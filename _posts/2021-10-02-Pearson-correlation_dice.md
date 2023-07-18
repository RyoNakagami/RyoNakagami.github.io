---
layout: post
title: "Pearson相関係数: 多項分布とサイコロの出目の相関係数"
subtitle: "相関係数 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-03-02
tags:

- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
- [解答](#%E8%A7%A3%E7%AD%94)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 問題設定

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$n$ 個のフェアな6面サイコロを振ったとき, 1の目がでたサイコロの個数 $X$ と 2の目がでたサイコロの個数 $Y$の２つの確率変数を考える.
このとき, $X$と$Y$のPearson相関係数 $\rho(X, Y)$を計算せよ

</div>

## 解答

$n$ 個のフェアな6面サイコロについて, 1と2以外の出目の個数を$Z$とすると, 同時分布関数 $Pr(X, Y, Z)$ 
は多項分布に従うので以下のように表現できる

$$
Pr(X=x, Y=y, Z=z) = \frac{n!}{x!y!z!}\bigg(\frac{1}{6}\bigg)^{x+y}\bigg(\frac{4}{6}\bigg)^z
$$

従って, 共分散は

$$
\begin{align*}
\mathbb E[XY] &= \sum_{x+y+z=n} \frac{n!}{x!y!z!}\bigg(\frac{1}{6}\bigg)^{x+y}\bigg(\frac{4}{6}\bigg)^zxy\\[8pt]

&=\frac{n(n-1)}{36}\sum_{(x-1)+(y-1)+z=n-2} \frac{(n-2)!}{(x-1)!(y-1)!z!}\bigg(\frac{1}{6}\bigg)^{x-1}\bigg(\frac{1}{6}\bigg)^{y-1}\bigg(\frac{4}{6}\bigg)^z\\[8pt]

&=\frac{n(n-1)}{36}
\end{align*}
$$

期待値と分散ははそれぞれ

$$
\begin{align*}
&\mathbf E[X] = \mathbf E[Y] = \frac{n}{6}\\
&Var(X) = Var(Y) = n\times\frac{1}{6}\times\frac{5}{6}= \frac{5n}{36}
\end{align*}
$$

よって,

$$
\begin{align*}
\rho(X, Y) &= \bigg(\frac{n(n-1)}{36} - \frac{n^2}{36}\bigg)\bigg/\frac{5n}{36}\\
&= -\frac{1}{5}
\end{align*}
$$


**解答終了**
