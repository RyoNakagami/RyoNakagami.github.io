---
layout: post
title: "ブログ編集手引きノート"
subtitle: "Git branchを用いたブログ更新テストのメモ"
author: "Ryo"
header-img: "img/post-git-github-logo.jpg"
header-mask: 0.4
catelog: true
tags:
  - git
  - git branch
  - ブログ作業マニュアル
---

|概要||
|---|---|
|目的|`git branch`を活用した[Ryo's Tech blog](https://ryonakagami.github.io)の更新手順のメモ|
|Goal|`git branch`を用いたファイルバージョン管理やブログレイアウト管理ができるようになる|
|参考|[サル先生のGit入門](https://backlog.com/ja/git-tutorial/stepup/01/)|
|key word|ローカルテスト, git branch|

<!-- START doctoc -->
<!-- END doctoc -->

## 1. ブログ更新環境

ブログ用レポジトリのネットワークは以下：

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/ブログ用/2020-10-13-ブログ更新手引きノート/post-branch-str.jpg?raw=true">

|branch|説明|
|---|---|
|master||本番環境。公開されているブログのソースコードを格納しているブランチ|
|test|開発環境でブログの実装・動作確認を行うブランチ|

## 2. Git branchを用いたブログ編集
### そもそもbranchとは

ブランチは、別々の作業を並行して行うために利用するものです。実際に公開しているブログのソースコード環境と新しく更新するブログのpostの制作環境を別々にすることで、公開されているブログの状態を維持したままブログのpost編集に伴うファイル操作を行うことができます。

それぞれのブランチ（ここではtest）の作業が終了したら`master`ブランチにマージして、pushすることでブログを公開することができます。

### git branch: ブランチの一覧を表示

`git branch`というコマンドを用いるとブランチの一覧と現在のブランチを確認することができます

```
$ git branch
* master
```

このときはまだ`master` ブランチのみしか存在しません。`*`は現在のブランチを表しています。

### git checkout -b: test ブランチを作成し、切り替える

まずはローカルブランチを作ります。

```
$ git checkout -b test_branch
Switched to a new branch 'test_branch'
$ git branch
  master
* test_branch
```

この`test_branch`がブログpost編集作業環境となります。

### ブログ postの編集

このブログpostを作成する例を用いて、ウォークスルーしていきます。まずブログpostの編集ファイルを作ります：

```
$ code ./_posts/2020-10-13-Blog-development.md
```

そしてこのファイルで新しく公開するpostの内容を書き切ります。

その後、headerで用いる画像を追加します

```
$ mv ../post-git-github-logo.jpg ./img/
```

作業が終わったらgit add and commitします。

```
$ git add ./img/post-git-github-logo.jpg 
```

