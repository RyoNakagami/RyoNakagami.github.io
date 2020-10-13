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
### 技術スタック

|項目||
|---|---|
|ウェブホスティングサービス|GitHub Pages|
|静的サイトジェネレーター|jekyll|
|editor|Visual Studio Code|

### 作業ディレクトリ構成

```
current working directory
├── _post #ブログのpost格納フォルダ
├── ...
└── _img  #ブログで用いる画像ファイル格納フォルダ
```

### ブランチの構成
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
$ git checkout -b test
Switched to a new branch 'test'
$ git branch
  master
* test
```

この`test`がブログpost編集作業環境となります。

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
$ git add ./img/post-git-github-logo.jpg _posts/2020-10-13-Blog-development.md
$ git commit -m "dev 2020-10-13 post initial commit"
```

このときの`test`の`_post`ディレクトリの状態は

```
$ ls ./_posts/
2020-10-08-How-Programm-Works.md  2020-10-13-Blog-development.md
```

一方、`master`ブランチの状態は

```
$ git checkout master
$ ls ./_posts/
2020-10-08-How-Programm-Works.md
```

となっています。先ほど追加したpostが反映されていないことがわかります。

### ローカルテスト

ブログpostの編集が終わったらローカル環境でブログ表示状態確認テストを実施ます。まず`test` branchに戻ります。

```
$ git checkout test
```

そして、ローカルホストを立ち上げ、ブログpostの表示内容を確認します。

```
$ bundle exec jekyll serve
Configuration file: /hogehoge/_config.yml
            Source: /hogehoge
       Destination: /hogehoge/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
                    done in 0.583 seconds.
 Auto-regeneration: enabled for '/hogehoge'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop. 
```

とターミナルに表示されるので`http://127.0.0.1:4000/`にアクセスして、表示状態を確認します。特に問題がなかったらブランチのマージします。問題があった場合は修正をしますが、もうどうでも良くなった場合はブランチを消去します（後述）

### git merge: ブランチのマージ 

`test`ブランチでの作業が終了したら実装完了として、`master`ブランチにマージします。

まず、統合ブランチである`master`ブランチに移動します

```
$ git checkout master
Swited to branch 'master'
```

`test` ブランチをマージします。ブランチからマージしたことを明確に歴史に残すためにマージコミットをoption `--no--ff`を用いて実行します。

```
$ git merge --no-ff test
```





