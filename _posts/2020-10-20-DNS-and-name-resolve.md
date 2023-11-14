---
layout: post
title: "DNSと名前解決"
subtitle: "ネットワークを学ぶ 4/N"
author: "Ryo"
header-style: text
header-mask: 0.0
mathjax: true
catelog: true
last_modified_at: 2023-04-07
tags:
  - ネットワーク
  - Linux
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [DNS(Domain Name System)](#dnsdomain-name-system)
  - [ドメイン名の構造](#%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E5%90%8D%E3%81%AE%E6%A7%8B%E9%80%A0)
  - [IPアドレスがわかるまで：DNSの構成](#ip%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9%E3%81%8C%E3%82%8F%E3%81%8B%E3%82%8B%E3%81%BE%E3%81%A7dns%E3%81%AE%E6%A7%8B%E6%88%90)
- [コマンド紹介](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E7%B4%B9%E4%BB%8B)
  - [`hostname`: ホスト名の表示](#hostname-%E3%83%9B%E3%82%B9%E3%83%88%E5%90%8D%E3%81%AE%E8%A1%A8%E7%A4%BA)
  - [`nslookup`: ドメイン名からIPアドレスを表示](#nslookup-%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E5%90%8D%E3%81%8B%E3%82%89ip%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9%E3%82%92%E8%A1%A8%E7%A4%BA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## DNS(Domain Name System)

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: DNS</ins></p>

DNS ( Domain Name System ) は, ドメイン名（コンピュータを識別する名称）をIPアドレスに自動的に
変換する(名前解決する)してくれるアプリケーション層プロトコル.

IPアドレスとドメイン名の対応関係を提供する側をDNSサーバまたはネームサーバ, クライアントをリゾルバという.

</div>

TCP/IPを利用したネットワークでは, 各ノードを識別するため一意のIPアドレスが割り当てられていますが, DNSの仕組みがないと
GitHub.comへアクセスする際に`https://20.27.177.113/`とIPアドレスを直接入力する必要があります. 

<img src = "https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/0c9f263e49992f4619907b4ea27ac8f978039e2f/%E6%8A%80%E8%A1%93%E8%80%85%E8%A9%A6%E9%A8%93/20201020-DNS.png">


### ドメイン名の構造

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/2a8632022b4c41c245860379acef43da4216f51e/%E6%8A%80%E8%A1%93%E8%80%85%E8%A9%A6%E9%A8%93/20201020-DNS-domain-structure.png">

- トップレベルドメイン（TLD）は, 国別, 地域, 商用(`com`)などを表すドメイン
- 第4レベルドメインは,「ホスト名」に位置づけされるドメイン. 一般的にWebサーバであれば「www」として、FTPサーバであれば「ftp」とする
- トップレベルドメインより更に上の階層にルートドメインが存在しますが, 通常表示されることはない

> REMARKS

ドメインは頂点にルートドメイン(`.`)が存在し, ルートドメイン配下にトップレベルドメインがあり, その配下に第2レベルドメインと続く階層構造（ツリー構造）となっています.

### IPアドレスがわかるまで：DNSの構成

ネットワークに接続された遠隔コンピュータのホスト名の名前解決を行う際, 遠隔マシンのアドレスを得るために, ローカルマシン上で動作している DNS ソフトウェアにまず要求をに送ります. この時のローカルマシンを「**DNS クライアント**」や「**ローカルネームサーバー**」と呼びます. 

リクエストを受け取ったローカルネームサーバーは, 自分の対応表にないドメインを聞かれると, まずDNSを統括するルートサーバーに問い合わせをします. 


## コマンド紹介
### `hostname`: ホスト名の表示

`hostname`はシステムのホスト名を表示するコマンド.
rootユーザーの場合, `hostname`コマンドを用いてホスト名を変更することも可能です.

> Syntax

```zsh
### ホスト名の表示
% hostname

### 狭義ホスト名の表示
% hostname -s

### ホスト名の変更
% hostname <new hostname>
```

> ホスト名はどこに保存されているのか？

Linuxではホスト名は`/etc/hostname`ファイルに保存されています.
ホスト名を変更する場合, `hostname`コマンドを用いる以外にも `/etc/hostname`ファイルを直接編集することでも可能です.


### `nslookup`: ドメイン名からIPアドレスを表示



## References

> 関連記事

- [Ryo's Tech Blog > 電子メールの仕組み](https://ryonakagami.github.io/2020/10/15/Mail-system-basic/)

> 書籍

- [TCP/IPの絵本 第2版 ネットワークを学ぶ新しい9つの扉, 株式会社アンク 著](https://www.shoeisha.co.jp/book/detail/9784798155159)

> オンラインマテリアル

- [ASCII.jp × TECH > メールを支えるドメイン名とDNSの仕組み](https://ascii.jp/elem/000/000/432/432823/)
