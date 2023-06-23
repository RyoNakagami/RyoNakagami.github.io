---
layout: post
title: "Markdown目次作成ツール doctocのインストール"
subtitle: "Ubuntu Desktop環境構築 Part 11"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-08-10
tags:

- Ubuntu 20.04 LTS
- GitHub Pages
- Shell
---


---|---
目的|Markdown目次作成ツール doctocのインストール


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [方針](#%E6%96%B9%E9%87%9D)
- [2.`doctoc`のインストール](#2doctoc%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [3. `doctoc`の使用例の紹介](#3-doctoc%E3%81%AE%E4%BD%BF%E7%94%A8%E4%BE%8B%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [オプション](#%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
  - [使用例: git addとの組わせ](#%E4%BD%BF%E7%94%A8%E4%BE%8B-git-add%E3%81%A8%E3%81%AE%E7%B5%84%E3%82%8F%E3%81%9B)
  - [複数のmarkdown fileを対象にdoctoc update](#%E8%A4%87%E6%95%B0%E3%81%AEmarkdown-file%E3%82%92%E5%AF%BE%E8%B1%A1%E3%81%ABdoctoc-update)
- [4. sort-markdown-tablesのインストール](#4-sort-markdown-tables%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [何ができるようになるか？](#%E4%BD%95%E3%81%8C%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%AA%E3%82%8B%E3%81%8B)
  - [インストール](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [使い方](#%E4%BD%BF%E3%81%84%E6%96%B9)
- [Appendix](#appendix)
  - [`find`コマンド](#find%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

- Markdown目次作成ツール `doctoc`のインストール
- Markdown table sort用の `sort-markdown-tables`のインストール

### 方針

1. `npm`のインストール
2. `doctoc`をインストール
3. `doctoc`の使用例の紹介

## 2.`doctoc`のインストール

doctocはnpmパッケージなのでまず`npm`と`nodejs`をインストールします。

```zsh
% sudo apt install -y nodejs npm
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
% npm install -g doctoc
```

## 3. `doctoc`の使用例の紹介

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
% doctoc test.md --github
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


### オプション

目次の作成形式について、以下のサイトと整合的なフォームを選択することができます。

```
--bitbucket bitbucket.org
--nodejs    nodejs.org
--github    github.com
--gitlab    gitlab.com
--ghost     ghost.org
```

### 使用例: git addとの組わせ

```zsh
% doctoc --github README.md 
% git add !$
```

- `!$`は直前に実行したコマンドの最後の引数を引用するコマンド


### 複数のmarkdown fileを対象にdoctoc update

複数のファイルを対象にdoctoc updateを実施したい場合, 現状では逐次コマンドを入力する必要があり, 複数のドキュメントを同時編集している際にはやや億劫な作業となります.

そこで, ここではカレントディレクトリ下に存在するmarkdown fileに対してのみ一括でdoctoc updateを実行するエイリアスを紹介します.


> 完成物

```zsh
doctoc_all='echo $(find . -maxdepth 1 -name "*.md" -type f|xargs doctoc --github|grep -Eo "\./\S{1,}\.md"| sort --unique|wc -l) files are updated'
```

> 機能

- カレントディレクトリに存在するmarkdown fileのみ取得する = サブディレクトリ以下は検索しない
- 取得したmarkdown fileに対して`doctoc --github`コマンドを一括で実行したい
- `doctoc --github`コマンド対象ファイル数を表示したい

## 4. sort-markdown-tablesのインストール
### 何ができるようになるか？

- Markdown tableを最初のカラムに基づいてsortすることができるようになる
- [公式レポジトリ](https://github.com/fmma/sort-markdown-tables#readme)

### インストール

```zsh
% sudo npm install -g @fmma-npm/sort-markdown-tables
```

### 使い方

1. sortの対象としたいテーブルの直前に`<!-- sort-table -->`タグをつける
2. `sort-markdown-tables -i Readme.md`とコンソールで実行する

## Appendix
### `find`コマンド

`find`コマンドは, ファイルを検索するためのコマンドです.
ファイル名だけでなく, アクセス権, ファイルサイズ, 更新日時といった条件でファイルを検索することも可能です.

> Syntax

```zsh
find [検索開始ディレクトリ] [検索式]
```

> Options

今回使用したoptionのみを紹介します.

---|---
`-maxdepth` LEVEL|指定したディレクトリから最大LEVEL階層下のディレクトリまで検索
`-name`|検索対象ファイル名の指定（ワイルドカード使用可能）
`-type`|検索対象ファイルタイプの指定(f: ファイル, d: ディレクトリ, l:シンボリック)




## References

- [doctoc GitHubレポジトリー](https://github.com/thlorenz/doctoc)
- [npm公式ページ](https://docs.npmjs.com/about-npm)