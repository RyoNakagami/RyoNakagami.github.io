---
layout: post
title: "Ubuntu Desktop環境構築 Part 11"
subtitle: "Markdown目次作成ツール doctocのインストール"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Markdown
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>


||概要|
|---|---|
|目的|Markdown目次作成ツール doctocのインストール|
|参考|- [doctoc GitHubレポジトリー](https://github.com/thlorenz/doctoc)<br> -[npm公式ページ](https://docs.npmjs.com/about-npm)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [方針](#%E6%96%B9%E9%87%9D)
- [2.`doctoc`のインストール](#2doctoc%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [3. `doctoc`の使用例の紹介](#3-doctoc%E3%81%AE%E4%BD%BF%E7%94%A8%E4%BE%8B%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [オプション](#%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
  - [使用例: git addとの組わせ](#%E4%BD%BF%E7%94%A8%E4%BE%8B-git-add%E3%81%A8%E3%81%AE%E7%B5%84%E3%82%8F%E3%81%9B)
- [4. sort-markdown-tablesの’インストール](#4-sort-markdown-tables%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [何ができるようになるか？](#%E4%BD%95%E3%81%8C%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%AA%E3%82%8B%E3%81%8B)
  - [インストール](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [使い方](#%E4%BD%BF%E3%81%84%E6%96%B9)

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





## 4. sort-markdown-tablesの’インストール
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





