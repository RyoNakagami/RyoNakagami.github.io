---
layout: post
title: "ガンマ関数の性質"
subtitle: "統計のための数学 3/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-18
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

- [ガンマ関数の定義](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E5%AE%9A%E7%BE%A9)
- [ガンマ関数の性質](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [ガンマ関数と階乗の一般化](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%A8%E9%9A%8E%E4%B9%97%E3%81%AE%E4%B8%80%E8%88%AC%E5%8C%96)
  - [1/2でのガンマ関数と円周率](#12%E3%81%A7%E3%81%AE%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%A8%E5%86%86%E5%91%A8%E7%8E%87)
  - [ガンマ関数の変形](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E5%A4%89%E5%BD%A2)
  - [例題](#%E4%BE%8B%E9%A1%8C)
- [数理統計におけるガンマ関数](#%E6%95%B0%E7%90%86%E7%B5%B1%E8%A8%88%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0)
  - [標準正規分布の4次モーメント](#%E6%A8%99%E6%BA%96%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AE4%E6%AC%A1%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88)
- [Appendix: ロピタルの定理](#appendix-%E3%83%AD%E3%83%94%E3%82%BF%E3%83%AB%E3%81%AE%E5%AE%9A%E7%90%86)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## ガンマ関数の定義

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ガンマ関数</ins></p>

正の実数 $x$に対して

$$
\Gamma(x) = \int^\infty_0t^{x-1}\exp(-t)dt
$$

をガンマ関数と呼ぶ.

</div>

上記のガンマ関数の定義から以下の関係式がそのまま出てきます

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

$a > 0$という定数をについて

$$
\int^\infty_0t^{x-1}\exp(-at)dt = \frac{\Gamma(x)}{a^x}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$t=as \ \ (a > 0)$と変換すると

$$
\begin{align*}
s &= \frac{t}{a}\\[3pt]
s&: 0\to\infty \text{ when } \ \ t: 0\to\infty\\[3pt]
dt &= ads 
\end{align*}
$$

なので

$$
\begin{align*}
\Gamma(x) &= \int^\infty_0t^{x-1}\exp(-t)dt\\[3pt]
          &= \int^\infty_0(as)^{x-1}\exp(-as)ads\\[3pt]
          &= a^x \int^\infty_0s^{x-1}\exp(-as)ds
\end{align*}
$$

従って, 


$$
\int^\infty_0t^{x-1}\exp(-at)dt = \frac{\Gamma(x)}{a^x}
$$

</div>




## ガンマ関数の性質

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>ガンマ関数の性質</ins></p>

ガンマ関数には以下の有名な性質があります:

$$
\begin{align*}
\Gamma(1) &= 1\\[3pt]
\Gamma(2) &= 1\\[3pt]
\Gamma(x+1) &= x\Gamma(x)\\[3pt]
\Gamma(n) &= (n-1)! \ \ \text{ where } n \in \mathbb N \\[3pt]
\Gamma\bigg(\frac{1}{2}\bigg) &= \sqrt{\pi}
\end{align*}
$$

</div>

$\Gamma(1) = 1$は直接積分を計算するだけで導出できます

$$
\begin{align*}
\Gamma(1) &= \int_0^\infty t^0\exp(-t)dt\\[3pt]
          &= [-\exp(-t)]_0^\infty\\[3pt]
          &= 1
\end{align*}
$$




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

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\Gamma(x+1) &= \int^\infty_0t^{x}\exp(-t)dt\\[3pt]
            &= [t^{x}(-\exp(-t))]^\infty_0 + \int^\infty_0xt^{x-1}\exp(-t)dt\\[3pt]
            &= x\int^\infty_0t^{x-1}\exp(-t)dt \ \ \because\text{ロピタルの定理}\\[3pt]
            &= x\Gamma(x)
\end{align*}
$$


</div>

### 1/2でのガンマ関数と円周率

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property </ins></p>

$$
\Gamma\bigg(\frac{1}{2}\bigg) = \sqrt{\pi}
$$

</div>

この証明は

- ガウス積分で証明する方法
- 座標変換で証明

があります.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明: ガウス積分で証明する方法</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">


$$
\begin{align*}
\Gamma\bigg(\frac{1}{2}\bigg) = \int^\infty_0t^{-1/2}\exp(-t)dt
\end{align*}
$$

ここで, $t = u^2$と変換すると $dt = 2udu$となるので




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


</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明: 座標変換で証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

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

</div>


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

### 例題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
\int^\infty_{-\infty}x^2\exp(-ax^2)dx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$x^2$は原点を中心に対称なので

$$
\int^\infty_{-\infty}x^2\exp(-ax^2)dx = 2\int^\infty_{0}x^2\exp(-ax^2)dx
$$

ここで$x^2=t$と変換すると

$$
\begin{align*}
x &= \sqrt{t}\\[3pt]
t&: 0\to\infty \text{ when } \ \ x: 0\to\infty\\[3pt]
dx&= \frac{1}{2}t^{-\frac{1}{2}}dt
\end{align*}
$$

従って,

$$
\begin{align*}
\int^\infty_{0}x^2\exp(-ax^2)dx 
      &= \int^\infty_{0}t\exp(-at)\frac{1}{2}t^{-1/2}dt\\[3pt]
      &= \frac{1}{2}\int^\infty_{0}t^{1/2}\exp(-at)dt\\[3pt]
      &= \frac{1}{2}\int^\infty_{0}t^{3/2-1}\exp(-at)dt\\[3pt]
      &= \frac{\Gamma(3/2)}{2a\sqrt{a}}\\[3pt]
      &= \frac{\sqrt{\pi}}{4a\sqrt{a}}
\end{align*}
$$

従って,

$$
\int^\infty_{-\infty}x^2\exp(-ax^2)dx = \frac{\sqrt{\pi}}{2a\sqrt{a}}
$$

</div>


## 数理統計におけるガンマ関数
### 標準正規分布の4次モーメント

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>標準正規分布の4次モーメント</ins></p>

$X \sim N(0, 1)$とするとき, $\mathbb E[X^4]$を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

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

</div>


## Appendix: ロピタルの定理

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: ロピタルの定理</ins></p>

$x=a$に十分近い$x$について$f(x), g(x)$は微分可能とする. さらに$x=a$以外で$g(x)\neq 0$とする

(1) $\lim_{x\to a}f(x)=\lim_{x\to a}g(x)=0$のとき次式が成り立つ

$$
\lim_{x\to a}\frac{f(x)}{g(x)} = \lim_{x\to a}\frac{f^\prime(x)}{g^\prime(x)}
$$

(2)  $\lim_{x\to a}\vert f(x)\vert= \infty, \lim_{x\to a}\vert g(x)\vert=\infty$のとき次式が成り立つ

$$
\lim_{x\to a}\frac{f(x)}{g(x)} = \lim_{x\to a}\frac{f^\prime(x)}{g^\prime(x)}
$$

(1), (2)で$a$を$\infty, -\infty$に置き換えても同様の命題が成り立つ.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

> $a<\infty, \lim_{x\to a}f(x)=g(x)=0$ の場合

平均値の定理より

$$
\begin{align*}
\frac{f(x)}{g(x)} = \frac{f(x)-f(a)}{g(x)-g(a)}= \frac{f^\prime(\xi)}{g^\prime(\xi)}
\end{align*}
$$

このとき, $\xi$は$a, x$の間の数. なお, $\xi\to a \text{ as }x\to a$なので

$$
\lim_{x\to a}\frac{f(x)}{g(x)} = \frac{f^\prime(a)}{g^\prime(a)}
$$


> $a=\infty, \lim_{x\to \infty}f(x)=g(x)=0$ の場合

$x = \frac{1}{t}$と変換し, 次の関数を考える

$$
\begin{align*}
&h(t) = f(1/t)\\
&k(t) = g(1/t)\\
& \lim_{t\to 0} h(t) = \lim_{t\to 0} k(t) =  0
\end{align*}
$$

従って,

$$
\begin{align*}
&\frac{h(t)}{k(t)} = \frac{h(t)-h(0)}{k(t)-k(0)} = \frac{h^\prime(\xi)}{k^\prime(\xi)}\\[3pt]
&\Rightarrow \lim_{t\to0}\frac{h(t)}{k(t)} = \lim_{t\to0}\frac{h^\prime(t)}{k^\prime(t)}
\end{align*}
$$

よって,

$$
\lim_{x\to\infty}\frac{f(x)}{g(x)} = \lim_{x\to\infty}\frac{f^\prime(x)}{g^\prime(x)}
$$


</div>

> ロピタルの定理の使用例

$$
\begin{align*}
\lim_{x\to\infty}\frac{x^k}{e^x} 
      &= \lim_{x\to\infty}\frac{kx^{k-1}}{e^x}\\[3pt]
      &= \lim_{x\to\infty}\frac{k(k-1)x^{k-2}}{e^x}\\[3pt]
      &= \cdots\\
      &= \lim_{x\to\infty}\frac{k!}{e^x}\\[3pt]
      &= 0
\end{align*}
$$


References
------------
- [とある数物研究者の覚書 > ガンマ関数](https://mathphysnote.com/math2/gammafn/#google_vignette)