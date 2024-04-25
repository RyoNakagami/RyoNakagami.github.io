---
layout: post
title: "ターミナル環境の構築: Terminatorのインストール"
subtitle: "Shell Environement Set-up 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2023-08-01
tags:

- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Overview](#overview)
- [What is Gnome-Terminator?](#what-is-gnome-terminator)
  - [Features: Terminal出力結果に対して検索](#features-terminal%E5%87%BA%E5%8A%9B%E7%B5%90%E6%9E%9C%E3%81%AB%E5%AF%BE%E3%81%97%E3%81%A6%E6%A4%9C%E7%B4%A2)
  - [Features: Setting Titles](#features-setting-titles)
- [Terminatorのインストール](#terminator%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [Configuration](#configuration)
- [Tips: Short cuts](#tips-short-cuts)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Overview

**What I Want**

- `Terminator`を用いたターミナル環境の構築

Default TerminalだとTab分割は可能だが, Window分割ができません. 
Terminatorだと

- 軽量動作(Pythonベースだけど...)
- 画面分割
- レイアウトの設定

が簡単にできるので今回採用.

**What Did I Do?**

1. Terminatorのインストール
2. Terminatorのレイアウト設定

## What is Gnome-Terminator?

Ubuntu 20.04にはデフォルトでGnome Terminalがインストールされていますが, こちらはTabを増やすことはできますが以下のように画面分割で用いることができません. 一方, TerminatorというTerminal emulatorでは簡単なキーバインディングで分割が可能です.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/terminal/20201224_terminal_terminator.png?raw=true">

---|---
Split terminal Vertically|`shift`+`ctrl` + `e`
Split terminal Horizontally|`shift`+`ctrl` + `o`
Focus to Next/Previous terminal|`shift`+`ctrl` + `n`/`p`

ただし, 軽量といえどもメモリもDefaultのGnome Terminalよりも余分に必要とします.
また, SSH接続を利用してリモートサーバーで作業する際に画面分割する場合はtmuxを利用することがどちらにしろ必要です.

### Features: Terminal出力結果に対して検索

出力画面のバッファーに対して, `Ctrl+Shift+F`でSearchが可能です. あくまでバッファー部分なので, 
`grep`を利用した上で最後に簡易に検索したい場合が多いと思いますが, `man`コマンドで出力したマニュアルにも検索がかけられるので, `grep`が利用しづらいときに重宝するかもしれません.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/blog/Ubuntu/terminator-search.png?raw=true">

### Features: Setting Titles

マウス or ショートカットでWindowsやTabのtitle settingsが可能です.

|Edit 	|Mouse  |Shortcut|
|---|---|---|
|Window title| N/A 	|`ctr`l+`alt`+`w`|
|Tab title 	|double-click tab 	|`ctrl`+`alt`+`a`|
|Terminal title| 	double-click titlebar 	|`ctrl`+`alt`+`x`|


## Terminatorのインストール

公式ドキュメントに従いPPA for Ubuntu 20.04からrepositoryを追加してinstallを実施する

```zsh
## you may not need to run this line
% sudo add-apt-repository ppa:mattrose/terminator

## install
% sudo apt update
% sudo apt install terminator
```

次にインストールされたバージョンを念の為確認する

```zsh
% apt-cache policy terminator
terminator:
  Installed: 2.1.1-1
  Candidate: 2.1.1-1
  Version table:
 *** 2.1.1-1 500
        500 http://jp.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages
        500 http://jp.archive.ubuntu.com/ubuntu jammy/universe i386 Packages
        100 /var/lib/dpkg/status
```

## Configuration

Terminatorの設定情報は`~/.config/terminator/config`に格納されています.

```zsh
% cat ~/.config/terminator/config
[global_config]
  dbus = False
  title_transmit_fg_color = "#000000"
  title_transmit_bg_color = "#c0bfbc"
  title_inactive_bg_color = "#77767b"
[keybindings]
  reset_clear = ""
  broadcast_off = <Shift><Super>b
  broadcast_all = <Super>b
  insert_number = ""
  insert_padded = ""
  help = ""
[profiles]
  [[default]]
    background_color = "#300a24"
    background_darkness = 0.39
    cursor_color = "#aaaaaa"
    foreground_color = "#ffffff"
    palette = "#000000:#cc0000:#4e9a06:#c4a000:#3465a4:#75507b:#06989a:#d3d7cf:#555753:#ef2929:#8ae234:#fce94f:#729fcf:#ad7fa8:#34e2e2:#eeeeec"
[layouts]
  [[default]]
    [[[window0]]]
      type = Window
      parent = ""
    [[[child1]]]
      type = Terminal
      parent = window0
[plugins]

```

上記ではショートカットコマンドの一部Disable設定及び色の設定に留めています.

## Tips: Short cuts

`Preferences > Keybindings`からも確認できますが代表的なものを紹介します.

> 移動

|Action| Default Shortcut|
|---|---|
|行頭への移動|`Ctrl+A`|
|行末に移動|`Ctrl+E`|
|行頭まで削除|`Ctrl+U`|
|行末まで削除|`Ctrl+K`|
|ワード単位で行頭方向の文字列を削除|`Ctrl+W`|

> Terminal split/move/close

|Action| Default Shortcut|
|---|---|
|Split terminal Horizontally|`Shift+Ctrl+E`|
|Split terminal Vertically|`Shift+Ctrl+O`|
|分割されたterminalの移動|`Ctrl+Tab`|
|分割されたterminalの移動(前)|`Shift+Ctrl+Tab`|
|Close window|`Shift+Ctrl+Q`|
|Close terminal|`Shift+Ctrl+W`|
|Terminatorの起動|`Ctrl+Alt+T`|

References
----

- [Installing Terminator](https://github.com/gnome-terminator/terminator/blob/master/INSTALL.md)
- [Terminator GitHub Project](https://github.com/gnome-terminator/terminator)
- [Terminator Document](https://terminator-gtk3.readthedocs.io/en/latest/)|