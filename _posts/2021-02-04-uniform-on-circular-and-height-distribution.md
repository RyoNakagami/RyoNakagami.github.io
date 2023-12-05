---
layout: post
title: "半円周上に一様分布する点の高さの分布"
subtitle: "確率と数学ドリル 10/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-12-05
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

- [半円周上に一様分布する点について](#%E5%8D%8A%E5%86%86%E5%91%A8%E4%B8%8A%E3%81%AB%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%99%E3%82%8B%E7%82%B9%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [Pythonでのsimulation](#python%E3%81%A7%E3%81%AEsimulation)
- [４分円内部に一様分布する点について](#%EF%BC%94%E5%88%86%E5%86%86%E5%86%85%E9%83%A8%E3%81%AB%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%99%E3%82%8B%E7%82%B9%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [円周内部に一様分布する二次元確率変数](#%E5%86%86%E5%91%A8%E5%86%85%E9%83%A8%E3%81%AB%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%99%E3%82%8B%E4%BA%8C%E6%AC%A1%E5%85%83%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0)
  - [変数変換後の期待値について](#%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B%E5%BE%8C%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [(X, Y)の共分散について：無相関だが独立ではない](#x-y%E3%81%AE%E5%85%B1%E5%88%86%E6%95%A3%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6%E7%84%A1%E7%9B%B8%E9%96%A2%E3%81%A0%E3%81%8C%E7%8B%AC%E7%AB%8B%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%84)
- [Appendix: 二次元極座標変換におけるヤコビアン](#appendix-%E4%BA%8C%E6%AC%A1%E5%85%83%E6%A5%B5%E5%BA%A7%E6%A8%99%E5%A4%89%E6%8F%9B%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%83%A4%E3%82%B3%E3%83%93%E3%82%A2%E3%83%B3)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 半円周上に一様分布する点について

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

点Pが半径1の直径ABをもつ半円周上に一様分布している. 点Pの高さの確率分布を求めよ

</div>

Geogebraで記述すると確率分布の対象となる高さとは線分PQの長さとなります.

{% include geogebra/20210204_circular.html %}

点Pが半径1の直径ABをもつ半円周上に一様分布しているので, 角度POBを$\theta$とすると

$$
\theta \sim Unif(0, \pi)
$$

点Pの高さを$X$としたとき, $X = \sin(\theta)$なので

$$
\theta = \arcsin(X)
$$

まず$\Pr(X \leq x)$を考える. $0<x<1$として, $\hat\theta$ を
$0<\hat\theta<\pi/2$ で $\sin(\hat\theta)=x$ となるものとすると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(X \leq x) &= \Pr(\sin(\theta) \leq x)\\[3pt]
              &= \Pr(0\leq \theta \leq \hat\theta) + \Pr(\pi-\hat\theta\leq \theta \leq \pi)\\[3pt]
              &= \frac{1}{\pi}(\hat\theta + \pi - (\pi-\hat\theta))\\[3pt]20210122_simulation.html
              &= \frac{2\hat\theta}{\pi}
\end{align*}
$$
</div>

$X$についての確率密度関数は上記を$x$について微分して得られるので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\frac{\partial \Pr(X \leq x)}{\partial x}&= \frac{\partial \Pr(X \leq x)}{\partial \hat\theta}\frac{\partial \hat\theta}{\partial x} \\[3pt]
&= \frac{2}{\pi}\frac{1}{\cos(\sin^{-1}(x))}\\[3pt]
&= \frac{2}{\pi\sqrt{1 - (\sin(\sin^{-1}(x)))^2}}\\[3pt]
&= \frac{2}{\pi\sqrt{1 - x^2}}
\end{align*}
$$
</div>

### Pythonでのsimulation

上で変数変換後の累積分布関数が

$$
\Pr(X \leq x) = \frac{2\arcsin(x)}{\pi}
$$

この逆関数は

$$
\text{ICDF}(p) = \sin\bigg(\frac{\pi p}{2}\bigg)
$$

と表せるので, 累積密度関数の返り値が一様分布に従う性質を利用して, 上の結果の正しさをPythonで検証してみます.

```python
import numpy as np
import plotly.express as px

np.random.seed(42)

## data size
N = 1000

## sin(theta) simulation
theta = np.random.uniform(0, np.pi, N)
x = np.sin(theta)

## ICDF simulation
prob = np.random.uniform(0, 1, N)
x_sim = np.sin(prob * np.pi / 2)

fig = px.histogram(x = [x, x_sim], 
             histnorm='probability', 
             barmode='overlay',
             title='逆累積分布関数によるシミュレーション結果との比較'
             )
newnames = {'wide_variable_0':'sin(θ)', 
            'wide_variable_1':'逆累積関数法'}

fig.for_each_trace(lambda t: t.update(name = newnames[t.name],
                                      legendgroup = newnames[t.name],
                                      hovertemplate = t.hovertemplate.replace(t.name, newnames[t.name])
                                     )
                  )
```

{% include plotly/20210204_simulation.html %}

## ４分円内部に一様分布する点について

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$D = \{(x, y)\vert x^2 + y^2 < 1, x>0, y >0\}$領域に一様分布する確率変数$(X, Y)$を考える.
このとき以下を求めよ, 

- $(X, Y)$の同時密度関数
- $X$の期待値
- $\text{Cov}(X + Y, X)$

</div>

$D$の面積は

$$
\text{Dの面積} = \frac{\pi}{4}\times 1\times 1 = \frac{\pi}{4}
$$

なので, $(X, Y)$の同時密度関数は

$$
f(x, y) = \begin{cases}\frac{4}{\pi} & (x, y) \in D\\[3pt]0 & \text{ otherwise}\end{cases}
$$

$X$の期待値は二次元極座標 $(r, \theta)$と直交座標 $(x, y)$間の変数変換を用いて

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X] &= \int\int_D x\frac{4}{\pi}dxdy\\[3pt]
             &= \frac{4}{\pi}\int^1_0\int^{\pi/2}_0r\cos\theta \times r d\theta dr\\[3pt]
             &= \frac{4}{\pi}\int^1_0 r^2 [\sin\theta]^{\pi/2}_0 dr\\[3pt]
             &= \frac{4}{3\pi}
\end{align*}
$$
</div>

$\text{Cov}(X + Y, X) = \text{Var}(X) + \text{Cov}(Y, X)$なので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \frac{4}{\pi}\int^1_0\int^{\pi/2}_0r^2\cos^2\theta \times r d\theta dr\\[3pt]
               &= \frac{4}{\pi}\int^1_0r^3\int^{\pi/2}_0\frac{1 + \cos 2\theta}{2} d\theta dr\\[3pt]
               &= \frac{4}{\pi}\int^1_0r^3\bigg[\frac{\theta}{2} + \frac{\sin2\theta}{4}\bigg]^{\pi/2}_0 dr\\[3pt]
               &= \frac{4}{\pi} \frac{\pi}{4}\frac{1}{4}\\
               &= \frac{1}{4}
\end{align*}
$$
</div>

また, 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[XY] &= \int\int_D xy\frac{4}{\pi}dxdy\\[3pt]
              &= \frac{4}{\pi}\int^1_0\int^{\pi/2}_0r^3\cos\theta\sin\theta d\theta dr\\[3pt]
              &= \frac{4}{\pi}\times \frac{1}{4} \times \frac{1}{2}\\[3pt]
              &= \frac{1}{2\pi}
\end{align*}
$$
</div>

従って,

$$
\begin{align*}
\text{Cov}(X + Y, X) &= \text{Var}(X) + \text{Cov}(Y, X)\\
                     &= \frac{1}{4} - \frac{16}{9\pi^2} + \frac{1}{2\pi} - \frac{16}{9\pi^2}\\[3pt]
                     &= \frac{1}{4} + \frac{1}{2\pi} - \frac{32}{9\pi^2}
\end{align*}
$$

> Python simulation

radiusはsquare rootを取る必要がある点に留意. 面積で一様分布しているが, その面積は$r^2$に比例するのが直感的理解ですが, 変数変換によって導出した確率密度関数から逆関数法で以下のようにも示せます

$$
\begin{align*}
\Pr(r\leq x) &= \int^x_0\int^{\pi/2}_0\frac{4}{\pi}rd\theta dr\\[3pt]
             &= \int^x_0 2r dr\\
             &= x^2
\end{align*}
$$

従って, $\Pr(r\leq x) \sim Unif(0, 1)$よりradius, $r$は

$$
\begin{align*}
r = \sqrt{U} \  \ \text{ where } U\sim Unif(0, 1)
\end{align*}
$$

と計算できます. $\theta$は同様に確かめると $\theta\sim Unif(0, \pi/2)$ であることがわかる.

```python
import numpy as np
N = 10000
r = np.sqrt(np.random.uniform(0, 1, N))
theta = np.random.uniform(0, 1, N) * np.pi/2
x, y = r * np.cos(theta), r * np.sin(theta)

print(np.mean(x), 4/(3*np.pi))
print(np.mean(x**2), 1/4)
print(np.mean(x*y), 1/(2*np.pi))
print(np.cov(x+y, x, ddof=1)[1,0], 1/4 + 1/(2*np.pi) - 32/(9*(np.pi**2)))
```

## 円周内部に一様分布する二次元確率変数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

二次元確率変数 $(X, Y)$の同時密度関数が以下のように与えられているとします:

$$
f_{X, Y}(x, y) = \begin{cases}
\frac{1}{\pi} & \text{ where } x^2 +y^2 < 1\\
0 & \text{ otherwise}
\end{cases}
$$

これは, $(X, Y)$が原点を中心とした半径1の円内部に一様分布していることを示している. このとき, 以下を求めよ

- $X$の期待値と分散
- $\mathbb E[\exp(-(X^2 + Y^2))]$
- $\text{Cov}(X, Y)$

</div>

$X$の期待値は直感的に0とわかりますが, 以下のように数式を用いて導出できます

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X] &= \int\int_{x^2+y^2<1} x \frac{1}{\pi}dxdy\\[3pt]
             &= \frac{1}{\pi}\int^1_0\int^{2\pi}_0 r\cos(\theta)\times r d\theta dr\\[3pt]
             &= \frac{1}{\pi}\int^1_0 r^2 \int^{2\pi}_0 \cos(\theta)d\theta dr\\[3pt]
             &= \frac{1}{\pi}\int^1_0 r^2 [\sin\theta]^{2\pi}_0\\
             &= 0
\end{align*}
$$
</div>

同様に

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \int\int_{x^2+y^2<1} x^2 \frac{1}{\pi}dxdy\\[3pt]
             &= \frac{1}{\pi}\int^1_0\int^{2\pi}_0 r^2\cos^2(\theta)\times rd\theta dr\\[3pt]
             &= \frac{1}{\pi}\int^1_0 r^3 \int^{2\pi}_0 \frac{1 + \cos(2\theta)}{2}d\theta dr\\[3pt]
             &= \frac{1}{\pi}\int^1_0 r^3 \bigg(\pi + \left[\frac{\sin 2\theta}{4}\right]^{2\pi}_0\bigg)\\[3pt]
             &= \frac{1}{4}
\end{align*}
$$
</div>

従って, 

$$
\text{Var}(X^2) = \frac{1}{4}
$$

### 変数変換後の期待値について

これも極座標変換を用いて計算することができます

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[\exp(-(X^2 + Y^2))] &=  \int\int_{x^2+y^2<1} \exp(-x^2 -y^2) \frac{1}{\pi}dxdy\\[3pt]
                              &=  \int^1_0\int^{2\pi}_0 r\exp(-r^2) \frac{1}{\pi}d\theta dr\\[3pt]
                              &= \int^1_02r\exp(-r^2) dr\\[3pt]
                              &= \left[-\exp(-r^2)\right]^1_0\\[3pt]
                              &= 1 - \exp(-1)
\end{align*}
$$
</div>

### (X, Y)の共分散について：無相関だが独立ではない

$$
\begin{align*}
\mathbb E[XY] &=  \int\int_{x^2+y^2<1} xy \frac{1}{\pi}dxdy\\[3pt]
                              &=  \int^1_0\int^{2\pi}_0 r^3\cos\theta\sin\theta \frac{1}{\pi}d\theta dr\\[3pt]
                              &= \frac{1}{2\pi}\int^1_0r^3\int^{2\pi}_0\sin(2\theta) d\theta dr\\[3pt]
                              &= 0
\end{align*}
$$

従って, $\text{Cov}(X, Y) = 0$

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS</ins></p>

- $X, Y$は, 上記より無相関だが$x^2 + y^2 < 1$内部で一様分布と定義されているので独立ではない
- 無相関であったとしても独立ではない例の一つ

</div>


## Appendix: 二次元極座標変換におけるヤコビアン

二次元極座標 $(r, \theta)$と直交座標 $(x, y)$間の変数変換を以下のように考えます:

$$
\begin{align*}
&x = r\cos\theta\\
&y = r\sin\theta
\end{align*}
$$

二変数関数2つ組なのでヤコビ行列のサイズは$2\times 2$となります.

ヤコビ行列は

$$
\left(\begin{array}{cc}
\frac{\partial x}{\partial r} & \frac{\partial x}{\partial \theta}\\
\frac{\partial y}{\partial r} & \frac{\partial y}{\partial \theta}
\end{array}\right)

=

\left(\begin{array}{cc}
r\cos\theta & -r\sin\theta\\
r\sin\theta & r\cos\theta
\end{array}\right)

$$

なので $\vert J \vert = r$と求まります.


References
------------
- [高校数学の美しい物語 > 二次元極座標](https://manabitimes.jp/math/1209)