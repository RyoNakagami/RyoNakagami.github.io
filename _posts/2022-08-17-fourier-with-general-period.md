---
layout: post
title: "任意の周期をもつ周期関数対するフーリエ展開"
subtitle: "フーリエ解析 6/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-30
header-mask: 0.0
header-style: text
tags:

- math
- フーリエ解析
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [周期の一般化](#%E5%91%A8%E6%9C%9F%E3%81%AE%E4%B8%80%E8%88%AC%E5%8C%96)
  - [基本周期2Lの周期関数と積分範囲](#%E5%9F%BA%E6%9C%AC%E5%91%A8%E6%9C%9F2l%E3%81%AE%E5%91%A8%E6%9C%9F%E9%96%A2%E6%95%B0%E3%81%A8%E7%A9%8D%E5%88%86%E7%AF%84%E5%9B%B2)
- [練習問題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 周期の一般化

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Prop: 周期の拡張</ins></p>

関数 $f(x)$ を周期 $2L (L > 0)$の周期関数とする. このときフーリエ級数展開が可能であるならば

$$
\begin{align*}
f(x) &\sim \frac{a_0}{2} + \sum_{n=1}^\infty\left(a_n \cos \frac{n\pi x}{L} + b_n \sin \frac{n\pi x}{L}\right)\\[3pt]
a_n &= \frac{1}{L}\int^L_{-L}f(x)\cos \frac{n\pi x}{L}\ dx\\[3pt]
b_n &= \frac{1}{L}\int^L_{-L}f(x)\sin \frac{n\pi x}{L}\ dx
\end{align*}
$$

</div>

考え方としては, 周期 $2L$ の周期関数の変数$x$のスケールを変換すれば$2\pi$ できるので,

$$
t = \frac{\pi x}{L}, \ \left(x = \frac{Lt}{\pi}\right)
$$

と変数変換すると $x$ が$2L$変化する間に$t$は$2\pi$変化する, すなわち

$$
\begin{align*}
h(t) &= f\left(\frac{L t}{\pi}\right)\\[3pt]
h(t) &\sim \frac{a_0}{2} + \sum_{n=1}^\infty\left(a_n \cos nt + b_n \sin nt \right)
\end{align*}
$$

一方, フーリエ係数は変数変換を用いると

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^\pi_{-\pi}h(t)\cos nt dt\\[3pt]
    &= \frac{1}{\pi}\int^L_{-L} h\left(\frac{\pi x}{L}\right)\cos \frac{n\pi x}{L} \frac{dt}{dx} dx\\[3pt]
    &= \frac{1}{\pi}\int^L_{-L} f(x)\cos \frac{n\pi x}{L} \frac{\pi}{L} dx\\[3pt]
    &=  \frac{1}{L}\int^L_{-L}f(x)\cos \frac{n\pi x}{L}\ dx\
\end{align*}
$$

となります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>REMARKS: 余弦展開と正弦展開</ins></p>

余弦展開と正弦展開のフーリエ係数はそれぞれ以下のように表せる:

$$
\begin{align*}
a_n &= \frac{2}{L}\int^L_{0}f(x)\cos \frac{n\pi x}{L}\ dx\\[3pt]
b_n &= \frac{2}{L}\int^L_{0}f(x)\sin \frac{n\pi x}{L}\ dx
\end{align*}
$$

</div>


### 基本周期2Lの周期関数と積分範囲

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 積分範囲</ins></p>

周期$2L$の周期関数に対応する係数を, $c$を任意の定数として

$$
\begin{align*}
a_n &= \frac{1}{L}\int^{c+2L}_{c}f(x)\cos \frac{n\pi x}{L}\ dx\\[3pt]
b_n &= \frac{1}{L}\int^{c+2L}_{c}f(x)\sin \frac{n\pi x}{L}\ dx
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

(この証明は[Ryo's Tech Blog > 三角関数系の直交性](https://ryonakagami.github.io/2022/08/13/triangular-functions/)でも取り扱ったが再掲載)


$$
\begin{align*}
&\int^{c+2L}_{c}f(x)\cos \frac{n\pi x}{L}\ dx\\[3pt]
&= \int^{2L}_{c}f(x)\cos \frac{n\pi x}{L}\ dx + \int^{2L+c}_{2L}f(x)\cos \frac{n\pi x}{L}\ dx
\end{align*}
$$

このとき, $f(x), \cos n\pi x/ L$は周期$2L$をもつので

$$
\int^{2L+c}_{2L}f(x)\cos \frac{n\pi x}{L} = \int^{c}_{0}f(x)\cos \frac{n\pi x}{L}\ dx
$$

従って, 

$$
\begin{align*}
&\int^{2L}_{c}f(x)\cos \frac{n\pi x}{L}\ dx + \int^{c}_{0}f(x)\cos \frac{n\pi x}{L}\ dx \\[3pt]
&= \int^{2L}_{0}f(x)\cos \frac{n\pi x}{L}\ dx 
\end{align*}
$$

</div>

## 練習問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

$$
f(x) = x \qquad (-2\leq x<2)
$$

を$f(x + 4) = f(x)$により周期的に拡張した周期4の関数をフーリエ展開せよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$f(x)$は奇関数なので$b_n$のみ計算すれば十分.

$$
\begin{align*}
b_n &= \frac{1}{L}\int^L_{-L}x\sin\left(\frac{n\pi x}{L}\right)\ dx\\[3pt]
    &= \frac{2}{L}\int^L_{0}x\sin\left(\frac{n\pi x}{L}\right)\ dx \ \because\text{奇関数同士の積は偶関数} \\[3pt]
    &= \frac{2}{L}\frac{L}{n \pi}\left[-x\cos \frac{n\pi x}{L}\right]^L_0\\[3pt]
    &= (-1)^{n+1}\frac{2L}{n \pi}
\end{align*}
$$

今回は $L = 2$なので

$$
f(x) \sim \sum_{n=1}^\infty (-1)^{n+1}\frac{4}{n \pi} \sin \frac{n\pi x}{L}
$$


{% include plotly/20220817_example_1.html %}

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

$$
f(x) = \cos x \qquad (-4\leq x<4)
$$

を$f(x + 8) = f(x)$により周期的に拡張した周期4の関数をフーリエ展開せよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$f(x)$は偶関数なので$a_0$を求めれば十分.

$$
\begin{align*}
a_0 &= \frac{1}{L}\int^L_{-L} \cos x \ dx\\[3pt]
    &= \frac{2}{L}\int^L_{0} \cos x \ dx\\[3pt]
    &= \frac{1}{2}\sin 4
\end{align*}
$$

$n\neq 0$について, 積和の公式より

$$
\cos x \cos y = \frac{1}{2}\left[\cos (x+y) + \cos (x-y)\right]
$$

なので


$$
\begin{align*}
a_n &= \frac{1}{L}\int^L_{-L} \cos x \cos \frac{n\pi x}{L}\ dx\\[3pt]
    &= \frac{1}{L}\left[\frac{L}{n\pi+L}\sin(n\pi +L) + \frac{L}{n\pi-L}\sin(n\pi -L)\right]\\[3pt]
    &= (-1)^{n+1} \frac{2L \sin L}{n^2\pi^2 - L^2}\\[3pt]
    &= (-1)^{n+1} \frac{8 \sin 4}{n^2\pi^2 - 16}
\end{align*}
$$

従って,

$$
f(x)\sim \frac{1}{2}\sin 4 + \sum_{n=1}^\infty (-1)^{n+1} \frac{8 \sin 4}{n^2\pi^2 - 16} \cos \frac{n\pi x}{4}
$$

{% include plotly/20220817_example_2.html %}

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

$$
f(x) = \exp x \qquad (0\leq x<1)
$$

をフーリエ余弦級数展開とフーリエ正弦級数せよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

> **フーリエ余弦級数展開**

$$
\begin{align*}
a_0 &= 2\int^1_0 \exp(x) dx\\
    &= 2 (e - 1) 
\end{align*}
$$

$n\neq 0$について

$$
\begin{align*}
I = \int^L_0\exp(x)\cos \frac{n\pi x}{L}\ dx 
\end{align*}
$$

とすると

$$
\begin{align*}
I &= \underbrace{\left[\exp(x)\cos\frac{n\pi x}{L}\right]^L_0}_{=J}+ \frac{n\pi}{L}\int^L_0\exp(x)\sin \frac{n\pi x}{L}\ dx \\[3pt]
  &= J + \left[\frac{n\pi}{L}\exp(x)\sin\frac{n\pi x}{L}\right]^L_0 - \frac{n^2\pi^2}{L^2}\int^L_0\exp(x)\cos \frac{n\pi x}{L}\ dx \\[3pt]
  &= J - \left(\frac{n^2\pi^2}{L^2}\right)I
\end{align*}
$$

つまり, 

$$
I = \frac{L^2}{L^2 + n^2\pi^2} J
$$

また,

$$
J = \begin{cases}
\exp(L) - 1 & n \text{: even}\\
-\exp(L) - 1 & n \text{: odd}
\end{cases}
$$

従って, 

$$
a_n = \frac{2}{1+ n^2\pi^2}[(-1)^ne - 1]
$$

よって,


$$
f(x)\sim  (e - 1) + \sum_{n=1}^\infty\frac{2}{1+ n^2\pi^2}[(-1)^ne - 1]\cos(n\pi x )
$$


{% include plotly/20220817_example_3.html %}


> **フーリエ正弦級数展開**

$$
b_n = \frac{2}{L}\int^L_0\exp(x)\sin\frac{n\pi x}{L}dx
$$

このとき,

$$
\begin{align*}
&\int^L_0\exp(x)\sin\frac{n\pi x}{L}dx\\[3pt]
&= \left[\exp(x)\sin\frac{n\pi x}{L}\right]^L_0 - \frac{n\pi}{L}\int^L_0\exp(x)\cos\frac{n\pi x}{L} dx\\[3pt]
&= -\frac{n\pi}{L}\int^L_0\exp(x)\cos\frac{n\pi x}{L} dx
\end{align*}
$$

ここで, 

$$
\int^L_0\exp(x)\cos\frac{n\pi x}{L} dx = \frac{L^2}{L^2 + n^2\pi^2} [(-1)^n \exp(L) - 1]
$$

なので

$$
b_n = \frac{-2n\pi}{1 + n^2\pi^2} [(-1)^n \exp(L) - 1]
$$

従って,

$$
f(x)\sim\sum_{n=1}^\infty \frac{-2n\pi}{1 + n^2\pi^2} [(-1)^n \exp(L) - 1] \sin n\pi x
$$


{% include plotly/20220817_example_4.html %}


</div>




References
----------
- [フーリエ解析（理工系の数学入門コース［新装版］）](https://pro.kinokuniya.co.jp/search_detail/product?ServiceCode=1.0&UserID=PLATON&isbn=9784000298889&lang=en-US&search_detail_called=1&table_kbn=A%2CE%2CF)
