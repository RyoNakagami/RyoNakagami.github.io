---
layout: post
title: "三角関数系の直交性"
subtitle: "フーリエ解析 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-01-24
tags:

- math
- フーリエ解析
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [周期関数の直交性の定義](#%E5%91%A8%E6%9C%9F%E9%96%A2%E6%95%B0%E3%81%AE%E7%9B%B4%E4%BA%A4%E6%80%A7%E3%81%AE%E5%AE%9A%E7%BE%A9)
- [三角関数の直交性の性質](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%AE%E7%9B%B4%E4%BA%A4%E6%80%A7%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [自分と異なる三角関数系の関数との内積が 0](#%E8%87%AA%E5%88%86%E3%81%A8%E7%95%B0%E3%81%AA%E3%82%8B%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E7%B3%BB%E3%81%AE%E9%96%A2%E6%95%B0%E3%81%A8%E3%81%AE%E5%86%85%E7%A9%8D%E3%81%8C-0)
  - [自分自身との内積](#%E8%87%AA%E5%88%86%E8%87%AA%E8%BA%AB%E3%81%A8%E3%81%AE%E5%86%85%E7%A9%8D)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 周期関数の直交性の定義

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

関数 $f(x), g(x)$を周期 $2\pi$ の周期関数とします. 関数 $f$ と $g$ が直交するとは

$$
\int^{2\pi}_0 f(x)g(x)dx = 0 \tag{1.1}
$$

が成立することである. (1.1)を関数 $f$ と $g$の内積とも言う.
</div>

## 三角関数の直交性の性質
### 自分と異なる三角関数系の関数との内積が 0

> パターン 1

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">


任意の $m = 1, 2, \cdots$ と $n = 1, 2, \cdots$ について

$$
\int^{2\pi}_0\cos mx \sin nx dx =0 \tag{1.2}
$$

</div>

**証明**

$$
\begin{align*}
\int^{2\pi}_0\cos mx \sin nx dx &= \frac{1}{2}\int^{2\pi}_0 \{\sin(m+n)x - \sin(m-n)x \}dx\\
                                &= 0
\end{align*}
$$

**証明終了**

---


> パターン 2

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">


$m \neq n$ となる任意の $m = 1, 2, \cdots$ と $n = 1, 2, \cdots$ について

$$
\int^{2\pi}_0\cos mx \cos nx dx =0 \tag{1.3}
$$

</div>

**証明**

$$
\begin{align*}
\int^{2\pi}_0\cos mx \cos nx dx &= \frac{1}{2}\int^{2\pi}_0 \{\cos(m+n)x + \cos(m-n)x \}dx\\
                                &= 0
\end{align*}
$$


**証明終了**

---


> パターン 3

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">


$m \neq n$ となる任意の $m = 1, 2, \cdots$ と $n = 1, 2, \cdots$ について

$$
\int^{2\pi}_0\sin mx \sin nx dx =0 \tag{1.4}
$$

</div>

**証明**

$$
\begin{align*}
\int^{2\pi}_0\sin mx \sin nx dx &= -\frac{1}{2}\int^{2\pi}_0 \{\cos(m+n)x - \cos(m-n)x \}dx\\
                                &= 0
\end{align*}
$$


**証明終了**

---


### 自分自身との内積

> 正弦関数

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">


任意の $m = 1, 2, \cdots$ について

$$
\int^{2\pi}_0\sin^2 mx dx = \pi \tag{1.5}
$$

</div>

**証明**

$$
\begin{align*}
\int^{2\pi}_0\sin^2 mx dx &= -\frac{1}{2}\int^{2\pi}_0 \{\cos(2m)x - 1 \}dx\\
                          &= \pi
\end{align*}
$$


**証明終了**

---

> 余弦関数

<div class="math display" style="overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">


任意の $m = 1, 2, \cdots$ について

$$
\int^{2\pi}_0\cos^2 mx dx =0 \tag{1.6}
$$

</div>

**証明**


$$
\begin{align*}
\int^{2\pi}_0\cos^2 mx dx &= \frac{1}{2}\int^{2\pi}_0 \{\cos(2m)x + 1 \}dx\\
                          &= \pi
\end{align*}
$$


**証明終了**

---