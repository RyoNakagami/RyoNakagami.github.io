---
layout: post
title: "Linux環境構築基礎知識：パッケージの管理"
subtitle: "APTによるパッケージ管理"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Linux
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

```zsh
% apt moo
                 (__) 
                 (oo) 
           /------\/ 
          / |    ||   
         *  /\---/\ 
            ~~   ~~   
..."Have you mooed today?"...
```


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. パッケージ管理とは](#1-%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E7%AE%A1%E7%90%86%E3%81%A8%E3%81%AF)
  - [バイナリパッケージの構造](#%E3%83%90%E3%82%A4%E3%83%8A%E3%83%AA%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E6%A7%8B%E9%80%A0)
  - [パッケージの依存関係](#%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E4%BE%9D%E5%AD%98%E9%96%A2%E4%BF%82)
  - [Debian系OSのパッケージマネジャー: なぜaptが便利なのか？](#debian%E7%B3%BBos%E3%81%AE%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%83%9E%E3%83%8D%E3%82%B8%E3%83%A3%E3%83%BC-%E3%81%AA%E3%81%9Capt%E3%81%8C%E4%BE%BF%E5%88%A9%E3%81%AA%E3%81%AE%E3%81%8B)
- [2. APT](#2-apt)
  - [aptコマンドのSyntax](#apt%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AEsyntax)
  - [パッケージの情報の取得](#%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E6%83%85%E5%A0%B1%E3%81%AE%E5%8F%96%E5%BE%97)
  - [`apt install --reinstall`の使用用途](#apt-install---reinstall%E3%81%AE%E4%BD%BF%E7%94%A8%E7%94%A8%E9%80%94)
  - [不要になったパッケージの削除](#%E4%B8%8D%E8%A6%81%E3%81%AB%E3%81%AA%E3%81%A3%E3%81%9F%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E5%89%8A%E9%99%A4)
  - [パッケージがインストールしたファイル群を確認する](#%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%8C%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%97%E3%81%9F%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E7%BE%A4%E3%82%92%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B)
- [3. リポジトリの設定](#3-%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [`/etc/apt/sources.list`ファイル例](#etcaptsourceslist%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E4%BE%8B)
  - [Syntax](#syntax)
  - [パッケージの一覧](#%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E4%B8%80%E8%A6%A7)
- [4. リポジトリの追加](#4-%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [なぜPPAを使うのか？](#%E3%81%AA%E3%81%9Cppa%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AE%E3%81%8B)
  - [Syntax](#syntax-1)
  - [リポジトリの削除](#%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E5%89%8A%E9%99%A4)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. パッケージ管理とは

Linuxではパッケージという単位でソフトウェアを管理しています。パッケージにはいろいろな種類があります。Debian GNU/LinuxやUbuntuではDebian形式,`.deb`拡張子のパッケージを採用しています。


Fig 1:パッケージの概念
<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20201220-linux-packages-diagram.png?raw=true">

なお、Debian形式パッケージは`ar`, `tar`, and `xz`といった古典的UNIXコマンドしか使えない環境でも展開できるように設計されています. 
基本的にはDebian形式パッケージの展開は`dpkg`, `apt`といったコマンドを使いますが、これらコマンドを誤って削除してしまった時でも、パッケージが展開できなくなるという事態を回避することができます.


### バイナリパッケージの構造

`.deb`パッケージの構成要素を確認してみましょう. Ubuntu用のZoomパッケージを例に確認してみます:

```zsh
% ar t zoom_amd64.deb
debian-binary
control.tar.xz
data.tar.xz
_gpgbuilder
```

これをみるとZoom Debian パッケージは4つのファイルから成り立っています

---|---
debian-binary|.debファイルパッケージフォーマットバージョンのバージョンを示すテキストファイルです
control.tar.xz|パッケージ名やバージョンなどのメタ情報、およびパッケージのインストール前、インストール中、またはインストール後に実行するスクリプトが含まれています
data.tar.xz|パッケージから展開されるすべてのファイルが含まれています. 実行ファイル、ライブラリ、ドキュメントなどがすべて保存されています
_gpgbuilder|GPG Keysの生成関連ファイル

### パッケージの依存関係

`apt-cache show`コマンドをもちいて`gzsip`パッケージの情報を確認してみます.

```zsh
% apt-cache show gzip              
Package: gzip
Architecture: amd64
Version: 1.10-0ubuntu4
Priority: required
Essential: yes
Section: utils
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Bdale Garbee <bdale@gag.com>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 245
Pre-Depends: libc6 (>= 2.17)
Depends: dpkg (>= 1.15.4) | install-info
Suggests: less
Filename: pool/main/g/gzip/gzip_1.10-0ubuntu4_amd64.deb
...
```

依存関係について、以下の記述が確認できます.

```
Pre-Depends: libc6 (>= 2.17)
Depends: dpkg (>= 1.15.4) | install-info
```

この情報がどのように取得しているかというと`control.tar.xz`の情報を読み込んで表示しています. `>=` という記号がありますが、これはどのversionを許容しているかを示します.

- `<<`: より低いことを意味します
- `<=`: 以下を意味します
- `=`: 等しいことを意味します (「2.6.1」は「2.6.1-1」と等しくありません)
- `>=`: 以上を意味します
- `>>`: より高いことを意味します。

また、`|`という記号は論理演算の OR を示しています. ANDの場合は `,` で表現されます. Pre-dependsとDependsの違いは前者のほうが後者より強い依存関係と理解するのが良いです. 通常の依存関係, `Depends`とは、依存関係が記述されたパッケージの設定前に、依存関係にあるパッケージの展開および設定を行わなければいけないことを示しています. 先行依存, `Pre-Depends`とは、先行依存関係が記述されたパッケージのインストール前スクリプトの実行前 (インストールの前) に、先行依存関係にあるパッケージの展開および設定を行わなければいけないことを規定しています.

### Debian系OSのパッケージマネジャー: なぜaptが便利なのか？

Debian形式のパッケージを管理するにあたって、パッケージのインストールや削除だけに限れば`dpkg`コマンドを使うだけで十分ですが、上で見たようにパッケージには相互に依存関係があります. 手動で管理するのは大変ですが、そこのところをうまい具合に対応した上でパッケージを管理してくれるソフトウェアがAPTです. なお、`apt install`コマンドでパッケージをインストールするとき、実際にはバックエンドでdpkgを使用してそれを実現しています. 

なお、「パッケージのインストールや削除」の機能を担当するパッケージマネジャーを「低レベル」と分類し、「依存関係やメタデータ検索」の機能を担当するパッケージマネジャーを「高レベル」と分類します.

---|---
`dpkg`|低レベルパッケージマネジャー, 依存関係の問題が出てきた場合エラーメッセージの出力のみ
`apt`|高レベルパッケージマネジャー（低レベルの機能もカバーしているが、内部で`dpkg`を利用している）

dpkg はシステムツール (バックエンド)、apt はユーザに近いツールという感じです. 


> もしパッケージマネジャーがない世界だったら

任意のソフトウェアを今利用している環境にインストールする場合、作業者は以下のことを実行する必要があります:

- readmeを読んで、必要なコンポーネントやバイナリ, コンパイラの一覧を把握 & インストール
- updateに伴うbug修正情報を確認する
- configスクリプト, Makefileを読み込み、どのような手順でbuildするか実行計画を立てる
- 環境差異問題の対処をする
- `build`実行時にでてくるエラーに対処（原因究明など）

## 2. APT

APT(Advanced Packaging Tool)はDevian系ディストリビューションで使われているパッケージ管理システムです。依存関係を自動的に調整しながら、パッケージのインストールやアップデート、削除を行います。APTでは、あらかじめ設定されたリポジトリからパッケージとパッケージの情報を取得します。リポジトリとは、ファイルやデータを集積している場所、及びその情報を管理しているデータベースを意味します。APTを使うには、まず、利用可能なパッケージリストを更新する必要があります。インストールやアップデートに必要なファイルは、インターネット上のリポジトリから自動的にダウンロードされますが、その最新情報を取得する必要があるからです。

<img src="https://raw.githubusercontent.com//ryonakimageserver/omorikaizuka//master/linux/packages/20201222_apt_packages_system.png">

### aptコマンドのSyntax

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
|`search`|正規表現を使ってキーワードを設定することで、パッケージの説明文を参照しながらパッケージを探すことができます<br><br>パッケージの説明文ではなく、パッケージに含まれているファイル名で検索したい場合は`apt-file`コマンド、または`dpkg`コマンドを使用|
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


### パッケージの情報の取得

パッケージの情報は`show`サブコマンドで表示できます、リポジトリにあるパッケージであれば、インストールされているかどうかにかかわらず表示できます。VScodeのパッケージ情報を表示してみます。

```zsh
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

```zsh
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

### `apt install --reinstall`の使用用途

パッケージをインストールしたあとで、重要な構成ファイルを削除してしまったとします。そのファイルだけを取得するために再インストールしようとしても、システム的にはすでにインストールされているので、そのままでは上書きインストールができません。このときに`apt install --reinstall`を用います。

postfixパッケージを再インストールする場合：

```
% sudo apt install --reinstall postfix
```

### 不要になったパッケージの削除

`man`コマンドで`apt`を見てみると、パッケージ削除に関して以下のような記述が確認できます.

```zsh
% man apt
install, reinstall, remove, purge (apt-get(8))
           Performs the requested action on one or more packages specified via
           regex(7), glob(7) or exact match. The requested action can be overridden
           for specific packages by appending a plus (+) to the package name to
           install this package or a minus (-) to remove it.

           A specific version of a package can be selected for installation by
           following the package name with an equals (=) and the version of the
           package to select. Alternatively the version from a specific release can
           be selected by following the package name with a forward slash (/) and
           codename (buster, bullseye, sid ...) or suite name (stable, testing,
           unstable). This will also select versions from this release for
           dependencies of this package if needed to satisfy the request.

           Removing a package removes all packaged data, but leaves usually small
           (modified) user configuration files behind, in case the remove was an
           accident. Just issuing an installation request for the accidentally
           removed package will restore its function as before in that case. On the
           other hand you can get rid of these leftovers by calling purge even on
           already removed packages. Note that this does not affect any data or
           configuration stored in your home directory.
```

`apt remove <package name>`によって不要となったパッケージを削除することができますが、ユーザー設定ファイルなどの関連ファイルは残ってしまいます. 設定ファイルも含めて削除したい場合は、`apt purge <package name>`を実行します. ただし、この場合も依存関係上不要となったパッケージは残り続けます. 依存関係上参照されてなくなったパッケージを除去したい場合は`apt autoremove`コマンドを実行します. 実際にサービスとして使っているパッケージも削除されたというケースもあるので、注意が必要です.

```zsh
% man apt
autoremove (apt-get(8))
           autoremove is used to remove packages that were automatically installed
           to satisfy dependencies for other packages and are now no longer needed
           as dependencies changed or the package(s) needing them were removed in
           the meantime.

           You should check that the list does not include applications you have
           grown to like even though they were once installed just as a dependency
           of another package. You can mark such a package as manually installed by
           using apt-mark(8). Packages which you have installed explicitly via
           install are also never proposed for automatic removal.
```

> Autoremoveの実行結果を事前に確認する

```zsh
% apt autoremove --just-print    
NOTE: This is only a simulation!
      apt needs root privileges for real execution.
      Keep also in mind that locking is deactivated,
      so don't depend on the relevance to the real current situation!
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be REMOVED:
  libevent-core-2.1-7 libevent-pthreads-2.1-7 libopts25 sntp
0 upgraded, 0 newly installed, 4 to remove and 67 not upgraded.
Remv sntp [1:4.2.8p12+dfsg-3ubuntu4.20.04.1]
Remv libevent-pthreads-2.1-7 [2.1.11-stable-1]
Remv libevent-core-2.1-7 [2.1.11-stable-1]
Remv libopts25 [1:5.18.16-3]
```

### パッケージがインストールしたファイル群を確認する

パッケージがインストールしたファイルの確認は「低レベル」パッケージマネジャーの担当領域なので、`dpkg`コマンドを用います.
一例として、

```zsh
% dpkg -L vim   
/.
/usr
/usr/bin
/usr/bin/vim.basic
/usr/share
/usr/share/bug
/usr/share/bug/vim
/usr/share/bug/vim/presubj
/usr/share/bug/vim/script
/usr/share/doc
/usr/share/doc/vim
/usr/share/doc/vim/NEWS.Debian.gz
/usr/share/doc/vim/changelog.Debian.gz
/usr/share/doc/vim/copyright
/usr/share/lintian
/usr/share/lintian/overrides
/usr/share/lintian/overrides/vim
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

## 4. リポジトリの追加

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


## References

- [APT公式ウェブサイト](https://tracker.debian.org/pkg/apt)
- [Debianパッケージ管理](https://www.debian.org/doc/manuals/debian-reference/ch02.ja.html)
- [Debian 管理者ハンドブック](https://debian-handbook.info/browse/ja-JP/stable/index.html)
- [Launchpad](https://launchpad.net/)
