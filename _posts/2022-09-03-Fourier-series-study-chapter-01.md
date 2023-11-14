---
layout: post
title: "フーリエ級数展開"
subtitle: "フーリエ解析 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-01-24
tags:

- math
- フーリエ解析
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [フーリエ級数展開とは](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E7%B4%9A%E6%95%B0%E5%B1%95%E9%96%8B%E3%81%A8%E3%81%AF)
  - [周期関数](#%E5%91%A8%E6%9C%9F%E9%96%A2%E6%95%B0)
  - [周期 $T$ の周期関数の線型結合](#%E5%91%A8%E6%9C%9F-t-%E3%81%AE%E5%91%A8%E6%9C%9F%E9%96%A2%E6%95%B0%E3%81%AE%E7%B7%9A%E5%9E%8B%E7%B5%90%E5%90%88)
  - [異なる周期の周期関数の線型結合](#%E7%95%B0%E3%81%AA%E3%82%8B%E5%91%A8%E6%9C%9F%E3%81%AE%E5%91%A8%E6%9C%9F%E9%96%A2%E6%95%B0%E3%81%AE%E7%B7%9A%E5%9E%8B%E7%B5%90%E5%90%88)
  - [周期 $T$ の周期関数の積](#%E5%91%A8%E6%9C%9F-t-%E3%81%AE%E5%91%A8%E6%9C%9F%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D)
- [フーリエ係数の公式の導出](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E4%BF%82%E6%95%B0%E3%81%AE%E5%85%AC%E5%BC%8F%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [仮定](#%E4%BB%AE%E5%AE%9A)
  - [導出](#%E5%B0%8E%E5%87%BA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## フーリエ級数展開とは

- フーリエ級数展開とは, 任意の関数を三角関数の和 $\sin nT, \cos nT (n = 0, 1,2, \cdots)$ で表すこと

> 例: 周期 $2\pi$ の周期関数の$f(x)$のフーリエ級数展開

$$
f(x) = \frac{a_0}{2} + \sum^{\infty}_{n=1} (a_n \cos nx + b_n \sin nx)
$$

このときのフーリエ係数は

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{2\pi}_0 f(x) \cos nx dx\\
b_n &= \frac{1}{\pi}\int^{2\pi}_0 f(x) \sin nx dx
\end{align*}
$$

### 周期関数

> 定義

関数 $f(x)$ が次の条件を満たす時, $f$ を周期関数(periodic function)と呼ぶ

$$
f(x + T) = f(x) \ \ (T > 0)
$$

また, $T$ をその周期という. 

---

### 周期 $T$ の周期関数の線型結合

2つの関数 $f, g$ が周期 $T$ の周期関数であれば, その線型結合も周期 $T$ の周期関数となる.

**証明**

$$
h(x) = \alpha f(x) + \beta g(x)
$$

としたとき, 

$$
\begin{align*}
h(x + T) &= \alpha f(x + T) + \beta g(x + T)\\
         &= \alpha f(x) + \beta g(x)\\
         &= h(x)
\end{align*}
$$

**(証明終了)**

---

### 異なる周期の周期関数の線型結合

$$
f(x) = \cos \frac{x}{2} + \cos\frac{x}{3}
$$

としたとき, $f(x)$の基本周期を求めたいとします.


**解答**

$\cos \frac{x}{2}$の基本周期は $4\pi$, $\cos \frac{x}{2}$の基本周期は $6\pi$. 
その最小公倍数 $12\pi$ が基本周期となります.

$$
\begin{align*}
f(x + 12\pi) =& \cos \frac{x + 12\pi}{2} + \cos\frac{x + 12\pi}{3} \\
             =& \cos \frac{x}{2}\cos 6\pi - \sin\frac{x}{2}\sin 6\pi + \cos \frac{x}{3}\cos 4\pi - \sin\frac{x}{3}\sin 4\pi \\
             =& \cos \frac{x}{2} + \cos\frac{x}{3}\\
             =& f(x)
\end{align*}
$$

**(終了)**

---

### 周期 $T$ の周期関数の積

2つの関数 $f, g$ が周期 $T$ の周期関数であれば, それらの積で定義される関数も周期 $T$ の周期関数となる.

**証明**

$$
h(x) = f(x)g(x)
$$

と定義する.

$$
\begin{align*}
h(x + T) &= f(x + T)g(x + T)\\
         &= f(x)g(x)\\
         &= h(x)
\end{align*}
$$

**(証明終了)**

---

## フーリエ係数の公式の導出

### 仮定

> 仮定 1: 関数がフーリエ級数展開可能

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

関数 $f(x)$ が以下のようにフーリエ級数展開できるとする

$$
f(x) = \frac{a_0}{2} + \sum^{\infty}_{n=1} (a_n \cos nx + b_n \sin nx)
$$

</div>

> 仮定 2: 積分と無限和の順序交換性


<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

例として, 以下の積分と無限和の順序交換性が成立するとする

$$
\begin{align*}
\int^{2\pi}_0 f(x) \cos mx dx =& \int^{2\pi}_0 \frac{a_0}{2} \cos mx dx\\
                               &+ \sum_{n=1}^\infty \int^{2\pi}_0 (a_n \cos nx \cos mx + b_n \sin nx \cos mx) dx
\end{align*}
$$
</div>


### 導出

[三角関数系の直交性](https://ryonakagami.github.io/2022/09/02/trigonometric-function-orthogonality/)より以下の等式が成り立つ:

$$
\begin{align*}
a_m &= \frac{1}{\pi} \int^{2\pi}_0 f(x) \cos mx dx \\
b_m &= \frac{1}{\pi} \int^{2\pi}_0 f(x) \sin mx dx 
\end{align*}
$$

**導出終了**

なお, 三角関数の周期性より以下のように表現することも可能.

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

$c$ を任意の定数としたとき, 

$$
\begin{align*}
a_m &= \frac{1}{\pi} \int^{c + 2\pi}_c f(x) \cos mx dx \\
b_m &= \frac{1}{\pi} \int^{c + 2\pi}_c f(x) \sin mx dx 
\end{align*}
$$

</div>



## References

> 関連ポスト

- [Ryo's Tech Blog > 正弦関数の積の積分公式](https://ryonakagami.github.io/2022/09/01/integrals-of-trigonometric-functions/#appendix-%E7%A9%8D%E5%92%8C%E5%85%AC%E5%BC%8F)
- [Ryo's Tech Blog > 三角関数系の直交性](https://ryonakagami.github.io/2022/09/02/trigonometric-function-orthogonality/)