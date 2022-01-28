---
layout: post
title: "マルチディスプレイ設定と時計表示をはじめとする拡張機能とDockの設定"
subtitle: "Ubuntu Desktop環境構築 Part 3"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
uu_cnt: 200
session_cnt: 1000
tags:

- Ubuntu 20.04 LTS
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回設定する項目](#1-%E4%BB%8A%E5%9B%9E%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B%E9%A0%85%E7%9B%AE)
- [2. マルチディスプレイ設定](#2-%E3%83%9E%E3%83%AB%E3%83%81%E3%83%87%E3%82%A3%E3%82%B9%E3%83%97%E3%83%AC%E3%82%A4%E8%A8%AD%E5%AE%9A)
  - [Login後のマルチディスプレイ設定](#login%E5%BE%8C%E3%81%AE%E3%83%9E%E3%83%AB%E3%83%81%E3%83%87%E3%82%A3%E3%82%B9%E3%83%97%E3%83%AC%E3%82%A4%E8%A8%AD%E5%AE%9A)
  - [Login前のマルチディスプレイ設定](#login%E5%89%8D%E3%81%AE%E3%83%9E%E3%83%AB%E3%83%81%E3%83%87%E3%82%A3%E3%82%B9%E3%83%97%E3%83%AC%E3%82%A4%E8%A8%AD%E5%AE%9A)
- [3. 時計表示を右寄せする](#3-%E6%99%82%E8%A8%88%E8%A1%A8%E7%A4%BA%E3%82%92%E5%8F%B3%E5%AF%84%E3%81%9B%E3%81%99%E3%82%8B)
  - [拡張機能のインストール](#%E6%8B%A1%E5%BC%B5%E6%A9%9F%E8%83%BD%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Removable Drive Menu](#4-removable-drive-menu)
- [5. Dockの設定](#5-dock%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回設定する項目

|項目|説明|
|---|---|
|マルチディスプレイ設定|Login前と後のディスプレイ表示設定|
|Frippery Move Clock|時計表示設定, GNOME拡張機能|
|Removable Drive Menu|外付けハードディスクやDVDなどのマウント／アンマウントを操作するためのGNOME Shell 拡張機能|

> 環境


```
% lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.3 LTS
Release:        20.04
Codename:       focal
% uname -srvmpio
Linux 5.13.0-27-generic #29~20.04.1-Ubuntu SMP Fri Jan 14 00:32:30 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```

## 2. マルチディスプレイ設定

Login前とLogin後の二つのディスプレイの設定の必要があります。

### Login後のマルチディスプレイ設定

1. `Settings`から`Display`をクリック。
2. 好きなように設定する
3. 保存

このモニターの設定は`~/.config/monitors.xml`に保存されている。

### Login前のマルチディスプレイ設定

- この項目は`Login後のマルチディスプレイ設定`が完了してから実施してください。

Login後のディスプレイ設定をLogin前の段階にも適用したい場合は追加の作業が必要となります。Ubuntu 20.04 LTSはGnomeベースなのでGnome用のディスプレイマネジャー`GDM3`ベースで話を進めます。

Login前のディスプレイ表示は`/var/lib/gdm3/.config/monitors.xml`にて設定することができます。GUI機能はまだ実装されていないので、こちらのファイルを直接編集する必要があります。Login後と同じ設定で良い場合は、次のコマンドで終了です。

```
$ cp ~/.config/monitors.xml /var/lib/gdm3/.config/monitors.xml
```

その後、`reboot`を実行して、設定が反映されているかどうか確認します。

## 3. 時計表示を右寄せする

方針はトップバー中央に位置している時計表示をトップバー右寄せで表示させることです。イメージは以下、

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201211_ubuntu_time.jpg?raw=true">

Desktopの表示をいじりたい場合はGNOMEという「デスクトップ作業を行うのに必要なソフトウェアのセット」の設定を編集することになります。今回の時計表示変更はGNOMEの拡張機能である`Frippery Move Clock`を用います。

### 拡張機能のインストール

GNOME Shell と Webブラウザを結びつけるプログラム (chrome-gnome-shell) をインストールする必要があります。

```
$ sudo apt install -y chrome-gnome-shell
```

その後、拡張機能をインストール & rebootします。

```
$ sudo apt install gnome-shell-extensions
$ reboot
```

次にFirefoxを立ち上げる。するとツールバーの右上に足跡マーク見たいのがあるのでそれをクリック。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201211_how-to-install-gnome-shell-extensions-on-ubuntu-20-04-focal-fossa-linux-desktop.png?raw=true">

そして、`Frippery Move Clock`を検索してFrippery Move Clockをクリック。`OFF`となっているものを`ON`とすれば完了。


## 4. Removable Drive Menu

アイコンをクリックすると、マウントしているデバイスやパーティション一覧が表示されます。リストからデバイス名の選択でファイルマネージャで開く、矢印アイコンをクリックでアンマウントできます。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201211_removable_drive_menu.png?raw=true">

## 5. Dockの設定

Settings > Appearanceで設定可能。

## References

- [Frippery Move Clock](https://extensions.gnome.org/extension/2/move-clock/)
