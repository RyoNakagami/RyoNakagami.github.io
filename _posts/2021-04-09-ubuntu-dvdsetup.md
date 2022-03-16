---
layout: post
title: "VLCを使って Ubuntu 20.04 で DVD 視聴"
subtitle: "Ubuntu Desktop環境構築 Part 18"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [VLCとは？](#vlc%E3%81%A8%E3%81%AF)
- [VLCのインストールと起動](#vlc%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%A8%E8%B5%B7%E5%8B%95)
  - [インストール方法](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95)
  - [vlcの起動](#vlc%E3%81%AE%E8%B5%B7%E5%8B%95)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## やりたいこと

- Ubuntu 20.04 で DVD を視聴したい

### VLCとは？

VLCとは動画ファイルや音楽ファイルを再生するメデイアプレイヤーソフトです. 再生対応している規格はMKV, MP4, MPEG, MPEG-2, MPEG-4, DivX, MOV, WMV, QuickTime, WebM, FLAC, MP3, Ogg/Vorbis files, BluRays, DVDs, VCDs, podcastと幅広くカバーされています(see [公式サイト](https://www.videolan.org/vlc/features.html)). 

言及するほどでもないですが、「No spyware, No ads, No user tracking」です.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210409-002.png?raw=true">

## VLCのインストールと起動
### インストール方法

```zsh
% sudo apt install vlc
% sudo apt install libdvd-pkg
% sudo dpkg-reconfigure libdvd-pkg
```

`sudo dpkg-reconfigure libdvd-pkg`コマンドを実行すると、libdvd-pkgの設定のため選択画面が表示される場合がありますが、ここは「Yes」を選択します.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210409-001.png?raw=true">

> dpkg-reconfigureコマンドってなに？

インストール済みパッケージを再設定する際に用いるコマンドです. Syntaxは

```zsh
% dpkg-reconfigure <package name>
```

`dpkg --configure`と`dpkg-reconfigure`どちらも指定したパッケージのコンフィグ設定のコマンドですが、前者はunpacked & unconfiguredのパッケージを対象にしたコマンドであるとこが相違点となります.

なお、すべての`.deb`形式のパッケージの再設定ができるわけでない点に注意が必要です. 以下のコマンドを入力すると、`dpkg-reconfigure`コマンドで再設定が可能なパッケージを調べることができます:

```zsh
% ls /var/lib/dpkg/info/*.config
/var/lib/dpkg/info/adduser.config*           /var/lib/dpkg/info/dictionaries-common.config*     /var/lib/dpkg/info/memtest86+.config*                 /var/lib/dpkg/info/ubuntu-advantage-tools.config*
/var/lib/dpkg/info/apparmor.config*          /var/lib/dpkg/info/gdm3.config*                    /var/lib/dpkg/info/openvpn.config*                    /var/lib/dpkg/info/ubuntu-drivers-common.config*
/var/lib/dpkg/info/ca-certificates.config*   /var/lib/dpkg/info/grub-pc.config*                 /var/lib/dpkg/info/popularity-contest.config*         /var/lib/dpkg/info/ufw.config*
/var/lib/dpkg/info/clamav-freshclam.config*  /var/lib/dpkg/info/iproute2.config*                /var/lib/dpkg/info/postfix.config*                    /var/lib/dpkg/info/unattended-upgrades.config*
/var/lib/dpkg/info/console-setup.config*     /var/lib/dpkg/info/keyboard-configuration.config*  /var/lib/dpkg/info/powerline.config*                  /var/lib/dpkg/info/wamerican.config*
/var/lib/dpkg/info/cups-bsd.config*          /var/lib/dpkg/info/libdvd-pkg.config*              /var/lib/dpkg/info/printer-driver-pnm2ppa.config*     /var/lib/dpkg/info/wbritish.config*
/var/lib/dpkg/info/cups.config*              /var/lib/dpkg/info/libpaper1:amd64.config*         /var/lib/dpkg/info/rkhunter.config*                   /var/lib/dpkg/info/xserver-xorg-legacy.config*
/var/lib/dpkg/info/dash.config*              /var/lib/dpkg/info/linux-sound-base.config*        /var/lib/dpkg/info/sane-utils.config*
/var/lib/dpkg/info/debconf.config*           /var/lib/dpkg/info/locales.config*                 /var/lib/dpkg/info/ttf-mscorefonts-installer.config*
/var/lib/dpkg/info/debsecan.config*          /var/lib/dpkg/info/man-db.config*                  /var/lib/dpkg/info/tzdata.config*
```

### vlcの起動

```zsh
% vlc
```

## References

- [VLC media player](https://www.videolan.org/vlc/)
- [What is dpkg-reconfigure and how is it different from dpkg --configure?](https://askubuntu.com/questions/590898/what-is-dpkg-reconfigure-and-how-is-it-different-from-dpkg-configure)