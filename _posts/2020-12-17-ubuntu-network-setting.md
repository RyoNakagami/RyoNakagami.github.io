---
layout: post
title: "Ubuntu Desktop環境構築 Part 5 (未実施 Part)"
subtitle: "デスクトップへのリモート接続：WoL設定"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- 未完成記事
---

||概要|
|---|---|
|目的|デスクトップへのリモート接続：WoL設定|
|参考|[ASUSのWi-FiルーターにOpenVPNでリモートアクセスしてみよう](https://tarufu.info/asusのwi-fiルーターにopenvpnでリモートアクセスしてみよう/)<br>[L2TP/IPsecを使ったVPNサーバー設定方法（バッファロー）](https://faq.interlink.or.jp/faq2/View/wcDisplayContent.aspx?id=147)<br>[無線LANとWoL](http://16777215.blogspot.com/2011/01/linux-wake-on-wlan.html)<br>[Ubuntu 20.04 で Wake-On-LAN を有効化する](https://ez-net.jp/article/03/CGPZ9mBE/05gYsU6tOny7/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [方針](#%E6%96%B9%E9%87%9D)
  - [前提条件 （注意！！）](#%E5%89%8D%E6%8F%90%E6%9D%A1%E4%BB%B6-%E6%B3%A8%E6%84%8F)
  - [技術スタック](#%E6%8A%80%E8%A1%93%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF)
- [2. VPNの設定](#2-vpn%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [なぜVPN設定をするのか](#%E3%81%AA%E3%81%9Cvpn%E8%A8%AD%E5%AE%9A%E3%82%92%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)
  - [ルーター設定](#%E3%83%AB%E3%83%BC%E3%82%BF%E3%83%BC%E8%A8%AD%E5%AE%9A)
  - [macOSでL2TP/IPsec接続する](#macos%E3%81%A7l2tpipsec%E6%8E%A5%E7%B6%9A%E3%81%99%E3%82%8B)
- [3. Ubuntu側でWoLの設定 (未実施)](#3-ubuntu%E5%81%B4%E3%81%A7wol%E3%81%AE%E8%A8%AD%E5%AE%9A-%E6%9C%AA%E5%AE%9F%E6%96%BD)
  - [BIOS設定](#bios%E8%A8%AD%E5%AE%9A)
  - [Ubuntuの設定](#ubuntu%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [ネットワークインタフェース名を確認](#%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%95%E3%82%A7%E3%83%BC%E3%82%B9%E5%90%8D%E3%82%92%E7%A2%BA%E8%AA%8D)
  - [WoLの状態確認](#wol%E3%81%AE%E7%8A%B6%E6%85%8B%E7%A2%BA%E8%AA%8D)
  - [Wake-On-LAN の設定を永続化する](#wake-on-lan-%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%82%92%E6%B0%B8%E7%B6%9A%E5%8C%96%E3%81%99%E3%82%8B)
    - [Wake-On-LAN 有効化スクリプトを作成](#wake-on-lan-%E6%9C%89%E5%8A%B9%E5%8C%96%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%82%92%E4%BD%9C%E6%88%90)
    - [サービスの定義ファイルを作成](#%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%81%AE%E5%AE%9A%E7%BE%A9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E4%BD%9C%E6%88%90)
    - [サービスを起動する](#%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E8%B5%B7%E5%8B%95%E3%81%99%E3%82%8B)
  - [MacBookに`wakeonlan`をインストールする](#macbook%E3%81%ABwakeonlan%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B)
  - [ファイヤウォール設定](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%A4%E3%82%A6%E3%82%A9%E3%83%BC%E3%83%AB%E8%A8%AD%E5%AE%9A)
- [Appendix: ネットワークインターフェース](#appendix-%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%95%E3%82%A7%E3%83%BC%E3%82%B9)
  - [ネットワークインターフェースの命名規則](#%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%95%E3%82%A7%E3%83%BC%E3%82%B9%E3%81%AE%E5%91%BD%E5%90%8D%E8%A6%8F%E5%89%87)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

持ち運び用として用いている MacBook Pro からデスクトップにリモート先からアクセスして、GPUなどを使った分析をしたい

### 方針

1. クライアント側でVPN設定
2. デスクトップ側でWoLとファイヤウォール設定
3. グローバルIPアドレス確認方法の確立
4. ssh接続設定（今回のスコープ外）

### 前提条件 （注意！！）

この記事は未実施 Part です。

- WoLが有線LANのみ対応
- SORACOMやラズパイによるデスクトップ電源管理の調査が必要と判断

### 技術スタック

|項目|詳細|
|---|---|
|Laptop PC|MacBook Pro (13-inch, Late 2016, Two Thunderbolt 3 ports)|
|Wi-Fiルーター|Buffalo WXR-2533DHP2（買い替えの必要あり）|
|VPNクライアント|システム環境設定 > ネットワーク > VPN設定|

## 2. VPNの設定
### なぜVPN設定をするのか

今回のスコープに入っているWoL(Wake on LAN)が機能する条件の一つとして、「Wake on LANで起動をかけるマシンと起動されるマシンが同一のネットワークセグメントに接続されていること」が求められているためです。

端末からルーターにVPN接続すると、ルーターに割り当てた固定IPアドレスでの通信になります。

### ルーター設定

1. まずルーターの設定ページにアクセスします。グローバルIPアドレスを確認します。ホーム画面から「詳細設定」→「ステータス」→「システム」と進み、IPアドレスを確認します。
このIPアドレスがVPN接続先のサーバーアドレスになります。
2. .VPNサーバー機能を有効にします。「Internet」→「VPNサーバー」と進みます。
3. VPNサーバー機能のプルダウンメニューから「L2TP/IPsec」を選択し、「事前共有キー（任意の文字列）」を入力して、「設定」ボタンをクリックします。
4. VPNサーバー設定の範囲から取得をクリック (FIX ここ要検討！)
5. VPN接続するユーザーを追加します。画面下の「VPN接続ユーザーの編集」をクリックすると、VPN接続ユーザー名の新規追加画面になります。「接続ユーザー名」にユーザー名（任意の文字列）、パスワードを入力して、「新規追加」をクリックします。

IPアドレス確認例

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/VPN/20201216_check_global_ip.jpg?raw=true">

VPN接続ユーザー登録

<img src="https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/VPN/20201216_setting2_01.jpg?raw=true">

設定完了画面

<img src="https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/VPN/20201212_setup_done.jpg?raw=true">

### macOSでL2TP/IPsec接続する

1. 「システム環境設定」から「ネットワーク」をクリックします。
2. ネットワーク画面左下にある「＋」をクリックします。
3. インターフェースは「VPN」、VPNタイプは「L2TP/IPsec」、サービス名は任意の名前を入力します。
4. 以下のように設定してVPN接続します。

## 3. Ubuntu側でWoLの設定 (未実施)

Wake-on-LAN (WOL) はネットワーク接続 (インターネットまたはイントラネット) からコンピュータの電源を入れる機能です。無線カードは Wake-on-LAN をサポートしていないため、ルーターや他のコンピュータに物理的に (ケーブルで) 接続しなくてはなりません。

### BIOS設定

- BIOSの起動はF10を押して起動します。
- 設定項目は、[Advanced]の中にある[Wake On Lan from S5]で、この値を Enabled に変更します。

### Ubuntuの設定

WOLを行うためにethtoolをインストールします。

```
$ sudo apt install ethtool
```

### ネットワークインタフェース名を確認

WoL設定を確認するためには `sudo ethtool ネットワークインタフェース名` を実行しますが、ネットワークインタフェース名を知っておく必要があるので、まずはネットワークインタフェース名を確認します。

```
$ ifconfig
```

または

```
$ ip address show
```

このうち、IPアドレスが記述されたネットワークインターフェースがあるのでその名前を確認します。今回は確認の結果、 `enp2s0` とします。

### WoLの状態確認

無効化されている場合は `Wake-on: d` となります。

```
$ sudo ethtool enp2s0 | grep Wake-on:
    Supports Wake-on: pumbg
    Wake-on: d
```

これを有効化します

```
$ sudo ethtool -s enp2s0 wol g
```

これだけでは再起動のたびに無効化されてしまうので、Wake-On-LAN の設定を永続化する必要があります。

### Wake-On-LAN の設定を永続化する
#### Wake-On-LAN 有効化スクリプトを作成

まず、次のようにして /etc/wol ディレクトリーを作成します。

```
$ sudo mkdir /etc/wol
```

そうしたら、そのディレクトリー内に `wakeonlan.sh` を作成して、次のような Wake-On-LAN 有効化コマンドを記載します。

```
$ nano /etc/wol/wakeonlan.sh
#!/bin/sh
/sbin/ethtool -s enp6s0 wol g
```

そして、次のようにして、作成したスクリプトファイルに実行権限を付与します。

```
$ sudo chmod u+x /etc/wol/wakeonlan.sh
```

#### サービスの定義ファイルを作成

次の内容で /etc/systemd/system/wakeonlan.service を作成します。

```
[Unit]
Description=Enable Wake-On-LAN
 
[Service]
Type=simple
ExecStart=/etc/wol/wakeonlan.sh
Restart=always
 
[Install]
WantedBy=multi-user.target
```

#### サービスを起動する

そうしたら、あとは次のようにしてサービスの登録と起動を行います。

```
$ sudo systemctl enable wakeonlan.service
$ sudo systemctl start wakeonlan.service
```

これで Ubuntu を再起動しても、常に Wake-On-LAN が有効化されるようになりました。

### MacBookに`wakeonlan`をインストールする

```
$ brew install wakeonlan
$ wakeonlan -v
```

で完了。次にwakeonlanを使ってUbuntu Desktopを起動します。まずUbuntu DesktopのMACアドレスが必要なので検索します。'link/ether' で始まる行に記載されています。

```
$ ip link show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether XX:YY:ZZ:PP:QQ:RR brd ff:ff:ff:ff:ff:ff
```

その後、

```
$ wakeonlan ＜MACアドレス＞
```

これで動作確認をする。

### ファイヤウォール設定

TBA

## Appendix: ネットワークインターフェース

ネットワークとの接点をネットワークインターフェースといいます。Linuxでは、ネットワークインターフェースは「eth0」や「enp0s3」といった名前で表します。名前はネットワークインターフェースの種類とデバイスの種類に応じて決定されます。

### ネットワークインターフェースの命名規則

|種別|説明|
|---|---|
|en|イーサネット（有線LAN）|
|wl|無線LAN|
|ww|無線WAN|

|デバイス|説明|
|---|---|
|オンボードデバイス|o<インデックス>|
|ホットプラグデバイス|s<スロット>[f<機能> d<デバイスID>]|
|PCIデバイス|p<バス>s<スロット>[f<機能> d<デバイスID>]|