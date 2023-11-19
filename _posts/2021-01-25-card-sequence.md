---
layout: post
title: " 数字が記載されたカードの並べ替え問題:カード数字とindexの一致確率"
subtitle: "確率と数学ドリル 5/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-17
header-mask: 0.0
header-style: text
tags:

- math
- 統計

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [数字が記載れたカードの並べ替え問題](#%E6%95%B0%E5%AD%97%E3%81%8C%E8%A8%98%E8%BC%89%E3%82%8C%E3%81%9F%E3%82%AB%E3%83%BC%E3%83%89%E3%81%AE%E4%B8%A6%E3%81%B9%E6%9B%BF%E3%81%88%E5%95%8F%E9%A1%8C)
  - [期待値の導出](#%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [分散の導出](#%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 数字が記載れたカードの並べ替え問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$1, 2, \cdots. m$の数字を書いたカードをよくシャッフルしてから, 一列に並べてみる.
配列のindexを1から始まり$m$で終わるとしたとき, カードの記載番号と配列indexが一致する枚数を$X$とする.

このとき, $X$の期待値と分散を求めよ.

</div>

<div class="math display" style="overflow: auto">
$$
X_k = \begin{cases}
    1 & \text{ k indexについて, カード数値とindexが一致}\\
    0 & \text{ otherwise}
\end{cases}
$$
</div>

としたとき, $X = \sum_{1\leq k \leq m}X_k$と表現できます. $X_k$は互いには独立ではないことに留意して問題を解きます.

### 期待値の導出

$X_k$は互いには独立ではないですが, 期待値は線形分離できるので

$$
\mathbb E[X] = \sum_{1\leq k \leq m}\mathbb E[X_k]
$$

$\mathbb E[X_k]$は$1/m$であることがすぐわかるので

$$
\mathbb E[X] = 1
$$

となる.

### 分散の導出

$X_k$は互いには独立ではないので, 期待値と同様に分散を線形分離して計算するのは無理です.
期待値はすでに出ているので, 2次モーメントについて考えます.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \mathbb E[(\sum_{1\leq k \leq m} X_k)^2]\\
               &= \sum_{1\leq k \leq m}\mathbb E[X_k^2] + 2\sum_{1\leq i<j\leq m} E[X_iX_j]
\end{align*}
$$
</div>

$X_iX_j$について見てみると

$$
X_iX_j = \begin{cases}
1 \text{index i, jについて, カード数値とindexが一致}\\
0 & \text{ otherwise}
\end{cases}
$$

index i, j以外については並び方は何でも良いので

$$
Pr(X_iX_j) = \frac{1}{m!/(m-2)!}=\frac{1}{m(m-1)}
$$

したがって,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \mathbb E[(\sum_{1\leq k \leq m} X_k)^2]\\
               &= \sum_{1\leq k \leq m}\mathbb E[X_k^2] + 2\sum_{1\leq i<j\leq m} E[X_iX_j]\\
               &= \frac{1}{m}\times m + 2\bigg(\begin{array}{c}m\\2\end{array}\bigg)\frac{1}{m(m-1)}\\
               &= 2
\end{align*}
$$
</div>

よって, 分散は$V(X) = \mathbb E[X^2] - \mathbb E[X]^2 = 1$


References
------------
- [Ryo's Tech Blog > Trapped Miner Problem](https://ryonakagami.github.io/2021/01/24/miner-choose-door/)
