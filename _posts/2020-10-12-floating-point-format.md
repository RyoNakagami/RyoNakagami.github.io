---
layout: post
title: "固定小数点表示と浮動小数点表示"
subtitle: "コンピューターにおける算術演算 3/N"
author: "Ryo"
header-img: "img/cpu.png"
header-mask: 0.4
mathjax: true
catelog: true
revise_date: 2023-04-01
tags:
  - 数値計算
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [浮動小数点表示の考え方](#%E6%B5%AE%E5%8B%95%E5%B0%8F%E6%95%B0%E7%82%B9%E8%A1%A8%E7%A4%BA%E3%81%AE%E8%80%83%E3%81%88%E6%96%B9)
- [固定小数点数(Fixed-point arithmetic)](#%E5%9B%BA%E5%AE%9A%E5%B0%8F%E6%95%B0%E7%82%B9%E6%95%B0fixed-point-arithmetic)
  - [練習問題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C)
- [浮動小数点数](#%E6%B5%AE%E5%8B%95%E5%B0%8F%E6%95%B0%E7%82%B9%E6%95%B0)
  - [IBM 方式](#ibm-%E6%96%B9%E5%BC%8F)
    - [正規化](#%E6%AD%A3%E8%A6%8F%E5%8C%96)
  - [IEEE方式](#ieee%E6%96%B9%E5%BC%8F)
    - [イクセス表現](#%E3%82%A4%E3%82%AF%E3%82%BB%E3%82%B9%E8%A1%A8%E7%8F%BE)
    - [IEEE方式におけるeconomized form](#ieee%E6%96%B9%E5%BC%8F%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Beconomized-form)
    - [IEEE単精度浮動小数点数の表現範囲](#ieee%E5%8D%98%E7%B2%BE%E5%BA%A6%E6%B5%AE%E5%8B%95%E5%B0%8F%E6%95%B0%E7%82%B9%E6%95%B0%E3%81%AE%E8%A1%A8%E7%8F%BE%E7%AF%84%E5%9B%B2)
  - [浮動小数点数の問題点](#%E6%B5%AE%E5%8B%95%E5%B0%8F%E6%95%B0%E7%82%B9%E6%95%B0%E3%81%AE%E5%95%8F%E9%A1%8C%E7%82%B9)
  - [練習問題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C-1)
- [Appendix: r進数と英語表現](#appendix-r%E9%80%B2%E6%95%B0%E3%81%A8%E8%8B%B1%E8%AA%9E%E8%A1%A8%E7%8F%BE)
- [Appendix: NaNとは？](#appendix-nan%E3%81%A8%E3%81%AF)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 浮動小数点表示の考え方

コンピュータが直接扱うことのできるデータは, 0 と 1 を有限個並べて表現する 2 進数ですが, 
小数の形式で表現される数については一般的には浮動小数点数という形式で記憶されてます.

この浮動小数点数を理解するためには, まず単純な固定小数点を理解する必要があるので先に解説します.

## 固定小数点数(Fixed-point arithmetic)

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E6%8A%80%E8%A1%93%E8%80%85%E8%A9%A6%E9%A8%93/20201012_%E5%9B%BA%E5%AE%9A%E5%B0%8F%E6%95%B0%E7%82%B9_figure.png?raw=true">

n bit与えられた時, $i$ bitと $i-1$ bitの間に小数点が固定されているとして数値を表現する方法です.
`signed int`の場合は 小数点が第 0 ビットの右側にある (固定されている) 固定小数点の特殊な場合と考えることが出来ます.

この固定された小数点の位置のことを **binary point** と呼んだりします.

> メリット

- 浮動小数点数にくらべ高速に計算できる


> デメリット

- 浮動小数点数に比べて表現できる値の範囲ははるかに狭いため, 算術オーバーフローや算術アンダーフロー, 丸め誤差が発生しやすい

たとえば、2 進小数点の右側が 4 ビットの固定小数点の表現は, 精度が $2^{-4}$, つまり最下位ビットの値になります.
これ以下の数値については表現することが出来ず丸め誤差が発生してしまいます.


### 練習問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 1: 基本情報技術者試験平成18年秋期　問5</ins></p>

負数を2の補数で表す16ビットの符号付き固定小数点数の最小値を表すビット列を，16進数として表せ

</div>

**解答**

2の補数で表す16ビットの符号付き固定小数点数の最小値はbinary pointの位置に関わらず

```
1000 0000 0000 0000
```

従って, これを16進数変換すると `8000`

**解答終了**

---

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 2: 固定小数点による表示 </ins></p>

10進数-5.625を, 8ビット固定小数点形式による2進数で表しなさい. 
ここで, 小数点位置は3ビット目と4ビット目の間とし, 負数には2の補数表現を用いる

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E6%8A%80%E8%A1%93%E8%80%85%E8%A9%A6%E9%A8%93/IT_exam_01.png?raw=true">

</div>

**解答**

$5.625$ を8ビット固定小数点形式にて2進数表現すると`0101.1010`.
今回は2の補数表現を用いているので, $-5.625$は

```zsh
(1): 0101.1010
(2): 1010.0101 #反転
(3): 1010.0110 #プラス1
```

従って, `1010.0110`


**解答終了**

---



<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 3: 固定小数点の表示範囲 </ins></p>

8 ビットで2の補数表示の固定小数点表示したとき、小数点が第 4 ビットと第 3 ビットの間にあると仮
定します. この条件で表される数値を$x$としたとき, 最大値と最小値を求めなさい.

</div>

**解答**

- 最小: `1000 0000`
- 最大: `0111 1111`

なので, $x \in [-8, 7.9375]$

**解答終了**

---

## 浮動小数点数

浮動小数点数は固定小数点表示に比べ非常に大きな数や非常に小さな数を表示するのに適しています.
データ型「倍精度浮動小数点」(64 bit)と「単精度浮動小数点」(32 bit)の二つがある（C言語ではdouble, floatがそれぞれに対応している）が表示構造としてはどちらも基本的なところは同じで

$$
(-1)^S \times M \times B^E
$$

- S: 符号
- M: 仮数部(mantissa)
- E: 指数部(exponent)
- B: 底(base) 

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E6%8A%80%E8%A1%93%E8%80%85%E8%A9%A6%E9%A8%93/20201012_floating_point_format.png?raw=true">

具体的実装方式としては, 代表的なものとして「**IBM方式**」と「**IEEE方式(IEEE 754方式)**」があります.


### IBM 方式

底を16という特徴があります. 表示される数は単精度に基づく場合

$$
(-1)^{S} \times 16^{E-64} \times M
$$

---|---
符号部|正負を表す
指数部|16を基数とし +64 のバイアス表現
仮数部|1未満 0 以上の2進数

IBM 方式の浮動小数点の仮数部と指数部のbit数は単精度と倍精度それぞれで以下の通りとなります:

||単精度|倍精度|
|---|---|---|
|符号|1 bit|1 bit|
|指数部|7 bit|8 bit|
|仮数部|24 bit| 55 bit|
|合計|32 bit| 64 bit|

#### 正規化

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 浮動小数点表示における正規化</ins></p>

浮動小数点数が一意かつ有効数字が長くなる(=仮数部を無駄なく使う)ように, 仮数部の上位1 bitを1になるように調整すること

</div>

10進小数 0.05 を 2 進小数に変換すると

SS
0.0000 1100 1100 1100 1100 1100..._{(2)}
SS

これを仮数部として採用してしまうと, このままだと先頭にならぶ 4 ビットの0が無駄になるってしまいます.
ここで正規化を実施すると

$$
0.1100 1100 1100 1100 1100 \times 16^{-1}
$$

と表現されるようになります.

### IEEE方式

IEEE方式は「アイ・トリプルイー方式」と読みます. 高精度の数値計算を最適に実行するために米国電気電子技術者協会で提唱した規
格で、現在、多くのワークステーションやパーソナルコンピュータで採用されている方式です. 

表示される数は単精度に基づく場合

$$
(-1)^{S} \times 2^{E-127} \times (1+M)
$$

倍精度に基づく場合は

$$
(-1)^{S} \times 2^{E-1023} \times (1+M)
$$


---|---
符号部|正負を表す
指数部|2を基数とし +127(単精度) +1023(倍精度) のバイアス表現(=イクセス表現)
仮数部|1未満 0 以上の2進数, 1以下の2進小数,正規化され,さらにeconomized form をとる


||単精度|倍精度|
|---|---|---|
|符号|1 bit|1 bit|
|指数部|8 bit|11 bit|
|仮数部|23 bit| 52 bit|
|合計|32 bit| 64 bit|

#### イクセス表現

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: イクセス表現</ins></p>

nビットで数を表すとき, $2^{n-1}$ を $0$ として、それより上の数を正の数、下の数を負の数とする表示方法をイクセス表現という.
表せる範囲の中央の値を0と見做すことで, 符号ビットを使わずにマイナスの値を表すことが可能となる.

例えば, 4 bitならば`0111`が 0となります.

</div>




#### IEEE方式におけるeconomized form

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Economized form</ins></p>

仮数部は, $1.xxxx$ となるように正規化され, $1$ は省略して $.xxxx$ の部分だけを記憶する表現のことをEconomized formという.

</div>

#### IEEE単精度浮動小数点数の表現範囲

IEEE単精度浮動小数点数における数の表し方の基本は

$$
(-1)^{S} \times 2^{E-127} \times (1+M)
$$

> 特別な値の表現

非数(`NaN`)や$\infty$を表す場合を含めると以下のようになります

|条件|表示範囲|
|---|---|
|$E\in (0, 255)$|$(-1)^{S} \times 2^{E-127} \times (1+M)$|
|$E=255, M\neq 0$|`NaN`|
|$E=255, M=0$|$(-1)^S\times \infty$|
|$E=0, M\neq 0$|$(-1)^S\times (0.M)_{(2)} \times 2^{-126}$|
|$E=0, M=0$|$(-1)^S\times 0$|


> `float`型で表現し得る数の範囲

---|---
0より大きい正の最小数|$1.0 \times 2^{-126}$
正の最大数|$1.11\cdots \times 2^{127}$
0より小さい負の最大数|$-1.0 \times 2^{-126}$
負の最小数|$-1.11\cdots \times 2^{127}$

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/numerical_computation/IEEE754_overflow_underflow.png?raw=true">

### 浮動小数点数の問題点

1. 仮数部が有限桁しか存在しないため, 「**丸め誤差**」が発生する
2. 指数部も有限桁のため「**オーバフロー**」と「**アンダフロー**」の発生
3. ほぼ等しい値の浮動小数点数同士の減算の際に, 「**桁落ち**」が発生するリスクがある
4. 小さな数と大きな数の加減算で「**情報落ち**」が発生するリスクがある


### 練習問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 実数のfloat表現への変換</ins></p>

10進数で表現された$-1$と$1$をIEEE754単精度, `float`型で表現せよ

</div>

**解答**

$2^{0} \times 1.0 = 1$であるので

```
0 01111111 00000000000000000000000
1 01111111 00000000000000000000000
```

**解答終了**

---

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 応用情報技術者平成22年春期 午前問2</ins></p>

以下のような16ビットの浮動小数点形式において，10進数 0.25 を正規化した表現を書け. なお, 正規化は仮数部の最上位桁が1になるように指数部と仮数部を調節する操作とする.

$$
-1^S \times M \times 2^{E}
$$

- S: 符号ビット, 1 bit
- E: 指数部(負の数は2の補数で表現), 4 bit
- M: 仮数部(符号なし2進数), 11 bit

</div>

**解答**

0.25を２進数表現すると`0.01`となる.
正規化を踏まえると 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
&2^{-1_{(10)}} \times 0.1_{(2)}\\
&\Rightarrow -1_{(10)} = 1111_{(2)}
\end{align*}
$$

従って, `0 1111 10000000000`が答えとなる.

- S: `0`
- E: `1111`
- M: `10000000000`




**解答終了**

---

## Appendix: r進数と英語表現

---|---
2進数|binary number
8進数|octal number
10進数|deciaml number
16進数|hexadecimal number


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>練習問題: ２進数を16進数へ変換</ins></p>

$10101100.01010011$という２進数は, 16進数でいくつか？

</div>


**解答**

$10101100.01010011$を見やすくするため4区分ずつ表すと `1010 1100. 0101 0011`. 
従って, 

$$
\begin{align*}
1010_{(2)} &= A_{(16)}\\ 
1100_{(2)} &= C_{(16)}\\ 
0101_{(2)} &= 5_{(16)}\\ 
0011_{(2)} &= 3_{(16)} 
\end{align*}
$$

従って, $AC.53$ となります.

**解答終了**

---




## Appendix: NaNとは？

`NaN` とは 「**not a number**」を表すnumeric data typeのことです.
直感的には定義できない数を表すnumeric data typeと理解して大丈夫です. 定義できない数の例として

- $0/0$
- $\sqrt{-x} \  \$ where $x \geq 0$
- $\log x \  \$ where $x < 0$

などがあります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: `NaN` vs `infinity`</ins></p>

コンパイラーによって詳細は異なりますが, 計算結果が不定の場合は`NaN`, 実数演算で最大値を超えるような演算(=オーバーフローを起こすような演算)の実行結果は`Infinity`となります.

> NaNの倍精度表現

$E=1023, M\neq 0$が`NaN`を表すので

```
1 11111111111 1111111111111111111111111111111111111111111111111111
0 11111111111 1000000000000000000000000000000000000000000000000000
```

> Infinityの倍精度表現

$E=1023, M=0$が$-\infty, \infty$を表すので

```
## Infinity
0 11111111111 0000000000000000000000000000000000000000000000000000

## -Infinity
1 11111111111 0000000000000000000000000000000000000000000000000000
```

</div>


## References

> 資格試験

- [基本情報技術者試験ドットコム > 基本情報技術者平成23年秋期 午前問2](https://www.fe-siken.com/kakomon/23_aki/q2.html)
- [IT資格試験](http://www.it-shikaku.jp/top.php)


> 講義ノート

- [u-toyama > 補数](https://kouyama.sci.u-toyama.ac.jp/main/education/2002/prog1/pdf/0203.pdf)
- [Tohoku University > 計算機工学・第3章 「実数の表現」](http://www.vision.is.tohoku.ac.jp/files/1814/9359/7662/3rd.pdf)


> オンラインマテリアル

- [How to assign NaN to a variable in Python](https://www.educative.io/answers/how-to-assign-nan-to-a-variable-in-python)

> オンラインツール

- [浮動小数点数内部表現シミュレーター](https://tools.m-bsys.com/calculators/ieee754.php)