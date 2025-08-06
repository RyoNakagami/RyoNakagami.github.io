---
layout: post
title: "Markdown目次作成ツール doctocのインストール"
subtitle: "GitHub Pages作成環境の構築 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
reading_time: 10
last_modified_at: 2023-11-15
tags:

- GitHub Pages
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What Do I Want to DO?](#what-do-i-want-to-do)
- [`npm` & `doctoc`のインストール](#npm--doctoc%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [`doctoc`の使用例の紹介](#doctoc%E3%81%AE%E4%BD%BF%E7%94%A8%E4%BE%8B%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [Options](#options)
  - [Usage Example](#usage-example)
- [sort-markdown-tablesのインストール](#sort-markdown-tables%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [インストール](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [Usage](#usage)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What Do I Want to DO?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>やりたいこと</ins></p>

- Markdown目次作成ツール `doctoc`のインストール
- Markdown table sort用の `sort-markdown-tables`のインストール

</div>

上記を達成するために今回行ったことは以下です:

1. `npm`, `nodejs` のインストール
2. `doctoc`をインストール
3. `sort-markdown-tables`のインストール

## `npm` & `doctoc`のインストール

doctocはnpmパッケージなのでまず`npm`と`nodejs`をインストールします。

```zsh
### ubuntu
% sudo apt install -y nodejs npm

### windows
~> sudo choco install -y --force nodejs-lts
```

インストールしたバージョンを確認すると

```zsh
% node -v
v10.19.0
% npm -v
6.14.4
```

つぎに、doctocをインスールします。

```zsh
% npm install -g doctocdoctoc\: false
```

### `doctoc`の使用例の紹介

以下のような形式のMarkdown file, `test.md` を用意します

```md
# Title
<!-- START doctoc -->
<!-- END doctoc -->

## Section 1
### Section 1-2
## Section 2
## Section 3
```

このファイルに対して以下のコマンドを実行します。

```zsh
% doctoc test.md
```

すると

```md
# Title
<!-- START doctoc generated TOC please keep comment here to allow auto update ->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Section 1](#section-1)
  - [Section 1-2](#section-1-2)
- [Section 2](#section-2)
- [Section 3](#section-3)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Section 1
### Section 1-2
## Section 2
## Section 3
```

以上のように`<!--START doctoc --><!--END doctoc -->`の間で囲まれたエリアにIndexを自動的に作ってくれます。


### Options

目次の作成形式について、以下のサイトと整合的なフォームを選択することができます:

```zsh
% doctoc -h
Usage: doctoc [mode] [--entryprefix prefix] [--notitle | --title title] [--maxlevel level] [--all] [--update-only] <path> (where path is some path to a directory (e.g., .) or a file (e.g., README.md))

Available modes are:
  --bitbucket   bitbucket.org
  --nodejs      nodejs.org
  --github      github.com
  --gitlab      gitlab.com
  --ghost       ghost.org
Defaults to 'github.com'.
```

`doctoc`のdefaultは`--github`なので, GitHub Pages用に目次を作成したい場合はoptionを指定する必要はありません.


### Usage Example

> combination with git add command

```zsh
% doctoc --github README.md 
% git add !$
```

- `!$`は直前に実行したコマンドの最後の引数を引用するコマンド

> doctoc all markdown files under the current directory

```bash
#!/bin/bash
## doctoc all markdown files under the current directory
## Author: Ryo Nakagami
## Revised: 2023-06-13
## REQUIREMENT: doctoc

set -e


# Variable Assignment
if [[ -z $1  ]]; then
    DOCTOC_OPTION='--github'
else
    DOCTOC_OPTION=$1
fi


# Main
echo $(grep -lL "doctoc\: false$" ./*.md\
|xargs doctoc $DOCTOC_OPTION|grep -Eo "\./\S{1,}\.md"\
| sort --unique|wc -l) files are updated
```

## sort-markdown-tablesのインストール

Markdown tableを最初のカラムに基づいてsortすることができるようになります

### インストール

```zsh
% sudo npm install -g @fmma-npm/sort-markdown-tables
```

### Usage

1. sortの対象としたいテーブルの直前に`<!-- sort-table -->`タグをつける
2. `sort-markdown-tables -i Readme.md`とコンソールで実行する


References
-----------

- [GitHub.com > thlorenz/doctoc](https://github.com/thlorenz/doctoc)
- [npm公式ページ](https://docs.npmjs.com/about-npm)
