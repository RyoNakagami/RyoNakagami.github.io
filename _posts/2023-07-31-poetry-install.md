---
layout: post
title: "pyproject.tomlからPoetry installする仕組み"
subtitle: "Ubuntu Python 分析環境の構築 3/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: true
last_modified_at: 2024-04-18
header-mask: 0.0
header-style: text
tags:

- Poetry
- Python
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Poetry install](#poetry-install)
  - [Project repositoryのインストール](#project-repository%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [groupからパッケージをインストールする場合](#group%E3%81%8B%E3%82%89%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
- [プロジェクト配下に存在する特定のディレクトリをpoetry addする場合](#%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E9%85%8D%E4%B8%8B%E3%81%AB%E5%AD%98%E5%9C%A8%E3%81%99%E3%82%8B%E7%89%B9%E5%AE%9A%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%92poetry-add%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
- [GitHub private repositoryをpoetry addする場合](#github-private-repository%E3%82%92poetry-add%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
  - [Repository先で更新が走った場合](#repository%E5%85%88%E3%81%A7%E6%9B%B4%E6%96%B0%E3%81%8C%E8%B5%B0%E3%81%A3%E3%81%9F%E5%A0%B4%E5%90%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Poetry install

- `poetry install`コマンドは, 現在のプロジェクトの`pyproject.toml`から依存関係を解決しながらpackageを仮想環境へセットアップするコマンドです. 
- `poetry.lock`が存在する場合は, そこに記載されたversionを読み込む形で仮想環境セットアップが行われます.


### Project repositoryのインストール

`pyproject.toml`が現在のプロジェクトで以下のように設定されているとします.

```
[tool.poetry]
name = "poetry-demo"
version = "0.1.0"
description = ""
authors = ["Sébastien Eustace <sebastien@eustace.io>"]
readme = "README.md"
packages = [{include = "poetry_demo"}]

[tool.poetry.dependencies]
python = "^3.7"


[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

Poetryは, プロジェクトのルートに `tool.poetry.name`と同じ名前のパッケージ(上の例では`poetry-demo`ディレクトリ)を含むと想定しています. そのため, `poetry install`を実行するとき, `poetry-demo`ディレクトリの中身はパッケージとして仮想環境にインストールされます.

一方, `poetry-demo`ディレクトリが存在しない場合は, `poetry install --no-root`でインストールするべきとの警告が出現します.


### groupからパッケージをインストールする場合

- 特定のグループを除外して読み込む場合
- 特定のグループを明示的に指定してmainグループと一緒に読み込む場合
- 特定のグループのみを読み込む場合

それぞれのパターンがあります

```zsh
# 特定のグループを除外して読み込む場合
poetry install --without test,docs --sync

# 特特定のグループを明示的に指定してmainグループと一緒に読み込む場合
poetry install --with test,docs --sync

# 特定のグループのみを読み込む場合
poetry install --only test,docs --sync
```

`--sync` optionは選択したグループと`poetry.lock`の記載内容の整合性を整えるために使用されるオプションです.

## プロジェクト配下に存在する特定のディレクトリをpoetry addする場合

`tool.poetry.name`に記載されていない名前で, project root直下に存在するディレクトリについてインストール死体場面を考えます. 下の例では, `utilities_dir`以下に存在する`repository_utilities`パッケージをインストールしたいとします.

```zsh
.
├── docs
├── utilities_dir
│     └── repository_utilities
├── license
├── poetry.lock
├── pyproject.toml
├── README.md
└── poetry-demo
```

`pyproject.toml`に以下のように記述することで, `poetry install`や`poetry update`実施後, 
`repository_utilities`を普通のモジュールと同じように`import`で呼ぶことができるようになります.

```
packages = [
    { include = "repository_utilities", from = "utilities_dir" }
]
```

## GitHub private repositoryをpoetry addする場合

`poetry add`の方法として以下の２つが考えられます

- `https`経由で`poetry add`
- `ssh`経由で`poetry add`

また, 上記それぞれに対して特定のbranchを対象にしたい場合というケースの計４パターンが考えられます.

User `kirby`の `test_repository` レポジトリを加える場合を例にコマンド例を以下紹介します

```zsh
# (1-a) https経由でmainをadd
% poetry add git+https://github.com/kirby/test_repository.git

# (1-b) https経由でdevelop branchをadd
% poetry add git+https://github.com/kirby/test_repository.git#develop

# (2-a) ssh経由でmainをadd
% poetry add git+ssh://git@github.com/kirby/test_repository.git

# (2-b) ssh経由でdevelop branchをadd
% poetry add git+ssh://git@github.com/kirby/test_repository.git#develop
```

上記のコマンドを実行すると，`pyproject.toml`に

```toml
[tool.poetry.dependencies]
python = ">=3.11,<4.0"
test_repository = {git = "https://github.com/kirby/test_repository.git"}
```

という形でパッケージ情報が記載されます. または `poetry show` でdependencyを含め確認することもできます.

### Repository先で更新が走った場合

レポジトリ先で更新が入った場合は, `poetry update`で変更内容を
反映させることができます.

```zsh
% poetry update
Updating dependencies
Resolving dependencies... (1.8s)

Package operations: 0 installs, 1 update, 0 removals

  - Updating test_repository (0.1.0 1cbd71e -> 0.1.0 083db26)

Writing lock file
```

References
----------
- [Ryo's Tech Blog > Poetry configuration Tips](https://ryonakagami.github.io/2023/07/30/poetry-configuration/)
