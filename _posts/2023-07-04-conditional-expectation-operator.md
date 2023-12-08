---
layout: post
title: "Conditional Expectation operator"
subtitle: "条件付き期待値の基本的理解 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-09-28
tags:

- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [CE operatorの性質](#ce-operator%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [条件付き期待値関数の例: 線形性と非線形性](#%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E6%9C%9F%E5%BE%85%E5%80%A4%E9%96%A2%E6%95%B0%E3%81%AE%E4%BE%8B-%E7%B7%9A%E5%BD%A2%E6%80%A7%E3%81%A8%E9%9D%9E%E7%B7%9A%E5%BD%A2%E6%80%A7)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## CE operatorの性質

条件付き期待値はCEオペレーターとも呼ばれたりします.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Conditional Expectations</ins></p>

確率変数 $y$ をOutcome, 確率変数ベクトルの$\mathbf x \equiv(x_1, x_2, \cdots, x_k)$をregressorとしたとき,
$\mathbb E[|y|]\leq \infty$ならば, 

$$
\begin{align*}
\mu: \mathbb R^k \to \mathbb R \text{ such that }\mathbb E[y|\mathbf x] = \mu(\mathbf x)
\end{align*}
$$

を満たす関数が存在する.

</div>

$\mu(\mathbf x)$ は $\mathbf x$が変化したときの平均的(=average)な$y$の値の変化を表現することができます. 
$y$が賃金で, $\mathbf x$が学歴, 経験年数, 性別を表しているとき, $\mu(\mathbf x)$によって(学歴, 経験年数, 性別)が与えられたときの平均的な賃金を計算することができます.


### 条件付き期待値関数の例: 線形性と非線形性

$\mathbf x \equiv(x_1, x_2)$のとき以下のようなCEが考えられます:

$$
\begin{align}
\mathbb E[y|\mathbf x] &= \beta_0 + \beta_1 x_1 + \beta_2x_2\\
\mathbb E[y|\mathbf x] &= \beta_0 + \beta_1 x_1 + \beta_2x_2 + \beta_3x_2^2\\
\mathbb E[y|\mathbf x] &= \beta_0 + \beta_1 x_1 + \beta_2x_2 + \beta_3x_1x_2\\
\mathbb E[y|\mathbf x] &= \exp(\beta_0 + \beta_1 \ln(x_1) + \beta_2x_2)
\end{align}
$$

上記の(1)は$\mathbf x$について線形ですが, $\mathbf x$について(2)~(4)は線形ではありません. ただ分析においては,
(1)~(3)は線形モデルと扱われます. parameter $\beta_j$について線形で表現されているためです.


なお(4)は, 非線形モデルである他に, $x_1$について弾力性が$\beta_1$で一定という特徴があります.
弾力性とは

$$
\text{elasticity} \equiv \frac{\partial \mathbb E[y|\mathbf x]}{\partial x_1}\frac{x_1}{\mathbb E[y|\mathbf x]}
$$


で定義されますが, 「$x_1$について弾力性が$\beta_1$で一定」は以下のようにして確かめられます:

$$
\begin{align*}
\frac{\partial \mathbb E[y|\mathbf x]}{\partial x_1}\frac{x_1}{E[y|\mathbf x]} 
& = \mathbb E[y|\mathbf x]\beta_1\frac{1}{x_1}\frac{x_1}{\mathbb E[y|\mathbf x]}\\
&= \beta_1
\end{align*}
$$









References
-----------

- [Econometric Analysis of Cross Section and Panel Data, Second Edition](https://mitpress.mit.edu/9780262232586/)
