---
layout: post
title: "Ubuntu 20.04 LTS マルチディスプレイ設定"
subtitle: "Ubuntu Desktop環境構築 Part 3"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-22
tags:

- Ubuntu 20.04 LTS
---




**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回設定する項目](#1-%E4%BB%8A%E5%9B%9E%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B%E9%A0%85%E7%9B%AE)
  - [設定可能なモニター数の確認](#%E8%A8%AD%E5%AE%9A%E5%8F%AF%E8%83%BD%E3%81%AA%E3%83%A2%E3%83%8B%E3%82%BF%E3%83%BC%E6%95%B0%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [2. マルチディスプレイ設定](#2-%E3%83%9E%E3%83%AB%E3%83%81%E3%83%87%E3%82%A3%E3%82%B9%E3%83%97%E3%83%AC%E3%82%A4%E8%A8%AD%E5%AE%9A)
  - [Login後のマルチディスプレイ設定](#login%E5%BE%8C%E3%81%AE%E3%83%9E%E3%83%AB%E3%83%81%E3%83%87%E3%82%A3%E3%82%B9%E3%83%97%E3%83%AC%E3%82%A4%E8%A8%AD%E5%AE%9A)
  - [Login前のマルチディスプレイ設定](#login%E5%89%8D%E3%81%AE%E3%83%9E%E3%83%AB%E3%83%81%E3%83%87%E3%82%A3%E3%82%B9%E3%83%97%E3%83%AC%E3%82%A4%E8%A8%AD%E5%AE%9A)
- [3. 時計表示を右寄せする](#3-%E6%99%82%E8%A8%88%E8%A1%A8%E7%A4%BA%E3%82%92%E5%8F%B3%E5%AF%84%E3%81%9B%E3%81%99%E3%82%8B)
  - [拡張機能のインストール](#%E6%8B%A1%E5%BC%B5%E6%A9%9F%E8%83%BD%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Dockの設定](#4-dock%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [Appendix: xrandrコマンド](#appendix-xrandr%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回設定する項目

|項目|説明|
|---|---|
|マルチディスプレイ設定|Login前と後のディスプレイ表示設定|
|Frippery Move Clock|時計表示設定, GNOME拡張機能|
|Removable Drive Menu|外付けハードディスクやDVDなどのマウント／アンマウントを操作するためのGNOME Shell 拡張機能|

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

### 設定可能なモニター数の確認

すでに設定済みの確認となってしまいますが, `xrandr` コマンドでシステムで利用可能な出力端子の名前 (VGA-1, HTMI-1, など) 
と各端子で利用できる解像度を確認できます.

```zsh
% xrandr        
Screen 0: minimum 8 x 8, current 4720 x 1920, maximum 32767 x 32767
DVI-D-0 connected 1080x1920+3640+0 left (normal left inverted right x axis y axis) 531mm x 299mm
   1920x1080     60.00*+  75.00    59.94    50.00  
   1680x1050     59.95  
   1600x1200     60.00  
   1440x900      59.89  
   1366x768      59.79  
   1280x1024     75.02    60.02  
   1280x960      60.00  
   1280x720      60.00    59.94    50.00  
   1152x864      75.00  
   1024x768      75.03    70.07    60.00  
   800x600       75.00    72.19    60.32    56.25  
   720x576       50.00  
   720x480       59.94  
   640x480       75.00    72.81    59.94    59.93  
HDMI-0 connected primary 2560x1440+1080+0 (normal left inverted right x axis y axis) 697mm x 393mm
   2560x1440    143.97*+ 120.00    99.95    59.95  
   3840x2160     59.94  
   1920x1080    119.88    60.00    59.94  
   1680x1050     59.95  
   1440x900      59.89  
   1440x480      59.94  
   1280x1024     75.02    60.02  
   1280x960      60.00  
   1280x720     119.88    60.00    59.94  
   1152x864      75.00  
   1024x768      75.03    70.07    60.00  
   800x600       75.00    72.19    60.32    56.25  
   720x480       59.94  
   640x480       75.00    72.81    59.94    59.93  
DP-0 connected 1080x1920+0+0 right (normal left inverted right x axis y axis) 509mm x 286mm
   1920x1080     60.00*+  59.94    50.00  
   1680x1050     59.95  
   1440x900      59.89  
   1440x576      50.00  
   1440x480      59.94  
   1280x1024     75.02    60.02  
   1280x960      60.00  
   1280x800      59.81  
   1280x720      60.00    59.94    50.00  
   1152x864      75.00  
   1024x768      75.03    70.07    60.00  
   800x600       75.00    72.19    60.32    56.25  
   720x576       50.00  
   720x480       59.94  
   640x480       75.00    59.94    59.93  
DP-1 disconnected (normal left inverted right x axis y axis)
```


## 2. マルチディスプレイ設定

Login前とLogin後の二つのディスプレイの設定の必要があります。

### Login後のマルチディスプレイ設定

1. `Settings`から`Display`をクリック。
2. 好きなように設定 & 保存する

このモニターの設定は`~/.config/monitors.xml`に保存されています.

<img src='https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20201211-display-settings.png?raw=true'>

### Login前のマルチディスプレイ設定

> REMARKS!!

この項目は`Login後のマルチディスプレイ設定`が完了してから実施してください。

> 設定

Login後のディスプレイ設定をLogin前の段階にも適用したい場合は追加の作業が必要となります.
Ubuntu 20.04 LTSはGnomeベースなのでGnome用のディスプレイマネジャー`GDM3`ベースで話を進めます.

Login前のディスプレイ表示は`/var/lib/gdm3/.config/monitors.xml`にて設定することができます.
GUI機能はまだ実装されていないので, こちらのファイルを直接編集する必要があります. 

Login後と同じ設定で良い場合は, 次のコマンドで終了です.

```zsh
% cp ~/.config/monitors.xml /var/lib/gdm3/.config/monitors.xml
```

その後, `reboot`を実行して, 設定が反映されているかどうか確認し終了です.


## 3. 時計表示を右寄せする

方針はトップバー中央に位置している時計表示をトップバー右寄せで表示させることです。イメージは以下、

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201211_ubuntu_time.jpg?raw=true">

Desktopの表示をいじりたい場合はGNOMEという「デスクトップ作業を行うのに必要なソフトウェアのセット」の設定を編集することになります。今回の時計表示変更はGNOMEの拡張機能である`Frippery Move Clock`を用います。

### 拡張機能のインストール

GNOME Shell と Webブラウザを結びつけるプログラム (chrome-gnome-shell) をインストールする必要があります。

```zsh
% sudo apt install -y chrome-gnome-shell
```

その後、拡張機能をインストール & rebootします。

```zsh
% sudo apt install gnome-shell-extensions
% reboot
```

次にFirefoxを立ち上げる。するとツールバーの右上に足跡マーク見たいのがあるのでそれをクリック。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201211_how-to-install-gnome-shell-extensions-on-ubuntu-20-04-focal-fossa-linux-desktop.png?raw=true">

そして、`Frippery Move Clock`を検索してFrippery Move Clockをクリック。`OFF`となっているものを`ON`とすれば完了。


## 4. Dockの設定

Settings > Appearanceで設定可能。


## Appendix: xrandrコマンド

xrandr は RandR("Resize and Rotate") X Window System 拡張の公式設定ユーティリティです. 
xrandr を使うことで画面のサイズや向き、反転などを設定できます.


HDMI-1について解像度とリフレッシュレートを設定する例は以下,

```zsh
% xrandr --output HDMI-1 --mode 1920x1080 --rate 60
```

> X Window Systemとは？

そもそもですが, WindowsやMacのように, Window(GUI)を使ってファイルやアプリケーションを操作する機能をWindow Systemといいます.
X Window Systemは, UNIX/Linux環境でGUIを利用するためのWindow Systemです.GNOMEやKDEといった総合デスクトップ環境(=ウィンドウマネージャーを含めた複数のツールの集まり)はX Window Systemをベースとしています.

カーネルとユーザーのやり取りはUNIX/Linux環境ではシェルが基本ですが, X Window Systemもカーネルとユーザーのやり取りの仲介をしてくれるシステムです.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20201211-xserver-xclient.png?raw=true">

## References

- [Frippery Move Clock](https://extensions.gnome.org/extension/2/move-clock/)
