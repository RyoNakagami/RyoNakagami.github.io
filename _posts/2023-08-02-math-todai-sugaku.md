---
layout: post
title: "東大数学解説: 三角関数の微分と積分"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-08-13
tags:

- math
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [sec関数の積分](#sec%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D%E5%88%86)
- [東大理系数学2022第一問](#%E6%9D%B1%E5%A4%A7%E7%90%86%E7%B3%BB%E6%95%B0%E5%AD%A62022%E7%AC%AC%E4%B8%80%E5%95%8F)
  - [(1) 解答](#1-%E8%A7%A3%E7%AD%94)
  - [(2) 解答](#2-%E8%A7%A3%E7%AD%94)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## sec関数の積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: セカント</ins></p>

$$
\sec x=\frac{1}{\cos x}
$$

</div>

sec関数の不定積分は $\sin x = t$と置換積分をもちいると簡単にできます.

$$
\begin{align*}
\int \frac{1}{\cos x} dx &= \int \frac{\cos x}{\cos^2 x} dx\\
                         &= \int \frac{\cos x}{1 - \sin^2 x} dx
\end{align*}
$$

このとき

$$
\frac{dt}{dx} = \frac{\sin x}{dx} = \cos x
$$

なので

$$
\begin{align*}
\int \frac{1}{\cos x} dx &=  \int \frac{1}{1 - t^2} dt\\
                         &= \int \frac{1}{(1 - t)(1 + t)} dt\\
                         &= \frac{1}{2}\int\left(\frac{1}{(1 - t)} + \frac{1}{(1 + t)}\right) dt\\
                         &= \frac{1}{2}\left[-\log(|1 - t|) + \log(|1 + t|)\right] + C\\
                         &= \frac{1}{2}\log\left(\frac{1 + \sin x}{1 - \sin x}\right) + C
\end{align*}
$$

## 東大理系数学2022第一問

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

次の関数 $f(x)$ を考える

$$
f(x) = (\cos x)\log (\cos x) - \cos x + \int^x_0 (\cos t) \log(\cos t)dt \  \, s.t. \  \ x\in [0, \frac{\pi}{2})
$$

- (1): $f'(x)$ を求めよ
- (2): $ x\in [0, \frac{\pi}{2})$区間内での $f(x)$の最小値を求めよ

</div>

### (1) 解答

$$
\begin{align*}
f'(x) &= -(\sin x )\log (\cos x) - \cos x \frac{\sin x}{\cos x} + \sin x + \cos x \log(\cos x)\\
      &= (\cos x - \sin x)\log (\cos x)\\
      &= -\sqrt{2}\sin\left(x - \frac{\pi}{4}\right)\log (\cos x)
\end{align*}
$$

### (2) 解答

区間内で$\log (\cos x) \leq 0$であることに注意すると, 

---|---|---|---|---
$x$|0 | - | $\pi/4$ | -
$f'(x)$|0| negative | 0 | positive

なので, 区間内で$x = \pi/4$のとき最小値を取る. このとき, 

$$
\begin{align*}
\int^{\pi/4}_0 (\cos x) \log(\cos x)dx &= [(\sin x)\log (\cos x)]^{\pi/4}_0 + \int^{\pi/4}_0 \sin x \frac{\sin x}{\cos x} dx\\
&= \frac{1}{\sqrt{2}} \log \frac{1}{\sqrt{2}} + \left[\frac{1}{2}\log\left(\frac{1 + \sin x}{1 - \sin x}\right) + \sin x\right]^{\pi/4}_0\\[8pt]
&= \frac{1}{\sqrt{2}}\left( \log \frac{1}{\sqrt{2}} - 1\right) + \log(\sqrt{2}+1)
\end{align*}
$$

したがって, 

$$
f\left(\frac{\pi}{4}\right) = \log(\sqrt{2} + 1) - \sqrt{2}(\log(\sqrt{2})+1)
$$






References
-----

- [高校数学の美しい物語 > 三角関数sec, cosec, cotと記号の意味 ](https://manabitimes.jp/math/818)
- [Wolframengineを用いて解いてみた場合](https://github.com/RyoNakagami/wolframengine_example/blob/main/note/math/integrate_sec.ipynb)
