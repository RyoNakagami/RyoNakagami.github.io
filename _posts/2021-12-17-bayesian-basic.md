---
layout: post
title: "Flip a Coin and Bayesian estimation"
subtitle: "ベイズ統計入門 1/N"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- 統計
- Bayesian
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Flip a Coin and Bayesian estimation](#flip-a-coin-and-bayesian-estimation)
  - [問題.1](#%E5%95%8F%E9%A1%8C1)
  - [問題.2](#%E5%95%8F%E9%A1%8C2)
- [Appendix:ベイズ統計とは？](#appendix%E3%83%99%E3%82%A4%E3%82%BA%E7%B5%B1%E8%A8%88%E3%81%A8%E3%81%AF)
  - [ベイズ統計における独立性](#%E3%83%99%E3%82%A4%E3%82%BA%E7%B5%B1%E8%A8%88%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E7%8B%AC%E7%AB%8B%E6%80%A7)
- [Refereneces](#refereneces)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Flip a Coin and Bayesian estimation

### 問題.1

とあるコインを独立に3回投げた時, 表３回, 裏が０回出現したのデータ(以下, $D$ と表記)があるとします(各施行は独立とする). \\
このコインの表の出る確率を $\theta$, その事前分布を$\theta \sim Beta(1,1))$としたとき, 観測結果を踏まえた上の$\theta$の事後分布を推定せよ


**解答**

ベータ分布のpdfは

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
P(\theta) &= \frac{1}{B(\alpha, \beta)}\theta^{\alpha - 1}(1-\theta)^{\beta - 1}\\
\text{ where } & B(\alpha, \beta) = \int^1_0\theta^{\alpha - 1}(1-\theta)^{\beta - 1}d\theta = \frac{\Gamma(\alpha)\Gamma(\beta)}{\Gamma(\alpha+\beta)}
\end{aligned}
$$
</div>

$(\alpha, \beta) = (1, 1)$のとき, ベータ分布で表現される事前分布は一様分布になります.

今回求めたいのは $P(\theta\|D)$なので、ベイズルールより

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
P(\theta|D) &= \frac{P(D|\theta)P(\theta)}{P(D)}
\end{aligned}
$$
</div>

$h, t$ をそれぞれ、コインを投げたときの表と裏の出現回数だとすると

$$
\begin{aligned}
P(D) &= \int^1_0 {_{h+t}}C_h \theta^h(1-\theta)^t P(\theta) d\theta \\[8pt]
&= \int^1_0 \frac{_{h+t}C_h}{B(\alpha, \beta)} \theta^h(1-\theta)^t\theta^{\alpha - 1}(1-\theta)^{\beta - 1}d\theta\\[8pt]
&=\int^1_0 \frac{_{h+t}C_h}{B(\alpha, \beta)} \theta^{\alpha+h-1}(1-\theta)^{\beta + t - 1}d\theta
\end{aligned}
$$

今回は、事前分布を一様分布, i.e., $(\alpha, \beta) = (1, 1)$なので

$$
\begin{aligned}
P(D) &= \int^1_0 {_{h+t}} C_h\theta^{h}(1-\theta)^{t} d\theta\\
&= {_{h+t}} C_h B(h+1, t+1)
\end{aligned}
$$

従って、

$$
\begin{aligned}
P(\theta|D) &= \frac{_{h+t}C_h \theta^{h}(1-\theta)^{t}}{_{h+t} C_h B(h+1, t+1)}\\[8pt]
            &= \frac{1}{B(h+1, t+1)}\theta^{h}(1-\theta)^{t}
\end{aligned}
$$

**解答終了**

---

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Remarks: </ins></p>
一般に, 事前の信念として $Beta(\alpha, \beta)$ で表現されるBeta-binomial分布について, <br> 
試行回数が$n$, 表の回数が $y$と観測された時の事後分布は $Beta(\alpha + y, \beta + n -y)$

$$
\mathbf E[\theta |y] = \frac{n}{\alpha + \beta + n}\frac{y}{n} + \frac{\alpha+\beta}{\alpha + \beta + n}\frac{\alpha}{\alpha+\beta}
$$

また, 事後平均も事前平均と標本平均の加重平均となる.

</div>


> Python simulation

```python
### libary
import numpy as np
import math
from scipy import stats
from scipy import special
import matplotlib.pyplot as plt

### style
plt.style.use('ggplot')


def plot_posterior(heads, tails, alpha, beta, ax=None):
    x = np.linspace(0, 1, 1000)
    y = stats.beta.pdf(x, heads+alpha, tails+beta)
        
    if ax == None:
      fig, ax = plt.subplots(figsize = (10, 7))
    
    ax.plot(x, y)
    ax.set_xlabel(r"$\theta$", fontsize=20)
    ax.set_ylabel(r"$P(\theta|D)$", fontsize=20)
    ax.set_title("Posterior after {} heads, {} tails, \
                 Prior: BetaPDF({},{})".format(heads, tails, alpha, beta));
    
    return x, y

def summary_stats(x, y):
    y_cum = np.cumsum(y)/np.sum(y)

    posterior_mean = np.sum(x * y)/sum(y)
    lower_05_percent = np.min(x[y_cum>0.05])
    midian_50_percent = np.min(x[y_cum>0.5])
    upper_95_percent = np.min(x[y_cum>0.95])
    standard_dev = np.sqrt(np.sum(x**2 * y/np.sum(y)) - posterior_mean**2)
    #standard_dev = np.sqrt(np.sum(((x - posterior_mean) ** 2)*y/np.sum(y)))
    
    print("posterior_mean : %.3f" % posterior_mean)
    print("standard_dev   : %.3f" % standard_dev)
    print("lower_value_05 : %.3f" % lower_05_percent)
    print("median_value_50: %.3f" % midian_50_percent)
    print("upper_value_95 : %.3f" % upper_95_percent)

x, y = plot_posterior(heads=3, tails=0, alpha=1, beta=1)
summary_stats(x, y)
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2021121706-11-43.png?raw=true">

### 問題.2

$\alpha=\beta=1$で表現されるベータ分布を事前分布として, 問題.1のデータを観測し, 信念を更新した後に, 再び同じコインを $N$ 回投げるとします. \\
このとき表の出る回数を $S_N$ としたとき、$P(S_N\|D)$を求めよ

**解答**

$$
Pr(S_T = H|D) = {}_{N} C_H \int^1_0 \theta^H(1-\theta)^{N-H}P(\theta|D)d\theta
$$

ともとめることができます. また問題.1より

$$
P(\theta|D) = \frac{1}{B(h+1, t+1)}\theta^{h}(1-\theta)^{t}
$$

なので、

$$
\begin{aligned}
Pr(S_T = H|D) &= \frac{_{N} C_H}{B(h+1, t+1)} \int^1_0 \theta^{H+h}(1-\theta)^{N-H+t}d\theta\\[8pt]
&= {}_{N} C_H\frac{B(H+h+1, N-H+t+1)}{B(h+1, t+1)}
\end{aligned}
$$


**解答終了**



```python
def plot_extrapolate(N_trials, heads, tails, alpha=1, beta=1, ax = None):
    x = np.arange(0, N_trials + 1)
    y = special.comb(N_trials, x) \
        * special.beta(x + heads + alpha,N_trials - x + tails + beta)\
        / special.beta(heads + alpha,tails + beta)
    
    if ax == None:
      fig, ax = plt.subplots(figsize = (10, 7))
    
    ax.bar(x, y)
    ax.set_xlabel("H: the number of head", fontsize=20)
    ax.set_ylabel(r"$P(S = H|D, N)$", fontsize=20)
    ax.set_title("The trials: {}, Data(heads: {}, tails: {}) \
                 ".format(N_trials, heads, tails));
    
    return x, y

x, y = plot_extrapolate(N_trials = 20 , heads = 3, tails = 0)
summary_stats(x, y)
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2021121706-11-59.png?raw=true">


> 観測Dataを変更してシミュレーション(alpha = 1, beta = 1)

```python
flips = [(2, 0), (20, 16), (50, 47), (75, 73), (400, 399)]
fig, axes = plt.subplots(len(flips), 2, figsize = (20, 14))

for i, flip in enumerate(flips):
    plot_posterior(heads=flip[0], tails=flip[1], alpha=1, beta=1, ax=axes[i,0])
    axes[i,0].set_yticks([])
    plot_extrapolate(N_trials = 50, heads = flip[0], tails = flip[1], ax = axes[i,1])

fig.subplots_adjust(hspace=0.8)
for ax in axes:
    ax[0].set_yticks([])
    ax[1].set_yticks([])
    ax[0].set_xlabel("")
    ax[1].set_xlabel("")
axes[4,0].set_xticks([0.5]);
```


<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2021121706-12-06.png?raw=true">

> alpha = 2, beta = 2の場合のシミュレーション

```python
flips = [(2, 0), (20, 16), (50, 47), (75, 73), (400, 399)]
fig, axes = plt.subplots(len(flips), 2, figsize = (20, 14))

for i, flip in enumerate(flips):
    plot_posterior(heads=flip[0], tails=flip[1], alpha=2, beta=2, ax=axes[i,0])
    axes[i,0].set_yticks([])
    plot_extrapolate(N_trials = 50, heads = flip[0], tails = flip[1], alpha=2, beta=2, ax = axes[i,1])

fig.subplots_adjust(hspace=0.8)
for ax in axes:
    ax[0].set_yticks([])
    ax[1].set_yticks([])
    ax[0].set_xlabel("")
    ax[1].set_xlabel("")
axes[4,0].set_xticks([0.5]);
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2021121706-12-13.png?raw=true">


## Appendix:ベイズ統計とは？

- 不確かな状況において合理的な(=目的関数の最大化問題に質する)意思決定を行うための理論的フレームワークを提供する統計手法
- その場その場で変わっていく情報を意思決定にどのように反映させるべきか?, という意思決定プロセスを提供
- 新しく観測データが与えられたとき, 次に自分はどのような決定をすべきであろうか?という問題を扱う

> REMARK

ベイズ法では事前分布が主観により(近似的にも)真でありモデルは正しいとして情報をアップデートしていくので, 
データを得たのちに事前分布やモデルの変更を行うことは禁止されています.

### ベイズ統計における独立性

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 独立性</ins></p>

２つの事象 $F, G$ が 事象 $H$ が与えられた下で条件付き独立とは以下が成立することをいう:

$$
Pr(F\cap G|H) = Pr(F|H)Pr(G|H)
$$

</div>

独立性が成立しているならば

$$
\begin{align*}
Pr(F\cap G|H) &= Pr(F|H, G)Pr(G|H)\\
              &= Pr(F|H)Pr(G|H)\\
\Rightarrow Pr(F|H, G) &= Pr(F|H) 
\end{align*}
$$

上記独立性が成立しているとき, $H$が真であることを知っているならば, $G$を知っていることは $F$に関する信念を
変えることはないことを意味しています. (逆もしかり)


## Refereneces

- [MA40189: Topics in Bayesian statistics](https://people.bath.ac.uk/masss/ma40189/notes.pdf)
- [決定理論 と ベイズ法:渡辺澄夫](http://watanabe-www.math.dis.titech.ac.jp/users/swatanab/decisiontheory.pdf)
