---
layout: post
title: "Universally Unique ID Generatorの設計"
subtitle: "System Design 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-10-12
tags:

- architecture

---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [UUIDとは？](#uuid%E3%81%A8%E3%81%AF)
  - [UUIDのversion](#uuid%E3%81%AEversion)
  - [UUIDのメリット](#uuid%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
- [分散システムにおけるUIDの設計](#%E5%88%86%E6%95%A3%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Buid%E3%81%AE%E8%A8%AD%E8%A8%88)
  - [要望に合わせた設計例](#%E8%A6%81%E6%9C%9B%E3%81%AB%E5%90%88%E3%82%8F%E3%81%9B%E3%81%9F%E8%A8%AD%E8%A8%88%E4%BE%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## UUIDとは？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: UUID</ins></p>

- UUIDとは, ソフトウェア上位でオブジェクトを一位に識別するための識別子
- 128 bitの数値で本来的には表されるが, 16進法文字を組み合わせた36の長さの文字列によって表現されるケースが多い
- UUIDはシステム内部だけでなくUniversally(=世界中の意味)でユニークであると事実上みなされてる(collision riskが無視できるほど低い)

</div>

zshでUUIDのリストを簡易的に作成すると以下のようになります:

```zsh
% echo -n "|user_id|\n|-------|\n" && for i in {1..4}; do echo "|$(uuidgen)|"; done
|user_id|
|-------|
|ecd88b02-62af-470e-bb31-9e68b817dfa7|
|8ecaa117-47b0-4cd2-9d78-a48d636dfd21|
|7c67082e-1b6f-4243-92e2-f01972c71e9c|
|d3f2a690-0b86-4553-8ce3-8bb4baf5df25|
```

UUIDの形式として, 8-4-4-4-12桁のハイフン含めた32文字で構成されています

```
XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX (X = 0, …, 9, A, …, F)
```

なお, 上の`uuidgen`コマンドで生成したUUIDについて, ３つ目のグループはすべて`4XXX`となっています.
これは, UUID versionがversion 4であることを意味しています.

### UUIDのversion

UUIDには精製アルゴリズムに応じてversionが切り分けられており, 1~5までversionが存在します.
乱数に基づいた**Version 4**が最も頻繁に利用されています.

|Version|特徴|
|-------|---|
|version 1|UUIDを生成するコンピュータのMACアドレスとナノ秒単位の時刻を使って計算|
|Version 2|version 1のUUIDのTimestampのとクロックシーケンスの一部をPOSIXのユーザーIDやグループIDで差し替えたもの|
|version 3|ドメイン名などなんらかの一意な名前（バイト列）を用いたUUIDで, ハッシュ関数としてMD5を利用したもの|
|version 4|乱数により生成|
|version 5|version 3のハッシュ関数をSHA1へ変えたもの|


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: Version 1 UUIDの例</ins></p>

Version 1のUUIDは以下のような構造となっている

```
TTTTTTTT-TTTT-1TTT-sSSS-AAAAAAAAAAAA
```

- T: Timestampより生成
- S: クロックシーケンス
- A: MACアドレス

UUIDを生成するコンピューターで同じ時刻にUUIDを生成しない限り, Version 1 UUIDは同じにならないので事実上
Universally Uniqueとなっているが, 生成時刻とUUIDを生成するコンピューターのMACアドレスが他人にわかってしまうという
デメリットがあります.

</div>

### UUIDのメリット

- collision riskが無視できるほど小さいので, 分散システムでUUIDを生成したい場合, サーバー間連携が不要(=同期の問題が発生しない)
- UID generatorは各サーバーが持ち, 独自にIDを生成できるので, システムのスケーリングが容易


## 分散システムにおけるUIDの設計

UUIDという仕組みがあるにも関わらず, ユニークIDジェネレーターを設計するニーズは世の中に存在します.
シンプルな理由としては, 個々のシステムの要件と照らし合わせた結果UUIDは適さないと判断されるからとなります. 

例として, 要件定義のディスカッションで以下のような要望が出てきたとします

- IDは一意
- IDは64bit以内に収まる数値のみ
- IDは日付順に並んでおりsort可能
- 1秒間に10,000以上のIDが生成可能(= 1個あたりの生成時間は0.1 ms or 100 microsec)
- 障害に対してロバスト（一つのサーバーが落ちたとき, UIDが全く生成できないという事態を回避したい）

「**IDは64bit以内に収まる数値のみ**」というのはmemory spaceの制約に起因する要望と推察できます.
UUIDは128 bit memory spaceを要求するのでこの時点でUUIDは利用できません.

「**IDは日付順に並んでおり**」という要件も少なくともVersion 4 UUIDでは実現不可能です.

### 要望に合わせた設計例

上記の要望と照らし合わせたとき, snowflakeアプローチとして知られているUID設計が有効です.

---|---
符号ビット|timestamp|データセンタID|マシンID|シーケンス番号|
1 bit|41 bit|5 bit|5 bit|12 bit|

- 符号ビット: 将来の用途へに備え. 現状は常に0とする
- timestamp: epochからのミリ秒. 基準点から41bitあれば70年近く表現可能
- データセンタID: 5 bitなので32データセンターが表現可能
- マシンID: データセンタごとに32台のマシンが表現可能
- シーケンス番号: プロセスでIDが生成されるたびにシーケンス番号が１ずつ増える. 1ミリ秒ごとに0にリセットされる


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS</ins></p>

- シーケンス番号は12bitなので最大値4096を取りますが, １台のマシンで1ミリ秒あたり4096以上のUIDを生成してしまうと
collisionが発生してしまいます
- 「**IDは日付順に並んでおりsort可能**」という要望を実現するためには各サーバーのマシンがすべて同期されたクロックをもちいているという仮定が必要です
- 要望に応じて各セクションのチューニングは必要(70年近くもサービス稼働を予定していないのであるならばtimestampセクションは41 bitも必要がない)
- version 1 UUIDと似た構造

</div>


References
---------------

- [What is a UUID, and what is it used for?](https://www.cockroachlabs.com/blog/what-is-a-uuid/)
- [A Universally Unique IDentifier (UUID) URN Namespace](https://www.rfc-editor.org/rfc/rfc4122)