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

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題：一様分布の変数変換

確率変数 $X, Y$が独立に $Unif(0, 1)$に従っているとき、$Z= X + Y$, $W = XY$の確率密度関数を求めよ

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
