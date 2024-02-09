---
layout: post
title: "数と数の関係"
subtitle: "数学・統計周り雑学 2/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-02-09
header-mask: 0.0
header-style: text
tags:

- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [数と数の関係としての関数](#%E6%95%B0%E3%81%A8%E6%95%B0%E3%81%AE%E9%96%A2%E4%BF%82%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AE%E9%96%A2%E6%95%B0)
  - [Correspondence](#correspondence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 数と数の関係としての関数

関数とは, 数と数の対応関係のルールの１つです. 

例えば, 1個100円のキャンディを$x$個買ったときの合計金額を$y$円と表すと,

- 1個購入: $100 \times 1 = 100$
- 2個購入: $100 \times 2 = 200$

と$x$が定まれば$y$がただ一通りに定まります. このように, 「**1つの数に対して, 数が1つだけ決まるとき, この対応関係を関数**」
といいます. キャンディの例だと

$$
y = f(x) = 100x
$$

という対応関係 $f$ が関数となります. また, この関数の変数 $(x, y)$について

- $x$を独立変数
- $y$を従属変数

と呼んだりします. $x$はキャンディの個数なので0以上の整数を値としてとると解釈したとします. すると, 
関数 $f$ の「**定義域**」は $\mathbb Z_+$ となります. また, $y$は0または100の倍数しか取ることが出来ないですが, この空間のことを「**関数の値域（ちいき）**」とよびます. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>例: 関数ではない対応</ins></p>

$x$を独立変数, $y$を従属変数とした

$$
y^2 = x
$$

という関係式を考えてみます. $x = 4$のとき$y=\pm 2$となるので「1つの数に対して, 数が1つだけ決まらない」. 従って, この対応関係は関数はいえません.

</div>

### Correspondence

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: correspondence</ins></p>

- $X$: non-empty subsets of $\mathbb R^N$
- $Y$: non-empty subsets of $\mathbb R^K$

とします. $X$と$Y$の対応関係 $F$ が

$$
F(x) \subset Y \qquad \forall x \in X
$$

となるとき, この対応関係 $F$ のことを「**correpondence**」 といいます

</div>

関数とはすべての$x \in X$について$F(x)$がsingleton setのときと理解することが出来ます. 
またこの対応関係を図示したものを一般的にはグラフと呼びますが, 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: graph</ins></p>

correspondence $F$ の graphは次の集合のことを指す

$$
\text{Graph}(F) = \{(x, y)\in X\times Y \vert y \in F(x)\}
$$

</div>
