---
layout: post
title: "三角関数と自然対数についての積分"
subtitle: "統計のための数学 7/N"
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

- [指数関数と正弦・余弦関数の積分](#%E6%8C%87%E6%95%B0%E9%96%A2%E6%95%B0%E3%81%A8%E6%AD%A3%E5%BC%A6%E3%83%BB%E4%BD%99%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D%E5%88%86)
  - [練習問題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C)
- [arctanと部分積分](#arctan%E3%81%A8%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86)
  - [arctanの微分](#arctan%E3%81%AE%E5%BE%AE%E5%88%86)
  - [arctanと部分積分](#arctan%E3%81%A8%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86-1)
- [対数関数と積分](#%E5%AF%BE%E6%95%B0%E9%96%A2%E6%95%B0%E3%81%A8%E7%A9%8D%E5%88%86)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 指数関数と正弦・余弦関数の積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$a, b$を任意の実数とし, 

$$
\begin{align*}
I &= \int \exp(ax)\cos bx\ dx\\[3pt]
J &= \int \exp(ax)\sin bx\ dx
\end{align*}
$$

とおくと,

$$
\begin{align*}
I &= \frac{\exp(ax)}{a^2 + b^2}(a\cos bx + b\sin bx) + C\\[3pt]
J &= \frac{\exp(ax)}{a^2 + b^2}(-b\cos bx + a\sin bx) + C
\end{align*}
$$

となることを示せ.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
I &= \int \exp(ax)\cos bx\ dx\\[3pt]
  &= \frac{1}{a}\exp(ax)\cos bx + \int \frac{b}{a}\exp(ax)\sin bx\ dx\\[3pt]
  &= \frac{1}{a}\exp(ax)\cos bx + \frac{b}{a}J + C
\end{align*}
$$

同様に

$$
\begin{align*}
J &= \int \exp(ax)\sin bx\ dx\\[3pt]
  &= \frac{1}{a}\exp(ax)\sin bx - \int \frac{b}{a}\exp(ax)\cos bx\ dx\\[3pt]
  &= \frac{1}{a}\exp(ax)\sin bx - \frac{b}{a}I  + C
\end{align*}
$$

これらを整理すると

$$
\begin{align*}
I &= \frac{\exp(ax)}{a^2 + b^2}(a\cos bx + b\sin bx) + C\\[3pt]
J &= \frac{\exp(ax)}{a^2 + b^2}(-b\cos bx + a\sin bx) + C
\end{align*}
$$

</div>

### 練習問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 1</ins></p>

定積分

$$
\int^\pi_0\exp(x)\sin x\ dx
$$

を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\int^\pi_0\exp(x)\sin x\ dx\\[3pt]
&= \underbrace{\left[\exp(x)\sin x\right]^\pi_0}_{=0} - \int^\pi_0\exp(x)\cos x\ dx\\[3pt]
&= \left[\exp(x)\cos x\right]^\pi_0 - \int^\pi_0\exp(x)\sin x\ dx 
\end{align*}
$$

従って, 

$$
\int^\pi_0\exp(x)\sin x\ dx = \frac{1 + \exp(\pi)}{2}
$$

これは, 

$$
\int \exp(ax)\sin bx\ dx = \frac{\exp(ax)}{a^2 + b^2}(-b\cos bx + a\sin bx)
$$

に対して, $(a, b) = (1,1)$, また $[0, \pi]$区間で積分した場合と同じ答えである.

</div>

<br>


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 2</ins></p>

定積分

$$
\int^\pi_0\exp(-x)\cos x\ dx
$$

を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\int^\pi_0\exp(-x)\cos x\ dx\\[3pt]
&= \left[(-1)\exp(-x)\cos x\right]^\pi_0 - \int^\pi_0\exp(x)\sin x\ dx\\[3pt]
&= [\exp(-\pi) + 1] - \left\{\underbrace{[(-1)\exp(-x)\sin x]^\pi_0}_{=0} + \int^\pi_0\exp(-x)\cos x\ dx\right\}
\end{align*}
$$

従って, 

$$
\int^\pi_0\exp(-x)\cos x\ dx= \frac{1 + \exp(-\pi)}{2}
$$

</div>

## arctanと部分積分
### arctanの微分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: arctanの微分</ins></p>

$$
\frac{d\arctan x}{dx} = \frac{1}{1+x^2}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

逆関数の微分公式を用いて示します

$x = \tan y$について, 両辺を$y$で微分すると

$$
\begin{align*}
\frac{dx}{dy} = \frac{1}{\cos^2 y} 
\end{align*}
$$

このとき, 三角関数の関係式より

$$
\begin{align*}
\cos^2y = \frac{1}{1 + \tan^2 y}
\end{align*}
$$

従って,

$$
\begin{align*}
\frac{dy}{dx} &= \cos^2y\\[3pt]
              &=  \frac{1}{1 + \tan^2 y}\\[3pt]
              &= \frac{1}{1+x^2}
\end{align*}
$$

</div>

### arctanと部分積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 1</ins></p>

定積分

$$
\int^1_0x^2\arctan x\ dx
$$

を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\int^1_0x^2\arctan x\ dx\\[3pt]
&= \left[\frac{1}{3}x^3\arctan x\right]^1_0 - \frac{1}{3}\int^1_0\frac{x^3}{1+x^2}\ dx\\[3pt]
&= \frac{\pi}{12} - \frac{1}{3}\int^1_0\left(x - \frac{x}{1+x^2}\right)\ dx\\[3pt]
&= \frac{\pi}{12} - \frac{1}{6} + \frac{\log 2}{6}
\end{align*}
$$

</div>


## 対数関数と積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 1</ins></p>

定積分

$$
\int^e_1x^2\log x\ dx
$$

を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\int^e_1x^2\log x\ dx \\[3pt]
&= \left[\frac{1}{3}x^3\log x\right]^e_1 - \int^e_1x^2\ dx\\[3pt]
&= \frac{2\exp(3) + 1}{9}
\end{align*}
$$

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 2</ins></p>

定積分

$$
\int^e_1x(\log x)^2\ dx
$$

を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\int^e_1x(\log x)^2\ dx \\[3pt]
&= \left[\frac{1}{2}x^2(\log x)^2\right]^e_1 - \int^e_1x\log x\ dx\\[3pt]
&= \left[\frac{1}{2}x^2(\log x)^2\right]^e_1 - \left[\frac{1}{2}x^2\log x\right]^e_1 + \left[\frac{x^2}{4}\right]^e_1\\[3pt]
&= \frac{\exp(2)-1}{4}
\end{align*}
$$

</div>

<br>

References
---------
- [Ryo's Tech Blog > 加法定理と積和の公式の図形的理解](https://ryonakagami.github.io/2021/02/14/addition-theorem/)
