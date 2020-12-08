---
layout: post
title: "Ubuntu Desktop環境の構築 Part 1"
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
- [2. Requirements](#2-requirements)
- [3. 作業手順概要](#3-%E4%BD%9C%E6%A5%AD%E6%89%8B%E9%A0%86%E6%A6%82%E8%A6%81)
- [4. Rufus: USB Installerの作成方法](#4-rufus-usb-installer%E3%81%AE%E4%BD%9C%E6%88%90%E6%96%B9%E6%B3%95)
- [5. HP BIOSの設定](#5-hp-bios%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [6. Ubuntu初期設定](#6-ubuntu%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
  - [インストールタイプ、アップデートのダウンロード、サードパーティソフトウェアのインストール設定](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%82%BF%E3%82%A4%E3%83%97%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E3%81%AE%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%82%B5%E3%83%BC%E3%83%89%E3%83%91%E3%83%BC%E3%83%86%E3%82%A3%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E8%A8%AD%E5%AE%9A)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 環境

|項目||
|---|---|
|デバイス|HP ENVY TE01-0xxx|
|OS|ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel COre i7-9700 CPU 3.00 GHz|
|RAM|32.0 GB|
|GPU|NVIDIA GeForce FTX 2060 SUPER|
|起動ディスク作成ソフト|Rufus|

## 2. Requirements

1. 2 GHz dual core processor
2. 4 GiB RAM (system memory)
3. 25 GB of hard-drive space (or USB stick, memory card or external drive)
4. グラフィックカードと1024×768モニター
5. インストーラーメディア用のCD/DVD drive または a USB portへのアクセス

## 3. 作業手順概要

1. ubuntu 20.04 LTSを[ダウンロード](http://jp.releases.ubuntu.com/focal/)
2. ダウンロードしたイメージファイルをUSBメモリに焼き、インストーラーを作成する
3. 作成したインストールUSBメディアからUbuntuを起動するため、Windows PCを再起動
4. BIOSの設定を修正して、ubuntu 20.04 LTSインストーラーUSBデバイスからUbuntu installerを起動する。
5. Ubuntu初期設定を行う。

この画面が出てくればもう安心。

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201207_ubuntu_installer.jpg?raw=true">

## 4. Rufus: USB Installerの作成方法

1. 予めUSBメディアをUSBポートに挿入する。
2. [こちら](https://rufus.ie/)からRufus実行ファイルをダウンロードする。
3. Rufus（`rufus-3.13.exe`）を起動する。特に理由はないが、最初の自動確認機能は無効にする。

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201207_rufus_01.jpg?raw=true">

4. ブートの種類の「選択」ボタンをクリックしてダウンロードしたUbuntuのインストールイメージファイルを選択
5. Ubuntuのインストールイメージファイルを選択するとその他の設定値が自動で決まるので設定値はそのままで「スタート」ボタンをクリック
6. ダウンロードが必要なものはダウンロードする
7. ハイブリッドISOイメージの検出のダイアログが表示されますので「ISOイメージモードで書き込む」を選択し、「OK」ボタンをクリック

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201207_rufus_02.jpg?raw=true">

## 5. HP BIOSの設定

1. HPロゴが出た瞬間にに`F10`を入力し、boot menuを立ち上げる
2. 「レガシーサポート」を有効にする。
3. セキュアブートを無効にする。
4. Boot menuの設定を保存する。
5. USBドライブで、POSTプロセスをHPロゴ中に`F9`を押して中断します。青いブートBIOSブートデバイス画面が表示されます。

## 6. Ubuntu初期設定

基本的には[こちらのチュートリアル](https://ubuntu.com/tutorials/install-ubuntu-desktop#3-boot-from-dvd)に従って実行するのみ。

### インストールタイプ、アップデートのダウンロード、サードパーティソフトウェアのインストール設定

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/installer/20201208_ubuntu_installer_02.jpg?raw=true">

- `Normal installation`を選ぶと、LibreOffice、Thunderbird、ビデオ（Totem）、写真管理（Shotwell）、バックアップ（Déjà Dup）などのデフォルトアプリがインストールされます。通常はこちらを選択します。
- `Download updaytes while installing Ubuntu`は、インターネットにつながっているならデフォルトでチェックが入ります。インストール中にアップデートがダウンロードされ、セキュリティホールやバグが解消された状態で使い始めることができます。
- `Install third-party software`をチェックすれば、商用のドライバやデコーダーなどがインストールされます。


