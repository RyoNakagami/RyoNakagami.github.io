---
layout: post
title: "正弦関数の積の積分公式"
subtitle: "フーリエ解析 1/N"
author: "Ryo"
header-img: "img/post-bg-miui6.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-07-11
tags:

- math
- フーリエ解析
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [正弦関数の積の積分公式](#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D%E3%81%AE%E7%A9%8D%E5%88%86%E5%85%AC%E5%BC%8F)
  - [正弦関数の積和公式](#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D%E5%92%8C%E5%85%AC%E5%BC%8F)
  - [正弦関数の積の積分公式の導出](#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D%E3%81%AE%E7%A9%8D%E5%88%86%E5%85%AC%E5%BC%8F%E3%81%AE%E5%B0%8E%E5%87%BA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 正弦関数の積の積分公式

$n,k$をそれぞれ自然数としたとき

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int^{\pi}_0\sin nx \sin kx dx =\begin{cases}
0 & (k\neq n)\\[4pt]
\frac{\pi}{2} & (k = n)
\end{cases}\tag{A}
\end{align*}
$$
</div>


### 正弦関数の積和公式

$$
\sin \alpha\sin \beta=-\frac{1}{2} \left\{\cos(\alpha+\beta)-\cos(\alpha-\beta)\right\} \tag{B}
$$

> 導出

余弦関数の加法定理より

$$
\begin{align*}
\cos(\alpha + \beta) &= \cos\alpha\cos\beta - \sin\alpha\sin\beta \tag{C}\\[4pt]
\cos(\alpha - \beta) &= \cos\alpha\cos\beta + \sin\alpha\sin\beta\tag{D}
\end{align*}
$$

$(C) - (D)$より

$$
\cos(\alpha + \beta) - \cos(\alpha - \beta) = -2\sin\alpha\sin\beta
$$

従って,

$$
\sin \alpha\sin \beta=-\frac{1}{2} \left\{\cos(\alpha+\beta)-\cos(\alpha-\beta)\right\}
$$

### 正弦関数の積の積分公式の導出

正弦関数の積和公式, $(B)$, を用いて $(A)$を変形すると

$$
\begin{align*}
\int^{\pi}_0\sin nx \sin kx dx &= -\frac{1}{2}\int^{\pi}_0 \left\{\cos(n+k)x-\cos(n-k)x\right\} dx \\
&= -\frac{1}{2}\left\{\int^{\pi}_0\cos(n+k)x dx- \int^{\pi}_0\cos(n-k)xdx\right\} \tag{E}
\end{align*}
$$

> $n = k$ の場合

$n=k$の場合, $(E)$の第二項は

$$
\int^{\pi}_0\cos 0 dx = \pi
$$

$(E)$の第一項は

$$
\begin{align*}
\int^{\pi}_0\cos(n+k)x dx &= -\left[\sin(n+k)x\right]^{\pi}_0\\
&= 0 \tag{F}
\end{align*}
$$

従って,

$$
\int^{\pi}_0\sin nx \sin kx dx = \frac{\pi}{2}
$$


> $n \neq k$ の場合

$$
-\left[\sin(n-k)x\right]^{\pi}_0
$$

は自明. 従って

$$
\int^{\pi}_0\sin nx \sin kx dx = 0
$$


## References

- [「集合と位相」をなぜ学ぶのか―数学の基礎として根づくまでの歴史](https://gihyo.jp/book/2018/978-4-7741-9612-1)