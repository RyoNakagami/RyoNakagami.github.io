---
layout: post
title: "補数を用いた整数の表現"
subtitle: "コンピューターにおける算術演算 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
mathjax: true
mermaid: false
catelog: true
tags:
  - 数値計算
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [2の補数と減算](#2%E3%81%AE%E8%A3%9C%E6%95%B0%E3%81%A8%E6%B8%9B%E7%AE%97)
  - [2の補数による数の表現](#2%E3%81%AE%E8%A3%9C%E6%95%B0%E3%81%AB%E3%82%88%E3%82%8B%E6%95%B0%E3%81%AE%E8%A1%A8%E7%8F%BE)
    - [2進数から10進数への変換](#2%E9%80%B2%E6%95%B0%E3%81%8B%E3%82%8910%E9%80%B2%E6%95%B0%E3%81%B8%E3%81%AE%E5%A4%89%E6%8F%9B)
    - [2の補数のメリット](#2%E3%81%AE%E8%A3%9C%E6%95%B0%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
  - [加算と減算におけるオーバーフロー判定](#%E5%8A%A0%E7%AE%97%E3%81%A8%E6%B8%9B%E7%AE%97%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%82%AA%E3%83%BC%E3%83%90%E3%83%BC%E3%83%95%E3%83%AD%E3%83%BC%E5%88%A4%E5%AE%9A)
    - [ポケモン金銀におけるオーバーフロー問題](#%E3%83%9D%E3%82%B1%E3%83%A2%E3%83%B3%E9%87%91%E9%8A%80%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%82%AA%E3%83%BC%E3%83%90%E3%83%BC%E3%83%95%E3%83%AD%E3%83%BC%E5%95%8F%E9%A1%8C)
- [Appendix: シェルで2進数整数値を10進数変換したい場合](#appendix-%E3%82%B7%E3%82%A7%E3%83%AB%E3%81%A72%E9%80%B2%E6%95%B0%E6%95%B4%E6%95%B0%E5%80%A4%E3%82%9210%E9%80%B2%E6%95%B0%E5%A4%89%E6%8F%9B%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
- [Appendix: 2進数の表現の幅](#appendix-2%E9%80%B2%E6%95%B0%E3%81%AE%E8%A1%A8%E7%8F%BE%E3%81%AE%E5%B9%85)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 2の補数と減算

コンピューターに符号あり整数型(signed int)の減算処理を実行させる際, 引く数を正負反転してから加算処理を行います. 
8bit CPUで2の補数ベースで $7 - 6$ という処理を行う場合, 

$$
\begin{array}{rr}
 & 00000111\\
 +\{)}&11111010\\
 \hline
 &00000001
\end{array}
$$

と計算されます.


### 2の補数による数の表現

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 補数表示</ins></p>

ある決まった正の数 (普通は基数のベキ数が用いられる) からある正の数を引くことで負の数を
表現することを補数表示といい, 補数表示された負の数を補数(complement) といいます.

</div>

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 2進法における補数</ins></p>

2進法において，自然数 $a$ を表現するのに必要な最小の桁数を $n$としたとき，

- $2^n - a$: 2進法における $a$ に対する 2の補数
- $2^n - a - 1$: 2進法における $a$ に対する 1の補数

</div>

なお英語での表現は, 2の補数: Two's complement, 1の補数: One's complement

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Tips </ins></p>

- 2の補数の最上位ビットは「符号ビット」として実質機能している(符号ビットが0の場合はプラス, 1の場合はマイナス)
- 2の補数における正負反転の計算方法は「2 進数表現を反転させ１を加えたもの」
- 1の補数の場合は「正の数の2 進数表現を反転させたもの」

</div>


> 例: 自然数 9 の2進法における2の補数の求め方

1. 自然数 $9_{10}$ を2進数表現する($= 01001$)
2. 自然数 $9_{10}$ の2進数表現の最小の桁数は 4 となる
3. 10進法ベースで2の補数を計算する: $$2_{10}^4 - 9_{10} = 7_{10}$$
4. 得られた7を2進数表現に直し, 符号を加える: $7_{10} = 10111$


#### 2進数から10進数への変換

32 bit CPUのとき, 最上位ビット$x_{31}$が符号ビットであることに留意すると, 10進数数値$N$は以下のように各ビット, $x_{i}$から計算できる

$$
- x_{31}\times 2^{31} + \sum_{i=0}^{30} x_{i} 2^{i}
$$


> 例題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題: 10進数変換 </ins></p>

補数表示された1111000011110000(2) を普通の 10 進数で答えなさい

</div>

`1111000011110000`は16桁なので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
-1 * 2^15 + 111000011110000_2 &= -32768 + 28912\\
                              &= -3856
\end{align*}
$$


**解答終了**

---


#### 2の補数のメリット

> 表現の幅

4 bit CPUを考えたとき, 1の補数と2の補数で表現できる整数の範囲は

|補数|表現可能な整数の個数|範囲|範囲の2進数表現|
|---|---|---|---|
|1の補数| $15 = 2^4 - 1$ |範囲は $-7 \sim 7$|$1000_{(2)} \sim 0111_{(2)}$　|
|2の補数| $16 = 2^4$ |範囲は $-8 \sim 7$ |$1000_{(2)} \sim 0111_{(2)}$　|

1の補数では $0_{(10)}$ の表現方法が `0000` と `1111` の２つ存在し, この重複分だけ表現可能な整数の個数が少なくなってしまってます.

一方, 関連するデメリットとして2の補数では表現可能な最小の整数に対応する正の数が存在しないことが挙げられます. 

> 正負判定の容易さ

2の補数表現では負の数の最上位ビットが常に1になるので, ハードウェアで数値の正負判定をする場合, 最上位ビットだけ検査するだけで済むというメリットがあります.

> 減算処理の容易さ

減算を, 負数の作成と加算処理で行うことができるというメリットもあります


### 加算と減算におけるオーバーフロー判定

計算結果の数値がハードウェアに用意されているビット幅に収まらない場合, オーバーフローが発生したといいます.
加算対象の２つの数値の符号が異なる場合, その和がオペランドのの一方の値を超えることがないので, オーバーフローは発生しません.

加算及び減算におけるオーバーフローの判定は以下のケースとなります:


|操作|オペランドA|オペランドB|オーバーフロー判定|
|---|---------|----------|-------------|
|$A + B$|$\geq 0$ |$\geq 0$ |$< 0$| 
|$A + B$|$< 0$ |$< 0$ |$\geq 0$| 
|$A - B$|$\geq 0$ |$< 0$ |$< 0$| 
|$A - B$|$< 0$ |$\geq 0$ |$\geq 0$| 

#### ポケモン金銀におけるオーバーフロー問題

ゲームボーイ版のポケモンは, ダメージ計算中に読み込めるのは1byte分(=8 bit)のデータという制約があります.
そのため, ダメージ計算に用いる攻撃力もしくは防御力が256以上(0~255の範囲を超える)となるときは, 一旦両辺（攻撃力と防御力）を4で割る処理が1回のみ入ります.（※かけ算・割り算をするとき、小数点以下が出たときに小数点以下を切り捨てにする）

これは「能力値の上限を999で打ち止めにする処理」が適切に機能する前提で作られた計算処理で, 999以下ならばmaxでも249と255以下に収まり, 8 bit演算処理の観点からオーバーフローは発生しないはずでした. 

しかし, ポケモン金銀では **「ガラガラ + ふといほね + はらだいこ」** という悪名高いアタッカーがいます.

- ふといほね: カラカラ・ガラガラ・ガラガラ(アローラのすがた)に持たせるとこうげきが2倍になる
- はらだいこ: 攻撃力を6段階UP=4倍UP

なので, 攻撃力が128のガラガラは「ふといほね + はらだいこ」で 1024の攻撃力となります.
ここで, 上で説明した **「４で除するルール」** を思い出してもらうと, ダメージ計算時このガラガラの攻撃力は

$$
(1024 / 4)　\text{mod } 256 \equiv 0
$$

次にポケモン金銀のダメージ計算ルールを見てみます

```
ダメージ = (技の威力 ×（レベル × 2 ÷ 5 + 2）× 攻撃力 ÷ 防御側の防御力 ÷ 50 + 2) × タイプ一致補正 × 相性補正 × 乱数補正
```

攻撃力がオーバーフローを起こした場合, 補正前のダメージ計算式は最低の 2, タイプ一致と相性を加味しても最大威力 4 を出力し得ることがわかります.


## Appendix: シェルで2進数整数値を10進数変換したい場合

|変換パターン|元の数|変換コマンド|
|---|---|---|
|16進数→10進数|`F`|`echo $((0xF))`|
|2進数→10進数|`10`|`echo $((2#10))`|
|8進数→10進数|`10`|`echo $((8#10))`|

任意の基底(xx進数)を10進数に変換したい場合は, 頭に`xx#`を付けると元の数が`xx`進数であると指示することが出来ます.

## Appendix: 2進数の表現の幅

$a$を正の整数とし, $b＝a^2$とします. $a$を2進数で表現すると$n$ビットであるとき, $b$を2進数で表現すると最大で何ビットになるかという問題を考えてみたいと思います.

これはシンプルに底を2とする対数をとることで簡単にわかります.

$a=7$ならば $\lfloor\log_2 7\rfloor + 1 = 3$で3 bit必要,
$a=8$ならば $\lfloor\log_2 8\rfloor + 1 = 4$で4 bit必要,
$a=15$ならば $\lfloor\log_2 15 \rfloor + 1 = 4$で4 bit必要.

よって, $\lfloor\log_2 a\rfloor + 1 = n$のとき, 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\lfloor\log_2 b\rfloor + 1 &= \lfloor\log_2 a^2\rfloor + 1\\
                           &= \lfloor 2\log_2 a\rfloor + 1\\
                           &\in [2n-1 , 2n]
\end{align*}
$$

よって, 最大 $2n$ bitとなります.



## References

> 書籍

- [コンピュータの構成と設計 第5版 上, パタヘネ](https://bookplus.nikkei.com/atcl/catalog/14/P98420/)

> 講義ノート

- [u-toyama > 補数](https://kouyama.sci.u-toyama.ac.jp/main/education/2002/prog1/pdf/0203.pdf)

> ブログ

- [きんのいれば > Gen2：仕様に基づく戦略 > オーバーフローの知識と対策](https://gold.hatenadiary.jp/entry/2017/06/18/205506)