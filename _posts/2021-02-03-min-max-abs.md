---
layout: post
title: "min, max関数を絶対値を用いて表現する"
subtitle: "確率と数学ドリル 9/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-30
header-mask: 0.0
header-style: text
tags:

- math
- 統計

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [平均と絶対値を用いたmax, minの表現](#%E5%B9%B3%E5%9D%87%E3%81%A8%E7%B5%B6%E5%AF%BE%E5%80%A4%E3%82%92%E7%94%A8%E3%81%84%E3%81%9Fmax-min%E3%81%AE%E8%A1%A8%E7%8F%BE)
  - [三角不等式とmin,max](#%E4%B8%89%E8%A7%92%E4%B8%8D%E7%AD%89%E5%BC%8F%E3%81%A8minmax)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 平均と絶対値を用いたmax, minの表現

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>min, max, abs</ins></p>

$x, y\in \mathbb R$としたとき, この２つの数の最大値と最小値は絶対値を用いて以下のように書き換えられる

$$
\begin{align*}
\max\{x, y\} &= \frac{x + y + |x - y|}{2}\\[3pt]
\min\{x, y\} &= \frac{x + y - |x - y|}{2}
\end{align*}
$$

</div>


まず$\max$に関して示します.

$x\geq y$ のとき

$$
\begin{align*}
 \frac{x + y + |x - y|}{2} &= \frac{x + y + x - y}{2}\\[3pt]
                           &= x\\
                           &= \max\{x,y\} 
\end{align*}
$$

となり題意は成り立つ.

$y > x$のときも

$$
\frac{x + y + |x - y|}{2} =  \frac{x + y + |y - x|}{2}
$$

であるので, $x\geq y$ のときと同様の理由で題意は成り立つ. 

$\min$に関しても同様に

$$
\frac{x + y - |x - y|}{2} = \frac{x + y - |y - x|}{2}
$$

なので, $x\geq y$ のとき題意が成り立つとき示せれば十分.

$$
\begin{align*}
 \frac{x + y - |x - y|}{2} &= \frac{x + y - (x - y)}{2}\\[3pt]
                           &= y\\
                           &= \min\{x,y\} 
\end{align*}
$$

従って, $\min$についても題意が成り立つことが証明された.

> REMARKS

- 実数値関数 $f(x), g(x)$ が連続であるとき, $x$ を $\max⁡\{f(x),g(x)\}$や$\min\{f(x),g(x)\}$に対応させる関数も連続であることを証明する際に用いられます

### 三角不等式とmin,max

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>problem</ins></p>

任意の$a,b,c,d \in \mathbb R$について

$$
\begin{align*}
\max\{a+b, c+d\} & \leq \max\{a, c\} + \max\{b, d\} \\[3pt]
\min\{a+b, c+d\} & \geq \min\{a, c\} + \min\{b, d\} \\[3pt]
\end{align*}
$$

が成立することを示せ

</div>

三角不等式 $\vert x + y\vert\leq \vert x\vert + \vert y \vert$を利用して示すことができます.

$$
\begin{align*}
\max\{a+b, c+d\} &= \frac{a+b+c+d+|(a+b) - (c+d)|}{2}\\[3pt]
                 &= \frac{a+b+c+d+|(a-c) + (b-d)|}{2}\\[3pt]
                 &\leq \frac{a+b+c+d+|(a-c)| + |(b-d)|}{2} \  \ \because \ \ \text{ 三角不等式}\\[3pt]
                 &= \frac{a+c + |a-c|}{2} + \frac{b+d+|b-d|}{2}\\[3pt]
                 &= \max\{a, c\} + \max\{b, d\} 
\end{align*}
$$

$\min$に関しても同様に

$$
\begin{align*}
\min\{a+b, c+d\} &= \frac{a+b+c+d-|(a+b) - (c+d)|}{2}\\[3pt]
                 &= \frac{a+b+c+d-|(a-c) + (b-d)|}{2}\\[3pt]
                 &\geq \frac{a+b+c+d - |(a-c)| - |(b-d)|}{2} \  \ \because \ \ \text{ 三角不等式}\\[3pt]
                 &= \frac{a+c - |a-c|}{2} + \frac{b+d-|b-d|}{2}\\[3pt]
                 &= \min\{a, c\} + \min\{b, d\} 
\end{align*}
$$
