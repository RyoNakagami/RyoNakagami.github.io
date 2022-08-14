---
layout: post
title: "Ubuntuのディレクトリ名をEnglishにrename & 日本語入力環境を整える"
subtitle: "Ubuntu Desktop環境構築 Part 2"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revised_date: 2022-07-31 
tags:

- Ubuntu 20.04 LTS
- Linux
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [2. 日本語のディレクトリ/アプリをEnglishにrenameする](#2-%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92english%E3%81%ABrename%E3%81%99%E3%82%8B)
  - [Rename File/Directory実践編](#rename-filedirectory%E5%AE%9F%E8%B7%B5%E7%B7%A8)
  - [アプリケーションの表記の変更](#%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E8%A1%A8%E8%A8%98%E3%81%AE%E5%A4%89%E6%9B%B4)
  - [ロケールとは？](#%E3%83%AD%E3%82%B1%E3%83%BC%E3%83%AB%E3%81%A8%E3%81%AF)
- [3. 日本語入力設定](#3-%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%85%A5%E5%8A%9B%E8%A8%AD%E5%AE%9A)
  - [入力ソースの設定](#%E5%85%A5%E5%8A%9B%E3%82%BD%E3%83%BC%E3%82%B9%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [Appendix](#appendix)
  - [`etc`などの主要なディレクトリ](#etc%E3%81%AA%E3%81%A9%E3%81%AE%E4%B8%BB%E8%A6%81%E3%81%AA%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ

1. 日本語のディレクトリ/アプリをEnglishにrenameする
2. 日本語入力設定

なお前提としてUSキーボードを使用しています。

> なぜrenameわざわざするの？

- GUIでの操作であればフォルダ名が日本語になっていても問題ないですが, CLIではかな漢字の変換作業を行わなければならなず面倒だから


## 2. 日本語のディレクトリ/アプリをEnglishにrenameする

Ubuntuインストール直後の言語設定において, 日本語を選択するとホームディレクトリ直下のディレクトリが日本語で表記されてしまう, またはTerminalなどが「端末」と表記されるという問題があります. ファイル名が日本語だとTerminalでのファイル操作に不安がある&「端末」が直感的にわかりづらいので, 日本語で命名されたディレクトリ/アプリをEnglishにrenameします。

### Rename File/Directory実践編

```zsh
% sudo apt update && sudo apt upgrade -y
```

次にディレクトリ名のrenameを実行する。コマンドは以下、

```zsh
% LANG=C xdg-user-dirs-gtk-update ### ポップアップをなしにしたい場合は --force オプションを加える
```

ターミナル上で実行すればその後ポップアップが表示され、変更前と変更後の内容が表示されるので、確認し決定すればディレクトリはリネームされます。

### アプリケーションの表記の変更

システムワイドなロケール設定を今回は実行したいので, `etc/default/locale`に存在するロケールファイルを`nano`で開きます。

```
$ nano /etc/default/locale
```

その後、

```
LANG="en_US.UTF-8"
LANGUAGE="en_US:en"
```

と書き換え保存するだけで設定は終了です.

最後に, Terminalを立ち上げ直して`date`コマンドで英語表記で時間が出力されるか確認でこのタスクは終了。

```zsh
% date
Sat 12 Dec 2020 09:32:31 PM JST
% date -u
Sat 12 Dec 2020 00:32:35 PM UTC
```

> `update-locale` コマンドを用いた変更

`update-locale` コマンドを使用した場合, 設定内容を `/etc/default/locale` に書き出す前に,
設定された各ロケール値が実行環境において有効なものか否かのチェックが実施されます.
ですので直接ファイルを編集するのではなく, コマンドを用いた設定変更が推奨されます.

```
% update-locale LANG=en_US.UTF-8
% update-locale LANGUAGE=en_US:en
```

### ロケールとは？

ロケールとは, 言語や通貨などを含めた地域情報のことです. `locale`コマンドを用いると現在の設定が確認できます.

```zsh
% locale
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=en_US.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_ALL=
```

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

## Appendix 
### `etc`などの主要なディレクトリ

|ディレクトリ|役割|
|---|---|
|`bin`|バイナリ形式の実行ファイルやコマンドが保管されています|
|`dev`|デバイス関係のファイルが保管されています|
|`etc`|各種設定ファイルなどが保管される場所です|
|`root`|ルートディレクトリとは別に用意された、システム管理者用のホームディレクトリ.|
|`sbin`|管理者用のシステム標準コマンドが保管されています.|
|`usr`|各ユーザーのデータやアプリケーションが保管される場所です.|
|`home`|この下にユーザー毎のディレクトリが作られ、そこが各ユーザーのホームディレクトリになります|
|`var`|アプリケーションのログファイルやメールデータが保管される場所.|

> treeコマンドを用いてディレクトリーツリーの確認

```zsh
% tree -L 1 -d  
. ### root directory
├── bin -> usr/bin
├── boot
├── cdrom
├── dev
├── etc
├── home
├── lib -> usr/lib
├── lib32 -> usr/lib32
├── lib64 -> usr/lib64
├── libx32 -> usr/libx32
├── lost+found
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin -> usr/sbin
├── snap
├── srv
├── sys
├── tmp
├── usr
└── var

```

## References

> コマンドソースコード

- [xdg-user-dirs-gtk-update](https://gitlab.gnome.org/GNOME/xdg-user-dirs-gtk)

> オンラインマテリアル

- [ロケール: 言語、地域の設定](hhttps://memo.open-code.club/Linux/locale.html)|
- [Windows PCにUbuntu 20.04 LTS (Focal Fossa)をインストールする](https://ryonakagami.github.io/2020/12/07/ubuntu-setup/)|

> 書籍

- [UNIXの絵本, 株式会社アンク著](https://www.shoeisha.co.jp/book/detail/4798109339)