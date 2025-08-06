---
layout: post
title: "統計検定：二項分布の性質"
subtitle: "条件付き期待値の計算"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 
tags:

- 統計検定
- 統計
- Python
- 二項分布
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 二項分布の性質](#1-%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [ベルヌーイ分布](#%E3%83%99%E3%83%AB%E3%83%8C%E3%83%BC%E3%82%A4%E5%88%86%E5%B8%83)
  - [二項分布の特性値](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AE%E7%89%B9%E6%80%A7%E5%80%A4)
    - [MLEによるパラメーター推定](#mle%E3%81%AB%E3%82%88%E3%82%8B%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC%E6%8E%A8%E5%AE%9A)
    - [ベルヌーイ分布の合成と二項分布](#%E3%83%99%E3%83%AB%E3%83%8C%E3%83%BC%E3%82%A4%E5%88%86%E5%B8%83%E3%81%AE%E5%90%88%E6%88%90%E3%81%A8%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83)
    - [確率母関数, MGF, CF](#%E7%A2%BA%E7%8E%87%E6%AF%8D%E9%96%A2%E6%95%B0-mgf-cf)
    - [確率関数の総和](#%E7%A2%BA%E7%8E%87%E9%96%A2%E6%95%B0%E3%81%AE%E7%B7%8F%E5%92%8C)
    - [再生性](#%E5%86%8D%E7%94%9F%E6%80%A7)
  - [推定量$\hat p$の分散の不偏推定量](#%E6%8E%A8%E5%AE%9A%E9%87%8F%5Chat-p%E3%81%AE%E5%88%86%E6%95%A3%E3%81%AE%E4%B8%8D%E5%81%8F%E6%8E%A8%E5%AE%9A%E9%87%8F)
  - [推定量$\hat p$の分散の不偏推定量](#%E6%8E%A8%E5%AE%9A%E9%87%8F%5Chat-p%E3%81%AE%E5%88%86%E6%95%A3%E3%81%AE%E4%B8%8D%E5%81%8F%E6%8E%A8%E5%AE%9A%E9%87%8F-1)
  - [二項分布に従う確率変数の正規分布近似](#%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AB%E5%BE%93%E3%81%86%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E8%BF%91%E4%BC%BC)
  - [練習問題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C)
    - [(1) H26 東京大学 大学院新領域創成科学研究科 情報生命科学専攻 第5問](#1-h26-%E6%9D%B1%E4%BA%AC%E5%A4%A7%E5%AD%A6-%E5%A4%A7%E5%AD%A6%E9%99%A2%E6%96%B0%E9%A0%98%E5%9F%9F%E5%89%B5%E6%88%90%E7%A7%91%E5%AD%A6%E7%A0%94%E7%A9%B6%E7%A7%91-%E6%83%85%E5%A0%B1%E7%94%9F%E5%91%BD%E7%A7%91%E5%AD%A6%E5%B0%82%E6%94%BB-%E7%AC%AC5%E5%95%8F)
    - [(2) ベルヌーイ試行と二進数: H31東京大学大学院工学系研究科入学試験](#2-%E3%83%99%E3%83%AB%E3%83%8C%E3%83%BC%E3%82%A4%E8%A9%A6%E8%A1%8C%E3%81%A8%E4%BA%8C%E9%80%B2%E6%95%B0-h31%E6%9D%B1%E4%BA%AC%E5%A4%A7%E5%AD%A6%E5%A4%A7%E5%AD%A6%E9%99%A2%E5%B7%A5%E5%AD%A6%E7%B3%BB%E7%A0%94%E7%A9%B6%E7%A7%91%E5%85%A5%E5%AD%A6%E8%A9%A6%E9%A8%93)
    - [(3) マルコフ過程 一橋1992年](#3-%E3%83%9E%E3%83%AB%E3%82%B3%E3%83%95%E9%81%8E%E7%A8%8B-%E4%B8%80%E6%A9%8B1992%E5%B9%B4)
- [2. 二項分布と条件付き期待値](#2-%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%A8%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E6%9C%9F%E5%BE%85%E5%80%A4)
  - [最尤推定値の計算法](#%E6%9C%80%E5%B0%A4%E6%8E%A8%E5%AE%9A%E5%80%A4%E3%81%AE%E8%A8%88%E7%AE%97%E6%B3%95)
  - [例題](#%E4%BE%8B%E9%A1%8C)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 二項分布の性質
### ベルヌーイ分布

結果が2種類しかない試行をBernoulli experimentsといいます.

- 標本空間: $S = \{\text{T}, \text{F}\}$
- $Pr(\text{T}) = p, Pr(\text{F}) = 1 - Pr(\text{T}) = p$

ベルヌーイ確率変数$X$を、試行がTならば1, Fならば0と定義すると、確率関数は

$$
Pr(X = x) = p^x(1-p)^{1-x}
$$

> 平均と分散

$$
\begin{align*}
\mathbb E[X] &= p\\
V(X) &= p(1-p)
\end{align*}
$$

### 二項分布の特性値

独立かつ定常性をもつベルヌーイ試行をn回繰り返します。各ベルヌーイ試行の確率変数を$X_i$と定義し、その総和$X$を以下のように定義します：

$$
X = \sum_{i=1}^n X_i
$$

このとき、確率変数$X$は二項分布に従うといいます, i.e., $X \sim \mathrm{B}(n, p)$という。確率関数は

$$
\begin{align*}
Pr(X = k) &= \:_nC_k p^k(1 - p)^{n-k}\\
&= \frac{n!}{(n-k)!k!}p^k(1 - p)^{n-k}\\
&= \frac{1}{(n+1)Beta(n-k+1, k+1)}p^k(1 - p)^{n-k}\quad\quad\tag{1.1}
\end{align*}
$$

二項分布 $\mathrm{B}(n,p)$ に従う確率変数の期待値は $np$，分散は $np(1-p)$.

- 独立性: 各試行の結果は、他の回の試行結果に影響を及ぼさない
- 定常性: 成功の確率、失敗の確率が、各試行を通じて一定

> 平均と分散の導出

$$
\begin{aligned}
\mathbb E[X]&= \sum_{k=0}^n k \:_nC_k p^k(1-p)^{n-k}\\
&= np\sum_{k=1}^n \:_{n-1}C_{k-1} p^{k-1}(1-p)^{n-k}\\
&= np\sum_{k=0}^{n-1} \:_{n-1}C_{k} p^{k}(1-p)^{n-1-k}\\
&= np 
\end{aligned}
$$

$$
\begin{aligned}
\mathbb E[X^2]&= \sum_{k=0}^n k^2\:_nC_k p^k(1-p)^{n-k}\\
&= \sum_{k=1}^n k(k-1)\:_nC_k p^k(1-p)^{n-k} + \sum_{k=0}^n k\:_nC_k p^k(1-p)^{n-k}\\
&= n(n-1)p^2 \sum_{k=2}^{n-2} \:_{n-2}C_{k-2} p^{k-2}(1-p)^{n-k} + np\\
&= n(n-1)p^2 \sum_{k=0}^{n-2} \:_{n-2}C_{k} p^{k}(1-p)^{n-2-k} + np\\
&= n(n-1)p^2 + np
\end{aligned}
$$

よって， $V(X) = n(n-1)p^2 + np - n^2p^2 = np(1-p)$


#### MLEによるパラメーター推定

$n$回の試行で $x$回の成功が観測されたとき、パラメーター$p$についての尤度関数は

$$
\begin{align*}
L(p) &= \frac{\Gamma(n+1)}{\Gamma(n-x+1)\Gamma(x+1)}p^x(1-p)^{n-x}\\
&\Rightarrow \log L(p) = \log \frac{\Gamma(n+1)}{\Gamma(n-x+1)\Gamma(x+1)} + x\log p + (n-x) \log (1-p)
\end{align*}
$$

対数尤度に対して、$p$についてのFOCを求めれると

$$
\frac{\partial \log L(p^*)}{\partial p} = \frac{x}{p^*} - \frac{n-x}{1 - p^*} = 0
$$

従って最尤法によるパラメーター推定量として

$$
\hat p_{MLE} = \frac{x}{n}
$$

また、以下の式展開より$\hat p_{MLE}$は不変推定量であることがわかります:

$$
\begin{align*}
\mathbb E[\hat p] &= \frac{\mathbb E[x]}{n}\\
&= \frac{\mathbb np}{n}\\
&= p
\end{align*}
$$

#### ベルヌーイ分布の合成と二項分布

$X_1,\cdots, X_n$ が独立で、ベルヌーイ分布$\mathrm{Be}(p)$に従う時、$X_1 + \cdots + X_n$は二項分布$\mathrm{B}(n, p)$に従うことを示します.

> 導出

ベルヌーイ分布の性質から

$$
Pr(X_i = 1) = p, Pr(X_i = 0) = 1- p
$$

整数$r$について、$r = \sum_{i=1}^nX_i$なるのは、確率変数のうち$x$個が1をとり、残りが0の場合なのでその組合せは$\:_nC_x$存在する。それぞれの組合せは排反事象なので

$$
Pr(X_1 + \cdots + X_r = r) = \:_nC_x p^x(1-p)^{n-x}
$$


<div style="text-align: right;">
■
</div>

次に独立なベルヌーイ試行の合成によって二項分布が表現できることを利用した、二項分布の平均と分散の導出を紹介します.


二項分布に従う確率変数は独立なベルヌーイ確率変数の和なので

$$
\mathbb E[X] = \mathbb E[\sum_{i=1}^n X_i] = \sum_{i=1}^n\mathbb E[X_i] = np
$$

同様に

$$
V(X) = V(\sum_{i=1}^n X_i) = \sum_{i=1}^n V(X_i) = np(1-p)
$$


#### 確率母関数, MGF, CF

- 確率母関数: $(ps + 1- p)^n$
- 積率母関数: $(p\exp(t) - 1 - p)^n$
- 特性関数: $(p\exp(it) - 1 - p)^n$

> 積率母関数の導出

$$
\begin{align*}
M_X(t) &= \mathbb E[\exp(tX)]\\[8pt]
&= \sum \exp(tx)\:_nC_k p^x(1-p)^{n-x}\\[8pt]
&= \sum \:_nC_k (\exp(t)p)^x(1-p)^{n-x}\\[8pt]
&= (\exp(t)p + 1 - p)^n
\end{align*}
$$

#### 確率関数の総和

$U$を標本空間とする.確率変数が満たすべき条件の一つとして、

$$
\sum_{k \in U} Pr(X = k) = 1
$$

二項分布の確率関数(1.1)について確認してみる.

$$
(p + (1-p))^n = \sum_{k=0}^n \:_nC_k p^k(1-p)^{n-k} = 1
$$

従って、条件を満たしている.



#### 再生性

ある同一の確率分布に従い独立な確率変数$X, Y$について、$X + Y$が同じ確率分布に従うとき、その確率分布は再生性をもつといいます.
二項分布も再生性を持ちます。(1)で二項係数の定理を示し、(2)で二項係数の定理を所与として、二項分布の再生性を示します

なお、二項係数の定理とは

$$
\sum_{i=0}^k \:_nC_i\:_mC_{k-i} = \:_{m+n}C_{k}
$$

> (1) 二項係数の定理の証明


二項定理より

$$
\begin{aligned}
(1 + x)^m &= \sum_{i=0}^m \:_mC_i x^i\\
(1 + x)^n &= \sum_{i=0}^n \:_nC_i x^i
\end{aligned}
$$

これらの積の$x^k$の係数は

$$
\sum_{i=0}^k \:_nC_i\:_mC_{k-i}
$$

一方、$(1+x)^{m+n}$の係数は $C(m+n, k)$

$$
\therefore \sum_{i=0}^k \:_nC_i\:_mC_{k-i} = \:_{m+n}C_{k}
$$


> (2) 二項分布の再生性の証明

- $X\sim \mathrm{B}(n, p)$
- $Y\sim \mathrm{B}(m, p)$
- $X, Y$は独立
- $Z = X + Y$

$$
\begin{aligned}
P(Z = z) &= P(X + Y = z)\\[8pt]
&= \sum_{x+y = z}P(X=x)P(Y=y)\\
&= \sum_{x+y = z}\:_nC_x\:_mC_yp^z(1-p)^{m+n-z}\\
&= p^z(1-p)^{m+n-z}\sum_{x+y = z}\:_nC_x\:_mC_y
\end{aligned}
$$


二項係数の定理の定理より

$$
p^z(1-p)^{m+n-z}\sum_{x+y = z}\:_nC_x\:_mC_y = \:_{m+n}C_zp^z(1-p)^{m+n-z}
$$

<div style="text-align: right;">
■
</div>

### 推定量$\hat p$の分散の不偏推定量

確率変数$X\sim Bin(p, N)$としたときのpの推定量は$\hat p = X/N$と表現されることから

$$
\begin{align*}
Var(\hat p) &= Var \left(\frac{X}{n}\right)\\
&= \frac{p(1-p)}{n}
\end{align*}
$$

ただ、実際には$p$は分析者にはわからないので不偏推定量かつ一致推定量である$\hat p$を$p$の代わりに用いた分散推定量$\hat v_n$を考えます.

$$
\hat v_n= \frac{\hat p(1-\hat p)}{n}
$$

ただこの推定量は不偏推定量ではありません.

> 証明

$$
\begin{align*}
\mathbb E[v_n(\hat p)] &= \frac{1}{n}\mathbb E[\hat p(1-\hat p)]\\
&= \frac{1}{n}\left(p - p^2 - \frac{p(1-p)}{n}\right)\\
&= \frac{p(1-p)}{n}\frac{n-1}{n}\\ \quad\quad\tag{1.2}
&\neq \frac{p(1-p)}{n} 
\end{align*}
$$

### 推定量$\hat p$の分散の不偏推定量

(1.2)より$Var(\hat p)$の不偏推定量は

$$
\begin{align*}
\tilde v_n &= \frac{n}{n-1}\hat v_n\\[8pt]
&= \frac{\hat p(1-\hat p)}{n-1}
\end{align*}
$$

ということがわかります. この推定量の活用方法に一つとして、二項分布の正規分布近似に基づいた信頼区間の導出があります

$$
CI = \hat p \pm z_{\alpha/2}\sqrt {\tilde v_n }
$$

ただ、以下のように信頼区間を求める方法もあります. 詳しくは[NIST Engineering Statistics Handbbok](https://www.itl.nist.gov/div898/handbook/prc/section2/prc241.htm)を参照してください.

$$
\large
\begin{align*}
\mbox{U.L. } & = & \frac{\hat{p} + \frac{z^2_{1-\alpha/2}}{2n} + z_{1-\alpha/2}
\sqrt{ \frac{\hat{p}(1-\hat{p})}{n} + \frac{z^2_{1-\alpha/2}}{4n^2} }}
{1 + \frac{z^2_{1-\alpha/2}}{n}} \\
 &   & \\
 &   & \\
\mbox{L.L. } & = & \frac{\hat{p} + \frac{z^2_{\alpha/2}}{2n} + z_{\alpha/2}
\sqrt{ \frac{\hat{p}(1-\hat{p})}{n} + \frac{z^2_{\alpha/2}}{4n^2} }}
{1 + \frac{z^2_{\alpha/2}}{n}} \, . 
\end{align*}
$$


### 二項分布に従う確率変数の正規分布近似

$$
X\sim \mathrm B(n, p)
$$

について、

$$
Z = \frac{X - np}{\sqrt{np(1-p)}}
$$

という変数変換を考えます. $n\to\infty$のとき$Z$は標準正規分布に従うことが知られています.

> 証明

$Z$のMGFの極限値が標準正規分布のMGF $\exp(-t^2/2)$に従うことを示せばよいです.

$$
\begin{align*}
M_Z(t) &= E\left[\exp\left(t\frac{X - np}{\sqrt{np(1-p)}}\right)\right]\\
&= \exp\left(\frac{- tnp}{\sqrt{np(1-p)}}\right)E\left[\exp\left(X\frac{t}{\sqrt{np(1-p)}}\right)\right]\\
&= \exp\left(\frac{- tnp}{\sqrt{np(1-p)}}\right)\left(p\exp\left(\frac{t}{\sqrt{np(1-p)}}\right)+1-p\right)^n
\end{align*}
$$

これの対数を取ると

$$
\begin{align*}
\log M_Z(t) = \frac{- tnp}{\sqrt{np(1-p)}} + n\log\left(p\exp\left(\frac{t}{\sqrt{np(1-p)}}\right)+1-p\right)
\end{align*}
$$

テイラー展開から導かれる以下２つの近似式をここで用いる

$$
\begin{align*}
\exp(x) &= 1 + x + \frac{x^2}{2} + o(x^2)\\
\log(1 + x) &= 1 + x - \frac{x^2}{2} + o(x^2)
\end{align*}
$$

従って、オーダーで抑えながら計算することに注意すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\log M_Z(t)&= \frac{- tnp}{\sqrt{np(1-p)}} + n\log\left(p\left(1 + \frac{t}{\sqrt{np(1-p)}} + \frac{t^2}{np(1-p)} + o(n^{-1})\right)+1-p\right)\\
&= \frac{- tnp}{\sqrt{np(1-p)}} + n\log\left(1 + \frac{tp}{\sqrt{np(1-p)}} + \frac{t^2}{n(1-p)} + o(n^{-1})\right)\\
&= \frac{- tnp}{\sqrt{np(1-p)}} + \frac{tnp}{\sqrt{np(1-p)}}+ \frac{t^2}{1-p} -  \frac{nt^2p^2}{2n(1-p)}+o(1)\\
&= \frac{t^2}{(1-p)} -  \frac{t^2p^2}{2(1-p)}+o(1)\\
&= \frac{t^2}{2} + o(1)
\end{align*}
$$
</div>


従って、$M_Z(t)\to \exp(t^2/2)$

### 練習問題

#### (1) H26 東京大学 大学院新領域創成科学研究科 情報生命科学専攻 第5問

表が出る確率が $p \: (0 < p < 1)$、裏が出る確率が $1 - p$ のコインを独立にN回 $ (N > 1) $ 投げ、得られる表と裏の列を考える。以下の問に、式の導出も含めて答えよ。

(1-1) $N = 5$とする。列「表表裏表裏」が得られる確率を求めよ。<br><br>
(1-2) 最初の $l$個 $(0 \leq l \leq N)$ がすべて表になる確率を求めよ。 <br><br>
(1-3) 初めて裏がでるまでの、表の数を$m$とする。ただし、裏がひとつもない列では$m = N$とする $0\leq m \leq N $。mの期待値を求めよ。<br><br>
(1-4) 表をn個 $(0 \leq n \leq N)$、裏を $N-n$ 個持つ列が得られる確率 $P(n \mid N, p )$を求めよ。<br><br>
(1-5) (4)において、nの期待値を求めよ。<br> <br>
(1-6) $n$と$\lambda = Np$を固定し、$N\to\infty$をとると、$P(n \mid N, p )$はポアソン分布になることを示せ

> (1-1)の解答

$X_i$を $i$ 回目の試行のときの確率変数とする. 各試行は互いに独立、かつ問題設定より定常なので

$$
\begin{aligned}
&P((X_1, X_2, X_3, X_4, X_5) = (\text{表, 表, 裏, 表, 裏}) ) \\[8pt]
&= P(X_1 = \text{表})P(X_2 = \text{表})P(X_3 = \text{裏})P(X_4 = \text{表})P(X_5 = \text{裏})\\
&= p^3(1-p)^2
\end{aligned}
$$


> (1-2)の解答

最初の $l$ 個が表で、残りの $N-l$ 個のコインの結果は表裏問わないので $p^l$


> (1-3)の解答

$0 \leq m \leq N-1$の範囲では、最後の試行で裏がでなくてはならず、$m = N$のときは $N$ 回表が出続ける.これをふまえると

$$
\begin{aligned}
E(m) &= \sum_{k=0}^{N-1}kp^k(1-p) + Np^N\\
&= (1-p)\frac{(p-p^N)/(1-p) - (N-1)p^N}{1-p} + Np^N
&= \frac{(p-p^N)}{1-p} - (N-1)p^N + Np^N\\
&= \frac{p(1-p^N)}{1-p}
\end{aligned}
$$


> (1-4), (1-5)の解答

$$
P(n|N, p) = \:_NC_np^n(1-p)^{N-n}
$$

期待値は

$$
\mathbb E[X] = \sum_{k=0}^N k\:_NC_kp^k(1-p)^{N-k} = Np
$$



> (1-6)の解答

$p = \lambda/N$ 及び, (1-4)の解答より

$$
\begin{aligned}
P(n|N, p) &= \:_NC_np^n(1-p)^{N-n}\\[8pt]
&=\frac{N!}{(N - n)!n!}p^n(1-p)^{N-n}\\
&=\frac{N!}{(N - n)!n!}\left(\frac{\lambda}{N}\right)^n\left(1 - \frac{\lambda}{N}\right)^{N-n}\\
&= \frac{N(N-1)(N-2)\cdots(N-n+1)}{n!}\left(\frac{\lambda}{N}\right)^n\left(1 - \frac{\lambda}{N}\right)^{N}\left(1 - \frac{\lambda}{N}\right)^{-n}\\
&= 1\left(1 - \frac{1}{N}\right)\left(1 - \frac{2}{N}\right)\cdots\left(1 - \frac{N-n+1}{N}\right)\frac{\lambda^n}{n!}\left(1 - \frac{\lambda}{N}\right)^{N}\left(1 - \frac{\lambda}{N}\right)^{-n}
\end{aligned}
$$

ここで、$N\to \infty$をとると$N$以外は固定された値なので

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



#### (2) ベルヌーイ試行と二進数: [H31東京大学大学院工学系研究科入学試験](https://www.t.u-tokyo.ac.jp/shared/admission/data/H31_suugaku_J)

- $X_1, X_2, \cdots, X_n$は独立
- $X_k \: (k = 1, 2, \cdots, n)$は、それぞれ確率 $p$ で値1をとり、確率 $1-p$ で値0を取る

確率変数 $X_1, X_2, \cdots, X_n$ を順に並べて作った列 $X_n\cdots X_2X_1$ を $n$ 桁の2進数とみなすことで得られる整数を $Y$とします。たとえば、 $n=4$とし、$X_4X_3X_2X_1$ が $0101$ ならば $Y = 5$. このときの $Y$ の期待値と分散を求めます

> 期待値の計算

確率変数 $Y$ の定義域は $0 $から $2^n-1$.　これを踏まえると

$$
\begin{aligned}
\mathbb E[Y] &= \mathbb E\left[\sum^n_{i=1}2^{i-1}X_i\right]\\
&= \sum^n_{i=1}2^{i-1} \mathbb E[X_i] \: \because \text{ 独立性}\\
&= p \sum^n_{i=1}2^{i-1}\\
&= p \sum^{n-1}_{i=0}2^{i}\\
&= (2^n - 1)p
\end{aligned}
$$

> 分散の計算

$$
\begin{aligned}
V(Y) &= V\left(\sum^n_{i=1}2^{i-1}X_i\right)\\
&= p(1-p)\sum^n_{i=1}4^{i-1}\\
&= \frac{4^n - 1}{3}p(1-p)
\end{aligned}
$$

> Pythonで確認

ソースコードは[こちら](https://colab.research.google.com/drive/1Fj1OPTD-kinR5SMPMb0zbj1sR2xUeK4P?usp=sharing)参考

```python
import random
import matplotlib.pyplot as plt
import numpy as np

random.seed(42)

### Data generation
n_digits = 8
n_simulation = 100000
p = 0.5
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
```

Then,

```
Dataから得られる平均値: 127.220, 理論から導かれる期待値: 127.500
Dataから得られる分散: 5441.694, 理論から導かれる分散: 5461.250
```

#### (3) マルコフ過程 一橋1992年

「一つのサイコロを振り，出た目が4以下ならばAに1点を与え，5以上ならばBに1点を与える」 という試行を繰り返す．

1. AとBの得点差が2になったところでやめて得点の多い方を勝ちとする． $n$ 回以下の 試行でAが勝つ確率 $p_n$ を求めよ．
2. Aの得点がBの得点より2多くなるか，またはBの得点がAの得点より1多くなったところで やめて，得点の多い方を勝ちとする． $n$ 回以下の試行でAが勝つ確率 $q_n$ を求めよ．

> 解答(3-1)

$(1, 0), (0, 1)$がそれぞれ「AがBに対して1点リード」と「BがAに対して1点リード」している状況を表しているとする.

問題文より、遷移確率行列は以下

|$t$期の状態 \ $t+1$期の状態|(2,0)|(1, 0)|(0, 0)|(0,1)|(0, 2)|
|---|---|---|---|---|---|
|(2, 0)|1|0|0|0|0|
|(1, 0)|2/3|0|1/3|0|0|
|(0, 0)|0|2/3|0|1/3|0|
|(0, 1)|0|0|2/3|0|1/3|
|(0, 2)|0|0|0|0|1|

なお、ゲーム開始時$t=0$は$(0,0)$とする. 得点差が $\pm1$ の間をくり返し、最後にAが2連勝するしか得点差が2になることはないことに注意すると、奇数回目の得点差は奇数なので、得点差が2になるのは偶数回目しかないことがわかる.

従って、$2k$回目にAが勝つ確率は

$$
r_{2k}= \left(\dfrac{2}{3}\cdot\dfrac{1}{3}+ \dfrac{1}{3}\cdot\dfrac{2}{3}\right)^{k-1}\times\left(\dfrac{2}{3}\right)^2= \left(\dfrac{4}{9}\right)^k
$$

したがって $n$ が偶数なら

$$
p_n =\sum_{k=1}^{n/2}\left(\dfrac{4}{9}\right)^k = \dfrac{4}{5}\left\{1-\left(\dfrac{2}{3}\right)^n\right\}
$$

$n$ が奇数なら 

$$
p_n = p_{n-1}=\dfrac{4}{5}\left\{1-\left(\dfrac{2}{3}\right)^{n-1}\right\}
$$

> 解答(3-2)

得点差が2になるのは偶数回目しかないこと、及びはじめに4以下を出さないとAさんはゲームに負けてしまうので

$2k$回目に勝つ確率は

$$
\begin{aligned}
r_{2k} &= \frac{2}{3}\left(\frac{1}{3}\frac{2}{3}\right)^{\frac{n}{2}-1}\frac{2}{3}\\
&= 2\left(\frac{2}{9}\right)^{k}
\end{aligned}
$$

従って、$n$が偶数ならば

$$
\begin{aligned}
p_n &=\sum_{k=1}^{n/2}2\left(\frac{2}{9}\right)^{k}\\
&= \frac{4}{7}\left\{1 - \left(\frac{2}{9}\right)^{n/2}\right\}
\end{aligned}
$$

$n$が奇数ならば

$$
p_n = \frac{4}{7}\left\{1 - \left(\frac{2}{9}\right)^{(n-1)/2}\right\}
$$



## 2. 二項分布と条件付き期待値

パラメータ $n, \theta$ の二項分布 $\mathbf{B}(n, \theta)$ に従う確率変数 を$X$とする.

$X \geq 1$の条件の下での $X$ の条件付き確率関数は

$$
\begin{align*}
P(X = x|X\geq 1) &= \frac{P(X = x, X \geq 1)}{P(X \geq 1)}\\
&= \frac{P(X = x)}{P(X \geq 1)} \: \text{ where } (x = 1, 2, \cdots, n) \tag{2.1}
\end{align*}
$$

(2.1)の分子は 

$$
\:_nC_x \theta^{x}(1 - \theta)^{n-x}
$$

一方、(2.1)の分母は

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

$X$の条件付き期待値は

$$
\begin{aligned}
\mathbb E[X\mid X\geq 1] &= \frac{1}{1 - (1 - \theta)^n} \sum_{k = 1}^n k\:_nC_x \theta^{x}(1 - \theta)^{n-x}\\
&= \frac{n\theta}{1 - (1 - \theta)^n}
\end{aligned}
$$

同様に

$$
\begin{aligned}
\mathbb E[X^2\mid X\geq 1] &= \frac{1}{1 - (1 - \theta)^n} \sum_{k = 1}^n k^2\:_nC_x \theta^{x}(1 - \theta)^{n-x}\\
&= \frac{n\theta(1 - \theta) + n^2\theta^2}{1 - (1 - \theta)^n}
\end{aligned}
$$

$$
\therefore \: V(X|X\geq 1) = \frac{n\theta(1 - \theta)}{1 - (1 - \theta)^n} - \frac{n^2\theta^2(1 - \theta)}{\{1 - (1 - \theta)^n\}^2}
$$

### 最尤推定値の計算法

$X \geq 1$の条件の下で,独立な $m$個の観測値 $y_1, \cdots, y_m$を得たとし、その平均を $\bar y = \sum_{i=1}^m y_i/m$ とします.このとき、パラメータ $\theta$ を最尤法で推定したいとします.

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

$l(\theta; \mathbf{y})$を$\theta$で偏微分すると,

$$
\frac{\partial l(\theta; \mathbf{y})}{\partial \theta} = \frac{m\bar y}{\theta} - \frac{m(n - \bar y)}{1 - \theta} - \frac{mn(1 - \theta)^{n-1}}{1 - (1 - \theta)^n}
$$

これを $0$ とおいて整理すると、

$$
n\hat\theta = \bar y \{1 - (1 - \hat\theta)^n\} \tag{2.2}
$$


この推定式はモーメント法に基づく推定値であることもわかる. なお、式(2.2)から$\hat\theta$は陽にはもとめられないので、実務では反復計算で計算する. 一例として, $\hat\theta^{(0)} = \bar y /n$のような適当な初期値を設定し、

$$
\hat\theta^{(t+1)} = \frac{\bar y\{1 - (1 - \hat\theta^{(t)})^n\}}{n}
$$

という反復スキームで求める. 


### 例題

確率変数

$$
x_i {\stackrel{\text{i.i.d}}{\sim}}  \mathbf{B}(N, \theta), \: (i = 1, \cdots, M)
$$

を考えます. データとして観測できる確率変数 $y_i$ は以下のように定義される:

$$
y_i = \begin{cases}
x_i & \:\text{ if } x_i \geq 3\\
0 & \:\text{otherwise}
\end{cases}
$$

このとき、$\theta$を推定せよ.

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
\mathbb E[x_i|x_i\geq 3] &= \frac{\sum_{k=3}^n k\:_nC_k \theta^k(1 - \theta)^{n-k}}{1 - \frac{(1 - \theta)^{n-2}}{2}\{(n-1)(n-2)\theta^2 + 2\theta(n-2)+2\}}\\[8pt]
&= \frac{n\theta - n\theta(1-\theta)^{n-1}-n(n-1)\theta^2(1 - \theta)^{n-2}}{1 - \frac{(1 - \theta)^{n-2}}{2}\{(n-1)(n-2)\theta^2 + 2\theta(n-2)+2\}}
\end{aligned}
$$

> Dataと推定

- $N = 10$
- $M = 1000$
- $\theta = 0.3$

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

Pythonで数値計算で解いてみると

```python
def binary_search(func, y_min, y_max, value, n, eps):
    left = y_min             # left seach area
    right = y_max            # right seach area
    while left <= right:
        mid = (left + right) / 2            # calculate the mid
        if abs(func(mid, n) - value) < eps:
            # return the numerical solution
            return mid
        elif func(mid, n) < value:
            # set the left at the mid beacuse the objective function is a strictly increasing function
            left = mid
        else:
            # set the right at the mid
            right = mid 
    return None            # cannot compute

def objective_function(X, N):
    numerator = N*X - N*X * (1 - X)**(N-1) - (N-1)*N * X**2 * (1 - X)**(N-2)
    denominator = 1 - (((1 - X)**(N-2))/2 )* ((N-1)*(N-2) * X**2 + 2*X*(N - 2) +2)

    return numerator/denominator

conditional_data = data[data > 2]
bar_y = np.mean(conditional_data)

print(binary_search(func=objective_function, y_min=0, y_max =1, value = bar_y, n = n, eps = 1e-8))
```

$\hat\theta = 0.29651909694075584$を得る. なお、上記を[Wolfram Alpha](https://ja.wolframalpha.com/input/?i=3.89%3D+%5Cfrac%7B10x+-+10x%281-x%29%5E%7B9%7D-90x%5E2%281+-+x%29%5E%7B8%7D%7D%7B1+-+%5Cfrac%7B%281+-+x%29%5E%7B8%7D%7D%7B2%7D%2872x%5E2+%2B+16x%2B2%29%7D)をもちいて解くと, $\hat\theta = 0.296243$. 

## References

- [現代数理統計学の基礎, 久保川 達也著](https://www.kyoritsu-pub.co.jp/bookdetail/9784320111660)
- [高校数学の美しい物語 > 二項分布の平均と分散の二通りの証明](https://manabitimes.jp/math/913)
- [高校数学の美しい物語 > 多項分布の意味と平均，分散，共分散などの計算](https://manabitimes.jp/math/1282)
- [死神とのコイントスゲーム](https://ryonakagami.github.io/2020/10/22/CoinFlip-Programming/)
- [NIST Engineering Statistics Handbbok](https://www.itl.nist.gov/div898/handbook/prc/section2/prc241.htm)
