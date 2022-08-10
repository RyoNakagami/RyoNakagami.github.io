---
layout: post
title: "ブログ編集手引きノート"
subtitle: "Git branchを用いたブログ更新テストのメモ"
author: "Ryo"
header-img: "img/post-git-github-logo.jpg"
header-mask: 0.4
purpose: 目的 git branchを活用したRyo's Tech blogの更新手順のメモ
goal: 成果物 git branchを用いたファイルバージョン管理やブログレイアウト管理を実現
catelog: true
reading_time: 10
tags:
  - git
  - GitHub Pages
---



|概要||
|---|---|
|目的|`git branch`を活用した[Ryo's Tech blog](https://ryonakagami.github.io)の更新手順のメモ|
|Goal|`git branch`を用いたファイルバージョン管理やブログレイアウト管理ができるようになる|


<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. ブログ更新環境](#1-%E3%83%96%E3%83%AD%E3%82%B0%E6%9B%B4%E6%96%B0%E7%92%B0%E5%A2%83)
  - [技術スタック](#%E6%8A%80%E8%A1%93%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF)
  - [作業ディレクトリ構成](#%E4%BD%9C%E6%A5%AD%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E6%A7%8B%E6%88%90)
  - [ブランチの構成](#%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AE%E6%A7%8B%E6%88%90)
- [2. Git branchを用いたブログ編集](#2-git-branch%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%96%E3%83%AD%E3%82%B0%E7%B7%A8%E9%9B%86)
  - [そもそもbranchとは](#%E3%81%9D%E3%82%82%E3%81%9D%E3%82%82branch%E3%81%A8%E3%81%AF)
  - [git branch: ブランチの一覧を表示](#git-branch-%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AE%E4%B8%80%E8%A6%A7%E3%82%92%E8%A1%A8%E7%A4%BA)
  - [git checkout -b: test ブランチを作成し、切り替える](#git-checkout--b-test-%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%82%8B)
  - [ブログ postの編集](#%E3%83%96%E3%83%AD%E3%82%B0-post%E3%81%AE%E7%B7%A8%E9%9B%86)
  - [ローカルテスト](#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%83%86%E3%82%B9%E3%83%88)
  - [git merge: ブランチのマージ](#git-merge-%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AE%E3%83%9E%E3%83%BC%E3%82%B8)
  - [ブランチマージを視覚的に確認する](#%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%83%9E%E3%83%BC%E3%82%B8%E3%82%92%E8%A6%96%E8%A6%9A%E7%9A%84%E3%81%AB%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B)
  - [branchの消去](#branch%E3%81%AE%E6%B6%88%E5%8E%BB)
  - [本番環境GitHub Pagesの更新](#%E6%9C%AC%E7%95%AA%E7%92%B0%E5%A2%83github-pages%E3%81%AE%E6%9B%B4%E6%96%B0)
- [3. Google Analyticsの設定](#3-google-analytics%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [Google Analyticsの利用登録](#google-analytics%E3%81%AE%E5%88%A9%E7%94%A8%E7%99%BB%E9%8C%B2)
  - [記事ページへの埋め込み](#%E8%A8%98%E4%BA%8B%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%B8%E3%81%AE%E5%9F%8B%E3%82%81%E8%BE%BC%E3%81%BF)
- [4. 自作スニペット for Markdown Writing](#4-%E8%87%AA%E4%BD%9C%E3%82%B9%E3%83%8B%E3%83%9A%E3%83%83%E3%83%88-for-markdown-writing)
- [Ryo's Tech Blog 関連記事](#ryos-tech-blog-%E9%96%A2%E9%80%A3%E8%A8%98%E4%BA%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. ブログ更新環境
### 技術スタック

|項目||
|---|---|
|ウェブホスティングサービス|GitHub Pages|
|静的サイトジェネレーター|jekyll|
|editor|Visual Studio Code|
|Analytics|Google Analytics 4|



### 作業ディレクトリ構成

```
current working directory
├── _post #ブログのpost格納フォルダ
├── ...
└── _img  #ブログで用いる画像ファイル格納フォルダ
```

### ブランチの構成
ブログ用レポジトリのネットワークは以下：

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/ブログ用/2020-10-13-ブログ更新手引きノート/post-branch-str.jpg?raw=true">

|branch|説明|
|---|---|
|master|本番環境。公開されているブログのソースコードを格納しているブランチ|
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

`master`ブランチの状態は

```
$ git checkout master
$ ls ./_posts/
2020-10-08-How-Programm-Works.md  2020-10-13-Blog-development.md
```

となっています。

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
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```

`test` ブランチをマージします。ブランチからマージしたことを明確に歴史に残すためにマージコミットをoption `--no-ff`を用いて実行します。

```
$ git merge --no-ff test
```

するとviエディターが立ち上がって、マージコミットメッセージが求められるので、記入（記入せずとも良い）した後に保存して、終了します。

```
Merge made by the 'recursive' strategy.
 _posts/2020-10-13-Blog-development.md | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 img/post-git-github-logo.jpg          | Bin 0 -> 44464 bytes
 2 files changed, 176 insertions(+)
 create mode 100644 _posts/2020-10-13-Blog-development.md
 create mode 100644 img/post-git-github-logo.jpg
```

ファイルが書き換わっているか確認すると
```
$ ls ./_posts/
2020-10-08-How-Programm-Works.md  2020-10-13-Blog-development.md
```

となっており更新されてことが確認できます。


### ブランチマージを視覚的に確認する

ブランチのマージを視覚的に確認したい場合は`git log --graph`を用います。

```
$ git log --graph
*   commit ddf29585a8705b905ae25f3820b168b3d5d2410c (HEAD -> master)
|\  Merge: 7faae6b 64fee80
| | Author: ryonak <nakagamiryo0901@gmail.com>
| | Date:   Tue Oct 13 21:02:47 2020 +0900
| | 
| |     Merge branch 'test'
| | 
| * commit 64fee80503cfbc0bcc70d7c596bb08d58ff6ec60 (test)
| | Author: ryonak <nakagamiryo0901@gmail.com>
| | Date:   Tue Oct 13 21:02:19 2020 +0900
| | 
| |     dev 2020-10-13 post initial commit
| | 
:
```
このようにgit log --graphはコミットログをグラフでわかりやすく表示してくれます。エスケープするときは`q`を押せば良い。

Visual Studio Codeを使っている場合はGit Graphという拡張機能を用いるともっと簡単に見ることができる。

### branchの消去

マージ済みのブランチやバグだらけでどうでも良くなったブランチを消去したい場合は`git branch -d`または`git branch -D`コマンドを使えば良い。ここではマージされて不必要になった`test` branchを消去します。

```
$ git branch -d test
Deleted branch test (was 64fee80).
```

マージされていないブランチ(どうでも良くなった)を削除したいときは`git branch -D`コマンドを使います。

```
$ git branch -D <branch name>
```

その後編集記録を消したい場合は、`git checkout .`で編集記録が消えます。ファイルを消したい場合は`rm`コマンドを使って消していきましょう。

### 本番環境GitHub Pagesの更新

remote repositoryにpushして終了。コマンドは以下、

```
$ git push --set-upstream origin master
```

## 3. Google Analyticsの設定

方針は

1. GA Propetyの作成
2. Measurement IDを各ページに逐次埋め込む

### Google Analyticsの利用登録

利用登録手順は以下です：

1. [Google Analytics](https://analytics.google.com/analytics/web/)にアクセスします。
2. Account設定をします（基本的には自分のGoogle Accountを入力）
3. Adminをクリックします。
4. Create Propertyという項目があるのでクリックします
5. Property setupをします
6. 最後に[利用規約](https://docs.google.com/document/d/1ArTraHJGbPKdO3gXDpKh4F1vLDPS19nR2U9EVvRJXuI/edit?usp=sharing)に同意したらGoogle Analyticsのダッシュボードが開く

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2020-10-13-GA-settings.png?raw=true">

**GAは無料で使えるのか？**

プロパティのサービス料金は、1 つのプロパティに紐づけられているすべての（該当する）プロファイルのヒット数を集計して算出されます。「ヒット」とは、最終的にデータとして本サービスに送信されて処理される、操作の集合を指します。例えば、ページビューや e コマースのヒットなどがあります。他にも、さまざまなライブラリによる本サービスの呼び出しがヒットにあたる場合がありますが、このような場合に限定されるわけではありません。GAは 1 アカウントにつき 1 か月あたり 1,000 万ヒットを上限としてお客様に無料で提供されます。

### 記事ページへの埋め込み

測定対象を指定します：

1. Adminをクリック
2. `Data Streams`をクリック
3. `Add stream`をクリック
4. 測定対象URLを指定する
5. Global site tag (gtag.js)が発行されます
6. gtag.jsタグをHTMLの<head>セクションにコピーします。また、ウェブサイトビルダー（WordPress、Shopifyなど）をお使いの場合は、グローバルサイトタグをウェブサイトビルダーのカスタムHTMLフィールドにコピーしてください。

**例**

```
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-12345"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-12345');
</script>
```

## 4. 自作スニペット for Markdown Writing

> 工程

1. `Ctrl` + `P` Then `>`から `Preferences: Configure User Snippets`を選択する
2. `markdown.json`をクリック（存在しない場合はmarkdownをクリック）
3. 自作スニペットを定義して保存する

> 自作スニペット例

```json
{
	/// General
	"Table of Contents": {
		"prefix": "doctoc",
		"body":[
		  "**Table of Contents**"
		  "<!-- START doctoc -->"
		  "<!-- END doctoc -->"
		],
		"description": "markdownにて、doctocに従ったTable of Contentsを表示させる箇所に入力する"
	  },
	
	/// LaTex related setting
	"begin align*": {
		"prefix": "begin",
		"body":[
			"\\begin{align*}",
			"\\end{align*}"
		],
		"description": "markdown 数式モードでbegin{align*}end{align*}を入力"

	},
	"overflow setting for Latex code": {
		"prefix": "tex",
		"body":[
			"<div class=\"math display\" style=\"overflow: auto\">",
			"$$",
			"$$",
			"</div>"
		],
		"description": "markdown 数式モードでoverflowエリアをスクロールで表示させるコマンドを入力する。"
	},
	"quod erat demonstrandum": {
		"prefix": "qed",
		"body":[
		  "<div style=\"text-align: right;\">",
		  "■",
		  "</div>"
		],
		"description": "markdown 数式モードにて、証明/解答が終了したことを示すマークを加える。証明/解答が完了した次の行で入力する。"
	  }
}
```

## Ryo's Tech Blog 関連記事

- [ブログ編集手引きノート: GA4編](https://ryonakagami.github.io/2021/04/18/google-analytics-source-setting/)
- [静的サイトジェネレーター Jekyllのインストール: GitHub Pages作成環境の構築](https://ryonakagami.github.io/2020/12/27/ubuntu-jekyll-install/)

## References

- [サル先生のGit入門](https://backlog.com/ja/git-tutorial/stepup/01/)
