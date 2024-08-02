---
layout: post
title: "フーリエ級数の練習問題"
subtitle: "フーリエ解析 7/N"
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

<!-- START doctoc -->
<!-- END doctoc -->


</div>

## 三角関数の積をフーリエ級数展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$[0, 2\pi)$区間で定義された以下の関数を$f(x + 2\pi)=f(x)$で拡張したときのフーリエ係数を求めよ

$$
\begin{align*}
(1) & \qquad f(x) = \cos x \sin 2x\\
(2) & \qquad f(x) = \cos^2 x\\
(3) & \qquad f(x) = \sin^3 x
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

> **(1) について**

偶関数と奇関数の積は奇関数なので$b_n$のみに注目すればいいとわかる.

$$
\begin{align*}
b_n &= \frac{1}{\pi}\int^{2\pi}_0 \cos x \sin 2x \sin nx dx\\[3pt]
    &= -\frac{1}{2\pi}\int^{2\pi}_0\cos x \cos (2+n)x -\cos x\cos(2-n)x dx
\end{align*}
$$

余弦関数の直交性より $n=1, 3$のときのみ注目すればいいので

$$
\begin{align*}
b_1 &= \frac{1}{2\pi}\int^{2\pi}_0\cos x\cos(2-1)x dx\\[3pt]
    &= \frac{1}{2}\\
    \\
b_3 &= \frac{1}{2\pi}\int^{2\pi}_0\cos x\cos(2-3)x dx\\[3pt]
    &= \frac{1}{2\pi}\int^{2\pi}_0\cos x\cos(-x) dx\\[3pt]
    &= \frac{1}{2\pi}\int^{2\pi}_0\cos x\cos x dx\\[3pt]
    &= \frac{1}{2}
\end{align*}
$$

従って, 

$$
f(x) \sim \frac{1}{2}\sin x + \frac{1}{2}\sin 3x
$$

> **(2) について**

$$
\begin{align*}
\cos^2x &= \cos x \cos x\\
        &= \frac{1}{2}[\cos(2x) + 1]\\
        &= \frac{1}{2} + \frac{1}{2}\cos(2x)
\end{align*}
$$

> **(3) について**

$$
\begin{align*}
\sin^3 x &= \sin x\sin^2 x\\[3pt]
         &= \sin x \left[-\frac{1}{2}(\cos 2x - 1)\right]\\[3pt]
         &= -\frac{1}{2}(\sin x\cos 2x - \sin x)\\[3pt]
         &= -\frac{1}{2}\left(\frac{1}{2}\sin 3x + \frac{1}{2}\sin(-x) - \sin x\right)\\[3pt]
         &= \frac{3\sin x}{4} - \frac{1}{4}\sin 3x 
\end{align*}
$$

</div>

## 絶対値を用いた関数のフーリエ展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$[0, 2\pi)$区間で定義された以下の関数を$f(x + 2\pi)=f(x)$で拡張したときのフーリエ係数を求めよ

$$
f(x) = \vert x - \pi \vert
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

拡張された関数は偶関数なので$a_n$の係数のみに着目すれば良い. 

$$
a_0 = \frac{1}{\pi}\times \frac{2\pi\times \pi}{2} = \pi
$$

$n\geq 1$について

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{2\pi}_0 \vert x - \pi \vert \cos nx\ dx\\[3pt]
    &= \frac{1}{\pi}\left[\int^{\pi}_0 (\pi - x) \cos nx\ dx + \int^{2\pi}_\pi (x - \pi) \cos nx\ dx\right]\\[3pt]
    &= \frac{1}{\pi}\left[\int^{\pi}_0 - x \cos nx\ dx + \int^{2\pi}_\pi x \cos nx\ dx\right]\\[3pt]
    &= -\frac{1}{\pi}\left[\frac{\cos nx}{n^2}\right]^\pi_0 + \frac{1}{\pi}\left[\frac{\cos nx}{n^2}\right]^{2\pi}_\pi\\[3pt]
    &= 
    \begin{cases}
    0 & n\text{: even}\\[3pt]
    \displaystyle \frac{4}{n^2\pi}& n\text{: odd}
    \end{cases}
\end{align*}
$$

したがって,

$$
f(x) \sim \frac{\pi}{2} + \sum_{n=1}^\infty \frac{4}{(2n-1)^2\pi}\cos (2n-1)x
$$

{% include plotly/20220818_example_2.html %}

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 正弦関数と絶対値</ins></p>

$[0, 2\pi)$区間で定義された以下の関数を$f(x + 2\pi)=f(x)$で拡張したときのフーリエ係数を求めよ

$$
f(x) = \vert \sin x \vert
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

拡張された関数は偶関数なので $a_n$のみに着目すれば十分

$$
\begin{align*}
a_0 &= \frac{1}{\pi}\int^{2\pi}_0 \vert \sin x\vert\ dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 \sin x\ dx\\[3pt]
    &= \frac{4}{\pi}\\
    \\
a_1 &=  \frac{1}{\pi}\int^{2\pi}_0 \vert \sin x\vert\cos x dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 \vert\sin x \vert\cos x dx \qquad \because{\text{偶関数同士の積}}\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 \sin x \cos x dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 \bigg[\frac{1}{2}(\sin 2x + \sin 0)\bigg]dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi}_0 \sin 2x\ dx\\[3pt]
    &= 0\\
    \\
a_n &= \frac{1}{\pi}\int^{2\pi}_0 \vert \sin x\vert \cos nx\ dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 \sin x \cos nx dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi}_0 (\sin (n+1)x - \sin (n-1)x)dx\\[3pt]
    &= \begin{cases}
        0 & n:\text{odd}\\[3pt]
        \displaystyle -\frac{4}{\pi (n^2-1)} & n:\text{even}
        \end{cases}
\end{align*}
$$

したがって,

$$
f(x) \sim \frac{2}{\pi} - \sum_{n=1}^\infty \frac{4}{\pi(4n^2 - 1)}\cos(2nx)
$$


{% include plotly/20220818_example_3.html %}

</div>


## 不連続だが区分的に連続な関数
### 方形波

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

区間 $[0, 2\pi]$において, $x=\pi$を除き,

$$
f(x) = \frac{\pi - x}{\vert \pi - x \vert}
$$

と定義した不連続な関数を考える. この関数を$f(x+2\pi) = f(x)$と周期的に拡張したときのフーリエ級数展開を求めよ.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
a_0 &= \frac{1}{\pi}\int^{2\pi}_0 \frac{\pi-x}{\vert \pi-x\vert}dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi}_0 \frac{\pi-x}{\pi-x}dx - \frac{1}{\pi}\int^{2\pi}_\pi \frac{\pi-x}{ \pi-x}dx\\[3pt]
    &= 0\\
    \\
a_n &= \frac{1}{\pi}\int^{2\pi}_0 \frac{\pi-x}{\vert \pi-x\vert} \cos nx dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi}_0 \cos nx dx - \frac{1}{\pi}\int^{2\pi}_\pi \cos nx dx \\[3pt]
    &=0
\end{align*}
$$

また, $b_n$については

$$
\begin{align*}
b_n &= \frac{1}{\pi}\int^{\pi}_0 \sin nx dx - \frac{1}{\pi}\int^{2\pi}_\pi \sin nx dx \\[3pt]
    &= \frac{1}{\pi}\left\{-\frac{1}{n}[\cos nx]^\pi_0 + \frac{1}{n}[\cos nx]^\pi_0\right\}\\[3pt]
    &= \begin{cases}
    \displaystyle 0 & n\text{: even}\\[3pt]
    \displaystyle \frac{4}{\pi n} & n\text{: odd}
    \end{cases}
\end{align*}
$$

従って,

$$
f(x) \sim \sum^{\infty}_{n=1} \frac{4}{\pi (2n-1)}\sin(2n-1)x
$$

{% include plotly/20220818_example_1.html %}

</div>

なお, 上記のフーリエ級数展開は

$$
g(x) = \begin{cases}
\displaystyle 1 & (0\leq x < \pi)\\[3pt]
\displaystyle -1 & (\pi\leq x < 2\pi)
\end{cases}
$$

を$g(x+2\pi) = g(x)$と周期拡張したときのフーリエ係数と一致します.

$f(x), g(x)$が周期を同じとする連続関数の場合, フーリエ係数がすべて一致すれば

$$
f(x) \equiv g(x)
$$

が成り立ちますが, 上記の場合は不連続関数なので係数が一致したけれども, 関数は同じとは限りません.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</証明ins></p>

$$
f(x) = \begin{cases}
1 & \qquad (-\pi/2 \leq x < \pi/2)\\
0 & \qquad (-\pi \leq x < -\pi/2)\\
0 & \qquad (\pi/2 \leq x < \pi)
\end{cases}
$$

この関数を$f(x+2\pi) = f(x)$と周期的に拡張したときのフーリエ級数展開を求めよ.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

拡張された関数は偶関数なので $a_n$のみに着目すれば十分.

$$
\begin{align*}
a_0 &= \frac{1}{\pi}\int^\pi_{-\pi}f(x)dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi/2}_{-\pi/2}dx\\[3pt]
    &= 1\\
    \\
a_n &= \frac{1}{\pi}\int^{\pi/2}_{-\pi/2}\cos nx\ dx\\[3pt]
    &= \frac{1}{n\pi}\bigg[\sin nx\bigg]^{\pi/2}_{-\pi/2}\\[3pt]
    &= \begin{cases}
        \displaystyle 0 & n: \text{even} \\[6pt]
        \displaystyle \frac{2}{n\pi} & n \bmod 4 \equiv 1\\[6pt]
        \displaystyle \frac{-2}{n\pi} & n \bmod 4 \equiv 3
       \end{cases}
\end{align*}
$$

したがって,

$$
f(x) \sim \frac{1}{2} + \sum_{n=1}^\infty(-1)^{n+1} \frac{2}{(2n-1)\pi}\cos(2n-1)x
$$

{% include plotly/20220818_example_4.html %}

</div>


### ノコギリ波

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</証明ins></p>

$$
f(x) = \begin{cases}
x & \qquad (0 \leq x < \pi)\\
x - \pi & \qquad (\pi \leq x < 2\pi)
\end{cases}
$$

この関数を$f(x+2\pi) = f(x)$と周期的に拡張したときのフーリエ級数展開を求めよ.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
a_0 &= \frac{1}{\pi}\int^{2\pi}_0f(x)dx\\[3pt]
    &= \pi\\
    \\
a_n &= \frac{1}{\pi}\bigg[\int_0^\pi x\cos nx dx + \int_{\pi}^{2\pi} (x-\pi)\cos nx dx\bigg]\\[3pt]
    &= \frac{1}{\pi}\bigg[\int_0^{2\pi} x\cos nx dx - \int_{\pi}^{2\pi} \pi\cos nx dx\bigg]\\[3pt]
    &= 0
\end{align*}
$$

一方, $b_n$については

$$
\begin{align*}
b_n &= \frac{1}{\pi}\bigg[\int_0^\pi x\sin nx dx + \int_{\pi}^{2\pi} (x-\pi)\sin nx dx\bigg]\\[3pt]
    &= \frac{1}{\pi}\bigg[\int_0^{2\pi} x\sin nx dx - \int_{\pi}^{2\pi} \pi\sin nx dx\bigg]
\end{align*}
$$

積分の第一項については

$$
\begin{align*}
\int_0^{2\pi} x\sin nx dx &= \bigg[-\frac{1}{n}x\cos nx\bigg]^{2\pi}_0\\
                          &= -\frac{2\pi}{n}
\end{align*}
$$

第二項については

$$
\begin{align*}
\int_{\pi}^{2\pi} \pi\sin nx dx &= \bigg[-\frac{\pi}{n}\cos nx\bigg]^{2\pi}_\pi\\
                                &= \begin{cases}
                                    \displaystyle 0 & \text{n: even}\\[3pt]
                                    \displaystyle \frac{2\pi}{n} & \text{n: odd}
                                    \end{cases}
\end{align*}
$$

したがって,

$$
f(x) \sim \frac{\pi}{2} - \sum_{n=1}^\infty \frac{2}{2n}\sin 2nx
$$

{% include plotly/20220818_example_5.html %}

</div>


References
----------
- [Ryo's Tech Blog > フーリエ級数展開の計算例](https://ryonakagami.github.io/2022/08/14/fourier-series-example/)
- [Ryo's Tech Blog > 三角関数と自然対数についての積分](http://localhost:4000/2021/02/16/integral-and-trigonometric-functions/)