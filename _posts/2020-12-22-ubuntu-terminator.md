---
layout: post
title: "Ubuntu Desktop環境構築 Part 9"
subtitle: "ターミナル環境の構築: Terminatorのインストール"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Terminal
---

||概要|
|---|---|
|目的|ターミナル環境の構築: Terminatorのインストール|
|参考|[Installing Terminator](https://github.com/gnome-terminator/terminator/blob/master/INSTALL.md)<br>[Terminator GitHub Project](https://github.com/gnome-terminator/terminator)<br>[Terminator Document](https://terminator-gtk3.readthedocs.io/en/latest/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [方針](#%E6%96%B9%E9%87%9D)
- [2. Bleachbitとは？](#2-bleachbit%E3%81%A8%E3%81%AF)
  - [Use case](#use-case)
- [3. Bleachbitのインストール](#3-bleachbit%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Bleachbit使用方針](#4-bleachbit%E4%BD%BF%E7%94%A8%E6%96%B9%E9%87%9D)
  - [DOM Storageとは](#dom-storage%E3%81%A8%E3%81%AF)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

`Terminator 2.0.1`を用いたターミナル環境の構築

### 方針

1. Terminator 2.0.1のインストール
2. Terminatorのレイアウト設定
3. 便利ショートカットコマンドの確認

## 2. Terminatorとは

Ubuntu 20.04にはデフォルトでGnome Terminalがインストールされていますが、こちらはTabを増やすことはできますが以下のように画面分割で用いることができません。一方、TerminatorというTerminal emulatorではこの機能が備わっています。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/terminal/20201224_terminal_terminator.png?raw=true">

### Features

- 画面分割
- トグル可能
- Terminal出力結果に対して検索可能
- shortcuts機能の充実
- Pythonで書かれてる
- version 1.9.0からGTK3を使用

### デメリット

- 立ち上がりが少し遅い（立ち上がりラグは１秒もなく、あまり意識されない）
- メモリもDefaultのGnome Terminalよりも余分に必要とする
- サーバーで使うならtmux(端末マルチプレクサーなのですこし異なる)
- リモートからSSH接続したときでも画面分割したいなら、tmux

### 立ち上がり時間の比較

GNOME-Terminal:
```
idiot@village:~$ time for i in {1..30} ; do gnome-terminal --profile=Quickexit; done

real    0m10.606s
```

Terminator:
```
idiot@village:~$ time for i in {1..30} ; do terminator -g deletemeconfig -p Quickexit; done

GTK3: real    0m10.885s Yeah, basically identical!
```

### Cold start時のたちあがり時間の比較

GNOME-Terminal:
```
idiot@village:~$ time gnome-terminal --profile=Quickexit

real    0m7.628s (approx median, there was a strange variance for GT, between 5 and 9 secs)
```

Terminator
```
idiot@village:~$ time terminator -g deletemeconfig -p Quickexit

GTK3: real    0m11.264s (median of 3x)
```

### Memory useの比較

GNOME-Terminal:
```
root@pinpoint:~# sync && echo 3 > /proc/sys/vm/drop_caches && free           # Before startup
             total       used       free     shared    buffers     cached
Mem:       3102404    1388776    1713628       4052        164      45340
-/+ buffers/cache:    1343272    1759132
Swap:      3121996     788704    2333292
root@pinpoint:~# sync && echo 3 > /proc/sys/vm/drop_caches && free          # After startup
             total       used       free     shared    buffers     cached
Mem:       3102404    2439524     662880      57196       1240      99212
-/+ buffers/cache:    2339072     763332
Swap:      3121996     751440    2370556
root@pinpoint:~# sync && echo 3 > /proc/sys/vm/drop_caches && free          # After kill
             total       used       free     shared    buffers     cached
Mem:       3102404    1466536    1635868       4796        160      45912
-/+ buffers/cache:    1420464    1681940
Swap:      3121996     751020    2370976

Used (used mem -buffers/cache + swap)
    Before start: 2131976
    After start : 3090512 = 958536 kbytes, 936 Mbytes / 9.36 MBytes/instance
    After kill  : 2171484 =  39508 kbytes,  38 Mbytes not recovered
```

Terminator
```
root@pinpoint:~# sync && echo 3 > /proc/sys/vm/drop_caches && free
             total       used       free     shared    buffers     cached
Mem:       3102404    1313456    1788948       4284        152      43844
-/+ buffers/cache:    1269460    1832944
Swap:      3121996     736844    2385152
root@pinpoint:~# sync && echo 3 > /proc/sys/vm/drop_caches && free
             total       used       free     shared    buffers     cached
Mem:       3102404    2866552     235852      19484       1084      65408
-/+ buffers/cache:    2800060     302344
Swap:      3121996     736340    2385656
root@pinpoint:~# sync && echo 3 > /proc/sys/vm/drop_caches && free
             total       used       free     shared    buffers     cached
Mem:       3102404    1317724    1784680       4284        152      43464
-/+ buffers/cache:    1274108    1828296
Swap:      3121996     736304    2385692

Used (used mem -buffers/cache + swap)
    before start: 2006304
    after start : 3536400 = 1530096 kbytes, 1494 Mbytes / 14.94 MBytes/instance
    after kill  : 2010412 =    4108 kbytes,    4 Mbytes not recovered
```

## 3. Terminatorのインストール

公式ドキュメントに従いPPA for Ubuntu 20.04からrepositoryを追加してinstallを実施する

```
$ sudo add-apt-repository ppa:mattrose/terminator
$ sudo apt update
$ sudo apt install terminator
```

次にインストールされたバージョンを念の為確認する

```
$ apt-cache policy terminator
terminator:
  Installed: 2.0.1-1-0ubuntu3
  Candidate: 2.0.1-1-0ubuntu3
  Version table:
 *** 2.0.1-1-0ubuntu3 500
        500 http://ppa.launchpad.net/mattrose/terminator/ubuntu focal/main amd64 Packages
        500 http://ppa.launchpad.net/mattrose/terminator/ubuntu focal/main i386 Packages
        100 /var/lib/dpkg/status
     1.91-4ubuntu1 500
        500 http://jp.archive.ubuntu.com/ubuntu focal/universe amd64 Packages
        500 http://jp.archive.ubuntu.com/ubuntu focal/universe i386 Packages
```

## 4. Layoutの設定

Layoutやショートカットは`右クリック>Preferences`から設定することができます。今回はGNOME-Terminalと同じ色にする設定をします。

### 手順

1. `Preferences > Profiles > Colors`
2. Built-in schemesをCustomに変更し、Background Colorを GNOME-Terminalと同様に`#300a24`と設定します。
3. Closeして設定が反映されているか確認します。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/terminal/20201225_terminator_backgroundcolor.png?raw=true">

## 5. Short cuts

Terminator特有以外のもの記載する。

|Action| Default Shortcut|
|---|---|
|Copy|`Shift+Ctrl+C`|
|Paste|`Shift+Ctrl+V`|
|文字列での実行コマンド履歴検索|`Ctrl+R`|
|文字列での出力結果検索|`Ctrl+Shift+F`|
|Split terminal Horizontally|`Shift+Ctrl+E`|
|Split terminal Vertically|`Shift+Ctrl+O`|
|分割されたterminalの移動|`Shift+Ctrl+Tab`|
|Close window|`Shift+Ctrl+Q`|
|Close terminal|`Shift+Ctrl+W`|
|Terminatorの起動|`Ctrl+Alt+T`|
|トグル|`F12`|
|全画面表示と解除|`F11`|

## Appendix: Cold startとは？

システム障害が発生したときにシステムを初期状態に戻して再開する方法で,更新前コピー又は更新後コピーの前処理を伴わないシステム開始のことです。初期プログラムロードとも呼ばれます。システム障害発生時の復旧方法には全くの初期状態（電源を切った状態）から復旧させるコールドスタート、電源を入れたまま再起動を行うウォームスタート、ログ情報を元にトランザクション更新前の状況に戻すロールバック、トランザクション更新後に戻すロールフォワードがあります。