---
layout: post
title: "半円周上に一様分布する点の高さの分布"
subtitle: "確率と数学ドリル 10/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-12-01
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

- [本日のクイズ](#%E6%9C%AC%E6%97%A5%E3%81%AE%E3%82%AF%E3%82%A4%E3%82%BA)
  - [Pythonでのsimulation](#python%E3%81%A7%E3%81%AEsimulation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 本日のクイズ

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
              &= \frac{1}{\pi}(\hat\theta + \pi - (\pi-\hat\theta))\\[3pt]
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
