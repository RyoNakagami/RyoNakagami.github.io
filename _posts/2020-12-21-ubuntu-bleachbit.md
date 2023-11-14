---
layout: post
title: "キャッシュ削除ツール Bleachbitのインストール"
subtitle: "Ubuntu Desktop環境構築 Part 8"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-07-11
tags:

- Ubuntu 20.04 LTS
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
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
- [Appendix: Firefoxのキャッシュ設定しないと大変なことになる件](#appendix-firefox%E3%81%AE%E3%82%AD%E3%83%A3%E3%83%83%E3%82%B7%E3%83%A5%E8%A8%AD%E5%AE%9A%E3%81%97%E3%81%AA%E3%81%84%E3%81%A8%E5%A4%A7%E5%A4%89%E3%81%AA%E3%81%93%E3%81%A8%E3%81%AB%E3%81%AA%E3%82%8B%E4%BB%B6)
  - [Firefox経由でcacheされた内容の確認方法](#firefox%E7%B5%8C%E7%94%B1%E3%81%A7cache%E3%81%95%E3%82%8C%E3%81%9F%E5%86%85%E5%AE%B9%E3%81%AE%E7%A2%BA%E8%AA%8D%E6%96%B9%E6%B3%95)
  - [Firefoxのキャッシュ設定一覧](#firefox%E3%81%AE%E3%82%AD%E3%83%A3%E3%83%83%E3%82%B7%E3%83%A5%E8%A8%AD%E5%AE%9A%E4%B8%80%E8%A6%A7)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>


## 1. 今回のスコープ
### やりたいこと

不要ファイル/キャッシュ削除ツールBleachbitをインストールする

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


## Appendix: Firefoxのキャッシュ設定しないと大変なことになる件

デフォルトの設定でFirefoxはYoutube動画をすべてディスクキャッシュとしてため込んでいます. 
そのため、SSDの書き込みが延々と発生し、SSDの寿命を縮めてしまうい恐れがあります. 

### Firefox経由でcacheされた内容の確認方法

Firefoxのアドレスバーに以下を入力すると確認できます:

```
about:cache
```

設定変更を実施したい場合は、アドレスバーに

```
about:config
```

と入力すると設定変更が出来ます. 

### Firefoxのキャッシュ設定一覧

|設定 	|説明|
|---|---|
|`browser.cache.disk.enable` 	|ディスクキャッシュを有効にするかどうか|
|`browser.cache.disk.capacity` 	|ディスクキャッシュサイズKB（smart_sizeがdisableの時に有効|
|`browser.cache.disk.smart_size`.enabled 	|ディスクキャッシュをディスク容量から自動設定する|
|`browser.cache.disk.max_entry_size` 	|ディスクキャッシュするコンテンツの最大サイズKB|
|`browser.cache.disk.content_type_media_limit` 	|メディアデータを格納する最大％|
|`browser.cache.disk.parent_directory` 	|キャッシュフォルダへのフルパス（要追加）|
|`browser.cache.memory.enable` 	|メモリキャッシュを有効にするかどうか|
|`browser.cache.memory.capacity` 	|メモリキャッシュサイズKB|
|`browser.cache.memory.max_entry_size` 	|メモリキャッシュする最大サイズKB|

Youtubeのビデオはチャンクというコマ切れになっており、メディアデータとして認識されず、ディスクキャッシュされてしまいます.
`browser.cache.disk.enable`をfalseにしてディスクキャッシュを無効にしたとしても`browser.cache.memory.max_entry_size`が5MBあるのでメモリキャッシュも動画データですぐに食いつぶされてしまいます. 

> FirefoxでYoutube見続けるとSSDが早死にする問題の対処法

about:configを開いて以下の項目を128にします。

```
browser.cache.disk.max_entry_size
```

これはディスクキャッシュするコンテンツの最大サイズKBで、デフォルトでは51.2MBになっていま. 。Youtubeの動画データのチャンクは128KBは必ず超えるので、それ以下のJavascriptやHTMLや画像データはキャッシュされ、動画データは無事キャッシュされなくなります. (なお、歴史あるソフトなのでネット回線が非常にボトルネックだった時代から設定が引き継がれていますとのこと)


## References

- [Bleackbit deb packagesダウンロードサイト](https://www.bleachbit.org/download/linux)
- [FirefoxでYoutube見続けるとSSDが早死にする問題とその対処法](https://kanasys.com/tech/892)