---
layout: post
title: "Ubuntu環境構築基礎知識：パッケージの管理"
subtitle: "APTによるパッケージ管理"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- apt
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
|目的|APTパッケージ管理の基礎知識の整理|
|参考|[APT公式ウェブサイト](https://tracker.debian.org/pkg/apt)<br>[Debianパッケージ管理](https://www.debian.org/doc/manuals/debian-reference/ch02.ja.html)<br> [Launchpad](https://launchpad.net/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. パッケージ管理とは](#1-%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E7%AE%A1%E7%90%86%E3%81%A8%E3%81%AF)
- [2. APT](#2-apt)
  - [Syntax](#syntax)
  - [`apt install --reinstall`の使用用途](#apt-install---reinstall%E3%81%AE%E4%BD%BF%E7%94%A8%E7%94%A8%E9%80%94)
- [3. リポジトリの設定](#3-%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [`/etc/apt/sources.list`ファイル例](#etcaptsourceslist%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E4%BE%8B)
  - [Syntax](#syntax-1)
  - [パッケージの一覧](#%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E4%B8%80%E8%A6%A7)
- [4. パッケージの情報の取得](#4-%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E6%83%85%E5%A0%B1%E3%81%AE%E5%8F%96%E5%BE%97)
- [5. リポジトリの追加](#5-%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [なぜPPAを使うのか？](#%E3%81%AA%E3%81%9Cppa%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AE%E3%81%8B)
  - [Syntax](#syntax-2)
  - [リポジトリの削除](#%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E5%89%8A%E9%99%A4)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. パッケージ管理とは

Linuxではパッケージという単位でソフトウェアを管理しています。パッケージにはいろいろな種類があります。Debian GNU/LinuxやUbuntuではDebian形式のパッケージを採用しています。


Fig 1:パッケージの概念
<img src = "https://raw.githubusercontent.com//ryonakimageserver/omorikaizuka//master/linux/packages/20201222_deb_packages.jpeg">

Debian形式のパッケージを管理するには`dpkg`コマンドを使いますが、パッケージには相互に依存関係があります。手動で管理するのは大変ですがそこのところをうまい具合に対応した上でパッケージを管理してくれるソフトウェアがAPTです。

## 2. APT

APT(Advanced Packaging Tool)はDevian系ディストリビューションで使われているパッケージ管理システムです。依存関係を自動的に調整しながら、パッケージのインストールやアップデート、削除を行います。APTでは、あらかじめ設定されたリポジトリからパッケージとパッケージの情報を取得します。リポジトリとは、ファイルやデータを集積している場所、及びその情報を管理しているデータベースを意味します。APTを使うには、まず、利用可能なパッケージリストを更新する必要があります。インストールやアップデートに必要なファイルは、インターネット上のリポジトリから自動的にダウンロードされますが、その最新情報を取得する必要があるからです。

<img src="https://raw.githubusercontent.com//ryonakimageserver/omorikaizuka//master/linux/packages/20201222_apt_packages_system.png">

### Syntax

```
% apt [option] subcommand
```

aptコマンドの主なオプション

|option|説明|
|---|---|
|`-c 設定ファイル`|設定ファイルを指定する(デフォルトは`/etc/apt/sources.list`)|
|`-d`|パッケージのダウンロードのみ行う(installとともに実行)|
|`-y`|問い合わせに対して自動的にyesと回答する|
|`--no-install-recommends`|必須ではない推奨パッケージはインストールしない|
|`--install-suggets`|提案パッケージもインストールする|
|`--reinstall`|インストール済みパッケージの再インストールを許可する|

aptコマンドの主なサブコマンド

|subcommand|説明|
|---|---|
|`update`|パッケージリストを更新する|
|`install <package name>`|パッケージをインストールする|
|`remove <package name>`|パッケージを削除する(設定ファイルは残る)|
|`purge <package name>`|パッケージと設定ファイルを削除する(依存パッケージは残る)|
|`upgrade`|インストール済みのパッケージ更新をおこない、新しいバージョンにアップグレードする|
|`show <package name>`|指定したパッケージに関する情報を表示する|
|`list`|パッケージリストを表示する|
|`list --installed`|インストールされたパッケージを一覧表示する|
|`list --upgradable`|アップデート可能なパッケージを一覧表示する|
|`depends <package name>`|パッケージの依存関係を表示する|
|`autoremove`|他のパッケージが削除されたことで「必要なくなった」パッケージを削除するコマンド|

### `apt install --reinstall`の使用用途

パッケージをインストールしたあとで、重要な構成ファイルを削除してしまったとします。そのファイルだけを取得するために再インストールしようとしても、システム的にはすでにインストールされているので、そのままでは上書きインストールができません。このときに`apt install --reinstall`を用います。

postfixパッケージを再インストールする場合：

```
% sudo apt install --reinstall postfix
```

## 3. リポジトリの設定

リポジトリの設定は`/etc/apt/sources.list`ファイル及び`/etc/apt/sources.list.d`ディレクトリ以下の`.list`ファイルで行います。

### `/etc/apt/sources.list`ファイル例

```
deb http://jp.archive.ubuntu.com/ubuntu/ focal main restricted
deb http://jp.archive.ubuntu.com/ubuntu/ focal-updates main restricted
deb http://jp.archive.ubuntu.com/ubuntu/ focal-updates universe
deb http://jp.archive.ubuntu.com/ubuntu/ focal-updates multiverse
```

### Syntax

```
dep http://jp.archive.ubuntu.com/ubuntu/ focal main restricted
```

このapt-lineは以下の構成となっています：

```
<パッケージの種類> <取得先URI> <Ubuntu version> <コンポーネント>
```

|パッケージの種類|説明|
|---|---|
|deb|バイナリパッケージを取得する|
|deb-src|ソースパッケージを取得する|

|コンポーネント|説明|
|---|---|
|main|Canonicalがサポートするフリーなオープンソースソフトウェア|
|restricted|プロプライエタリなソフトウェア(主にデバイスドライバー)|
|universe|コミュニティによってメンテナンスされるフリーなオープンソースソフトウェア|
|multiverse|著作権もしくは法的な問題によって制限されたソフトウェア|

### パッケージの一覧

apt listコマンドを使うと、パッケージ一覧を表示します。パッケージ名でソートされています。インストールされているパッケージは`[[installed]]`, 依存関係に従ってインストールされたパッケージは`[[installed,automatic]]`と表示されます。それらが表示されていないパッケージはインストールされていないパッケージです。また、ワイルドカードを使った指定も可能です。`apt list "apache2*"`と入力すると、`apache2`から始まる名前のパッケージを表示します。インストールされているパッケージだけを表示したい場合は、`apt list --installed`と入力します。

## 4. パッケージの情報の取得

パッケージの情報は`show`サブコマンドで表示できます、リポジトリにあるパッケージであれば、インストールされているかどうかにかかわらず表示できます。VScodeのパッケージ情報を表示してみます。

```
% apt show code
ackage: code
Version: 1.52.1-1608136922
Priority: optional
Section: devel
Maintainer: Microsoft Corporation <vscode-linux@microsoft.com>
Installed-Size: 273 MB
Provides: visual-studio-code
Depends: libnss3 (>= 2:3.26), gnupg, apt, libxkbfile1, libsecret-1-0, libgtk-3-0 (>= 3.10.0), libxss1, libgbm1
Conflicts: visual-studio-code
Replaces: visual-studio-code
Homepage: https://code.visualstudio.com/
Download-Size: 64.8 MB
APT-Manual-Installed: yes
APT-Sources: https://packages.microsoft.com/repos/code stable/main amd64 Packages
Description: Code editing. Redefined.
 Visual Studio Code is a new choice of tool that combines the simplicity of a code editor with what developers need for the core edit-build-debug cycle. See https://code.visualstudio.com/docs/setup/linux for installation instructions and FAQ.

```

なお、正常な設定として "Provides" と "Conflicts" と "Replaces" とを単一バーチャルパッケージに対し同時宣言することがあります。こうするといかなる時にも当該バーチャルパッケージを提供する実パッケージのうち確実に一つだけがインストールされます。

依存関係だけ確認したい場合は`apt depends`コマンドを用います。

```
% apt depends code
code
  Depends: libnss3 (>= 2:3.26)
  Depends: gnupg
  Depends: apt
  Depends: libxkbfile1
  Depends: libsecret-1-0
  Depends: libgtk-3-0 (>= 3.10.0)
  Depends: libxss1
  Depends: libgbm1
  Conflicts: <visual-studio-code>
  Replaces: <visual-studio-code>
    code
```

なお部分一致でリポジトリ上のパッケージを調べたい場合は

```
% sudo apt search {パッケージ名}
```

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

