---
layout: post
title: "Sony WF-1000XM3 Bluetoothの設定"
subtitle: "Ubuntu Desktop環境構築 Part 18"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-03-09
tags:

- Ubuntu 20.04 LTS
- bluetooth
- Network

---
<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回のスコープ](#%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [1. 実行環境](#1-%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
  - [Desktop](#desktop)
  - [Bluetoothヘッドホン](#bluetooth%E3%83%98%E3%83%83%E3%83%89%E3%83%9B%E3%83%B3)
  - [Package Requirements(今回インストールするもの)](#package-requirements%E4%BB%8A%E5%9B%9E%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B%E3%82%82%E3%81%AE)
- [2. Bluetooth技術](#2-bluetooth%E6%8A%80%E8%A1%93)
  - [Bluetoothのバージョン](#bluetooth%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3)
    - [メッシュネットワークとは？](#%E3%83%A1%E3%83%83%E3%82%B7%E3%83%A5%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%81%A8%E3%81%AF)
    - [Bluetooth 5.2とオーディオシェアリング](#bluetooth-52%E3%81%A8%E3%82%AA%E3%83%BC%E3%83%87%E3%82%A3%E3%82%AA%E3%82%B7%E3%82%A7%E3%82%A2%E3%83%AA%E3%83%B3%E3%82%B0)
  - [プロファイル](#%E3%83%97%E3%83%AD%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)
    - [コーデック](#%E3%82%B3%E3%83%BC%E3%83%87%E3%83%83%E3%82%AF)
    - [代表的な音源フォーマットのビットレート一覧](#%E4%BB%A3%E8%A1%A8%E7%9A%84%E3%81%AA%E9%9F%B3%E6%BA%90%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88%E3%81%AE%E3%83%93%E3%83%83%E3%83%88%E3%83%AC%E3%83%BC%E3%83%88%E4%B8%80%E8%A6%A7)
  - [Bluetoothのクラスとは？](#bluetooth%E3%81%AE%E3%82%AF%E3%83%A9%E3%82%B9%E3%81%A8%E3%81%AF)
- [3. Ubuntu 20.04とWF-1000XM3の接続設定](#3-ubuntu-2004%E3%81%A8wf-1000xm3%E3%81%AE%E6%8E%A5%E7%B6%9A%E8%A8%AD%E5%AE%9A)
  - [Bluetooth Managerのインストール](#bluetooth-manager%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [pulseaudio-modules-btの設定](#pulseaudio-modules-bt%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [Appendix: ビットレートとは](#appendix-%E3%83%93%E3%83%83%E3%83%88%E3%83%AC%E3%83%BC%E3%83%88%E3%81%A8%E3%81%AF)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 今回のスコープ

- 脳死で接続するとHSP/HPPで接続してしまい音質が悪くなってしまう
- Sony WF-1000XM3をA2DP AACでUbuntu 20.04と接続するまでの設定

## 1. 実行環境
### Desktop

|項目||
|---|---| 	 
|マシン| 	HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| 	Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 	32.0 GB|
|GPU| 	NVIDIA GeForce RTX 2060 SUPER|

```zsh
% lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.3 LTS
Release:        20.04
Codename:       focal
% uname -srvmpio
Linux 5.13.0-27-generic #29~20.04.1-Ubuntu SMP Fri Jan 14 00:32:30 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```

### Bluetoothヘッドホン

|項目||
|---|---|
|Bluetoothヘッドホン|WF-1000XM3|
|通信方式| 	Bluetooth標準規格 Ver.5.0|
|出力| 	Bluetooth標準規格 Power Class 1|
|最大通信距離| 	見通し距離 約10m|
|使用周波数帯域| 	2.4GHz帯(2.4000GHz-2.4835GHz)|
|対応Bluetoothプロファイル|A2DP, AVRCP, HFP, HSP|
|対応コーデック|SBC, AAC|
|対応コンテンツ保護| 	SCMS-T|
|伝送帯域(A2DP)| 	20Hz - 20,000Hz(44.1kHzサンプリング時)|


### Package Requirements(今回インストールするもの)

|Package|説明|
|---|---|
|libavcodec-dev|de/encoders for audio codecs|
|libldac|Sony LDAC de/encoders|
|pulseaudio-modules-bt|bluetooth経由で音声を流すためのLinuxのライブラリ|
|bluez|Bluetoothドライバ|
|bluez-tools|Bluetoothドライバ設定ライブラリ|

## 2. Bluetooth技術

Bluetoothとは, 免許申請や使用登録の不要な2.4GHz帯の電波を用い, 数m～数十m程度の比較的短距離の情報機器間で, 電波を使い最大24Mbpsの無線通信を行う規格です. IEEE規格名は「IEEE 802.15.1」. 機器同士をペアリング（原則1対1の通信に制限）してデータの送受信を行います. 


> Bluetoothの特徴

- Wi-Fiのように大容量のデータを高速で送ることはできませんが, Wi-Fiと比べ接続が簡単で, 消費電力も小さい
- 赤外線で無線通信を行うIrDAと比較して通信間にある障害物に強い
- Bluetoothでは通信の指向性がないため, 機器のレイアウトや向きを自由に変更することが可能というメリットがある

Bluetooth対応機器を購入する場合、機能や性能を100%発揮させるためには、主に通信に関わる「バージョン」と、機器同士の機能連携に関わる「プロファイル」、そして通信距離に関わる「Class」の確認が重要です。

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa ; background-color:#e6e6fa'>
<p class="h4"><ins>Column: IrDA</ins></p>

IrDaとはInfrared Data Associationの略で, 携帯電話のアドレス帳などのデータ交換を行う場合に使用される赤外線を使って無線通信をする技術のこと. 通信可能範囲は30cm～2m程度とBluetoothと比較して狭く, 固い壁で隔てられた場所同士の通信はできません.

ちなみにゲームボーイカラーの赤外線はIrDA規格ではありませんが, SONYのポケットステーションの赤外線はIrDA準拠です.

</div>


> それぞれの無線通信が使用する周波数帯

|通信技術|周波数帯|
|:---:|:---:|
|Bluetooth|2.4GHz帯|
|GPS|1.2GHz/1.5GHz帯|
|IEEE802.11 無線LAN|2.4GHz/5GHz帯|
|第３世代携帯電話|2GHz/800MHz帯|
|5G|Sub6帯の3.7GHz/4.5GHz帯, ミリ波帯の28GHz帯|

2.4GHz帯は無線免許を必要とせずに利用できるため, 電子レンジやコードレス電話などの多くの機器で使用されており,
これらを同時に使用すると電波の干渉が起こる可能性があります.


### Bluetoothのバージョン

Bluetoothが誕生したのは1999年。このときのバージョンが「Bluetooth 1.0」。その後、何度か大きなバージョンアップを繰り返し、2016年にメジャー・バージョンアップ「Bluetooth 5.0」が発表され2020年1月に発表された「Bluetooth 5.2」が最新となります。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210423_bluetooth_version.png?raw=true">

#### メッシュネットワークとは？

メッシュネットワークとは、複数のBluetoothの対応機器（スマホが親だとしたら、Bluetoothイヤホンのような子にあたる接続先の機器）同士が網の目のようにつながるネットワークのことです。たとえば、Bluetooth照明機器が1階から2階まで、家中の部屋に設置されていたとします。このとき、自分のスマホでいちばん近くにあるBluetoothライトに「家中の電気を消せ」と指令を出せば、このメッシュネットワークを通じて家中のBluetoothライトに命令が伝わり、一斉に電気を消すことができます。

つまり、Bluetoothに接続した機器同士が通信を中継する役割を果たしてくれるというわけです。これを利用すれば、遠く離れた部屋にあるBluetooth付きエアコンを、Bluetoothライトのネットワークを通じてコントロールする、といったことも今後は可能になります。

> 活用例

- 店舗の棚などにビーコンを設置し、買い物客のスマホにその商品の詳細な情報（たとえば食品なら成分や生産地、賞味期限、おすすめの料理法など）を配信
- スマートウォッチやヘルスケア用のウェアラブル・デバイスが、Bluetooth搭載の体重計や家電などと自動的に連携して情報を収集、管理してくれ、コントロールもできる
- Bluetoothスピーカーや電球、エアコンなどの家電を別の部屋のスマホから操作できる
- GPS電波が届かない屋内でも、スマホだけで高精度に位置を特定できるので、ビーコンを用いた屋内での位置ナビゲーションサービス

#### Bluetooth 5.2とオーディオシェアリング

2019年に発表されたBluetooth 5.1（方向探知機能追加）に続き、2020年に発表された最新のBluetooth 5.2では、新技術のオーディオ技術「LE Audio」が搭載されました。「LE Audio」では、「マルチ・ストリーム・オーディオ」機能によりブロードキャストで複数デバイスに音声を送信できるほか、ハイレゾ音源にも対応している新コーデック（圧縮伝送方式）のLC3により、低消費電力で高品質の音声データ送信が可能となりました。その代表的活用例が「オーディオシェアリング」機能です。「オーディオシェアリング」機能によって、自分のスマホの音楽を友人と共有する、映画館で音声を共有する、などができるようになっています。

### プロファイル

「プロファイル」とはBluetooth機器同士で通信を行うための規格のことです。スマートフォンとプリンターをつなぐためのプロファイルや、2台のPC同士で通信するためのプロファイルなど、多くの種類が存在しますが、ここではワイヤレスのBluetoothイヤホン／ヘッドホンに関連するプロファイルを紹介します。

|プロファイル名| 	機能内容|
|---|---|
|A2DP|Advanced Audio Distribution Profile,	音声をレシーバー付きヘッドフォン（またはイヤホン）に伝送する。HSP/HFPと異なり、ステレオ音声・高音質となる。|
|GAVDP| 	A2DP、AVRCPなどをサポートするための基本となるプロファイル。ビデオストリームと音声ストリームを配信するために使用されます。|
|HSP|Headset Profile, Bluetooth搭載ヘッドセットと通信する。モノラル音声の受信だけではなく、マイクで双方向通信する。|
|HFP|Hands-Free Profile, 車内やヘッドセットでハンズフリー通話を可能にする。HSPの機能に加え、通信の発信・着信機能を持つ。|
|VDP| 	ビデオ配信をする。|

#### コーデック

Bluetoothのコーデックとは、スマホや音楽再生プレイヤーなどのデバイスからワイヤレスイヤホンやヘッドホンなどに無線で音楽のデータを送る際の符号化の規格です。圧縮の規格でもあるので元の音楽データを圧縮エンコードしBluetoothで飛ばし、受信デバイスのイヤホンなどでデコードすることで音楽の再生をしています。そのため、コーデックの違いにより、音質や遅延に違いが出ます。

|コーデック|特徴|遅延|ビットレート|サンプリングレート| 
|---|---|---|---|---|
|SBC|Sub Band Codec, Bluetooth標準コーデック<br>音質と遅延に難有り|220m/s|64-328kbps|48kHz/16bit|
|AAC|iPhoneでメインに採用されるコーデック<br>音質は良いが規格的には大遅延|120m/s［CBR］<br>800m/［VBR］|128Kbps<br>可変256kbps<br>320kbps| 48kHz/16bit|
|aptX|実質的にAndroidの標準コーデック<br>比較的良い音質で低遅延|70m/s|384kbps|48kHz/16bit|
|aptX HD|ハイレゾ対応コーデック<br>高音質で遅延も少なめ|130m/s|576kbps|48kHz/24bit|
|aptX Adaptive|可変ビットレートであらゆる環境に対応したコーデック<br>接続環境に合わせて高音質重視～低遅延重視まで自動で判断<br>ハイレゾ対応|50-80m/s|276~420kbps|48kHz/24bit|
|LDAC|ハイレゾ対応の最高音質のコーデック<br>音質は良くても遅延も多い<br>Xperiaを中心に採用される|1000m/s|330kbps/660kbps/990kbps|96kHz/24bit|

#### 代表的な音源フォーマットのビットレート一覧

- FMラジオ：約96kbps
- mp3/AACなどの圧縮音源をBluetooth A2DP(SBC)接続：事実上64～約200kbps
- mp3/AACなどの圧縮音源を記録したメディア：事実上64～320kbps
- CD(-DA)：1,411kbps

1,411kbpsのデータ量のCD音質データや256kbps程度のデータ量のmp3/AAC等の音楽データをBluetooth A2DP(SBC)接続で伝送する場合にBluetoothでの無線接続部分がボトルネックとなり音質が低下してしまうことがわかります.

### Bluetoothのクラスとは？

Bluetoothのクラスとは、電波の最大出力や到達距離を規定した名称です。最大通信距離によって「クラス1」、「クラス2」、「クラス3」の3つの種類に分けられています。

|クラスの種類| 	最大出力 	|通信最大距離|
|---|---|---|
|クラス1| 	100mW 	|約100m|
|クラス2| 	2.5mW 	|約10m|
|クラス3| 	1mW 	|約1m|

なお日本国内では「クラス1」といえど10mWが限界のため最大値の1/10が最大出力です。

## 3. Ubuntu 20.04とWF-1000XM3の接続設定

接続設定手順としては以下です：

1. Bluetooth Managerのインストール
2. pulseaudio-modules-btの設定 & GUIでprofile/codecsの設定

### Bluetooth Managerのインストール

```zsh
% sudo apt update
% apt install bluez bluez-tools
% apt install blueman
```

Ubuntuでは問題は怒らないと思いますが、Bluetooth serviceが立ち上がっておらずBluemanが起動できないという恐れがあります.
この場合は`systemctl`経由でbluetooth serviceはenableすれば良いとなります. この設定は

```zsh
% sudo systemctl enable bluetooth.service
% sudo systemctl status bluetooth.service
● bluetooth.service - Bluetooth service
     Loaded: loaded (/lib/systemd/system/bluetooth.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2020-03-17 09:59:16 JST; 1h 59min ago
       Docs: man:bluetoothd(8)
   Main PID: 908 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 38299)
     Memory: 2.7M
     CGroup: /system.slice/bluetooth.service
             └─908 /usr/lib/bluetooth/bluetoothd
```

Blueman経由でWF-1000XM3と接続するばあいはGUI経由か, Terminalに`blueman-manager`と入力して接続設定を開いて、あとはボタンをポチポチするだけです.

### pulseaudio-modules-btの設定

Ubuntu側でコーデック対応に必要なパッケージをインストールし、接続確認するだけです。まず必要パッケージのインストール.

```zsh
% sudo add-apt-repository ppa:berglh/pulseaudio-a2dp
% sudo apt update
% sudo apt install pulseaudio-modules-bt libldac
pulseaudio -k
pulseaudio --start
% reboot
```

次に正しくインストールされているか確認します. この時、Blueman経由でWF-1000XM3と接続しておきます.

```zsh
% pacmd list-cards
name: <bluez_card.XX_XX_XX_XX_XX_XX>
	driver: <module-bluez5-device.c>
	owner module: 29
	properties:
		device.description = "WF-1000XM3"
		device.string = "94:DB:56:CC:3E:92"
		device.api = "bluez"
		device.class = "sound"
		device.bus = "bluetooth"
		device.form_factor = "headset"
		bluez.path = "/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX"
		bluez.class = "0x240404"
		bluez.alias = "WF-1000XM3"
		device.icon_name = "audio-headset-bluetooth"
		device.intended_roles = "phone"
	profiles:
		headset_head_unit: Headset Head Unit (HSP/HFP) (priority 30, available: unknown)
		a2dp_sink_sbc: High Fidelity Playback (A2DP Sink: SBC) (priority 40, available: unknown)
		a2dp_sink_aac: High Fidelity Playback (A2DP Sink: AAC) (priority 40, available: yes)
		a2dp_sink_aptx: High Fidelity Playback (A2DP Sink: aptX) (priority 40, available: no)
		a2dp_sink_aptx_hd: High Fidelity Playback (A2DP Sink: aptX HD) (priority 40, available: no)
		a2dp_sink_ldac: High Fidelity Playback (A2DP Sink: LDAC) (priority 40, available: no)
		off: Off (priority 0, available: yes)
	active profile: <a2dp_sink_aac>
	sinks:
		bluez_sink.XX_XX_XX_XX_XX_XX.a2dp_sink/#3: WF-1000XM3
	sources:
		bluez_sink.XX_XX_XX_XX_XX_XX.a2dp_sink.monitor/#4: Monitor of WF-1000XM3
	ports:
		headset-output: Headset (priority 0, latency offset 0 usec, available: yes)
			properties:
				
		headset-input: Headset (priority 0, latency offset 0 usec, available: unknown)
			properties:

```

profiles の欄に選択可能なものが表示されます．available: no となっているものは使えません.
あとはBlueman(GUI)経由でprofile/codecを自分の好みにあった規格に設定するだけで完了です.

## Appendix: ビットレートとは

ビットレートは、動画の1秒あたりのデータ量を示す値です。 bps（bits per second）と表記され、1Mbpsに設定されている場合、1秒あたりデータ量が0.125MB（1byte＝8bit）の動画ということになります。 ビットレートが高い動画ほど、データ量が多く高画質です。

## References

- [Sony WF-1000XM3](https://www.sony.jp/headphone/products/WF-1000XM3/)
- [pulseaudio-modules-bt](https://github.com/EHfive/pulseaudio-modules-bt/wiki/Packages#ppaberglhpulseaudio-a2dp)
- [Linux PCではBluetoothにLDACコーデックが使えるらしい](https://enear555.blog.fc2.com/blog-entry-201.html)
- [Rubyと筋肉とギターとわたし > elementaryOSにbluetoothドライバが入ってなかったのでいれようとした](https://smot93516.hatenablog.jp/entry/2018/03/16/165420)
