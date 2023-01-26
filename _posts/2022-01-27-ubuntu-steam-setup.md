---
layout: post
title: "Ubuntu 20.04 LTSでメタルギアソリッドVをやりたい"
subtitle: "Ubuntu Desktop環境構築: Steam編 1/N"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
tags:

- Ubuntu 20.04 LTS
- Steam
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
- [Dependency](#dependency)
- [そもそもSteamってなに？](#%E3%81%9D%E3%82%82%E3%81%9D%E3%82%82steam%E3%81%A3%E3%81%A6%E3%81%AA%E3%81%AB)
- [ゲーム環境構築](#%E3%82%B2%E3%83%BC%E3%83%A0%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89)
  - [Steamのインストール](#steam%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [Steamの初期設定](#steam%E3%81%AE%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
  - [コントローラーの接続と設定](#%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9%E3%83%BC%E3%81%AE%E6%8E%A5%E7%B6%9A%E3%81%A8%E8%A8%AD%E5%AE%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## やりたいこと

- WindowsじゃなくてUbuntu 20.04 LTSでMGSVをやりたい
- Steamを導入したい

## Dependency

> 実行環境

|項目||
|---|---| 	 
|マシン| HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 32.0 GB|
|GPU| NVIDIA GeForce RTX 2060 SUPER|

```zsh
% lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.3 LTS
Release:        20.04
Codename:       focal
% uname -srvmpio
Linux 5.13.0-27-generic #29~20.04.1-Ubuntu SMP Fri Jan 14 00:32:30 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```

> ハードウェア

|項目|製品|説明|
|---|---|---| 	 
|コントローラー|[Xbox ワイヤレス コントローラー - カーボン ブラック](https://www.microsoft.com/ja-jp/d/xbox-%E3%83%AF%E3%82%A4%E3%83%A4%E3%83%AC%E3%82%B9-%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9%E3%83%BC/8xn59crbsqgz)|Xinput対応コントローラーがほしかったため|
|有線ケーブル|Type-Cケーブル USB3.1 Gen2 YouZippper|コントローラーとPCを接続用|

> その他

- [steam アカウント](https://store.steampowered.com/)

## そもそもSteamってなに？

Steamは、アメリカのValve Corporationによって開発/運営がされているゲーム配信サービス. 

> 利用方法

1. Steamアカウント登録(無料)
2. SteamクライアントをローカルPCにインストール
3. SteamのアカウントとローカルPCを紐付ける
4. Steam経由でローカルPCへゲームソフトをダウンロード
5. Steamクライアント経由でダウンロードしたゲームソフトをプレイ

> Steamの特徴

- Windows/Mac/Linux問わずクライアント自体はどの環境でもインストールすることができる
- ただしSteamクライアント自体がLinuxに対応しているとはいえ, ゲーム自体がLinuxに対応しているとは限らない
- PCが利用条件を満たしているならば、インターネット環境のあるどのPCからでもゲームのインストールやプレイを行うことができる
- Windows専用ソフトも「[Proton](https://www.protondb.com/)」というSteamに組み込まれたソフトを使うことでLinux環境でもプレイできる

> すべてのWindowsゲームがプレイできるのか？

- この答えは残念ながらNo
- なにがUbuntuでプレイできるかは「[ProtonDB](https://www.protondb.com/)」へアクセスしてプレイしたいゲームソフトがプレイ可能化否かチェックすることが必要
- もしゲームソフト自体がLinuxへ対応していた場合は、ProtonDBの確認は不要
- **Ubuntuで動作しなかった場合でもSteamは返金に応じてくれます**（→ see [サポートページ](https://help.steampowered.com/en/)）

> Protonとは？

- Steam上で動作することを目的に作られたValveによるWine魔改造ソフト(完全にWineから独立しているわけではない)
  - Wine自体は, Windowsアプリが動作に必要とするWindows APIをLinux上でも使えるようにする互換レイヤーのこと
  - Wineを使うことでWindows専用アプリが動作したとしても, Windowsそのものを動作させるのではない
- Direct X, Direct3DというMicrosoft御用達グラフィックスAPIをVulkan APIへ翻訳しているソフトみたいな感じ
  - Vulkan APIは3DグラフィックスAPIでGPUなどを制御している

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20220127_wine_image.png?raw=true">


> Dockerコンテナとかでコンテナ管理すべきでは？

仰るとおりです... ただ、コンテナ内部からGPU, サウンド, カメラ, ゲームコントローラーを認識させる設定がめんどくさいので今回は割愛しました.(see [docker-steam](https://github.com/mikenye/docker-steam))

## ゲーム環境構築
### Steamのインストール

SteamのUbuntuへのインストール方法は２つあります:

1. Ubuntu package repositoryから`apt`経由でインストール
2. マニュアルでOfficial steam packageをダウンロード&インストール

どちらの手法が良いかは個人の好みに依存しますが、メリット/デメリットとしては以下のようなものがある：

||メリット|デメリット|
|---|---|---|
|apt経由インストール|package依存関係やversionコントロールが楽<br>パッケージ情報確認も`show`コマンドで楽|利用できるversionが必ずしも最新版ではない|
|マニュアルインストール|公式サイトが出している最新&信頼できるインストーラーを使える|依存関係管理がめんどくさい<br>インストールのときのCLI経由での入力が少し多い<br>CPUに合わせたインストールがめんどくさそう|

FYI: 僕は手法1「apt経由インストール」でゲーム環境を構築しました.

> 手法1: apt経由インストール

STEP 1: `multiverse` Ubuntu repositoryを追加します

```zsh
% sudo add-apt-repository multiverse
% sudo apt update
```

STEP 2: Steamをインストール

```zsh
% sudo apt install steam
```

パッケージ情報の確認をしたい場合は

```zsh
% apt show steam
Package: steam:i386
Version: 1:1.0.0.61-2ubuntu3
Priority: extra
Section: multiverse/games
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian Games Team <pkg-games-devel@lists.alioth.debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 4,504 kB
Pre-Depends: debconf
Depends: libgl1-mesa-dri (>= 17.3) | libtxc-dxtn0, libgl1-mesa-glx, libgpg-error0 (>= 1.10), libudev1, libxcb-dri3-0 (>= 1.11.1), libxinerama1 (>= 2:1.1.1), xz-utils, debconf (>= 0.5) | debconf-2.0, libc6 (>= 2.15), libstdc++6 (>= 4.8), libx11-6
Recommends: steam-devices, ca-certificates, fontconfig, fonts-liberation, libxss1, mesa-vulkan-drivers, xterm | x-terminal-emulator
Suggests: libnvidia-gl-390 | libnvidia-gl-435 | libnvidia-gl-440
Conflicts: steam-launcher
Replaces: steam-launcher
Homepage: https://steamcommunity.com/linux
Download-Size: 1,451 kB
APT-Manual-Installed: yes
APT-Sources: http://jp.archive.ubuntu.com/ubuntu focal/multiverse i386 Packages
Description: Valve's Steam digital software delivery system
```

STEP 3: Steamの起動

```zsh
% steam
```

> 手法2: マニュアルでOfficial Steam packageをダウンロード&インストール

STEP 1: `i386` architectureの追加

普通なら64 bit環境のOSを使っていると思いますが、Steamパッケージは32 bitライブラリーに依存しているのでまず、i386アーキテクチャを利用できるように設定

```zsh
% sudo dpkg --add-architecture i386
% sudo apt update
```

STEP 2: 依存関係のあるライブラリをインストール

```zsh
% sudo apt install wget gdebi-core libgl1-mesa-glx:i386
```

- `wget`: ファイルダウンローダー
- `gdebi-core`:  deb packagesインストール時の依存関係解消ツール
- `libgl1-mesa-glx`: グラフィック関係パッケージ

STEP 3: インストーラーのダウンロード

```zsh
% wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb
```

STEP 4: Steamをインストール

```zsh
% sudo gdebi ~/steam.deb
```

STEP 5: Steamを起動

```zsh
% steam
```

### Steamの初期設定

> Protonの有効化

LinuxでWindowsゲームをプレイするためには、Protonなどのソフトを利用しなくてはならず、そのソフトの多くがベータ版機能でないと利用できません. そのため、`Steam -> Settings -> Account`でBeta Participationを「Steam Beta Update」(ベータ版への参加)へ変更.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220127-02.png?raw=true">


その後、`Steam -> Settings -> Steam Play`へ移動し、「Enable Steam Play for supported titles and Enable Steam Play for all other titles」をクリックします. これをクリックすることで、WindowsゲームをUbuntuでプレイできるようになります. そして、最後にProton versionを選択します. 自分はExperimentalを選択していますが、Windowsゲームが動作しなかった場合は、ProtonDBの内容を参考にversion設定を変更することが初手として推奨されてる.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220127-01.png?raw=true">


### コントローラーの接続と設定

UbnuntuでSteamを利用する場合、ソフトが対応しているコントローラーの種類を確認することが推奨されます. コントローラーにはDirectInput形式とXinput形式の２つがあります. なお、今回のMGSVはXinput形式のコントローラーが推奨されてる.

> DirectInput形式

- 従来からあるゲームパッドの規格
- 標準状態ではNintendo Switch用コントローラー及びPS4コントローラーはDirectInputで動作します

はじめはNintendo Switch用コントローラーでのプレイを試みましたが、設定に挫折しました. MGSVを起動しても上手く認識してくれず、キーマップを頑張って設定しようとしましたが挫折. 

> Xinput形式

- 最新のオンラインゲームやGames for Windows®タイトル、Xbox360®とPCのクロスプラットフォームのゲームなどで採用されている新規格
- Nintendo Switch用コントローラー及びPS4コントローラーをXinput形式で利用するためには別途ドライバーを導入する必要があります

[Xbox ワイヤレス コントローラー - カーボン ブラック](https://www.microsoft.com/ja-jp/d/xbox-%E3%83%AF%E3%82%A4%E3%83%A4%E3%83%AC%E3%82%B9-%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9%E3%83%BC/8xn59crbsqgz)はXinput形式に対応しており、利用はBluetoothなり有線で接続するだけで完了しました.

## References

- [Steam](https://store.steampowered.com/)
- [Ryo's Tech Blog > Ubuntu環境構築基礎知識：APTによるパッケージ管理](https://ryonakagami.github.io/2020/12/20/packages-manager-apt-command/)
- [docker-steam](https://github.com/mikenye/docker-steam)