---
layout: post
title: "フーリエ級数展開の計算例"
subtitle: "フーリエ解析 3/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-19
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

- [フーリエ級数展開](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E7%B4%9A%E6%95%B0%E5%B1%95%E9%96%8B)
  - [フーリエ係数の公式導出](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E4%BF%82%E6%95%B0%E3%81%AE%E5%85%AC%E5%BC%8F%E5%B0%8E%E5%87%BA)
- [フーリエ級数展開計算例](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E7%B4%9A%E6%95%B0%E5%B1%95%E9%96%8B%E8%A8%88%E7%AE%97%E4%BE%8B)
  - [方形波](#%E6%96%B9%E5%BD%A2%E6%B3%A2)
    - [方形波の振幅とロケールを変換してみる](#%E6%96%B9%E5%BD%A2%E6%B3%A2%E3%81%AE%E6%8C%AF%E5%B9%85%E3%81%A8%E3%83%AD%E3%82%B1%E3%83%BC%E3%83%AB%E3%82%92%E5%A4%89%E6%8F%9B%E3%81%97%E3%81%A6%E3%81%BF%E3%82%8B)
  - [絶対値関数を用いたジグザグ波](#%E7%B5%B6%E5%AF%BE%E5%80%A4%E9%96%A2%E6%95%B0%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%82%B8%E3%82%B0%E3%82%B6%E3%82%B0%E6%B3%A2)
  - [ノコギリ波](#%E3%83%8E%E3%82%B3%E3%82%AE%E3%83%AA%E6%B3%A2)
  - [正弦関数の絶対値変換](#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%B5%B6%E5%AF%BE%E5%80%A4%E5%A4%89%E6%8F%9B)
  - [奇関数$x^3$のフーリエ級数展開](#%E5%A5%87%E9%96%A2%E6%95%B0x%5E3%E3%81%AE%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E7%B4%9A%E6%95%B0%E5%B1%95%E9%96%8B)
- [フーリエ係数の線型性](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E4%BF%82%E6%95%B0%E3%81%AE%E7%B7%9A%E5%9E%8B%E6%80%A7)
- [Appendix: 瞬間部分積分](#appendix-%E7%9E%AC%E9%96%93%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## フーリエ級数展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: フーリエ級数展開</ins></p>

関数$f(x)$を周期$2\pi$の周期関数とする. このとき, 関数$f(x)$が区分的になめらかな連続関数であるとき, $f(x)$はフーリエ級数展開で以下のように表すことができる:

$$
f(x)\sim \frac{a_0}{2} + \sum_{n=1}^\infty(a_n \cos nx + b_n \sin nx)
$$

このときのフーリエ係数は

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{2\pi}_0 f(x) \cos nx dx\\
b_n &= \frac{1}{\pi}\int^{2\pi}_0 f(x) \sin nx dx
\end{align*}
$$

</div>

$\cos nx, \sin nx$の基本周期は$2\pi/n$であるが, 共通に$2\pi$周期をもつのでRHSが収束するならば
LHSも$2\pi$周期をもつことがわかります.

有限項で表せるフーリエ級数展開の例として, 

$$
\begin{align*}
\sin^2 x &= \frac{1 - \cos 2x}{2}\\[3pt]
\cos^2 x &= \frac{1 + \cos 2x}{2}\\[3pt]
\cos^3 x &= \frac{3\cos x + \cos 3x}{4}
\end{align*}
$$

これらはそれぞれフーリエ級数との比較で表すと

$$
\begin{align*}
\sin^2 x &= \frac{1}{2} - \frac{1}{2}\cos 2x\\[3pt]
\cos^2 x &= \frac{1}{2} + \frac{1}{2}\cos 2x\\[3pt]
\cos^3 x &= \frac{3}{4}\cos x + \frac{1}{4}\cos 3x
\end{align*}
$$

### フーリエ係数の公式導出

基本周期$2\pi$の関数$f(x)$が

$$
f(x)\sim \frac{a_0}{2} + \sum_{n=1}^\infty(a_n \cos nx + b_n \sin nx)
$$

と展開できるとします. この式の両辺に関数$\cos mx (m=0,1,2,\cdots)$をかけ, $[0, 2\pi]$区間で積分をする. **積分と和の順序を交換できるとすると**, [三角関数の直交性](https://ryonakagami.github.io/2022/08/13/triangular-functions/)より

$$
\begin{align*}
\int^{2\pi}_0 f(x) \cos mx dx =& \int^{2\pi}_0\frac{a_0}{2}\cos mx\ dx\\[3pt]
                               &+ \sum_{n=1}^\infty\int^{2\pi}_0(a_n \cos nx \cos mx + b_n \sin nx \cos mx)\ dx\\
                               &= a_m\pi
\end{align*}
$$

同様に

$$
\begin{align*}
\int^{2\pi}_0 f(x) \sin mx dx =& \int^{2\pi}_0\frac{a_0}{2}\sin mx\ dx\\[3pt]
                               &+ \sum_{n=1}^\infty\int^{2\pi}_0(a_n \cos nx \sin mx + b_n \sin nx \sin mx)\ dx\\
                               &= b_m\pi
\end{align*}
$$

従って,

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{2\pi}_0 f(x) \cos nx dx\\
b_n &= \frac{1}{\pi}\int^{2\pi}_0 f(x) \sin nx dx
\end{align*}
$$

を得る.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>周期関数の特性</ins></p>

関数$f(x)$を基本周期$2\pi$の周期関数とすると, $f(x)$と$\cos nxm \sin nx$はともに周期$2\pi$の周期関数であるので, その積も周期$2\pi$の関数となります. 従って, 周期関数の特性より

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{2\pi}_0 f(x) \cos nx dx\\
    &= \frac{1}{\pi}\int^{2\pi+c}_c f(x) \cos nx dx
\end{align*}
$$

従って, $c=\pi$として以下のようにフーリエ係数を表記したりする

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} f(x) \cos nx dx\\
b_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} f(x) \sin nx dx
\end{align*}
$$


</div>

## フーリエ級数展開計算例

ここではフーリエ級数展開で表現可能な周期関数の例を紹介します. 有名なところだとノコギリ波や方形波
があります.

- ノコギリ波: テレビのブラウン管に流す電流の波形
- 方形波: コンピューターなどで用いるデジタル信号の基本波形

といわれています.


### 方形波

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題: 方形波</ins></p>

関数

$$
f(x) = \begin{cases}
\displaystyle 1 & (0\leq x < \pi)\\
\displaystyle 0 & (-\pi\leq x < 0)
\end{cases}
$$

を$f(x+2\pi)=f(x)$によって拡張した関数$\tilde f(x)$のフーリエ係数を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答1</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\tilde f(x)$は周期$2\pi$をもつので

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} \tilde f(x) \cos nx dx\\[3pt]
b_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} \tilde f(x) \sin nx dx
\end{align*}
$$

と計算できる

$$
\begin{align*}
a_n &=\frac{1}{\pi}\int^{\pi}_{-\pi} \tilde f(x) \cos nx dx\\[3pt]
    &= \frac{1}{\pi}\left(\int^{\pi}_{0} \cos nx dx\\\right)\\[3pt]
    &= \begin{cases}
    \displaystyle 1&n=0\\[5pt]
    \displaystyle 0& n>1\\
    \end{cases}
\end{align*}
$$

$$
\begin{align*}
b_n &=\frac{1}{\pi}\int^{\pi}_{-\pi} \tilde f(x) \sin nx dx\\[3pt]
    &= \frac{1}{n\pi}\left[-\cos nx\right]^{\pi}_{0}\\[3pt]
    &= \begin{cases}
    \displaystyle \frac{2}{n\pi}&\text{nが奇数}\\[5pt]
    \displaystyle 0& \text{nが偶数}\\
    \end{cases}
\end{align*}
$$


従って,

$$
\begin{align*}
\tilde f(x) \sim \frac{1}{2} + \sum_{n=1}^\infty \frac{2}{\pi(2n-1)}\sin (2n-1)x
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答2</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\tilde f(x)$を$\tilde f(x) = h(x) + g(x)$として

$$
\begin{align*}
h(x)& = \frac{1}{2}\\[3pt]
g(x) &=\begin{cases}
\displaystyle \frac{1}{2} & (0\leq x < \pi)\\[3pt]
\displaystyle -\frac{1}{2} & (-\pi\leq x < 0)
\end{cases}
\end{align*}
$$

と定数関数と奇関数を用いて表現し直します. 

定数関数ののフーリエ係数は$a_0(h) = 1/2$と自明. $g(x)$は奇関数であるので$a_n(g) = 0$であるのは自明.
また, 奇関数と奇関数の積は偶関数であるので

$$
\begin{align*}
b_n(g) &= \frac{1}{\pi}\int^{\pi}_{-\pi}g(x)\sin nx\ dx\\[3pt]
       &= \frac{2}{\pi}\int^{\pi}_{0}g(x)\sin nx\ dx\\[3pt]
       &= -\frac{1}{n\pi}[\cos nx]^\pi_0\\[3pt]
       &= \begin{cases}
    \displaystyle \frac{2}{n\pi}&\text{nが奇数}\\[5pt]
    \displaystyle 0& \text{nが偶数}\\
    \end{cases}

\end{align*}
$$

$$
\begin{align*}
a_n(\tilde f) &= a_n(h) + a_n(g)\\
b_n(\tilde f) &= b_n(h) + b_n(g)
\end{align*}
$$

より

$$
\begin{align*}
\tilde f(x) \sim \frac{1}{2} + \sum_{n=1}^\infty \frac{2}{\pi(2n-1)}\sin (2n-1)x
\end{align*}
$$

</div>

導き出した方形波をPythonでplotしてみる

```python
import plotly.express as px
import numpy as np
from IPython.display import display, HTML
import plotly

plotly.offline.init_notebook_mode()
display(HTML(
    '<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_SVG"></script>'
))

# 定数

def constant_fourier(x, max_n):
    y = 1/2
    term = 1
    while max_n + 1 > term:
        y += 2/(term * np.pi) * np.sin(x*term)
        term += 2

    return y

x = np.linspace(-2*np.pi*1.1, 2*np.pi*1.1, 500)
y, y2, y3 = constant_fourier(x, max_n=10), constant_fourier(x, max_n=40), constant_fourier(x, max_n=1000)


fig = px.line(x=x, y=[y, y2, y3], 
              render_mode='SVG', 
              title='周期関数に対するフーリエ級数展開例<br><sup>opacity=.6 , n = 10, 40, 1000</sup>',
              )
newnames = {'wide_variable_0':'n=10', 
            'wide_variable_1':'n=40',
            'wide_variable_2':'n=1000'}
fig.update_traces(opacity=.8)
fig.for_each_trace(lambda t: t.update(name = newnames[t.name],
                                      legendgroup = newnames[t.name],
                                      hovertemplate = t.hovertemplate.replace(t.name, newnames[t.name])
                                     )
                  )
fig.update_xaxes(tickangle=0,
                 tickmode = 'array',
                 tickvals = [-2*np.pi, -3/2*np.pi, -np.pi, -1/2*np.pi, 
                             0, 1/2*np.pi, np.pi, 3/2*np.pi, 2*np.pi],
                 ticktext=['$-2\pi$', '', '$-\pi$', '', '0', '', '$\pi$', '', '$2\pi$'])
fig.show()
```

{% include plotly/20220814_houkeiha.html%}

#### 方形波の振幅とロケールを変換してみる

$$
\begin{align*}
\tilde f(x) \sim \frac{1}{2} + \sum_{n=1}^\infty \frac{2}{\pi(2n-1)}\sin (2n-1)x
\end{align*}
$$

に対して, 係数を2倍にすれば

$$
g_1(x) = \begin{cases}
\displaystyle 2 & (0\leq x < \pi)\\
\displaystyle 0 & (-\pi\leq x < 0)
\end{cases}
$$

が表現できることは直感的にわかります. さらに$-1$を加えることによって

$$
g_2(x) = \begin{cases}
\displaystyle 1 & (0\leq x < \pi)\\
\displaystyle -1 & (-\pi\leq x < 0)
\end{cases}
$$

が表現できるはずです. このときのフーリエ級数展開を

$$
\begin{align*}
\tilde g_2(x) \sim \sum_{n=1}^\infty \frac{4}{\pi(2n-1)}\sin (2n-1)x
\end{align*}
$$

して, Pythonで可視化してみると

{% include plotly/20220814_houkeiha_2.html%}

上手くいっていることが確認できます. $g_2(x)$は奇関数ですが, フーリエ級数展開後も正弦関数のみで表現されていることから確からしさがわかります.

### 絶対値関数を用いたジグザグ波

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題: ジグザグ波</ins></p>

関数

$$
f(x) = \vert x\vert \qquad (-\pi\leq x < \pi)
$$

を$f(x+2\pi)=f(x)$によって拡張した関数$\tilde f(x)$のフーリエ係数を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$f(x)$は偶関数なので, 余弦展開のみで十分であることがわかる. 従って,

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^\pi_{-\pi}\vert x\vert \cos nx\ dx\\[3pt]
    &= \frac{2}{\pi}\int^\pi_{0}x \cos nx\ dx
\end{align*}
$$

$n=0$のとき

$$
a_0 = \frac{2}{\pi}\int^\pi_{0}x \ dx = \pi
$$

また, $n > 0$のときは

$$
\begin{align*}
a_n &= \frac{2}{\pi}\int^\pi_{0}x \cos nx\ dx\\[3pt]
    &= \frac{2}{\pi}\left\{\frac{1}{n}[x\sin nx]^\pi_0 - \int^\pi_0 \frac{1}{n}\sin nx\ dx\right\}\\[3pt]
    &= \frac{2}{\pi}\left\{\frac{1}{n}[x\sin nx]^\pi_0 + \frac{1}{n^2}[\cos nx]^\pi_0\right\}\\[3pt]
    &= \begin{cases}
        \displaystyle 0 & n: \text{even} \\[3pt]
        \displaystyle -\frac{4}{n^2\pi}& n: \text{odd} 
        \end{cases}
\end{align*}
$$

従って, 

$$
\tilde f(x)\sim \frac{\pi}{2} - \sum_{n=1}^\infty \frac{4}{(2n-1)^2\pi}\cos(2n-1)x 
$$

{% include plotly/20220814_zigzag.html %}

</div>

### ノコギリ波

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題: ノコギリ波</ins></p>

関数

$$
f(x) = x \qquad (-\pi\leq x < \pi)
$$

を$f(x+2\pi)=f(x)$によって拡張した関数$\tilde f(x)$のフーリエ係数を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\tilde f(x)$は奇関数であるので正弦展開だけで十分であることがわかる. 

$$
\begin{align*}
b_n &= \frac{1}{\pi}\int^\pi_{-\pi}x\sin nx \ dx\\[3pt]
    &= \frac{2}{\pi}\int^\pi_{0}x\sin nx \ dx\\[3pt]
    &= \frac{2}{\pi n}\left([x\cos nx]^\pi_0 + \int^\pi_{0}\cos nx \ dx\right)\\[3pt]
    &= \frac{2(-1)^{n+1}}{n}
\end{align*}
$$

従って, 

$$
\tilde f(x)\sim 2\sum^\infty_{n=1}\frac{(-1)^{n+1}}{n}\sin nx
$$

{% include plotly/20220814_nokogiri.html %}


</div>

### 正弦関数の絶対値変換

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題: ノコギリ波</ins></p>

関数

$$
f(x) = \vert\sin x\vert
$$
のフーリエ係数を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$f(x)$は偶関数なので余弦展開のみで十分である.

従って,

$$
\begin{align*}
a_0 &= \frac{1}{\pi}\int^\pi_{-\pi} \vert\sin x\vert dx \\[3pt]
    &=  \frac{2}{\pi}\int^\pi_{0} \sin x dx \\[3pt]
    &= \frac{2}{\pi} [-\cos x]^\pi_{0}\\[3pt]
    &= \frac{4}{\pi}
\end{align*}
$$

また, $n > 0$に対して

$$
\begin{align*}
a_n &= \frac{2}{\pi}\int^\pi_{0} \sin x \cos nx dx \\[3pt]
    &= \frac{2}{2\pi}\int^\pi_{0} (\sin(n+1)x + \sin(1-n)x)\ dx\\[3pt]
    &= \frac{1}{\pi}\left\{\left[\frac{-1}{n+1}\cos(n+1)x\right]^\pi_0 - \left[\frac{1}{1-n}\cos(1-n)x\right]^\pi_0\right\}\\[3pt]
    &=
    \begin{cases}
    \displaystyle 0 & n:\text{odd}\\[3pt]
    \displaystyle \frac{-4}{\pi(n^2-1)} & n:\text{even}
    \end{cases}
\end{align*}
$$

従って, 

$$
f(x)\sim \frac{2}{\pi} - \sum_{n=1}^\infty \frac{4}{\pi(4n^2 - 1)}\cos 2n x
$$

{% include plotly/20220814_sine_abs.html %}

</div>

### 奇関数$x^3$のフーリエ級数展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>例題</ins></p>

関数

$$
f(x) = x^3 \qquad (-\pi \leq x < x)
$$

を$f(x+2\pi)=\tilde f(x)$によって周期的に拡張した関数のフーリエ係数を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\tilde f(x)$は奇関数なので正弦展開のみで十分である. 従って

$$
\begin{align*}
b_n &= \frac{1}{\pi}\int^\pi_{-\pi} x^3 \sin nx\ dx\\[3pt]
    &= \frac{2}{\pi}\int^\pi_{0} x^3 \sin nx\ dx \qquad \because\text{奇関数同士の積は偶関数なので}
\end{align*}
$$

$\int^\pi_{0} x^3 \sin nx\ dx$は$x^3$が４回微分すると0になるので

|符号|$f(x)$|$g(x)$|
|---|---|---|
|$+$|$x^3$|$-\frac{1}{n}\cos nx$|
|$-$|$3x^2$|$-\frac{1}{n^2}\sin nx$|
|$+$|$6x$|$\frac{1}{n^3}\cos nx$|
|$-$|$6$|$-\frac{1}{n^4}\sin nx$|

このとき, $[0, \pi]$区間で積分するので２行目と４行目は0とわかる. 従って,

$$
b_n = (-1)^{n+1}\left(\frac{2\pi^2}{n}-\frac{12}{n^3}\right)
$$

よって,

$$
\tilde f(x) \sim \sum_{n=1}^\infty (-1)^{n+1}\left(\frac{2\pi^2}{n}-\frac{12}{n^3}\right) \sin nx
$$


{% include plotly/20220814_function_x.html %}

</div>


## フーリエ係数の線型性

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property: フーリエ係数の線型性</ins></p>

周期$2\pi$の周期関数$f(x), g(x)$のフーリエ係数をそれぞれ$a_n(f), b_n(f), a_n(g), b_n(g)$とする.
このとき, $c, d$を定数とするとき

$$
h(x) = cf(x) + dg(x)
$$

のフーリエ係数について

$$
\begin{align*}
a_n(h) &= ca_n(f) + da_n(g)\\
b_n(h) &= cb_n(f) + db_n(g)
\end{align*}
$$

が成立する.

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Example</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

$$
f(x) = \begin{cases}
\displaystyle x & (0 \leq x < \pi)\\[3pt]
\displaystyle 0 & (-\pi \leq x < 0)
\end{cases}
$$

という関数を$f(x + 2\pi)=f(x)$と周期的に拡張した関数$\tilde f(x)$を考えます.
フーリエ係数$a_n, b_n$をもとめるとき, 普通に解くと

$$
\begin{align*}
a_0 &= \frac{1}{\pi}\int^{\pi}_{-\pi} f(x)\ dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi}_{0} x\ dx\\[3pt]
    &= \frac{\pi}{2}\\
\\
a_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} f(x)\cos nx\ dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi}_{0} x\cos nx\ dx\\[3pt]
    &= \frac{1}{\pi}\left[\frac{1}{n}x \sin nx + \frac{1}{n^2}\cos nx\right]^\pi_0\\
    &= \begin{cases}
        \displaystyle 0 & n:\text{even}\\[3pt]
        \displaystyle \frac{-2}{n^2\pi} & n:\text{odd}
    \end{cases}\\
    \\
b_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} f(x)\sin nx\ dx\\[3pt]
    &= \frac{1}{\pi}\int^{\pi}_{0} x\sin nx\ dx\\[3pt]
    &= \frac{1}{\pi}\left[-\frac{1}{n}x \cos nx + \frac{1}{n^2}\sin nx\right]^\pi_0\\
    &= \frac{(-1)^{n+1}}{n} \\[3pt]
\end{align*}
$$

従って,

$$
\tilde f(x)\sim \frac{\pi}{4} - \sum_{n=1}^\infty \frac{2}{(2n-1)^2\pi}\cos (2n-1)x + \sum^\infty_{n=1}\frac{(-1)^{n+1}}{n} \sin nx   
$$


ここで, $f(x)$がノコギリ波とジグザグ波を足し合わせたものを2で割ったことに注目します. すなわち

$$
\begin{align*}
g(x) &= \vert x\vert \qquad (-\pi\leq x < \pi)\\[3pt]
h(x) &= x \qquad (-\pi\leq x < \pi)\\[3pt]
f(x) &= \frac{g(x) + h(x)}{2}
\end{align*}
$$

$\tilde g(x), \tilde h(x)$をそれぞれ$2\pi$周期的に拡張した関数とすると

$$
\begin{align*}
\tilde g(x)&\sim \frac{\pi}{2} - \sum_{n=1}^\infty \frac{4}{(2n-1)^2\pi}\cos(2n-1)x \\[3pt]
\tilde h(x)&\sim 2\sum^\infty_{n=1}\frac{(-1)^{n+1}}{n}\sin nx
\end{align*}
$$

すると

$$
\begin{align*}
&\frac{\tilde g(x) + \tilde h(x)}{2} \\[3pt]
&= \frac{\pi}{4} - \sum_{n=1}^\infty \frac{2}{(2n-1)^2\pi}\cos(2n-1)x + \sum^\infty_{n=1}\frac{(-1)^{n+1}}{n}\sin nx
\end{align*}
$$

これは上で求めた$\tilde f(x)$のフーリエ係数と一致することがわかる.

</div>



## Appendix: 瞬間部分積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 瞬間部分積分</ins></p>

複数回微分可能な関数$f(x), g(x)$が与えられ, $f(x)$は何回か微分すると0になるとします.
このとき２つの関数の積の積分

$$
\int f(x)g(x)\ dx 
$$

は次の手順で計算することができる.

1. ３列の表をつくる
2. ２列目に上から $f(x), f^\prime(x), f^{\prime\prime}(x), \cdots$と0になる手前まで格納する
3. ３列目に上から$g$の積分, $g$の二回積分, $\cdots$, と手順２と同じ回数まで格納する
4. １列目に上から$+, -, +, \cdots$と交互に格納する
5. ２列目と３列目の項を掛けて, 縦に１列目の符号を維持しながら足す

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >example</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\int(x^3+x)\cos x\ dx
$$

を瞬間部分積分で計算すると, $x^3+x$は４回微分すると0になるので

|符号|$f(x)$|$g(x)$|
|---|---|---|
|$+$|$(x^3+x)$|$\sin x$|
|$-$|$(3x^2+1)$|$-\cos x$|
|$+$|$6x$|$-\sin x$|
|$-$|$6$|$\cos x$|

従って,

$$
\begin{align*}
&\int(x^3+x)\cos x\ dx\\
&= (x^3+x)\sin x + (3x^2+1)\cos x - 6x \sin x - 6\cos x + C\\
&= (x^3-5x)\sin x + (3x^2-5)\cos x + C
\end{align*}
$$

</div>



References
-----------
- [Ryo's Tech Blog > 三角関数系の直交性](https://ryonakagami.github.io/2022/08/13/triangular-functions/)
- [フーリエ解析（理工系の数学入門コース［新装版］）](https://pro.kinokuniya.co.jp/search_detail/product?ServiceCode=1.0&UserID=PLATON&isbn=9784000298889&lang=en-US&search_detail_called=1&table_kbn=A%2CE%2CF)
- [高校数学の美しい物語 > 瞬間部分積分のやり方と例題２問](https://manabitimes.jp/math/823)