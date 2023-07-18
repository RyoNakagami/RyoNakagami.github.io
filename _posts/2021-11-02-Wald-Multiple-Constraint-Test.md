---
layout: post
title: "Wald複合仮説検定"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-11-07
tags:

- Econometrics
- statistical inference
- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Wald検定](#wald%E6%A4%9C%E5%AE%9A)
  - [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [Wald検定のIntuition](#wald%E6%A4%9C%E5%AE%9A%E3%81%AEintuition)
  - [OLS推定量 $\hat\beta$の漸近分布](#ols%E6%8E%A8%E5%AE%9A%E9%87%8F-%5Chat%5Cbeta%E3%81%AE%E6%BC%B8%E8%BF%91%E5%88%86%E5%B8%83)
  - [Wald検定統計量の漸近分布](#wald%E6%A4%9C%E5%AE%9A%E7%B5%B1%E8%A8%88%E9%87%8F%E3%81%AE%E6%BC%B8%E8%BF%91%E5%88%86%E5%B8%83)
- [PythonでWald検定をやってみよう](#python%E3%81%A7wald%E6%A4%9C%E5%AE%9A%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86)
- [Appendix: Delta Method](#appendix-delta-method)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Wald検定

$\beta_j =0$の仮説検定はしばしばt-testを用いて実施されますが, ここでは$\beta_1 = 0$ かつ $\beta_2 = 0$という複合仮説を検定する手法のWald検定を紹介します.

### 問題設定

- $(Y_i, \bold X_i)$はi.i.d
- $E[\epsilon_i|\bold X_i]=0$
- $\mathbb E[Y_i]<\infty, \mathbb E[\|\bold X_i\|]<\infty$
- $rank(\bold X_i)=k+1$, full rank

という仮定が満たされているとき, 

$$
Y_i = \sum_j X_{ij}\beta_j + e_i
$$

という推定式のもとで次のような帰無仮説・対立仮説を考えます.

$$
\begin{align*}
H_0: \bold r(\beta) &= \bold 0\\
H_1: \bold r(\beta) &\neq \bold 0
\end{align*}
$$

ただし, $\bold r:\mathbb R^{k+1}\to \mathbb R^q$のベクトル関数, $q < k+1$とします.

### Wald検定のIntuition

Wald検定は帰無仮説が仮に正しいならば$\bold r(\hat\beta) = \bold 0$が成り立つはずなので

1. $\|\bold r(\hat\beta)\|^2$が大きな値を取るならば棄却すれば良い
2. 大きいという理由で棄却するためには$\|\bold r(\hat\beta)\|^2$が従う分布がわかれば良い
3. $\hat\beta$の漸近分布がわかるならば, $\|\bold r(\hat\beta)\|^2$が従う漸近分布はDelta Methodで計算できるはず
4. Delta Methodで計算した漸近分布に基づき検定しよう

というアイデアに基づいています.
そんな訳で次に, OLS推定量 $\hat\beta$の漸近分布のおさらいをまずします.


### OLS推定量 $\hat\beta$の漸近分布

OLS推定量は

$$
\begin{align*}
\hat\beta &= (X'X)^{-1}(X'Y)\\
&= \beta + (X'X)^{-1}(X'\epsilon)
\end{align*}
$$

これを式変形すると

$$
\sqrt{n}(\hat\beta - \beta) = \left(\frac{1}{n}X'X\right)^{-1}\frac{1}{\sqrt{n}}X'\epsilon
$$

従って, 漸近分布は

$$
\begin{align*}
&\sqrt{n}(\hat\beta - \beta)\xrightarrow[\text{d}]{}N(\bold 0, \bold V)\\
&V = \mathbb E[X'X]^{-1}\mathbb E[X'\epsilon\epsilon'X]\mathbb E[X'X]^{-1}
\end{align*}
$$

これを標本対応で置き換えると

$$
\begin{align*}
&\hat V = \left(\frac{1}{n}X'X\right)^{-1}\frac{1}{n}X'\Sigma X\left(\frac{1}{n}X'X\right)^{-1}\\
&\text{where }\Sigma = \text{diag}(e_1^2, e_2^2, \cdots, e_n^2) \because \text{ the assumption of no autocorrelation}
\end{align*}
$$

従って, OLS推定量 $\hat\beta$の仮説検定上の漸近分布は

$$
\sqrt{n}(\hat\beta - \beta)\xrightarrow[\text{d}]{}N(\bold 0, \hat{\bold V})
$$


### Wald検定統計量の漸近分布

ここでのゴールは

$$
\begin{align*}
W_n &= n\bold r(\beta)'(\hat{\bold R}\hat{\bold V}\hat{\bold R}')^{-1}r(\beta)\xrightarrow[d]{}\chi_q\\
\text{where } \hat{\bold R} &= \left.\frac{\partial\bold r(b)}{\partial b'}\right|_{b=\hat\beta}
\end{align*}
$$

を導出することです.

> 導出

まずDelta Methodより${\bold R} = \frac{\partial\bold r(b)}{\partial b'}$とすると

$$
\sqrt{n}\bold r(\hat\beta) \xrightarrow[d]{} N(0, {\bold R}{\bold V}{\bold R}') \ \ \because \bold r(\beta)=0 \text{ under } H_0
$$

$\hat{\bold R}\hat{\bold V}\hat{\bold R}'$は$\bold r(\hat\beta)$の漸近分散共分散行列の一致推定量なのでスラツキー定理より

$$
\sqrt{n}[\hat{\bold R}\hat{\bold V}\hat{\bold R}']^{-1/2}\bold r(\hat\beta) \xrightarrow[d]{} N(0,I_q)
$$

従って, 

$$
W_n \xrightarrow[d]{}\chi^2_q
$$

## PythonでWald検定をやってみよう

> Library

```python
import pandas as pd
import numpy as np
from scipy import stats
import statsmodels.formula.api as smf
import statsmodels.api as sm
```

> 関数

```python
def compute_ols(y, X):
    beta_ols = np.linalg.solve(X.T @ X, X.T @ y)
    residual = (y - X @ beta_ols)

    inv_x = np.linalg.inv(X.T @ X)
    white_v = len(y) * inv_x @ (X.T @ np.diag(residual ** 2) @ X) @ inv_x

    return beta_ols, white_v

def compute_waldstatistics(n, beta, white_v, gradient_func, constraint_func, degree_of_freedom):
    RHS = constraint_func(beta)
    LHS = RHS.T
    R = gradient_func(beta)
    inv_mat = np.linalg.inv(R @ white_v @ R.T)

    wald_stats = n * (LHS @ inv_mat @ RHS)

    return wald_stats, stats.chi2.sf(wald_stats, degree_of_freedom)

```


> 実行

```python
df = pd.read_csv("https://raw.githubusercontent.com/spring-haru/wooldridge/master/raw_data/data_csv/hprice2.csv")
df = df.dropna()
y = np.log(df['price'].values)
df['const'] = 1
df['room_squared'] = df['rooms'] ** 2
df['nox'] = np.log(df['nox'])
df['dist'] = np.log(df['dist'])
X = np.asarray(df[['const', 'nox', 'dist', 'rooms', 'room_squared']])

res_stats = sm.OLS(y, X).fit(cov_type='HC0')
beta, v = compute_ols(y, X)
```

statsmodelsと個人実装のOLS paramsと漸近分散共分散の比較

```python
print(np.allclose(res_stats.params, beta))
print(np.allclose(res_stats.cov_HC0, v/len(y)))
>>> True
>>> True
```

statsmodelsベースのwald統計量

```python
x_vars = res_stats.summary2().tables[1].index
wald_str = ' =  '.join(list(x_vars[-4:])) + ' = 0'
print(res_stats.wald_test(r_matrix=wald_str, use_f=False, scalar=True)) # joint test
print(wald_str)

>>> <Wald test (chi2): statistic=546.1084114572402, p-value=7.110524920931534e-117, df_denom=4>
>>> x1 =  x2 =  x3 =  x4 = 0
```

個人実装のwald統計量

```python
beta, v = compute_ols(y, X)

def grandient(x):
    R = np.array([[0, 1, 0, 0, 0],[0, 0, 1, 0, 0],[0, 0, 0, 1, 0], [0, 0, 0, 0, 1]])
    return R

def constraint(x):
    R = np.array([[0, 1, 0, 0, 0],[0, 0, 1, 0, 0],[0, 0, 0, 1, 0], [0, 0, 0, 0, 1]])
    return R @ x

wald = compute_waldstatistics(n=len(y), beta=beta, white_v=v, gradient_func=grandient, constraint_func=constraint, degree_of_freedom=4)
print(wald)
>>> 546.1084114535796, 7.110524933898384e-117
```


## Appendix: Delta Method

久保川先生の「現代数理統計学の基礎」を参考にしています.

> 定理

確率変数の列 $\{X_n\}_{n=1,2,\cdots}$について, 定数$\theta$と$a_n\to\infty$となる数列に対して

$$
a_n(X_n-\theta)\xrightarrow[\text{d}]{} X
$$

であると仮定する. 連続微分可能な関数$g(\cdot)$について、点$\theta$で$g'(\theta)$が存在し

$$
g'(\theta)\neq 0
$$

を仮定する. このとき

$$
a_n(g(X_n)-g(\theta))\xrightarrow[\text{d}]{} g'(\theta)X
$$

が成り立つ。

> Proof

$g(X_n)$を$X_n=\theta$の周りでテイラー展開すると

$$
g(X_n)=g(\theta)+g'(\theta^{*})(X_n-\theta), \text{ where } |\theta^{*}-\theta|<|X_n-\theta|
$$

これを変形し,

$$
a_n(g(X_n)-g(\theta))=a_ng'(\theta^{*})(X_n-\theta)
$$

スラツキーの定理より

$$
\frac{1}{a_n}a_n(X_n-\theta)\xrightarrow[\text{d}]{} 0\cdot X=0
$$

これは定数収束を意味しているので以下の確率収束を得る

$$
\begin{align*}
(X_n-\theta)&\xrightarrow[\text{p}]{} 0\\
X_n&\xrightarrow[\text{p}]{}\theta
\end{align*}
$$

このことは$ |\theta^{*}-\theta|<|X_n-\theta|$より

$$
\theta^{*}\xrightarrow[\text{p}]{}\theta
$$

従って, 「連続微分可能な関数$g(\cdot)$」という仮定より

$$
g'(\theta^{*})a_n(X_n-\theta)\xrightarrow[\text{d}]{}g'(\theta)X
$$


## References

- [現代数理統計学の基礎, 久保川達也著・新井仁之編・小林俊行編・斎藤毅編・吉田朋広編](https://www.kyoritsu-pub.co.jp/book/b10003681.html)
- [計量経済学ミクロデータ分析へのいざない, 末石直也著](https://www.nippyo.co.jp/shop/book/6899.html)