---
layout: post
title: "Start Wars Jedi: Fallen Orderプレイ環境設定"
subtitle: "Ubuntu Desktop環境構築: Steam編 2/N"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
revise_date: 2022-12-26
catelog: true
mathjax: true
tags:

- Ubuntu 20.04 LTS
- Steam
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [動作環境](#%E5%8B%95%E4%BD%9C%E7%92%B0%E5%A2%83)
- [Star Wars Jedi: Fallen Order](#star-wars-jedi-fallen-order)
- [ゲーム環境設定](#%E3%82%B2%E3%83%BC%E3%83%A0%E7%92%B0%E5%A2%83%E8%A8%AD%E5%AE%9A)
  - [Proton Version設定](#proton-version%E8%A8%AD%E5%AE%9A)
  - [ゲームパッドを認識しない問題](#%E3%82%B2%E3%83%BC%E3%83%A0%E3%83%91%E3%83%83%E3%83%89%E3%82%92%E8%AA%8D%E8%AD%98%E3%81%97%E3%81%AA%E3%81%84%E5%95%8F%E9%A1%8C)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 動作環境

|項目||
|---|---| 	 
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 32.0 GB|
|GPU| NVIDIA GeForce RTX 2060 SUPER|
|ゲームプラットフォーム| Steam|
|コントローラー|[Xbox ワイヤレス コントローラー - カーボン ブラック](https://www.microsoft.com/ja-jp/d/xbox-%E3%83%AF%E3%82%A4%E3%83%A4%E3%83%AC%E3%82%B9-%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9%E3%83%BC/8xn59crbsqgz)|


## Star Wars Jedi: Fallen Order

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20221226_FallOrder.jpg?raw=true">

---|---
開発元|Respawn Entertainment
発売元|エレクトロニック・アーツ
プロデューサー|シシド・カスミ
ディレクター|スティグ・アスムッセン
シリーズ|スター・ウォーズシリーズ
人数|1人
発売日|2019年11月15日
エンジン|Unreal Engine
protondb status|Gold (Runs perfectly after tweaks)



## ゲーム環境設定
### Proton Version設定

- Game Title > Property > Compatibilityから `Proton 7.0-5` を指定
- Experimental, GE-Proton7-41などを試したが, 「DX11 feature level 10.0 is required to run the engine」というエラーメッセージがでてきてしまい対応できなかった

### ゲームパッドを認識しない問題

Proton設定後, ゲームは起動するがゲームパッドが認識されない（正確には、一部のコマンド入力しか認識されない）という問題に直面. 
この問題の対処は以下２つの流れで暫定的に解決:

- ゲームパッドの設定
- 「BigPictureモード」ではない画面からゲームを起動する


> ゲームパッドの設定

前提として, USB Type-CケーブルかBluetoothか何でも良いので使用するコントローラーをPCに接続してから以下を実行

1. Open Steam Settings
2. Go down to the Controller tab
3. Click Desktop Configuration button
4. Click Template and select the gamepad
5. Apply Configuration


## References

> 関連ポスト

- [Ryo's Tech Blog > Ubuntu 20.04 LTSでメタルギアソリッドVをやりたい](https://ryonakagami.github.io/2022/01/27/ubuntu-steam-setup/)

> オンライン参考

- [PC Watch > 【第3回】Ubuntuでもエルデンリングを動かせる！ SteamでWindows用のゲームをプレイしよう](https://pc.watch.impress.co.jp/docs/column/ubuntu/1409524.html)