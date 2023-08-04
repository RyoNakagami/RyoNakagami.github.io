---
layout: post
title: "apt vs apt-get"
subtitle: "APTによるパッケージ管理 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-07-28
tags:

- Linux
- apt
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem: packages are being "kept back".](#problem-packages-are-being-kept-back)
- [Why Does It Happen?](#why-does-it-happen)
- [Solution](#solution)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Problem: packages are being "kept back".

```zsh
% sudo apt update
% sudo apt upgrade
Building Dependency Tree... Done
The following packages have been kept back:
  bind9-host dnsutils imagemagick libmagick6
0 upgraded, 0 newly installed, 0 to remove and 4 not upgraded.
```

このように`apt upgrade`を実行してもupgradeされないパッケージが発生してしまう問題に直面.
`sudo apt list --upgradable`を実行するとupgrade待ちパッケージとして表示されてしまう.

## Why Does It Happen?

すでにインストールされたパッケージについて依存関係(`dependencies`)が変わってしまった場合,
新しい依存関係パッケージをインストールするまで, upgrade可能だが"kept-back"という形で処理されてしまいます.

## Solution

依存関係パッケージを最新にした上で, kept-back packagesをインストールし直すだけで解決できます.

```zsh
% sudo apt-get install <list of packages kept back>
```


References
---------

- [debian-administration.org > Some upgrades show packages being kept back](https://web.archive.org/web/20200810160338/https://debian-administration.org/article/69/Some_upgrades_show_packages_being_kept_back)
- [askUbuntu > The following packages have been kept back:" Why and how do I solve it?](https://askubuntu.com/questions/601/the-following-packages-have-been-kept-back-why-and-how-do-i-solve-it)