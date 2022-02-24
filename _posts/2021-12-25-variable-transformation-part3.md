---
layout: post
title: "一様分布の変数変換"
subtitle: "数理統計：変数変換 3/n"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- 統計検定
- 統計
- Python
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題：一様分布の変数変換](#%E5%95%8F%E9%A1%8C%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AE%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B)
  - [(1) $Z= X + Y$の確率密度関数](#1-z-x--y%E3%81%AE%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0)
  - [(2) $W = XY$の確率密度関数](#2-w--xy%E3%81%AE%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0)
- [2. 円周上で一様分布する点の此の距離：統計検定１級2013年11月](#2-%E5%86%86%E5%91%A8%E4%B8%8A%E3%81%A7%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%99%E3%82%8B%E7%82%B9%E3%81%AE%E6%AD%A4%E3%81%AE%E8%B7%9D%E9%9B%A2%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%EF%BC%91%E7%B4%9A2013%E5%B9%B411%E6%9C%88)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題：一様分布の変数変換

確率変数 $X, Y$が独立に $\text{Unif}(0, 1)$に従っているとき、$Z= X + Y$, $W = XY$の確率密度関数を求めよ

### (1) $Z= X + Y$の確率密度関数

$Z$のpdfは

$$
f_Z(z) = \int^1_0f_X(z-t)f_Y(t)dt
$$

となります. $0<z-t<1$, $0<t<1$より$z\in (0, 1)$のときは$t$の積分範囲は$(0, z)$. また$z\in (1, 2)$のときは積分範囲が$(z-1, 1)$になることに留意すると

$$
f_Z(z) = \begin{cases}\int^z_0 dt = z & \  \ z\in (0, 1) \\ 
\int^1_{z-1} dt = 2-z & \  \ z\in (1, 2) 
\end{cases}
$$

> 直感的なイメージ

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2021-12-25-uniformditribution-01.png?raw=true">

$Z$の値によって積分範囲がかわるイメージはこの図を参照することでわかります. $Z$のCDFは$X, Y \in [0, 1]$で画定された四角形のうち$X + Y$の等高線を引き、その線分と原点から伸びる$X, Y$方面それぞれの線分で囲まれた領域となります. pdfはその面積の増分、つまり等高線の赤線部分となるので、$Z = 1$を境界に変わることがわかります. 


### (2) $W = XY$の確率密度関数

$$
\begin{align*}
W & = XY\\
U & = X
\end{align*}
$$

と変数変換すると$J((w, u)\to (x, y)) = 1/u$となります. 従って、

$$
f_{W, U}(w, u) = u^{-1}I(u \in (0, 1))I(w/u \in (0, 1))
$$

これを$u\in(0,1)$範囲で積分すると

$$
\begin{align*}
f(w) &= \int^1_0 u^{-1}I(u \in (0, 1))I(w/u \in (0, 1)) du\\
&= \int^1_0 u^{-1}I(w/u \in (0, 1)) du\\
&= \int^1_0 u^{-1}I(w<u) du\\
&= \int^1_w u^{-1} du\\
&= -\log w
\end{align*}
$$

> Pythonでplot

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

## SEED
np.random.seed(42)

## Params
N = 10000             #sample size
A, B = 0, 1          # uniform distribution param

## generate random variables
X = np.random.uniform(A, B, N)
Y = np.random.uniform(A, B, N)
W = X*Y

## plot parameter
bin_range = np.linspace(A, B, 100)

fig, ax = plt.subplots(1, 1,figsize=(10, 7))
ax.hist(W, density = True, alpha = 0.5, bins = bin_range, label = 'uniform variable ratio')
ax.plot(bin_range[1:], -np.log(bin_range[1:]), label = 'plot $-\log(w)$')
ax.legend();
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211225-python-plot.png?raw=true">

## 2. 円周上で一様分布する点の此の距離：統計検定１級2013年11月

周の長さ1の円の円周上に１点Aを固定し、次に、同じ円周上で一様分布するように別の点Bをとる. その二点で区切られてできる２つの弧ABのうち短い方の長さをX, 長い方の長さをYとする.

1. $X$及び$Y$の期待値と標準偏差を求めよ. また、$X, Y$の相関係数も求めよ
2. $W=X/Y$の累積分布関数と確率密度関数を求めよ
3. $W$の期待値と中央値を求めよ

> (1) $X$及び$Y$の期待値と分散を求めよ. また、$X, Y$の相関係数も求めよ


$X$は区間$(0, 0.5)$の一様分布に従い、$Y = 1 - X$より$Y$は区間$(0.5, 1)$の一様分布に従う. 従って、

$$
\begin{align*}
E[X] &= \frac{0 + 0.5}{2} = 0.25\\
V(X) &= \frac{(0.5 - 0)^2}{12} = \frac{1}{48}\\
E[Y] &= \frac{0.5 + 1}{2} = 0.75\\
V(Y) &= \frac{(1 - 0.5)^2}{12} = \frac{1}{48}\\
Corr(X, Y) &= \frac{cov(X, Y)}{\sqrt{V(X)V(Y)}} = -1
\end{align*}
$$

> (2) $W=X/Y$の累積分布関数と確率密度関数を求めよ

$X$のCDFは$x\in (0, 0.5)$の範囲で$F(x) = 2x$なので、$W = X/Y$は$w\in (0, 1)$の範囲で

$$
\begin{align*}
F(w) &= F\left(\frac{X}{1-X}\leq w\right)\\
&= F\left(X\leq\frac{w}{1+w}\right)\\
&= 2 - \frac{2}{1+w}
\end{align*}
$$

確率密度関数は、CDFを$w$で微分すれば良いので

$$
f(w) = \frac{2}{(1 + w)^2}
$$

> (3) $W$の期待値と中央値を求めよ

$$
\begin{align*}
\mathrm E[W] &= \int^1_0\frac{2}{(1 + w)^2}wdw\\
&= \int^1_0\frac{2(1 + w) - 2}{(1 + w)^2}dw\\
&= \int^1_0\frac{2}{(1+w)}dw - \int^1_0\frac{2}{(1+w)^2}dw\\
&= [2\log(1+w)]^1_0 + \left[\frac{2}{1+w}\right]^1_0\\
&= 2\log 2 - 1
\end{align*}
$$

中央値は

$$
\begin{align*}
&2 - \frac{2}{1+\tilde w} = 0.5\\
&\Rightarrow \tilde w = \frac{1}{3}
\end{align*}
$$
