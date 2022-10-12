---
layout: post
title: "カイ二乗適合度検定とContingency Tableにおける独立性検定"
subtitle: "数理統計：適合度検定 1/N"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-03
purpose: 
tags:

- 統計
- 統計検定
---

||概要|
|---|---|
|目的|カイ二乗適合度検定とContingency Tableにおける独立性検定の考え方を学ぶ|
|分類|数理統計|
|言語|Python, R|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [カイ二乗分布の定義](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E5%AE%9A%E7%BE%A9)
  - [カイ二乗分布の成り立ち](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E6%88%90%E3%82%8A%E7%AB%8B%E3%81%A1)
    - [自由度1の場合の証明](#%E8%87%AA%E7%94%B1%E5%BA%A61%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%AE%E8%A8%BC%E6%98%8E)
    - [自由度Nの場合の証明](#%E8%87%AA%E7%94%B1%E5%BA%A6n%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [モード, 平均, 分散の導出](#%E3%83%A2%E3%83%BC%E3%83%89-%E5%B9%B3%E5%9D%87-%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Appendix](#appendix)
  - [ガンマ関数の公式](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E5%85%AC%E5%BC%8F)
  - [自由度1のカイ二乗分布の確率密度関数の導出：別解](#%E8%87%AA%E7%94%B1%E5%BA%A61%E3%81%AE%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA%E5%88%A5%E8%A7%A3)
  - [カイ二乗分布の積率母関数の導出](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E7%A9%8D%E7%8E%87%E6%AF%8D%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Refereneces](#refereneces)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## カイ二乗分布の定義

$$n$$を自然数とした時,確率変数 $$X$$ の確率密度関数が

$$
f_X(x) = \frac{1}{\Gamma(n/2)}\left(\frac{1}{2}\right)^{n/2}x^{n/2-1}\exp(-x/2), \  \ x>0
$$

で与えられる時,自由度$$n$$のカイ二乗分布といい, $$\chi^2_n$$で表す.

---|---
特性関数|$(1 - 2it)^{-n/2}$
積率母関数|$(1 - 2t)^{-n/2}$
期待値|$$n$$
分散|$$2n$$


### カイ二乗分布の成り立ち

確率変数 $Z_i \sim N(0, 1), \  \ i \in \{1,\cdots, N\}$がi.i.d条件を満たす時,

$$
\chi^2(N) = \sum_{i}^N Z_i^2
$$

と定義すると,$$\chi^2(N)$$は自由度 $$N$$のカイ二乗分布に従う.

#### 自由度1の場合の証明

$f(z)$を標準正規分布の確率密度関数とし, $$f^*$$を$f(x)$の原始関数の1つとする. $$Y = Z^2$$が従う分布の確率密度関数$g(y)$は以下のように導出される:

<div class="math display" style="overflow: auto">
$$
\begin{align*}
g(y) &= \frac{d}{dy}Pr(Z^2 \leq y)\\
     &= \frac{d}{dy}Pr(-\sqrt{y} \geq Z \leq \sqrt{y})\\
     &= \frac{d}{dy}\int^{\sqrt{y}}_{-\sqrt{y}}f(x)dx\\
     &= \frac{d}{dy}\{f^*(\sqrt{y}) - f^*(-\sqrt{y})\}\\
     &= \frac{1}{2\sqrt{y}}\frac{1}{\sqrt{2\pi}}\exp(-y/2) + \frac{1}{2\sqrt{y}}\frac{1}{\sqrt{2\pi}}\exp(-y/2)\\
     &= \frac{1}{\sqrt{2\pi}}y^{-1/2}\exp(-y/2)\\
     &= \frac{1}{\Gamma(1/2)}\left(\frac{1}{2}\right)^{1/2}y^{1/2-1}\exp(-y/2)
\end{align*}
$$
</div>

となり,$$Y$$が自由度１のカイ二乗分布に従うことがわかる.

> コラム:変数変換Tips

上の式展開を見ればわかるが$$X$$の確率密度関数を$f(x)$としたとき, $$Y = X^2$$という変数変換をした時の確率密度関数は

<div class="math display" style="overflow: auto">
$$
g(y) = \begin{cases}
\frac{1}{2\sqrt{y}}\left[f(-\sqrt{y})+f(\sqrt{y})\right] & \  \ (y\geq 0)\\
0 & \  \ (y < 0)
\end{cases}
$$
</div>



#### 自由度Nの場合の証明

カイ二乗分布の自由度$N$は自然数, 自由度$1$の場合の証明は上記で完了しているので, 自由度 $N-1$の場合のとき成立することを仮定して帰納法を用いて証明すれば十分です.

まず,証明したい内容は以下:

$$Y = \sum_{i}^{N-1}Z_i^2$$が自由度 $$N-1$$のカイ二乗分布に従うとき, $$Y + Z_N^2$$が自由度 $$N$$のカイ二乗分布に従う, つまり

$$
f_N(x) = \int^x_0f_{N-1}(t)f_1(x-t)dt
$$

ここで$$f_{n-1}, f_1$$はそれぞれ自由度 $$N-1, 1$$のカイ自乗分布の確率密度関数なので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
f_N(x) &= \int^x_0f_{N-1}(t)f_1(x-t)dt\\[8pt]
       &= \frac{\exp(-x/2)}{\Gamma((N-1)/2)\Gamma(1/2)}\left(\frac{1}{2}\right)^{N/2}\int^x_0t^{\frac{N-3}{2}}(x-t)^{-\frac{1}{2}}dt
\end{align*}
$$
</div>

ここで $u = t/x$と変数変換すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
f_N(x) = \frac{\exp(-x/2)x^{N/2-1}}{\Gamma((N-1)/2)\Gamma(1/2)}\left(\frac{1}{2}\right)^{N/2}\int^1_0u^{(N-3)/2}(1-u)^{-1/2}du
\end{align*}
$$
</div>

$$\int^1_0u^{(N-3)/2}(1-u)^{-1/2}du$$に対してベータ関数の積分公式を用いると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int^1_0u^{(N-3)/2}(1-u)^{-1/2}du &= B\left(\frac{N-1}{2}, \frac{1}{2}\right)\\
&= \frac{\Gamma((N-1)/2)\Gamma(1/2)}{\Gamma(N/2)}
\end{align*}
$$
</div>

従って, $$f_N(x)$$は自由度 $$N$$のカイ二乗分布の確率密度関数と一致する.

### モード, 平均, 分散の導出

> モード

$$n\geq 3$$のときに限定して導出します.

カイ二乗分布の確率密度関数$$f_n(x)$$を$x$について微分すると

$$
f'_n(x) = -\frac{1}{2}Cx^{\frac{n}{2}-2}\exp(-\frac{x}{2})\{x - (n-2)\}, \  \ C\equiv \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}
$$

従って, 

$$
f'_n(n-2)=0
$$

よって, $x=n-2$のとき最大値を取ることがわかります.

> 平均

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X] &= \int^\infty_0 xf_n(x)dx\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\int^{\infty}_0 x^{\frac{n}{2}}\exp\left(\righ-\frac{x}{2})\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}+1\right)}{\left(\frac{1}{2}\right)^{\frac{n}{2}+1}}\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}\right)\frac{n}{2}}{\left(\frac{1}{2}\right)^{\frac{n}{2}+1}}\\
             &= n
\end{align*}
$$
</div>

> 分散

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \int^\infty_0 x^2f_n(x)dx\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\int^{\infty}_0 x^{\frac{n}{2}+1}\exp\left(\righ-\frac{x}{2})\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}+2\right)}{\left(\frac{1}{2}\right)^{\frac{n}{2}+2}}\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}\right)\frac{n}{2}\left(\frac{n}{2}+1\right)}{\left(\frac{1}{2}\right)^{\frac{n}{2}+1}}\\
             &= n(n+2)
\end{align*}
$$
</div>

従って, 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
V(x) &= n(n+2) - n^2\\
     &= 2n
\end{align*}
$$
</div>






## Appendix
### ガンマ関数の公式

$$
\int^\infty_0 x^r \exp(-ax)dx = \frac{\Gamma(r+1)}{a^{r+1}}
$$

### 自由度1のカイ二乗分布の確率密度関数の導出：別解

$Z\sim N(0,1)$に従うとき, $$X = Z^2$$の変数変換を考える. $z > 0$のとき

$$
\frac{dz}{dx} = \frac{1}{2\sqrt{x}}
$$

であり,かつ$$Z$$の分布は原点を中心に左右対称であることに注意すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
f(x) &= 2\phi(\sqrt{x})\frac{dz}{dx}\\
     &= \frac{2}{\sqrt{2\pi}}\exp\left(-\frac{x}{2}\right)\frac{1}{2\sqrt{x}}\\
     &= \frac{1}{\sqrt{2\pi}\sqrt{x}}\exp\left(-\frac{x}{2}\right)\\
     &= \frac{1}{\sqrt{2}\Gamma\left(\frac{1}{2}\right)}x^{\frac{1}{2}-1}\exp\left(-\frac{x}{2}\right)
\end{align*}
$$
</div>

となり,$$X$$が自由度１のカイ二乗分布に従うことがわかる.

### カイ二乗分布の積率母関数の導出

<div class="math display" style="overflow: auto">
$$
\begin{align*}
M_{X}(t)&=E[\exp(tX)]\\
        &=\int_{ 0 }^{ \infty }\exp(tx)f(x)dx\\
        &=\int_{ 0 }^{ \infty }\exp(tx)\frac{x^{(\frac{N}{2} - 1)}\exp(-x/2)}{\Gamma\left(\frac{N}{2}\right)2^{\frac{N}{2}}}dx\\
        &=\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp(-x/2 + tx)}{\Gamma\left(\frac{N}{2}\right)2^{\frac{N}{2}}}dx\\
        &=\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)2^{\frac{N}{2}}}dx\\
        &=\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)(1-2t)^{\frac{N}{2}}\left(\frac{2}{1-2t}\right)^{\frac{N}{2}}}dx\\
        &=(1-2t)^{-\frac{N}{2}}\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)\left(\frac{2}{1-2t}\right)^{\frac{N}{2}}}dx
\end{align*}
$$
</div>



ここで以下のように変数変換する:

$$
\theta \equiv \frac{2}{1-2t}
$$

すると, 積分箇所がscale parameter $\theta$のカイ二乗分布関数に以下のように書き換えられるので合計1となるので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
(1-2t)^{-\frac{N}{2}}\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)\left(\frac{2}{1-2t}\right)^{\frac{N}{2}}}dx &= (1-2t)^{-\frac{N}{2}}\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2}-1)}\exp\left(-\frac{x}{\theta}\right)}{\Gamma(\frac{N}{2})\theta^{\frac{N}{2}}}dx\\
&=(1-2t)^{-\frac{N}{2}}
\end{align*}
$$
</div>


## Refereneces
### オンラインマテリアル

- [高校数学の美しい物語 > 正規分布の二乗和がカイ二乗分布に従うことの証明](https://manabitimes.jp/math/1083)
