---
layout: post
title: "network overheadを理解する"
subtitle: ""
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2024-07-06
header-mask: 0.0
header-style: text
tags:

- Network

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [この記事のスコープ](#%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [Navigation Timing and Resource Timing](#navigation-timing-and-resource-timing)
  - [Navigation Timingの項目分解](#navigation-timing%E3%81%AE%E9%A0%85%E7%9B%AE%E5%88%86%E8%A7%A3)
- [Network overhead](#network-overhead)
  - [DNS Resolution](#dns-resolution)
  - [TCP/SSL connection](#tcpssl-connection)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## この記事のスコープ

- Resourceのリクエストからのdownloading開始までの間に何が起こっているかの理解を通して，network latencyとconnection overheadの概要を学ぶ


## Navigation Timing and Resource Timing

ブラウザのdeveloper tools(ChromeやFirefoxなどで`ctrl` + `shift` + `c`で表示可能)で以下のように，
network requestのNavigation Timingを表示することができます．

![20201208_networkrequest_time](https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/network/20201208_networkrequest_time.png?raw=true)

ここで表示されているものはNavigation TimingやResource Timingとなります．Navigation TimingとResource Timingはネットワークのパフォーマンスを測定するMetricsでありますがそれぞれ以下のように異なる概念です．

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Navigation Timing and Resource Timing</ins></p>

- Navigation Timing: HTMLドキュメントのリクエスト速度（ナビゲーションリクエスト）を測定
- Resource Timing: CSS，JavaScript，画像などのドキュメント依存のリソースのリクエスト速度を測定

</div>

Navigation TimingはリクエストされたDocument全体のloading speedに焦点を当てている一方，Resource Timingは各個別のコンテンツについてのloading/fetchingに焦点を当てているという違いがあります．network requestの全体像を掴みたいときはまずNavigation Timingを確認し，個別論点でResource Timingを個別に確認していくものと理解して良いと思います．

### Navigation Timingの項目分解

Network requestはいくつかのフェーズに分解できます（[参考](https://developer.chrome.com/docs/devtools/network/reference/?utm_source=devtools#timing-explanation)）

|Phase|Comments|
|---|---|
|Queueing|Network requestが処理されるまでの待ち時間．優先度の高いリクエストが他に存在していたりする場合に発生|
|Stalled|Connectionが始まってから発生した待ち時間のこと．要因はQueueingと同じ|
|DNS Lookup|IPアドレスとドメイン名を紐づけ時間|
|Initial connection|Connection確立の時間，TCP handshakesやSSLの時間|
|Requests and responses|リクエストの送信，サーバー側での処理時間，コンテンツのダウンロードなど|

## Network overhead

上記のNavigation Timingを見てみるとContent Downloadingの時間は64 msで全体の11.2%となっています．のこちの約88.8%がいわゆるnetwork overheadです．

etwork overheadの短縮を短縮に関するブラウザ上での最適化技法や新しいプロトコルの一部を以下紹介します.

### DNS Resolution

上記のNavigation TimingにおけるDNS Lookup時間はほぼ0 msとなっています．これはDNSキャッシュという仕組みをしているためです．
現在のキャッシュの状態は，`chrome://net-internals/#dns`で確認できます．`google.com`を対象に確認してみると

```
Resolved IP addresses of "google.com": ["2404:6800:4004:818::200e","142.251.222.46"].
Alternative endpoint: {"alpns":["h2","h3","http/1.1"],"ip_endpoints":["2404:6800:4004:818::200e","142.251.222.46"]}.
```

Chromeは内部キャッシュに最大1000の解決済みDNS名を保持できます．

### TCP/SSL connection

HTTPリクエストを使用している場合，TCP接続プロトコルは単一のラウンドトリップ（SYN -> SYN + ACK -> ACK）で完了します．
しかし，SSL/TLSを通常のTCP接続に追加すると，少し複雑になります．

SSLはTCPをトランスポートプロトコルとして使用するため，接続を確立するためには通常のTCP接続と同じ手順（SYN -> SYN + ACK -> ACK）を踏みます．しかし，最後のACKパケットにはSSLネゴシエーションを開始するために必要な追加データ（クライアントハロー）が含まれているという違いが有ります．そしてSSLを用いた接続の場合，プロトコルを完了するためにここからさらに，2つの追加のラウンドトリップが必要となります．

またinitial connectionの後も，SSLを用いた接続ではリクエストのたびに２回のラウンドトリップが発生します．つまり，50個のユニークなリソースを持つウェブサイトの場合，100回分のラウンドトリップが発生することになり，一回あたり0.01秒でも読み込み時間が１秒以上遅れます．
これはかなりのNetwork overheadです．

このオーバーヘッドを削減するために，「ストリーム」と呼ばれる仮想的な通信経路を作って多重化することで，1 回の TCP/SSL コネクションに対して複数のリクエストを並列処理できるようにしたHTTP/2，HTTP/3というプロトコルが登場しました．





References
----------
- [Chrome for Developers > Network features reference](https://developer.chrome.com/docs/devtools/network/reference/?utm_source=devtools#timing-explanation)
- [Understanding network overhead](http://colin-dumitru.github.io/network/latency/web-performance/2015/02/04/understanding-network-overhead.html)