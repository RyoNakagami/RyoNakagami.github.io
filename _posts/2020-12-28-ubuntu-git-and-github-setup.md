---
layout: post
title: "Ubuntu Desktop環境構築 Part 13"
subtitle: "GitとGitHubの設定"
author: "Ryo"
header-img: "img/post-git-github-logo.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- git
- GitHub
---

||概要|
|---|---|
|目的|GitとGitHubの設定|
|関連記事|- [Git in Zshの設定](https://ryonakagami.github.io/2020/12/23/ubuntu-zshsetup/)|
|参考|- [Git Getting Started](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)<br> - [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)<br> - [Gitの内側 - Gitオブジェクト](https://git-scm.com/book/ja/v2/Git%E3%81%AE%E5%86%85%E5%81%B4-Git%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [Requirements](#requirements)
- [2. Gitとはなにか？](#2-git%E3%81%A8%E3%81%AF%E3%81%AA%E3%81%AB%E3%81%8B)
  - [Version管理の方法：分散型とは？](#version%E7%AE%A1%E7%90%86%E3%81%AE%E6%96%B9%E6%B3%95%E5%88%86%E6%95%A3%E5%9E%8B%E3%81%A8%E3%81%AF)
  - [Gitのバージョン管理の仕組み](#git%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%AE%A1%E7%90%86%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [Gitはどこにバージョン管理のDBをもっているのか？](#git%E3%81%AF%E3%81%A9%E3%81%93%E3%81%AB%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%AE%A1%E7%90%86%E3%81%AEdb%E3%82%92%E3%82%82%E3%81%A3%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
  - [Gitはどのように履歴データを取り出しているのか？](#git%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AB%E5%B1%A5%E6%AD%B4%E3%83%87%E3%83%BC%E3%82%BF%E3%82%92%E5%8F%96%E3%82%8A%E5%87%BA%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
- [3. GitのInstallと初期設定](#3-git%E3%81%AEinstall%E3%81%A8%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
  - [初期設定](#%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
    - [`~/.gitconfig`の設定](#gitconfig%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [commit templateの作成](#commit-template%E3%81%AE%E4%BD%9C%E6%88%90)
- [4. GitHubの個人アカウントとの連携](#4-github%E3%81%AE%E5%80%8B%E4%BA%BA%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%A8%E3%81%AE%E9%80%A3%E6%90%BA)
  - [新しい SSH キーを生成して ssh-agent に追加する](#%E6%96%B0%E3%81%97%E3%81%84-ssh-%E3%82%AD%E3%83%BC%E3%82%92%E7%94%9F%E6%88%90%E3%81%97%E3%81%A6-ssh-agent-%E3%81%AB%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)
  - [GitHub アカウントへの新しい SSH キーの追加](#github-%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%B8%E3%81%AE%E6%96%B0%E3%81%97%E3%81%84-ssh-%E3%82%AD%E3%83%BC%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [SSH 接続をテストする](#ssh-%E6%8E%A5%E7%B6%9A%E3%82%92%E3%83%86%E3%82%B9%E3%83%88%E3%81%99%E3%82%8B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

- Gitのインストールと初期設定
- GitHubの個人アカウントとの連携

### Requirements

- GitHubの個人アカウント作成済み
- Visual Studio Codeインストール済み

## 2. Gitとはなにか？

Gitとは分散型バージョン管理システムです。Version管理とは、変更履歴を管理することで, ソースコードを書き足したり、変更したりする過程を記録したり、特定の段階に戻ったり、ファイルを復活させたり、メタデータからの状態の検索することができるようになります。Gitを活用することで以下のような課題を解決することができます：

- あのとき動いたが、今は動かない。一回動いていた状態に戻したい
- このコードを加えた人とタイミングを知りたい

### Version管理の方法：分散型とは？

Version管理の方法として、Gitは差分(Differences)でなくSnapshotsでデータを管理しています。Git は基本的に、すべてのファイルが各時点でどのように見えるかをSnapshotで記録し、そのSnapshotへの参照を保存します。効率化のため、ファイルが変更されていない場合は、Git はファイルを再び保存せず、すでに保存されている以前の同じファイルへのリンクだけを保存します。

Snapshots vs Differencesのイメージは以下のFiguresとなります。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20210104_GIt_snapshots.png?raw=true">

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20210104_git_snapshots_02.png?raw=true">

Version管理システムは分散型と集中型の２つに大別することができます。集中型とは変更履歴などのデータを一つの中央サーバーに集めて管理する種類のことです。分散型とは、各クライアントがレポジトリーをミラーし終わったあとは、変更履歴の参照などのVersion管理アクションは各々のクライアント内部で閉じている種類のことを指します。

分散型は、最新のソースコードの管理が難しいというデメリットがありますが(いわゆるコンフリクト)、クライアントのローカル環境内部で変更履歴の確認等の作業が完結するので、集中型Version管理システムで直面するnetwork latency overhead問題を憂慮すること少なく開発作業をすることができます。

分散型 vs 集中型のイメージは以下のFiguresとなります。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20210104_Git_Centralized_version_control.png?raw=true">

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20200104_Git_Distributed_version_control.png?raw=true">

### Gitのバージョン管理の仕組み

Gitはディレクトリ単位でVersion管理します。管理されるディレクトリには3つのエリアが作られ、それぞれWorking Directory、Staging Area、Respositoryと呼びます。Git管理されたファイルは`modified`, `staged`, `committed`という状態が与えられ、それぞれの状態がファイルがどこのエリアにいるかを示しています。

|状態|説明|
|---|---|
|`modified`|ファイルの内容は変更されたがまだcommitされていない状態(データベースに記録されていない状態)|
|`staged`|ファイルが次のcommitでデータベースに記録される準備ができたことを示します|
|`committed`|ローカルレポジトリにファイル変更履歴が記録されていることを示します|

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/GitHub_pages_Posts/20210104_Git_Three_states.png?raw=true">

### Gitはどこにバージョン管理のDBをもっているのか？

`git init`によってGit管理に指定したディレクトリには`.git`というディレクトリが作成されます。Git が保管したり操作したりする対象の、ほとんどすべてがここに格納されます。 リポジトリのバックアップやクローンをしたい場合、このディレクトリをどこかへコピーするだけで、ほぼ事足ります。

`.git` ディレクトリの中は以下のようになっています。

```raw
HEAD
config*
description
hooks/
info/
objects/
refs/
```

重要なのは4項目です。具体的には、 HEAD ファイル、 index ファイル（まだ作成されていない）、 objects ディレクトリ、 refs ディレクトリです。 これらがGitの中核部分になります。 objects ディレクトリにはデータベースのすべてのコンテンツが保管されます。refs ディレクトリには、それらコンテンツ内のコミットオブジェクトを指すポインタ（ブランチ）が保管されます。HEAD ファイルは、現在チェックアウトしているブランチを指します。index ファイルには、Git がステージングエリアの情報を保管します。

### Gitはどのように履歴データを取り出しているのか？

Gitはシンプルなキー・バリュー型データストアです。どんな種類のコンテンツでも格納でき、それに対応するキーが返されます。キーを使えば格納したコンテンツをいつでも取り出せます。ここでのコンテンツのことを「コミットオブジェクト」といいます。「コミットオブジェクト」はコミットによって生成されたデータのことです。Gitはコミットオブジェクトに対して40文字のIDを発行します。これがコミットハッシュ値でキー・バリューのキーに相当します。

コミットオブジェクトの中身を確認したい場合は、`git cat-file -p`で任意のコミットのコミットオブジェクトを見ることができます。

```zsh
% git cat-file -p 757cd618f38d574238bae4768ff1a1aedfafdb7a
tree 05520e3bd0354e823cacf96b244987f235b3c240
parent 2476c4c7bcbf98e444b6851d67036077334502d2
author DQNEO <dqneo@example.com> 1454588308 +0900
committer DQNEO <dqneo@example.com> 1454588308 +0900
second commit
```

- `tree`というのはtreeオブジェクトのことで、これはディレクトリツリーに対して割り振られるIDです。(もうちょっと厳密に言うと、treeオブジェクトは1つ以上のtreeオブジェクトまたはblobオブジェクトを持つツリー構造のデータです)
- `parent`というのは親コミットすなわち１個前のコミットのハッシュ値です。Gitのコミットオブジェクトは必ず1つ以上の親コミットを持っており、親を順番にたどっていくことで履歴をさかのぼることができます。
- authorとcommiterは普通同じ人になるのですが、cherry-pickしたりrebaseしたりすると異なる名前になることがあります。
- 1行空行をはさんでそこから下がコミットメッセージです。

なお、コミットオブジェクトに対応するハッシュ値の計算式は以下のようになります

```raw
hash = sha1("commit<半角スペース><コミットオブジェクトのバイト数>\0<コミットオブジェクトの中身>")
```

## 3. GitのInstallと初期設定

Ubuntu 20.04 LTSにGitをインストールすのは簡単で以下のコマンドをターミナルで実行するだけです。

```zsh
% sudo apt update && sudo apt upgrade -y
% sudo apt install git-all
```

Versionを確認しときます。

```zsh
% git --version
git version 2.30.0
```

### 初期設定

Git configファイルの置き場所は３パターンあります：

|PATH|説明|
|---|---|
|`/etc/gitconfig`|システム上のすべてのユーザーとそのすべてのリポジトリに適用される値を保持します。git config に `--system` オプションを指定すると、このファイルから読み書きします。これはシステム設定ファイルなので、これを変更するには管理者権限かスーパーユーザー権限が必要となります。|
|`~/.gitconfig`|ユーザー自身に固有の値を指定します。`--global` オプションを指定することで、Git にこのファイルの読み書きをさせることができます。|
|config file in the Git directory |その単一のリポジトリーに固有の値を指定します。このファイルの読み書きを強制的に行う場合、`--local` オプションを指定しますが、デフォルトで参照するようになっています。このオプションが正しく動作するには、Git リポジトリのどこかに位置している必要があります。|

以下のコマンドでconfig一覧を確認することができます

```
% git config --list --show-origin
```

#### `~/.gitconfig`の設定

configファイルの設定をここから紹介します。Version管理を実現するためには誰がどのファイルをいつ変更したのかのデータが必要です。なのでまずユーザーがだれなのかをgitに教えるため、user nameとemail addressをconfigに設定します。

```
% git config --global user.name "John Doe"
% git config --global user.email johndoe@example.com
```

次にEditorの設定をします。commitメッセージを書くときなどに立ち上がるEditorの設定となります。

```
% git config --global core.editor nano
```

次に default branch nameを設定します。昔は`master`で最近は`main`と変わってきたところですがこちらは好みなので設定は任意です。

```
% git config --global init.defaultBranch main
```

### commit templateの作成

Commit messageのテンプレートを作成します。commit messageを作成する際に、適切なフォーマットやスタイルを自分（または他の人）にリマインドすることができるというメリットがあります。

まず、`~/.gitmessage.txt`というファイルを以下のように作成します。commit message conventionなるものを確認したい場合は[こちらのサイト](https://www.conventionalcommits.org/en/v1.0.0/)がおすすめです。

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

git commit を実行したときにDefaultのメッセージとして使うためには、`commit.template`の設定値を設定する必要があります。

```zsh
% git config --global commit.template ~/.gitmessage.txt
```

## 4. GitHubの個人アカウントとの連携

SSH プロトコルを利用してGitHubへの接続環境を構築します。SSH をセットアップする際には、SSH キーを生成し、ssh-agent に追加し、それから キーを自分の GitHubアカウントに追加します。 SSH キーを ssh-agent に追加することで、パスフレーズの利用を通じて SSH キーに追加のセキュリティのレイヤーを持たせることができます。

### 新しい SSH キーを生成して ssh-agent に追加する

`ssh-keygen`というコマンドを用いてsshキーを作成します。`which ssh-keygen`を実行して、コマンドが存在するか確かめます。

```zsh
% which ssh-keygen
usr/bin/ssh-keygen
```

次にsshキーを作成します。メールアドレスは自分のgit configで用いたメールアドレスを用いてください。

```zsh
% ssh-keygen -t ed25519 -C "your_email@example.com"
> Generating public/private ed25519 key pair.
```

Enter a file in which to save the key」というメッセージが表示されたら、Enter キーを押します。 これにより、デフォルトのファイル場所が受け入れられます。

```
> Enter a file in which to save the key (/home/you/.ssh/id_ed25519): [Press enter]
```

プロンプトで、安全なパスフレーズを入力します。 

```
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

仮に`~/.ssh/id_ed25519`というキーが発行された場合、Permissionを変更しておく

```zsh
% chmod 600 ~/.ssh/id_ed25519.pub
```

`~/.ssh/config`ファイルも編集する。

```
Host github
  HostName github.com
  User git
  Port 22
  IdentityFile ~/.ssh/id_ed25519`
  IdentitiesOnly yes
  TCPKeepAlive yes
```

ここの設定は以下のコマンドに対応します。

```
% git clone [User]@[Host]:[リポジトリアドレス]
```

|設定項目|説明|
|---|---|
|Host|ホスト名, ssh hogehogeでhogehogeとなるところ|
|User|ログインユーザー, githubの場合はgit|
|Port| port, default 22|
|HostName|hostのアドレス, github.com|
|IdentityFile|秘密鍵のPATHを指定する|
|TCPKeepAlive|持続的接続の設定|
|IdentitiesOnly|使用する秘密鍵をIdentityFileだけにします。デフォルトではnoであり、noだと全ての秘密鍵を試そうとします。|

### GitHub アカウントへの新しい SSH キーの追加

SSH 公開鍵をGitHubに登録するところまでを目指します。そのためまず自分が作成したsshキーの公開鍵の内容を取得する必要があります。具体的にはクリップボードへのコピーです。

```zsh
% sudo apt install xclip
% xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

その後、GitHubにwebブラウザでアクセスし、`Settings`を変更します（Settingsをクリック）。

<img src="https://docs.github.com/assets/images/help/settings/userbar-account-settings.png">


ユーザ設定サイドバーでSSH and GPG keys（SSH及びGPGキー）をクリックします。

<img src="https://docs.github.com/assets/images/help/settings/settings-sidebar-ssh-keys.png">

`[New SSH key]` または `[Add SSH key]` をクリックします。

<img src="https://docs.github.com/assets/images/help/settings/ssh-add-ssh-key.png">

`[Title]` フィールドで、新しいキーを説明するラベルを追加します。 たとえば個人の Ubuntu Desktop を使っている場合、このキーを "Personal Ubuntu Desktop" などと呼ぶことが考えられます。

次に、クリップボードにコピーしたキーを `[Key]` フィールドに貼り付けます。 

<img src="https://docs.github.com/assets/images/help/settings/ssh-key-paste.png">

その後、`[Add SSH key]` をクリックして完了です。

### SSH 接続をテストする

```
% ssh -T git@github.com
```

コマンド実行後以下のようなメッセージが出たら接続テスト成功です。

```
> Hi username! You've successfully authenticated, but GitHub does not
> provide shell access
```


