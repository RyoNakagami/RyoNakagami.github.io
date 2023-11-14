---
layout: post
title: "有限母集団からの標本抽出と有限母集団修正項"
subtitle: "Random Samplingの理論と実践 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-10-06
tags:

- 統計
- 統計検定
- RCT
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [有限母集団からのRandom Samplingと平均値](#%E6%9C%89%E9%99%90%E6%AF%8D%E9%9B%86%E5%9B%A3%E3%81%8B%E3%82%89%E3%81%AErandom-sampling%E3%81%A8%E5%B9%B3%E5%9D%87%E5%80%A4)
  - [平均値の期待値と分散の検討](#%E5%B9%B3%E5%9D%87%E5%80%A4%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%A8%E5%88%86%E6%95%A3%E3%81%AE%E6%A4%9C%E8%A8%8E)
  - [標本の不偏分散と期待値](#%E6%A8%99%E6%9C%AC%E3%81%AE%E4%B8%8D%E5%81%8F%E5%88%86%E6%95%A3%E3%81%A8%E6%9C%9F%E5%BE%85%E5%80%A4)
  - [母分散が未知の場合の平均値の分散の検討](#%E6%AF%8D%E5%88%86%E6%95%A3%E3%81%8C%E6%9C%AA%E7%9F%A5%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%AE%E5%B9%B3%E5%9D%87%E5%80%A4%E3%81%AE%E5%88%86%E6%95%A3%E3%81%AE%E6%A4%9C%E8%A8%8E)
  - [効率的な不偏推定量](#%E5%8A%B9%E7%8E%87%E7%9A%84%E3%81%AA%E4%B8%8D%E5%81%8F%E6%8E%A8%E5%AE%9A%E9%87%8F)
- [有限母集団のyes/no調査のCIの計算](#%E6%9C%89%E9%99%90%E6%AF%8D%E9%9B%86%E5%9B%A3%E3%81%AEyesno%E8%AA%BF%E6%9F%BB%E3%81%AEci%E3%81%AE%E8%A8%88%E7%AE%97)
  - [測定誤差$\epsilon$を0.04以下にするために必要なサンプルサイズ](#%E6%B8%AC%E5%AE%9A%E8%AA%A4%E5%B7%AE%5Cepsilon%E3%82%92004%E4%BB%A5%E4%B8%8B%E3%81%AB%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AB%E5%BF%85%E8%A6%81%E3%81%AA%E3%82%B5%E3%83%B3%E3%83%97%E3%83%AB%E3%82%B5%E3%82%A4%E3%82%BA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 有限母集団からのRandom Samplingと平均値

データサイズ $N$ の母集団から標本の大きさ $n$ の標本を非復元無作為抽出して得られた標本 $x_1, \cdots, x_n$とします.
母平均と母分散が $(\mu, \sigma^2)$ で表現されるときの $\mathbb E[x_i], \mathbb V(x_i), \rho(x_i, x_j)$, (ただし $i\neq j$)を求めてみます.

まず, 期待値の定義より母集団から$x_i$がとある値になる確率を表現することが必要となることがわかるのでそれを考えてみます.


母集団の元を $(a_1, a_2, \cdots, a_N)$ としたとき, $x_i=a_r$ となる確率は $(a_1, a_2, \cdots, a_N)$　から $n$個とって１列に並べてから, 
$x_i=a_r$を固定, つまり i番目に割り当てられた母集団の元を固定して, 残りの順列の個数を計算したものとなります. 

$$
Pr(x_i=a_r) = \frac{_{N-1}P_{n-1}}{_{N}P_{n}} = \frac{1}{N}
$$

相関係数の計算にあたって $Pr(x_i=a_r, x_j=a_s)$が必要となるので上と同様に (ただし $i\neq j, r\neq s$)

$$
Pr(x_i=a_r, x_j=a_s) = \frac{_{N-2}P_{n-2}}{_{N}P_{n}} = \frac{1}{N(N-1)}
$$

従って,

$$
\begin{align*}
\mathbb E[x_i] &= \sum_{r=1}^N a_r Pr(x_i=a_r) = \frac{1}{N}\sum_{r=1}^N a_r = \mu\\
\mathbb V(x_i) &= \sum_{r=1}^N (a_r - \mu)^2 Pr(x_i=a_r) = \sigma^2\\
Cov(x_i, x_j) &= \sum_{r=1}^N\sum_{s\neq r} (a_r - \mu)(a_s - \mu) Pr(x_i=a_r, x_j=a_s)\\
&= \frac{1}{N(N-1)}\left\{\sum_{r=1}^N\sum_{s=1} (a_r - \mu)(a_s - \mu) - \sum_{r=1}^N (a_r - \mu)^2\right\}\\
&= \frac{1}{N(N-1)}\left\{\left(\sum_{r=1}^N (a_r - \mu)\right)^2 - \sum_{r=1}^N (a_r - \mu)^2\right\}\\
&= -\frac{1}{N-1}\sigma^2\\
\rho(x_i, x_j) &= \frac{Cov(x_i, x_j)}{\sqrt{\mathbb V(x_i)}\mathbb V(x_j)}= -\frac{1}{N-1}
\end{align*}
$$

### 平均値の期待値と分散の検討

有限母集団からの非復元抽出で大きさ $n$ のサンプルを抽出した時, その標本平均を $\bar x$としたとき、その期待値と分散を考えてみます.

$$
\begin{align*}
\mathbb E[\bar x] &= \mathbb E\left[\frac{1}{n}\sum^n_{i=1} x_i\right]\\
&=\frac{1}{n} \sum^n_{i=1} \mathbb E\left[x_i\right]\\
&= \mu
\end{align*}
$$

次に母集団分散が既知の場合の標本平均の分散を示します. 非復元抽出は互いに抽出確率が独立ではないことに注意すると

$$
\begin{align*}
\mathbb V(\bar x) &=  \mathbb V\left[\frac{1}{n}\sum^n_{i=1} x_i\right]\\
&= \frac{1}{n^2}\mathbb V\left[\sum^n_{i=1} x_i\right]\\
&= \frac{1}{n^2}\left[\sum_{i=1}^n \mathbb{V}(x_i)+\sum^n_{i=1} \sum^n_{j\neq i} Cov(x_i,x_j)\right]\\
&= \frac{1}{n^2}\left[n\sigma^2 - n(n-1)\frac{\sigma^2}{N-1}\right]\\
&= \frac{N-n}{N-1}\frac{\sigma^2}{n}
\end{align*}
$$

> 有限母集団修正項はどれくらいの大きさなのか？

$$
\begin{align*}
\text{finite population correction} & = \sqrt{\frac{N-n}{N-1}}\\
& \approx \sqrt{\frac{N-n}{N}}
\end{align*}
$$

と理解すると有限母集団修正項は $1 - \text{抽出率}$ の平方根に近似することができます.

|抽出率|修正項|
|---|---|
|100%|0|
|70%|0.546|
|50%|0.707|
|30%|0.836|
|20%|0.894|
|10%|0.948|
|5%|0.974|
|1%|0.995|

有限母集団サイズに対してサンプル抽出率が1~3%程度にとどまるならば基本的には補正は無視しても構わないと思います.

### 標本の不偏分散と期待値

標本の不偏分散を以下のように定義します

$$
s^2 = \frac{1}{n-1}\sum_{i=1}^n(x_i - \bar x)^2
$$

このときの期待値と母分散の関係は次のようになります:

$$
\begin{align*}
\mathbb E[s^2] &= \frac{1}{n-1}\mathbb E\left[\sum_{i=1}^n(x_i - \bar x)^2\right]\\
&= \frac{1}{n-1}\left[E[\sum_{i=1}^nx_i^2] - n\mathbb E[\bar x^2]\right]\\
&= \frac{1}{n-1}\left[n(\sigma^2 + \mu^2) - n\left(\frac{N-n}{N-1}\frac{\sigma^2}{n} + \mu^2\right)\right]\\
&= \frac{1}{n-1}\left[n\sigma^2 - \frac{N-n}{N-1}\sigma^2\right]\\
&= \frac{N}{N-1}\sigma^2
\end{align*}
$$

### 母分散が未知の場合の平均値の分散の検討





### 効率的な不偏推定量

上と同じく有限データサイズ $N$ の母集団から標本の大きさ $n$ を非復元無作為抽出して得た標本 $x_1, \cdots, x_n$とします.

$$
T = \sum a_ix_i
$$

という推定量を考えた時, これが母平均 $\mu$ の不偏推定量であるための条件は

$$
\begin{align*}
\mathbb E[T] &= \sum a_i \mathbb E[x_i]\\
&= \sum a_i \mu
\end{align*}
$$

より $\sum a_i = 1$であることがわかります. 次にこの不偏推定量の分散が最小(= 効率的)である条件を考えます.

$$
\begin{align*}
V(T) &= \sum a_i^2 V[x_i] + \sum_{i}^n\sum_{j\neq i} a_ia_j Cov(x_i, x_j)\\
&= \sigma^2 \sum a_i^2 -\frac{1}{N-1}\sigma^2\sum_{i}^n\sum_{j\neq i} a_ia_j\\
&= \sigma^2 \sum a_i^2 -\frac{1}{N-1}\sigma^2 (1 - \sum a_i^2)\\
&= \frac{N}{N-1}\sigma^2 \sum a_i^2 - \frac{1}{N-1}\sigma^2
\end{align*}
$$

従って, $\sum a_i^2$が最小になる時が分散が最小になるので

$$
a_1 = a_2 = \cdots = a_n = \frac{1}{n}
$$

が条件とわかる.

## 有限母集団のyes/no調査のCIの計算

$N = 2000$の村を対象にyes/noアンケート調査を実施したいとします.
測定誤差, $\epsilon$, を0.04以下にしたいと思っていますが, この場合最低何人に対してアンケートすれば良いか考えます.

なお, $N_1$人がyes, $N - N_1$人がnoと答える分布と想定します.

> Theorem: 有限母集団のApproximate Confidence Interval 

$$
\hat{p}\pm z_{\alpha/2}\sqrt{\dfrac{\hat{p}(1-\hat{p})}{n} \cdot \dfrac{N-n}{N-1}}
$$

有限母集団からの非復元抽出で大きさ $n$ のサンプル, $x_1, \cdots, x_n$, を抽出したとします. なお,

$$
x_ i \begin{cases}1 & \text{ if yes}\\0 \text{ otherwise} \end{cases}
$$


問題設定より, yesと答える割合を$p$, 上記サンプリングによるその推定値を$\hat p$とすると

$$
\begin{align*}
p & = \frac{N_1}{N}\\
1 - p &= \frac{N - N_1}{N}\\
\hat p & = \frac{\sum x_i}{n}
\end{align*}
$$

$X = \sum x_i$という確率変数を考えると, これは超幾何分布に従うので

$$
\begin{align*}
\mathbb E(X)&=n\frac{N_1}{N}\\
&=np\\
Var(X)&=n{N_1\over N}\left(1-{N_1\over N}\right) \left({N-n\over N-1}\right)\\
&=np(1-p)\left({N-n\over N-1}\right)
\end{align*}
$$

従って,

$$
Var(\hat{p})=\frac{p(1-p)}{n}\left(\frac{N-n}{N-1}\right)
$$

またCLTより

$$
\frac{\hat{p}-p}{\sqrt{\frac{p(1-p)}{n} \left(\frac{N-n}{N-1}\right) }} \sim N(0, 1)
$$

### 測定誤差$\epsilon$を0.04以下にするために必要なサンプルサイズ

$$
0.04 \geq \epsilon \equiv |p - \hat p|
$$

が問題文が求めていることです. 確率変数$\hat p$によって$\epsilon$は定義されているので同じく確率変数, 
つまり誤差に関しても確率的な表現を踏まえた上で考える必要があります.

ここで, 95% Confidence Intervalの範囲が$\hat p \pm 0.04$に収まるという形で言い換えて良いならば, CLTからのthe sample analogue principleによって

$$
\text{CI} \ equiv \hat{p}\pm z_{\alpha/2}\sqrt{\dfrac{\hat{p}(1-\hat{p})}{n} \cdot \dfrac{N-n}{N-1}}
$$

$$
\epsilon=z_{\alpha/2}\sqrt{\dfrac{\hat{p}(1-\hat{p})}{n}\cdot \dfrac{N-n}{N-1}}
$$

と式変形できるので, $n$について解くと

$$
\begin{align*}
n&=\dfrac{m}{1+\dfrac{m-1}{N}}\\
&\text{where } \ \  m=\dfrac{z^2_{\alpha/2}\hat{p}(1-\hat{p})}{\epsilon^2}
\end{align*}
$$

今回の問題において分散が最大になる$p=0.5$と想定して解くと, $n \approx 463$くらいの規模になります.

## References

> オンラインマテリアル

- [PennState > STAT 415 > 6.3 - Estimating a Proportion for a Small, Finite Population](https://online.stat.psu.edu/stat415/lesson/6/6.3)

> 書籍

- [ Sampling: Design and Analysis, By Sharon L. Lohr](https://www.routledge.com/Sampling-Design-and-Analysis/Lohr/p/book/9780367279509)