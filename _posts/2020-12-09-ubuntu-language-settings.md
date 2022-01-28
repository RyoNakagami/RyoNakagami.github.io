---
layout: post
title: "Ubuntu Desktop環境構築 Part 2"
subtitle: "Ubuntuのディレクトリ名をEnglishにrename & 日本語入力環境を整える"
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

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [2. 日本語のディレクトリ/アプリをEnglishにrenameする](#2-%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92english%E3%81%ABrename%E3%81%99%E3%82%8B)
  - [ロケールとは？](#%E3%83%AD%E3%82%B1%E3%83%BC%E3%83%AB%E3%81%A8%E3%81%AF)
  - [`etc`などの主要なディレクトリ](#etc%E3%81%AA%E3%81%A9%E3%81%AE%E4%B8%BB%E8%A6%81%E3%81%AA%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA)
- [3. 日本語入力設定](#3-%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%85%A5%E5%8A%9B%E8%A8%AD%E5%AE%9A)
  - [入力ソースの設定](#%E5%85%A5%E5%8A%9B%E3%82%BD%E3%83%BC%E3%82%B9%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ

1. 日本語のディレクトリ/アプリをEnglishにrenameする
2. 日本語入力設定

なお前提としてUSキーボードを使用しています。

## 2. 日本語のディレクトリ/アプリをEnglishにrenameする

Ubuntuインストール直後の言語設定において、日本語を選択するとホームディレクトリ直下のディレクトリが日本語で表記されてしまう/Terminalなどが「端末」と表記されるという問題があります。ファイル名が日本語だとTerminalでのファイル操作に不安がある&「端末」が直感的にわかりづらいので、日本語で命名されたディレクトリ/アプリをEnglishにrenameします。

まず、念のため

```
$ sudo apt update && sudo apt upgrade -y
```

次にディレクトリ名のrenameを実行する。コマンドは以下、

```
$ LANG=C xdg-user-dirs-gtk-update
```

ターミナル上で実行すればその後ポップアップが表示され、変更前と変更後の内容が表示されるので、確認し決定すればディレクトリはリネームされます。

次にアプリケーションの表記を英語に変更します。ロケールファイルを設定するだけでおしまいです。まずロケールファイルを`nano`で開きます。

```
$ nano /etc/default/locale
```

その後、

```
LANG="en_US.UTF-8"
LANGUAGE="en_US:en"
```

と書き換え保存するだけで終了です。Terminalを立ち上げ直して`date`コマンドで英語表記で時間が出力されるか確認でこのタスクは終了。

### ロケールとは？

言語、地域慣例(金額・日時などの表示形式)の設定のこと。

### `etc`などの主要なディレクトリ

|ディレクトリ|役割|
|---|---|
|`bin`|バイナリ形式の実行ファイルやコマンドが保管されています|
|`dev`|デバイス関係のファイルが保管されています|
|`etc`|各種設定ファイルなどが保管される場所です|
|`root`|ルートディレクトリとは別に用意された、システム管理者用のホームディレクトリ。|
|`sbin`|管理者用のシステム標準コマンドが保管されています。|
|`usr`|各ユーザーのデータやアプリケーションが保管される場所です。|
|`home`|この下にユーザー毎のディレクトリが作られ、そこが各ユーザーのホームディレクトリになります|
|`var`|アプリケーションのログファイルやメールデータが保管される場所。|

## 3. 日本語入力設定

起動時は日本語入力に切り替えた際にどうしても「直接入力」が基準になってしまう問題があります。これにより、初回の日本語入力の際にはわざわざマウスにて直接入力モードを変えなければいけません。Ubuntu起動時から『半角英数字（A）』と『ひらがな（あ）』で切り替えが可能な設定を目指します。

### 入力ソースの設定

USキーボードの使用に関係無く、入力ソースを Mozc 1つにします。上記画像の「設定」ウィンドウを開き、「地域と言語」項目より入力ソースを『日本語（Mozc）』のみにします。

USキーボード設定をしている場合、`Settings`の`Region&Language`は以下のようになっています。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201209_ubuntu_japanese_01.png?raw=true">

USキーボードの使用に関係無く、入力ソースを Mozc 1つにします。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201209_ubuntu_japanese_02.png?raw=true">

次に、画面右上の入力モードをクリックし、`Tools`の`Properties`を開きます。そして、`Keymap`を編集します。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201209_ubuntu_japanese_03.png?raw=true">

`Hankaku/Zenkaku`入力キーが各モードの4箇所で割り当てられていますが、これらを全て希望するショートカットキーに変更すれば良いです。また`Hiragana`キーを削除しておきます。ショートカットキー変更のやり方としては、各モードの「入力キー」項目の所で3回クリックし、希望するショートカットを打ち込むだけで変更することができます。

なお、Mozc キーバインディング設定ではAltキーの使用が認められていないことに注意が必要です。そのため僕は`Ctrl`+`Space`とMacと同じ設定にしました。

各種設定が終わったらTerminalで`reboot`と打ち込み、変更内容が反映されているか再起動後確認して終了です。

## References

- [ロケール: 言語、地域の設定](hhttps://memo.open-code.club/Linux/locale.html)|
- [Windows PCにUbuntu 20.04 LTS (Focal Fossa)をインストールする](https://ryonakagami.github.io/2020/12/07/ubuntu-setup/)|
