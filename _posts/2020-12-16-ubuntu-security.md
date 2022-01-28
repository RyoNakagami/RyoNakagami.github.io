---
layout: post
title: "ファイヤウォールの設定: ufw と Gufw"
subtitle: "Ubuntu Desktop環境構築 Part 4"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
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

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. ファイヤウォールの設定](#1-ファイヤウォールの設定)
- [2. `ufw`コマンドによるファイヤウォール設定](#2-ufwコマンドによるファイヤウォール設定)
  - [インストール](#インストール)
  - [ufw の稼働状況及び設定内容の確認](#ufw-の稼働状況及び設定内容の確認)
  - [ufw enable/disable](#ufw-enabledisable)
  - [ufw default](#ufw-default)
    - [Syntax](#syntax)
    - [今回の設定](#今回の設定)
  - [ufw logging](#ufw-logging)
    - [Syntax](#syntax-1)
  - [ufw allow](#ufw-allow)
    - [Syntax](#syntax-2)
    - [今回の設定](#今回の設定-1)
  - [ufw delete](#ufw-delete)
  - [ufw limit](#ufw-limit)
- [3. グラフィカルユーザインタフェースによる設定: `Gufw`](#3-グラフィカルユーザインタフェースによる設定-gufw)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. ファイヤウォールの設定

Linuxカーネルには、Netfilterというパケットフィルタリング機能が備わっています。通信経路を流れるパケットを検査し、パケット単位で処理を行います。主な通信経路には、外部からLinuxへ入ってくる「入力」、Linuxから外部へ出ていく「出力」、別のホストへ転送する「転送」があります。

外部から入ってくるパケットは、「入力」に設定されたルールと照合され、ルールにマッチすれば許可または拒否されます。すべてのルールにマッチしなかったパケットは、デフォルトの設定（ポリシー）に従って処理されます。ポリシーが「破棄」であれば、パケットは破棄されます。

パケットフィルタリングの仕組みは以下の図参照：

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201216_ubuntu_packetfiltering.jpg?raw=true">

今回は`ufw`とそのGUI実装版の`Gufw`を用いたファイヤウォール設定を紹介します。

## 2. `ufw`コマンドによるファイヤウォール設定
### インストール

```
$ apt-get install ufw
```

###  ufw の稼働状況及び設定内容の確認

```
$ sudo ufw status
Status: active
```
ルールが設定される場合はルール一覧が表示されます。

### ufw enable/disable

ufwを有効にしたい場合は

```
$ sudo ufw enable
```

ufwを無効にしたい場合は

```
$ sudo ufw disable
```

ファイヤウォール設定を向こうにしても、設定したルールは残されているので、次回有効にしたときに再現されます。

### ufw default

ポリシーを設定します。

|オプション|説明|
|---|---|
|allow|ルールにマッチしなかった通信を許可します|
|deny|通信を破棄します|
|reject|通信を拒否してエラーを返します|

デフォルトでは「incoming」のポリシーを設定しますが、内部から外部方向「outgoing」や転送「routed」のポリシーを設定したときは、オプションでそれを明示する。

#### Syntax

```
$ ufw default allow|deny|reject [incoming|outgoing|routed]
```

#### 今回の設定

```
$ sudo ufw default reject
```

### ufw logging

ログレベル、つまりログに記録する粒度を設定します。デフォルトはmediumです。ログは通常 `/var/log/syslog` に出力されます。

#### Syntax

|パラメーター|説明|
|---|---|
|off|ログを記録しない|
|low|default以外でルールにマッチしてブロックされた通信を記録する|
|medium|lowに加え、ポリシーにマッチせず許可された通信、不正なパケット、新規の接続を記録する|
|high|mediumに加え、limit(後述)にマッチした通信も記録する|
|full|limitを覗くすべての通信を記録する|

```
$ ufw logging off|low|medium|high|full
```

### ufw allow

許可する通信を設定します。

#### Syntax

```
$ ufw allow サービス名|ポート番号|プロトコル|IPアドレス
```

サービス名とポート番号の対応づけは `/etc/services` ファイルで確認することができます。

#### 今回の設定

ラップトップからのssh接続を可能としたい場合は、

```
$ sudo ufw allow from 192.168.11.0/24 to any port ssh
Rule added
```

ルール番号付きで設定を表示 & 確認する

```
$ sudo ufw status numbered
```

### ufw delete

指定したルールを削除します。「ufw status numbered」コマンドで表示されるルール番号を指定する方法が簡単です。

```
$ ufw delete ルール|ルール番号
```

### ufw limit

指定したサービスへの繰り返される試行（同一IPアドレスから３０秒間に６回以上）を拒否します。設定方法は、

```
$ sudo ufw limit ssh
```

## 3. グラフィカルユーザインタフェースによる設定: `Gufw`

まず`Gufw` のインストールを実施する。

```
$ sudo apt -yV install gufw
```

その後、`settings`よりFirewall Configを開き、上述と同じ条件をGUIでポチポチして設定する。


## References

- [UbuntuでGufwを用いてファイヤウォールの設定](https://www.kkaneko.jp/tools/server/gufw_ubuntu.html)
