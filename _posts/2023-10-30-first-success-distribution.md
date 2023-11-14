---
layout: post
title: "coupon collector problemの期待値の導出"
subtitle: "本日の統計ドリル"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-10-30
tags:

- 統計

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [coupon collector proble](#coupon-collector-proble)
  - [ファーストサクセス分布確率変数の線形和アプローチ](#%E3%83%95%E3%82%A1%E3%83%BC%E3%82%B9%E3%83%88%E3%82%B5%E3%82%AF%E3%82%BB%E3%82%B9%E5%88%86%E5%B8%83%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E7%B7%9A%E5%BD%A2%E5%92%8C%E3%82%A2%E3%83%97%E3%83%AD%E3%83%BC%E3%83%81)
  - [吸収マルコフ連鎖アプローチ](#%E5%90%B8%E5%8F%8E%E3%83%9E%E3%83%AB%E3%82%B3%E3%83%95%E9%80%A3%E9%8E%96%E3%82%A2%E3%83%97%E3%83%AD%E3%83%BC%E3%83%81)
- [対数近似](#%E5%AF%BE%E6%95%B0%E8%BF%91%E4%BC%BC)
  - [近似性能](#%E8%BF%91%E4%BC%BC%E6%80%A7%E8%83%BD)
- [couponコンプリートまでの回数の分散のバウンド](#coupon%E3%82%B3%E3%83%B3%E3%83%97%E3%83%AA%E3%83%BC%E3%83%88%E3%81%BE%E3%81%A7%E3%81%AE%E5%9B%9E%E6%95%B0%E3%81%AE%E5%88%86%E6%95%A3%E3%81%AE%E3%83%90%E3%82%A6%E3%83%B3%E3%83%89)
- [Appendix: 期待値の線形性](#appendix-%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AE%E7%B7%9A%E5%BD%A2%E6%80%A7)
- [Appendix: 対数近似のグラフコード](#appendix-%E5%AF%BE%E6%95%B0%E8%BF%91%E4%BC%BC%E3%81%AE%E3%82%B0%E3%83%A9%E3%83%95%E3%82%B3%E3%83%BC%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## coupon collector proble

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

n種類のクーポンが1つずつある. 一つ選んではもとに戻す動作を繰り替えることを考えたとき, 
すべてのクーポンの種類を集めるまでの回数の期待値をもとめよ

</div>

この問題はいわゆる 「**Single collection with equal probabilities**」と呼ばれるものです. 
解き方としては

- ファーストサクセス分布確率変数の線形和アプローチ
- 吸収マルコフ連鎖アプローチ

の2つが考えられます.


### ファーストサクセス分布確率変数の線形和アプローチ

すでに$r$種類手元にある状態($0\leq r \leq n-1$)から$r+1$種類まで集めるまでに必要な回数を
表す確率変数を$X_r$とすると, $k\geq 1$について

$$
\Pr(X_r = k) = (\pi)^{k-1}(1 -\pi) \ \ \text{ where } \pi = \frac{r}{n}
$$

したがって,

$$
\begin{align*}
\mathbb E[X_r] &= \sum_{k\geq 1}k\Pr(X_r = k) \\[3pt]
               &= \sum_{k\geq 1}k\bigg(\frac{r}{n}\bigg)^{k-1}\bigg(1-\frac{r}{n}\bigg)\\[3pt]
               &= \bigg(1-\frac{r}{n}\bigg)\frac{n}{r}\sum_{k\geq 1}k\bigg(\frac{r}{n}\bigg)^{k}\\[3pt]
               &= \frac{(1 - \pi)}{\pi}\frac{\pi}{(1 - \pi)^2}\\[3pt]
               &= \frac{1}{1-\pi}\\[3pt]
               &= \frac{n}{n-r}
\end{align*}
$$

0種類手元にある状態から$n$種類集めるまでの期待値は, 期待値の線型性より

$$
\begin{align*}
\mathbb E\bigg[\sum_{r=0}^{n-1} X_r\bigg] &= \sum_{r=0}^{n-1} \mathbb E[X_r]\\
&= \sum_{r=0}^{n-1}\frac{n}{n-r}\\[3pt]
&= n\sum_{r=0}^{n-1}\frac{1}{n-r}\\[3pt]
&= n\bigg(\frac{1}{1} + \frac{1}{2} + \cdots + \frac{1}{n-1}\bigg)
\end{align*}
$$

### 吸収マルコフ連鎖アプローチ

回数を次のStateに至るまでの離散時間と考えると吸収マルコフ連鎖のアプローチで考えることができます

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>吸収マルコフ連鎖</ins></p>

状態変数が２つの状態$(x_0, x_1)$からなる吸収マルコフ連鎖を考えます. 状態$x_0$から状態$x_1$への遷移確率を要素で記述した遷移行列を以下のように定義します

$$
\mathbf P = \left(\begin{array}{cc}p & 1-p\\0 & 1 \end{array}\right)
$$

このとき, $x_1$が吸収状態となります. 状態$x_0$からスタートして$x_1$まで至る時間を$T$としたとき期待値は以下のように表せます

$$
\begin{align*}
\mathbb E[T|x_0] &= p(1 + \mathbb E[T|x_0]) + (1-p)\\
                 &= (1-p)^{-1}
\end{align*}
$$

</div>

この吸収マルコフ連鎖を用いると$r$枚保有している状態におけるコンプリートまでの期待値を$\mu_r$, 状態$i$から$j$までの遷移確率を$p_{ij}$と表すと

$$
\begin{align*}
\mu_0 &= 1 + \mu_1\\
\mu_1 &= p_{11}(1 + \mu_1) + p_{12}(1 + \mu_2)\\
\vdots&\\
\mu_k &= p_{kk}(1 + \mu_k) + p_{kk+1}(1 + \mu_{k+1})\\
\vdots&\\
\mu_{N-1} &= p_{N-1N-1}(1 + \mu_{N-1}) + p_{N-1N}(1 + \mu_{N})\\
\mu_{N} &= 0
\end{align*}
$$

これを整理すると

$$
\mu_k = \frac{1}{1 - p_{kk}} + \mu_{k+1}
$$

となるので今回は $p_{kk} = \frac{k}{n}$であることを利用すると

$$
\begin{align*}
\mu_0 &= 1 + \sum^{N-1}_{r=1}\frac{n}{n-r}\\[3pt]
      &= n \bigg(\sum^{N}_{r=1}\frac{1}{r}\bigg)
\end{align*}
$$

## 対数近似

調和級数は$n$が十分大きいとき, 自然対数で近似することができます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Theorem</ins></p>

$$
\ln(n+1) < \sum^{n}_{r=1}\frac{1}{r} < 1 + \ln(n)
$$

</div>


{% include plotly/20231030_log_bound.html %}

調和級数は上の図の青のブロックで囲まれたエリアの合計面積となります. そのため, その面積は
赤線と緑線の積分値をうまく使うとバウンドすることができ, その結果上記の不等式が得られます.

下のバウンドは, 赤のラインの積分値となるので次の式が得られます.

$$
\sum^{n}_{r=1}\frac{1}{r} > \int_1^{n+1}\frac{1}{x}dx = \ln(n+1)
$$

また上のバウンドは, $x\geq 1$で定義される$1/x$を右に1シフトさせたものなので, $1\leq x \leq 2$の青の面積1を踏まえると

$$
\begin{align*}
\sum^{n}_{r=1}\frac{1}{r} &< 1 + \int_2^{N+1}\frac{1}{x-1}dx\\
                         &= 1 + \int_1^{N}\frac{1}{x}dx\\
                         &= 1 + \ln(n)
\end{align*}
$$

が得られるので, 証明はこれで完了です.

### 近似性能

対数近似でも十分ですがより性能の良い近似はオイラー定数を用いた以下の形となります

$$
\begin{align*}
\sum_{i}^N \frac{1}{i} &= \ln(N) + \gamma + \frac{1}{2N}\\[3pt]
\mathbb E[X] &= N \ln(N) + N\gamma + \frac{1}{2}\\[3pt]
\text{where } \gamma & \approx 0.5772156649
\end{align*}
$$

近似の性能は高く, 以下のように$N\geq > 30$以上でも.


{% include plotly/20231030_log_bound_diff.html %}


## couponコンプリートまでの回数の分散のバウンド

[ファーストサクセス分布確率変数の線形和アプローチ](#%E3%83%95%E3%82%A1%E3%83%BC%E3%82%B9%E3%83%88%E3%82%B5%E3%82%AF%E3%82%BB%E3%82%B9%E5%88%86%E5%B8%83%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E7%B7%9A%E5%BD%A2%E5%92%8C%E3%82%A2%E3%83%97%E3%83%AD%E3%83%BC%E3%83%81)の考えを用いると, 各stateにおける次の状態に行く確率変数は独立なので, コンプリートまでの回数を$T$とすると


$$
Var(T) = Var\bigg(\sum_{r=0}^{N-1}X_r\bigg) = \sum_{r=0}^{N-1}Var(X_r)
$$

$Var(X_r) = \mathbb E[X_r^2] - \mathbb E[X_r]^2$であるので

$$
\begin{align*}
\mathbb E[X_r^2] &= \sum_{k\geq 1} k^2 \bigg(\frac{r}{n}\bigg)^{k-1}\frac{n-r}{n}\\[3pt]
                 &= \frac{n-r}{n}\sum_{k\geq 1} k^2 \bigg(\frac{r}{n}\bigg)^{k-1}
\end{align*}
$$

$p\in (0, 1)$について$S = \sum_{k\geq 1} k^2 p^{k-1}$とすると,

$$
\begin{align*}
pS &= \sum_{k\geq 1} k^2 p^k\\
(1-p)S &= \sum_{k\geq 1}(2k-1)p^{k-1}\\
       &= \frac{2}{(1-p)^2}- \frac{1}{1-p}
\end{align*}
$$

したがって, 

$$
\begin{align*}
Var(X_r) = \bigg(\frac{n}{n-r}\bigg)^2 - \frac{n}{n-r}
\end{align*}
$$

ここからexactに分散を求めることは無理ですが, 上へのバウンドを以下のように考えることができます.

$$
\begin{align*}
Var(T) &= Var\bigg(\sum_{r=0}^{N-1}X_r\bigg)\\[3pt]
       &= \sum_{r=0}^{N-1}Var(X_r)\\[3pt]
       &= \sum_{r=0}^{N-1}\bigg(\frac{n}{n-r}\bigg)^2 - \sum_{r=0}^{N-1}\frac{n}{n-r}\\[3pt]
       &< n^2 \sum_{i=1}^{N-1}\frac{1}{i^2}\\[3pt]
       &< \frac{\pi^2}{6}n^2 \  \ \because \text{ Basel Problem}
\end{align*}
$$




## Appendix: 期待値の線形性

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Theorem</ins></p>

確率変数 $X, Y$について期待値は以下のように線形の関係が成立する:

$$
\mathbb E[X + Y] = \mathbb E[X] + \mathbb E[Y]
$$

</div>

連続の場合の証明だけ簡単に紹介します

$$
\begin{align*}
\mathbb E[X+Y] &= \int_y\int_x(x + y)f(x, y)dD\\
               &= \int_y\int_x xf(x, y)dD + \int_y\int_x yf(x, y)dD\\
               &= \int_x\int_y xf(x, y)dD + \int_y\int_x yf(x, y)dD\\
               &= \int_x x \int_y f(x, y)dydx + \int_y y\int_x f(x, y)dxdy\\
               &= \int_x x f_x(x)dx + \int_y y f_y(y) dy\\
               &= \mathbb E[X] + \mathbb E[Y]
\end{align*}
$$

> REMARKS

- 期待値の線形性は $X$ と $Y$ が独立でなくてもどんな場合にも成立する

## Appendix: 対数近似のグラフコード

**Figure 1**

```python
import plotly.graph_objects as go
import numpy as np


x_raw = np.arange(1,12)
x2 = np.linspace(1, 10, 100)
x = np.repeat(x_raw, 2)[1:]
y = np.repeat(1/x_raw, 2)

fig = go.Figure()
fig.add_trace(go.Scatter(
    x = x, y = y, name='1/xの階段', fill='tozeroy'
))

fig.add_trace(go.Scatter(
    x = x2, y = 1/x2, mode='lines', name='1/x'
))

fig.add_trace(go.Scatter(
    x = x2+1, y = 1/x2, mode='lines', name='1/(x-1)'
))

fig.update_layout(
    xaxis_range=[0,11],
    width=600,
    height=500)
```

**Figure 2**

```python
import pandas as pd
from plotly.subplots import make_subplots
import plotly.graph_objects as go

x = np.arange(1, 40)
y = np.cumsum(1/x)
y_approx = (np.log(x) + 0.5772156649 + 1/(2*x))

df = pd.DataFrame({'x': x, 'inverse': y, 'approx': y_approx})
df['diff'] = df['inverse'] - df['approx']
df['diff_2'] = df['diff'] * x

fig = make_subplots(rows=1, cols=2, 
                    subplot_titles=("調和級数の近似誤差", "期待値近似誤差"))
trace1 = go.Scatter(x=df['x'],
                    y=df['diff'],
                    mode='lines',
                    name='prob',
                    showlegend=False
                   )
trace2 = go.Scatter(x=df['inverse']*df['x'],
                    y=df['diff_2'],
                    mode='lines',
                    name='uplift',
                    showlegend=False
                   )
fig.append_trace(trace1,1,1)
fig.append_trace(trace2,1,2)
fig.update_layout(title_text="対数近似性能")

fig['layout']['xaxis']['title']='N'
fig['layout']['xaxis2']['title']='期待値'
fig['layout']['yaxis']['title']='近似誤差'
fig.show()
```



References
-------------

- [高校数学の美しい物語 > コンプガチャに必要な回数の期待値の計算 ](https://manabitimes.jp/math/1053)
- [Ryo's Tech Blog > 吸収マルコフ連鎖の紹介](https://ryonakagami.github.io/2022/02/27/absorbing-markov-chain/)
