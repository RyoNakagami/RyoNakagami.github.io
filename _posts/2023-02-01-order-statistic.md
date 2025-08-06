---
layout: post
title: "順序統計量(order statistic)と密度関数"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-04-06
tags:

- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [順序統計量とは？](#%E9%A0%86%E5%BA%8F%E7%B5%B1%E8%A8%88%E9%87%8F%E3%81%A8%E3%81%AF)
- [順序統計量の密度関数](#%E9%A0%86%E5%BA%8F%E7%B5%B1%E8%A8%88%E9%87%8F%E3%81%AE%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## 順序統計量とは？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 順序統計量(order statistic)</ins></p>

$X_1, \cdots, X_n \sim F, i.i.d.,$ とするとき, これらの確率変数の値を小さい順に並び替えたものを順序統計量という:

$$
X_{(1)} \leq X_{(2)} \leq \cdots \leq X_{(n)}
$$

</div>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Sample range(Statistical Range)</ins></p>

$X_1, \cdots, X_n \sim F, i.i.d.,$としたとき, $X_{(1)} = \min(X_i)$, $X_{(n)} = \max(X_i)$とすると,
Sample range, $R$, は以下のように定義される:

$$
R \equiv X_{(n)} - X_{(1)}
$$

</div>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Statistical median</ins></p>

$$
Median(X_i) = \begin{cases}
X_{(\frac{n+1}{2})} & \text{ if n is odd}\\[8pt]
\frac{X_{(n/2)} + X_{(n/2 + 1)}}{2} & \text{ if n is even}
\end{cases}
$$

</div>

## 順序統計量の密度関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition</ins></p>

$X_1, \cdots, X_n \sim F, i.i.d.,$ また, $f$を $F$の密度関数とすると順序統計量 $X_{(i)}の累積分布関数及び密度関数は次のように表される:



</div>



## References

> 書籍

- [新装改訂版　現代数理統計学, 竹村彰通 著，学術図書出版社](https://www.gakujutsu.co.jp/product/978-4-7806-0860-1/)

> オンラインマテリアル

- [Wolfram MathWorld > Order Statistic](https://mathworld.wolfram.com/OrderStatistic.html)
