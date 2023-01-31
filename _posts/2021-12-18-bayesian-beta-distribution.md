---
layout: post
title: "ベータ分布の性質"
subtitle: "ベイズ統計入門 2/N"
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

- [ベータ分布の性質](#%E3%83%99%E3%83%BC%E3%82%BF%E5%88%86%E5%B8%83%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [ベータ分布の確率密度関数](#%E3%83%99%E3%83%BC%E3%82%BF%E5%88%86%E5%B8%83%E3%81%AE%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0)
  - [ベータ分布の平均, 分散, 最頻値の導出](#%E3%83%99%E3%83%BC%E3%82%BF%E5%88%86%E5%B8%83%E3%81%AE%E5%B9%B3%E5%9D%87-%E5%88%86%E6%95%A3-%E6%9C%80%E9%A0%BB%E5%80%A4%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [ベータ分布を用いた一様分布の表現](#%E3%83%99%E3%83%BC%E3%82%BF%E5%88%86%E5%B8%83%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AE%E8%A1%A8%E7%8F%BE)
- [一様分布に従う確率変数との順序とベータ分布の関係](#%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AB%E5%BE%93%E3%81%86%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%A8%E3%81%AE%E9%A0%86%E5%BA%8F%E3%81%A8%E3%83%99%E3%83%BC%E3%82%BF%E5%88%86%E5%B8%83%E3%81%AE%E9%96%A2%E4%BF%82)
  - [Simulationで確認](#simulation%E3%81%A7%E7%A2%BA%E8%AA%8D)
- [Appendix: ガンマ関数の定義](#appendix-%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E5%AE%9A%E7%BE%A9)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## ベータ分布の性質

ベータ分布は区間 $(0, 1)$ 上の確率分布です. つまり, ベータ分布に従う確率変数 $X$ は区間 $(0, 1)$ 上のみ値を取ります.

### ベータ分布の確率密度関数

確率変数 $X$ が $Beta(a, b), a>0, b>0$に従うとき, 確率密度関数は以下で与えられます

$$
f_X(x|a, b) = \begin{cases}
\frac{1}{B(a, b)}x^{a-1}(1 - x)^{b-1} & \text{ if } x\in (0,1)\\[8pt]
0 & \text{ otherwise}
\end{cases}
$$

$B(a, b)$はベータ関数であり, その形状は

$$
\begin{align*}
B(a, b) &= \int^1_0 x^{a-1}(1-x)^{b-1}dx\\[8pt]
        &= \frac{\Gamma(a)\Gamma(b)}{\Gamma(a+b)}
\end{align*}
$$


### ベータ分布の平均, 分散, 最頻値の導出

確率変数 $X$ が $Beta(a, b), a>0, b>0$に従うとします.

> ベータ分布の平均の導出

$$
\begin{align*}
\mathbb E[X] &= \int^{1}_0 x f(x)dx\\[8pt]
             &= \frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}\int^1_0 x^a (1-x)^{b-1}dx\\[8pt]
             &= \frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}\frac{\Gamma(a+1)\Gamma(b)}{\Gamma(a+b+1)}\\
             &= \frac{a}{a+b}
\end{align*}
$$

---

> ベータ分布の分散

$$
\begin{align*}
\mathbb E[X^2] &= \frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}\int^1_0 x^{a+1} (1-x)^{b-1}dx\\[8pt]
               &= \frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}\frac{\Gamma(a+2)\Gamma(b)}{\Gamma(a+b+2)}\\
               &= \frac{(a+1)a}{(a+b)(a+b+1)}
\end{align*}
$$

従って,

$$
\begin{align*}
\mathbb V(X) &= \mathbb E[X^2] - \mathbb E[X]^2\\[8pt]
             &= \frac{(a+1)a}{(a+b)(a+b+1)} - \frac{a^2}{(a+b)^2}\\[8pt]
             &= \frac{ab}{(a+b)^2(a+b+1)}
\end{align*}
$$

なお, $\mathbb E[X]=\mu$ とあらわしたとき分散は以下のようにも表現できる

$$
\mathbb V(X) = \frac{\mu(1-\mu)}{a+b+1}
$$


---

> ベータ分布の最頻値

$$
f'(x^*) = 0
$$

となるような $x^*$ が最頻値なので,

$$
\begin{align*}
f'(x) &=\frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)} [a-1 + (2-a-b)x]x^{a-2}(1-x)^{b-2} \\[8pt]
& \Rightarrow a-1 + (2-a-b)x = 0\\[8pt]
& \Rightarrow x^* = \frac{a-1}{a+b-2}
\end{align*}
$$

---

### ベータ分布を用いた一様分布の表現

確率変数 $X$ が $Beta(1, 1)$に従うとき, 確率密度関数は区間 $(0, 1)$ で

$$
f(x) = \frac{\Gamma(2)}{\Gamma(1)\Gamma(1)}x^{0}(1-x)^{0} = 1
$$

となり, $X\sim Unif(0, 1)$と等しいことがわかる.



## 一様分布に従う確率変数との順序とベータ分布の関係

<div class="math display" style="padding-left: 2em; overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

$X_1, X_2, \cdots, X_n$ が独立に一様分布 $U(0, 1)$ に従う時, これらを小さい順に並び替えるとします.

$$
X_{(1)} \leq X_{(2)} \leq \cdots X_{(n)} 
$$

このとき, k番目の確率変数 $X_{(k)}$はベータ分布 $Beta(k, n+1-k)$に従います.

</div>


**証明**

$F_k(x)$をk番目の確率変数の累積分布関数とします, i.e., $F_k(x) \equiv Pr(X_{(k)}\leq x)$

$X_i\sim U(0,1)$なので

$$
\begin{align*}
F_k(x) &= \sum_{i=k}^n _nC_i Pr(X_{(1)} \leq x, X_{(2)} \leq x, \cdots, X_{(i)} \leq x, X_{(i+1)} > x,\cdots, X_{(n)} > x)
       &= \sum_{i=k}^n _nC_i Pr(X_{(1)} \leq x)Pr(X_{(2)} \leq x) \cdots Pr(X_{(i)} \leq x)Pr(X_{(i+1)} > x)\cdots Pr(X_{(n)} > x)\\
       &= \sum_{i=k}^n _nC_i x^{i}(1-x)^{n-i}\\
       &= \frac{n!}{(k-1)!(n-k)!}\int^x_0 t^{k-1}(1-t)^{n-k}dt\\
       &\Rightarrow f_k(x) = \frac{n!}{(k-1)!(n-k)!}x^{k-1}(1-x)^{n-k}
\end{align*}
$$

従って, $X_{(k)}$はベータ分布 $Beta(k, n+1-k)$に従う.

**証明終了**

---

### Simulationで確認

PythonでのSimulation用コードを記載します.

```python
#%%
import numpy as np
from scipy.stats import beta
import matplotlib.pyplot as plt

plt.style.use('ggplot')

## parameter
np.random.seed(42)
iter_num = 100000
N = 20
K = 7

## GDP
X = np.random.uniform(0, 1, size = (iter_num, N))
X_K = np.sort(X, axis=1)[:, K-1] ##K番目の数値がほしいのでindexではK-1

## plot
fig, ax = plt.subplots(1, 1)
ax.set_xlim(0, 1)
ax.hist(X_K, density=True, bins='auto', histtype='stepfilled', alpha=0.2, label='simulation')

x_range = np.linspace(0, 1, 1000)
ax.plot(x_range, beta.pdf(x_range, K, N+1-K), 'b-', lw=1, alpha=0.6, label='beta pdf')
plt.legend();
```


## Appendix: ガンマ関数の定義

<div class="math display" style="padding-left: 2em; overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

正の実数 $x$ についてのガンマ関数は以下, 

$$
\Gamma(x)=\int_0^\infty t^{x−1}\exp(-t)dt
$$
</div>

> ガンマ関数の形状

```python
#%%
# Library
from itertools import accumulate
from math import gamma
import numpy as np
import matplotlib.pyplot as plt

# vectorize gamma
gamma_v = np.vectorize(gamma)

# data x, y from gamma
x = np.linspace(0.001, 6, 1000)
y = gamma_v(x)

# product
x_2 = np.arange(1, 6)
y_2 = list(accumulate(x_2, lambda a, b: a*(b-1)))

# plot gamma
fig = plt.figure(figsize = (6, 6))
ax = fig.add_subplot(111)
ax.set_title("Gamma Function", size = 15)
ax.grid()
ax.set_xlim(0, 5.5)
ax.set_ylim(0, 30)
ax.set_xlabel("x", size = 14, labelpad = 10)
ax.set_ylabel("Gamma(x)", size = 14, labelpad = 10)

ax.plot(x, y, color = "darkblue", label='gamma function')
ax.scatter(x_2, y_2, color = "darkblue", label='factorial')
plt.legend()
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20211218_gamma_plot.png?raw=true">

> ガンマ関数の性質

<div class="math display" style="padding-left: 2em; overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

任意の正の実数 $x$ に対して, 

$$
\Gamma(x+a) = \Gamma(x)
$$
</div>

## References

> 関連ポスト

- [Ryo's Tech Blog > Flip a Coin and Bayesian estimation](https://ryonakagami.github.io/2021/12/17/bayesian-basic/#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C-flip-a-coin-and-bayesian-estimation)