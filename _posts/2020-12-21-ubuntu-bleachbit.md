---
layout: post
title: "Ubuntu Desktop環境構築 Part 8"
subtitle: "キャッシュ削除ツール Bleachbitのインストール"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- dpkg
- ファイルクリーナー
---

||概要|
|---|---|
|目的|キャッシュ削除ツール Bleachbitのインストール|
|参考|[Bleackbit deb packagesダウンロードサイト](https://www.bleachbit.org/download/linux)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [方針](#%E6%96%B9%E9%87%9D)
- [2. Bleachbitとは？](#2-bleachbit%E3%81%A8%E3%81%AF)
  - [Use case](#use-case)
- [3. Bleachbitのインストール](#3-bleachbit%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Bleachbit使用方針](#4-bleachbit%E4%BD%BF%E7%94%A8%E6%96%B9%E9%87%9D)
  - [DOM Storageとは](#dom-storage%E3%81%A8%E3%81%AF)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

不要ファイル削除ツールBleachbitをインストールする

### 方針

1. Bleachbit deb packagesをダウンロード
2. `dpkg`コマンドでパッケージをインストール

## 2. Bleachbitとは？

Bleachbitは.DS_Storeファイルなどのシステムファイルやダウンロード履歴や閲覧履歴などのログ・キャッシュファイルをGUIで簡単に削除できるディスククリーンアップツールです。

### Use case

- Disk spaceの開放
- 閲覧履歴など個人情報にかかるファイルを消すことでprivacyを守ることができる
- 不要なキャッシュの削除によるシステムパフォーマンスの向上

## 3. Bleachbitのインストール

まず[公式ページ](https://www.bleachbit.org/download/linux)でUbuntu 20.04用の最新のversionを確認すると、`bleachbit_4.0.0_all_ubuntu1904.deb`とのこと。まずこれが`apt repository`に登録されているか確認する。

```
$ apt-cache policy bleachbit
bleachbit:
  Installed: (none)
  Candidate: 3.9.0
  Version table:
     3.9.0-1 500
        500 http://jp.archive.ubuntu.com/ubuntu focal/universe amd64 Packages
        500 http://jp.archive.ubuntu.com/ubuntu focal/universe i386 Packages
```

バージョンが古いことがわかる。公式ページも `The version of BleachBit in the repositories of many Linux distributions is often stale, so to use the best and latest version, use the packages below.`といっており、今回は公式ページから`.deb`ファイルをダウンロードして、package installしたいと思います。まず、`.deb`ファイルをダウンロードします。

```
$ mkdir ~/deb_packages
$ cd ~/deb_packages
$ wget https://download.bleachbit.org/bleachbit_4.0.0_all_ubuntu1910.deb
```

次にpackageをインストールします

```
$ sudo dpkg -i bleachbit_4.0.0_all_ubuntu1904.deb
```

`/usr/bin/bleachbit`がどのパッケージからインストールされたか一応確認する

```
$ which bleachbit | xargs dpkg -S
bleachbit: /usr/bin/bleachbit
```

## 4. Bleachbit使用方針

基本的にはインターネットブラウザの以下の項目を削除します

- Cache
- Cookies
- Crash reports
- DOM Storage

### DOM Storageとは

DOM Storageはブラウザがローカルに持つストレージにデータを保存することができる仕組みです。従来、ウェブアプリケーションが何らかのデータを永続化するにはCookieを利用するか、そうでなければサーバ側のストレージに保持しておく必要がありました。DOM Storageよって、そのような様々な情報をローカル側に保存しておくことができるようになります。

DOM StorageはWindowオブジェクトの属性として定義されており、次の2種類のオブジェクトが用意されています。

- sessionStorage - ウィンドウ（タブ）を閉じるまでデータが保持される
- localStorage - ウィンドウ（タブ）を閉じた後もデータが保持される

