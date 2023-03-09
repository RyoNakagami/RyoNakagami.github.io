---
layout: post
title: "Chebyshev inequalityの導出"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-03-09
tags:

- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Chebyshev inequalityの定理](#chebyshev-inequality%E3%81%AE%E5%AE%9A%E7%90%86)
- [証明](#%E8%A8%BC%E6%98%8E)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Chebyshev inequalityの定理

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

確率変数 $X$ に対して $\mathbf E[X] = \mu, Var(X) = \sigma^2$とおいたとき

$$
\begin{align*}
&Pr\{|X - \mu|\geq k\sigma\} \leq \frac{1}{k^2}\\
&\text{where } k > 1 \text{ and constant}
\end{align*}
$$


</div>

## 証明

以下のような確率変数 $D$ を定義する

$$
D = \begin{cases}
1 & \text{ if } |X - \mu|\geq k\sigma\\
0 & \text{ otherwise}
\end{cases}
$$

すると, 以下の式が常に成り立つ

$$
(X - \mu)^2 \geq k^2\sigma^2U
$$

従って, 

$$
\begin{align*}
\sigma^2 &= Var(X)\\
         &= \mathbf E[(X - \mu)^2]\\
         &\geq \mathbf E[k^2\sigma^2U]\\
         &= k^2\sigma^2\mathbf E[U]\\
\Rightarrow& \frac{1}{k^2} \geq  \mathbf E[U]
\end{align*}
$$

定義より, $\mathbf E[U]$は $Pr\{|X - \mu|\geq k\sigma\}$と同値なので

$$
Pr\{|X - \mu|\geq k\sigma\} \leq \frac{1}{k^2}
$$

**証明終了**
