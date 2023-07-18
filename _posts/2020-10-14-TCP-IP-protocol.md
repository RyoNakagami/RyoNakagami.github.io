---
layout: post
title: "初心者がTCP/IPを理解する"
subtitle: "ネットワークを学ぶ 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
mathjax: true
catelog: true
revise_date: 2023-04-07
tags:
  - ネットワーク
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [TCP/IPとは？](#tcpip%E3%81%A8%E3%81%AF)
  - [通信プロトコルの基本](#%E9%80%9A%E4%BF%A1%E3%83%97%E3%83%AD%E3%83%88%E3%82%B3%E3%83%AB%E3%81%AE%E5%9F%BA%E6%9C%AC)
  - [TCP/IP階層モデル](#tcpip%E9%9A%8E%E5%B1%A4%E3%83%A2%E3%83%87%E3%83%AB)
- [Appendix: コンピューターネットワークの種類](#appendix-%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%83%BC%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%81%AE%E7%A8%AE%E9%A1%9E)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## TCP/IPとは？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: TCP/IP</ins></p>

コンピューター同士(ノード間)のデータのやり取りのルールのことを通信プロトコルといい, その内, 
インターネットをはじめとするコンピューターネットワークを実現している通信プロトコル群のことを
TCP/IP(Transmission Control Protocol/Internet Protocol)という.

</div>

TCP/IPが通信プロトコルではなく「**通信プロトコル群**」と上で説明した訳は, 詳細は後ほど説明しますが, 
TCP/IPでは, データの送受信に関わる一連の作業を「**TCP/IP階層モデルに基づき階層化**」して, それぞれの階層で通信方法を定義 & 運用しているからです. 

なお, 通信プロトコルの意味でのTCPとIPもそれぞれ存在します.

- TCP: TCP/IPのネットワークにおいて送達管理や, 伝送管理などの機能を持つコネクション型プロトコルで, トランスポート層に属す
- IP: IPネットワークを分割管理するプロトコルでネットワーク層に属す. 最も基本的な通信単位であるパケットを相手に送信する役割を担っている

### 通信プロトコルの基本

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 通信プロトコル</ins></p>

データを送受信するためには, 送信側と受信側のコンピューターが予め決められた共通のルールに沿って連絡を取り合う必要があり, 
このルールのことをプロトコルという.

</div>

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E6%8A%80%E8%A1%93%E8%80%85%E8%A9%A6%E9%A8%93/20201014_TCP_IP_protocol.png?raw=true">

### TCP/IP階層モデル

データの送受信を行うにあたって, TCP/IPではどんなコンピューター同士でもデータのやり取りができるように以下のような処理を行います.

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/aecc0a89854f00fce0bcdd8c4e7d228a1169606c/%E6%8A%80%E8%A1%93%E8%80%85%E8%A9%A6%E9%A8%93/20201014_TCP_IP_process_basic.png">

この一連の流れを階層で表現したものが「**TCP/IP階層モデル**」となります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:gray; background-color:gray; color:white'>
<p class="h4"><ins>Def: TCP/IP階層モデル</ins></p>

| TCP/IP階層モデル&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;| Protocol<br> &nbsp;| OSI基本参照モデル&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;|
| :----------- |:----------- | :------------- | 
|アプリケーション層|HTTP, HTTPS, SMTP, POP3, FTP, TELNET, ...| 	アプリケーション層<br>プレゼンテーション層<br>セッション層|
|トランスポート層|TCP, UDP|トランスポート層|
|ネットワーク層|IP|ネットワーク層|
|データリンク層|Ethernet, FDDI, ATM, PPP, PPPoE, ...|データリンク層|
|物理層|特定のプロトコルはない|物理層|

</div>

TCP/IP階層モデルは５つの階層に分かれており, 上に行くほどユーザーに, 下に行くほど機器に近い作業を担当しています.
**階層化**によって, 「階層ごとに作業を独立させる」ことを実現しており, 他の階層に依存することなく「新しい機能を追加すること」や, 
「各階層の作業を単純化させる」といったことが可能になるメリットがあります.

例えば, インターネットに接続する方式として新たに`hogehoge`という接続方式が開発された場合, データリンク層にその接続方式に対応するプロトコルさえ作れば, TCP/IPを用いてデータのやり取りがネットワークに接続されたノード間で実現することが出来ます.

> 各階層の役割

- 第５層: アプリケーション層
  - アプリケーションに合わせた通信を行えるようにする層. アプリケーションに応じて利用するプロトコルが変わる
- 第４層: トランスポート層
  - エラー検出/再送などの伝送制御を担い通信の品質を保証する役割をもつ層
- 第３層: ネットワーク層
  - エンドシステム間のデータ伝送を実現するために, ルーティング(通信経路選択)や中継などを行う役割をもつ層
- 第２層: データリンク層
  - 隣接ノード間の伝送制御手順(誤り検出，再送制御など)を提供する役割をもつ層
  - ネットワークに直接接続されたノード間を伝送できるようにする役割をもつ
- 第１層: 物理層
  - データを信号に, 信号をデータに変換する層
  - 変換方法は通信媒体に依存するため, 特定のプロトコルは決められていない





## Appendix: コンピューターネットワークの種類

コンピューターネットワークとは, コンピューター同士をケーブルや赤外線, 無線など何らかの手段で繋いで
データのやり取りをできる状態にしたものをいいます. コンピューターネットワークのおかげで, プリンタへのファイルの出力や
ファイルの共有/転送, メールのやり取り, リモートアクセスなどが実現されています.

規模の応じてコンピューターネットワークは以下のように分類されます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>ネットワークの種類</ins></p>

|名称|説明|
|---|---|
|LAN|Local Area Network, 比較的狭い空間にある機器同士を繋いだネットワーク|
|WAN|Wide Area Network, 接続には光ファイバーケーブルや電話回線などが使われる|
|インターネット &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|複数のLANやWANを繋いだネットワーク|
|イントラネット &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|インターネットを技術を用いた地域原典版のLAN, 特定の会社でのみ情報を共有する場合に用いられる|

</div>





## References

> 関連ポスト




> 書籍

- [TCP/IPの絵本 第2版 ネットワークを学ぶ新しい9つの扉, 株式会社アンク 著](https://www.shoeisha.co.jp/book/detail/9784798155159)