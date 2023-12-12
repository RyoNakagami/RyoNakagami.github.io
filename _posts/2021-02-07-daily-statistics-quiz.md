---
layout: post
title: "置換積分を用いて基本統計量を計算する"
subtitle: "確率と数学ドリル 12/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-12-08
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

- [置換積分](#%E7%BD%AE%E6%8F%9B%E7%A9%8D%E5%88%86)
- [自然対数と置換積分](#%E8%87%AA%E7%84%B6%E5%AF%BE%E6%95%B0%E3%81%A8%E7%BD%AE%E6%8F%9B%E7%A9%8D%E5%88%86)
  - [Python simulation: Acceptance-Rejection Sampling](#python-simulation-acceptance-rejection-sampling)
- [ガンマ関数と置換積分](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%A8%E7%BD%AE%E6%8F%9B%E7%A9%8D%E5%88%86)
- [三角関数と置換積分](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%A8%E7%BD%AE%E6%8F%9B%E7%A9%8D%E5%88%86)
  - [$\arcsin$と置換積分](#%5Carcsin%E3%81%A8%E7%BD%AE%E6%8F%9B%E7%A9%8D%E5%88%86)
    - [シミュレーションは可能なのか？](#%E3%82%B7%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AF%E5%8F%AF%E8%83%BD%E3%81%AA%E3%81%AE%E3%81%8B)
    - [Python simulation](#python-simulation)
  - [$\arctan$と置換積分](#%5Carctan%E3%81%A8%E7%BD%AE%E6%8F%9B%E7%A9%8D%E5%88%86)
- [Appendix: Acceptance-Rejection Sampling](#appendix-acceptance-rejection-sampling)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 置換積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$a>0$のとき, 以下を求めよ

$$
\int^a_0 x\sqrt{a^2 - x^2}dx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

以下のように変数変換を置く:

$$
\begin{align*}
x &= a\sin\theta\\
dx &= a\cos\theta d\theta
\end{align*}
$$

このとき, $\theta$は$0$から$\pi/2$を動くので

$$
\begin{align*}
\int^a_0 x\sqrt{a^2 - x^2}dx &= \int^{\pi/2}_0 a\sin\theta\sqrt{a^2 - a^2\sin^2\theta}a\cos\theta d\theta\\[3pt]
                             &= a^3 \int^{\pi/2}_0\sin\theta\cos^2\theta dx\\[3pt]
\end{align*}
$$

あらためて, $u = \cos\theta$とおくと, $du = -\sin\theta d\theta$なので

$$
\begin{align*}
a^3 \int^{\pi/2}_0\sin\theta\cos^2\theta dx &= a^3\int^0_1 -u^2 du\\[3pt]
                                            &= a^3\int^1_0 u^2 du\\[3pt]
                                            &= \frac{a^3}{3}
\end{align*}
$$


</div>

## 自然対数と置換積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$x\in(0,1)$で確率密度関数が以下のように与えられたとする

$$
f(x) = 2\log(1 + \sqrt{x})
$$

(1) $\int^1_0 f(x)dx = 1$になることを確かめよ

(2) $X$について, 期待値と分散を求めよ

</div>

確率事象の値全体としての標本空間を$\Omega$としたとき, 連続型の確率変数の密度関数 $f(x)$は次の性質を満たす必要があります

$$
\begin{align*}
& (a): f(x) \geq 0\\
& (b): \int_\Omega f(x) dx = 1 
\end{align*}
$$

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

(1)について以下確かめてみる. $1 + \sqrt{x} = t$とおくと

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int_\Omega f(x) dx &= \int^1_0 2\log(1 + \sqrt{x}) dx \\[3pt]
                    &= 2\int^2_1\log(t) 2(t-1)dt\\[3pt]
                    &= 2\int^2_12(t-1)\log(t)dt\\[3pt]
                    &= 2\bigg[(t-1)^2\log(t)\bigg]^2_1 - 2\int^2_1(t-1)^2\frac{1}{t}dt\\[3pt]
                    &= 2\log2 - 2\int^2_1 t - 2 + \frac{1}{t}dt \\[3pt]
                    &= 2\log2 - \bigg[t^2 - 4t + 2\log(|t|)\bigg]^2_1\\[3pt]
                    &= 1
\end{align*}
$$
</div>

期待値と分散については計算がめんどくさいですが.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X] &= \int^1_0 2x\log(1 + \sqrt{x}) dx  = \frac{7}{12}\\[3pt] 
\mathbb E[X^2] &= \int^1_0 2x^2\log(1 + \sqrt{x}) dx  = \frac{37}{90}\\[3pt]
\text{Var}(X) &= \mathbb E[X^2] - \mathbb E[X]^2 = \frac{17}{240}
\end{align*}
$$
</div>


</div>

### Python simulation: Acceptance-Rejection Sampling

目標密度関数$f$, 参照密度関数$f_0$, 定数$M$を以下のように定義します

$$
\begin{align*}
f(x) &= \begin{cases}2\log(1 + \sqrt{x}) & x \in(0, 1)\\ 0 & \text{otherwise}\end{cases}\\[3pt]
f_0(x) &= \begin{cases}1 & x \in(0, 1)\\ 0 & \text{otherwise}\end{cases}\\[3pt]
M & = \sup\left\{\frac{f(x)}{f_0(x)}\right\} = f(1) = 2\log 2
\end{align*}
$$

$M = 2\log 2$は目標密度関数が定義域内で単調増加関数であることから自明.

```python
import numpy as np
from scipy import stats
import plotly.graph_objects as go

def cdf(x):
    return 2*(x-1)*np.log(1+np.sqrt(x)) - x + 2*np.sqrt(x)

def pdf(x):
    return 2*np.log(1 + np.sqrt(x))


## data generating 
np.random.seed(42)
N = 20000
u = np.random.uniform(0, 1, N)
v = np.random.uniform(0, 1, N)
M = 2*np.log(2)
thresh = pdf(v)/M
x = v[u <= thresh]

## plot
support = np.linspace(0, 1, 1000)
density = pdf(support)
binsize= 50 

fig = go.Figure()
fig.add_trace(go.Histogram(x=x, 
                           nbinsx=binsize,
                           name='Rejection sampling',
                           histnorm='probability'))
fig.add_trace(go.Scatter(x=support, 
                         y=density/binsize,
                         mode='lines', 
                         name='density function'))
```

シミュレーションで発生させたデータのhistogramとdensity plotを重ねるとそれなりにうまく行っていそうな気配が漂っている.

{% include plotly/20210207_rejection_sampling_log.html%}

KS testで統計量を確認してみると, 異なる分布と棄却することはできない結果となった.

```python
## ks test
stats.kstest(x, cdf)
>> KstestResult(statistic=0.005850481461250778, 
                pvalue=0.7039166342313163, 
                statistic_location=0.7378783528059887, statistic_sign=1)

```

一旦は分布が再現できていると判断して期待値と分散を計算すると以下のような結果となり, 
上で求めた厳密解と近しい値を取ってることがわかる.

```python
## mean, variance
print("sample mean:{:.4f}, true-val::{:.4f}".format(np.mean(x), 7/12))
print("sample mean:{:.4f}, true-val::{:.4f}".format(np.var(x), 17/240))
>> sample mean:0.5823, true-val::0.5833
>> sample mean:0.0704, true-val::0.0708
```

## ガンマ関数と置換積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$x\in(0,1)$で確率密度関数が以下のように与えられたとする

$$
f(x) = -\log(x)
$$

(1) $\int^1_0 f(x)dx = 1$になることを確かめよ

(2) $X$について, 期待値と分散を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\int^1_0  -\log(x)dx &= \bigg[-x\log(x)\bigg]^1_0 + \int^1_0 dx\\[3pt]
                   &= 1
\end{align*}
$$

また, 

$$
\begin{align*}
\Pr(X \leq x) &= \bigg[-x\log(x)\bigg]^x_0 + \int^x_0 dx\\[3pt]
              &= -x\log(x) + x
\end{align*}
$$

期待値は, $-\log(x) = u$と変数変換をおくと

$$
\begin{align*}
\mathbb E[X] &= \int^1_0  -x\log(x)dx\\[3pt]
             &= \int^0_\infty u \exp(-u)\exp(-u)\times (-1) du \\[3pt]
             &= \int^\infty_0 u \exp(-2u) du \\[3pt]
             &= \int^\infty_0 \frac{1}{2}t\exp(-t)\frac{1}{2}dt\\[3pt]
             &= \frac{1}{4}\int^\infty_0t^{2-1}\exp(-t)dt\\[3pt]
             &= \frac{1}{4} \Gamma(2)\\[3pt]
             &= \frac{1}{4}
\end{align*}
$$

分散については$\mathbb E[X^2]$が求まれば良いので

$$expected value using CDF
\begin{align*}
\mathbb E[X^2] &= \int^1_0  -x^2\log(x)dx\\[3pt]
               &= \int^\infty_0 u \exp(-3u) du \\[3pt]
               &= \int^\infty_0 \frac{1}{3}t \exp(-t)\frac{1}{3} du \\[3pt]
               &= \frac{1}{9}
\end{align*}
$$

従って, 

$$
\text{Var}(X) = \frac{1}{9} - \bigg(\frac{1}{4}\bigg)^2 = \frac{7}{144}
$$


</div>

## 三角関数と置換積分
### 基本問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

以下の定積分を求めよ

$$
\int^{\pi}_0\cos\sqrt{x}dx
$$


</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$t = \sqrt{x}$とおいて

$$
\begin{align*}
\int^{\pi}_0\cos\sqrt{x}dx &= \int^{\sqrt{\pi}}_02t\cos t dt\\[3pt]
                           &= [2t\sin t]^{\sqrt{\pi}}_0 - \int^{\sqrt{\pi}}_0 2\sin t dt\\[3pt]
                           &=  [2t\sin t]^{\sqrt{\pi}}_0 + [2\cos t]^{\sqrt{\pi}}_0\\[3pt]
                           &=  2(\sqrt{\pi}\sin \sqrt{\pi} + \cos \sqrt{\pi} - 1)
\end{align*}
$$


</div>




### $\arcsin$と置換積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$x\in(0,1)$で確率密度関数が以下のように与えられたとする

$$
f(x) = \frac{2}{\pi\sqrt{1-x^2}}
$$

- $\int^1_0 f(x)dx = 1$になることを確かめよ
- $X$について, 期待値と分散を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\arcsin'(x) = \frac{1}{\sqrt{1-x^2}}
$$

であることに留意すると

$$
\begin{align*}
\int^1_0 \frac{2}{\pi\sqrt{1-x^2}}dx &= \frac{2}{\pi}[\arcsin(x)]^1_0\\
                                     &= \frac{2}{\pi} \bigg(\frac{\pi}{2} - 0\bigg)\\
                                     &= 1
\end{align*}
$$

期待値は$x=\sin\theta$を用いて

$$
\begin{align*}
\mathbb E[X] &= \int^1_0\frac{2x}{\pi\sqrt{1-x^2}}dx\\[3pt]
             &= \frac{2}{\pi}\int^{\pi/2}_0 \frac{\sin\theta}{\cos\theta}\cos\theta d\theta\\[3pt]
             &= \frac{2}{\pi}\int^{\pi/2}_0\sin\theta d\theta\\
             &= \frac{2}{\pi}
\end{align*}
$$

$\mathbb E[X^2]$は

$$
\begin{align*}
\mathbb E[X^2] &= \int^1_0\frac{2x^2}{\pi\sqrt{1-x^2}}dx\\[3pt]
             &= \frac{2}{\pi}\int^{\pi/2}_0 \frac{\sin^2\theta}{\cos\theta}\cos\theta d\theta\\[3pt]
             &= \frac{2}{\pi}\int^{\pi/2}_0\sin^2\theta d\theta\\[3pt]
             &= \frac{1}{\pi}\int^{\pi/2}_0(1 - \cos2\theta)d\theta\\[3pt]
             &= \frac{1}{2}
\end{align*}
$$

従って, 

$$
\text{Var}(X) = \frac{1}{2} - \frac{4}{\pi^2}
$$

</div>

#### シミュレーションは可能なのか？

Acceptance-Rejection samlingでは

$$
M = \sup\left\{\frac{f(x)}{f_0(x)}\right\} < \infty
$$

という条件が必要ですが

$$
\lim_{x\to1}f(x) = \frac{2}{\pi\sqrt{1-x^2}}=\infty
$$

なので, Acceptance-Rejection samlingでsimulationするのは難しそうです. 

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >逆関数法</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

今回の累積密度関数は

$$
\Pr(X\leq x) = \frac{2}{\pi} \arcsin(x)
$$

なので逆関数が

$$
\text{ICDF}(x) = \sin\bigg(\frac{x\pi}{2}\bigg)
$$

とわかるので, 逆関数法でシミュレーションすることができます.

</div>

---

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >変数変換法</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
f(x) = \frac{2}{\pi\sqrt{1-x^2}}
$$

について$x = \sin\theta$と変数変換し, $\theta$についての密度関数$g$を考えてみると $\theta\in(0, \pi/2)$
について

$$
\begin{align*}
g(\theta) &= \frac{2}{\pi\sqrt{1-\sin^2\theta}}\cos\theta\\
          &= \frac{2}{\pi}
\end{align*}
$$

従って, 

$$
\theta\sim\text{Unif}(0, \pi/2)
$$

に従う$\theta$に対して$x = \sin(\theta)$と変換してシミュレーションデータの生成もできそうです.

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: 変数変換は一意ではない</ins></p>

$$
\theta\sim\text{Unif}(0, \pi)
$$

について$x=\sin(\theta)$と考えたときの$x$の密度関数を考えてみます. 

$$
\begin{align*}
\Pr(X\leq x) &= \Pr(\sin\theta \leq x)\\
             &= \Pr(\theta \in (0, \arcsin(x))) + \Pr(\theta \in (\pi-\Pr(\theta \in (0, \arcsin(x))), \pi))\\
             &= \frac{2\arcsin(x)}{\pi}
\end{align*}
$$

従って, 

$$
f(x) = \frac{2}{\pi\sqrt{1-x^2}}
$$

$\theta\sim\text{Unif}(0, \pi)$からの変数変換でも今回の目的密度関数が再現できる.

</div>



#### Python simulation

```python
import numpy as np
from scipy import stats

def cdf(x):
    return (2 / np.pi) * np.arcsin(x)

def pdf(x):
    return 2 / (np.pi * np.sqrt(1 - x**2))

## DGP
np.random.seed(42)
N = 20000
u = np.random.uniform(0, np.pi/2, N)
u2 = np.random.uniform(0, 1, N)

x = np.sin(u)
x2 = np.sin(u2 * np.pi/2)

## ks test
print(stats.kstest(x, cdf))
>>> KstestResult(statistic=0.0038036929545425258, pvalue=0.9333433180624549, statistic_location=0.8256177094009344, statistic_sign=1)

print(stats.kstest(x2, cdf))
>>> KstestResult(statistic=0.004595894932220124, pvalue=0.7902584909796191, statistic_location=0.8961216642195171, statistic_sign=1)
```

期待値分散についても

```python
print("sample mean:{:.4f}, true-val::{:.4f}".format(np.mean(x), 2/np.pi))
print("sample mean:{:.4f}, true-val::{:.4f}".format(np.mean(x2), 2/np.pi))
print("sample mean:{:.4f}, true-val::{:.4f}".format(np.var(x), 1/2 - 4/np.pi**2))
print("sample mean:{:.4f}, true-val::{:.4f}".format(np.var(x2), 1/2 - 4/np.pi**2))

>>> sample mean:0.6360, true-val::0.6366
>>> sample mean:0.6364, true-val::0.6366
>>> sample mean:0.0946, true-val::0.0947
>>> sample mean:0.0944, true-val::0.0947
```

### $\arctan$と置換積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$a, b > 0$としたとき, 次の定積分の値を計算せよ

$$
I = \int^{\pi/2}_{0}\frac{1}{(a^2\cos^2\theta + b^2\sin^2\theta)^2}d\theta
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
I &= \int^{\pi/2}_{0}\frac{1}{(a^2\cos^2\theta + b^2\sin^2\theta)^2}d\theta \\[3pt]
  &= \int^{\pi/2}_{0}\frac{\frac{1}{a^4\cos^4\theta}}{(1 + \frac{b^2}{a^2}\tan^2\theta)^2}d\theta\\[3pt]
  &= \int^{\pi/2}_{0}\frac{\frac{1}{a^4\cos^2\theta} + \frac{\tan^2\theta}{a^4\cos^2\theta}}{(1 + \frac{b^2}{a^2}\tan^2\theta)^2}d\theta
\end{align*}
$$


ここで, 

$$
\begin{align*}
&t = \bigg(\frac{b}{a}\tan\theta\bigg)\\[3pt]
&\frac{d\theta}{dt}= \frac{a}{b}\cos^2\theta 
\end{align*}
$$

とおくと

$$
\begin{align*}
I &= \int^{\pi/2}_{0}\frac{\frac{1}{a^4\cos^2\theta} + \frac{\tan^2\theta}{a^4\cos^2\theta}}{(1 + \frac{b^2}{a^2}\tan^2\theta)^2}d\theta\\[3pt]
&= \frac{1}{a^3b^3}\int^{\infty}_0\frac{b^2 + a^2t^2}{(1+t^2)^2}dt
\end{align*}
$$

このとき

$$
I_1 = \int^{\infty}_0\frac{b^2 + a^2t^2}{(1+t^2)^2}dt
$$

に対して, 以下のような変数変換を実施する

$$
t = \frac{1}{x}
$$

すると

$$
\begin{align*}
\int^{\infty}_0\frac{b^2 + a^2t^2}{(1+t^2)^2}dt &= \int_{\infty}^0\frac{b^2 + a^2x^{-2}}{(1+x^{-2})^2}(-x^{-2})dx\\[3pt]
&= \int^{\infty}_0\frac{b^2 + a^2x^{-2}}{(1+x^{-2})^2}\frac{x^2}{x^4}dx\\[3pt]
&= \int^{\infty}_0\frac{x^2b^2 + a^2}{(x^2+1)^2}dx
\end{align*}
$$

従って

$$
\begin{align*}
2I_1 &= \int^{\infty}_0\frac{b^2 + a^2t^2}{(1+t^2)^2}dt + \int^{\infty}_0\frac{x^2b^2 + a^2}{(x^2+1)^2}dx\\[3pt]
&= \int^\infty_0\frac{a^2+b^2}{(1+t^2)}dt\\[3pt]
&= (a^2+b^2)[\arctan(t)]^\infty_0\\[3pt]
&= (a^2+b^2)\frac{\pi}{2}
\end{align*}
$$


従って, 

$$
I = \frac{a^2+b^2}{a^3b^3}\frac{\pi}{4}
$$


</div>



## Appendix: Acceptance-Rejection Sampling

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Acceptance-Rejection Sampling Algorithm</ins></p>

> **Input**: target density $f$, proposal density $f_0$, constant $M$ satisfying the follwoing<br>
> 
> $$M = \sup\left\{\frac{f(x)}{f_0(x)}\right\}$$
> 
> **Output**: one realization from $f$
> 
> **Repeat**: generate $y$ from $f_0$ and $u$ from $\text{Unif}(0, 1)$, independently<br>
> 
> **Until** 
> 
> $$u \leq \frac{f(y)}{Mf_0(y)}$$
> 
> **Return** the last $y$

- $M$が大きくなると棄却する割合が大きくなり非効率なサンプリング法になる
- $M<\infty$を満たすためには, 提案分布の密度$f_0(x)$は目標分布の密度$f(x)$よりも裾が厚くなる必要がある 
- 例: 提案分布の密度がコーシー分布で目標分布が正規分布のときは機能するが, 逆の場合は機能しない

</div>



References
-------------
- [Lecture note 2007 by Karl Sigman > Acceptance-Rejection Method](http://www.columbia.edu/~ks20/4703-Sigman/4703-07-Notes-ARM.pdf)
- [Ryo's Tech Blog > 半円周上に一様分布する点の高さの分布](https://ryonakagami.github.io/2021/02/04/uniform-on-circular-and-height-distribution/#%E5%8D%8A%E5%86%86%E5%91%A8%E4%B8%8A%E3%81%AB%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%99%E3%82%8B%E7%82%B9%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
