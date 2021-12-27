---
layout: post
title: "統計検定：ポワソン分布と条件付き分布"
subtitle: "２つの分布をvisualizationで比較"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
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

- [条件付きポワソン分布：2019年統計検定準１級試験](#%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%832019%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%E6%BA%96%EF%BC%91%E7%B4%9A%E8%A9%A6%E9%A8%93)
  - [解答(1)](#%E8%A7%A3%E7%AD%941)
  - [解答(2): 条件付き分布と二項分布](#%E8%A7%A3%E7%AD%942-%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E5%88%86%E5%B8%83%E3%81%A8%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83)
- [Reference](#reference)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 条件付きポワソン分布：2019年統計検定準１級試験

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


## Reference

- [scipy.stats.ks_2samp](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.ks_2samp.html)
