---
layout: post
title: "Poetry configuration Tips"
subtitle: "Ubuntu Python 分析環境の構築 2/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: true
last_modified_at: 2024-04-15
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

- [Configuration設定の基本](#configuration%E8%A8%AD%E5%AE%9A%E3%81%AE%E5%9F%BA%E6%9C%AC)
  - [現在のPoetry Configuration一覧の確認と削除](#%E7%8F%BE%E5%9C%A8%E3%81%AEpoetry-configuration%E4%B8%80%E8%A6%A7%E3%81%AE%E7%A2%BA%E8%AA%8D%E3%81%A8%E5%89%8A%E9%99%A4)
- [Configurations](#configurations)
  - [installer.max-workers](#installermax-workers)
  - [virtualenvs.prefer-active-python](#virtualenvsprefer-active-python)
- [Poetry addが終わらないとき](#poetry-add%E3%81%8C%E7%B5%82%E3%82%8F%E3%82%89%E3%81%AA%E3%81%84%E3%81%A8%E3%81%8D)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Configuration設定の基本

Poetry設定を行う場合は２つの方法があります

- `config` commandでCLI経由で設定
- `config.toml`をエディターで設定

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >config.tomlの格納ディレクトリ</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- macOS: `~/Library/Application Support/pypoetry`
- Windows: `%APPDATA%\pypoetry`
- Linux: `~/.config/pypoetry`

</div>

### 現在のPoetry Configuration一覧の確認と削除

```zsh
# 現在の設定リストの確認
% poetry config --list

# 特定の設定の削除: virtualenvs.path を削除する場合
% poetry config virtualenvs.path --unset
```

## Configurations
### installer.max-workers

- `installer.parallel = true`が設定されているときに, 用いるCPUの最大個数の設定項目
- Defaultでは, `number_of_cores + 4` で動作する
- `number_of_cores`は`os.cpu_count()`と同じ

```
% poetry config installer.max-workers 30
```

### virtualenvs.prefer-active-python

- Defaulrでは, `false`
- 現在アクティブ化されているPythonバージョンを使用して, 新しい仮想環境を作成するオプション。
- `false`に設定されている場合, Poetryインストール時に使用されたPythonバージョンが使用される

```zsh
% poetry config virtualenvs.prefer-active-python true
```

## Poetry addが終わらないとき

時折`ssh`先で `poetry add` を試みるとき, 処理が終わらないときがあります.
まず, `-vvv` optionを付与し, ログを確認しながら原因を確認してみます.

```zsh
% poetry add <package-name> -vvv
```

このとき, 以下の様なメッセージが確認できた場合, `keyring.backend`が何かしら悪さをしている可能性が高いです.

```zsh
[keyring.backend] Loading SecretService
[keyring.backend] Loading Windows
[keyring.backend] Loading chainer
[keyring.backend] Loading libsecret
[keyring.backend] Loading macOS
```

このkeyringは本来 packageをpublishする場合に読み込まれるものですが, `poetry add` などの non-publishing operationsのときも, poetryはkeyringへのアクセスを試みる場合があります. 

一時的な対処方法として, 

```zsh
% export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
```

と設定することで, 一時的に keyringを参照しなくなります.
この設定を解除したい場合は以下のコマンドを実行します.

```zsh
% unset PYTHON_KEYRING_BACKEND
```


References
----------
- [Poetry公式ドキュメント > Configuration](https://python-poetry.org/docs/configuration/)
- [Keyring errors during non-publishing operations #1917 ](https://github.com/python-poetry/poetry/issues/1917)
