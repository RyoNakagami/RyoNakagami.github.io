---
layout: post
title: "性能の定義: throughput and response time"
subtitle: "Syetem Design 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-10-08
tags:

- architecture
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [性能の定義](#%E6%80%A7%E8%83%BD%E3%81%AE%E5%AE%9A%E7%BE%A9)
  - [Response timeとthroughput](#response-time%E3%81%A8throughput)
- [CPUの性能と測定](#cpu%E3%81%AE%E6%80%A7%E8%83%BD%E3%81%A8%E6%B8%AC%E5%AE%9A)
- [Appendix: 2のべき乗](#appendix-2%E3%81%AE%E3%81%B9%E3%81%8D%E4%B9%97)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 性能の定義

コンピューターやシステムを選択するにあたって, どれが最もコストパフォーマンスが良いかで判断するケースが大半だと思いますが, 
コストパフォーマンスを計算する基礎としてそもそも「**性能**」とはなにか？を理解することが重要です.

コンピューターの文脈において「性能」が計算性能という形で一意に定まるならば論点にはなりませんが実際はこの定義が難しいです. 
旅客機の性能の議論を例に**性能の定義が多義的**であることを確認してみましょう. 安全性とかいろいろな見方がありますが一旦は時間あたりの作業量という観点で速度を中心に考えてみます.

|航空機|搭乗人員数|巡航速度|輸送能力|
|-----|--------|-------|------|
|A|300| 1,000 km/h|300,000|
|B|400| 1,000 km/h|400,000|
|C|100| 2,000 km/h|200,000|
|D|150| 800 km/h  |120,000|

上記のようなスペックがあたえられたとき, １人の旅客の観点から見るならば航空機Cが最も巡航速度が速いので
最も性能が良いというように判断できます. 一方, １台の航空機で2000km離れた地点へ1200人の旅客を運びたい場合は, 時間あたり輸送人員距離の指標としての

$$
\text{輸送能力} = \text{搭乗人員数}\times\text{巡航速度}
$$

の観点から航空機Bが最も性能が良いという判断へ変わります. 

### Response timeとthroughput

上の航空機の例をコンピューターの文脈で対応させると

- 個人のコンピューターユーザーは**応答時間(= response time)**に関心がある
- サーバー管理者は**スループット(= throughput, bandwidth)**を増やすことに関心がある

という言い表すことができます. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Response time</ins></p>

コンピューターがタスクを完了させるのに必要な合計時間のこと. ディスクアクセス, メモリアクセス, 入出力動作, 
OSのオーバーヘッド, CPUの実行時間などを含む.

日本語では「応答時間」や「実行時間」と呼ばれたりする.

</div>

応答時間の改善はほとんどの場合, 後述のスループットの改善に繋がります. 例えば, ゲームサーバーのプロセッサをより高速なものに変えた場合, 

- タスクの実行時間が改善
- 応答時間が改善
- スループットが改善

という経路で影響が派生していきます.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: スループット</ins></p>

単位時間あたりの処理能力のことをスループット(throughput)と呼ぶ．

100個の荷物があったとして, 一分間に2個のペースでこの荷物を移動できる人がいるとしたとき, 

- 一分間に4個のペースでこの荷物を移動できる人にreplaceする
- 一分間に2個のペースでこの荷物を移動できる人をもう一人雇う

いずれかの方法で１分あたりの作業量が2個→4個へ改善される. このとき, スループット（＝単位時間あたり作業量）は2倍になったという

</div>

## CPUの性能と測定



## Appendix: 2のべき乗

以下の数値感覚を持っておくことは実行時間の概算をするにあたって有用です.

|2のべき乗|オーダー|データ単位|
|--------|------|--------|
|10|1,000|1KB|
|20|100万|1MB|
|30|10億|1GB|
|40|1兆|1TB|
|50|1,000兆|1PB|

なお, $\log_{10}(2) = 0.301...$なのでべき乗の数に$0.3$すればおおよその感覚と一致します.







References
-------------

- [コンピュータの構成と設計 第5版 上](https://www.amazon.co.jp/%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%81%AE%E6%A7%8B%E6%88%90%E3%81%A8%E8%A8%AD%E8%A8%88-%E7%AC%AC5%E7%89%88-%E4%B8%8A-%E3%82%B8%E3%83%A7%E3%83%B3%E3%83%BBL-%E3%83%98%E3%83%8D%E3%82%B7%E3%83%BC/dp/4822298426)
