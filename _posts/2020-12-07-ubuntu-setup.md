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

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>


**Table of Contents**
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
- [Appendix. 導入アプリケーション・ソフト・プログラミング言語](#appendix-%E5%B0%8E%E5%85%A5%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%83%BB%E3%82%BD%E3%83%95%E3%83%88%E3%83%BB%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E8%A8%80%E8%AA%9E)
- [References](#references)

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
|カメラ|Logicool C920n HD Pro ウェブカメラ|
|スピーカー|Creative T30 Wireless|
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

|Roadmap|記事|
|---|---|
|Ubuntu 20.04 LTS (Focal Fossa)をインストール(今回！)|[Ubuntu Desktop環境構築 Part 1](https://ryonakagami.github.io/2020/12/07/ubuntu-setup/)|
|日本語環境整備|[Ubuntu Desktop 環境構築 Part 2](https://ryonakagami.github.io/2020/12/09/ubuntu-language-settings/)|
|マルチディスプレイ設定 & 表示設定（時計とDock）|[Ubuntu Desktop 環境構築 Part 3](https://ryonakagami.github.io/2020/12/11/ubuntu-display/)|
|セキュリティ対策: ファイヤウォールの設定|[Ubuntu Desktop 環境構築 Part 4](https://ryonakagami.github.io/2020/12/16/ubuntu-security/)|
|リモートアクセス設定：VPN設定とWoL設定とssh|[Ubuntu Desktop 環境構築 Part 5](https://ryonakagami.github.io/2020/12/17/ubuntu-network-setting/)|
|セキュリティ対策: システム診断設定・ウイルス対策|[Ubuntu Desktop 環境構築 Part 6](https://ryonakagami.github.io/2020/12/18/ubuntu-security-part2/)|
|zsh setup|[Ubuntu Desktop環境構築 Part 10](https://ryonakagami.github.io/2020/12/23/ubuntu-zshsetup/)|


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

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201207_ubuntu_installer.jpg?raw=true">

## 5. Rufus: USB Installerの作成方法

1. 予めUSBメディアをUSBポートに挿入する。
2. [こちら](https://rufus.ie/)からRufus実行ファイルをダウンロードする。
3. Rufus（`rufus-3.13.exe`）を起動する。特に理由はないが、最初の自動確認機能は無効にする。

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201207_rufus_01.jpg?raw=true">

4. ブートの種類の「選択」ボタンをクリックしてダウンロードしたUbuntuのインストールイメージファイルを選択
5. Ubuntuのインストールイメージファイルを選択するとその他の設定値が自動で決まるので設定値はそのままで「スタート」ボタンをクリック
6. ダウンロードが必要なものはダウンロードする
7. ハイブリッドISOイメージの検出のダイアログが表示されますので「ISOイメージモードで書き込む」を選択し、「OK」ボタンをクリック

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201207_rufus_02.jpg?raw=true">

## 6. HP BIOSの設定

1. HPロゴが出た瞬間にに`F10`を入力し、boot menuを立ち上げる
2. 「レガシーサポート」を有効にする。
3. セキュアブートを無効にする。
4. Boot menuの設定を保存する。
5. USBドライブで、POSTプロセスをHPロゴ中に`F9`を押して中断します。青いブートBIOSブートデバイス画面が表示されます。

## 7. Ubuntu初期設定

基本的には[こちらのチュートリアル](https://ubuntu.com/tutorials/install-ubuntu-desktop#3-boot-from-dvd)に従って実行するのみ。

### インストールタイプ、アップデートのダウンロード、サードパーティソフトウェアのインストール設定

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/installer/20201208_ubuntu_installer_02.jpg?raw=true">

- `Normal installation`を選ぶと、LibreOffice、Thunderbird、ビデオ（Totem）、写真管理（Shotwell）、バックアップ（Déjà Dup）などのデフォルトアプリがインストールされます。通常はこちらを選択します。
- `Download updaytes while installing Ubuntu`は、インターネットにつながっているならデフォルトでチェックが入ります。インストール中にアップデートがダウンロードされ、セキュリティホールやバグが解消された状態で使い始めることができます。
- `Install third-party software`をチェックすれば、商用のドライバやデコーダーなどがインストールされます。

## Appendix. 導入アプリケーション・ソフト・プログラミング言語

|項目|詳細|関連記事|
|---|---|---|
|main shell|zsh|[Ubuntu Desktop環境構築 Part 10](https://ryonakagami.github.io/2020/12/23/ubuntu-zshsetup/)|
|shell script用shell|bash||
|Terminalソフト|Terminator|[Ubuntu Desktop環境構築 Part 9](https://ryonakagami.github.io/2020/12/22/ubuntu-terminator/)|
|キャッシュ削除ツール|bleachbit|[Ubuntu Desktop環境構築 Part 8](https://ryonakagami.github.io/2020/12/21/ubuntu-bleachbit/)|
|Web Browser main|Firefox||
|Web Browser sub|Google Chrome||
|ファイル共有ソフト|google drive ocamlfuse|[Ubuntu Desktop環境構築 Part 7](https://ryonakagami.github.io/2020/12/19/ubuntu-google-drive-setup/)|
|カレンダー|Google Calender||
|ToDo管理|Google Keep||
|Web会議サービス|Zoom||
|ビジネス用チャットツール|Slack||
|チャットツール|Discord|[Ubuntu Desktop環境構築 Part 15 Discordのインストールと使い方](https://ryonakagami.github.io/2021/02/02/ubuntu-discord-setup/)|
|Text editor main|Visual Studio Code|[Ubuntu Desktop環境構築 Part 24](https://ryonakagami.github.io/2021/12/08/ubuntu-keyboard-setting/)|
|Text editor sub|vim|[Ubuntu Desktop環境構築 Part 21](https://ryonakagami.github.io/2021/04/27/ubuntu-vim-tutorial/)|
|分散型バージョン管理システム|Git|[Ubuntu Desktop環境構築 Part 13](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/)<br>[Githubパスワード認証廃止への対応](https://ryonakagami.github.io/2021/04/25/github-token-authentication/)|
|データベースサーバー|PostgreSQL||
|統計・機械学習用プログラミング言語|Python||
|ジェネラティブアート|Processing|[Ubuntu Desktop環境構築 Part 17 Processing 3.5.4の導入](https://ryonakagami.github.io/2021/04/07/ubuntu-processing/)|
|統計解析用プログラミング言語|R||
|数値計算用プログラミング言語|Julia||
|競技プログラミング用|C, C++|[C言語練習環境の作成](https://ryonakagami.github.io/2021/01/04/setup-C-language-dev-env/)|
|記述統計用分析環境|JupyterLab||
|R言語用開発環境|RStudio||
|コンテナ|Docker|[Ubuntu Desktop環境構築 Part 14](https://ryonakagami.github.io/2021/01/27/ubuntu-docker-setup/)|
|静的サイトジェネレーター|Jekyll|[Ubuntu Desktop環境構築 Part 12](https://ryonakagami.github.io/2020/12/27/ubuntu-jekyll-install/)|
|Markdown 目次作成パッケージ|doctoc|[Ubuntu Desktop環境構築 Part 11](https://ryonakagami.github.io/2020/12/26/ubuntu-doctoc/)|
|ファイル圧縮ソフト|7-zip|[Ubuntu Desktop環境構築 Part 10](https://ryonakagami.github.io/2020/12/23/ubuntu-zshsetup/)|
|C/C++コンパイラ|GCC|[C言語練習環境の作成](https://ryonakagami.github.io/2021/01/04/setup-C-language-dev-env/)|
|DVD再生ソフト|VLC media player|[Ubuntu 20.04 LTS vlc Ubuntu Desktop環境構築 Part 18](https://ryonakagami.github.io/2021/04/09/ubuntu-dvdsetup/)|
|PC Game|Steam||

## References

- [Ubuntu Desktopインストールチュートリアル](https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview)
- [Ubuntu Tutorials](https://ubuntu.com/tutorials?topic=desktop)
- [Ubuntu Desktop image](http://jp.releases.ubuntu.com/focal/)|
