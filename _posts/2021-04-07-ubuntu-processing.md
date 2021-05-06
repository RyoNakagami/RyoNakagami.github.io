---
layout: post
title: "Ubuntu Desktop環境構築 Part 17"
subtitle: "Processing 3.5.4の導入"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Processing
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|Processing 3.5.4の導入|
|参考|-[processing.org](https://processing.org/download/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 実行環境](#1-%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
- [2. Processingのインストール](#2-processing%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [Processing versionの確認](#processing-version%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [作業方針](#%E4%BD%9C%E6%A5%AD%E6%96%B9%E9%87%9D)
  - [実行](#%E5%AE%9F%E8%A1%8C)
- [3. 日本語表示設定](#3-%E6%97%A5%E6%9C%AC%E8%AA%9E%E8%A1%A8%E7%A4%BA%E8%A8%AD%E5%AE%9A)
- [4. ライブラリのインストール](#4-%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 実行環境

|項目||
|---|---| 	 
|マシン| 	HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| 	Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 	32.0 GB|
|GPU| 	NVIDIA GeForce RTX 2060 SUPER|
|前提条件|`wget`コマンドインスール|

## 2. Processingのインストール
### Processing versionの確認

- [公式サイト](https://processing.org/download/)より最新のStable Releasesを確認
- 実行時の最新版は3.5.4

### 作業方針

1. OSシステム更新
2. Processingインストーラーのダウンロード
3. Processing をインストール 
4. processingの起動確認

### 実行

```zsh
# OSシステム更新
% sudo apt update
% sudo apt -yV upgrade

# Processingインストーラーのダウンロード
% cd ./deb_packages
% wget https://download.processing.org/processing-3.5.4-linux64.tgz

# ファイルを解凍
% sudo tar -xvzof ./deb_packages/processing-3.5.4-linux64.tgz -C /home/ryo_nak/

# Processing をインストール
% cd ./processing-3.5.4
% sudo bash install.sh

# Processing起動確認
% ./processing
```

## 3. 日本語表示設定

まず設定ファイルを開きます

```zsh
% nano ~/.processing/preferences.txt
```

ファイルを開いた後、フォント設定箇所

```raw
editor.font.family=Source Code Pro
```

を日本語対応したフォントに変えます：

```raw
editor.font.family=monospaced
```

完了です。

## 4. ライブラリのインストール

メニューバーから「スケッチ」→「ライブラリをインポート」→「ライブラリを追加」を選択すると、「Contribution Manager」が開きます。ここで、インストールしたいライブラリを検索してインストールします。

