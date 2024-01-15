---
layout: post
title: "三角関数系の直交性"
subtitle: "フーリエ解析 2/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-15
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

- [三角関数の性質](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [周期性](#%E5%91%A8%E6%9C%9F%E6%80%A7)
  - [奇関数と偶関数](#%E5%A5%87%E9%96%A2%E6%95%B0%E3%81%A8%E5%81%B6%E9%96%A2%E6%95%B0)
- [三角関数の直交性](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%AE%E7%9B%B4%E4%BA%A4%E6%80%A7)
  - [正弦関数の直交性](#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%9B%B4%E4%BA%A4%E6%80%A7)
  - [余弦関数の直交性](#%E4%BD%99%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%9B%B4%E4%BA%A4%E6%80%A7)
  - [正弦関数と余弦関数の積](#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%A8%E4%BD%99%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D)
- [演習問題](#%E6%BC%94%E7%BF%92%E5%95%8F%E9%A1%8C)
  - [三角関数の公式の証明](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%AE%E5%85%AC%E5%BC%8F%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [基本周期](#%E5%9F%BA%E6%9C%AC%E5%91%A8%E6%9C%9F)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 三角関数の性質

フーリエ級数展開は, 性質のよくわからない関数を性質のよくしれた三角関数の重ね合わせといｓて表す方法です.
この記事では三角関数の性質を確認します.

{% include plotly/20220813_sincos_plot.html %}

$\sin, \cos$に共通しているのはどちらも最大値が1, 最小値が-1, 1周期が$2\pi$であることです.
このことから,  整数$n$に対して

$$
\begin{align*}
\sin n\pi &= 0\\
\cos n\pi &= (-1)^n
\end{align*}
$$

が成立します. また, $\sin, \cos$の関係について, 上記のplotより

$$
\begin{align*}
\sin\left(\theta + \frac{\pi}{2}\right) &= \cos\theta\\[3pt] 
\sin\left(\frac{\pi}{2}-\theta\right) &= \cos\theta\\[3pt] 
\cos\left(\frac{\pi}{2}-\theta\right) &= \sin\theta\\[3pt] 
\end{align*}
$$

### 周期性

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 周期関数, periodic function</ins></p>

関数$f(x)$が

$$
f(x+T) = f(x) \qquad (T > 0)
$$

を満たすとき, fを周期関数と呼び, また, $T$をその周期という. 特に最小の$T$のことを基本周期と呼ぶ.

</div>

この周期関数の定義より, 三角関数の基本周期は$2\pi$なので整数$n$に対して以下が成立します.

$$
\begin{align*}
\sin(x + 2n\pi) &= \sin x\\
\cos(x + 2n\pi) &= \cos x
\end{align*}
$$

また周期関数について以下の性質が知られています.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>周期関数の性質</ins></p>

関数$f(x), g(x)$がともに周期$T$の周期関数であるとする. このとき, $a, b$を定数としたとき

$$
\begin{align*}
h_1(x) &\equiv af(x) + bg(x)\\
h_2(x) &\equiv f(x)g(x)
\end{align*}
$$

も周期$T$の関数となる.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

示すべきことは

$$
\begin{align*}
h_1(x+T) &= h_1(x)\\
h_2(x+T) &= h_2(x)
\end{align*}
$$


> 線型結合について

$$
\begin{align*}
h_1(x + T) &= af(x + T) + bg(x +T)\\
           &= af(x) + bg(x)\\
           &= h_1(x)
\end{align*}
$$

> 乗法結合について

$$
\begin{align*}
h_2(x + T) &= f(x + T)g(x +T)\\
           &= f(x)g(x)\\
           &= h_2(x)
\end{align*}
$$

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>周期関数の性質と積分範囲</ins></p>

周期$T$の関数$f(x)$について, 任意の定数$c$に対して

$$
\int^T_0f(x)dx = \int^{T+c}_cf(x)dx
$$

が成立する.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\int^{T+c}_cf(x)dx = \int^{T}_cf(x)dx + \int^{T+c}_{T}f(x)dx
\end{align*}
$$

とすると, $f(x)$は周期$T$の関数であることから

$$
\int^{T+c}_{T}f(x)dx = \int^{c}_{0}f(x)dx
$$

従って, 

$$
\begin{align*}
\int^{T+c}_cf(x)dx &= \int^{T}_cf(x)dx + \int^{T+c}_{T}f(x)dx\\
                   &= \int^{T}_cf(x)dx + \int^{c}_{0}f(x)dx\\
                   &= \int^T_0f(x)dx 
\end{align*}
$$


</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>定数倍と基本周期</ins></p>

$h(x)$を基本周期$T$の関数としたとき, 任意の0以外の正の実数に対して

$$
f(x) \equiv h(ax)
$$

と定義すると, $f(x)$の基本周期は$T/a$となる

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
f\left(x + \frac{T}{a}\right) &= h(ax + T)\\[3pt]
                              &= h(ax)\\[3pt]
                              &= f(x)
\end{align*}
$$

従って, 基本周期は$T/a$が確認できた.

</div>



### 奇関数と偶関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 奇関数と偶関数</ins></p>

任意の$-\infty < x < \infty$に対して

$$
f(-x) = f(x)
$$

ならば偶関数

$$
f(-x) = -f(x)
$$

ならば奇関数と呼ぶ.

</div>

奇関数と偶関数の例として

- 関数 $x$は奇関数
- 関数 $\vert x \vert $は偶関数
- 関数 $\sin nx$は奇関数
- 関数 $\cos nx$は偶関数

奇関数と偶関数の性質として以下の３つが知られています:

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Property 1</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

関数$f(x)$を任意の関数とする. このとき,

$$
\begin{align*}
f_e(x) &= \frac{f(x) + f(-x)}{2}\\[3pt]
f_o(x) &= \frac{f(x) - f(-x)}{2}
\end{align*}
$$

$f_e(x), f_o(x)$はそれぞれ偶関数, 奇関数を表すとする.

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Property 2</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

- 偶関数と偶関数の積と奇関数と奇関数の積は偶関数
- 偶関数と奇関数の積は奇関数

$$
\begin{align*}
f_e &= f_e\times f_e\\
f_e &= f_o\times f_o\\
f_o &= f_e\times f_o
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Property 3</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

$f_e(x), f_o(x)$をそれぞれ偶関数, 奇関数としたとき

$$
\begin{align*}
\int^\pi_{-\pi}f_e(x) dx &= 2\int^\pi_{0}f_e(x) dx\\
\int^\pi_{-\pi}f_o(x) dx &= 0
\end{align*}
$$

</div>

## 三角関数の直交性

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 直交性</ins></p>

基本周期$2\pi$の関数$f(x), g(x)$が直交するとは

$$
\int^{2\pi}_0f(x)g(x) = 0
$$

が成立することである.

</div>

三角関数における直交性をここでは考えてみます.

### 正弦関数の直交性

$m, n$が共に整数で, かつ $m\neq n$が成立するとします. このとき, $\sin nx$ と$ \sin mx$は周期$2\pi$をもちます.

もし, $\sin nx$ と$\sin mx$が直交するならば

$$
\int^{\pi}_{-\pi} \sin nx \sin mx\ dx = 0
$$

が成立します.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

加法定理より

$$
\begin{align*}
\sin mx \times \sin nx = \frac{1}{2}\{\cos(mx-nx) - \cos(mx+nx)\} 
\end{align*}
$$

従って, 

$$
\begin{align*}
\int^{\pi}_{-\pi} \sin nx \sin mx\ dx &= \frac{1}{2}\left[\int^{\pi}_{-\pi} \{\cos(mx-nx) - \cos(mx+nx)\}dx\right]\\[3pt]
&= \frac{1}{2}\left(\frac{1}{m-n}[\sin(m-n)x]^\pi_{-\pi} - \frac{1}{m+n}[\sin(m+n)x]^\pi_{-\pi}\right)\\
&= 0
\end{align*}
$$

従って, $m, n$が共に整数で, かつ $m\neq n$が成立するとき, $\sin nx$ と$\sin mx$は直交する.


</div>

なお, $m=n$のときは

$$
\begin{align*}
\int^{\pi}_{-\pi} \sin nx \sin mx\ dx &= \frac{1}{2}\left[\int^{\pi}_{-\pi} \{\cos(mx-nx) - \cos(mx+nx)\}dx\right]\\[3pt]
&= \frac{1}{2}\left[\int^{\pi}_{-\pi} \{1 - \cos(mx+nx)\}dx\right]\\[3pt]
&= \pi
\end{align*}
$$

これらより, クロネッカーのデルタを用いて以下のように表現されるケースが多いです

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >直交性とクロネッカーのデルタ</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

$$
\frac{1}{\pi}\int^\pi_{-\pi}\sin m\theta \sin n\theta\ d\theta = \delta_{mn} \qquad (m,n\text{は整数})
$$

周期関数の特性を利用して以下のように表記する場合もあります

$$
\frac{1}{\pi}\int^{2\pi}_{0}\sin m\theta \sin n\theta\ d\theta = \delta_{mn} \qquad (m,n\text{は整数})
$$

</div>

### 余弦関数の直交性

コサインの場合もクロネッカーのデルタを用いて以下のように表現できます:

$$
\frac{1}{\pi}\int^\pi_{-\pi}\cos m\theta \cos n\theta\ d\theta = \delta_{mn} \qquad (m,n\text{は整数})
$$

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

加法定理より

$$
\begin{align*}
\cos mx \times \cos nx = \frac{1}{2}\{\cos(mx-nx) + \cos(mx+nx)\} 
\end{align*}
$$

従って, 

$$
\begin{align*}
\int^{\pi}_{-\pi} \sin nx \sin mx\ dx &= \frac{1}{2}\left[\int^{\pi}_{-\pi} \{\cos(mx-nx) + \cos(mx+nx)\}dx\right]\\[3pt]
&= \frac{1}{2}\left(\frac{1}{m-n}[\sin(m-n)x]^\pi_{-\pi} + \frac{1}{m+n}[\sin(m+n)x]^\pi_{-\pi}\right)
\end{align*}
$$

よって,

$$
\frac{1}{\pi}\int^\pi_{-\pi}\cos m\theta \cos n\theta\ d\theta = \delta_{mn} \qquad (m,n\text{は整数})
$$

</div>

### 正弦関数と余弦関数の積

サインとコサインをかけ合わせた関数の積分について

$$
\int^{\pi}_{-\pi}\sin m\theta \cos n\theta\ d\theta = 0
$$

が成立します.

一般に, 奇関数に偶関数をかけると奇関数になるので

$$
\sin m\theta \cos n\theta =f_o(\theta)
$$

帰還数について原点から当距離の範囲で積分したとき

$$
\int^L_{-L}f_o(x)dx = 0
$$

が成立するので, サインとコサインが直交していることがわかります.

## 演習問題
### 三角関数の公式の証明

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

次の公式を証明せよ

$$
\cos^3x = \frac{3\cos x + \cos 3x}{4}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\cos^3x &= \cos x\cos^2 x\\
        &= \cos x \frac{1 + \cos 2x}{2}\\[3pt]
        &= \frac{\cos x}{2} + \frac{\cos 3x + \cos x}{4}\\[3pt]
        &= \frac{3\cos x + \cos 3x}{4}
\end{align*}
$$

これは偶関数と偶関数の積が偶関数になっているという観点から解答の正しさが確認できる.

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題: フーリエ級数展開</ins></p>

三角関数の積を和に変換する公式を利用して, 次の関数のフーリエ級数展開をもとめよ

$$
\begin{align*}
(1) \qquad& f(x) = \sin x \cos x\qquad\\
(2) \qquad& f(x) = \sin x\sin 3x \qquad\\
(3) \qquad& f(x) = \cos x\cos 3x \qquad\\

\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

加法定理より

$$
\begin{align*}
\sin x \cos x &= \frac{1}{2}\sin 2x\\[3pt]
\sin x\sin 3x &= \frac{1}{2}(\cos 2x - \cos 4x)\\[3pt]
\cos x\cos 3x &= \frac{1}{2}(\cos 2x + \cos 4x)
\end{align*}
$$

</div>






### 基本周期

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

次の関数の基本周期を求めよ

$$
f(x) = \cos \frac{x}{2} + \cos \frac{x}{3}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

RHSの第一項の基本周期は$4\pi$, 第二項は$6\pi$なのでその最小公倍数は$12\pi$

$$
\begin{align*}
f(x+12\pi) &= \cos \frac{x+12\pi}{2} + \cos \frac{x+12\pi}{3}\\[3pt]
           &= \cos \left(\frac{x}{2} + 6\pi\right) + \cos \left(\frac{x}{3} + 4\pi\right)\\[3pt]
           &= \cos \frac{x}{2} + \cos \frac{x}{3} = f(x)
\end{align*}
$$

と基本周期が$12\pi$であることが確認できた.

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

次の関数の基本周期を求めよ

$$
\sin 3x + 3\cos 5x
$$

</div>

<br>
周期は$T/a$
<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

- 第1項の基本周期は$\frac{2}{3}\pi$
- 第2項の基本周期は$\frac{2}{5}\pi$

従って, $2\pi$が$\sin 3x + 3\cos 5x$の基本周期となる.


</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

次の関数の基本周期を求めよ

$$
\sin x\cos 2x
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

加法定理より

$$
\begin{align*}
\sin x\cos 2x = \frac{\sin 3x - \sin x}{2}
\end{align*}
$$

従って, 基本周期は$2\pi$. これは奇関数と偶関数の積が奇関数であることからも正しさが確かめられる.

</div>




References
------------
- [フーリエ解析（理工系の数学入門コース［新装版］）](https://pro.kinokuniya.co.jp/search_detail/product?ServiceCode=1.0&UserID=PLATON&isbn=9784000298889&lang=en-US&search_detail_called=1&table_kbn=A%2CE%2CF)