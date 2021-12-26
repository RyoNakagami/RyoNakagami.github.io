---
layout: post
title: "ベイズ統計入門 1/N"
subtitle: "主観的確率と意思決定 (& シミュレーション)"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- 統計
- Bayesian
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>


||概要|
|---|---|
|目的|ベイズ統計入門<br>がんばってBayesian Econometricsをマスターする|
|参考|1. [ベータ関数の積分公式](https://manabitimes.jp/math/608) <br>2. [MA40189: Topics in Bayesian statistics](https://people.bath.ac.uk/masss/ma40189/notes.pdf)<br>3. [決定理論 と ベイズ法:渡辺澄夫](http://watanabe-www.math.dis.titech.ac.jp/users/swatanab/decisiontheory.pdf)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [ベイズ統計とは？](#%E3%83%99%E3%82%A4%E3%82%BA%E7%B5%B1%E8%A8%88%E3%81%A8%E3%81%AF)
  - [伝統的な頻度論的統計学を意思決定に活用するにあたっての問題点](#%E4%BC%9D%E7%B5%B1%E7%9A%84%E3%81%AA%E9%A0%BB%E5%BA%A6%E8%AB%96%E7%9A%84%E7%B5%B1%E8%A8%88%E5%AD%A6%E3%82%92%E6%84%8F%E6%80%9D%E6%B1%BA%E5%AE%9A%E3%81%AB%E6%B4%BB%E7%94%A8%E3%81%99%E3%82%8B%E3%81%AB%E3%81%82%E3%81%9F%E3%81%A3%E3%81%A6%E3%81%AE%E5%95%8F%E9%A1%8C%E7%82%B9)
  - [ベイズ統計（主観ベイズ法）でやってはいけないこと](#%E3%83%99%E3%82%A4%E3%82%BA%E7%B5%B1%E8%A8%88%E4%B8%BB%E8%A6%B3%E3%83%99%E3%82%A4%E3%82%BA%E6%B3%95%E3%81%A7%E3%82%84%E3%81%A3%E3%81%A6%E3%81%AF%E3%81%84%E3%81%91%E3%81%AA%E3%81%84%E3%81%93%E3%81%A8)
  - [ベイズ流アプローチ](#%E3%83%99%E3%82%A4%E3%82%BA%E6%B5%81%E3%82%A2%E3%83%97%E3%83%AD%E3%83%BC%E3%83%81)
  - [練習問題: Flip a Coin and Bayesian estimation](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C-flip-a-coin-and-bayesian-estimation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## ベイズ統計とは？

- 不確かな状況において合理的な(=目的関数の最大化問題に質する)意思決定を行うための理論的背景を提供する統計手法
- その場その場で変わっていく情報を意思決定にどのように反映させるべきか、という意思決定プロセスを提供
- 新しく観測データが与えられたとき,次に自分はどのような決定をすべきであろうか?という問題を主眼に扱う

なお、決定理論における「不確かな状況」という言葉の意味は、確率はすべて既知であるということであり、「不確か」ではあっても「未知」ではないことに注意.
意思決定の場面で、「確率が既知」であるケースは少ないと思われるかもしれないが、ベイズ統計（主観ベイズ法）では、「主観的に解釈した確率」を真の事前分布とし、モデルは正しいとし、サンプルはそ
れに従う確率変数であると決めているので、未知の分布の想定を容認していません.

### 伝統的な頻度論的統計学を意思決定に活用するにあたっての問題点

> (1) 検定の解釈が直感的ではない

- 仮説Hが正しいとしたときにデータYかそれより極端なデータが得られる確率 $P(y \geq Y|H)$をp値と呼んで検定に使用して、統計的意思決定（例：仮説を正しいと判断する）するが、
このp値はあくまで有意水準との比較に利用するものであるため、数値の意味は直感的ではなく解釈しにくい. 
- ベイズ統計では $P(H\|Y)$を求めることができ、意思決定に活用しやすい

> (2) 信頼区間の解釈が直感的ではない

- 推定したいパラメータ$\theta$は定数なので、「$\theta$の値が区間 $[a, b]$ にある確率は95%」という解釈はできません. 



### ベイズ統計（主観ベイズ法）でやってはいけないこと

主観ベイズ法では、事前分布が主観により真でありモデルは正しいと決められているので、
データを得たのちに事前分布やモデルの変更を行うことは禁止されています.


### ベイズ流アプローチ

> Def 1.1: Subjective Interpretation of Probabilty

Let $\kappa$ denote the body of knowledge, experience, or information that an individual has accumulated about the situation of concern,
and let $A$ denote an uncertain event. The probability of $A$ afforded by $\kappa$ is the degree of belief(確信度) in A held by an individualn in the face of $\kappa$


> Thm 1.1: ベイズの定理

Consider a probability space $[S, \tilde A, P(\cdot)]$ and a collection $B_n \in \tilde A (n=1,2,..., N)$ of mutuallu disjoint events such that 
$P(B_n) > 0$ and $S = B_1\cup B_2\cup...\cup B_N$. Then

$$
P(B_n|A) = \frac{P(A|B_n)P(B_n)}{\sum_j P(A|B_j)P(B_j)}
$$

for every $A\in\tilde A$ such that $P(A) > 0$

- $P(B_n\|A)$はAの観測を反映した$B_n$の確信度 = 事後分布と解釈できる
- $P(B_n)$は事前分布
- $P(A\|B_n)$は尤度


> Def 1.2: Exchangeability

A finite sequence $Y_t (t = 1, 2, ..., T)$ of events (or random variable) is exchangeable iff the joint probability of the sequence, or any subsequence, is invariant under permutations of the subscripts, that is,

$$
P(y_1, \cdots, y_T) = P(y_{\pi(1)}, \cdots, y_{\pi(T)})
$$

where $\pi(t)$ is a permutation of the elements in $\{1, ..., T\}$. An infinite sequence is exchangeable iff any finite subsequence is exchangeable.


- 頻度論でいうi.i.dの仮定と似た概念
- ただし、exchangeableの仮定を満たしたとしても必ずしもi.i.dとは限らない (identically distributedではある)
- i.i.dならばexchangeableはいえます(下の式より明らか)


$$
f(y_1, ..., y_T) = \prod f(y_t)  \ \ \ \ \text{ if } y_t\text{ is i.d.d}
$$

### 練習問題: Flip a Coin and Bayesian estimation

> 問題(1)

とあるコインを3回投げた時,、表３回、裏が０回出現したのデータ(以下、Dと表記)があるとします.
このコインの表の出る確率を $\theta$ & その事前分布を$\theta \sim Beta(1,1))$としたとき、観測結果より$\theta$の事後分布を推定せよ

- 各施行は独立とする

> 解答

ベータ分布のpdfは

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
P(\theta) &= \frac{1}{B(\alpha, \beta)}\theta^{\alpha - 1}(1-\theta)^{\beta - 1}\\
\text{where }& B(\alpha, \beta) = \int^1_0\theta^{\alpha - 1}(1-\theta)^{\beta - 1}d\theta
\end{aligned}
$$
</div>

かつ、$(\alpha, \beta) = (1, 1)$のときそれは一様分布になります.

今回求めたいのは $P(\theta\|D)$なので、ベイズルールより

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
P(\theta|D) &= \frac{P(D|\theta)P(\theta)}{P(D)}
\end{aligned}
$$
</div>

h, t をそれぞれ、コインを投げたときの表と裏の出現回数だとすると

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
P(D) &= \int^1_0 \frac{_{h+t}C_h}{B(\alpha, \beta)} \theta^h(1-\theta)^t\theta^{\alpha - 1}(1-\theta)^{\beta - 1}d\theta\\
&=\int^1_0 \frac{_{h+t}C_h}{B(\alpha, \beta)} \theta^{\alpha+h-1}(1-\theta)^{\beta + t - 1}d\theta
\end{aligned}
$$
</div>

今回は、事前分布を一様分布, i.e., $(\alpha, \beta) = (1, 1)$なので

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
P(D) &= \int^1_0 {_{h+t}} C_h\theta^{h}(1-\theta)^{t} d\theta\\
&= {_{h+t}} C_h B(h+1, t+1)
\end{aligned}
$$
</div>

従って、

$$
P(\theta|D) = \frac{1}{B(h+1, t+1)}\theta^{h}(1-\theta)^{t}
$$

なお、分散の計算は定義どおり

$$
V(X) = \sum (x - E[X])^2f(x)
$$


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

> 問題 (2)

上記の事前分布を信念として上記のデータを観測した後に、再び同じコインをN回投げるとします。このとき表の出る回数を$S_N$としたとき、$P(S_N\|D)$を求めよ

> 解答

$$
Pr(S_T = H|D) = {}_{N} C_H \int^1_0 \theta^H(1-\theta)^{N-H}P(\theta|D)d\theta
$$

ともとめることができます. また問題(1)より

$$
P(\theta|D) = \frac{1}{B(h+1, t+1)}\theta^{h}(1-\theta)^{t}
$$

なので、

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
Pr(S_T = H|D) &= \frac{_{N} C_H}{B(h+1, t+1)} \int^1_0 \theta^{H+h}(1-\theta)^{N-H+t}d\theta\\
&= {}_{N} C_H\frac{B(H+h+1, N-H+t+1)}{B(h+1, t+1)}
\end{aligned}
$$
</div>

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
