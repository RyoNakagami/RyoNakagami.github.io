---
layout: post
title: "GitHub Repositoryの任意のサブディレクトリのみをローカル側で取得する"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
tags:
  - git
  - ブログ作業マニュアル
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

|概要||
|---|---|
|目的|GitHub Repositoryの任意のサブディレクトリのみをローカル側で取得する|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Git version](#git-version)
- [サブディレクトレリ取得までの手順](#%E3%82%B5%E3%83%96%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AC%E3%83%AA%E5%8F%96%E5%BE%97%E3%81%BE%E3%81%A7%E3%81%AE%E6%89%8B%E9%A0%86)
- [Sparse checkoutとは？](#sparse-checkout%E3%81%A8%E3%81%AF)
  - [sparse-checkoutの無効化と解除](#sparse-checkout%E3%81%AE%E7%84%A1%E5%8A%B9%E5%8C%96%E3%81%A8%E8%A7%A3%E9%99%A4)
- [Appendix](#appendix)
  - [リダイレクション](#%E3%83%AA%E3%83%80%E3%82%A4%E3%83%AC%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Git version

```zsh
% git --version
git version 2.31.1
```

## サブディレクトレリ取得までの手順

> 1: ローカル側で空ディレクトリを作る

```zsh
% mkdir <directory name>
% cd ./<directory name>
% git init
```

> 2: sparsecheckout の設定

```zsh
% git config core.sparsecheckout true
```

> 3: 取得元のリポジトリを設定

```zsh
% git remote add origin https://github.com/<username>/<repository name>.git
```
> 4: 取得したいディレクトリをsparse-checkoutに設定

```zsh
% echo <subdirectory name> > .git/info/sparse-checkout
```

仮に特定のファイルのみ取得したい場合は、

```zsh
% echo <path/to/file name> > .git/info/sparse-checkout
```

更に別ファイルを追加したい場合は

```zsh
% echo add-sub-directory >> .git/info/sparse-checkout
# ツリー情報を更新する
% git read-tree -m -u HEAD
```

> 5: pullする

```zsh
% git pull origin master
```

## Sparse checkoutとは？

`Sparse checkout` では、作業ディレクトリをコンパクトにすることができます. skip-worktree bit を使って、作業ディレクトリにあるファイルを見る価値があるかどうかを Git に伝えます。skip-worktree bitが設定されている場合、そのファイルは作業ディレクトリでは無視されます。Git はこれらのファイルの内容を入力しません。そのため、多くのファイルがあるリポジトリで作業をしていて、現在のユーザーにとって重要なファイルがほんの少ししかない場合などにSparse checkoutが役立ちます。

`Sparse checkout`の設定は、`.git/info/sparse-checkout`に格納されています. Gitは作業ディレクトリを更新するときに、このファイルに基づいてインデックスのskip-worktree bitを更新します。このファイルのパターンにマッチするファイルが作業ディレクトリに現れ、それ以外のファイルは現れません。

> sparse-checkoutの確認

```zsh
% git sparse-checkout list
```

> 変更

```
% git sparse-checkout set <path>
```

元々の設定が消えて、指定したPathのみが設定されます. または、Pathを直接上書きする形でも可能です.

```zsh
% echo <path/to/file name> > .git/info/sparse-checkout
```

### sparse-checkoutの無効化と解除

> 無効化

これは設定ファイルは残るが、機能は無効化されるコマンドです

```zsh
% git sparse-checkout disable
```

> 設定解除

```zsh
% echo "/*" > .git/info/sparse-checkout
% git read-tree -mu HEAD
% rm .git/info/sparse-checkout
% git config core.sparsecheckout false
```

1. `.git/info/sparse-checkout` に全体を対象とするよう `/*` を指定する
2. `git read-tree` でツリー情報を読み込み直す
3. `.git/info/sparse-checkout` を削除
4. `sparsecheckout` を無効にする


## Appendix
### リダイレクション

|項目 |説明|
|---|---|
|`>` |	ファイルへの上書き|
|`>>` |	ファイルへの追記|