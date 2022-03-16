---
layout: post
title: "フローチャートのチュートリアル"
subtitle: "プログラムができるまでの流れとフローチャート"
author: "Ryo"
header-img: "img/post-bg-miui6.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- flow chart
- CS101
- 料理
---



||概要|
|---|---|
|目的|プログラムができるまでの流れとフローチャート|
|参考|- [アルゴリズムの絵本 ～プログラミングが好きになる9つの扉～ ](https://www.cosc.canterbury.ac.nz/tim.bell)<br> - [JISX0121](https://www.jisc.go.jp/app/jis/general/GnrViewerLogIn?logIn)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [2. プログラムができるまで](#2-%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%8C%E3%81%A7%E3%81%8D%E3%82%8B%E3%81%BE%E3%81%A7)
- [3. フローチャート](#3-%E3%83%95%E3%83%AD%E3%83%BC%E3%83%81%E3%83%A3%E3%83%BC%E3%83%88)
  - [記号テーブル](#%E8%A8%98%E5%8F%B7%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB)
  - [フローチャートの例：ソフトウェアのインストール](#%E3%83%95%E3%83%AD%E3%83%BC%E3%83%81%E3%83%A3%E3%83%BC%E3%83%88%E3%81%AE%E4%BE%8B%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. ぶり大根のフローチャート](#4-%E3%81%B6%E3%82%8A%E5%A4%A7%E6%A0%B9%E3%81%AE%E3%83%95%E3%83%AD%E3%83%BC%E3%83%81%E3%83%A3%E3%83%BC%E3%83%88)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [環境](#%E7%92%B0%E5%A2%83)
  - [材料](#%E6%9D%90%E6%96%99)
  - [フローチャート](#%E3%83%95%E3%83%AD%E3%83%BC%E3%83%81%E3%83%A3%E3%83%BC%E3%83%88)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ

- プログラムができるまでの流れの確認
- フローチャートのお作法の確認

## 2. プログラムができるまで

|No|工程|説明|
|---|---|---|
|1|企画|こんなサービスがあったらいいなと考え、プロジェクト全体のゴールを設定します。|
|2|設計|サービスの機能仕様書や詳細設計書を作ります。フローチャートの出番!|
|3|コーディング|仕様書を基に、どのようなアルゴリズムで作ればよいか考えながらコーディング・ユニットテストします。Psuedo codeの出番!<br> テスト内容や手順を考えます <br> 結合テストを実施します。|
|4|試験・デバッグ|本番環境に近い環境でテストします。|
|5|ドキュメント作成|ヘルプや説明書の作成。|
|6|完成|公開|

## 3. フローチャート

フローチャートは情報処理の流れを図表化したものです。フローチャートをとして情報処理の流れを書くことで関係者間の共通認識の醸成がやりやすくなるというメリットがあります。ここでいう情報処理とは、

- データの流れ
- プログラムの流れ
- システムの流れ

### 記号テーブル

|分類|記号|名称|説明|
|---|:---:|---|---|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-process.png">|処理|処理一般を表します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-casewhen.png">|判断|流れを分岐させるときに使います|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-loop.png">|ループ|上下の組で使って繰り返し寄りの始まりと終わりを表します。ループ端に挟まれた処理を繰り返します。|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-initial.png">|準備|初期設定などを表します。|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-manualoperation.png">|手作業|人の手による任意の処理を表します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-definedprocess.png">|定義済み処理|自作の関数やモジュールなど、別の場所で定義された１つ以上の演算や関数でできた処理を表します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-parallelmode.png">|並行処理|２つ以上の並行した処理を同時に行うことを表します|
|データ記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-data.png">|データ|データ全般を表します|
|データ記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-datainmemory.png">|記憶データ|処理に適した形で記憶されているデータを表します|
|データ記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-database.png">|データベース|データベースに記憶されたデータを表します|


### フローチャートの例：ソフトウェアのインストール

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/flowchart/20210111-flowchart-example01.png?raw=true">

## 4. ぶり大根のフローチャート
### やりたいこと

- この記事を書いているときの僕の夕飯制作

### 環境

- 包丁
- まな板
- IH
- IH対応 LE CREUSET ストウブ鍋 特大
- 炊飯器

### 材料

|材料|調味料フラグ|量|
|---|---|---|
|ぶり|`False`|３切れ|
|大根|`False`|１本|
|米|`False`|1.5合|
|水|`True`|150 cc|
|醤油|`True`|大さじ２|
|みりん|`True`|大さじ２|
|砂糖|`True`|大さじ１|
|生姜薄切り|`True`|８切れ|
|酒|`True`|大さじ２|

### フローチャート

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/flowchart/20210111-flowchart-buridaikon.png?raw=true">
