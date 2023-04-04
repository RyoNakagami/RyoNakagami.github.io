---
layout: post
title: "文字コード > ギリシア文字"
author: "Ryo"
header-img: "img/cpu.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2020-10-10
purpose: 
tags:

- LaTex
- 文字コード
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [ギリシア文字対応表](#%E3%82%AE%E3%83%AA%E3%82%B7%E3%82%A2%E6%96%87%E5%AD%97%E5%AF%BE%E5%BF%9C%E8%A1%A8)
- [Unicodeとは？](#unicode%E3%81%A8%E3%81%AF)
  - [UnicodeとUTF-8の関係](#unicode%E3%81%A8utf-8%E3%81%AE%E9%96%A2%E4%BF%82)
  - [UTF-8の変換ルール](#utf-8%E3%81%AE%E5%A4%89%E6%8F%9B%E3%83%AB%E3%83%BC%E3%83%AB)
  - [UTF-8エンコードされたUnicodeに慣れよう](#utf-8%E3%82%A8%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%89%E3%81%95%E3%82%8C%E3%81%9Funicode%E3%81%AB%E6%85%A3%E3%82%8C%E3%82%88%E3%81%86)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>


## ギリシア文字対応表

一般的なギリシア文字は24文字から成り立っています.

|大文字|JIS|Unicode |LaTex|小文字 |JIS |Unicode|LaTex　|読み|
|---|---|---|---|---|---|---|---|---|
|Α 	|`2621` |`0391`|`\Alpha`|α|`2641`| `03B1` |`\alpha`|アルファ|
|Β 	|`2622` |`0392`|`\Beta`|β|`2642`| `03B2` |`\beta`|ベータ|
|Γ 	|`2623` |`0393`|`\Gamma` |γ|`2643`| `03B3` |`\gamma`|ガンマ|
|Δ 	|`2624` |`0394`|`\Delta` |δ|`2644`| `03B4` |`\delta`|デルタ|
|Ε 	|`2625` |`0395`|`\Epsilon` |ε|`2645`| `03B5` |`\epsilon`|イプシロン|
|Ζ 	|`2626` |`0396`|`\Zeta` |ζ|`2646`| `03B6` |`\zeta`|ゼータ|
|Η 	|`2627` |`0397`|`\Eta` |η|`2647`| `03B7` |`\eta`|イータ|
|Θ 	|`2628` |`0398`|`\Theta` |θ|`2648`| `03B8` |`\theta`|シータ|
|Ι 	|`2629` |`0399`|`\Iota` |ι|`2649`| `03B9` |`\iota`|イオタ|
|Κ 	|`262A` |`039A`|`\Kappa` |κ|`264A`| `03BA` |`\kappa`|カッパ|
|Λ 	|`262B` |`039B`|`\Lambda` |λ|`264B`| `03BB` |`\lambda`|ラムダ|
|Μ 	|`262C` |`039C`|`\Mu` |μ|`264C`| `03BC` |`\mu`|ミュー|
|Ν 	|`262D` |`039D`|`\Nu` |ν|`264D`| `03BD` |`\nu`|ニュー|
|Ξ 	|`262E` |`039E`|`\Xi` |ξ|`264E`| `03BE` |`\xi`|グザイ, クシィー|
|Ο 	|`262F` |`039F`|`\Omicron` |ο|`264F`| `03BF` |`\omicron`|オミクロン|
|Π 	|`2630` |`03A0`|`\Pi` |π|`2650`| `03C0` |`\pi`|パイ|
|Ρ 	|`2631` |`03A1`|`\Rho` |ρ|`2651`| `03C1` |`\rho`|ロー|
|Σ 	|`2632` |`03A3`|`\Sigma` |σ|`2652`| `03C3` |`\sigma`|シグマ|
|Τ 	|`2633` |`03A4`|`\Tau` |τ|`2653`| `03C4` |`\tau`|タウ|
|Υ 	|`2634` |`03A5`|`\Upsilon` |υ|`2654`| `03C5` |`\upsilon`|ウプシロン|
|Φ 	|`2635` |`03A6`|`\Phi` |φ|`2655`| `03C6` |`\phi`|ファイ|
|Χ 	|`2636` |`03A7`|`\Xi` |χ|`2656`| `03C7` |`\chi`|カイ|
|Ψ 	|`2637` |`03A8`|`\Psi` |ψ|`2657`| `03C8` |`\psi`|プサイ|
|Ω 	|`2638` |`03A9`|`\Omega` |ω|`2658`| `03C9` |`\omega`|オメガ`|

## Unicodeとは？

コンピューター上で利用する文字と, 各文字に割り当てた数値と, バイトで表した数字の対応関係のことを文字コードといいます.

文字コードは2つの要素から成り立っています:

---|---
符号化文字集合|表現したい文字の範囲
文字符号化方式（エンコーディング）|文字集合を構成する個々の文字の表現方法（数値の振り方）

この「符号化文字集合」にはJISやASCIIがあり, Unicodeもこの一種です. 
Unicodeはギリシャ語, 日本語, 中国語, 記号など、世界で使われているすべての文字を共通の文字集合で利用できることを目的に
ユニコード・コンソーシアムという団体によって作成された背景があります.

### UnicodeとUTF-8の関係

Unicodeで割り振ったコードポイントの文字符号化形式(encoding形式)の一種です. なので厳密には文字コードそれ自体ではなく, その構成要素としての「文字符号化方式（エンコーディング）」のことです. 

UTF-8の特徴として

- ASCIIと同じ文字は1バイト
- その他の文字については2～6バイトを用いて文字を表現する

という特徴があります. ASCIIとの対応関係があるので **「ASCIIと上位互換性がある」** と言われたりします.

今回は詳しく説明しないですが, UTF-16と異なりUTF-8にはエンディアンの問題がないというメリットがあります.

UnicodeとUTF-8の対応例として, 小文字ギリシア文字の $\alpha$ を考えます.

|文字|Unicode|UTF-8|
|---|---|---|
|α|`03B1`|`0xCE 0xB1`|

> 他のエンコーディング方式の特徴

---|---
UTF-7|ASCII文字だけを使用することが前提の電子メールで利用するために, 7ビットで表現
UTF-16|2バイトで表現する領域に収まらない文字は, 上位サロゲートと下位サロゲートを組み合わせて4バイトで表現
UTF-32|各符号位置が4バイトの固定長で表現

### UTF-8の変換ルール

Unicodeを2進数へ一旦変換し, その値をUTF-8の2進数へ変換, 16進数UTF-8へ変換するのが基本です.
しかし, Unicode2進数をUTF-8の2進数へ変換する際に, Unicodeの範囲の応じて変換ルールが異なります.

|範囲|Unicode|UTF-8の2進数表現|
|---|---|---|
|範囲1|`U+0000` - `U+007F`|`0xxx xxxx`|
|範囲2|`U+0080` - `U+07FF`|`110x xxxx 10xx xxxx`|
|範囲3|`U+0800` - `U+FFFF`|`1110 xxxx 10xx xxxx 10xx xxxx`|
|範囲4|`U+1000`0 -` U+10FFFF`|`1111 0xxx 10xx xxxx 10xx xxxx 10xx xxxx`|

なお, 範囲1の`U+0000` - `U+007F`の文字はUS-ASCIIと互換を持っており, UTF-8の表現範囲は`0x00` - `0x7F`となります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Tips</ins></p>

Unicode文字列をUTF-8でエンコードすると，各文字のエンコード結果の先頭バイトは2進表示が`0`又は`11`で始まり, それ以降のバイトは`10`で始まります. つまり, 1 byte = 8 bitなので, 最初の8桁は`0`又は`11`で始まり, それ以降の8桁グループは `10`で始まる.

</div>


> Example

$\alpha$を例に, UnicodeからUTF-8への変換を紹介します.

1. $\alpha$のUnicode `03B1` を2進数に変換する → `011 1011 0001`
2. `03B1`は範囲2なので範囲2のルールに従って変換する → `1100 1110 1011 0001`
3. `1100 1110 1011 0001`を16進数変換する → `CEB1`
4. 16進数リテラルの表記へ変換する → `0xCE 0xB1`

### UTF-8エンコードされたUnicodeに慣れよう

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 文字数カウント</ins></p>

Unicode文字列をUTF-8でエンコードすると,各文字のエンコード結果の先頭バイトは2進表示が0又は11で始まり,それ以降のバイトは10で始まる. 16進表示された次のデータは何文字のUnicode文字列をエンコードしたものか?

```raw
CF 80 E3 81 AF E7 B4 84 33 2E 31 34 E3 81 A7 E3 81 99
```

</div>

**解答**

- 先頭ビットが`0`になるのは16進表記で`0～7`
- 先頭が`11`になるビットは16進表記で`C～F`

なので

<span style="color: red; ">C</span>F 80 <span style="color: red; ">E</span>3 81 AF <span style="color: red; ">E</span>7 B4 84 <span style="color: red; ">3</span>3 <span style="color: red; ">2</span>E <span style="color: red; ">3</span>1 <span style="color: red; ">3</span>4 <span style="color: red; ">E</span>3 81 A7 <span style="color: red; ">E</span>3 81 99

なのでデータに含まれる文字数は9文字

**解答終了**

---

## References

- [UTF-8コード表](https://www.seiai.ed.jp/sys/text/java/utf8table.html)