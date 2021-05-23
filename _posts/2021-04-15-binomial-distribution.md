---
layout: post
title: "二項分布の紹介"
subtitle: "条件付き期待値の計算"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- math
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

||概要|
|---|---|
|目的|二項分布の紹介:条件付き期待値の計算|
|参考|- [高校数学の美しい物語 > 二項分布の平均と分散の二通りの証明](https://manabitimes.jp/math/913)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [二項分布](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83)
  - [ベルヌーイ分布](#%E3%83%99%E3%83%AB%E3%83%8C%E3%83%BC%E3%82%A4%E5%88%86%E5%B8%83)
  - [二項分布](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83-1)
    - [独立性と定常性](#%E7%8B%AC%E7%AB%8B%E6%80%A7%E3%81%A8%E5%AE%9A%E5%B8%B8%E6%80%A7)
    - [確率関数の総和](#%E7%A2%BA%E7%8E%87%E9%96%A2%E6%95%B0%E3%81%AE%E7%B7%8F%E5%92%8C)
  - [二項分布の期待値の証明](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [二項分布の分散の証明](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AE%E5%88%86%E6%95%A3%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [再生性](#%E5%86%8D%E7%94%9F%E6%80%A7)
  - [例題](#%E4%BE%8B%E9%A1%8C)
- [二項分布と二進数](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%A8%E4%BA%8C%E9%80%B2%E6%95%B0)
- [二項分布と条件付き期待値](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%A8%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E6%9C%9F%E5%BE%85%E5%80%A4)
  - [最尤推定値の計算法](#%E6%9C%80%E5%B0%A4%E6%8E%A8%E5%AE%9A%E5%80%A4%E3%81%AE%E8%A8%88%E7%AE%97%E6%B3%95)
  - [例題 with Python](#%E4%BE%8B%E9%A1%8C-with-python)
- [Appendix](#appendix)
  - [二項係数の定理](#%E4%BA%8C%E9%A0%85%E4%BF%82%E6%95%B0%E3%81%AE%E5%AE%9A%E7%90%86)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 二項分布
### ベルヌーイ分布

結果が2種類しかない試行をBernoulli experimentsといいます.

- 標本空間: $$S = \{\text{T}, \text{F}\}$$
- $$Pr(\text{T}) = p, Pr(\text{F}) = 1 - Pr(\text{T}) = p$$

ベルヌーイ確率変数$$X$$を、試行がTならば1, Fならば0と定義すると、確率関数は

$$
Pr(X = x) = p^x(1-p)^{1-x}
$$

### 二項分布

独立かつ定常性をもつベルヌーイ試行をn回繰り返します。各ベルヌーイ試行の確率変数を$$X_i$$と定義し、その総和$$X$$を以下のように定義します：

$$
X = \sum_{i=1}^n X_i
$$

このとき、確率変数$$X$$は二項分布に従う, $$X \sim \mathrm{B}(n, p)$$という。確率関数は

$$
Pr(X = k) = \:_nC_k p^k(1 - p)^{n-k} \tag{A}
$$

二項分布 $$\mathrm{B}(n,p)$$ に従う確率変数の期待値は $$np$$，分散は $$np(1-p)n$$.

> 例題

$$X_1, X_n$$ が独立で、ベルヌーイ分布$$\mathrm{Be}(p)$$に従う時、$$X_1 + \cdots + X_n$$は二項分布$$\mathrm{B}(n, p)$$に従うことを示せ.

> 解答

ベルヌーイ分布の性質から

$$
Pr(X_i = 1) = p, Pr(X_i = 0) = 1- p
$$

整数$$r$$について、$$r = \sum_{i=1}^nX_i$$なるのは、確率変数のうち$$r$$個が1をとり、残りが0の場合なのでその組合せは$$\:_nC_r$$存在する。それぞれの組合せは排反事象なので

$$
Pr(X_1 + \cdots + X_r = r) = \:_nC_r p(1-p)
$$


<div style="text-align: right;">
■
</div>


#### 独立性と定常性

- 独立性: 各試行の結果は、他の回の試行結果に影響を及ぼさない
- 定常性: 成功の確率、失敗の確率が、各試行を通じて一定

#### 確率関数の総和

$$U$$を標本空間とする.確率変数が満たすべき条件の一つとして、

$$
\sum_{k \in U} Pr(X = k) = 1
$$

二項分布の確率関数(A)について確認してみる.

$$
(p + (1-p))^n = \sum_{k=0}^n \:_nC_k p^k(1-p)^{n-k} = 1
$$

従って、条件を満たしている.

### 二項分布の期待値の証明

> 証明１

二項分布に従う確率変数は独立なベルヌーイ確率変数の和なので

$$
E[X] = E[\sum_{i=1}^n X_i] = \sum_{i=1}^nE[ X_i] = np
$$


<div style="text-align: right;">
■
</div>

> 証明2

期待値の定義より

$$
\begin{aligned}
E[X]&= \sum_{k=0}^n k \:_nC_k p^k(1-p)^{n-k}\\
&= np\sum_{k=1}^n \:_{n-1}C_{k-1} p^{k-1}(1-p)^{n-k}\\
&= np\sum_{k=0}^{n-1} \:_{n}C_{k} p^{k}(1-p)^{n-1-k}\\
&= np (\because \text{二項定理})
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

### 二項分布の分散の証明

> 証明1

二項分布に従う確率変数は独立なベルヌーイ確率変数の和なので

$$
V(X) = V(\sum_{i=1}^n X_i) = \sum_{i=1}^n V(X_i) = np(1-p)
$$

<div style="text-align: right;">
■
</div>

> 証明2

$$
\begin{aligned}
E[X^2]&= \sum_{k=0}^n k^2\:_nC_k p^k(1-p)^{n-k}\\
&= \sum_{k=1}^n k(k-1)\:_nC_k p^k(1-p)^{n-k} + \sum_{k=0}^n k\:_nC_k p^k(1-p)^{n-k}\\
&= n(n-1)p^2 \sum_{k=2}^{n-2} \:_{n-2}C_{k-2} p^{k-2}(1-p)^{n-k} + np\\
&= n(n-1)p^2 \sum_{k=0}^{n-2} \:_{n-2}C_{k} p^{k}(1-p)^{n-2-k} + np\\
&= n(n-1)p^2 + np
\end{aligned}
$$

よって， $$V(X) = n(n-1)p^2 + np - n^2p^2 = np(1-p)$$

<div style="text-align: right;">
■
</div>

### 再生性

ある同一の確率分布に従い独立な確率変数$$X, Y$$について、$$X + Y$$が同じ確率分布に従うとき、その確率分布は再生性をもつといいます.
二項分布も再生性を持ちます。

> 証明

- $$X\sim \mathrm{B}(n, p)$$
- $$Y\sim \mathrm{B}(m, p)$$
- $$X, Y$$は独立
- $$Z = X + Y$$

$$
\begin{aligned}
P(Z = z) &= P(X + Y = z)\\[8pt]
&= \sum_{x+y = z}P(X=x)P(Y=y)\\
&= \sum_{x+y = z}\:_nC_x\:_mC_yp^z(1-p)^{m+n-z}\\
&= p^z(1-p)^{m+n-z}\sum_{x+y = z}\:_nC_x\:_mC_y\\
&= \:_{m+n}C_zp^z(1-p)^{m+n-z} 
\end{aligned}
$$

最後の展開は[二項係数の定理](#%E4%BA%8C%E9%A0%85%E4%BF%82%E6%95%B0%E3%81%AE%E5%AE%9A%E7%90%86)を参照.

<div style="text-align: right;">
■
</div>

### 例題

元ネタはH26 東京大学 大学院新領域創成科学研究科 情報生命科学専攻 第5問

> 問題

表が出る確率が $$p \: (0 < p < 1)$$、裏が出る確率が $$1 - p$$ のコインを独立にN回 $$ (N > 1) $$ 投げ、得られる表と裏の列を考える。以下の問に、式の導出も含めて答えよ。

(1) $$N = 5$$とする。列「表表裏表裏」が得られる確率を求めよ。<br> 
(2) 最初の $$l$$個 $$(0 \leq l \leq N)$$ がすべて表になる確率を求めよ。 <br>
(3) 初めて裏がでるまでの、表の数を$$m$$とする。ただし、裏がひとつもない列では$$m = N$$とする $$0\leq m \leq N $$。mの期待値を求めよ。<br> 
(4) 表をn個 $$(0 \leq n \leq N)$$、裏を $$N-n$$ 個持つ列が得られる確率 $$P(n \mid N, p )$$を求めよ。<br>
(5) (4)において、nの期待値を求めよ。<br> 
(6) $$n$$と$$\lambda = Np$$を固定し、$$N\to\infty$$をとると、$$P(n \mid N, p )$$はポアソン分布になることを示せ

> 解(1)

$$X_i$$を $$i$$ 回目の試行のときの確率変数とする. 各試行は互いに独立、かつ問題設定より定常なので

$$
\begin{aligned}
&P((X_1, X_2, X_3, X_4, X_5) = (\text{表, 表, 裏, 表, 裏}) ) \\[8pt]
&= P(X_1 = \text{表})P(X_2 = \text{表})P(X_3 = \text{裏})P(X_4 = \text{表})P(X_5 = \text{裏})\\
&= p^3(1-p)^2
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

> 解(2)

最初の $$l$$ 個が表で、残りの $$N-l$$ 個のコインの結果は表裏問わないので $$p^l$$

<div style="text-align: right;">
■
</div>

> 解(3)

$$0 \leq m \leq N-1$$の範囲では、最後の試行で裏がでなくてはならず、$$m = N$$のときは $$N$$ 回表が出続ける.これをふまえると

$$
\begin{aligned}
E(m) &= \sum_{k=0}^{N-1}kp^k(1-p) + Np^N\\
&= (1-p)\frac{(p-p^N)/(1-p) - (N-1)p^N}{1-p} + Np^N
&= \frac{(p-p^N)}{1-p} - (N-1)p^N + Np^N\\
&= \frac{p(1-p^N)}{1-p}
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

> 解(4), (5)

$$
P(n|N, p) = \:_NC_np^n(1-p)^{N-n}
$$

期待値は

$$
E[X] = \sum_{k=0}^N k\:_NC_kp^k(1-p)^{N-k} = Np
$$

<div style="text-align: right;">
■
</div>

> 解(6)

$$p = \lambda/N$$ 及び, (4)の解答より

$$
\begin{aligned}
P(n|N, p) &= \:_NC_np^n(1-p)^{N-n}\\[8pt]
&=\frac{N!}{(N - n)!n!}p^n(1-p)^{N-n}\\
&=\frac{N!}{(N - n)!n!}\left(\frac{\lambda}{N}\right)^n\left(1 - \frac{\lambda}{N}\right)^{N-n}\\
&= \frac{N(N-1)(N-2)\cdots(N-n+1)}{n!}\left(\frac{\lambda}{N}\right)^n\left(1 - \frac{\lambda}{N}\right)^{N}\left(1 - \frac{\lambda}{N}\right)^{-n}\\
&= 1\left(1 - \frac{1}{N}\right)\left(1 - \frac{2}{N}\right)\cdots\left(1 - \frac{N-n+1}{N}\right)\frac{\lambda^n}{n!}\left(1 - \frac{\lambda}{N}\right)^{N}\left(1 - \frac{\lambda}{N}\right)^{-n}
\end{aligned}
$$

ここで、$$N\to \infty$$をとると$$N$$以外は固定された値なので

$$
\begin{aligned}
&\lim_{N\to\infty}1\left(1 - \frac{1}{N}\right)\left(1 - \frac{2}{N}\right)\cdots\left(1 - \frac{N-n+1}{N}\right) = 1\\
&\lim_{N\to\infty}\left(1 - \frac{\lambda}{N}\right)^{N} = \exp(-\lambda)\\
&\lim_{N\to\infty}\left(1 - \frac{\lambda}{N}\right)^{-n} = 1
\end{aligned}
$$

$$
\therefore \: \lim_{N\to\infty}P(X = n|N, p) = \frac{\lambda^n}{n!}\exp(\lambda)
$$


<div style="text-align: right;">
■
</div>

## 二項分布と二進数

こちらの元ネタは[H31東京大学大学院工学系研究科入学試験](https://www.t.u-tokyo.ac.jp/shared/admission/data/H31_suugaku_J)

- $$X_1, X_2, \cdots, X_n$$は独立
- $$X_k \: (k = 1, 2, \cdots, n)$$は、それぞれ確率 $$p$$ で値1をとり、確率 $$1-p$$ で値0を取る

確率変数 $$X_1, X_2, \cdots, X_n$$ を順に並べて作った列 $$X_n\cdots X_2X_1$$ を $$n$$ 桁の2進数とみなすことで得られる整数を $$Y$$とします。たとえば、 $$n=4$$とし、$$X_4X_3X_2X_1$$ が $$0101$$ ならば $$Y = 5$$. このときの $$Y$$ の期待値と分散を求めます

> 期待値の計算

確率変数 $$Y$$ の定義域は $$0 $$から $$2^n-1$$.　これを踏まえると

$$
\begin{aligned}
E[Y] &= E\left[\sum^n_{i=1}2^{i-1}X_i\right]\\
&= \sum^n_{i=1}2^{i-1} E[X_i] \: \because \text{ 独立性}\\
&= p \sum^n_{i=1}2^{i-1}\\
&= p \sum^{n-1}_{i=0}2^{i}\\
&= (2^n - 1)p
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

> 分散の計算

$$
\begin{aligned}
V(Y) &= V\left(\sum^n_{i=1}2^{i-1}X_i\right)\\
&= p(1-p)\sum^n_{i=1}4^{i-1}\\
&= \frac{4^n - 1}{3}p(1-p)
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

> Pythonで確認

[こちら](https://colab.research.google.com/drive/1Fj1OPTD-kinR5SMPMb0zbj1sR2xUeK4P?usp=sharing)参考

```python
import random
import matplotlib.pyplot as plt
import numpy as np

random.seed(42)

### Data generation
n_digits = 8
n_simulation = 1000
p = 0.3
data = []

for t in range(n_simulation):
  v = sum([2**i if random.random() < p else 0 for i in range(n_digits)])
  data.append(v)

### mean and varioance
mu = np.mean(data)
var = np.var(data, ddof = 1)

expected_mu = (2**n_digits - 1)*p
expected_var = (4**n_digits - 1)*p*(1-p)/3

print("Dataから得られる平均値: {:.3f}, 理論から導かれる期待値: {:.3f}".format(mu, expected_mu))
print("Dataから得られる分散: {:.3f}, 理論から導かれる分散: {:.3f}".format(var, expected_var))
>>>Dataから得られる平均値: 71.755, 理論から導かれる期待値: 76.500
>>>Dataから得られる分散: 4362.123, 理論から導かれる分散: 4587.450
```

## 二項分布と条件付き期待値

パラメータ $$n, \theta$$ の二項分布 $$\mathbf{B}(n, \theta)$$ に従う確率変数 を$$X$$とする.

$$X \geq 1$$の条件の下での $$X$$ の条件付き確率関数は

$$
\begin{align*}
P(X = x|X\geq 1) &= \frac{P(X = x, X \geq 1)}{P(X \geq 1)}\\
&= \frac{P(X = x)}{P(X \geq 1)} \: \text{ where } (x = 1, 2, \cdots, n) \tag{A}
\end{align*}
$$

(A)の分子は $$\:_nC_x \theta^{x}(1 - \theta)^{n-x}$$. 一方、分母は

$$
\begin{aligned}
P(X \geq 1) &= \sum_{k=1}^n \:_nC_k\theta^k(1 - \theta)^{n-k}\\
&= 1 - \:_nC_0\theta^0(1 - \theta)^{n}\\
&= 1 - (1 - \theta)^n
\end{aligned}
$$

$$
\therefore \: P(X = x|X\geq 1) = \frac{\:_nC_x \theta^{x}(1 - \theta)^{n-x}}{1 - (1 - \theta)^n}
$$

$$X$$の条件付き期待値は

$$
\begin{aligned}
E[X\mid X\geq 1] &= \frac{1}{1 - (1 - \theta)^n} \sum_{k = 1}^n k\:_nC_x \theta^{x}(1 - \theta)^{n-x}\\
&= \frac{n\theta}{1 - (1 - \theta)^n}
\end{aligned}
$$

同様に

$$
\begin{aligned}
E[X^2\mid X\geq 1] &= \frac{1}{1 - (1 - \theta)^n} \sum_{k = 1}^n k^2\:_nC_x \theta^{x}(1 - \theta)^{n-x}\\
&= \frac{n\theta(1 - \theta) + n^2\theta^2}{1 - (1 - \theta)^n}
\end{aligned}
$$

$$
\therefore \: V(X|X\geq 1) = \frac{n\theta(1 - \theta)}{1 - (1 - \theta)^n} - \frac{n^2\theta^2(1 - \theta)}{\{1 - (1 - \theta)^n\}^2}
$$

### 最尤推定値の計算法

$$X \geq 1$$の条件の下で,独立な $$m$$個の観測値 $$y_1, \cdots, y_m$$を得たとし、その平均を $$\bar y = \sum_{i=1}^m y_i/m$$ とします.このとき、パラメータ $$\theta$$ を最尤法で推定したいとします.

まず尤度関数を定義します:

$$
\begin{aligned}
L(\theta; \mathbf{y}) &= \prod_{i=1}^m\frac{\:_nC_{y_i}\theta^{y_i}(1 - \theta)^{n - y_i}}{1 - (1 - \theta)^n}\\[8pt]
&= \frac{\theta^{m\bar y}(1 - \theta)^{mn - m\bar y}}{(1 - (1 - \theta)^n)^m}\prod\:_nC_{y_i}
\end{aligned}
$$

対数尤度関数は

$$
\begin{aligned}
l(\theta; \mathbf{y}) &= \log L(\theta; \mathbf{y})\\[8pt]
&= \log \left(\prod\:_nC_{y_i}\right) + m\bar y\log\theta +  (mn - m\bar y)\log(1 - \theta) - m\log(1 - (1 - \theta)^n)
\end{aligned}
$$

$$l(\theta; \mathbf{y})$$を$$\theta$$で偏微分すると,

$$
\frac{\partial l(\theta; \mathbf{y})}{\partial \theta} = \frac{m\bar y}{\theta} - \frac{m(n - \bar y)}{1 - \theta} - \frac{mn(1 - \theta)^{n-1}}{1 - (1 - \theta)^n}
$$

これを $$0$$ とおいて整理すると、

$$
n\hat\theta = \bar y \{1 - (1 - \hat\theta)^n\} \tag{A}
$$


この推定式はモーメント法に基づく推定値であることもわかる. なお、式(A)から$$\hat\theta$$は陽にはもとめられないので、実務では反復計算で計算する. 一例として, $$\hat\theta^{(0)} = \bar y /n$$のような適当な初期値を設定し、

$$
\hat\theta^{(t+1)} = \frac{\bar \{1 - (1 - \hat\theta^{(t)})^n\}}{n}
$$

という反復スキームで求める. 

### 例題 with Python

> 問題

確率変数

$$
x_i {\stackrel{\text{i.i.d}}{\sim}}  \mathbf{B}(N, \theta), \: (i = 1, \cdots, M)
$$

を考えます. データとして観測できる確率変数 $$y_i$$ は以下のように定義される:

$$
y_i = \begin{cases}
x_i & \:\text{ if } x_i \geq 3\\
0 & \:\text{otherwise}
\end{cases}
$$

このとき、$$\theta$$を推定せよ.

> 解答

まず条件付き確率を考えます:

$$
\begin{aligned}
P(x_i = x|x_i \geq 3) &= \frac{\:_nC_x\theta^x(1-\theta)^{n-x}}{1- \sum_{k=0}^2 \:_nC_k\theta^k(1-\theta)^{n-k} }\\[8pt]
&= \frac{\:_nC_x\theta^x(1-\theta)^{n-x}}{1 - \frac{(1 - \theta)^{n-2}}{2}\{(n-1)(n-2)\theta^2 + 2\theta(n-2)+2\}}
\end{aligned}
$$

条件付き期待値は

$$
\begin{aligned}
E[x_i|x_i\geq 3] &= \frac{\sum_{k=3}^n k\:_nC_k \theta^k(1 - \theta)^{n-k}}{1 - \frac{(1 - \theta)^{n-2}}{2}\{(n-1)(n-2)\theta^2 + 2\theta(n-2)+2\}}\\[8pt]
&= \frac{n\theta - n\theta(1-\theta)^{n-1}-n(n-1)\theta^2(1 - \theta)^{n-2}}{1 - \frac{(1 - \theta)^{n-2}}{2}\{(n-1)(n-2)\theta^2 + 2\theta(n-2)+2\}}
\end{aligned}
$$

> Dataと推定

- $$N = 10$$
- $$M = 1000$$
- $$\theta = 0.3$$

このパラメータのもと, 設問に則した形でデータを生成して推定してみる.

```python
import numpy as np
from scipy.stats import binom

# data generationg
## params
n = 10
m = 1000
p = 0.3

## seed
np.random.seed(42)


## data
data = binom.rvs(n, p, size=m)
data = np.where(data > 2 , data, 0)

## calculating the mean
print(np.average(data, weights=(data > 0)))
>> 3.891304347826087
```

これを[Wolfram Alpha](https://ja.wolframalpha.com/input/?i=3.89%3D+%5Cfrac%7B10x+-+10x%281-x%29%5E%7B9%7D-90x%5E2%281+-+x%29%5E%7B8%7D%7D%7B1+-+%5Cfrac%7B%281+-+x%29%5E%7B8%7D%7D%7B2%7D%2872x%5E2+%2B+16x%2B2%29%7D)をもちいて解くと,

$$
\hat\theta = 0.296243
$$


## Appendix
### 二項係数の定理

$$
\sum_{i=0}^k \:_nC_i\:_mC_{k-i} = \:_{m+n}C_{k}
$$

> 証明

二項定理より

$$
\begin{aligned}
(1 + x)^m &= \sum_{i=0}^m \:_mC_i x^i\\
(1 + x)^n &= \sum_{i=0}^n \:_nC_i x^i
\end{aligned}
$$

これらの積の$$x^k$$の係数は

$$
\sum_{i=0}^k \:_nC_i\:_mC_{k-i}
$$

一方、$$(1+x)^{m+n}$$の係数は $$\:_{m+n}C_{k}$$

$$
\therefore \sum_{i=0}^k \:_nC_i\:_mC_{k-i} = \:_{m+n}C_{k}
$$

<div style="text-align: right;">
■
</div>
