---
layout: post
title: "GitHub Repositoryの任意のサブディレクトリのみをローカル側で取得する"
subtitle: "How to use git command 11/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-01-24
header-mask: 0.0
header-style: text
tags:

- git

---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Overview](#overview)
- [サブディレクトレリ取得までの手順](#%E3%82%B5%E3%83%96%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AC%E3%83%AA%E5%8F%96%E5%BE%97%E3%81%BE%E3%81%A7%E3%81%AE%E6%89%8B%E9%A0%86)
  - [Sparse checkout設定とは？](#sparse-checkout%E8%A8%AD%E5%AE%9A%E3%81%A8%E3%81%AF)
  - [sparse-checkoutの無効化と解除](#sparse-checkout%E3%81%AE%E7%84%A1%E5%8A%B9%E5%8C%96%E3%81%A8%E8%A7%A3%E9%99%A4)
- [Remote repositoryの特定のファイルのみをダウンロードしたい場合](#remote-repository%E3%81%AE%E7%89%B9%E5%AE%9A%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%81%BF%E3%82%92%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [盗み見されてしまう場合](#%E7%9B%97%E3%81%BF%E8%A6%8B%E3%81%95%E3%82%8C%E3%81%A6%E3%81%97%E3%81%BE%E3%81%86%E5%A0%B4%E5%90%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Overview

> What I Want

- GitHub Repositoryの任意のサブディレクトリのみをローカル側で取得する

> Git version

```zsh
% git --version
git version 2.31.1
```

## サブディレクトレリ取得までの手順

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >手順</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">


<div style="display: inline-block; background: #FFFFFF;; border: 1px solid #FFFFFF; padding: 3px 10px;color:black"><span >1: ローカル側で空ディレクトリを作る</span>
</div>

```zsh
% mkdir <directory name>
% cd ./<directory name>
% git init
```

<div style="display: inline-block; background: #FFFFFF;; border: 1px solid #FFFFFF; padding: 3px 10px;color:black"><span >2: sparsecheckout の設定</span>
</div>

```zsh
% git config core.sparsecheckout true
```

<div style="display: inline-block; background: #FFFFFF;; border: 1px solid #FFFFFF; padding: 3px 10px;color:black"><span >3: 取得元のリポジトリを設定</span>
</div>

```zsh
% git remote add origin https://github.com/<username>/<repository name>.git
```
<div style="display: inline-block; background: #FFFFFF;; border: 1px solid #FFFFFF; padding: 3px 10px;color:black"><span >4: 取得したいディレクトリをsparse-checkoutに設定</span>
</div>

```zsh
% echo <subdirectory name> > .git/info/sparse-checkout
```

仮に特定のファイルのみ取得したい場合は、上書きリダイレクション `>` を用いて

```zsh
% echo <path/to/file name> > .git/info/sparse-checkout
```

更に別ファイルを追加したい場合は, 追記リダイレクション `>>` を用いて

```zsh
% echo add-sub-directory >> .git/info/sparse-checkout
# ツリー情報を更新する
% git read-tree -m -u HEAD
```

<div style="display: inline-block; background: #FFFFFF;; border: 1px solid #FFFFFF; padding: 3px 10px;color:black"><span >5: pullする</span>
</div>

```zsh
% git pull origin main
```

</div>

なおここでの手順では紹介しないが, `main` branchはcloneしてもよいが特定のbranchのファイルを
ローカルへ落とす際にsparse-checkoutを設定するという方法も考えられます. 

```zsh
% git clone --filter=blob:none https://github.com/hoge/fuge.git
```

というように`--filter=blob:none`を設定するとブロブレスクローンが実行できます.
blobとはここではgit objectのうちのファイルとみなしてもらって大丈夫です.


### Sparse checkout設定とは？

`Sparse checkout` では, 作業ディレクトリをコンパクトにすることができます. skip-worktree bit を使って, 作業ディレクトリにあるファイルを見る価値があるかどうかを Git に伝えます. skip-worktree bitが設定されている場合, そのファイルは作業ディレクトリでは無視されます. Git はこれらのファイルの内容を入力しません. そのため, 多くのファイルがあるリポジトリで作業をしていて, 現在のユーザーにとって重要なファイルがほんの少ししかない場合などにSparse checkoutが役立ちます. 

`Sparse checkout`の設定は, `.git/info/sparse-checkout`に格納されています. Gitは作業ディレクトリを更新するときに, このファイルに基づいてインデックスのskip-worktree bitを更新します. このファイルのパターンにマッチするファイルが作業ディレクトリに現れ, それ以外のファイルは現れません.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >sparse-checkoutの確認</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">


sparse-checkoutの確認したい場合, 

```zsh
% git sparse-checkout list

## 設定されていない場合
% git sparse-checkout list
warning: this worktree is not sparse (sparse-checkout file may not exist)
```

変更したい場合は, **元々の設定が消えて指定したPathのみが設定されます**が

```zsh
% git sparse-checkout set <path>
```

または, Pathを直接上書きする形でも可能です.


```zsh
% echo <path/to/file name> > .git/info/sparse-checkout
```

</div>


### sparse-checkoutの無効化と解除

sparse-checkoutの機能をdisableする場合, 無効化(disable)と設定解除する２つの方法があります.
基本的には`disable`の場合だけで十分です.


<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >無効化(disable)</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

これは設定ファイルは残るが, 機能は無効化されるコマンドです

```zsh
% git sparse-checkout disable
```

このコマンド実行後, working directoryは`.gitignore`で指定されたオブジェクト以外のすべてのオブジェクトをrestoreします.

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >設定解除</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

手順としては

1. `.git/info/sparse-checkout` に全体を対象とするよう `/*` を指定する
2. `git read-tree` でツリー情報を読み込み直す
3. `.git/info/sparse-checkout` を削除
4. `sparsecheckout` を無効にする

```zsh
% echo "/*" > .git/info/sparse-checkout
% git read-tree -mu HEAD
% rm .git/info/sparse-checkout
% git config core.sparsecheckout false
```

</div>

## Remote repositoryの特定のファイルのみをダウンロードしたい場合

private repositoryの特定のブランチの特定のファイルのみをローカルへダウンロードしたい場合を考えます.
このとき, `curl`とPATを上手く組み合わせることで実現することが出来ます.

前準備として, 

- private repositoryやprojectへのアクセス権限が与えられたPATを取得
- 上記のPATを`$TOKEN`に格納する

その後, 

```zsh
## -s optionはsilentの意味
% curl -s https://$TOKEN@raw.githubusercontent.com/<user or org>/<repositoryname>/<branch>/<path>
```

とすると, private repositoryの任意のファイルをローカルへダウンロードすることが出来ます.

`git-curl`という名前で以下のようにシェルスクリプト化し,

```zsh
#!/bin/bash
## get a single file from a github repository
## Author: Ryo Nakagami
## Revised: 2024-01-23

set -e

## variables
URL=$1
TOKEN=hogehogehoge ##BE CAREFUL THIS IS SENSITIVE INFO
HEADER=https://
DOTCOM=@raw.githubusercontent.com/

## substition
UPDATEED_URL=${URL/https:\/\/github.com\//}

## main
curl -s $HEADER$TOKEN$DOTCOM$UPDATEED_URL
```

その後, 実行権限とPATHを通して

```zsh
% git-curl https://github.com/user-name/repository-name/branch-name/path/test.txt
```

と実行するとローカルにダウンロードすることが出来ます. ただし, **PATを平文で保存するのは良くない** 
and **同じサーバー内の第三者がpsを叩くとPATが見れてしまう**ので, あまり推奨はできません.

### 盗み見されてしまう場合

２つのターミナルを立ち上げ, 

- `curl`実行役ターミナル
- 盗聴用ターミナル

のふたつを用意します. 

まず実行側でシェルスクリプト化したコマンドを実行してみます

```zsh
% git-curl https://github.com/RyoNakagami/RyoNakagami.github.io/main/_includes/plotly/20210122_simulation.html
```

同時に, うまいタイミングで盗聴側で以下のコマンドを実行します

```zsh
% while true; do ps aww | fgrep curl && break; done
  86766 pts/0    S+     0:00 /bin/bash /home/ryo_billiken/bin/git-curl https://github.com/RyoNakagami/RyoNakagami.github.io/main/_includes/plotly/20210122_simulation.html
  86767 pts/0    R+     0:00 curl -s https://hokkaidowadekkaido@raw.githubusercontent.com/RyoNakagami/RyoNakagami.github.io/main/_includes/plotly/20210122_simulation.html
  86770 pts/3    S+     0:00 grep -F curl
```

すると上記のようにPAT(`hokkaidowadekkaido`)が見れてしまいます. 
PAT自体を暗号化して参照するようにはできますが, 最終的に`curl`でPATが平文で見えてしまうのでやはり推奨できない方法と言うことが出来ます.


References
----------
- [Git Documentation > git-sparse-checkout](https://git-scm.com/docs/git-sparse-checkout/en)