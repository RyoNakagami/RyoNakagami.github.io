---
layout: post
title: "What is Git?"
subtitle: "GitとGitHubの設定 1/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2024-07-06
header-mask: 0.0
header-style: text
tags:

- git

---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is Git?](#what-is-git)
  - [Local VCS vs Distributed VCS](#local-vcs-vs-distributed-vcs)
  - [What is Git Repository?](#what-is-git-repository)
  - [GitによるVersion管理](#git%E3%81%AB%E3%82%88%E3%82%8Bversion%E7%AE%A1%E7%90%86)
    - [Snapshots vs Differences](#snapshots-vs-differences)
    - [commits are snapshots, not diffs](#commits-are-snapshots-not-diffs)
  - [Gitのバージョン管理の仕組み](#git%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%AE%A1%E7%90%86%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [Gitはどこにバージョン管理のDBをもっているのか？](#git%E3%81%AF%E3%81%A9%E3%81%93%E3%81%AB%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%AE%A1%E7%90%86%E3%81%AEdb%E3%82%92%E3%82%82%E3%81%A3%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
  - [Gitはどのように履歴データを取り出しているのか？](#git%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AB%E5%B1%A5%E6%AD%B4%E3%83%87%E3%83%BC%E3%82%BF%E3%82%92%E5%8F%96%E3%82%8A%E5%87%BA%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
- [How to Install Git](#how-to-install-git)
  - [Setup](#setup)
    - [`~/.gitconfig`の設定](#gitconfig%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [commit templateの作成](#commit-template%E3%81%AE%E4%BD%9C%E6%88%90)
- [GPGキーの登録](#gpg%E3%82%AD%E3%83%BC%E3%81%AE%E7%99%BB%E9%8C%B2)
  - [GPGキーの生成とGitHubへの登録](#gpg%E3%82%AD%E3%83%BC%E3%81%AE%E7%94%9F%E6%88%90%E3%81%A8github%E3%81%B8%E3%81%AE%E7%99%BB%E9%8C%B2)
  - [Git へ GPG キーを伝える](#git-%E3%81%B8-gpg-%E3%82%AD%E3%83%BC%E3%82%92%E4%BC%9D%E3%81%88%E3%82%8B)
  - [`.zshrc`への登録](#zshrc%E3%81%B8%E3%81%AE%E7%99%BB%E9%8C%B2)
  - [コミットに署名する](#%E3%82%B3%E3%83%9F%E3%83%83%E3%83%88%E3%81%AB%E7%BD%B2%E5%90%8D%E3%81%99%E3%82%8B)
- [Appendix: BFG Repo-Cleanerのインストール](#appendix-bfg-repo-cleaner%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [BFG Repo-Cleanerとは？](#bfg-repo-cleaner%E3%81%A8%E3%81%AF)
  - [BFGのインストール](#bfg%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## この記事のスコープ

- Gitを利用するための基礎知識及び各種設定の解説


## What is Git?

<strong > &#9654;&nbsp; Key Takeaways</strong>

- Gitとはファイルやソースコードの変更を分散型でトラッキングする仕組み
- ファイルやソースコードの変更をトラッキングする仕組みのことをバージョン管理システムと呼ぶ
- Linux創始者Linux Torvalds氏によって2005年ごろに原型となるプログラムが開発された

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Version Control System</ins></p>

変更履歴を管理することを通じて, 

- 誰がなんの変更を加えたかの表示
- 前回差分箇所をハイライト
- ファイルの特定の段階に戻る
- ファイルを復活

などを実現する仕組みがVersion Control System(VCS)です.

</div>

VCSを活用するメリットの具体例として, 

- あのとき動いたが,今は動かない... もう一回動いていた状態に戻したい
- このコードを加えた人とタイミングを知りたい
- 前回消してしまったコードを復活させたい
- 同じテーマで2つファイルが発生してしまったから差分を確認したい

つまるところ,「**VCSを活用することで, 一回とんでもない変更をしたとしても, すぐプロジェクト全体の状態を戻したり修正することができる**」ということです.

### Local VCS vs Distributed VCS

Version管理システムは分散型と集中型の２つに大別することができます. 

- 集中型: 変更履歴などのデータを一つの中央サーバーに集めて管理する種類のこと
- 分散型: 各クライアントがリポジトリをミラーし終わったあとは, 変更履歴の参照などのVersion管理アクションは各々のクライアント内部で閉じている種類のこと


分散型は,最新のソースコードの管理が難しいというデメリットがありますが(いわゆるコンフリクト), 
クライアントのローカル環境内部で変更履歴の確認等の作業が完結するので, 
集中型Version管理システムで直面するnetwork latency overhead問題を余り気にせずに開発作業をすることができます.

<table>
<td>Centralized Version Control</td><td>Distributed Version Control</td>
<tr>
<td><img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20210104_Git_Centralized_version_control.png?raw=true" width="100%" height="100%"></td> 
<td><img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20200104_Git_Distributed_version_control.png?raw=true" width="100%" height="100%"></td>
</tr>
</table>


集中型VCSでは, １つのrepository(=データを保存する場所)に対して多くの開発者とコンテンツを共有しているため, 
2人で同じファイルを同時に編集してしまうと, 先に編集した人の変更内容が消えてしまうリスクがありました.
一方, Gitではリモート側の内容をローカルへコピーした上で, 手元のVCS内部で編集作業を行い, remoteへ同期する際は, 
merge conflictという形でdiffが警告され強制的な上書きを防止くれるので, 分散型のメリットに基づく平行開発環境を提供してくれています.

また, merge conflictが発生してもそれを解消するコマンドを提供してくれているので, その便利さがGitが今日普及した理由と考えられます.


### What is Git Repository?

Repositoryとはデータを保存する場所のことです. 
Gitでは，このrepository単位でデータを管理しており，修正ログもrepository内に保存されています．
Gitは分散型Version管理システムであるため，repositoryは各開発者側にlocal環境へミラーリングして利用します． 

<strong > &#9654;&nbsp; Remote repository vs Local repository</strong>

- Remote repository: GitHub/GitLab上のリモートサーバーに置かれたrepositoryのこと 
- Local repository: 開発者がlocalにおくrepository

### GitによるVersion管理
#### Snapshots vs Differences

Version管理の方法として, Gitは差分(Differences)でなくSnapshotsでデータを管理しています.
Git は基本的に,すべてのファイルが各時点でどのように見えるかをSnapshotで記録し,そのSnapshotへの参照を保存します. 
効率化のため,ファイルが変更されていない場合は, Git はファイルを再び保存せず,すでに保存されている以前の同じファイルへのリンクだけを保存します.

Snapshots vs Differencesのイメージは以下のFiguresとなります.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20210104_GIt_snapshots.png?raw=true">

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20210104_git_snapshots_02.png?raw=true">


#### commits are snapshots, not diffs








### Gitのバージョン管理の仕組み










```mermaid
sequenceDiagram

  participant A as working directory<br>(working tree)
  participant B as staging area<br>(index)
  participant C as local repository<br>(local branch)
  participant D as local repository<br>(tracking branch)
  participant E as remote repository

  A->>B: git add
  B->>C: git commit
  C->>E: git push
  C->>A: git switch -c<br>(checkout)
  E->>D: git fetch
  D->>A: git merge
  E->>A: git pull (実質的には git fetch + git merge)
```

Gitはディレクトリ単位でVersion管理します. 管理されるディレクトリには3つのエリアが作られ,それぞれWorking Directory,Staging Area,Respositoryと呼びます.

- Working Directory:
  - ドキュメントやプログラムファイルの作成などの作業を行う場所
  - 開発者が作業するためのディレクトリ領域
- Staging Area:
  - 変更履歴として保存するファイルを選択し,置いておく場所
  - `git add`で指定したファイルが行き着くところ
- Respository:  
  - 変更履歴を記録しておく場所
  - Staging Areaに置かれているファイルを変更履歴をリポジトリに保存することを「Commit」といいます


Git管理されたファイルは`modified`, `staged`, `committed`という状態が与えられ,それぞれの状態がファイルがどこのエリアにいるかを示しています.

|状態|説明|
|---|---|
|`modified`|ファイルの内容は変更されたがまだcommitされていない状態(データベースに記録されていない状態)|
|`staged`|ファイルが次のcommitでデータベースに記録される準備ができたことを示します|
|`committed`|ローカルレポジトリにファイル変更履歴が記録されていることを示します|


```mermaid
sequenceDiagram
    participant wd as Working Directory
    participant sd as Staging Area
    participant cd as .git directory<br>(=Repository)
    cd->>wd: Checkout the project
    Note left of sd: git checkout<br>git restore
    wd->>sd: Stage Fixes
    Note left of sd: git add<br>git rm
    sd->>cd: Commit
    Note left of cd: git commit
```


<strong > &#9654;&nbsp; git ls-fles: stagedにインデックスされているファイルの表示</strong>

`git ls-files`コマンドでステージングエリアに存在するファイルを確認することができます. ただし,gitの監視対象にある,ディレクトリに存在するファイルのみをリスト化するということであって,ディレクトリは確認することができません.

```zsh
 % git ls-files
.gitignore
404.html
Gemfile
Gemfile.lock
Gruntfile.js
LICENSE
README.md
...
```

オプションを組合せて`git ls-files -io --exclude-standard`と入力するとgitignoreに記載されているファイル=stagedされないファイルのみを表示することもできます.

|Option|Comments|
|---|---|
|`-i`|無視ファイル(ignore)のみを表示，利用するためには除外パターンの指定が必要|
|`-o`|管理対象外のファイルを表示|
|`--exclude-standard`|`.gitignore` 等で指定されているものを除外パターンとしてコマンドに伝えるオプション|

### Gitはどこにバージョン管理のDBをもっているのか？

新たにGitでバージョン管理を始める際に，Repository初期化から始まります．具体的には`git init`コマンドを
叩くこととで初期化を実行します．

`git init`によってGit管理に指定したディレクトリには `.git`ディレクトリが作成されます．
この`.git`ディレクトリにてGitはrepository dataを管理しており，修正ログもこの中に記録されています．
Repositoryのバックアップやクローンをしたい場合，このディレクトリをどこかへコピーするだけでほぼ事足ります．

`.git` ディレクトリの中は以下のようになっています.

```raw
HEAD
config*
description
hooks/
info/
objects/
refs/
```

特に重要なのは以下の４項目となります

- HEAD ファイル: 現在チェックアウトしているブランチを示すファイル
- index ファイル（`git init`直後ではまだ作成されていない）: ステージングエリアの情報を保管
- objects ディレクトリ: データベースのすべてのコンテンツを保管
- refs ディレクトリ: コンテンツ内のコミットオブジェクトを指すポインタ（ブランチ）を保管

なお，`.git`ディレクトリが存在するディレクトリ以下の特に「**ワークツリー**」と呼びます．とある時点のcommitまで戻したい場合は，

- `.git`ディレクトリに格納されているログデータを参照
- 対象となるデータの状態をログデータから取得し，ワークツリーに展開

という仕組みになっています．


### Gitはどのように履歴データを取り出しているのか？

Gitはシンプルなキー・バリュー型データストアです.どんな種類のコンテンツでも格納でき,それに対応するキーが返されます.キーを使えば格納したコンテンツをいつでも取り出せます.ここでのコンテンツのことを「コミットオブジェクト」といいます.「コミットオブジェクト」はコミットによって生成されたデータのことです.Gitはコミットオブジェクトに対して40文字のIDを発行します.これがコミットハッシュ値でキー・バリューのキーに相当します.

コミットオブジェクトの中身を確認したい場合は,`git cat-file -p`で任意のコミットのコミットオブジェクトを見ることができます.

```zsh
% git cat-file -p 757cd618f38d574238bae4768ff1a1aedfafdb7a
tree 05520e3bd0354e823cacf96b244987f235b3c240
parent 2476c4c7bcbf98e444b6851d67036077334502d2
author DQNEO <dqneo@example.com> 1454588308 +0900
committer DQNEO <dqneo@example.com> 1454588308 +0900
second commit
```

- `tree`というのはtreeオブジェクトのことで,これはディレクトリツリーに対して割り振られるIDです.(もうちょっと厳密に言うと,treeオブジェクトは1つ以上のtreeオブジェクトまたはblobオブジェクトを持つツリー構造のデータです)
- `parent`というのは親コミットすなわち１個前のコミットのハッシュ値です.Gitのコミットオブジェクトは必ず1つ以上の親コミットを持っており,親を順番にたどっていくことで履歴をさかのぼることができます.
- authorとcommiterは普通同じ人になるのですが,cherry-pickしたりrebaseしたりすると異なる名前になることがあります.
- 1行空行をはさんでそこから下がコミットメッセージです.

なお,コミットオブジェクトに対応するハッシュ値の計算式は以下のようになります

```raw
hash = sha1("commit<半角スペース><コミットオブジェクトのバイト数>\0<コミットオブジェクトの中身>")
```

## How to Install Git

Ubuntu 20.04 LTSにGitをインストールすのは簡単で以下のコマンドをターミナルで実行するだけです.

```zsh
% sudo apt update && sudo apt upgrade -y
% sudo apt install git-all
```

Versionを確認しときます.

```zsh
% git --version
git version 2.30.0
```

### Setup

Git configファイルの置き場所は３パターンあります：

|PATH|説明|
|---|---|
|`/etc/gitconfig`|システム上のすべてのユーザーとそのすべてのリポジトリに適用される値を保持します.git config に `--system` オプションを指定すると,このファイルから読み書きします.これはシステム設定ファイルなので,これを変更するには管理者権限かスーパーユーザー権限が必要となります.|
|`~/.gitconfig`|ユーザー自身に固有の値を指定します.`--global` オプションを指定することで,Git にこのファイルの読み書きをさせることができます.|
|config file in the Git directory |その単一のリポジトリーに固有の値を指定します.このファイルの読み書きを強制的に行う場合,`--local` オプションを指定しますが,デフォルトで参照するようになっています.このオプションが正しく動作するには,Git リポジトリのどこかに位置している必要があります.|

以下のコマンドでconfig一覧を確認することができます

```zsh
% git config --list --show-origin
```

#### `~/.gitconfig`の設定

<strong > &#9654;&nbsp; User 設定</strong>


Version管理を実現するためには誰がどのファイルをいつ変更したのかのデータが必要です．まずユーザーがだれなのかをgitに教えるため，user nameとemail addressをconfigに設定します.

```zsh
% git config --global user.name "John Doe"
% git config --global user.email johndoe@example.com
```

ここで設定した名前とアドレスがコミットログに表示されます．コミット漕ぐに表示される名前としてなので，
本名やGitHubアカウントネームである必要はありません．


<strong > &#9654;&nbsp; Editor 設定</strong>

次にEditorの設定をします．commitメッセージを書くときなどに立ち上がるEditorの設定となります．
VSCodeを利用したい場合は以下のように記載します．

```zsh
% git config --global core.editor "code --wait"
```

<strong > &#9654;&nbsp; Default Branch Name 設定</strong>

次に default branch nameを設定します，昔は`master`で最近は`main`と変わってきたところですが，こちらは好みなので設定は任意です．

```zsh
% git config --global init.defaultBranch main
```

<strong > &#9654;&nbsp; color UIの設定</strong>

Gitはカラー化されたターミナル出力をサポートしており，コマンドの出力の視覚的理解向上が期待できます．
デフォルト設定でもcolorに対応していますが，`~/.gitconfig`に明示的に記載したい場合は以下のコマンドを入力します

```zsh
% % git config --global color.ui auto

# offにしたい場合は
% git config --global color.ui false
```

上記の設定をした場合, `.gitconfig`は以下のようになっているはずです

```zsh
% cat .gitconfig                
[user]
	name = John Doe
	email = johndoe@example.com
[core]
	editor = code --wait
[color]
	ui = auto
[init]
	defaultBranch = main
```


### commit templateの作成

Commit messageのテンプレートを作成します.commit messageを作成する際に,適切なフォーマットやスタイルを自分（または他の人）にリマインドすることができるというメリットがあります.

まず,`~/.gitmessage.txt`というファイルを以下のように作成します.commit message conventionなるものを確認したい場合は[こちらのサイト](https://www.conventionalcommits.org/en/v1.0.0/)がおすすめです.

```
<type>[optional scope]: <description>

[optional body]

Reviewed-by: [reviewer]
Refs: [ticket]

# ==== Type ====
# Add      ADD new file, function, feature
# Update   UPDATE existing functions/features
# Clean    Refactoring
# Remove   REMOVE files
# Fix      FIX bugs
# Upgrade  Upgrading to a new version

# ==== Type ====
# [Refs]: #<number>: referring an issue on GitHub
# [close, closed, fixed, resolve, resolved] #<number>: closing issue
```

git commit を実行したときにDefaultのメッセージとして使うためには,`commit.template`の設定値を設定する必要があります.

```zsh
% git config --global commit.template ~/.gitmessage.txt
```

## GPGキーの登録

Gitは, メールアドレスを使って誰がAuthorなのか,Committerであるかを判別するしています.
しかし, メールアドレスは各自がlocalの `git config` で設定できる属性のため, 簡単になりすましができてしまうという
問題があります. 

このようななりすましの対策として, GPGキーを用いたgit commitへのデジタル署名がGitHub公式ページでは推奨されています.
GPG公開鍵をGitHubに登録とすると, commitとtagが正常に検証されたGPGキーで署名されている場合,「Verified」としてマークがつくようになります.

### GPGキーの生成とGitHubへの登録

GitHubでサポートされていないアルゴリズムを用いてキーを生成 & 追加しようとすると,
エラーが生じることがあるので, サポートされているアルゴリズムをまず確認します:

```
RSA,ElGamal,DSA,ECDH,ECDSA,EdDSA
```

> GPGキー生成

```zsh
% gpg --full-generate-key
```

- キーは少なくとも 4096 ビットである必要があり
- キー有効期間は, 無期限を示すデフォルトの選択を指定(公式の推奨)
- ユーザID情報時に求められるメールアドレスは, GitHub アカウント用の検証済みメールアドレスを入力
- GPGキーはホームディレクトリ以下の`.gnupg/openpgp-revocs.d`に生成されます

> 生成されたGPGキーの確認

生成されたGPGキーの確認は以下のコマンドでできます. GitHubでは秘密鍵のGPGキーIDの長い形式の登録が必要なので,
` --keyid-format=long` オプションをつけて表示します.

```zsh
% gpg --list-secret-keys --keyid-format=long  
% gpg --list-public-keys --keyid-format=long  
```

なおそれぞれ２つのIDがでてきますが, それらの意味は以下です:

---|---
sec|SECret key
ssb|Secret SuBkey
pub|PUBlic key
sub|public SUBkey

> GitHubに登録するGPGキーの確認

まず秘密鍵のGPGキーを確認します. この例では, GPG キー ID は 3AA5C34371567BD2 です

```zsh
% gpg --list-secret-keys --keyid-format=long
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot 
ssb   4096R/42B317FD4BA89E7A 2016-03-10
```

次に, 秘密鍵情報をASCII形式(テキスト形式)で出力します

```zsh
% gpg --armor --export 3AA5C34371567BD2
```

-----BEGIN PGP PUBLIC KEY BLOCK----- で始まり、-----END PGP PUBLIC KEY BLOCK----- で終わる GPG キーをコピーし, それを登録します.

### Git へ GPG キーを伝える

GitHubへのGPGキー登録後, GitでGPG署名キーを設定する必要があります.

GPG キー ID は 3AA5C34371567BD2の場合,

```zsh
% git config --global user.signingkey 3AA5C34371567BD2
```

きちんと登録されているかどうかの確認するため, `.gitconfig`を開きます(場所は個人次第)

```zsh
% cat ~/.gitconfig
```

### `.zshrc`への登録

```zsh
% [[ -f ~/.zshrc ]] && echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
```

`[[ -f ~/.zshrc ]]`は条件式で `-f` 後のファイルパスが存在するならば 1 else 0を返します.

### コミットに署名する

`-S` フラグを`git commit`コマンドに追加し, pushするだけで完了です.

```zsh
% git commit -S -m "your commit message"
# Creates a signed commit
% git push -u origin main
# ローカルコミットをリモートリポジトリにプッシュする
```

> タグに署名する

1. タグに署名するには, `git tag` コマンドに `-s` を追加します.
2. タグを`git tag -v [tag-name]` コマンドで検証(verify)します

```zsh
% git tag -s mytag
# 署名済みのタグを作成する
% git tag -v mytag
# 署名済みのタグを検証する
```

## Appendix: BFG Repo-Cleanerのインストール
### BFG Repo-Cleanerとは？

BFGは, git-filter-branchと同様にGit Repository Historyから機密データ(例:パスワードや認証情報、その他のプライベートなデータ)をクレンジングしてくれるツールです.オープンソースコミュニティによって構築およびメンテナンスされています.

誤って個人情報を含んだファイルをrepositoryに上げてしまい情報流出が発生してしまう恐れは多々あります. その際,ファイルの削除だけでなくhistoryの削除も実施する必要があり,そのようなときにBFGが役に立ちます.


### BFGのインストール

```zsh
% cd ./tools/bfg
% wget https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar
```

- `./tools/bfg`は自分がapt以外の経由でパッケージをインストールする際に使っているディレクトリなので,任意の場所でも構いません

つぎにCLIから簡単に呼び出すことができるようにaliasを指定します. 自分はzshを使っているので`.zshrc`に以下のラインを追記します.

```
alias bfg='java -jar ~/tools/bfg/bfg-1.14.0.jar'
```

- `java`コマンドが必要なので`sudo apt install -y default-jdk`とかでOpenJDKをインストールすることが必要です

> 利用方法

Delete all files named 'id_rsa' or 'id_dsa' :

```zsh
% bfg --delete-files id_{dsa,rsa}  my-repo.git
```

Replace all passwords listed in a file (prefix lines 'regex:' or 'glob:' if required) with ***REMOVED*** wherever they occur in your repository :

```zsh
% bfg --replace-text passwords.txt  my-repo.git
```



References
------


- [Ryo's Tech Blog > 2021-04-25: Githubパスワード認証廃止への対応](https://ryonakagami.github.io/2021/04/25/github-token-authentication/)
- [Ryo's Tech Blog > 2020-12-23: Git in Zshの設定](https://ryonakagami.github.io/2020/12/23/ubuntu-zshsetup/)
- [Git Getting Started](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)
- [GitHub Docs > 新しい GPG キーを生成する](https://docs.github.com/ja/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
- [GitHub Docs > Git へ署名キーを伝える](https://docs.github.com/ja/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [Gitの内側 - Gitオブジェクト](https://git-scm.com/book/ja/v2/Git%E3%81%AE%E5%86%85%E5%81%B4-Git%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88)
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)