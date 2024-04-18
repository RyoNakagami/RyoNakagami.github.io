---
layout: post
title: "Intel Core マイクロアーキテクチャーの構成"
subtitle: "Computer science 101 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-20
tags:

- computer science
- Linux

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [コンピューターの物理的構成要素](#%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AE%E7%89%A9%E7%90%86%E7%9A%84%E6%A7%8B%E6%88%90%E8%A6%81%E7%B4%A0)
- [Intel Core マイクロアーキテクチャー](#intel-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3%E3%83%BC)
  - [Intel Core マイクロアーキテクチャーチップセットの概略図](#intel-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3%E3%83%BC%E3%83%81%E3%83%83%E3%83%97%E3%82%BB%E3%83%83%E3%83%88%E3%81%AE%E6%A6%82%E7%95%A5%E5%9B%B3)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## コンピューターの物理的構成要素

|構成要素|説明|
|---|---|
|CPUクーラー|CPUはかなり発熱するパーツなので「CPUクーラー」という冷却装置を取り付ける．<br>空冷式と水冷式がある。|
|CPU|CPUはシステムやアプリの動作に必要な計算処理を行うパソコンの頭脳にあたるパーツ．<br>パソコンを選ぶ際はここから決める|
|グラフィックボード|グラフィックボードはパソコンの操作画面をディスプレイに映すためのパーツ．<br>「GPU」という描画用演算装置が必要な処理を担当する．<br>グラフィック機能を搭載したCPUを用いた場合，必要ではない|
|電源ユニット|パソコンの各パーツに電力を供給する機器．<br>接続したパーツの消費電力に見合った容量を持った製品が必要|
|メモリ (RAM)|一次記憶<br>CPU が計算する際に用いられる記憶領域をメインメモリという．<br>CPU が計算をするためのデータやプログラムはメインメモリに一度保存され，必要に応じて読み出される|
|マザーボード|パソコンに必要な装置を接続する基盤．<br>バス（コンポーネントを繋ぐ線）やネットワーク，サウンド機能はマザーボード上に搭載されている．<br>コンポーネントを結びつけるパーツを総称でチップセットという<br>CPUに対応したチップセットを搭載したマザーボードを選ぶ必要がある|
|ストレージ|SSD，HHDといった二次記憶装置<br>大容量のデータを電源が切れていても保存できる装置|
|PCケース|マザーボードのサイズによって決まる|
|出力デバイス|演算結果のデータをユーザに対して出力する装置<br>例：Display，Screen，スピーカー|
|入力デバイス|ユーザからの入力を受ける装置<br>例：キーボード, マウス|

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: USB</ins></p>

- 外部に現れるバスのことをユニバーサルシリアルバス，USBと呼ぶ
- コンピューターに周辺機器を接続するための規格のひとつ

最大転送速度は企画によって以下のように異なる

- USB 2.0: 480Mbit/s
- USB 3.0: 5Gbit/s
- USB 3.1: 10Gbit/s
- USB 3.2: 20Gbit/s

</div>

## Intel Core マイクロアーキテクチャー

Intel Core マイクロアーキテクチャーは，

- プロセッサチップ
- PCH(Platform Controller hub)

から構成されています．プロセッサチップとPCHはDMI(Direct Media Interface)によって接続されています．
DMIは論理的にはPCIバス0(バス番号:0)とみなせます．また，グラフィックスコントローラーや，SATAコントローラーといった主要デバイスはプロセッサ内部及びPCH内部で
PCIバス0に接続されています

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>プロセッサチップの機能</ins></p>

- マルチコアプロセッサ
- メモリーコントローラー
- ホストブリッジ（プロセッサ，メモリ，PCIバス0を接続するブリッジ）
- グラフィックスコントローラー
- ディスプレイインターフェース(DP, eDP, DVI, HDMI)
- PCI Express（外部グラフィックスデバイス用）
- Local APIC

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>PCHチップの機能</ins></p>

- PCI-to-PCIブリッジ(PCIバス0と他のPCIバスを接続)
- SATAコントローラー
- USBコントローラー
- オーディオコントローラー
- イーサネットコントローラー
- PCI Express
- I/O APIC

</div>

<br>

**用語説明**

|用語|説明|
|---|---|
|PCI|Intel Coreマイクロアーキテクチャーにおいて<br>チップセット内部の主要なデバイスを接続するバス|
|PCI Express|PCIに変わる高速なバス<br>GPUの接続などに使われる|
|SDRAM|Synchronous DRAM<br>メモリバスクロックに同期して，1クロックにつき一つのデータを読み出すDRAM|
|DDR SDRAM|Double-Data-Rate Synchronous DRAM<br>クロック信号の立ち上がりと立ち下がりの両方に同期してデータをやり取りするDRAM<br>理論上はクロック間隔と等倍で動作するSDRAMの2倍の速度を得ることが可能な規格<br>メモリクロックが高ければ高いほど性能が良い.<br>DDR4-5000ならば 5000 MHzのメモリクロックとなる|

### Intel Core マイクロアーキテクチャーチップセットの概略図

データの通り道であるバスを中心に各種構成要素を抽象的に表したのが下図

![abstract-architecure](https://github.com/ryonakimageserver/omorikaizuka/blob/master/IT101/computer_bus_hardware.jpg?raw=true)

Core i7 6700HQのノートPCを例としたIntel Core マイクロアーキテクチャーチップセットの概略図は以下

![IntelCoreMicroArchiExmaple](https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/device/IntelCoreMicroArchiExmaple.png?raw=true)
