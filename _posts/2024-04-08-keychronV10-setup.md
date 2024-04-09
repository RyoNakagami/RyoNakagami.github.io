---
layout: post
title: "Keychron V10 初期設定"
subtitle: "VIAを用いたKey remappingとキーボードマクロの設定"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-09
tags:

- Keyboard
- Ubuntu 22.04 LTS
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [想定環境](#%E6%83%B3%E5%AE%9A%E7%92%B0%E5%A2%83)
  - [ショートカット対象](#%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E3%82%AB%E3%83%83%E3%83%88%E5%AF%BE%E8%B1%A1)
- [Key remappingのための前準備](#key-remapping%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E5%89%8D%E6%BA%96%E5%82%99)
  - [V10 Max Knob Ansi(US) keymapの準備](#v10-max-knob-ansius-keymap%E3%81%AE%E6%BA%96%E5%82%99)
  - [`/dev/hidraw` デバイスの権限設定](#devhidraw-%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%81%AE%E6%A8%A9%E9%99%90%E8%A8%AD%E5%AE%9A)
- [Key remapping](#key-remapping)
  - [LAYER LEVEL 2での設定](#layer-level-2%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [Macro設定](#macro%E8%A8%AD%E5%AE%9A)
- [Appendix: `/dev/hidraw` デバイス](#appendix-devhidraw-%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9)
  - [HIDRAWはキャラクタデバイス](#hidraw%E3%81%AF%E3%82%AD%E3%83%A3%E3%83%A9%E3%82%AF%E3%82%BF%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 想定環境

- Browser: Google Chrome
- OS: Ubuntu 22.04.4 LTS

```zsh
% lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.4 LTS
Release:        22.04
Codename:       jammy
```

設定内容はキーボードに直接保存されるのでどのOSを用いていても, 実行手順は大きく異なりません. 
ただし, Browser上の[VIA](https://www.caniusevia.com/)経由でKey remappingを実行する際に`/dev/hidraw` デバイスの権限設定を行う必要があり, この箇所のみUbuntu特有の流れとなります.

### ショートカット対象

スクリーンレコーディング用ソフトのKazam Screen Recorderのショートカットキーをマクロキーとして今回設定しております.

```zsh
% apt-cache policy kazam             
kazam:
  Installed: 1.4.5-5
  Candidate: 1.4.5-5
  Version table:
 *** 1.4.5-5 500
        500 http://jp.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages
        500 http://jp.archive.ubuntu.com/ubuntu jammy/universe i386 Packages
        100 /var/lib/dpkg/status
```

Kazamではレコーディング時にスピーカーやマイクなどの入力デバイスから音声をキャッチするオプションがある, また以下のようなショートカットキーがあります. 今回は以下のショートカットキーをMacro Keyにアサインしています.

|ショートカット|動作|
|---|---|
|`Super + CTRL + R`|Start recording|
|`Super + CTRL + F`|Finish recording|
|`Super + CTRL + Q`|Quite recording|


## Key remappingのための前準備

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >環境準備</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

1. [the V10 Max Knob Ansi(US) keymap JSON File](https://cdn.shopify.com/s/files/1/0059/0630/1017/files/v10_max_ansi_encoder_v1.0.zip?v=1705905508)をダウンロードする
2. `sudo chown $USER:$USER /dev/hidraw1`を実行し, WebHID APIを実行できるようにする

</div>

### V10 Max Knob Ansi(US) keymapの準備

2024-04-08時点では, V10 MaxのVIAコードはまだ自動的に認識されません. V10 MaxのキーマップをVIAで動作させるには以下の手順を実行します:

1. [the V10 Max Knob Ansi(US) keymap JSON File](https://cdn.shopify.com/s/files/1/0059/0630/1017/files/v10_max_ansi_encoder_v1.0.zip?v=1705905508)をダウンロード
2. VIAを開いて,「Setting」タブで「Show Degin tab」をオン
3. 上記JSON fileを「Design」タブへドラッグ

### `/dev/hidraw` デバイスの権限設定

VIAでキーボードを認識させる際に以下のようなエラーに遭遇する場合があります.

```
21:16:46.347
    Failed to open the device.
    Device: Keychron Keychron V10 Max
    Vid: 0x0568
    Pid: 0x2119
21:16:46.357
    Received invalid protocol version from device
    Device: Keychron Keychron V10 Max
    Vid: 0x0568
    Pid: 0x2119
```

このときchromeで`chrome://device-log/`をアドレスバーに入力すると, 以下のようなログが見ることができます.

```zsh
chrome://device-log/
    [21:16:46] Failed to open '/dev/hidraw1': FILE_ERROR_ACCESS_DENIED
```

キーボード設定のため, `/dev/hidraw1`を開こうとしたら権限がなくて開けませんというエラーになります.
権限を確認してみると, rootユーザーしか開けないことが以下で分かります.

```zsh
% ls -l /dev/hidraw1 
crw-------  1 root root    240,     1 Apr 22 20:28 hidraw1
```

そのため, 一時的に権限を自分に以下のコマンドで付与します

```zsh
% sudo chown $USER:$USER /dev/hidraw1
```

上記実行後, VIAでキーボード設定が可能となります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#ffa657; background-color:#F8F8F8'>
<strong style="color:#ffa657">警告 !</strong> <br> 

本来的にはrootユーザーしか権限がないファイルなので, キーボード設定後は権限を修復するという観点で以下コマンドを実行してください:

```zsh
% sudo chown root:root /dev/hidraw1 
```

</div>

## Key remapping

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >設定内容一覧</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

Windows Modeについて以下の項目を設定

- `Insert` → `End` へ変更
- Knobをzoom-in, zoom-out, zoom-resetへ変更
- `Macro Key`にKazamのショートカットキーをアサイン
    - アプリ立ち上げ, Start Recording, Stop Recording, Quit the Kazam

</div>

最終的には以下のような配置へ変更しました.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/device/20240409_V10KeyMap.png?raw=true" alt="V10-keymap">


### LAYER LEVEL 2での設定

今回はWindows Modeの配列を変更するので, LAYER LEVEL 2での設定となります.

- LAYER LEVEL 0: Mac Mode
- LAYER LEVEL 1: Mac Mode fn mode
- LAYER LEVEL 2: Windows Mode
- LAYER LEVEL 3: Windows Mode fn mode

Keyの位置を変更する場合は, Layoutの変更対象キーをダブルクリックすると点滅するので, 
点滅確認後に変更先キーをkey listの中から選択することで実現できます.

### Macro設定

[Basic Keycodes](https://docs.qmk.fm/#/keycodes_basic)を参考にマクロにアサインする組み合わせを設定します.

|Macro action|Key setting|Ubuntu側でのショートカットキー|
|---|---|
|Kazam立ち上げ|`{KC_LGUI,KC_6}`|`super + 6`|
|Kazam Start Recording|`{KC_LCTL,KC_LGUI,KC_R}`|`ctrl + super + R`|
|Kazam Stop Recording|`{KC_LCTL,KC_LGUI,KC_R}`|`ctrl + super + F`|
|Quit Kazam|`{KC_LCTL,KC_LGUI,KC_Q}`|`ctrl + super + Q`|
|zoom in|`{KC_LCTL,KC_EQL}`|`ctrl + +`|
|zoom out|`{KC_LCTL,KC_MINS}`|`ctrl + -`|
|zoom reset|`{KC_LCTL,KC_0}`|`ctrl + 0`|

## Appendix: `/dev/hidraw` デバイス

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>HIDRAW - Raw Access to USB and Bluetooth Human Interface Devices</ins></p>

- HID ( Human Interface Device ) とは, 人間から入力を受けたり, 人間に出力を提供したりする装置のこと
- HIDRAWは USBやBluetooth HID用のドライバーのこと

</div>

特に, インストールや設定手順を簡略化するために設計された, ホストとデバイス間の双方向通信のための標準規格のことをとくにHIDプロトコルと呼びます. HID プロトコルはもともと USB デバイス用に開発されたものですが, その後 Bluetooth をはじめとする多くのプロトコルで実装されたという流れがあり, 「HIDRAWは USBやBluetooth HID用のドライバー」という現在に至っております.

ホストとデバイスの通信にあたって, HIDリポートを介して情報のやり取りを行います.

|項目|説明|
|---|---|
|**HID レポート**|ホストとデバイス間で通信されるバイナリデータパケットのこと. 入力レポートはデバイスからホストに送信され, 出力レポートはホストからデバイスに送信されます. HID レポートのフォーマットはデバイス固有のもの|
|**HID レポート記述子**|デバイスの列挙中にホストから要求することができます. レポート記述子は, デバイスがサポートするレポートのバイナリ形式を記述します. 記述子のフォーマットは HID 仕様で定義されています|
|**HID usage**| 標準化された入力または出力を参照する数値. Usage の値を使用することで, デバイスはレポートの各フィールドの目的と同様に, デバイス自体の意図された使用法を記述することができます.|


### HIDRAWはキャラクタデバイス

```zsh
% ls -l /dev/hidraw1 
crw-------  1 root root    240,     1 Apr 22 20:28 hidraw1
```

`/dev`ディレクトリ以下にはデバイスファイルが格納されていますが, `/dev/hidraw`は上記コマンドで一列目に`c`という文字があることから, `/dev`にキャラクタデバイスとして格納されていることがわかります.

キャラクタデバイスとは, データの入出力をバイト（1文字）単位で扱うデバイスです. キャラクタデバイスファイルを介して, アプリケーションはバッファリングなしで直接デバイスとデータを交換できるため, 逐次的でリアルタイムなデータ処理が可能となります. キーボードやマウスがキャラクターデバイスの代表例です. 



References
----------
- [Keychron V10 Max](https://www.keychron.com/products/keychron-v10-max-qmk-via-wireless-custom-mechanical-keyboard)
- [VIA](https://www.caniusevia.com/)
- [Basic Keycodes](https://docs.qmk.fm/#/keycodes_basic)