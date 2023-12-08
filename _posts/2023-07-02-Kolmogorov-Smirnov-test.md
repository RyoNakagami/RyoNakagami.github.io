---
layout: post
title: "Kolmogorov-Smirnov test"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-08-13
tags:

- statistics
- KS test

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [KS testのスコープ](#ks-test%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [KS Testの考え方](#ks-test%E3%81%AE%E8%80%83%E3%81%88%E6%96%B9)
  - [なぜsupremumが未知の分布に依存しないのか？](#%E3%81%AA%E3%81%9Csupremum%E3%81%8C%E6%9C%AA%E7%9F%A5%E3%81%AE%E5%88%86%E5%B8%83%E3%81%AB%E4%BE%9D%E5%AD%98%E3%81%97%E3%81%AA%E3%81%84%E3%81%AE%E3%81%8B)
  - [Kolmogorov-Smirnov test statistics](#kolmogorov-smirnov-test-statistics)
- [Pythonで実装](#python%E3%81%A7%E5%AE%9F%E8%A3%85)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## KS testのスコープ

$$
X_1, X_2, \cdots, X_n \sim_{i.i.d} \mathbb P　\tag{1}
$$

とデータが与えられたとき, 以下のような形で帰無仮説を設定する場合を考えます

$$
\begin{align*}
&H_0: \mathbb P = \mathbb P_0\\
&H_1: \mathbb P \neq \mathbb P_0
\end{align*}
$$

$\mathbb P$が離散分布ならば「**chi-squared goodness-of-fit test**」で検定することができますが, 
$\mathbb P$が連続分布の場合, 検定手法の一つとして「**Kolmogorov-Smirnov test**」を用いることができます.

## KS Testの考え方

(1)同様に, $X_1, X_2, \cdots, X_n \sim_{i.i.d} \mathbb P$ を考えます. このとき, empirical c.d.fは以下のように定義されます:

$$
F_n(x) = \mathbb P_n(X\leq x) = \frac{1}{n}\sum_{i\in N}I(X_i\leq x) \tag{2}
$$

- $x$以下で観測されるsample pointsの割合を表している

上記(2)について, 大数の法則により, 任意の $x\in\mathbb R$について以下の式が成立します:

$$
F_n(x) \to \mathbb E[I(X_i\leq x)] = \mathbb P(X|i\leq x) = F(x) \tag{3}
$$

任意の $x\in\mathbb R$について成立するので, (3)より

$$
\sup_{x\in\mathbb R} |F_n(x)-F(x)|\to 0 \tag{4}
$$

KS testはこのsupremumが未知の分布 $\mathbb P$に依存しないことに着目した統計量という特徴があります.


### なぜsupremumが未知の分布に依存しないのか？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Theorem</ins></p>

$F(x)$が連続ならば, 

$$
\sup_{x\in\mathbb R} |F_n(x)-F(x)|
$$

は$F$の形状に依存しない

</div>

**Proof**

$F$の逆関数を以下のように定義します:

$$
F^{-1}(y) = \min\{x: F(x)\geq y\}
$$

このとき以下の式が成立します:

$$
\mathbb P\bigg(\sup_{x\in\mathbb R} |F_n(x)-F(x)| \leq t\bigg) = \mathbb P\bigg(\sup_{y\in[0, 1]} |F_n(F^{-1}(y))-F(F^{-1}(y))|\leq t\bigg)
$$

empirical c.d.fの定義より

$$
\begin{align*}
F_n(F^{-1}(y)) &= \frac{1}{n}\sum_{i\in N}I(X_i \leq F^{-1}(y))\\[8pt]
               &= \frac{1}{n}\sum_{i\in N}I(F(X_i) \leq y)
\end{align*}
$$

したがって,

$$
\mathbb P\left(\sup_{y\in[0, 1]} |F_n(F^{-1}(y))-y|\leq t\right) = \mathbb P\left(\sup_{y\in[0, 1]} \bigg|\frac{1}{n}\sum_{i\in N}I(F(X_i) \leq y)-y\bigg|\leq t\right) 
$$

また, 

$$
\begin{align*}
\mathbb P(F(X_1)\leq t) &= \mathbb P(X_1\leq F^{-1}(t))\\
                        &= F(F^{-1}(t))\\
                        &= t

\end{align*}
$$

上記より, c.d.f $F(X_i)$は確率分布がどんな形状であろうとも連続確率変数ならば $[0,1]$区間の一様分布になることがわかります. したがって, $U_i = F(X-i)$とすると $U_i \sim Unif(0,1)$なので

$$
\mathbb P\left(\sup_{y\in[0, 1]} |F_n(F^{-1}(y))-y|\leq t\right) = \mathbb P\left(\sup_{y\in[0, 1]} \bigg|\frac{1}{n}\sum_{i\in N}I(U_i \leq y)-y\bigg|\leq t\right) 
$$

よって題意は示された.

**(証明終了)**

### Kolmogorov-Smirnov test statistics

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Kolmogorov-Smirnov distribution</ins></p>

$$
\mathbb P\bigg(\sqrt{n}\sup_{x\in\mathbb R}\bigg|F_n(x) - F(x)\bigg|\leq t\bigg)\to H(t)=1 - 2\sum_{j=1}^\infty(-1)^{j-1}\exp(-2j^2t)
$$

この $H(t)$ はKolmogorov-Smirnov distributionのc.d.f

</div>

KS testの統計量は以下のように表される

$$
D_n = \sqrt{n}\sup_{x\in\mathbb R}|F_n(x)-F_0(x)|
$$

- 帰無仮説が正しい場合, $n$が十分大きいと$D_n$はKolmogorov-Smirnov distributionに漸近的に収束する.
- 帰無仮説が成立しない場合, $F$はLLNより真のc.d.f関数に収束する

帰無仮説が成立しない場合, nが十分大きいと,

$$
\begin{align*}
&\sup_{x\in\mathbb R}|F_n(x)-F_0(x)| > \delta\\
&D_n = \sqrt{n}\sup_{x\in\mathbb R}|F_n(x)-F_0(x)| > \sqrt{n}\delta
\end{align*}
$$

つまり, $H_0$が成立性ない場合, $n$が十分大きいと $D_n > \sqrt{n}\delta\to\infty$となる. 
この性質を利用して, KS testでは次のような形で棄却レベル$\alpha$と統計量の関係を定義している

$$
\begin{align*}
\alpha &= Pr(\text{reject }H_0 | H_0)\\
       &= \mathbb P(D_n \geq c | H_0)\\
       &\approx 1 -H(c)
\end{align*}
$$

## Pythonで実装

Pythonでは`scipy`パッケージを用いれば`kstest`コマンドがありますが, `method='asymp'`の場合は以下と同様の挙動となります(defaultは`exact`):

```python
import numpy as np
from scipy import stats
import statsmodels.api as sm
from scipy.stats import kstwobign
np.random.seed(42)

## scipy.stats.kstest
x = stats.norm.rvs(size=100)
res = stats.kstest(x, stats.norm.cdf, method='asymp')
print(res)
>> KstestResult(statistic=0.10357070563896065, pvalue=0.23367246360310912, statistic_location=0.37569801834567196, statistic_sign=1)

## 再現
def calculate_kstest(data, cdf):
    data = np.sort(data)
    sqrt_n = np.sqrt(len(data))
    ecdf = sm.distributions.ECDF(data)

    gaps = np.column_stack([np.abs(np.r_[0, ecdf(data[:-1])] - stats.norm.cdf(data)), 
                            np.abs(ecdf(data) - stats.norm.cdf(data))])
    gaps = np.max(gaps, axis=1, keepdims=False)
    data_idx = np.argmax(gaps)
    max_diff= np.max(gaps)
    D_n = max_diff * sqrt_n
    pval = 1 - kstwobign.cdf(D_n)

    return max_diff, pval, data[data_idx], D_n, ecdf
    

max_diff, p_val, sup_x_loc, D_n, ecdf = calculate_kstest(x, stats.norm.cdf)
print(calculate_kstest(x, stats.norm.cdf)[:-2])
>> (0.10357070563896065, 0.23367246360310912, 0.37569801834567196)
```





References
--------------

- [KS test lecture note](https://ocw.mit.edu/courses/18-443-statistics-for-applications-fall-2006/0c5a824a932b841205b7bb4d27229abc_lecture14.pdf)
