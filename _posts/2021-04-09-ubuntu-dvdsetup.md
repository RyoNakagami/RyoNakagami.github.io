---
layout: post
title: "Ubuntu Desktop環境構築 Part 18"
subtitle: "Ubuntu 20.04 で DVD を視聴"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- vlc
---


||概要|
|---|---|
|目的|Ubuntu 20.04 で DVD を視聴|
|参考|[VLC media player](https://www.videolan.org/vlc/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [インストール方法](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95)
- [vlcの起動](#vlc%E3%81%AE%E8%B5%B7%E5%8B%95)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## インストール方法

```zsh
% sudo apt install vlc
% sudo apt install libdvd-pkg
% sudo dpkg-reconfigure libdvd-pkg
```

## vlcの起動

```zsh
% vlc
```
