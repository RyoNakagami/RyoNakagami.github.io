---
layout: post
title: "退化分布: degenerate distribution"
subtitle: "確率分布 1/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-19
header-mask: 0.0
header-style: text
tags:

- 統計
- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [退化分布](#%E9%80%80%E5%8C%96%E5%88%86%E5%B8%83)
  - [密度関数と累積分布関数](#%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%A8%E7%B4%AF%E7%A9%8D%E5%88%86%E5%B8%83%E9%96%A2%E6%95%B0)
  - [退化分布の平均, 分散, 特性関数](#%E9%80%80%E5%8C%96%E5%88%86%E5%B8%83%E3%81%AE%E5%B9%B3%E5%9D%87-%E5%88%86%E6%95%A3-%E7%89%B9%E6%80%A7%E9%96%A2%E6%95%B0)
- [分布収束と退化分布](#%E5%88%86%E5%B8%83%E5%8F%8E%E6%9D%9F%E3%81%A8%E9%80%80%E5%8C%96%E5%88%86%E5%B8%83)
  - [例: 一様分布 to 退化分布 or 指数分布](#%E4%BE%8B-%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83-to-%E9%80%80%E5%8C%96%E5%88%86%E5%B8%83-or-%E6%8C%87%E6%95%B0%E5%88%86%E5%B8%83)
- [Appendix: ディラックのデルタ関数の性質](#appendix-%E3%83%87%E3%82%A3%E3%83%A9%E3%83%83%E3%82%AF%E3%81%AE%E3%83%87%E3%83%AB%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 退化分布

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 退化分布</ins></p>

退化分布 $\text{Deg}(c), \ \ c\in\mathbb R$は確率的ゆらぎがなくランダムサンプリングされた値がいつも
定数$c$になる確率分布を表す

確率密度関数はディラックのデルタ関数を用いて以下のように表せる

$$
\begin{align*}
&f_X(x) = \delta(x-c)\\
&\delta(x) = 
\begin{cases}
0 & \text{if } x\neq 0\\
\infty & \text{ if} x = 0
\end{cases}
\end{align*}
$$

</div>

ディラックのデルタ関数は一様分布 $\text{Unif(a, b)}, c \in (a, b)$や正規分布$N(c, \delta^2)$の幅が0になる極限で得られる関数に近似したものと考えることができます. つまり,

$$
\begin{align*}
\delta(x - c) &= \lim_{\theta\to 0}\text{p.d.f of Unif}(c-\theta/2, c+\theta/2)\\[3pt]
\delta(x - c) &= \lim_{\theta\to 0}\frac{1}{\sqrt{2\pi\theta^2}}\exp\left(-\frac{(x-c)^2}{2\theta^2}\right)
\end{align*}
$$

上記のとき, $\theta\to0$の極限で, 確率密度が１箇所に集中するのでその点で確率密度関数の値は無限大に近づきます.

### 密度関数と累積分布関数

$f_X(x)$をp.d.fとする連続確率変数$X$について

$$
\int_{-\infty}^{\infty} f_X(u)du=1
$$

を満たす必要がありますが退化分布もこれを満たします. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property</ins></p>

退化分布 $\text{Deg}(c), \ \ c\in\mathbb R$があたえられたとき

$$
\int_{-\infty}^{\infty} \delta(x-c)dx=1
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

ディラックのデルタ関数を一様分布の極限と表せるとします, i.e., 

$$
\delta(x-c) = \lim_{\epsilon \to 0} f_\epsilon(x)
$$

where:

$$
\begin{align*}
f_\epsilon(x) &= 
\begin{cases}
\frac{1}{\epsilon}&: x\in [c-\epsilon/2,c+\epsilon/2]\\[3pt]
0 &: \text{ otherwise}
\end{cases}
\end{align*}
$$

このとき, 

$$
\begin{align*}
\int_{-\infty}^\infty f_\epsilon(x)dx &= \int_{c-\epsilon/2}^{c+\epsilon/2}\frac{1}{\epsilon}dx + \int_{c+\epsilon/2}^\infty 0 dx + \int_\infty^{c-\epsilon/2} 0dx\\[3pt]
&= \frac{1}{\epsilon}\epsilon + 0 + 0\\
&= 1
\end{align*}
$$

従って,

$$
\begin{align*}
\int_{-\infty}^{\infty} \delta(x-c)dx &= \lim_{\epsilon\to0}\int_{-\infty}^\infty f_\epsilon(x)dx\\[3pt]
&= \lim_{\epsilon\to0} 1 \\
&= 1
\end{align*}
$$

</div>


なお, ディラックのデルタ関数はデルタ超関数ともよばれており, 通常の関数とは少し違うものです. 

例えば, $\delta(x)$ が連続関数だったとして $x = 0$ でゼロでない値をとるならば $x = 0$ を含む小区間で非ゼロでなければならず, $x\neq 0$ で $\delta(x) = 0$ という条件を満たせない. したがって $x \neq 0$ で $\delta(x) = 0$ ならばそれは常に 0 の値をとる関数であり, 他の関数と掛けて積分しても 0 以外の値をとることはない. 

点 $x = 0$ においてのみ不連続であることを認めても, デルタ関数の特徴付けに用いられている積分が, 通常の関数の（広義）リーマン積分やルベーグ積分として理解されるならば, このような関数の積分は恒等的に 0 に等しい関数を積分するのと同じであり積分値は 0 になる. したがって,このような条件を満たすような通常の関数は存在しないことがわかります. 



<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property: 累積分布関数</ins></p>

p.d.fを$(-\infty, x)$の範囲で積分するとc.d.f $F_X(x)$が得られるが, 退化分布 $\text{Deg}(c)$のc.d.fは

$$
\begin{align*}
F_X(x) &= \int^x_{-\infty}f_X(t)dt\\[3pt]
       &= 
       \begin{cases}
        1 &\text{if } x\geq c\\[3pt]
        0 &\text{if } x < c
       \end{cases}
\end{align*}
$$

</div>


### 退化分布の平均, 分散, 特性関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property</ins></p>

退化分布の平均, 分散, 特性関数は以下のように表せる

$$
\begin{align*}
\mathbb E[X] &= \int_{-\infty}^{\infty} x\delta(x-c)dx = c\\[3pt]
\text{Var}(x) &= \int_{-\infty}^{\infty} (x-c)^2\delta(x-c)dx = 0\\[3pt]
\phi_X(t) &= \int_{-\infty}^{\infty} \exp(itx)delta(x-c)dx = \exp(itc)
\end{align*}
$$

</div>

これらはディラックのデルタ関数の性質の一つである

$$
\int_{-\infty}^{\infty} g(x)\delta(x-c)dx = g(c)
$$

から導出することができます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

$g$を実数上で定義された連続関数とするとき

$$
\int_{-\infty}^{\infty} g(x)\delta(x-c)dx = g(c)
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

ディラックのデルタ関数を一様分布の極限と表せるとします, i.e., 

$$
\delta(x-c) = \lim_{\epsilon \to 0} f_\epsilon(x)
$$

where:

$$
\begin{align*}
f_\epsilon(x) &= 
\begin{cases}
\frac{1}{\epsilon}&: x\in [c-\epsilon/2,c+\epsilon/2]\\[3pt]
0 &: \text{ otherwise}
\end{cases}
\end{align*}
$$

このとき

$$
\begin{align*}
\int_{-\infty}^\infty g(x)f_\epsilon(x)dx
    = \int_{c-\epsilon/2}^{c+\epsilon/2}g(x)\frac{1}{\epsilon}dx
\end{align*}
$$

Darbouxの定理より

$$
m((c+\epsilon/2)-(c-\epsilon/2)) \leq \int_{c-\epsilon/2}^{c+\epsilon/2}g(x)dx \leq M((c+\epsilon/2)-(c-\epsilon/2))
$$

where:

- $M$: the maximum of $g(x)$ on $[c-\epsilon/2, c+\epsilon/2]$
- $m$: the minimum of $g(x)$ on $[c-\epsilon/2, c+\epsilon/2]$

従って, 

$$
\begin{align*}
&m\epsilon\leq \int_{c-\epsilon/2}^{c+\epsilon/2}g(x)dx \leq M\epsilon\\
&\Rightarrow m\leq \frac{1}{\epsilon}\int_{c-\epsilon/2}^{c+\epsilon/2}g(x)dx \leq M
\end{align*}
$$

また,

$$
\lim_{\epsilon\to0}M = \lim_{\epsilon\to0}m = g(c)
$$

より, 挟み撃ちの定理を用いて

$$
\lim_{\epsilon\to0}\int_{-\infty}^\infty g(x)f_\epsilon(x)dx = g(c)
$$

従って, 

$$
\begin{align*}
g(c) &= \lim_{\epsilon\to0}\int_{-\infty}^\infty g(x)f_\epsilon(x)dx\\[3pt]
     &= \int_{-\infty}^{\infty} g(x)\delta(x-c)dx
\end{align*}
$$

</div>

## 分布収束と退化分布

議論の前に確率収束と分布収束について振り返ります

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 確率収束(convergence in probability)</ins></p>

$\{X_n\}$ : 確率変数列, $\theta$: 定数とする

$$
\forall \epsilon > 0 \lim_{n\to\infty}\Pr(\vert X_n - \theta\vert > \epsilon) = 0
$$

が成り立つとき, $\{X_n\}$は$\theta$に確率収束するという, i.e.,

$$
X_n \xrightarrow{p} \theta
$$

<p class="h4"><ins>Def: 分布収束(convergence in distribution)</ins></p>

- $F_n$: 確率変数 $X_n$ の分布関数 $(n=1,2,\cdots)$
- $F$: 確率変数$ X$ の分布関数

$F$の任意の連続点$x$で

$$
\lim_{n\to\infty} F_n(x) = F(x)
$$

が成り立つとき, $X_n$は$X$に分布収束という.

</div>

とくに収束先が退化分布のときは以下のことが知られています.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 退化分布収束と確率収束</ins></p>

確率変数列 $X_1 , X_2 , \cdots$ が 退化分布$\text{Deg}(c)$に分布収束するとき, $X_n$は$c$に確率収束する, i.e.,

$$
X_n \xrightarrow{p} c
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$X_n$の分布関数を$F_n$としたとき, 仮定より

$$
\lim_{n\to\infty} F_n \xrightarrow{d} \text{Deg}(c)
$$

このとき, 任意の実数$\epsilon > 0$について

$$
\begin{align*}
\Pr(\vert X_n - c\vert \leq \epsilon) 
&\geq \Pr(c-\epsilon < X_n \leq c+\epsilon)\\
&= F_n(c + \epsilon) - F_n(c - \epsilon) 
\end{align*}
$$

これに対して$n\to\infty$の極限をとると

$$
\begin{align*}
&\lim_{n\to\infty}\Pr(\vert X_n - c\vert \leq \epsilon) \geq F(c + \epsilon) - F(c - \epsilon) = 1\\
&\Rightarrow \lim_{n\to\infty}\Pr(\vert X_n - c\vert > \epsilon) = 0
\end{align*}
$$

従って, $X_n$は$c$に確率収束する


</div>


### 例: 一様分布 to 退化分布 or 指数分布

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition</ins></p>

$\{X_n\}$: 互いに独立に$U(0, 1)$に従う確率変数列とする

$$
U_n = \max_{i\geq n} X_i
$$

このとき$U_n$は退化分布$\text{Deg}(1)$に分布収束する.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$U_n$の分布関数は以下のように表せる

<div class="math display" style="overflow: auto">
$$
\begin{align*}
F_n(u) &= \Pr(U_n \leq u)\\[3pt]
       &= \Pr(X_1 \leq u, \cdots, X_n\leq u)\\[3pt]
       &= \prod_{i=1}^n \Pr(X_i\leq u)= 
\begin{cases}
0 &\text{if }  u\leq 0\\
u^n &\text{if }  0 < u < 1\\
1 &\text{if }  u \geq 1
\end{cases}
\end{align*}
$$
</div>

従って,

$$
\lim_{n\to\infty}F_n(u) = \text{Deg}(1) = \begin{cases}0 &\text{if }  u\leq 1\\
1 &\text{if }  u \geq 1
\end{cases}
$$

</div>

$U_n$は$\text{Deg}(1)$に分布収束することがわかったが, $U_n$を用いて別の分布への分布収束を考えることができます.

$$
W_n = n(1 - U_n)
$$

と確率変数を定義すると, この$W_n$の分布関数$G_n(w)$は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
G_n(w) &= \Pr(W_n \leq w)\\[3pt]
       &= \Pr(n(1 - U_n) \leq w)\\[3pt]
       &= \Pr(U_n \geq (1-w/n))\\[3pt]
       &= 1 - F_n(1-w/n)\\[3pt]
       &= 
\begin{cases}
    0 &\text{if }  w\leq 0\\
    1 - (1-1/n)^n &\text{if }  0 < w < n\\
    1 &\text{if }  w \geq n
\end{cases}
\end{align*}
$$
</div>

従って,

$$
\lim_{n\to\infty}G_n(w) = \begin{cases} 0 & w < 0 \\ 1 - \exp(-w) & w > 0 \end{cases}
$$

$W_n$は平均1をもつ指数分布$\text{Ex}(1)$の分布関数に分布収束することがわかる.

Pythonで検証してみても$\text{Ex}(1)$のdensity functionとfitは結構良いです

{% include plotly/20200901_exponentialdist.html %}

```python
import numpy as np
import plotly.graph_objects as go
from scipy.stats import expon

from IPython.display import display, HTML
import plotly
## Tomas Mazak's workaround
plotly.offline.init_notebook_mode()
display(HTML(
    '<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_SVG"></script>'
))

def gen_exp_seq(unif_shape:tuple=(10000, 100000)):
    x = np.random.uniform(0, 1, unif_shape)
    exp_x = unif_shape[1] * (1 - np.max(x, axis =1))
    return exp_x

#---------------------------------------
# simulation
#---------------------------------------
np.random.seed(42)

x = gen_exp_seq()
support = np.linspace(0, max(x), 100)
true_density = expon.pdf(support)

binsize= 200
fig = go.Figure()
fig.add_trace(go.Histogram(x=x, 
                           nbinsx=binsize,
                           name='simulated',
                           histnorm='probability'))
fig.add_trace(go.Scatter(x=support, 
                         y=true_density/20,
                         mode='lines', 
                         name='density function'))
fig.update_layout(title='10000 samples simulated from 100000 uniform variables')
fig.show()
```

なお, こんなややこしいことしなくても $X\sim U(0, 1)$ に対して

$$
Y = -\frac{\log X}{\lambda} \ \ \text{ where } \lambda > 0
$$

とすると, yの定義域が$(0, \infty)$となり, また

$$
\begin{align*}
x & = \exp(-\lambda y) \\
dx &= -\lambda \exp(-\lambda y)dy
\end{align*}
$$

従って, $Y$の確率密度関数 $f$は

$$
\begin{align*}
f(y) &= 1 \cdot \vert -\lambda \exp(-\lambda y)\vert \\
     &= \lambda \exp(-\lambda y) 
\end{align*}
$$

よって, $Y$は指数分布に従うことがわかる.


## Appendix: ディラックのデルタ関数の性質

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property</ins></p>

任意の実関数$f(x)$について

$$
\int^\infty_{-\infty}f(x)\delta(x)dx=f(0)
$$

をみたす$\delta(x)$をディラックのデルタ関数としたとき, $a\neq 0$について

$$
\delta(ax) = \frac{1}{\vert a\vert}\delta(x)
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

- $a>0$のケース
- $a<0$のケース

についてそれぞれ考え, $\delta(ax) = \frac{1}{\vert a\vert}\delta(x)$となることを示します

> (1) $a>0$としたとき

$y = ax$と変換すると, $dy = adx$なので

$$
\begin{align*}
\int^\infty_{-\infty}f(x)\delta(ax)dx
    &= \int^\infty_{-\infty}f(a^{-1}y)\delta(y)a^{-1}dy\\
    &= a^{-1}f(0)
\end{align*}
$$

従って,

$$
\begin{align*}
&\frac{1}{a}\int^\infty_{-\infty}f(x)\delta(x)dx = \int^\infty_{-\infty}f(x)\delta(ax)dx\\[3pt]
&\Rightarrow \delta(ax) = \frac{1}{\vert a\vert}\delta(x)
\end{align*}
$$

> (2) $a<0$としたとき

(1)にならい$y = ax$と変換すると, $dy = adx$なので, 積分区間が逆転することに留意すると

$$
\begin{align*}
\int^\infty_{-\infty}f(x)\delta(ax)dx
    &= \int_\infty^{-\infty}f(a^{-1}y)\delta(y)a^{-1}dy\\
    &= \int^\infty_{-\infty}f(a^{-1}y)\delta(y)\vert a^{-1}\vert dy\\
    &= \vert a^{-1}\vert f(0)
\end{align*}
$$

従って, 

$$
\delta(ax) = \frac{1}{\vert a\vert}\delta(x)
$$

</div>





References
----------
- [Integral to Infinity of Dirac Delta Function](https://proofwiki.org/wiki/Integral_to_Infinity_of_Dirac_Delta_Function#google_vignette)
- [Integral to Infinity of Shifted Dirac Delta Function by Continuous Function](https://proofwiki.org/wiki/Integral_to_Infinity_of_Shifted_Dirac_Delta_Function_by_Continuous_Function)
- [Probability Density Function (PDF)](https://www.probabilitycourse.com/chapter4/4_1_1_pdf.php)
