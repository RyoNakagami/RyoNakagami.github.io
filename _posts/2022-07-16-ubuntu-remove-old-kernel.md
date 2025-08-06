---
layout: post
title: "Ubuntu 20.04 LTSでの古いカーネルの削除"
subtitle: ""
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-08-06
reading_time: 6
tags:

- Ubuntu 20.04 LTS
- Linux
- Shell
---

---|---
目的|古いカーネルの削除
OS|ubuntu 20.04 LTS Focal Fossa
Difficulty level|Easy
Root privileges|Yes
Requirements|Linux terminal

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. カーネルのアップグレード](#1-%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%82%B0%E3%83%AC%E3%83%BC%E3%83%89)
  - [コマンドで明示的にupdateする場合](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A7%E6%98%8E%E7%A4%BA%E7%9A%84%E3%81%ABupdate%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
  - [なぜ古いカーネルを削除するのか？](#%E3%81%AA%E3%81%9C%E5%8F%A4%E3%81%84%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)
- [2. 実践編](#2-%E5%AE%9F%E8%B7%B5%E7%B7%A8)
  - [現在のカーネルバージョンの確認](#%E7%8F%BE%E5%9C%A8%E3%81%AE%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [インストール済みのカーネル一覧の確認](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%B8%88%E3%81%BF%E3%81%AE%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E4%B8%80%E8%A6%A7%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [削除対象の決定](#%E5%89%8A%E9%99%A4%E5%AF%BE%E8%B1%A1%E3%81%AE%E6%B1%BA%E5%AE%9A)
  - [削除テスト](#%E5%89%8A%E9%99%A4%E3%83%86%E3%82%B9%E3%83%88)
  - [削除実行](#%E5%89%8A%E9%99%A4%E5%AE%9F%E8%A1%8C)
  - [実行結果確認](#%E5%AE%9F%E8%A1%8C%E7%B5%90%E6%9E%9C%E7%A2%BA%E8%AA%8D)
- [Appendix](#appendix)
  - [grepコマンドで一致しない文字列を検索する](#grep%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A7%E4%B8%80%E8%87%B4%E3%81%97%E3%81%AA%E3%81%84%E6%96%87%E5%AD%97%E5%88%97%E3%82%92%E6%A4%9C%E7%B4%A2%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. カーネルのアップグレード

Ubuntu 20.04ではデフォルトで自動更新が有効になっています. 
更新設定は, `/etc/apt/apt.conf.d/20auto-upgrades`ファイルに記載があります.

```zsh
% cat /etc/apt/apt.conf.d/20auto-upgrades                      
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

- `APT::Periodic::Update-Package-Lists`: 1の場合, 自動的にアップデート可能なパッケージリストを更新. 0の場合は無効
- `APT::Periodic::Unattended-Upgrade`: 1の場合, 自動的にアップデートを適用. 0の場合は無効

### コマンドで明示的にupdateする場合

```zsh
% sudo apt update && sudo apt dist-upgrade
```

### なぜ古いカーネルを削除するのか？

Ubuntu ではカーネルが頻繁に更新され, そのたびに新しいカーネルが `/boot` にインストールされます. 
`/boot`の容量がそのたびに大きくなってしまう一方, `/boot` はパーティションが分けられているケースが多く,
定期的にメンテナンスをしないと `/boot`のディスク容量が足りないと怒られるリスクがあります.


## 2. 実践編

### 現在のカーネルバージョンの確認

```zsh
% uname -r
5.15.0-46-generic
```

### インストール済みのカーネル一覧の確認

```zsh
% dpkg --get-selections | grep linux-
```

`dpkg --get-selections`コマンドは全パッケージのインストールされたものと, インストールされたが除去されたものを得ることができます.
ちなみにですが, `dpkg --get-selections`の出力結果をtxtファイルに出力して, それを対象に `apt install`コマンドを走らせるようにすれば,
異なる機器間で install packageを揃えることができ, このような使い方もされることがあります.


### 削除対象の決定

```zsh
% dpkg --get-selections | grep "linux-"|grep -v "deinstall"|grep -v "5.15.0-46"|column -t| cut -d" " -f1 > purge_dist_list_20220716.txt
```

- 間違いがないように, テキストエディタで明示的にどのkernel fileを削除するか指定
- 削除するパッケージを明示的に`purge_dist_list_20220716.txt`に記載
- 削除候補外は`purge_dist_list_20220716.txt`からそのパッケージ名を消します


### 削除テスト

```zsh
% cat purge_dist_list_20220716.txt| sudo xargs apt purge --dry-run
```

### 削除実行

```zsh
% cat purge_dist_list_20220716.txt| sudo xargs apt purge -y
```

### 実行結果確認

```zsh
% dpkg --get-selections | grep linux-
```


## Appendix
### grepコマンドで一致しない文字列を検索する

grep `-v` オプションを指定した文字列を含まない文字列検索を実行することができます.
`man`コマンドで確認してみると

```
Matching Control
    -v, --invert-match
              Invert  the  sense  of  matching,  to  select  non-
              matching lines.
```

> Syntax

```zsh
% grep -v "除外文字列" <FILE PATH>
```

## References

> オンラインマテリアル

- [Ubuntu/自動アップデートを有効・無効にする手順](https://linux.just4fun.biz/?Ubuntu/%E8%87%AA%E5%8B%95%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E3%82%92%E6%9C%89%E5%8A%B9%E3%83%BB%E7%84%A1%E5%8A%B9%E3%81%AB%E3%81%99%E3%82%8B%E6%89%8B%E9%A0%86)
- [dpkg –get-selections: Get the Current State of Your Ubuntu/Debian machine](https://linuxprograms.wordpress.com/2010/05/12/dpkg-get-selections/)
