---
layout: post
title: "定積分の漸化式とベータ関数"
subtitle: "統計のための数学 2/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-25
header-mask: 0.0
header-style: text
tags:

- math
- 統計

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
https://ryonakagami.github.io/2021/04/21/variable-transformation/
<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [パラメーターが整数のときのベータ関数の導出](#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%8C%E6%95%B4%E6%95%B0%E3%81%AE%E3%81%A8%E3%81%8D%E3%81%AE%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
    - [ガンマ関数の性質](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [定積分の漸化式を用いたベータ関数の導出](#%E5%AE%9A%E7%A9%8D%E5%88%86%E3%81%AE%E6%BC%B8%E5%8C%96%E5%BC%8F%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [ベータ関数の性質](#%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [ベータ関数とガンマ関数](#%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%A8%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0)
- [パラメーターが正の実数のときのベータ関数とガンマ関数の対応](#%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%8C%E6%AD%A3%E3%81%AE%E5%AE%9F%E6%95%B0%E3%81%AE%E3%81%A8%E3%81%8D%E3%81%AE%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%A8%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E5%AF%BE%E5%BF%9C)
  - [引数の交換性](#%E5%BC%95%E6%95%B0%E3%81%AE%E4%BA%A4%E6%8F%9B%E6%80%A7)
  - [三角関数とベータ関数の性質](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%A8%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [ベータ関数とガンマ関数](#%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%81%A8%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0-1)
- [Appendix](#appendix)
  - [ガンマ関数の作図](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E4%BD%9C%E5%9B%B3)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## パラメーターが整数のときのベータ関数の導出

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ベータ関数</ins></p>
https://ryonakagami.github.io/2021/04/21/variable-transformation/
ベータ関数 $\beta(s, t), s> 0, t > 0$は以下のように定義される

$$
\beta(s, t) = \int^1_0 x^{s-1}(1-x)^{t-1}dx
$$

また, ベータ関数はガンマ関数を用いて以下のように表せる

$$
\beta(s, t) = \frac{\Gamma(s+t)}{\Gamma(s)\Gamma(t)}
$$

</div>

このベータ関数はベータ分布やベイズ推論における事前分布として用いられる重要な関数です. 
この導出は高校数学の範囲でできるので確認してみます.
#### ガンマ関数の性質
### 定積分の漸化式を用いたベータ関数の導出

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

以下を示せ:

$$
\int^b_a(x-a)^m(b-x)^ndx = \frac{m!n!}{m+n+1}(b-a)^{m+n+1}
$$

ただし, $m, n$は正の整数とする.

</div>

$$
I(m, n) = \int^b_a(x-a)^m(b-x)^ndx
$$

とまず定義します. すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
I(m, n) &= \int^b_a(x-a)^m(b-x)^ndx\\[3pt]
        &= \bigg[\frac{1}{m+1}(x-a)^{m+1}(b-x)^n\bigg]^b_a + \frac{n}{m+1}\int^b_a(x-a)^{m+1}(b-x)^{n-1}dx\\[3pt]
        &= \frac{n}{m+1}I(m+1, n-1)
\end{align*}
$$
</div>

漸化式っぽい形が得られたので

$$
\begin{align*}
I(m, n) &=\frac{n}{m+1}I(m+1, n-1) \\[3pt]
        &=\frac{n}{m+1}\frac{n(n-1)}{(m+1)(m+2)}I(m+2, n-2) \\[3pt]
        &=\frac{n}{m+1}\frac{n(n-1)\cdots 1}{(m+1)(m+2)\cdots(m+n)}I(m+n, 0)
\end{align*}
$$

$$
I(m+n, 0) = \int^b_a(x-a)^{m+n}(b-x)^0dx = \frac{1}{m+n+1}(b-a)^{m+n+1}
$$

は明らかなので

$$
I(m, n) = \frac{n!m!}{(m+n+1)!}(b-a)^{m+n+1}
$$

### ベータ関数の性質

ベータ関数は上記の関数の$a=0, b=1$という特殊なときなので

$$
\beta(s, t) = \frac{(s-1)!(t-1)!定積分の漸化式を用いた}{(s+t-1)!}
$$

とわかる. また, 上記の式より$s, t$が整数ならば

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\beta(s, t) &= \frac{(s-1)!(t-1)!}{(s+t-1)!}\\[3pt]
            &= \frac{(t-1)!(s-1)!}{(s+t-1)!}\\[3pt]
            &= \beta(t, s)
\end{align*}
$$
</div>

となり, $\beta(s, t) = \beta(t, s)$が成立することがわかる.

### ベータ関数とガンマ関数

ベータ関数はガンマ関数を組み合わせて表現することもできます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ガンマ関数</ins></p>

正の実数 $x$に対して

$$
\Gamma(x) = \int^\infty_0t^{x-1}\exp(-t)dt
$$

をガンマ関数と呼ぶ.

</div>


{% include plotly/20210130_gamma.html %}

- ガンマ関数をplotすると上記のように$x\in(1,2)$の間で極小値をとり, そこから$x$がふえると爆発的に増えます
- 厳密に極値を求めるのはこんなんですが, 数値計算では$x=1.46, \Gamma(1.46...)=0.8856$近辺で極小値となります

ガンマ関数は階乗の一般化という性質があり, これを用いるとベータ関数との関係がわかりやすくなります


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>ガンマ関数の性質</ins></p>

任意の正の整数 $n$ について

$$
\Gamma(n+1) = n!
$$

</div>

この性質を用いると, 

$$
\beta(t, s) = \frac{\Gamma(t)\Gamma(s)}{\Gamma(s+t)}
$$

であることが上記と照らし合わせてすぐわかります.


## パラメーターが正の実数のときのベータ関数とガンマ関数の対応

これまでは正の整数空間を想定してベータ関数の性質を確認してきました. 
ここでは正の実数空間を対象にベータ関数の性質を考えていきます.

### 引数の交換性

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

正の実数$s, t > 0$について以下が成立する

$$
\beta(s, t) = \beta(t, s) 
$$

</div>

$z = 1-u$を用いた置換積分をすると以下のように示せます

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\beta(s, t) &= \int^1_0 z^{s-1}(1-z)^{t-1}dz\\
            &= \int^1_0 (1-u)^{s-1}u^{t-1}du\\
            &= \beta(t, s)
\end{align*}
$$
</div>


### 三角関数とベータ関数の性質

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

正の実数$s, t > 0$について以下が成立する

$$
\beta(s, t) = 2\int^{\pi/2}_0\cos^{2s-1}\theta\sin^{2t-1}\theta d\theta
$$

</div>

これも$z = \cos^2\theta$を用いた置換積分で示せます

$$
\frac{\partial \cos^2\theta}{\partial \theta} = -2\cos\theta\sin\theta
$$

に留意すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\beta(s, t) &= \int^1_0 z^{s-1}(1-z)^{t-1}dz\\[3pt]
            &= -2\int^0_{\pi/2} \cos^2\theta^{s-1}(1-\cos^2\theta)^{t-1} (\cos\theta\sin\theta) d\theta\\[3pt]
            &= -2\int^0_{\pi/2} \cos\theta^{2s-1}(\sin^2\theta)^{2t-1} d\theta\\[3pt]
            &= 2\int^{\pi/2}_0 \cos\theta^{2s-1}(\sin^2\theta)^{2t-1} d\theta\\[3pt]
\end{align*}
$$
</div>

### ベータ関数とガンマ関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

正の実数$s, t > 0$について以下が成立する

$$
\beta(t, s) = \frac{\Gamma(t)\Gamma(s)}{\Gamma(s+t)}
$$

</div>

$\Gamma(s)$について

$$
\Gamma(s) = 2\int_0^\infty x^{2s-1}\exp(-x^2)dx
$$

が成立するので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Gamma(s)\Gamma(t) &= 4\int_0^\infty x^{2s-1}\exp(-x^2)dx \int_0^\infty y^{2t-1}\exp(-y^2)dy\\
                   &= 2\int_0^\infty\int_0^\infty x^{2s-1}y^{2t-1} \exp(-(x^2 + y^2))dxdy
\end{align*}
$$
</div>

ここで$x = r\cos\theta, y =r\sin\theta$という変数変換を行うと

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Gamma(s)\Gamma(t) &= \int_0^{\pi/2}\int_0^\infty \cos^{2s-1}\theta \sin^{2t-1}\theta \exp(-r)rdrdy\theta\\[3pt]
                   &= \bigg(2\int^{\pi/2}_0\cos^{2s-1}\theta\sin^{2t-1}\theta d\theta\bigg)\bigg(2\int_0^\infty r^{2(s+t)-1}\exp(-r^2)dr\bigg)\\
                   &= \Beta(s, t)\Gamma(s+t)
\end{align*}
$$
</div>

したがって, 

$$
\Beta(s, t)=\frac{\Gamma(t)\Gamma(s)}{\Gamma(s+t)}
$$


## Appendix
### ガンマ関数の作図

```python
import numpy as np
import math
import plotly.graph_objects as go

x = np.linspace(0, 7.5, 10000)[1:]
y = list(map(math.gamma, x))
y_factorial = list(map(math.factorial, np.arange(0, 9)))

fig = go.Figure()
fig.add_trace(go.Scatter(x=x, y=y,
                         mode='lines', name='gamma function'))

fig.add_scatter(x=np.arange(1, 8), 
                y=y_factorial,
                name='factorial', 
                mode="markers") 

fig.update_layout(
    title='ガンマ関数: x の増加とともに爆発的に増えていく',
    width=600, height=500,
    margin=dict(l=20, r=20, t=60, b=20),
    xaxis_range=[-0.5,7.5],
    yaxis_range=[-20,900],
    yaxis_title="Γ(x)",
)
```

References
-------------
- [Ryo's Tech Blog > 変数変換のルールをまとめる](https://ryonakagami.github.io/2021/04/21/variable-transformation/)