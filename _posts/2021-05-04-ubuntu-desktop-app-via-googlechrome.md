---
layout: post
title: "Google Chrome経由でLINEをDesktop Appのように使う"
subtitle: "Ubuntu Desktop環境構築 Part 22"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- App
---




<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Chromeの拡張機能でLINEを追加する](#chrome%E3%81%AE%E6%8B%A1%E5%BC%B5%E6%A9%9F%E8%83%BD%E3%81%A7line%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)
  - [環境](#%E7%92%B0%E5%A2%83)
  - [前提](#%E5%89%8D%E6%8F%90)
  - [LINEをDesktopアプリ化する](#line%E3%82%92desktop%E3%82%A2%E3%83%97%E3%83%AA%E5%8C%96%E3%81%99%E3%82%8B)
  - [(opt) LINEのアイコンをLINEぽく変える](#opt-line%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%82%92line%E3%81%BD%E3%81%8F%E5%A4%89%E3%81%88%E3%82%8B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Chromeの拡張機能でLINEを追加する

### 環境

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

### 前提
UbuntuにはLINE APPはないのでGoogle Chromeの拡張機能を用いて、LINEを追加することを試みます.

1. chrome ウェブストア-lineでLINEを追加
2. `chrome://extensions/`にアクセスし、LINEのディベロッパーモードをONにする
3. `ID`をコピーする

### LINEをDesktopアプリ化する

1. Google chromeでLINEを開く
2. `設定 >> More tools >> Create shortcut`を選択
3. (opt) ウィンドウとして開くにチェック

完了後、`~/.local/share/applications/`以下に、chrome extension id(以下、`<app-id>`)に`chrome-<app-id>-Default.desktop`が作成されています. このオブジェクトはショートカットwindowの設定ファイルとなります.

### (opt) LINEのアイコンをLINEぽく変える

- デフォルトではLINEのアイコンがLINEぽくないので、`~/.local/share/applications/chrome-<app-id>-Default.desktop`のアイコン項目を設定します
- 基本的には、LINEぽい画像ファイルをどこから探して、そのPATHを設定すればよい形になります


今回は、`/home/"username"/.config/google-chrome/Default/Extensions/<app-id>/<app-ver>/res/img/line_logo_128x128_on.png`をもちいます.

> EXAMPLE : `chrome-<app-id>-Default.desktop`

```zsh
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Name=LINE
Exec=/opt/google/chrome/google-chrome --profile-directory=Default --app-id=<app-id>
Icon=<画像ファイルPATH>
StartupWMClass=crx_<app-id>
```
