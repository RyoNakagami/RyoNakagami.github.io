---
layout: post
title: "Ubuntu Desktop環境構築 Part 1"
subtitle: "Windows PCにUbuntu 20.04 LTS (Focal Fossa)をインストールする"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
---

|概要||
|---|---|
|目的|Windows 10 Proをアンインストールして、代わりにUbuntu 20.04 LTSをインストールする<br> Ubuntu install後の設定は別の記事で解説|
|参考|[Ubuntu Desktopインストールチュートリアル](https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview)<br>[Ubuntu Tutorials](https://ubuntu.com/tutorials?topic=desktop)<br>[Ubuntu Desktop image](http://jp.releases.ubuntu.com/focal/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. 環境](#1-%E7%92%B0%E5%A2%83)
- [2. 今回の環境構築のスコープ](#2-%E4%BB%8A%E5%9B%9E%E3%81%AE%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [なぜUbuntu 20.04 LTSに変更するのか？](#%E3%81%AA%E3%81%9Cubuntu-2004-lts%E3%81%AB%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)
  - [なぜLVMを用いないのか？](#%E3%81%AA%E3%81%9Clvm%E3%82%92%E7%94%A8%E3%81%84%E3%81%AA%E3%81%84%E3%81%AE%E3%81%8B)
  - [今後の予定](#%E4%BB%8A%E5%BE%8C%E3%81%AE%E4%BA%88%E5%AE%9A)
- [3. Requirements](#3-requirements)
- [4. 作業手順概要](#4-%E4%BD%9C%E6%A5%AD%E6%89%8B%E9%A0%86%E6%A6%82%E8%A6%81)
- [5. Rufus: USB Installerの作成方法](#5-rufus-usb-installer%E3%81%AE%E4%BD%9C%E6%88%90%E6%96%B9%E6%B3%95)
- [6. HP BIOSの設定](#6-hp-bios%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [7. Ubuntu初期設定](#7-ubuntu%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
  - [インストールタイプ、アップデートのダウンロード、サードパーティソフトウェアのインストール設定](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%82%BF%E3%82%A4%E3%83%97%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E3%81%AE%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%82%B5%E3%83%BC%E3%83%89%E3%83%91%E3%83%BC%E3%83%86%E3%82%A3%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E8%A8%AD%E5%AE%9A)
- [Appendix: To-Do List](#appendix-to-do-list)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 環境

|項目||
|---|---|
|デバイス|HP ENVY TE01-0xxx|
|OS|ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM|32.0 GB|
|GPU|NVIDIA GeForce RTX 2060 SUPER|
|キーボード|Microsoft Ergonomic Desktop US配列|
|マウス|Logicool M570|
|起動ディスク作成ソフト|Rufus|

## 2. 今回の環境構築のスコープ

今回は個人用のDesktop PCをWindows 10 ProからUbuntu 20.04 LTSに変更します。パーティションをLVMにするかの選択が最初にありますが、個人用かつSSD/HDDの構成を変える予定もないので、ext4のパーティションを利用します。

### なぜUbuntu 20.04 LTSに変更するのか？

- GPUを使った機械学習環境を構築したかったため。
- Pytorchの練習環境を作成したかった。
- ストレスのない環境でDockerの練習環境を作成したかった。
- PC Gameは結局やらなかった。

### なぜLVMを用いないのか？

- ハードディスクをそのままext4でフォーマットするのと比べると、間にLVMがはいるので設定など構築が分かりにくくなるのと、パフォーマンスも落ちてしまう
- HDD増設は予定していない。

### 今後の予定

1. Security設定（ファイアウォール設定、Security update設定 etc）
2. GPU活用&機械学習環境構築のため` Nvidia driver, Cuda, cuDNN, TensorFlow, Keras & PyTorch`のインストール
3. 必要アプリケーション(VScodeなど)のインストール

以上を予定しています。

## 3. Requirements

1. 2 GHz dual core processor
2. 4 GiB RAM (system memory)
3. 25 GB of hard-drive space (or USB stick, memory card or external drive)
4. グラフィックカードと1024×768モニター
5. インストーラーメディア用のCD/DVD drive または USB portへのアクセス

## 4. 作業手順概要

1. ubuntu 20.04 LTSを[ダウンロード](http://jp.releases.ubuntu.com/focal/)
2. ダウンロードしたイメージファイルをUSBメモリに焼き、インストーラーを作成する
3. 作成したインストールUSBメディアからUbuntuを起動するため、Windows PCを再起動
4. BIOSの設定を修正して、ubuntu 20.04 LTSインストーラーUSBデバイスからUbuntu installerを起動する。
5. Ubuntu初期設定を行う。

この画面が出てくればもう安心。

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201207_ubuntu_installer.jpg?raw=true">

## 5. Rufus: USB Installerの作成方法

1. 予めUSBメディアをUSBポートに挿入する。
2. [こちら](https://rufus.ie/)からRufus実行ファイルをダウンロードする。
3. Rufus（`rufus-3.13.exe`）を起動する。特に理由はないが、最初の自動確認機能は無効にする。

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201207_rufus_01.jpg?raw=true">

4. ブートの種類の「選択」ボタンをクリックしてダウンロードしたUbuntuのインストールイメージファイルを選択
5. Ubuntuのインストールイメージファイルを選択するとその他の設定値が自動で決まるので設定値はそのままで「スタート」ボタンをクリック
6. ダウンロードが必要なものはダウンロードする
7. ハイブリッドISOイメージの検出のダイアログが表示されますので「ISOイメージモードで書き込む」を選択し、「OK」ボタンをクリック

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201207_rufus_02.jpg?raw=true">

## 6. HP BIOSの設定

1. HPロゴが出た瞬間にに`F10`を入力し、boot menuを立ち上げる
2. 「レガシーサポート」を有効にする。
3. セキュアブートを無効にする。
4. Boot menuの設定を保存する。
5. USBドライブで、POSTプロセスをHPロゴ中に`F9`を押して中断します。青いブートBIOSブートデバイス画面が表示されます。

## 7. Ubuntu初期設定

基本的には[こちらのチュートリアル](https://ubuntu.com/tutorials/install-ubuntu-desktop#3-boot-from-dvd)に従って実行するのみ。

### インストールタイプ、アップデートのダウンロード、サードパーティソフトウェアのインストール設定

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201208_ubuntu_installer_02.jpg?raw=true">

- `Normal installation`を選ぶと、LibreOffice、Thunderbird、ビデオ（Totem）、写真管理（Shotwell）、バックアップ（Déjà Dup）などのデフォルトアプリがインストールされます。通常はこちらを選択します。
- `Download updaytes while installing Ubuntu`は、インターネットにつながっているならデフォルトでチェックが入ります。インストール中にアップデートがダウンロードされ、セキュリティホールやバグが解消された状態で使い始めることができます。
- `Install third-party software`をチェックすれば、商用のドライバやデコーダーなどがインストールされます。

## Appendix: To-Do List

|Roadmap|記事|
|---|---|
|日本語環境整備|[Ubuntu Desktop 環境構築 Part 2](https://ryonakagami.github.io/2020/12/09/ubuntu-language-settings/)|
|マルチディスプレイ設定 & 表示設定（時計とDock）|TBA|
|セキュリティ対策|TBA|
|zsh setup|TBA|
|git setup|TBA|
|VScode setup||
