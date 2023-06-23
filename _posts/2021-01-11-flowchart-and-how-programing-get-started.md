---
layout: post
title: "プログラムができるまでの流れとフローチャート"
subtitle: "料理レシピをフローチャートで書いてみる"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-10-05
tags:

- coding
- 料理
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回のスコープ](#%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [プログラムができるまで](#%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%8C%E3%81%A7%E3%81%8D%E3%82%8B%E3%81%BE%E3%81%A7)
- [フローチャート](#%E3%83%95%E3%83%AD%E3%83%BC%E3%83%81%E3%83%A3%E3%83%BC%E3%83%88)
  - [記号テーブル](#%E8%A8%98%E5%8F%B7%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB)
  - [フローチャートの例：ソフトウェアのインストール](#%E3%83%95%E3%83%AD%E3%83%BC%E3%83%81%E3%83%A3%E3%83%BC%E3%83%88%E3%81%AE%E4%BE%8B%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [料理レシピの紹介](#%E6%96%99%E7%90%86%E3%83%AC%E3%82%B7%E3%83%94%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [(1) ぶり大根のフローチャート](#1-%E3%81%B6%E3%82%8A%E5%A4%A7%E6%A0%B9%E3%81%AE%E3%83%95%E3%83%AD%E3%83%BC%E3%83%81%E3%83%A3%E3%83%BC%E3%83%88)
  - [(2) 黒豚の焼酎蒸し](#2-%E9%BB%92%E8%B1%9A%E3%81%AE%E7%84%BC%E9%85%8E%E8%92%B8%E3%81%97)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## 今回のスコープ

- プログラムができるまでの流れの確認
- フローチャートのお作法の確認
- 料理レシピの整備

## プログラムができるまで

|No|工程|説明|
|---|---|---|
|1|企画|こんなサービスがあったらいいなと考え, プロジェクト全体のゴールを設定|
|2|設計|サービスの機能仕様書や詳細設計書を作成<br>フローチャートをベースにコミュニケーションする|
|3|コーディング|仕様書を基に、どのようなアルゴリズムで作ればよいか考えながらコーディング/ユニットテスト(Psuedo codeをこの時用いる)<br> 結合テストの実施|
|4|試験/デバッグ|本番環境に近い環境でテスト|
|5|ドキュメント作成|ヘルプや説明書の作成|
|6|完成|公開/メンテナンス|

## フローチャート

フローチャートは情報処理の流れを図表化したものです. フローチャートとして情報処理の流れを書くことで関係者間の共通認識の醸成がやりやすくなるというメリットがあります. ここでいう情報処理とは以下の項目のことです:

- データの流れ
- プログラムの流れ
- システムの流れ

### 記号テーブル

|分類|記号|名称|説明|
|---|:---:|---|---|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-process.png">|処理|処理一般を表します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-casewhen.png">|判断|流れを分岐させるときに使います|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-loop.png">|ループ|上下の組で使って繰り返し寄りの始まりと終わりを表します。ループ端に挟まれた処理を繰り返します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-initial.png">|準備|初期設定などを表します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-manualoperation.png">|手作業|人の手による任意の処理を表します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-definedprocess.png">|定義済み処理|自作の関数やモジュールなど、別の場所で定義された１つ以上の演算や関数でできた処理を表します|
|処理記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-parallelmode.png">|並行処理|２つ以上の並行した処理を同時に行うことを表します|
|データ記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-data.png">|データ|データ全般を表します|
|データ記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-datainmemory.png">|記憶データ|処理に適した形で記憶されているデータを表します|
|データ記号|<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/flowchart/20210111-flowchart-database.png">|データベース|データベースに記憶されたデータを表します|


### フローチャートの例：ソフトウェアのインストール

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/flowchart/20210111-flowchart-example01.png?raw=true">

## 料理レシピの紹介
### (1) ぶり大根のフローチャート

> 環境

- 包丁
- まな板
- IH
- IH対応 LE CREUSET ストウブ鍋 特大
- 炊飯器

> 材料

|材料|量|
|---|---|
|ぶり|３切れ|
|大根|１本|
|米|1.5合|
|水|150 cc|
|醤油|大さじ２|
|みりん|大さじ２|
|砂糖|大さじ１|
|生姜薄切り|８切れ|
|酒|大さじ２|

> フローチャート

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/flowchart/20210111-flowchart-buridaikon.png?raw=true">

### (2) 黒豚の焼酎蒸し

> 環境

- 象印ホットプレート

> 栄養価（1人分換算）

---|---|---|---
エネルギー|	217 kcal	|カリウム | 444 mg
たんぱく質|	7.7 g	|亜鉛 | 1.2 mg
脂質|	17.5 g |	ビタミンE | 1 mg
炭水化物|	5.6 g |	ビタミンB1 | 0.27 mg
糖質|	3.5 g	|ビタミンC|41 mg
食物繊維|	2.1 g|	コレステロール|26 mg
塩分（食品相当量）|	0.9 g	|ビタミンB6	|0.26 mg
カルシウム|	87 mg	|ビタミンB12|0.2 μg
鉄|	1.2 mg	|葉酸|	79 μg


> 材料（4人分）

---|---|---|---
黒豚バラ肉(薄切り)|150g|ぽん酢しょうゆ|60ml
白菜|250g|ごま油|大さじ1
しめじ|1パック|ラー油|小さじ1/3
パプリカ(赤)|1/3個|すりごま(白)|大さじ1
水菜|70g|焼酎|50m

> フローチャート

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/%E6%96%99%E7%90%86%E3%83%AC%E3%82%B7%E3%83%94/%E9%BB%92%E9%85%A2%E8%B1%9A%E7%84%BC%E9%85%8E%E8%92%B8%E3%81%97.png?raw=true">


## References

> フローチャート系

- [アルゴリズムの絵本 ～プログラミングが好きになる9つの扉～ ](https://www.cosc.canterbury.ac.nz/tim.bell)
- [JISX0121](https://www.jisc.go.jp/app/jis/general/GnrViewerLogIn?logIn)

> 料理レシピ

- [Bob & Angie > 黒豚の焼酎蒸し](https://www.bob-an.com/recipes/40866.html)