---
layout: post
title: "確率変数の独立性"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-02-20
tags:

- 統計
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [確率変数の独立性](#%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7)
  - [独立ならば無相関の証明](#%E7%8B%AC%E7%AB%8B%E3%81%AA%E3%82%89%E3%81%B0%E7%84%A1%E7%9B%B8%E9%96%A2%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [例題: 無相関だが独立ではないパターンの紹介](#%E4%BE%8B%E9%A1%8C-%E7%84%A1%E7%9B%B8%E9%96%A2%E3%81%A0%E3%81%8C%E7%8B%AC%E7%AB%8B%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%84%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%81%AE%E7%B4%B9%E4%BB%8B)
- [変数変換したら独立になる場合](#%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B%E3%81%97%E3%81%9F%E3%82%89%E7%8B%AC%E7%AB%8B%E3%81%AB%E3%81%AA%E3%82%8B%E5%A0%B4%E5%90%88)
  - [離散変数の例](#%E9%9B%A2%E6%95%A3%E5%A4%89%E6%95%B0%E3%81%AE%E4%BE%8B)
- [無相関が変数間の独立を意味するケースの紹介](#%E7%84%A1%E7%9B%B8%E9%96%A2%E3%81%8C%E5%A4%89%E6%95%B0%E9%96%93%E3%81%AE%E7%8B%AC%E7%AB%8B%E3%82%92%E6%84%8F%E5%91%B3%E3%81%99%E3%82%8B%E3%82%B1%E3%83%BC%E3%82%B9%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [二値変数：無相関なら独立](#%E4%BA%8C%E5%80%A4%E5%A4%89%E6%95%B0%E7%84%A1%E7%9B%B8%E9%96%A2%E3%81%AA%E3%82%89%E7%8B%AC%E7%AB%8B)
- [正規分布に従う確率変数とsample mean residualの独立性](#%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AB%E5%BE%93%E3%81%86%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%A8sample-mean-residual%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7)
- [Resources](#resources)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>


## 確率変数の独立性

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 事象間の独立</ins></p>

２つの確率事象 $A, B$ について以下の関係式を満たすとき, $A$ と $B$ は独立であるという.

$$
P(A\cap B) = P(A)\cdot P(B)
$$

</div>



### 独立ならば無相関の証明

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 独立ならば無相関</ins></p>

2つの確率変数 $X, Y$ が独立ならば, $Cov(X, Y) = 0$ となります.

</div>

**証明**

$f(x, y)$を同時確率密度関数とすると

$$
\begin{align*}
\mathbf E[XY] &= \int_x\int_y xy f_{XY}(x, y)dydx\\
              &= \int_x\int_y xy f_X(x)f_Y(y)dydx\\
              &= \int_x xf_X(x) \bigg(\int_y y f_Y(y)dy\bigg)dx\\
              &= \mathbf E[Y] \int_x xf_X(x) dx\\
              &= \mathbf E[X]\mathbf E[Y]
\end{align*}
$$

従って, $Cov(X, Y) = \mathbf E[XY] - \mathbf E[X]\mathbf E[Y] = 0$

**証明終了**


### 例題: 無相関だが独立ではないパターンの紹介

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Example </ins></p>

$$
\begin{align*}
&f(x, y) = \frac{1}{2}\\
&\text{where } |x+y| < 1, |x-y| < 1 
\end{align*}
$$

で定義される密度関数を考えます. このとき, 確率変数の組$(x, y)$は$\rho_{xy} = 0$ですが, 独立ではありません 

</div>

**独立ではない証明**

まず$x$と$y$についての周辺密度を求めます

$$
\begin{align*}
f_x(x) &= \int_D f(x, y)dy\\
       &= \int_{|x|-1}^{1-|x|}\frac{1}{2}dy\\
       &= 1 - |x| 
\end{align*}
$$

同様に$f_y(y) = 1 - |y|$.

従って,

$$
f_x(x)f_y(y) &= (1-|x|)(1-|y|)\\
             &\neq f(x, y)
$$

よって独立ではない.

**証明終了**

---

**相関係数が0の証明**

$$
\begin{align*}
\mathbf E[x]  &= \int_{-1}^1 x(1- |x|) = 0\\
\mathbf E[y]  &= \int_{-1}^1 y(1- |y|) = 0\\
\mathbf E[xy] &= \int\int_D xy f(x, y)dydx\\[8pt]
              &= \frac{1}{2} \int\int_D xy dydx\\[8pt]
              &= \frac{1}{2} \int^1_{-1} \int^{1 - |x|}_{|x| - 1}xy dy dx\\
              &= \frac{1}{2} \int_{-1}^1 x \left(\frac{1}{2} (1-| x| )^2-\frac{1}{2} (-1+| x| )^2\right)  dx\\
              &= \frac{1}{2} \int_{-1}^1 x \times 0 dx\\
              &= 0
\end{align*}
$$

従って, $\rho_{xy} = 0$


**証明終了**


## 変数変換したら独立になる場合
### 離散変数の例

離散確率変数の組 $(X, Y)$がしたのテーブルのような同時分布に従うします

|$X$\ $Y$|$-1$|$0$|$1$|
|---|---|---|---|
|$-1$|$1/8$|$1/8$|$0$|
|$0$|$1/8$|$2/8$|$1/8$|
|$1$|$0$|$1/8$|$1/8$|

このとき, $X$と$Y$は独立ではないことは明らかですが, $X^2$, $Y^2$は独立となります.

**証明**

$(X^2,Y^2)$についての同時分布を求めると

|$X^2$\ $Y^2$|$0$|$1$|計|
|---|---|---|---|
|$0$|$1/4$|$1/4$|$1/2$|
|$1$|$1/4$|$1/4$|$1/2$|
|計|$1/2$|$1/2$|$1$|

となり, 「同時確率 = 周辺確率の積」が成立しているので$X^2$, $Y^2$は独立

**証明終了**

---


## 無相関が変数間の独立を意味するケースの紹介
### 二値変数：無相関なら独立

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

二値をとる確率変数の組 $(X, Y)$について, $\rho(X, Y) = 0$ とします.
このとき, $X$と$Y$ は独立となる

</div>

**証明**

$(X, Y)$についての同時確率を表現すると

|$X$ \ $Y$|$y_1$|$y_2$|計|
|---|---|---|---|
|$x_0$|$p_1$|$q_1$|$p_1+q_1$|
|$x_1$|$p_2$|$q_2$|$p_2+q_2$|
|計|$p_1+p_2$|$q_1+q_2$|$1$|

$\rho(X, Y) = 0$より

$$
\begin{align*}
&Cov(X, Y) =0\\
&\Rightarrow \mathbb E[XY] -\mathbb E[X]\mathbb E[Y] = 0
\end{align*}
$$

これを同時確率表と照らし合わせて計算すると

$$
\begin{align*}
&Cov(X, Y) = (p_1q_2 - p_2q_1)(x_1 - x_0)(y_1 - y_0)\\[8pt]
&\Rightarrow (p_1q_2 - p_2q_1) = 0\\[8pt]
&\Rightarrow \frac{p_1}{q_1} = \frac{p_2}{q_2} = k
\end{align*}
$$

これを用いて同時確率表を修正すると

|$X$ \ $Y$|$y_1$|$y_2$|計|
|---|---|---|---|
|$x_0$|$kq_1$|$q_1$|$(1+k)q_1$|
|$x_1$|$kq_2$|$q_2$|$(1+k)q_2$|
|計|$k(q_1+q_2)$|$q_1+q_2$|$1$|

ここで, 

$$
(1+k)(q_1 + q_2) = 1
$$

に注意すると,

$$
\begin{align*}
(q_1 + q_2)\times (1+k)q_1 &= \frac{1}{1+k}(1+k)q_1 = q_1\\
(q_1 + q_2)\times (1+k)q_2 &= \frac{1}{1+k}(1+k)q_1 = q_2
\end{align*}
$$

より「同時確率 = 周辺確率の積」が成立しているので独立であることがわかる.

**証明終了**

---



## 正規分布に従う確率変数とsample mean residualの独立性

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

確率変数 $X_1, \cdots, X_n$ が互いに独立に $N(\mu, \sigma^2)$ に従うとする.
このとき, 総和 $Y_n = \sum X_i$ と $X_i - Y_n/n$ は独立である.

</div>

**証明**

正規分布では, 無相関と独立性が同値なので $Cov(Y_n, X_i - Y_n/n) = 0$ が示せれば良い.


$$
\begin{align*}
Cov\bigg(Y_n, X_i - \frac{Y_n}{n}\bigg) &= Cov\bigg(Y_n, X_i\bigg) - Cov\bigg(Y_n,\frac{Y_n}{n}\bigg)\\
                                        &= \mathbf V(X_i) - \frac{1}{n} \mathbf V(Y_n)\\
                                        &= \sigma^2 - n\sigma^2/n\\
                                        &= 0
\end{align*}
$$


**証明終了**

---


## Resources

> 統計検定

- [統計検定1級 > 2013年11月数理統計問2](https://www.toukei-kentei.jp/prepare/kakomon/#grade1)