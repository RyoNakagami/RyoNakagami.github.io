---
layout: post
title: "統計検定：一様分布の性質の紹介"
subtitle: "Appendix: 十分統計量"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
uu_cnt: 100
session_cnt: 100
tags:

- 統計

---



**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 一様分布の性質](#1-%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [一様分布の特性値の導出](#%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AE%E7%89%B9%E6%80%A7%E5%80%A4%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [累積分布関数と一様分布](#%E7%B4%AF%E7%A9%8D%E5%88%86%E5%B8%83%E9%96%A2%E6%95%B0%E3%81%A8%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83)
  - [一様分布のパラメーターの不偏推定量: 2019年11月統計検定１級](#%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AE%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AE%E4%B8%8D%E5%81%8F%E6%8E%A8%E5%AE%9A%E9%87%8F-2019%E5%B9%B411%E6%9C%88%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%EF%BC%91%E7%B4%9A)
    - [最尤推定法推定量が不偏推定量ではないことの確認](#%E6%9C%80%E5%B0%A4%E6%8E%A8%E5%AE%9A%E6%B3%95%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%8C%E4%B8%8D%E5%81%8F%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%84%E3%81%93%E3%81%A8%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [Appendix](#appendix)
  - [十分統計量](#%E5%8D%81%E5%88%86%E7%B5%B1%E8%A8%88%E9%87%8F)
    - [フィッシャーネイマンの分解定理](#%E3%83%95%E3%82%A3%E3%83%83%E3%82%B7%E3%83%A3%E3%83%BC%E3%83%8D%E3%82%A4%E3%83%9E%E3%83%B3%E3%81%AE%E5%88%86%E8%A7%A3%E5%AE%9A%E7%90%86)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 一様分布の性質

確率変数$X$が閉区間$[a,b]$上の一様分布に従うとは$X$の確率密度関数が

$$
f_X(x|a,b) = \begin{cases}\frac{1}{b-a} & \ \ x \in [a,b]\\ 0 & \ \ \text{ otherwise }\end{cases}
$$

### 一様分布の特性値の導出

> 一様分布の期待値

$$
\begin{align*}
E[X] &= \int_a^b x \frac{1}{b-a}dx\\[8pt]
&= \frac{1}{b-a}\left[\frac{1}{2}x^2\right]^b_a\\[8pt]
&= \frac{b+a}{2} \quad\quad\tag{1.1}
\end{align*}
$$

> 一様分布の分散

$$
\begin{align*}
E[X^2] &= \int_a^b x^2 \frac{1}{b-a}dx\\[8pt]
&= \frac{1}{b-a}\left[\frac{1}{3}x^3\right]^b_a\\[8pt]
&= \frac{1}{3}(b^2 + ab + a^2) \quad\quad\tag{1.2}
\end{align*}
$$

従って、(1.1)と(1.2)より

$$
\begin{align*}
V(X) &= \frac{1}{3}(b^2 + ab + a^2) - \left(\frac{b+a}{2}\right)^2\\
&= \frac{1}{12}(b-a)^2
\end{align*}
$$

> MGFの導出

$$
\begin{align*}
E[\exp(tX)] &= \int^b_a\exp(tx)\frac{1}{b-a}dx\\[8pt]
&= \frac{1}{b-a}\left[\frac{1}{t}\exp(tx)\right]^b_a\\[8pt]
&= \frac{\exp(tb) - \exp(ta)}{t(b-a)}
\end{align*}
$$

### 一様分布のパラメーターの不偏推定量: 2019年11月統計検定１級

確率変数 $X_1, \cdots, X_n$を互いに独立に$Unif(0,\theta)$に従うとします, また$\theta>0$は未知のパラメーターとします. 

$$
Y = \max(X_1, \cdots, X_n)
$$

とするとき、以下の設問に答えよ

1. $Y$はパラメーター$\theta$に関する十分統計量であることを示せ
2. $Y$の確率密度関数$g(y)$を示せ
3. $Y=y$が与えられた時の$X_1, \cdots, X_n$の条件付き同時分布を求めよ
4. $\mathrm E[Y]$を求め、$Y$の関数s解いて$\theta$の不偏推定量$\tilde\theta$を構成せよ


> (1). $Y$はパラメーター$\theta$に関する十分統計量であることを示せ

確率変数 $X_1, \cdots, X_n$の同時確率密度関数は

$$
f(\mathrm x|\theta) = \theta^{-n} \ \ (x_i\in [0, \theta])
$$

条件の$x_i\in [0, \theta]$は$y\in [0, \theta]$と同値であるので、$f(\mathrm x\|\theta)$は$y$のみの関数として表されるので、フィッシャーネイマンの分解定理より$Y$は$\theta$についての十分統計量である.

> (2). $Y$の確率密度関数$g(y)$を示せ

$X_i$についてのCDFを$F_i(x) = P(X_i\leq x)$とすると$x\in [0, \theta]$について

$$
F_i(x) = \frac{x}{\theta}
$$

よって, $y\in [0,\theta]$について

$$
\begin{align*}
G(y) &= P(Y\leq y)\\
&= P(X_1, \cdot, X_n \leq y)\\
&= F_1(y)\times \cdots \times F_N(y)\\
&= \frac{y^n}{\theta^n}
\end{align*}
$$

従って、$Y$の確率密度関数$g(y)$は

$$
g(y) = \frac{n}{\theta^n}y^{n-1}
$$

> (3). $Y=y$が与えられた時の$X_1, \cdots, X_n$の条件付き同時分布を求めよ

$Y = y$が与えられた時、$X_1, \cdots, X_n$の条件付き同時確率密度関数は、$X_{(n)} = y$の選び方が$n$通りあることに留意すると

$$
\begin{align*}
f(x_1, \cdots, x_{n-1}, y|y) &= \frac{f(x_1, \cdots, x_{n-1}, y)}{g(y)}\\
&= \frac{n/\theta^n}{n\theta^{-n}y^{n-1}}\\
&= \frac{1}{y^{n-1}}
\end{align*}
$$

上記より、$Y=y$が与えられたものでの$X_1, \cdots, X_n$の条件付き確率密度関数がパラメーター$\theta$に依存しないことがわかる


> (4). $\mathrm E[Y]$を求め、$Y$の関数s解いて$\theta$の不偏推定量$\tilde\theta$を構成せよ

$$
\begin{align*}
\mathrm E[Y] &= \int^{\theta}_0y \frac{n}{\theta^n}y^{n-1}dy\\
&= \frac{n}{\theta^n}\int^{\theta}_0y&n dy\\
&= \frac{n}{n+1}\theta
\end{align*}
$$

従って、

$$
\tilde\theta = \frac{n+1}{n}Y
$$

とすれば$\theta$の不偏推定量を得る. またこの不偏推定量は唯一の不偏推定量であることを示します.

$C(Y)$を別の不偏推定量とすると定義より、

$$
E[C(Y) - \tilde\theta] = 0
$$

$\mu(Y)\equiv C(Y) - \tilde\theta$とし、またなめらかな関数とします. このとき、

$$
\begin{align*}
E[\mu(Y)] &= \int^\theta_0 \mu(y) \frac{n}{\theta^n}y^{n-1}dy\\
\Rightarrow & \int^\theta_0 \mu(y) y^{n-1}dy = 0
\end{align*}
$$

これがすべての$\theta$で成り立つためには$y>0$で$\mu(y) y^{n-1} = 0$が成り立つ必要があります(上記積分を$\theta$で微分することで確認可能).

従って、

$$
\mu(Y) = 0 \Rightarrow C(Y) = \tilde\theta
$$

#### 最尤推定法推定量が不偏推定量ではないことの確認

$Unif(0, \theta)$に従う、確率変数 $X_1, \cdots, X_n$のlikelihoodは

$$
L(x_1, \cdots, x_n|\theta) = \left(\frac{1}{\theta}\right)^n
$$

$(x_1,\cdots, x_n)\in (0, \theta_{mle})$を満たしつつ尤度を最大化する$\theta_{mle}$は

$$
\theta_{mle} = \max(x_1,\cdots, x_n)
$$

これは、上述の不偏推定量と一致しないことがわかります.



## Appendix
### 十分統計量

確率分布$f(x\|\theta)$からランダムサンプル$(X_1, \cdots, X_n)$が取られているとき、平均や四分位統計量、最大統計量、最小統計量といった統計量を分布の性質を探索する目的で抽出したりします.
この点、集約した統計量が$\theta$に関する情報を失っていないとき、その統計量を十分統計量といいます.

なお以下では次のようなノーテーションを用います:

- $\mathrm X = (X_1, \cdots, X_n)$
- $\mathrm x = (\it x_1, \cdots, \it{x_n})$


> 定義：十分統計量

統計量$T(\mathrm X)$が$\theta$に対して十分統計量とは、$T(\mathrm x) = t$ を満たす$\mathrm x$と$t$に対して $T(\mathrm X)=t$を与えたときの$\mathrm X= \mathrm x$の条件付き確率

$$
P(\mathrm X= \mathrm x|T(\mathrm X)=t)
$$

が$\theta$に依存しないことをいいます. つまり,

$$
P(\mathrm X= \mathrm x|T(\mathrm X)=t, \theta) = P(\mathrm X= \mathrm x|T(\mathrm X)=t)
$$

> 例: ベルヌーイ試行と二項分布

$X_1, \cdots, X_n$は独立に$Ber(\theta)$に従うとします. このとき、統計量$T(\mathrm X) = \sum X_i$を考えると、$T(\mathrm X)\sim Bin(n, \theta)$より

$$
\begin{align*}
&P(\mathrm X = \mathrm x) = \theta^{\sum x_i}(1 - \theta)^{\sum (1 - X_i)}\\[8pt]
&P(T(\mathrm X)=t ) = \frac{\Gamma(n+1)}{\Gamma(n-x+1)\Gamma(x+1)}\theta^t(1-\theta)^{n-t}
\end{align*}
$$

従って、$T(\mathrm X)=t$を与えたときの$\mathrm X= \mathrm x$の条件付き確率は

$$
\begin{align*}
P(\mathrm X= \mathrm x|T(\mathrm X)=t) &= \frac{\theta^{\sum x_i}(1 - \theta)^{\sum (1 - X_i)}}{\frac{\Gamma(n+1)}{\Gamma(n-t+1)\Gamma(t+1)}\theta^t(1-\theta)^{n-t}}\\[8pt]
&= \frac{\Gamma(n-t+1)\Gamma(t+1)}{\Gamma(n+1)}
\end{align*}
$$

となり、$\theta$に依存しません. 従って、$T(\mathrm X)$は十分統計量となります.

#### フィッシャーネイマンの分解定理

> 定理

$T(\mathrm X)$が$\theta$の十分等計量であるための必要十分条件は$\mathrm X = (X_1, \cdots, X_n)$の同時確率関数もしくは同時確率密度関数$f(x_1, \dots, x_n\|\theta)$が$\theta$に依存する部分とそうでない部分に分解でき、$\theta$に依存する部分は$T(\cdot)$を通してのみ$\mathrm x$に依存する. すなわち、

$$
f(x_1, \dots, x_n |\theta) = h(\mathrm x)g(T(\mathrm X)|\theta)
$$

> 証明

**(必要性)**


$t=T(\mathrm x)$なる$\mathrm x$に対して、

$$
\begin{align*}
f(\mathrm x|\theta) &= P(\mathrm X = \mathrm x, T(\mathrm X) = t|\theta)\\
&= P(\mathrm X = \mathrm x| T(\mathrm X) = t)P(T(\mathrm X) = t |\theta)\\
&= f(\mathrm x|T(\mathrm x))g(T(\mathrm x)|\theta)
\end{align*}
$$


**(十分性)**

$$
\begin{align*}
P(T(\mathrm X)=t|\theta) &= \int_{\mathrm x:T(\mathrm x)=t}f(\mathrm x|\theta)d\mathrm x\\
&= \int_{\mathrm x:T(\mathrm x)=t}h(\mathrm x)g(T(\mathrm X)=t|\theta)d\mathrm x\\
&= g(t|\theta)\int_{\mathrm x:T(\mathrm x)=t}h(\mathrm x)d\mathrm x
\end{align*}
$$

となることに留意すると、


$$
\begin{align*}
P(\mathrm X =\mathrm x|T(\mathrm X)=t, \theta) &= \frac{P(\mathrm X =\mathrm x, T(\mathrm X)=t|\theta)}{P(T(\mathrm X)=t|\theta)}\\
&= \frac{P(\mathrm X =\mathrm x|\theta)}{P(T(\mathrm X)=t| \theta)}\\
&= \frac{g(T(\mathrm x)|\theta)h(\mathrm x)}{g(t|\theta)\int_{\mathrm x:T(\mathrm x)=t}h(\mathrm x)d\mathrm x}\\
&=\frac{h(\mathrm x)}{\int_{\mathrm x:T(\mathrm x)=t}h(\mathrm x)d\mathrm x}
\end{align*}
$$

従って、$\theta$に依存しないことから$T(\mathrm X)$が十分統計量であることがわかる.


## References

- [Ryo's Tech Blog > 数理統計：変数変換 1/n](https://ryonakagami.github.io/2021/04/21/variable-transformation/#%E5%91%BD%E9%A1%8C%E7%B4%AF%E7%A9%8D%E5%88%86%E5%B8%83%E9%96%A2%E6%95%B0%E3%81%A8%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83)
- [現代数理統計学の基礎, 久保川 達也著 > 第６章統計的推定](https://www.kyoritsu-pub.co.jp/bookdetail/9784320111660)
