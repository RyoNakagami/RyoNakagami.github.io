---
layout: post
title: "google-drive-ocamlfuseのインストール: Linux版google-drive-stream"
subtitle: "Ubuntu Desktop環境構築 Part 7"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-09-03
tags:

- Ubuntu 20.04 LTS
- Shell
---


> 技術スペック

---|---
OS | ubuntu 20.04 LTS Focal Fossa
CPU| Intel Core i7-9700 CPU 3.00 GHz


<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [方針](#%E6%96%B9%E9%87%9D)
- [2. google-drive-ocamlfuseとは？](#2-google-drive-ocamlfuse%E3%81%A8%E3%81%AF)
  - [機能](#%E6%A9%9F%E8%83%BD)
- [3. google-drive-ocamlfuseのインストール](#3-google-drive-ocamlfuse%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Googleドライブへの認証](#4-google%E3%83%89%E3%83%A9%E3%82%A4%E3%83%96%E3%81%B8%E3%81%AE%E8%AA%8D%E8%A8%BC)
- [5. google-drive-ocamlfuseのマウント](#5-google-drive-ocamlfuse%E3%81%AE%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%88)
- [6. Google drive 自動起動用スクリプトの設定](#6-google-drive-%E8%87%AA%E5%8B%95%E8%B5%B7%E5%8B%95%E7%94%A8%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [Appendix: シンボリックリンクとハードリンク](#appendix-%E3%82%B7%E3%83%B3%E3%83%9C%E3%83%AA%E3%83%83%E3%82%AF%E3%83%AA%E3%83%B3%E3%82%AF%E3%81%A8%E3%83%8F%E3%83%BC%E3%83%89%E3%83%AA%E3%83%B3%E3%82%AF)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

Google DriveをUbuntu 20.04にマウントする

### 方針

1. google-drive-ocamlfuseのインストール
2. google-driveの認証
3. google-drive-ocamlfuseのマウント
4. 自動起動用スクリプトの設定

## 2. google-drive-ocamlfuseとは？

「google-drive-ocamlfuse」はGoogleドライブをLinux上でマウント出来るソフトウェアです. Googleドライブのデスクトップ向け公式ソフトウェアでは非同期になり, 端末側にもデータを保存する容量を要求しますが, こちらのソフトウェアはネットワークマウントを行います. そのため, 少ないストレージ容量の端末でも容量を気にせず使用出来るというメリットがあります. 

なぜ遠隔にあるGoogleドライブのストレージを端末側にマウント出来るかというと, [FUSE](https://ja.wikipedia.org/wiki/Filesystem_in_Userspace)という独自のファイルシステムを構築出来る機能を用いているからです. 

### 機能

- Google Drive上のファイルとフォルダに対してterminalから read/write access ができる
- Google Docs, Sheets, and Slidesに対してread-only accessができる
- 複数のgoogle accountのgoogle driveをマウントすることができる
- google drive上のファイルの複製/消去が可能
- Symbolic links
- Read-ahead buffers when streaming

## 3. google-drive-ocamlfuseのインストール

`.deb` packagesが PPAに上がっているのでそれをまず`add-apt-repository`します. その後にapt installを実行します. 

```
$ sudo add-apt-repository ppa:alessandro-strada/ppa
$ sudo apt-get update
$ sudo apt-get install google-drive-ocamlfuse
```

なお, `add-apt-repository ppa:`の結果は`/etc/apt/sources.list.d`に格納されています. 

## 4. Googleドライブへの認証

Install後まずgoogle driveの認証をしなくてはなりません. `google-drive-ocamlfuse`をパラメータなしでまず実行します. 

```
$ google-drive-ocamlfuse
```

すると, 自動的にGoogleのサイトに遷移し, ソフトウェアの認証を行うか聞かれます. またコマンド実行後, `~/.gdfuse/default`にconfigファイルが生成されます. 今回はconfigファイルの設定方法は特にいじりませんが, いじりたい場合はこちらの[wiki page](https://github.com/astrada/google-drive-ocamlfuse/wiki/Configuration)を参照してください. 

## 5. google-drive-ocamlfuseのマウント

マウントポイントをmkdirしてから, Googleドライブをマウントそこにマウントします. 

```
$ mkdir ~/googledrive
$ google-drive-ocamlfuse ~/googledrive
```

アンマウントしたい場合は, 以下のコマンドを実行する. 

```
fusermount -u ~/googledrive
```

## 6. Google drive 自動起動用スクリプトの設定

このままだと自動起動してくれず毎回マウントしないといけないので, 自動起動用スクリプトを書きます. 

```
$ nano ~/bin/google-drive-ocamlfuse-start.sh
```

- google-drive-ocamlfuse-start.sh

```
#! /usr/bin/bash
google-drive-ocamlfuse ~/googledrive
```

実行権限を以下のように編集します

```
$ chmod 700 google-drive-ocamlfuse-start.sh 
```

次にスタートメニューから`Startup Applications Preferences`を起動します. そして先程のスクリプトを登録しておきます. 

<img src="https://raw.githubusercontent.com//ryonakimageserver/omorikaizuka//master/linux/google_drive/StartupApplicationsPreferences_20201222.png">


> エイリアスを設定する場合

Google driveをマウントすると, そのマウントとされたフォルダが存在するディレクトリにて `ls` コマンドを実行する際など
シェルコマンドの動作が遅くなる傾向があります. そのため, 必要に応じてマウント/アンマウントするほうが良い場合があります.

自分は以下のようなエイリアスを設定し, 必要に応じてマウントしています.

```zsh
alias mount_googledrive='google-drive-ocamlfuse ~/GoogleDrive'
alias unmount_googledrive='fusermount -u ~/GoogleDrive'
```

## Appendix: シンボリックリンクとハードリンク

```
$ ln -s /home/ryo/sample1.txt sample
```

というコマンドでファイルやディレクトリに対するリンク（リンクファイル）を作成することができます.
リンクにはシンボリックリンクとハードリンクの２種類があります. 
PATHを絶対パスで指定するとリンクファイルを移動しても使えるので, 絶対パスで指定することをおすすめです.

|リンクの種類|説明|
|---|---|
|シンボリックリンク|シンボリックリンクはリンク先を呼び出すだけなので, それ自体を削除しても本体には影響はありません. 本体を削除するとリンクが切れてしまいます. `ln -s`とオプションをつけることでシンボリックリンクを作成することができます.|
|ハードリンク|ハードリンクはリンクファイルとリンク先両方共同じものとみなされ, どちらか片方を削除しても実態は残ります.|

## References

> 関連ポスト

- [Ryo's Tech Blog > システム起動時に自動的にドライブをマウントする](https://ryonakagami.github.io/2022/01/28/ubuntu-external-storage-setup/)


> オンラインマテリアル

- [FUSE filesystem over Google Drive](https://github.com/astrada/google-drive-ocamlfuse)
- [GoogleDriveをマウントする](https://sites.google.com/site/memomuteki/tinylinux/googledrivewomauntosuru)