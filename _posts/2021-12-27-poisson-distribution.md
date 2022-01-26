---
layout: post
title: "統計検定：ポワソン分布と条件付き分布"
subtitle: "MLE, Method of Moment, EMアルゴリズムによるパラメータ推定"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
uu_cnt: 100
session_cnt: 100 
tags:

- 統計
- 統計検定
- Data visualization
- ポワソン分布
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
    - [モーメント母関数からの期待値と分散の導出](#%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88%E6%AF%8D%E9%96%A2%E6%95%B0%E3%81%8B%E3%82%89%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%A8%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [ポワソンパラメーター $\lambda$の推定](#%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC-%5Clambda%E3%81%AE%E6%8E%A8%E5%AE%9A)
  - [ポワソン分布の最頻値の導出](#%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E6%9C%80%E9%A0%BB%E5%80%A4%E3%81%AE%E5%B0%8E%E5%87%BA)
- [2. 条件付きポワソン分布](#2-%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83)
  - [2016年統計検定１級試験統計応用（理工学）問４改題](#2016%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%EF%BC%91%E7%B4%9A%E8%A9%A6%E9%A8%93%E7%B5%B1%E8%A8%88%E5%BF%9C%E7%94%A8%E7%90%86%E5%B7%A5%E5%AD%A6%E5%95%8F%EF%BC%94%E6%94%B9%E9%A1%8C)
    - [解答 (1)：モーメント母関数と条件付き期待値](#%E8%A7%A3%E7%AD%94-1%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88%E6%AF%8D%E9%96%A2%E6%95%B0%E3%81%A8%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E6%9C%9F%E5%BE%85%E5%80%A4)
    - [解答(2): 数値解を二分探索法で計算する](#%E8%A7%A3%E7%AD%942-%E6%95%B0%E5%80%A4%E8%A7%A3%E3%82%92%E4%BA%8C%E5%88%86%E6%8E%A2%E7%B4%A2%E6%B3%95%E3%81%A7%E8%A8%88%E7%AE%97%E3%81%99%E3%82%8B)
    - [解答(3): MLEを用いたパラメーターの数値計算推定](#%E8%A7%A3%E7%AD%943-mle%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AE%E6%95%B0%E5%80%A4%E8%A8%88%E7%AE%97%E6%8E%A8%E5%AE%9A)
  - [2019年統計検定準１級試験](#2019%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%E6%BA%96%EF%BC%91%E7%B4%9A%E8%A9%A6%E9%A8%93)
    - [解答(1)：ポワソン分布の部分和](#%E8%A7%A3%E7%AD%941%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E9%83%A8%E5%88%86%E5%92%8C)
    - [解答(2): 条件付き分布と二項分布](#%E8%A7%A3%E7%AD%942-%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E5%88%86%E5%B8%83%E3%81%A8%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83)
- [3. ポワソン分布の適合度検定](#3-%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E9%81%A9%E5%90%88%E5%BA%A6%E6%A4%9C%E5%AE%9A)
  - [カイ二乗適合度検定](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E9%81%A9%E5%90%88%E5%BA%A6%E6%A4%9C%E5%AE%9A)
  - [練習問題：2019年統計検定１級試験改題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C2019%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%EF%BC%91%E7%B4%9A%E8%A9%A6%E9%A8%93%E6%94%B9%E9%A1%8C)
- [4. Zero-inflated Poisson Model](#4-zero-inflated-poisson-model)
  - [モーメント法による推定](#%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88%E6%B3%95%E3%81%AB%E3%82%88%E3%82%8B%E6%8E%A8%E5%AE%9A)
  - [MLEによる推定その１](#mle%E3%81%AB%E3%82%88%E3%82%8B%E6%8E%A8%E5%AE%9A%E3%81%9D%E3%81%AE%EF%BC%91)
  - [MLEによる推定その2: EMアルゴリズム](#mle%E3%81%AB%E3%82%88%E3%82%8B%E6%8E%A8%E5%AE%9A%E3%81%9D%E3%81%AE2-em%E3%82%A2%E3%83%AB%E3%82%B4%E3%83%AA%E3%82%BA%E3%83%A0)
- [Appendix: MLE vs MLE with EM vs Method of Moment](#appendix-mle-vs-mle-with-em-vs-method-of-moment)
- [Reference](#reference)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. ポワソン分布の性質
### ポアソン分布が確率分布であることの確認

$$
p_x(x) = \exp(-\lambda_x)\frac{\lambda_x^x}{x!}, \ \ x = 0, 1, 2, 3,\cdots 
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

> ポアソン分布の平均

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

> ポアソン分布の分散

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

#### モーメント母関数からの期待値と分散の導出

> モーメント母関数の導出

モーメント母関数は（存在するならば）、$M_X(t) = \mathbf E[\exp(tX)]$と定義されます. 従って、

$$
\begin{align*}
M_X(t) &= \sum_{x=0}^\infty \exp(tx)\exp(-\lambda)\frac{\lambda^x}{x!}\\
&= \exp(-\lambda) \sum \frac{(\exp(t)\lambda)^x}{x!}\\
&= \exp(-\lambda)\exp(\exp(t)\lambda)\\
&= \exp(\lambda(\exp(t) - 1))
\end{align*}
$$

従って、期待値と分散は

$$
\begin{align*}
E[X] &= M_X'(0)\\
&= \lambda\exp(t)[\exp(\lambda(\exp(t)-1))]|_{t=0}\\
&= \lambda
\end{align*}
$$

<div class="math display" style="overflow: auto">
$$
\begin{align*}
E[X^2] &= M_X^{''}(0)\\
&= \{\lambda\exp(t)[\exp(\lambda(\exp(t)-1))] + (\lambda\exp(t))^2[\exp(\lambda(\exp(t)-1))]\}|_{t=0}\\
&= \lambda + \lambda^2
\end{align*}
$$
</div>

従って、$V(X) = E[X^2] - E[X]^2 = \lambda$

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

### ポワソン分布の最頻値の導出

$$
\begin{align*}
\frac{p(x+1)}{p(x)} &= \frac{\exp(-\lambda)\lambda^{x+1}/(x+1)!}{\exp(-\lambda)\lambda^{x}/x!}\\
&= \frac{\lambda}{x+1} \tag{A}
\end{align*}
$$

(A)は$x$について単調減少関数なので 

$$
\begin{align*}
&\frac{\lambda}{x+1} \leq 1\\
&\Rightarrow x \geq \lambda - 1
\end{align*}
$$

を満たす$x$の最小値が最頻値となる. ただし、$\lambda$が整数値を取る場合は $x = \lambda-1$, $x= \lambda$が最頻値となる.

> Python

```python
def select_most_frequent_point(lambda_mu):
    """ 
    Description
        return the tuple of the most frequent datapoint and lambda_mu
        
        Note:
          When the most frequent datapoint are more than one datapoint, it returns the smaller integer datapoint
      
    INPUT
        lambda_mu:
            poisson lambda
    
    Returns:
        x: integer
            the most frequent datapoint based on the poisson distribution with the input lambda.

        x_theory: integer
           the analytical solution of the most frequent datapoint

        x_hacked: integer
           the datapoint which is caucluated by an easy way
           max(np.int64(np.ceil(lambda_mu - eps)) - 1, 0)

        lambda: float
            the poisson parameter.
            
    """
    eps = 1e-18

    x_range = np.arange(0, 100)
    x_index = np.argmax(np.around(poisson.pmf(x_range, lambda_mu), decimals=8)) ##HACK: 有効桁は小数点以下8桁
    x_theory = np.min(x_range[x_range >= lambda_mu - 1])
    x_tips = max(np.int64(np.ceil(lambda_mu - eps)) - 1, 0)

    return x_range[x_index], x_theory, x_tips, lambda_mu

### simulation lambda_range
lambda_range = np.linspace(0, 50, 201)

### create the object which can calculate the most frequent datapoint and compute vectorization
vectorized_select_most_frequent_point = np.vectorize(select_most_frequent_point)

### caculate the simulation
x_simulated, x_theory, x_hacked, lambda_param = vectorized_select_most_frequent_point(lambda_range)

### compare x_simulated with x_theory
print(np.array_equal(x_simulated, x_theory, equal_nan=True))

### compare x_theory with x_hacked
print(np.array_equal(x_theory, x_hacked, equal_nan=True))
```

## 2. 条件付きポワソン分布

### 2016年統計検定１級試験統計応用（理工学）問４改題

ある会社のCS部門では業務の一つとして、お客様からの商品に関するクレーム対応をしています. 一日に発生したクレーム件数は長年の経験によりポワソン分布に従っていると事前に知られていたとします.
一日に発生したクレーム件数を確率変数$X$として、過去のクレーム件数のデータをCS部門へのヒアリングによって収集したところ以下の結果となりました.

|1日単位のクレーム発生件数|頻度(観測された日数)|
|---|---|
|0件|不明|
|1件|15日|
|2件|12日|
|3件|10日|
|4件|3日|
|5件|2日|
|6件以上|なし|

クレーム件数が０件の日にちはCS部門で把握しておらず、また過去何日の調査なのかも現在わかっていないため上記のデータとなったとCS部門から説明がありました. 
このデータを用いて、一日あたりのクレーム発生件数のポワソンパラメータを識別したいとします.

#### 解答(1)：モーメント母関数と条件付き期待値

$Y\sim \{X\|X\geq 1\}$とします. この時、確率変数$Y$の確率密度関数$f(y)$は

$$
f(y) = \frac{1}{1 - \exp(-\lambda)}\frac{\lambda^y\exp(-\lambda)}{y!}
$$

このとき、$Y$についてのモーメント母関数は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
M_y(t) &= E[\exp(tY)]\\
&= \sum_{y=1}^\infty \frac{1}{1 - \exp(-\lambda)}\frac{\lambda^y\exp(-\lambda)}{y!} \exp(ty)\\
&= \frac{\exp(-\lambda)}{1 - \exp(-\lambda)}\sum \frac{(\exp(t)\lambda)^y}{y!}\\
&= \frac{\exp(-\lambda)}{1 - \exp(-\lambda)}(\exp[\exp(t)\lambda]-1)\quad\quad\tag{2.1}
\end{align*}
$$
</div>

モーメント母関数が表現できると期待値を解析的に表現することができます.

$$
\begin{align*}
E[Y] &= M_y'(0)\\
&= \frac{\exp(-\lambda)}{1 - \exp(-\lambda)} \exp[\exp(0)\lambda]\exp(0)\lambda\\
&= \frac{\lambda}{1 - \exp(-\lambda)}
\end{align*}
$$

従って、これの標本対応を考えると

$$
\bar Y = \frac{\hat\lambda}{1 - \exp(-\hat\lambda)} \tag{2.2}
$$

RHSは$\hat\lambda$について（定義域内ならば）狭義増加関数なので$\hat\lambda = F(\bar Y)$となるような逆関数が存在します. 

$\hat\lambda > 0, \bar Y > 0$を満たすことは自明なので、

<div class="math display" style="overflow: auto">
$$
\begin{align*}
&\frac{1}{\bar Y} = \frac{1 - \exp(-\hat\lambda)}{\hat\lambda}\\ 
&\Rightarrow \hat\lambda = (1 - \exp(-\hat\lambda))\bar Y\\
&\Rightarrow \hat\lambda\exp(\hat\lambda) = \frac{\exp(\hat\lambda) - 1}{1/\bar Y}\\
&\Rightarrow (\hat\lambda - \bar Y)\exp(\hat\lambda) = -\bar Y\\
&\Rightarrow (\hat\lambda - \bar Y)\exp(\hat\lambda)\exp(\bar Y) = -\bar Y\exp(-\bar Y)\\
&\Rightarrow (\hat\lambda - \bar Y)\exp(\hat\lambda - \bar Y) = -\bar Y\exp(-\bar Y)\tag{2.3}
\end{align*}
$$
</div>

(2.3)の両辺にランベルトの$W_0$関数(i.e., $y = x\exp(x)$の逆関数)を適用したいとします.

- $-\bar Y < -1$であること
- $\hat\lambda - \bar Y = \hat\lambda(1 - 1/(1 - \exp(-\hat\lambda))) > -1$ s.t. $\hat\lambda > 0$

以上に注意すると、

$$
(\hat\lambda - \bar Y) = W_0\left(-\bar Y\exp(-\bar Y)\right)
$$

従って、

$$
\hat\lambda = W_0\left(- \frac{\bar Y}{\exp(\bar Y)} \right) + \bar Y
$$

> Pythonでパラメータを計算

```python
from scipy.special import lambertw

## Generating Data
y = np.array([1, 2, 3, 4, 5])
freq = np.array([15, 12, 10, 3, 2])

## Estimation
lambert_w = np.average(y, weights = freq)
estimated_lambda = lambertw(-lambert_w/np.exp(lambert_w)) + lambert_w
print(estimated_lambda)
>>> 1.813224064133259 + 0j
```

従って $\lambda \simeq 1.813$.

#### 解答(2): 数値解を二分探索法で計算する

ランベルトのW関数を用いずにナイーブに二分探索法で数値計算してみます.
二分探索法を用いる根拠としては、今回の関数

$$
\frac{\hat\lambda}{1 - \exp(-\hat\lambda)}
$$

が$\hat\lambda$について定義域を上手く定めれば、連続かつ単調増加関数である性質に準拠しています（see 中間値の定理）.


```python
def binary_search(func, y_min, y_max, value, eps):
    left = y_min             # left seach area
    right = y_max            # right seach area
    while left <= right:
        mid = (left + right) / 2            # calculate the mid
        if abs(func(mid) - value) < eps:
            # return the numerical solution
            return mid
        elif func(mid) < value:
            # set the left at the mid beacuse the objective function is a strictly increasing function
            left = mid
        else:
            # set the right at the mid
            right = mid 
    return None            # cannot compute

def objective_function(x):
    return x/(1 - np.exp(-x))

y = np.array([1, 2, 3, 4, 5])
freq = np.array([15, 12, 10, 3, 2])
bar_y = np.average(y, weights = freq)

print(binary_search(func=objective_function, y_min=0, y_max =6, value = bar_y, eps = 1e-8))
>>> 1.8132240548729897
```

ランベルトのW関数を用いた計算結果と近しい結果を得ることができます. 

#### 解答(3): MLEを用いたパラメーターの数値計算推定

基本に忠実にMaximum Likelihood Estimationでパラメーター$\lambda$を推定します.

```python
from scipy.optimize import minimize
import math
import numpy as np

class ConditionalPoissonRegression:

    def __init__(self, data):
        self.data = data

    @staticmethod
    def conditiona_poisson_pmf(x, theta):
        vec_factorial = np.vectorize(math.factorial)
        return (theta**x * np.exp(-theta) / vec_factorial(x)) / (1 - np.exp(-theta))
    
    def neg_loglike(self, theta, _data):
        return np.sum(np.log(self.conditiona_poisson_pmf(x = _data, theta = theta)))

    def fit(self):
        observed_mean = np.mean(self.data)
        f = lambda theta: -self.neg_loglike(theta = theta, _data = self.data)
        return minimize(f, observed_mean, method = 'Nelder-Mead', options={'disp': True})
## Generating Data
y = np.array([1, 2, 3, 4, 5])
freq = np.array([15, 12, 10, 3, 2])
data = np.repeat(y, freq, axis=0)

poisson_mle = ConditionalPoissonRegression(data=data)

poisson_mle.fit()
```

Then,

```raw
Optimization terminated successfully.
         Current function value: 59.865722
         Iterations: 15
         Function evaluations: 30
 final_simplex: (array([[1.81320801],
       [1.8132609 ]]), array([59.86572216, 59.86572217]))
           fun: 59.86572215563589
       message: 'Optimization terminated successfully.'
          nfev: 30
           nit: 15
        status: 0
       success: True
             x: array([1.81320801])
```

MLEでも`1.813`とランベルトのW関数を用いた計算方法と近似の値が計算することができます.

#### 参考： モーメント法に基づく分散の導出

(2.1)の内容をもとに更に計算すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
M_y(t)     &= \frac{\exp(-\lambda)}{1 - \exp(-\lambda)}(\exp[\exp(t)\lambda]-1)\\
M_y'(t)    &= \frac{\exp(-\lambda)}{1 - \exp(-\lambda)} \exp[\exp(t)\lambda]\exp(t)\lambda\\
M_y^{''}(t)&= \frac{\exp(-\lambda)}{1 - \exp(-\lambda)} \exp[\exp(t)\lambda]\exp(t)\lambda(\lambda\exp(t)+1)
\end{align*}
$$
</div>

従って、

$$
\begin{align*}
M_y^{''}(0) = \frac{\lambda(\lambda+1)}{1 - \exp(-\lambda)} \quad\quad\tag{2.4}
\end{align*}
$$

$V(X) = E[X^2] - E[X]^2$なので(2.2)と(2.4)を組み合わせると

$$
V(Y|Y>1)= \frac{\lambda - \lambda(\lambda+1)\exp(-\lambda)}{(1 - \exp(-\lambda))^2}
$$

> Python

```python
y = np.array([1, 2, 3, 4, 5])
freq = np.array([15, 12, 10, 3, 2])

## MoM var
def calculate_conditionalvar(x):
    denominator = (1 - np.exp(-x))**2
    numerator = x - x*(x+1)*np.exp(-x)

    return numerator/denominator

theory_var = calculate_conditionalvar(x = lambert_w)

## 不偏分散
data_var = np.average((y - lambert_w)**2, weights = freq)*np.sum(freq)/(np.sum(freq) - 1)

print(data_var, theory_var)
>>> 1.3130081300813008 1.7610396317212755
```

- Poisson分布によるFitが良い訳ではなさそう


### 2019年統計検定準１級試験

２つの確率変数 $X, Y$を考える. それぞれで独立に $\lambda = 3, 2$のポワソン分布に従うものとする.

$$
p_x(x) = \exp(-\lambda_x)\frac{\lambda_x^x}{x!}
$$

1. $X +Y$の従う分布を求めよ
2. $X + Y = 4$という条件のもと$X$が従う分布を求めよ

#### 解答(1)：ポワソン分布の部分和

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
P(A, B) &= p_x(B)p_y(A-B)\\
&= \exp(-\lambda_x)\frac{\lambda_x^B}{B!}\exp(-\lambda_y)\frac{\lambda_y^{A-B}}{(A-B)!}\\
&= \exp(-\lambda_x-\lambda_y)\frac{\lambda_x^B\lambda_y^{A+B}}{B!(A-B)!}
\end{align*}
$$

次に

<div class="math display" style="overflow: auto">
$$
\begin{align*}
P(A) &= \sum_{b\in B}p_x(B)p_y(A-B)\\
&= \exp(-\lambda_x-\lambda_y)\sum_{b=0}^a\frac{\lambda_x^b\lambda_y^{A-b}}{b!(A-b)!}\\
&= \exp(-\lambda_x-\lambda_y)\left(\frac{\lambda_y^A}{A!} + \frac{\lambda_y^{A-1}\lambda_x}{(A-1)!}+ \frac{\lambda_y^{A-2}\lambda_x^2}{2!(A-2)!}\cdots +  \frac{\lambda_x^{A}}{A!}\right)\\
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

#### 解答(2): 条件付き分布と二項分布

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

chisquare_poisson_pmf = lambda x: np.where(x < 7, 1, 0) * poisson_rv.pmf(x) + (1 - np.where(x < 7, 1, 0)) * (1 - poisson_rv.cdf(x-1))
theoretical_x = chisquare_poisson_pmf(x_range)*N

chisquare(x, f_exp=theoretical_x)
>>> Power_divergenceResult(statistic=4.873492084753685, pvalue=0.6753982780281518)
```

カイ二乗検定統計量によると、帰無仮説は棄却されないことになります. ただし、元データの分散は2.03と計算され、平均の1.79とは大きく異なっていると思われます(ポワソン分布ならば、平均と分散は等しいはず). なのでカイ二乗検定統計量で帰無仮説が棄却されないとしても、必ずしも理論分布に従っていると結論付けることは難しいです.

## 4. Zero-inflated Poisson Model

特定の交差点における自動車事故の１日ごとの発生回数や、とある店舗の一日のクレーム発生件数は、ポワソン回帰モデルを適用することが妥当であるとされていますが、これらのデータは０を多く含んでいると考えられ、その頻度はポアソン分布よりおおくなることがあります. 0が過剰に含まれたままポワソン回帰してしまうと、過分散が起こる可能性があります.

このようば場合には、ゼロ過剰ポアソン分布(Zero-inflated Poisson Model, ZIP)を用いて対処することが考えられます. 

ZIP分布の確率関数は以下です:

$$
\begin{align*}
f(Y_i = y) = \begin{cases}Pr(Y_i = 0)&= w + (1 - w)\exp(-\lambda)\frac{\lambda^0}{0!}\\
Pr(Y_i \geq 1)&= (1 - w)\exp(-\lambda)\frac{\lambda^y_i}{y_i!}\end{cases}
\end{align*}
$$

これは目的変数の従う分布が確率$w$で値0をとり、確率$1-w$でポワソン分布に従うことを示しています. 実際に $\sum_{y=0}f(y) = 1$は自明です.

ZIPのパラメータ $(\lambda, w)$の推定方法はモーメント法と（EMアルゴリズムをもちいた）MLEが考えられます.

### モーメント法による推定

- モーメント法は後述するMLEに対して、closed-formでパラメーターを表すことができるメリットがあります
- モーメント法もMLEと比べasymptotically equallt efficientと知られています

ただし、infrequent with large samples but not so infrequent with small samplesという特徴を持つデータに対してモーメント法を用いると、推定されたパラメーターがパラメータースペース外に陥るリスクがあります 
　

<div class="math display" style="overflow: auto">
$$
M_Y(t) = E[\exp(tY)] =  w + (1 - w)\exp(-\lambda)\exp(\exp(t)\lambda)
$$
</div>

従って、

<div class="math display" style="overflow: auto">
$$
\begin{align*}
M_Y'(t) &= (1 - w)\lambda\exp(-\lambda)\exp(t)\exp(\exp(t)\lambda)\\
M_Y^{''}(t) &= (1 - w)\lambda\exp(-\lambda)\exp(t)\exp(\exp(t)\lambda)[1 + \lambda\exp(t)]
\end{align*}
$$
</div>

従って、

<div class="math display" style="overflow: auto">
$$
\begin{align*}
M_Y'(0) &= E[Y] = (1 - w)\lambda\\
M_Y^{''}(0) &= E[Y^2] = (1 - w)\lambda(1 + \lambda)
\end{align*}
$$

を得ます. これを連立させると

$$
\begin{align*}
\lambda & = \frac{E[Y^2]}{E[Y]} - 1\\
w & = 1 - \frac{E[Y]^2}{E[Y^2] - E[Y]}
\end{align*}
$$

よってこれを標本対応によって推定します. 上述の[練習問題：2019年統計検定１級試験改題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C2019%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%EF%BC%91%E7%B4%9A%E8%A9%A6%E9%A8%93%E6%94%B9%E9%A1%8C)を例に推定すると

```python
import numpy as np
from scipy.optimize import minimize
import math
import matplotlib.pyplot as plt

data = np.repeat(np.arange(0, 7), np.array([22, 23, 26, 18, 6, 4, 1]))
sample_mean = np.mean(data)
sample_second_moment = np.mean(data**2)

theta_moment = sample_second_moment / sample_mean - 1, 1 - sample_mean **2 / (sample_second_moment - sample_mean)
print(theta_moment)
>> (1.910614525139665, 0.06312865497076026)
```

> REMARKS

- 後述するMLE手法の推定値とは結構ズレがある(MLE手法による推定値の方がLog-lossの観点からは好ましい結果となっている)
- おそらくN = 100というsmall sample dataを用いて推定してしまったためかと思われる

### MLEによる推定その１

まずLikelihood functionを定義します:

<div class="math display" style="overflow: auto">
$$
\begin{align*}
L(\lambda, w|Y) = \prod_{y_i} \left[w + (1 - w)\exp(-\lambda)\right]^{1(y_i=0)}\left((1 - w)\exp(-\lambda)\frac{\lambda^{y_i}}{y_i!}\right)^{1 - 1(y_i=0)}\quad\quad\tag{4.1}
\end{align*}
$$
</div>

(4.1)にはclosed form solutionは存在しないので数値計算解をlog-lossの最小化によって計算します

```python
from scipy.optimize import minimize
import math
import numpy as np

class ZeroInflatedPoissonRegression:

    def __init__(self, data):
        self.data = data
        self.init_value = None

    @staticmethod
    def zip_pmf(x, theta):
        vec_factorial = np.vectorize(math.factorial)
        return (theta[1] + (1 - theta[1])*np.exp(-theta[0]))**np.where(x > 0, 0, 1) * ((1 - theta[1]) * np.exp(-theta[0]) * theta[0]**x / vec_factorial(x)) **np.where(x > 0, 1, 0)

    def estimate_initial_value(self):
        sample_first_moment = np.mean(self.data)
        sample_second_moment = np.mean(self.data**2)

        theta_moment = sample_second_moment / sample_first_moment - 1, 1 - sample_first_moment **2 / (sample_second_moment - sample_first_moment)
        return theta_moment
    
    def neg_loglike(self, theta, _data):
        return np.sum(np.log(self.zip_pmf(x = _data, theta = theta)))

    def fit(self):
        f = lambda theta: -self.neg_loglike(theta = theta, _data = self.data)
        self.init_value = self.estimate_initial_value()

        return minimize(fun = f, x0=self.init_value, method = 'Nelder-Mead', options={'disp': True})


## Generating Data
data = np.repeat(np.arange(0, 7), np.array([22, 23, 26, 18, 6, 4, 1]))

## Create the instance
poisson_mle = ZeroInflatedPoissonRegression(data=data)

## fit
poisson_mle.fit()
```

Then,

```raw
Optimization terminated successfully.
         Current function value: 168.338102
         Iterations: 30
         Function evaluations: 58
 final_simplex: (array([[1.97707489, 0.09462929],
       [1.977147  , 0.09463945],
       [1.97714908, 0.0946238 ]]), array([168.33810206, 168.33810208, 168.33810215]))
           fun: 168.33810205717472
       message: 'Optimization terminated successfully.'
          nfev: 58
           nit: 30
        status: 0
       success: True
             x: array([1.97707489, 0.09462929])
```

### MLEによる推定その2: EMアルゴリズム

sample size $N$のうち, mがゼロ過剰部分、つまり値0をとり、残りの$N-m$がポワソン分布に従うとまず仮定します. この仮定の下、Likelihood functionを定義すると

<div class="math display" style="overflow: auto">
$$
L(\lambda, w) = w^m\prod(1-w)\exp(-\lambda)\frac{\lambda^{y_i}}{y_i!}\quad\quad\tag{4.2}
$$
</div>

(4.2)をLog-Likelihoodへ変換すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
l(\lambda, w)= m\log(w) + (N-m)\log(1-w) - (N-m)\lambda + \log(\lambda)\sum y_i - \sum\log(y_i) \quad\quad\tag{4.3}
\end{align*}
$$
</div>

(4.3)のFOCsをとると

$$
\begin{align*}
\lambda &= \sum \frac{y_i}{N-m}\\
w &= \frac{m}{N}
\end{align*}
$$

を得ます. $f_0$を$y_i=0$となる観測度数とすると、$y_i \neq 0$となる観測数の期待値は 

$$
N - f_0 = N - m - N(1 - w)\exp(-\lambda)
$$

この式を変形すると

$$
m = \frac{f_0 - N \exp(-\lambda)}{1 - \exp(-\lambda)} \quad\quad\tag{4.4}
$$

よって、$\lambda, m$に関して以下のupdate functionを得ます.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
m_(t+1) &= \frac{f_0 - N \exp(-\lambda_t)}{1 - \exp(-\lambda_t)}\\
\lambda_{t+1} &= \sum \frac{y_i}{N-m_{t+1}}
\end{align*}
$$
</div>

このupdate ruleに基づいたパラメーターの推定はEMアルゴリズムと言われます.

> REMARKS

- この問題に関しては、初期値の$\lambda_0$は条件付きポワソンで推定すれば良い

## Appendix: MLE vs MLE with EM vs Method of Moment

- コードだけ紹介します
- サンプルサイズや$w,\lambda$を変化させて推定量の分布を確認することができます
- Method of Momentは若干、推定量の分散が大きいように思われる


```python
from scipy.optimize import minimize
import math
import numpy as np
from scipy.special import lambertw
import matplotlib.pyplot as plt

class ZeroInflatedPoissonRegression:

    def __init__(self, data):
        self.data = data
        self.init_value = None

    @staticmethod
    def zip_pmf(x, theta):
        vec_factorial = np.vectorize(math.factorial)
        return (theta[1] + (1 - theta[1])*np.exp(-theta[0]))**np.where(x > 0, 0, 1) * ((1 - theta[1]) * np.exp(-theta[0]) * theta[0]**x / vec_factorial(x)) **np.where(x > 0, 1, 0)
    
    @staticmethod
    def em_update(x, theta):    
        next_theta_1 = (len(x[x < 1]) - len(x) * np.exp(-theta[0]))/ (1 - np.exp(-theta[0])) 
        next_theta_0 = np.sum(x)/(len(x) - next_theta_1)

        return [next_theta_0, next_theta_1]

    def estimate_conditional_poisson(self):
        lambert_w = np.mean(self.data[self.data > 0])
        estimated_lambda = lambertw(-lambert_w/np.exp(lambert_w), 0) + lambert_w
        
        return estimated_lambda.real

    def method_of_moment(self):
        sample_mean = np.mean(self.data)
        sample_second_moment = np.mean(self.data**2)

        theta_moment = [sample_second_moment / sample_mean - 1, 1 - sample_mean **2 / (sample_second_moment - sample_mean)]
        return theta_moment
    
    def neg_loglike(self, theta, _data, normalize = False):
        if normalize:
            theta = theta[0], theta[1]/len(_data)

        return np.sum(np.log(self.zip_pmf(x = _data, theta = theta)))

    def fit(self):
        f = lambda theta: -self.neg_loglike(theta = theta, _data = self.data)
        self.init_value = self.method_of_moment()

        return minimize(fun = f, x0=self.init_value, method = 'Nelder-Mead', options={'disp': True})

    def em_fit(self, eps = 1e-10):
        lambda_t = self.estimate_conditional_poisson()
        m_t = len(self.data[self.data < 1])
        theta = [lambda_t, m_t]
        next_theta = self.em_update(self.data, theta)

        while abs(self.neg_loglike(theta = next_theta, _data = self.data, normalize=True) - self.neg_loglike(theta = theta, _data = self.data, normalize=True)) > eps:
            theta = next_theta
            next_theta = self.em_update(self.data, theta)
        
        next_theta[1] = next_theta[1]/len(self.data)

        return next_theta
        

## Generating Data
#data = np.repeat(np.arange(0, 7), np.array([22, 23, 26, 18, 6, 4, 1]))
#
## Create the instance
#poisson_mle = ZeroInflatedPoissonRegression(data=data)
#
## fit
#res_mle = poisson_mle.fit().x
#res_em = poisson_mle.em_fit()
#res_mom = poisson_mle.method_of_moment()
#
#print(res_mle, res_em, res_mom)

N = 100
w = 0.2
poisson_lambda = 2.5
iter_num = 0

mle = []
mle_em = []
mom = []


while iter_num < 1000:
    data = poisson.rvs(poisson_lambda , size=N)
    lottery = np.random.uniform(0, 1, N)
    data = np.where(lottery > w, data, 0)

    ## Create the instance
    poisson_mle = ZeroInflatedPoissonRegression(data=data)

    ## fit
    res_mle = list(poisson_mle.fit().x)
    res_em = poisson_mle.em_fit()
    res_mom = poisson_mle.method_of_moment()

    mle.append(res_mle)
    mle_em.append(res_em)
    mom.append(res_mom)

    iter_num += 1


fig, ax = plt.subplots(1, 3, sharex=True, figsize=(21, 9))
index = 0
bin_width = 0.1

_bin = np.arange(min(np.array(mom)[:,index])*0.7, max(np.array(mom)[:,index])*1.2, bin_width)

ax[0].hist(np.array(mom)[:,index], bins=_bin,
             color='r',
             alpha=0.5)
ax[0].set_title('Method of Moment: Mean = {:.2f}, Var= {:.2f}'.format(np.mean(np.array(mom)[:,index]),np.var(np.array(mom)[:,index])))

ax[1].hist(np.array(mle)[:,index], bins=_bin,
             color='g',
             alpha=0.5)
ax[1].set_title('MLE: Mean = {:.2f}, Var= {:.2f}'.format(np.mean(np.array(mle)[:,index]),np.var(np.array(mle)[:,index])))

ax[2].hist(np.array(mle_em)[:,index], bins=_bin,
             color='b',
             alpha=0.5)
ax[2].set_title('MLE with EM: Mean = {:.2f}, Var= {:.2f}'.format(np.mean(np.array(mle_em)[:,index]),np.var(np.array(mle_em)[:,index])));
```



## Reference

- [高校数学の美しい物語>ポアソン分布の意味と平均・分散](https://manabitimes.jp/math/924)
- [scipy.stats.ks_2samp](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.ks_2samp.html)
- [scipy.stats.chisquare](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.chisquare.html)
- [UCLA Statistical Methods and Data Analysis > Zero-inflated Poisson Regression](https://stats.oarc.ucla.edu/stata/dae/zero-inflated-poisson-regression/)
- [Wikipedia > ランベルトのW関数](https://ja.wikipedia.org/wiki/%E3%83%A9%E3%83%B3%E3%83%99%E3%83%AB%E3%83%88%E3%81%AEW%E9%96%A2%E6%95%B0)
