---
layout: post
title: "Ubuntu Desktop Noble Numbatのインストール"
subtitle: "分析用サーバーとしてのUbuntu Desktop Noble Numbat Setup 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-06-07
tags:

- Ubuntu 24.04 LTS
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [この記事のスコープ](#%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [作業環境](#%E4%BD%9C%E6%A5%AD%E7%92%B0%E5%A2%83)
- [作業手順](#%E4%BD%9C%E6%A5%AD%E6%89%8B%E9%A0%86)
  - [Ubuntu ISOファイルのダウンロード](#ubuntu-iso%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89)
  - [USBインストールメディアの作成](#usb%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%83%A1%E3%83%87%E3%82%A3%E3%82%A2%E3%81%AE%E4%BD%9C%E6%88%90)
  - [Ubuntu 24.04 LTSのインストール](#ubuntu-2404-lts%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## この記事のスコープ

- Ubuntu Desktop Noble NumbatをIntel Core i7-9700デスクトップへインストールする

### 作業環境

**Ubuntuインストールメディア作成環境**

---|---
OS|Ubuntu 22.04.4 LTS x86_64
Kernel|6.5.0-35-generic 
Shell|zsh 5.8.1 
CPU|AMD Ryzen 9 7950X (32) @ 5.881G 

**Ubuntu Desktop Noble Numbatインストール先**

---|---
デバイス|HP ENVY TE01-0xxx
CPU|Intel Core i7-9700 CPU 3.00 GHz
RAM|32.0 GB
GPU|NVIDIA GeForce RTX 2060 SUPER

## 作業手順

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>作業手順</ins></p>

1. Ubuntu Desktop 24.04 LTSのISOファイルのダウンロード (15~20 min)
2. USBインストールメディアの作成 (1~2 min)
3. Ubuntu 24.04 LTSのインストール(20 min)

</div>


### Ubuntu ISOファイルのダウンロード

- 日本のUbuntuミラーサーバーの一つであるTsukuba WIDEの[Ubuntu Desktop 24.04 isoファイルダウンロードリンク](https://ftp.tsukuba.wide.ad.jp/Linux/ubuntu-releases/24.04/ubuntu-24.04-desktop-amd64.iso)より
isoファイルを取得
- isoファイルサイズは約 6 GB
- ダウンロード時間は15~20分程度(6 MB/sec)

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>ISOファイルとは？</ins></p>

- ISOファイルは，CD-ROMやDVDのディスクイメージ(光ディスク用アーカイブファイル)をそのままファイルにしたもの
- ディスクからコピーした一般的なファイルでは，ヘッダー情報が消失しており完全なデータは含まれないが，ISOファイルにはディスクからのヘッダー情報を含む完全なデータが格納されている

</div>

### USBインストールメディアの作成

「Disks」アプリケーションを利用してUSBインストールメディアを作成する方法を取り扱います.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>作業手順</ins></p>

1. アプリケーションから「Disks」を検索して立ち上げる
2. 左ペインのDisk一覧からUSBインストールメディアの物理デバイスとなるUSBフラッシュメモリを選択
3. 右上のメニューボタンから `Restore Disk image` を選択
4. Destinationが意図した物理デバイスかどうか確認
5. `Image to Restore`項目にて，上でダウンロードしたISOファイルを選択し，`Start Restoring`をクリック


</div>


上記手順に従い約 2 minほどでインストールメディア作成が完了しました．

### Ubuntu 24.04 LTSのインストール

- USBインストールメディアを差し込んだ状態でUEFI環境経由boot managerを起動(HP製なので `esc` + `F10`)
- Try to install Ubuntuを選択し，案内通りに作業を行う(約 20 min)
- Ubuntu Proをenableする

Install作業において, `Who are you?`セクションがありますが対応関係は以下です

|項目|説明|
|---|---|
|Your name|GUIログイン画面表示上のusername|
|Your computer's name|hostname|
|Pick a username|username|
|Use Active Directory|ネットワークにつないでいるクライアント端末やサーバー，プリンター，アプリケーションなどの情報を収集し，一元管理できるディレクトリサービスのこと．個人で使用するならばチェックマークは基本不要|


References
----------
- [Ryo's Tech Blog > PCにUbuntu 20.04 LTS (Focal Fossa)をインストールする](https://ryonakagami.github.io/2020/12/07/ubuntu-setup/)
