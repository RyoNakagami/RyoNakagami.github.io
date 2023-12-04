---
layout: post
title: "ガンマ関数の性質"
subtitle: "統計のための数学 3/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-12-04
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

- [ガンマ関数の性質](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [ガンマ関数と階乗の一般化](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%A8%E9%9A%8E%E4%B9%97%E3%81%AE%E4%B8%80%E8%88%AC%E5%8C%96)
  - [1/2でのガンマ関数と円周率](#12%E3%81%A7%E3%81%AE%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%A8%E5%86%86%E5%91%A8%E7%8E%87)
  - [ガンマ関数の変形](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E5%A4%89%E5%BD%A2)
- [数理統計におけるガンマ関数](#%E6%95%B0%E7%90%86%E7%B5%B1%E8%A8%88%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0)
  - [標準正規分布の4次モーメント](#%E6%A8%99%E6%BA%96%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AE4%E6%AC%A1%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## ガンマ関数の性質

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ガンマ関数</ins></p>

正の実数 $x$に対して

$$
\Gamma(x) = \int^\infty_0t^{x-1}\exp(-t)dt
$$

をガンマ関数と呼ぶ.

</div>


ガンマ関数は

$$
\begin{align*}
\Gamma(1) &= 1\\
\Gamma(2) &= 1\\
\Gamma(x+1) &= x\Gamma(x)\\[3pt]
\Gamma\bigg(\frac{1}{2}\bigg) &= \sqrt{\pi}
\end{align*}
$$

という便利かつ有名な性質があります.

### ガンマ関数と階乗の一般化

ガンマ関数の定義から$\Gamma(1) = 1$は自明ですが, $\Gamma(x+1) = x\Gamma(x)$が成立すると,
$\Gamma(x) = (x-1)!$が成立することがわかります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property</ins></p>

任意の正の実数 $x$ について

$$
\Gamma(x+1) = x\Gamma(x)
$$

</div>

証明は部分積分を用います.

$$
\begin{align*}
\Gamma(x+1) &= \int^\infty_0t^{x}\exp(-t)dt\\[3pt]
            &= [t^{x}(-\exp(-t))]^\infty_0 + \int^\infty_0xt^{x-1}\exp(-t)dt\\[3pt]
            &= x\int^\infty_0t^{x-1}\exp(-t)dt\\[3pt]
            &= x\Gamma(x)
\end{align*}
$$

これで題意が示せた.


### 1/2でのガンマ関数と円周率

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property </ins></p>

$$
\Gamma\bigg(\frac{1}{2}\bigg) = \sqrt{\pi}
$$

</div>

この証明は複数あります. 

> パターン1: ガウス積分で証明する方法


$$
\begin{align*}
\Gamma\bigg(\frac{1}{2}\bigg) = \int^\infty_0t^{-1/2}\exp(-t)dt
\end{align*}
$$

ここで, $t = u^2$と置換積分すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int^\infty_0t^{-1/2}\exp(-t)dt &= \int^\infty_0u^{-1}\exp(-u^2)2udu\\[3pt]
                                &= 2\int^\infty_0\exp(-u^2)du\\[3pt]
                                &= \int^\infty_{-\infty}\exp(-u^2)du\\[3pt]
                                &= \int^\infty_{-\infty}\exp\bigg(-\frac{u^2}{2\times(\frac{1}{\sqrt 2})^2}\bigg)du\\[3pt]
                                &= \sqrt{2\pi}\frac{1}{\sqrt 2}\\
                                &= \sqrt{\pi}
\end{align*}
$$
</div>

> パターン2: 座標変換で証明

$$
\begin{align*}
\Gamma\bigg(\frac{1}{2}\bigg)^2 &= \bigg(\int^\infty_0t^{-1/2}\exp(-t)dt\bigg)^2\\[3pt]
                                &= \int^\infty_0x^{-1/2}\exp(-x)dx\int^\infty_0y^{-1/2}\exp(-y)dy
\end{align*}
$$

ここで, $x = u^2, y = v^2$と置換積分すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int^\infty_0x^{-1/2}\exp(-x)dx\int^\infty_0y^{-1/2}\exp(-y)dy &= 4\int^\infty_0\exp(-u^2)du\int^\infty_0\exp(-v^2)dv\\
&= 4\int^\infty_0\int^\infty_0\exp[-(u^2+v^2)]dudv
\end{align*}
$$
</div>

ここで, $u = r\cos\theta, v=r\sin\theta$と置換するとヤコビアンは$r$であり, また$u, v\geq 0$であることに留意すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
4\int^\infty_0\int^\infty_0\exp[-(u^2+v^2)]dudv &= 4\int^\infty_0\int^{\pi/2}_0\exp[-r^2]r d\theta dr \  \  \because u, v\geq 0 \\[3pt]
&= 4\times \frac{\pi}{2} \int^{\infty}_0\exp[-r^2]rdr\\[3pt]
&= 4\times \frac{\pi}{2}\bigg[\frac{\exp(-r^2)}{-2}\bigg]^\infty_0\\[3pt]
&= \pi
\end{align*}
$$
</div>

$\Gamma(1/2)>0$より, 

$$
\begin{align*}
&\Gamma\bigg(\frac{1}{2}\bigg)^2 = \pi\\
&\Rightarrow \Gamma\bigg(\frac{1}{2}\bigg) = \sqrt{\pi}
\end{align*}
$$



### ガンマ関数の変形

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property</ins></p>

ガンマ関数について以下の性質が知られている

$$
\Gamma(s) = 2\int_0^\infty t^{2s-1}\exp(-t^2)dt
$$

</div>

この性質は, ガンマ関数の積を考え極座標変換する際に用いたりします. 証明は置換積分法を用いて以下のように示せます.

$$
2\int_0^\infty t^{2s-1}\exp(-t^2)dt
$$

について $t^2 = u$という変換を行います. つまり

<div class="math display" style="overflow: auto">
$$
\begin{align*}
2\int_0^\infty t^{2s-1}\exp(-t^2)dt &= 2\int_0^\infty u^{s-1/2}\exp(-u)\frac{1}{2u^{1/2}}du\\[3pt]
          &= \int_0^\infty u^{s-1}\exp(-u)du\\
          &= \Gamma(s)
\end{align*}
$$
</div>

証明完了.

## 数理統計におけるガンマ関数
### 標準正規分布の4次モーメント

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>標準正規分布の4次モーメント</ins></p>

$X \sim N(0, 1)$とするとき, $\mathbb E[X^4]$を求めよ

</div>

$X$は標準正規分布に従うので

$$
\begin{align*}
\mathbb E[X^4] = \frac{1}{\sqrt{2\pi}}\int^\infty_{-\infty}x^4\exp\bigg(-\frac{x^2}{2}\bigg)dx
\end{align*}
$$

ここで, $x^2/2=u$とおくと

<div class="math display" style="overflowmath.gamma: auto">
$$
\begin{align*}
du &= xdx\\
x &= \sqrt{2u}\\
\mathbb E[X^4] &= \frac{2}{\sqrt{2\pi}}\int^\infty_{0}x^4\exp\bigg(-\frac{x^2}{2}\bigg)dx\\[3pt]
               &= \frac{2}{\sqrt{2\pi}}\int^\infty_{0} 4u^2\exp(-u)\frac{1}{\sqrt{2u}}du\\[3pt]
               &= \frac{4}{\sqrt{\pi}}\int^\infty_{0}u^{\frac{5}{2}-1}\exp(-u)du\\[3pt]
               &= \frac{4}{\sqrt{\pi}}\Gamma\bigg(\frac{5}{2}\bigg)
\end{align*}
$$
</div>

ここで, $\Gamma(x+1) = x\Gamma(x)$であるので

$$
\begin{align*}
\Gamma\bigg(\frac{1}{2}\bigg) &= \sqrt{\pi}\\[3pt]
\Gamma\bigg(\frac{5}{2}\bigg) &= \frac{3}{2}\frac{1}{2}\Gamma\bigg(\frac{1}{2}\bigg)
\end{align*}
$$

従って, 

$$
\begin{align*}
\mathbb E[X^4] &= \frac{4}{\sqrt{\pi}}\times\frac{3}{4}\times\sqrt{\pi}\\[3pt]
               &= 3
\end{align*}
$$








References
------------
- [とある数物研究者の覚書 > ガンマ関数](https://mathphysnote.com/math2/gammafn/#google_vignette)