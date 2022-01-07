---
layout: post
title: "統計検定：ポワソン分布と条件付き分布"
subtitle: "２つの分布をvisualizationで比較"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
uu_cnt: 100
session_cnt: 100 
tags:

- 統計
- Python
---
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. ポワソン分布の性質](#1-%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [ポアソン分布が確率分布であることの確認](#%E3%83%9D%E3%82%A2%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%8C%E7%A2%BA%E7%8E%87%E5%88%86%E5%B8%83%E3%81%A7%E3%81%82%E3%82%8B%E3%81%93%E3%81%A8%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [ポアソン分布の平均と分散の導出](#%E3%83%9D%E3%82%A2%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E5%B9%B3%E5%9D%87%E3%81%A8%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
    - [ポアソン分布の平均](#%E3%83%9D%E3%82%A2%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E5%B9%B3%E5%9D%87)
    - [ポアソン分布の分散](#%E3%83%9D%E3%82%A2%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E5%88%86%E6%95%A3)
  - [ポワソンパラメーター $\lambda$の推定](#%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC-%5Clambda%E3%81%AE%E6%8E%A8%E5%AE%9A)
- [2. 条件付きポワソン分布：2019年統計検定準１級試験](#2-%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%832019%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%E6%BA%96%EF%BC%91%E7%B4%9A%E8%A9%A6%E9%A8%93)
  - [解答(1)](#%E8%A7%A3%E7%AD%941)
  - [解答(2): 条件付き分布と二項分布](#%E8%A7%A3%E7%AD%942-%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E5%88%86%E5%B8%83%E3%81%A8%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83)
- [3. ポワソン分布の適合度検定](#3-%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E9%81%A9%E5%90%88%E5%BA%A6%E6%A4%9C%E5%AE%9A)
  - [カイ二乗適合度検定](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E9%81%A9%E5%90%88%E5%BA%A6%E6%A4%9C%E5%AE%9A)
  - [練習問題：2019年統計検定準１級試験改題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C2019%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%E6%BA%96%EF%BC%91%E7%B4%9A%E8%A9%A6%E9%A8%93%E6%94%B9%E9%A1%8C)
- [Reference](#reference)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. ポワソン分布の性質
### ポアソン分布が確率分布であることの確認

$$
p_x(x) = \exp(-\lambda_x)\frac{\lambda_x^x}{x!}
$$

という形でポワソン分布に従う確率変数の密度関数を表現することができます. ここで $\sum_{x=0}^\infty p_x(x)=1$を確認します.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\sum_{x=0}^\infty p_x(x) & = \sum_{x=0}^\infty \exp(-\lambda_x)\frac{\lambda_x^x}{x!}\\
&= \exp(-\lambda_x) \sum_{x=0}^\infty \frac{\lambda_x^x}{x!}\\
&= \exp(-\lambda_x)\left(1 + \lambda_x + \frac{\lambda_x^2}{2!}+\cdots \right)\\
&= \exp(-\lambda_x) \exp(\lambda_x) \because \text{ マクローリン展開より}\\
&= 1
\end{align*}
$$
</div>

### ポアソン分布の平均と分散の導出
#### ポアソン分布の平均

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\sum_{x=0}^\infty \exp(-\lambda)\frac{\lambda^x}{x!}x &= \exp(-\lambda)\lambda\sum_{x=1}^\infty \frac{\lambda^{x-1}}{(x-1)!}\\
&= \exp(-\lambda)\lambda\sum_{x=1}^\infty \frac{\lambda^{x-1}}{(x-1)!}\\
&= \exp(-\lambda)\lambda\sum_{k=0}^\infty \frac{\lambda^{k}}{(k)!}\\
&= \exp(-\lambda)\lambda\exp(\lambda)\\
&= \lambda
\end{align*}
$$
</div>

#### ポアソン分布の分散

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\sum_{x=0}^\infty \exp(-\lambda)\frac{\lambda^x}{x!}x^2 &= \exp(-\lambda)\lambda\sum_{x=1}^\infty \frac{\lambda^{x-1}}{(x-1)!}x\\
&= \exp(-\lambda)\lambda\sum_{x=1}^\infty \frac{\lambda^{x-1}}{(x-1)!}(x-1 + 1)\\
&= \exp(-\lambda)\lambda \left(\lambda\sum_{x=2}^\infty \frac{\lambda^{x-2}}{(x-2)!}+\sum_{x=1}^\infty \frac{\lambda^{x-1}}{(x-1)!}\right)\\
&= \exp(-\lambda)\lambda (\lambda \exp(\lambda) + \exp(\lambda))\\
&= \lambda^2 + \lambda
\end{align*}
$$
</div>

従って、

$$
E[X^2] - E[X]^2 = \lambda^2 + \lambda - \lambda^2 = \lambda
$$

### ポワソンパラメーター $\lambda$の推定

まずLikelihood関数を定義します

<div class="math display" style="overflow: auto">
$$
L(\lambda) = \prod \exp(-\lambda)\frac{\lambda^x}{x!}
$$
</div>

これをlog-likelihood関数に変換し

<div class="math display" style="overflow: auto">
$$
\log L(\lambda) = -n\lambda + \sum (x\log(\lambda) - \log(x!)) \tag{1.1}
$$
</div>

(1.1)を$\lambda$で微分して０とおくと、

$$
\frac{\partial\log(L(\lambda))}{\partial\lambda}|_{\lambda = \lambda^*} = -n + \sum\frac{x}{\lambda^*} = 0
$$

従って

$$
\lambda^* = \frac{\sum x}{n}
$$

よって、標本平均によって、$\lambda$が推定できることがわかる.

## 2. 条件付きポワソン分布：2019年統計検定準１級試験

２つの確率変数 $X, Y$を考える. それぞれで独立に $\lambda = 3, 2$のポワソン分布に従うものとする.

$$
p_x(x) = \exp(-\lambda_x)\frac{\lambda_x^x}{x!}
$$

1. $X +Y$の従う分布を求めよ
2. $X + Y = 4$という条件のもと$X$が従う分布を求めよ

### 解答(1)

叩き込みによって$X+Y$が$\lambda = 5$のポワソン分布に従うことを示す.

$$
\begin{align*}
A &= X + Y\\
B & = X
\end{align*}
$$

という変数変換を考える. このとき$P(A, B)$は

$$
\begin{align*}
P(A, B) &= p_x(B)p_y(A+B)\\
&= \exp(-\lambda_x)\frac{\lambda_x^B}{B!}\exp(-\lambda_y)\frac{\lambda_y^{A+B}}{(A+B)!}
&= \exp(-\lambda_x-\lambda_y)\frac{\lambda_x^B\lambda_y^{A+B}}{B!(A-B)!}
\end{align*}
$$

次に

<div class="math display" style="overflow: auto">
$$
\begin{align*}
P(A) &= \sum_{b\in B}p_x(B)p_y(A+B)\\
&= \exp(-\lambda_x-\lambda_y)\sum_{b=0}^a\frac{\lambda_x^b\lambda_y^{A+b}}{b!(A-b)!}\\
&= \exp(-\lambda_x-\lambda_y)\left(\frac{\lambda_y^A}{A!} + \frac{\lambda_y^{A-1}\lambda_x}{(A-1)!}+\cdots + + \frac{\lambda_x^{A}}{A!}\right)\\
&= \exp(-\lambda_x-\lambda_y)\frac{(\lambda_x+\lambda_y)^A}{A!} \because \text{二項定理}\\
&= \exp(-5)\frac{5^A}{A!}
\end{align*}
$$
</div>

したがって、$X+Y$は$\lambda = 5$のポワソン分布に従うことがわかる。
なお平均、分散ともに5である.

> Python

まずシミュレーション用データを作成します

```python
## Library
import numpy as np
import pandas as pd
from scipy import stats
from scipy.stats import poisson
from scipy.stats import binom
from statsmodels.distributions.empirical_distribution import ECDF
from itertools import chain
import matplotlib.pyplot as plt

## Generating Data
np.random.seed(seed=42)
mu_x, mu_y = 3, 2
N = 1000

x, y = poisson.rvs(mu_x, size=N), poisson.rvs(mu_y, size=N)
z = poisson.rvs(mu_x + mu_y, size=N)
```

つぎに、生成した各ポワソン分布とポワソン確率変数の和のヒストグラムを確認する

```python
fig, ax = plt.subplots(1, 1,figsize=(10, 7))
bins_range = np.arange(0, max(chain(x, y)), 1)

ax.hist(x, density = True, bins = bins_range, alpha = 0.5, label = '$\lambda = 3$')
ax.hist(y, density = True, bins = bins_range, alpha = 0.5, label = '$\lambda = 2$')
ax.set_title('random sampling from poisson', fontsize=15)
ax.set_xlabel('score', fontsize=12)
ax.set_ylabel('density', fontsize=12)
plt.legend();
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211227-01.png?raw=true">

```python
fig, ax = plt.subplots(1, 1,figsize=(10, 7))
bins_range = np.arange(0, max(x + y), 1)

ax.hist(x + y, density = True, bins = bins_range, alpha = 0.5, label = '$x + y$')
ax.hist(z, density = True, bins = bins_range, alpha = 0.5, label = '$\lambda = 5$')
ax.set_title('random sampling from poisson', fontsize=15)
ax.set_xlabel('score', fontsize=12)
ax.set_ylabel('density', fontsize=12)
plt.legend();
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211227-02.png?raw=true">

一見、$X+Y$と$\lambda = 5$のポワソン分布間には差があるように見えるが、KS-testとQQ-plotで比較してみる.
なお、QQ-plotはx軸, y軸共に分位点で評価している(quantile(x) = 0.5に相当するxはyにおいてどの分位点として表れるか).

```python
def qqplot(x, y, title = None, xlabel = None, ylabel = None, plot = False, ax = None):
    """ 
    INPUT
        x, y : array_like, 1-Dimensional
            Two arrays of sample observations
    
    Returns:
        statistic: float
            KS statistic.
        pvalue: float
            One-tailed or two-tailed p-value.
        Figure:
            QQ-plot
            x-axis and y-axis is normalized between 0 and 1
    """
    
    sorted_x = sorted(x)
    x_xdf, y_cdf = ECDF(x), ECDF(y)
    ks_test = stats.ks_2samp(x, y)

    print(ks_test)

    if ax is None:
        fig, ax = plt.subplots(1, 1,figsize=(9, 9))
    
    if plot:
        ax.plot(x_xdf(sorted_x), y_cdf(sorted_x),lw=2, color='#0485d1')
    else:
        ax.scatter(x_xdf(sorted_x), y_cdf(sorted_x),lw=2, color='#0485d1')
    
    ax.axline([0, 0], [1, 1],lw=4, color='#A60628')
    ax.set_title(title  + '  (ks-test p-value: %.3f )'%ks_test[1] , fontsize=15)
    ax.set_xlabel(xlabel, fontsize=13)
    ax.set_ylabel(ylabel, fontsize=13)
    plt.legend()
```

このqq-plot関数を用いると

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211227-03.png?raw=true">

qq-plot及びKS testによると、$X+Y$は$\lambda = 5$のポワソン分布と異なっていると帰結することが難しいことがわかります (あくまで、帰無仮説は棄却できなかった).

- KS test: the two-sample Kolmogorov-Smirnov test 

### 解答(2): 条件付き分布と二項分布

<div class="math display" style="overflow: auto">
$$
\begin{align*}
P(X, Y|X+Y=4) &= \frac{P(X, Y)}{P(X + Y = 4)}\\
&= \left(\frac{\lambda_x}{\lambda_x + \lambda_y}\right)^x\left(\frac{\lambda_y}{\lambda_x + \lambda_y}\right)^y\frac{(x+y)!}{x!y!}
\end{align*}
$$
</div>

$$
p = \frac{\lambda_x}{\lambda_x + \lambda_y} 
$$

とおくと

$$
1 - p = \frac{\lambda_y}{\lambda_x + \lambda_y}
$$

であることに注意すると

$$
X\sim B\left(4, \frac{\lambda_x}{\lambda_x + \lambda_y}\right)
$$

に従っていることがわかる.

> Python

```python
## Generating Data
w = np.vstack([x, y, x+y])
x_2, y_2, z_2 = w[:, w[2,:] == 4]

## plot histogram
fig, ax = plt.subplots(1, 1,figsize=(10, 7))
bins_range = np.arange(0, max(chain(x, y)), 1)

ax.hist(x_2, density = True, bins = bins_range, alpha = 0.5, label = '$X_2\sim (X|x+y =4)$')
ax.set_title('random sampling from trunctaed poisson', fontsize=15)
ax.set_xlabel('$X_2$ sampling', fontsize=12)
ax.set_ylabel('density', fontsize=12)
plt.legend();
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211227-04.png?raw=true">

QQ plotで二項分布$B(4, 0.6)$と比較してみると

```python
r_x = binom.rvs(n=4, p=mu_x/(mu_x + mu_y), size=1000)
qqplot(x_2, r_x, 
        title = 'QQ-plot between two poisson',
        xlabel = '$X_2$ from truncated X',
        ylabel = 'binomial distribution $n = 4, p = 0.6$',
        ax = None)
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211227-05.png?raw=true">

## 3. ポワソン分布の適合度検定
### カイ二乗適合度検定

全体でn個のデータが$C_1, C_2, \cdots, C_K$のK個のカテゴリーデータに分類されそれぞれ、$X_1, \cdots X_K$個観測されたとします.
観測結果より推定されるそれぞれのカテゴリーに入る確率を$p_1, \cdots, p_K$とすると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
p_1 + p_2 + \cdots + p_K &= 1\\
X_1 + X_2 + \cdots + X_K &= n
\end{align*}
$$
</div>

が成り立ちます. このとき、各カテゴリーに入る理論確率を$\pi_1, \cdots, \pi_K$としたとき、観測データに基づいた確率分布が理論分布に等しいか否かを検定する問題は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
H_0& : p_1 = \pi_1, \cdots, p_K = \pi_K\\ 
H_1& : \exists i \in K \text{ s.t } p_i \neq \pi_i
\end{align*}
$$
</div>

と定式化できます. この検定問題の一つとしてカイ二乗適合度検定があります. 検定統計量は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
&\chi^2 = \sum\frac{(\text{観測度数} - \text{理論度数})^2}{\text{理論度数}}\\
&\chi^2(X, K, \pi)= \sum_{i=1}^K\frac{(X_i - n\pi_i)^2}{n\pi_i}
\end{align*}
$$
</div>

これをピアソンのカイ二乗検定統計量といい、$H_0$のもとで $\chi^2(X, K, \pi) \to_d \chi^2_{K-1}$に収束することが知られています. この検定量の棄却域は

$$
R = \{x\in \chi|\chi^2(X, K, \pi) > \chi^2_{K-1, \alpha} \}
$$

と一般には定義されます.

### 練習問題：2019年統計検定１級試験改題

クレーム件数|0|1|2|3|4|5|6|7|
---|---|---|---|---|---|---|---|---
度数|22|23|26|18|6|4|1|0

というクレーム件数データが与えられたとします. クレーム発生件数がポワソン分布に適合するか否かをピアソンのカイ二乗検定統計量を用いて検定せよ

> 解答

```python
## setting model parameter
N = 100
observed_lambda = 1.79

## geenrating data
x_range = np.arange(0, 8)
x = np.array([22, 23, 26, 18, 6, 4, 1, 0])

## poisson object
poisson_rv = poisson(observed_lambda)

## plot
fig, ax = plt.subplots(1, 1,figsize=(10, 7))
ax.bar(x_range, x, alpha = 0.5)
ax.plot(x_range, poisson_rv.pmf(x_range)*N)
ax.set_xlabel('outcome')
ax.set_ylabel('Frequency')
ax.set_title('compare the observed data and a theoretical distirbution')
;
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211227_3_1.png?raw=true">

つぎにピアソンのカイ二乗検定統計量を確かめてみます.

```python
from scipy.stats import chisquare

theoretical_x = poisson_rv.pmf(x_range)/sum(poisson_rv.pmf(x_range))*N ##厳密な計算ではない

chisquare(x, f_exp=theoretical_x)
>>> Power_divergenceResult(statistic=4.816678345153642, pvalue=0.6823233236771076)
```

カイ二乗検定統計量によると、帰無仮説は棄却されないことになります. ただし、元データの分散は2.03と計算され、平均の1.79とは大きく異なっていると思われます(ポワソン分布ならば、平均と分散は等しいはず). なのでカイ二乗検定統計量で帰無仮説が棄却されないとしても、必ずしも理論分布に従っていると結論付けることは難しいです.

## 4. Zero-inflated Poisson Model

特定の交差点における自動車事故の１日ごとの発生回数や、とある店舗の一日のクレーム発生件数は、ポワソン回帰モデルを適用することが妥当であるとされていますが、これらのデータは０を多く含んでいると考えられ、その頻度はポアソン分布よりおおくなることがあります. 0が過剰に含まれたままポワソン回帰してしまうと、過分散が起こる可能性があります.

このようば場合には、ゼロ過剰ポアソン分布(Zero-inflated Poisson Model, ZIP)を用いて対処することが考えられます. 

## Reference

- [高校数学の美しい物語>ポアソン分布の意味と平均・分散](https://manabitimes.jp/math/924)
- [scipy.stats.ks_2samp](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.ks_2samp.html)
- [scipy.stats.chisquare](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.chisquare.html)
- [UCLA Statistical Methods and Data Analysis > Zero-inflated Poisson Regression](https://stats.oarc.ucla.edu/stata/dae/zero-inflated-poisson-regression/)
