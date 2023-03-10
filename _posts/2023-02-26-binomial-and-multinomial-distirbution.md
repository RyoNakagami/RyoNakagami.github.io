---
layout: post
title: "多項分布の周辺密度関数としての二項分布密度関数"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-03-10
tags:

- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [多項分布の定義](#%E5%A4%9A%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AE%E5%AE%9A%E7%BE%A9)
  - [共分散の導出](#%E5%85%B1%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [条件付き確率密度関数の導出](#%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
- [多項分布の周辺密度関数としての二項分布密度関数](#%E5%A4%9A%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AE%E5%91%A8%E8%BE%BA%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AE%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 多項分布の定義

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 多項分布(Multinomial distribution)</ins></p>

$(X_1, \cdots, X_k)$ の $(x_1, \cdots, x_k)$ における同時密度関数が

$$
f(x_1, \cdots, x_k | n, p_1, \cdots, p_{k-1}) = \frac{n!}{x_1!\cdots x_k!}p_1^{x_1}\cdots p_k^{x_k}
$$

と表現されるとき, これを多項分布という.

</div>

これが確率分布になることは, **多項定理**より確認することができる

$$
(p_1+\cdots + p_k)^n =  \sum_D\frac{n!}{x_1!\cdots x_k!}p_1^{x_1}\cdots p_k^{x_k}
$$

> どんなとき多項分布がでてくるの？

ある袋の中に, 赤玉: 5個, 青玉: 3個, 黒玉: 2個, 合計: 10個が入っているときにこの袋から６回復元抽出で１つの玉をランダムに
取り出す試行を考えます. なお, **同じ色の玉同士は区別できない**とします. 取り出された赤, 青, 黒の個数を $(X_1, X_2, X_3)$とすると、この確率変数の組は多項分布に従い

$$
f(x_1, x_2, x_3) = \frac{6!}{x_1!x_3!x_3!}\bigg(\frac{5}{10}\bigg)^{x_1}\bigg(\frac{3}{10}\bigg)^{x_1}\bigg(\frac{2}{10}\bigg)^{x_1}
$$

と確率分布を表現することができる.

### 共分散の導出

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition </ins></p>

$(X_1, \cdots, X_k)$が$(n, p_1, \cdots, p_k)$の多項分布に従うとき, $Cov(X_i, X_j)=-np_ip_j, (i\neq j)$となる

</div>

**証明**

$$
\begin{align*}
\mathbb E[X_iX_j] &= \sum x_ix_j \frac{n!}{x_1!\cdots x_k!}p_1^{x_1}\cdots p_k^{x_k}\\
                  &= n(n-1)p_ip_j \sum_{x_1+\cdots+x_k=n-2} x_ix_j \frac{(n-2)!}{x_1!\cdots x_k!}p_1^{x_1}\cdots p_k^{x_k}\\
                  &= n(n-1)p_ip_j
\end{align*}
$$

従って,

$$
\begin{align*}
Cov(X_i, X_j) &= n(n-1)p_ip_j - n^2p_ip_j \\
              &= -np_ip_j
\end{align*}
$$


**証明終了**

---

### 条件付き確率密度関数の導出

$(X_1, \cdots, X_k)$が$(n, p_1, \cdots, p_k)$の多項分布に従うとき, $X_k = x_k$が与えられたときの条件付き確率分布を計算したいとします.

$$
\begin{align*}
f(x_1, \cdots, x_{k-1}|x_k) &= \frac{n!}{x_1!\cdots x_k!}p_1^{x_1}\cdots p_k^{x_k}\bigg/ \frac{n!}{(n-x_k)!v!}p_k^{x_k}(1 - p_k)^{n-x_k}\\
                            &= \frac{(n-x_k)!}{x_1!\cdots x_{k-1}!}\bigg(\frac{p_1}{1-p_k}\bigg)^{x_1}\cdots bigg(\frac{p_{k-1}}{1-p_k}\bigg)^{x_{k-1}}
\end{align*}
$$


## 多項分布の周辺密度関数としての二項分布密度関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition</ins></p>

$(X_1, \cdots, X_k)$ が以下のような多項分布関数に従うとき, 

$$
f(x_1, \cdots, x_k | n, p_1, \cdots, p_{k-1}) = \frac{n!}{x_1!\cdots x_k!}p_1^{x_1}\cdots p_k^{x_k}
$$

$X_v (1\leq v \leq k)$の確率分布を求めると二項分布になる

</div>

**証明**

$X_v$の周辺確率密度関数を $f_v(x)$と表現すると

$$
f_v(x_v) = \frac{n!}{(n-x_v)!v!}p_v^{x_v}\sum\frac{(n-x_v)!}{x_1!\cdots x_{v-1}!x_{v+1}!\cdots x_k!}p_1^{x_1}\cdots p_{v-1}^^{x_{k-1}}p_{v+1}^{x_{v+1}}\cdots p_k^{x_k}
$$

多項定理より

$$
\begin{align*}
\sum\frac{(n-x_v)!}{x_1!\cdots x_{v-1}!x_{v+1}!\cdots x_k!}p_1^{x_1}\cdots p_{v-1}^^{x_{k-1}}p_{v+1}^{x_{v+1}}\cdots p_k^{x_k} &= (p_1+\cdots+p_{v-1}+p_{v+1}\cdots + p_{k})^{n-x_v}\\
                 &= (1 - p_v)^{n-x_v}
\end{align*}
$$

従って

$$
f_v(x_v) = \frac{n!}{(n-x_v)!v!}p_v^{x_v}(1 - p_v)^{n-x_v}
$$


すなわち, $X_v \sim Bin(n, p_v)$ となることがわかる.

**証明終了**

---
