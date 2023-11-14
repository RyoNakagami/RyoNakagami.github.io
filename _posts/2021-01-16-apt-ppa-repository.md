---
layout: post
title: "add-apt-repository ppaとはなにか？"
subtitle: "APTによるパッケージ管理 4/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-07-28
tags:

- Linux
- apt
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [PPA とはなにか？](#ppa-%E3%81%A8%E3%81%AF%E3%81%AA%E3%81%AB%E3%81%8B)
  - [PPAのデメリット](#ppa%E3%81%AE%E3%83%87%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
- [How to List up packages from PPA?](#how-to-list-up-packages-from-ppa)
- [How to Delete PPA](#how-to-delete-ppa)
  - [`add-apt-repository --remove`](#add-apt-repository---remove)
  - [`ppa-purge`: Delete the PPA repository info and the package at the same time](#ppa-purge-delete-the-ppa-repository-info-and-the-package-at-the-same-time)
- [References](#references)
- [5. リポジトリの追加](#5-%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [なぜPPAを使うのか？](#%E3%81%AA%E3%81%9Cppa%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AE%E3%81%8B)
  - [Syntax](#syntax)
  - [リポジトリの削除](#%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E5%89%8A%E9%99%A4)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## PPA とはなにか？

統計計算ソフトのRをUbuntuへInstallする際, 公式ドキュメントに従って実行すると以下のようなラインに出会います:

```zsh
% sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
...
% sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
% sudo apt update
% sudo apt install --no-install-recommends r-cran-tidyverse
```

普段, パッケージをインストールするときは, Ubuntu公式が運用しているリポジトリから取得しますが, サードパーティのリポジトリから取得するケースもあります.
サードパーティのソフトウェアをインストールする際は, そのリポジトリをあらかじめ追加してから, `apt`コマンドで対象となるパッケージをインストールします.
この, 「**サードパーティのリポジトリをあらかじめ追加**」には`add-apt-repository`を用います.

では, `PPA`とはなんなのか？という疑問が残ります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: PPA</ins></p>

- PPAはPersonal Package Archiveの略称でlaunchpad.netに用意された個人用リポジトリ
- PPAを用いることで, 開発者は自由にプログラム配布用のレポジトリを作成することができる.
- End userは `sources.list`へrepository infoを加えるだけで, `apt`コマンド経由でプログラムが利用可能

</div>

Ubuntuの公式リポジトリは, 一度リリースしたら不具合の修正とセキュリティ対応がパッケージのバージョンをできるだけあげないというスタンスを取っています.
そのため, 新しい機能を追加したアップデートバージョンを開発者がリリースしたいとき, Ubuntuの公式リポジトリ経由では時間がかかってしまうという問題がありました.

この点, PPAは個人が自由に使えるリポジトリ & バイナリパッケージのビルド・リリースのためのインフラまで準備してくれているので, 開発者はスムーズにパッケージのリリースをユーザーに提供できるというメリットがあります.
また, エンドユーザー目線でも, 公式リポジトリと同じUIでソフトウェアのインストールやアップグレードができます. Ubuntu側としても, PPAでビルドできるソースパッケージをソフトウェア開発者が作成してくれれば, 将来的に公式リポジトリにも取り込みやすくなるという三方良しの仕組みと言えます.

### PPAのデメリット

PPAは公式リポジトリのようなチェックは行われないので, 品質や信頼性のリスクは意識したほうが良いです.

ただそれよりも問題なのが, PPAを導入すると, そのPPAに存在するパッケージと公式リポジトリのパッケージの優先度は同じ値になってしまうので, 
PPAに存在するパッケージのバージョンが公式リポジトリのバージョンより高かったら, アップグレード時にPPA版のバージョンに更新されてしまうリスクがあることです.

意図しないところでパッケージのバージョンを更新されてしまうと, 依存関係問題から今まで動いていたのにある日突然ソフトが動かなくなったという自体に陥るリスクがあります.
ですので, システム安定稼働の観点から可能な限りPPA経由のパッケージインストールは避けたほうが良いと言えます.

## How to List up packages from PPA?

`apptitude`コマンドを使うと簡単に確認できます

```zsh
## commandのインストール
% sudo apt install aptitude 

## list of installed packages for active PPA's in sources.list
% aptitude search '?narrow(?installed, ~Oppa)'
```

- `?narrow(filter, pattern)`: filter and patternにマッチするパッケージの特定
- `?installed`: currently installed
- `~Oppa`: Origin contains `ppa`

上記で見つかったパッケージについてさらなる情報が欲しい場合は`apt-cache policy`を用います

```zsh
% apt-cache policy r-cran-uuid 
r-cran-uuid:
  Installed: 1.1-0-1cran1.2204.0
  Candidate: 1.1-0-1cran1.2204.0
  Version table:
 *** 1.1-0-1cran1.2204.0 500
        500 https://ppa.launchpadcontent.net/c2d4u.team/c2d4u4.0+/ubuntu jammy/main amd64 Packages
        100 /var/lib/dpkg/status
     1.0-3-1 500
        500 http://jp.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages

```


## How to Delete PPA

PPA repositoryの消去の仕方は複数あります

### `add-apt-repository --remove`

PPAレポジトリを加える際のコマンドに`--remove` optionをつけるだけで実行できます

```zsh
## Delete
% sudo add-apt-repository --remove ppa:PPA_Name/ppa

## Check whether the ppa is actually deleted
% ls /etc/apt/sources.list.d
```

上記のコマンドを実行すると`/etc/apt/sources.list.d`からレポジトリ登録情報を格納した`.list`ファイルが削除されます.
そのため, `/etc/apt/sources.list.d`ディレクトリで直接ファイルを削除するのと実質的に同じと言えます.

### `ppa-purge`: Delete the PPA repository info and the package at the same time

上記の`add-apt-repository --remove`による削除はあくまでレポジトリ登録を削除するだけでしたが, 
`ppa-purge`コマンドはレポジトリ登録の削除と同時に, PPAからインストールしたパッケージを「可能な限り」現在有効なリポジトリにあるパッケージに置き変えてくれるコマンドです.

```zsh
% sudo apt-get install ppa-purge
% sudo ppa-purge ppa:ppa-owner/ppa-name
```

References
------

- [How to list all the packages which are installed from PPAs?](https://askubuntu.com/questions/447129/how-to-list-all-the-packages-which-are-installed-from-ppas)
















## 5. リポジトリの追加

リポジトリは、Ubuntu公式が運用しているものばかりではなく、サードパーティのリポジトリもあります。サードパーティ性のソフトウェアをインストールする際は、そのリポジトリをあらかじめ追加しておくとaptコマンドが使えるので便利です。リポジトリの追加には`add-apt-repository`を使います。PPAを登録すると、`apt upgrade`でアップグレードの対象となるため、システム全体で一括してアップグレードをかけることができる便利さがあります。一方、安易に導入するとシステムの安定性やセキュリティを損なうことも考えられるので慎重さが必要です。


### なぜPPAを使うのか？

- オフィシャルリポジトリにパッケージがない場合
- パッケージはあるもののバージョンが古い場合

がPPAを使ったインストールを検討する代表的な例となります. なお、PPAとは、「Personal Package Archive」の略です. Ubuntuディストリビューション公式に承認されたものではないのでインストールするかどうかは自己責任となります.

### Syntax

```
% add-apt-repository <respository name>
```

リポジトリは`ppa:{ユーザー名}/ppa`で指定します。一例として、google-drive-ocamlfuseのレポジトリを追加したい場合は

```
% sudo add-apt-repository ppa:alessandro-strada/ppa
```

追加されたリポジトリの情報は、`/etc/apt/sources.list.d`ディレクトリ以下に格納されます。

```
% ls /etc/apt/sources.list.d
alessandro-strada-ubuntu-ppa-focal.list  embrosyn-ubuntu-cinnamon-focal.list.save  vscode.list
cisofy-lynis.list			                   google-chrome.list			                   vscode.list.save
cisofy-lynis.list.save			             google-chrome.list.save
embrosyn-ubuntu-cinnamon-focal.list	     slack.list
```

### リポジトリの削除

```
% ppa-purge {リポジトリ}
```

`ppa-purge`コマンドは、デフォルトではインストールされていないので、`apt install ppa-purge`を実行する必要があります。なお、リポジトリを削除しても、そのリポジトリからインストールされたパッケージは削除されないので`sudo apt autoremove`を実行することをおすすめします。

削除の一例として

```zsh
% sudo ppa-purge ppa:openjdk-r/ppa
```