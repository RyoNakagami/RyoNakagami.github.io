---
layout: post
title: "変数変換を用いて異なる分布間の関係性を理解する"
subtitle: "数理統計：変数変換 2/n"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- 統計検定
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

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 変数変換を用いたt分布密度関数の導出](#1-%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B%E3%82%92%E7%94%A8%E3%81%84%E3%81%9Ft%E5%88%86%E5%B8%83%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [t分布の定義](#t%E5%88%86%E5%B8%83%E3%81%AE%E5%AE%9A%E7%BE%A9)
  - [t分布の確率密度関数の導出](#t%E5%88%86%E5%B8%83%E3%81%AE%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [標本分布とt分布](#%E6%A8%99%E6%9C%AC%E5%88%86%E5%B8%83%E3%81%A8t%E5%88%86%E5%B8%83)
  - [t分布と正規分布](#t%E5%88%86%E5%B8%83%E3%81%A8%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83)
- [2. 標準正規分布の比とコーシー分布](#2-%E6%A8%99%E6%BA%96%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AE%E6%AF%94%E3%81%A8%E3%82%B3%E3%83%BC%E3%82%B7%E3%83%BC%E5%88%86%E5%B8%83)
  - [コーシー分布の定義](#%E3%82%B3%E3%83%BC%E3%82%B7%E3%83%BC%E5%88%86%E5%B8%83%E3%81%AE%E5%AE%9A%E7%BE%A9)
    - [練習問題：2019年統計検定１級数理統計問４改題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C2019%E5%B9%B4%E7%B5%B1%E8%A8%88%E6%A4%9C%E5%AE%9A%EF%BC%91%E7%B4%9A%E6%95%B0%E7%90%86%E7%B5%B1%E8%A8%88%E5%95%8F%EF%BC%94%E6%94%B9%E9%A1%8C)
  - [一様分布とコーシー分布](#%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%A8%E3%82%B3%E3%83%BC%E3%82%B7%E3%83%BC%E5%88%86%E5%B8%83)
  - [標準正規分布の比とコーシー分布](#%E6%A8%99%E6%BA%96%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AE%E6%AF%94%E3%81%A8%E3%82%B3%E3%83%BC%E3%82%B7%E3%83%BC%E5%88%86%E5%B8%83)
  - [コーシー分布に従う確率変数の逆数の分布](#%E3%82%B3%E3%83%BC%E3%82%B7%E3%83%BC%E5%88%86%E5%B8%83%E3%81%AB%E5%BE%93%E3%81%86%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E9%80%86%E6%95%B0%E3%81%AE%E5%88%86%E5%B8%83)
- [3. 対数正規分布](#3-%E5%AF%BE%E6%95%B0%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83)
  - [確率密度関数の導出](#%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [対数正規分布の特性値の導出](#%E5%AF%BE%E6%95%B0%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AE%E7%89%B9%E6%80%A7%E5%80%A4%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Appendix: 最強力検定](#appendix-%E6%9C%80%E5%BC%B7%E5%8A%9B%E6%A4%9C%E5%AE%9A)
  - [定義：検出力関数](#%E5%AE%9A%E7%BE%A9%E6%A4%9C%E5%87%BA%E5%8A%9B%E9%96%A2%E6%95%B0)
  - [定義：検定のレベルとサイズ](#%E5%AE%9A%E7%BE%A9%E6%A4%9C%E5%AE%9A%E3%81%AE%E3%83%AC%E3%83%99%E3%83%AB%E3%81%A8%E3%82%B5%E3%82%A4%E3%82%BA)
  - [定義：検出力関数がより強力](#%E5%AE%9A%E7%BE%A9%E6%A4%9C%E5%87%BA%E5%8A%9B%E9%96%A2%E6%95%B0%E3%81%8C%E3%82%88%E3%82%8A%E5%BC%B7%E5%8A%9B)
  - [定義：一様最強力検定](#%E5%AE%9A%E7%BE%A9%E4%B8%80%E6%A7%98%E6%9C%80%E5%BC%B7%E5%8A%9B%E6%A4%9C%E5%AE%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->



## 1. 変数変換を用いたt分布密度関数の導出
### t分布の定義

$Z$と$U$を独立な確率変数とし、$Z\sim N(0, 1)$, $U\sim \chi^2_m$としたとき

$$
T = \frac{Z}{\sqrt{U/m}}
$$

は自由度$m$のt分布に従うといいます.

**t分布の特性値**

自由度$m$のt分布について以下が成立します:

$$
\begin{align*}
f_X(x|m) &= \left(\frac{\Gamma((m+1)/2)}{\sqrt{m\pi} \Gamma(m/2)}\right)\left(1 + \frac{x^2}{m}\right)^{-(m+1)/2}\\
&= \frac{1}{\sqrt{m}B\left(\frac{m}{2}, \frac{1}{2}\right)}\left(1 + \frac{x^2}{m}\right)^{-(m+1)/2}
\end{align*}
$$

$$
\begin{align*}
E[X] &= 0\\
V(X) &= \frac{n}{n-2}
\end{align*}
$$

### t分布の確率密度関数の導出

$$
\int^{\infty}_0x^p\exp(-ax)dx = \frac{\Gamma(p+1)}{a^{p+1}}
$$

以上の公式を念頭にt分布の確率密度関数の導出をします. 


まず、$X$と$Y$を独立な確率変数とし、$X\sim N(0, 1)$, $Y\sim \chi^2_n$としたとき、それぞれの密度関数は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
f(x)&= \frac{1}{\sqrt{2\pi}}\exp \left( -\frac{x^2}{2}\right)\\
f_n(y)&= \frac{1}{2^{n/2}\Gamma(n/2)}y^{n/2 - 1}\exp \left(-\frac{y}{2}\right)
\end{align*}
$$
</div>

次に変数変換を考えます(see [Ryo's Tech Blog > 変数変換のルールをまとめる](https://ryonakagami.github.io/2021/04/21/variable-transformation/)).

$$
\begin{align*}
t&= \frac{x}{\sqrt{y/n}}\\
u&= y
\end{align*}
$$

以上のように変数変換を設定すると

$$
\begin{align*}
x&= t\sqrt{u/n}\\
y&= u
\end{align*}
$$

このときのヤコビアンは

<div class="math display" style="overflow: auto">
$$
\begin{align*}
J &= \left|\begin{array}{cc}\sqrt\frac{n}{u}&\frac{t}{2\sqrt{nu}}\\0&1\end{array}\right|\\
&= \sqrt{\frac{u}{n}}
\end{align*}
$$
</div>

このときの $(T, U)$の同時密度関数は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
g(t, u)&= \frac{1}{\sqrt{2\pi}}\exp \left(-\frac{1}{2}\frac{t^2u}{n}\right)\frac{1}{2^{n/2}\Gamma(n/2)}u^{n/2 - 1}\exp \left(-\frac{u}{2}\right)\sqrt{\frac{u}{n}}\\
&= \frac{1}{\sqrt{2\pi n}}\frac{1}{2^{n/2}\Gamma(n/2)}u^{\frac{n-1}{2}}\exp \left[-\frac{u}{2}\left(1 + \frac{t^2}{n}\right)\right]
\end{align*}
$$
</div>

Tの密度関数を$h(t)$とすれば

<div class="math display" style="overflow: auto">
$$
\begin{align*}
h(t) &= \int^\infty_0g(t, u)du\\
&= \frac{1}{\sqrt{2\pi n}}\frac{1}{2^{n/2}\Gamma(n/2)}\int^\infty_0u^{\frac{n-1}{2}}\exp \left[-\frac{u}{2}\left(1 + \frac{t^2}{n}\right)\right]du\\
&= \frac{1}{\sqrt{2\pi n}}\frac{1}{2^{n/2}\Gamma(n/2)} \frac{\Gamma((n+1)/2)}{\left\{\frac{1}{2}\left(1 + \frac{t^2}{n}\right)\right\}^{(n+1)/2}}\\
&= \left(\frac{\Gamma((n+1)/2)}{\sqrt{n\pi} \Gamma(n/2)}\right)\left(1 + \frac{t^2}{n}\right)^{-(n+1)/2}\\
&= \left(\frac{\Gamma((n+1)/2)}{\sqrt{n}\Gamma(1/2) \Gamma(n/2)}\right)\left(1 + \frac{t^2}{n}\right)^{-(n+1)/2}\\
&= \frac{1}{\sqrt{n}Beta \left(\frac{n}{2}, \frac{1}{2}\right)}\left(1 + \frac{t^2}{n}\right)^{-(n+1)/2}
\end{align*}
$$
</div>

従って、自由度nのt分布の密度関数が導かれる.

### 標本分布とt分布

$X_1, \cdots, X_n$を$N(\mu, \sigma^2)$からの無作為標本とします. このとき、以下の確率変数$T$が自由度$n-1$のt分布に従うことを示します

$$
T = \frac{\bar X - \mu}{\sqrt{\hat \sigma^2/n}}
$$

ただし、 $\bar X$ は標本平均, $\hat\sigma^2 = \frac{1}{n-1}\sum (X_i - \bar X)^2$とします.

これはヘルマート行列を用いて証明することができます. ヘルマート行列を以下のように定義します

<div class="math display" style="overflow: auto">
$$
\mathbf H = \left[\begin{array}{ccccc}
1/\sqrt{n} & 1/\sqrt{n} & 1/\sqrt{n} &\cdots & 1/\sqrt{n}\\
-1/\sqrt{2} & 1/\sqrt{2} & 0 & \cdots & 0\\
-1/\sqrt{2\cdot 3} & -1/\sqrt{2\cdot 3} & 2/\sqrt{2\cdot 3} & \cdots & 0\\
\vdots &\vdots &\vdots &\vdots &\vdots\\
-1/\sqrt{n(n-1)} &-1/\sqrt{n(n-1)} &-1/\sqrt{n(n-1)} &\cdots & (n-1)/\sqrt{n(n-1)}
\end{array}\right]
$$
</div>

これは直交行列で、$\mathbf H^T \mathbf H = \mathbf H\mathbf H^T = \mathbf I_N$また $\|\mathbf H\| = 1$を満たします. 

次に、$\mathbf Y = \mathbf H\mathbf Z$という変数変換をします. なお, $\mathbf Z \equiv (\mathbf X- \mu)/\sigma$とします.

このとき、

<div class="math display" style="overflow: auto">
$$
\begin{align*}
f_Y(\mathbf y) &= \frac{1}{(2\pi)^{n/2}}\exp(-(\mathbf H^{-1}\mathbf y)^T\mathbf H^{-1}\mathbf y/2)\\
&=\frac{1}{(2\pi)^{n/2}}\exp(-\mathbf y^T(\mathbf H^{-1})^T\mathbf H^{-1}\mathbf y/2)\\
&=\frac{1}{(2\pi)^{n/2}}\exp(-\mathbf y^T(\mathbf H\mathbf H^T)^{-1}\mathbf y/2)\\
&=\frac{1}{(2\pi)^{n/2}}\exp(-(\mathbf y^T\mathbf y/2))
\end{align*}
$$
</div>

従って、

$$
Y\sim N(\mathbf 0, \mathbf I_n)
$$

となります. $\mathbf H$の作りより

$$
Y_1 = \sqrt{n}\bar Z
$$

となることに注意すると

$$
\begin{align*}
\sum (Z_i - \bar Z)^2 &= \mathbf Z^T\mathbf Z - n\bar Z^2\\
&= \mathbf Y^T\mathbf Y - Y_1^2\\
&= Y_2^2 + Y_3^2 + \cdots + Y_n^2
\end{align*}
$$

従って、それぞれ独立に

$$
\begin{align*}
\sqrt{n}\bar Z &\sim N(0, 1)\\
\sum (Z_i - \bar Z)^2&\sim \chi^2(n-1)
\end{align*}
$$

よって、

$$
\begin{align*}
T&= \frac{\sqrt{n}\bar Z}{\sqrt{\sum (Z_i - \bar Z)^2/n-1}}\\
&= \frac{\sqrt n (\bar X - \mu)}{\sqrt{\sum (X_i - \bar X)^2/(n-1)}}
\end{align*}
$$

以上より題意は示された.

### t分布と正規分布

自由度$m$のT分布に従う確率変数$t_m$について、$m \to \infty$とすると、$t_m$は標準正規分布に従うことが知られています. $t_m$の確率密度関数は以下です. 

$$
\begin{align*}
f(t|m) &= \left(\frac{\Gamma((m+1)/2)}{\sqrt{m\pi \Gamma(m/2)}}\right)\left(1 + \frac{t^2}{m}\right)^{-(m+1)/2}
\end{align*}
$$


> 証明

$k=m/2$とおくと

<div class="math display" style="overflow: auto">
$$
\begin{align*}
f(t|2k) = \left(\frac{\Gamma(k+1/2)}{\sqrt{2k\pi} \Gamma(k)}\right)\left(1 + \frac{t^2}{2k}\right)^{-k-1/2}\quad\quad\tag{1.1}
\end{align*}
$$
</div>

このとき、

$$
\lim_{k\to\infty}\left(1 + \frac{t^2}{2k}\right)^{-k-1/2} = \exp\left(-\frac{t^2}{2}\right)\quad\quad\tag{1.2}
$$

また、スターリングの公式よりkが十分大きい時

$$
\Gamma(k+a) = \{\sqrt{2\pi}+1\}k^{k+a-1/2}\exp(-k)\quad\quad\tag{1.3}
$$

従って、

$$
\lim_{k\to\infty}\left(\frac{\Gamma(k+1/2)}{\sqrt{2k\pi} \Gamma(k)}\right) = \frac{1}{\sqrt{2\pi}}\quad\quad\tag{1.4}
$$


(1.1), (1.2), (1.4)より

$$
\lim_{k\to\infty}\left(\frac{\Gamma(k+1/2)}{\sqrt{2k\pi} \Gamma(k)}\right)\left(1 + \frac{t^2}{2k}\right)^{-k-1/2} = \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{t^2}{2}\right)
$$

標準正規分布に収束することがわかる.

## 2. 標準正規分布の比とコーシー分布
### コーシー分布の定義

確率密度関数が

$$
f(x|\mu) = \frac{1}{\pi}\frac{1}{1 + (x - \mu)^2}, \  \ -\infty <  x < \infty
$$

で与えられる時、これを位置母数$\mu$をもつコーシー分布という. コーシー分布は裾の厚い分布で、平均, 分散は存在しない.

> コーシー分布の累積分布関数

$$
F(x|\mu) = \frac{1}{\pi}\arctan(x - \mu) + \frac{1}{2}
$$


> コーシー分布の特性関数

$$
\exp(\mu i - |x|)
$$


#### 練習問題：2019年統計検定１級数理統計問４改題

位置パラメータ$\theta$を持つコーシー分布を考える. このときの確率密度関数は

$$
f_\theta(x) = \frac{1}{\pi(1 + (x - \theta)^2)}
$$

この分布から大きさ1の標本$X$に基づき、パラメータースペースは$\theta\in\{0, 1\}$と仮定し

- $H_0$: $\theta = 0$
- $H_0$: $\theta = 1$

に基づいて検定したいとします. この検定問題に対して、棄却域を以下のように定義します:

$$
R = \{x: x\in(1, 3)\}
$$

> (1) この検定問題のType I Error $\alpha$を求めよ

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\alpha &= P_0(1 < X < 3|\theta = 0)\\[8pt]
&= \int_1^3 \frac{1}{\pi(1 + x^2)}dx\\
&= \frac{1}{\pi}[\arctan (x)]^3_1\\
&\simeq 0.148
\end{align*}
$$
</div>

> (2) この検定の検出力を求めよ

<div class="math display" style="overflow: auto">
$$
\begin{align*}
1 - \beta &= P_1(1 < X < 3|\theta = 1)\\[8pt]
&= \int_1^3 \frac{1}{\pi(1 + (x-1)^2)}dx\\
&= \frac{1}{\pi}[\arctan (x-1)]^3_1\\
&= \frac{1}{\pi}(\arctan(2) - 0)\\
&\simeq 0.352
\end{align*}
$$
</div>


> (3) 尤度比 $\lambda(x) = f_1(x)/f_0(x)$を求めよ

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\lambda(x) &= \frac{f_1(x)}{f_0(x)}\\
&= \frac{1+x^2}{1 + (x-1)^2}\quad\quad\tag{2.1}
\end{align*}
$$
</div>

> (4) 有意水準$\alpha$において、今回の検定手法が最強力検定となることを示せ

(2.1)から$x = 1$と$x = 3$のとき $\lambda(1)=\lambda(3) = 2$とわかる. また$\lambda > 2$となる区間も

<div class="math display" style="overflow: auto">
$$
\begin{align*}
&\frac{1+x^2}{1 + (x-1)^2} > 2\\
&\Rightarrow (x - 3)(x - 1) < 0\\[8pt]
&\Rightarrow 1 < x < 3
\end{align*}
$$
</div>

よって、設問の棄却域は以下のように書き換えられる

$$
R = \{x|f_1(x) > 2 f_0(x)\}
$$

このときネイマン・ピアソンの補題を用いて今回の検定手法が最強力検定となることが示せる.

まず次のような検定関数を定義する

$$
\phi(X) = \begin{cases}1 & \text{ where } X \in R\\0 & \text{ where } X \notin R\end{cases}
$$

また有意水準$\alpha$の任意の検定の検定関数を

$$
\phi'(X) = \begin{cases}1 & \text{ where } X \in R'\\0 & \text{ where } X \notin R'\end{cases}
$$

このとき、どちらもサイズ$\alpha$の検定関数のため

$$
E[\phi(X)|\theta_0]=E[\phi'(X)|\theta_0] = \alpha
$$

を満たす. 従って、

$$
\int (\phi(x) - \phi'(x))f(x|\theta_0)dx = 0
$$

また検出力の差は$E[\phi(X)\|\theta_1] = \beta$であることに留意すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
E[\phi(x) - \phi'(x)|\theta_1] =& \int (\phi(x) - \phi'(x))f(x|\theta_1)dx\\
=& \int (\phi(x) - \phi'(x))(f(x|\theta_1) - 2 f(x|\theta_0))dx\\
=& \int_{x\in R} (\phi(x) - \phi'(x))(f(x|\theta_1) - 2 f(x|\theta_0))dx\\
& + \int_{x\in R^C} (\phi(x) - \phi'(x))(f(x|\theta_1) - 2 f(x|\theta_0))dx
\end{align*}
$$
</div>

- $x\in R$において、$\phi(x) - \phi'(x) \geq 0$
- $x\in R$において、$(f(x\|\theta_1) - 2 f(x\|\theta_0)) > 0$
- $x\in R^C$において、$\phi(x) - \phi'(x) \leq 0$
- $x\in R^C$において、$(f(x\|\theta_1) - 2 f(x\|\theta_0)) \leq 0$

以上より、

$$
E[\phi(x) - \phi'(x)|\theta_1] \geq 0
$$

以上より、今回の検定手法が最強力検定となることがわかる.

### 一様分布とコーシー分布

確率変数$\theta$ｆが$(-\pi/2, \pi/2)$区間の一様分布に従う時、$x = \tan x$はコーシー分布に従います.

> 証明

<div class="math display" style="overflow: auto">
$$
\begin{align*}
P(X \leq x) &= P(\tan(\theta) \leq x)\\[8pt]
&=P(\theta \leq \arctan x)\\[8pt]
&= \int^{\arctan x}_{-\frac{\pi}{2}}\frac{1}{\pi}dx\\
&= \frac{1}{\pi}\frac{1}{1 + x^2}
\end{align*}
$$
</div>

すなわち、コーシー分布となる.

### 標準正規分布の比とコーシー分布

$X, Y$ は独立で、ともに $N(0, 1)$ に従う時、

$$ 
\begin{aligned}
U &= \frac{X}{Y}\\
V &= Y
\end{aligned}
$$

密度関数 $h(u)$を求め、コーシー分布の確率密度関数と一致することを確かめます

> 証明

$X, Y$ は独立なので

$$
\begin{aligned}
f(x, y) &= \frac{1}{\sqrt{2\pi}}\exp\left(- \frac{x^2}{2}\right)\frac{1}{\sqrt{2\pi}}\exp\left(- \frac{y^2}{2}\right)\\
&= \frac{1}{2\pi}\exp\left(- \frac{x^2 + y^2}{2}\right)
\end{aligned}
$$

$x = uv, y = v$とおいて変数変換を行うと

$$
\begin{aligned}
g(u, v)&= f(x, y)\times \left|
\begin{array}{cc}
\frac{\partial x}{\partial u} & \frac{\partial x}{\partial v}\\
\frac{\partial y}{\partial u} & \frac{\partial y}{\partial v}
\end{array} \right|\\[8pt]
&= \frac{1}{2\pi}\exp\left(- \frac{x^2 + y^2}{2}\right)\times \left|
\begin{array}{cc}
v & u\\
0 & 1
\end{array} \right|\\[8pt]
&=\frac{1}{2\pi}\exp\left(- \frac{x^2 + y^2}{2}\right)|v|\\
&=\frac{1}{2\pi}\exp\left(- \frac{(uv)^2 + v^2}{2}\right)|v|
\end{aligned}
$$

周辺分布 $h(u)$は

$$
\begin{aligned}
h(u) &= \frac{1}{2\pi}\int^\infty_{-\infty}\exp\left(- \frac{(uv)^2 + v^2}{2}\right)|v|dv\\
&=\frac{2}{2\pi}\int^\infty_{0}\exp\left(- \frac{(uv)^2 + v^2}{2}\right)vdv\\
&=\frac{1}{\pi}\int^\infty_{0}\exp\left(- \frac{(u^2 + 1)v^2}{2}\right)vdv
\end{aligned}
$$

ここで $(u^2 + 1)v^2/2 = t$と変数変換すると

$$
\begin{aligned}
h(u) &= \frac{1}{\pi}\int^\infty_{0}\exp\left(- \frac{(u^2 + 1)v^2}{2}\right)vdv\\
&=\frac{1}{\pi}\int^\infty_{0}\exp(- t)\sqrt{\frac{2t}{1 + u^2}}\frac{dv}{dt}dt\\
&=\frac{1}{\pi}\int^\infty_{0}\exp(- t)\sqrt{\frac{2t}{1 + u^2}}\sqrt{\frac{2}{1+u^2}}\frac{1}{2\sqrt{t}}dt\\
&=\frac{1}{\pi(1+u^2)}\int^\infty_{0}\exp(-t)dt\\
&=\frac{1}{\pi(1+u^2)}
\end{aligned}
$$

コーシー分布の確率密度関数と一致することがわかる

PythonでのSimulation結果は[こちら](https://colab.research.google.com/drive/1b7XdjoqzPZKJefXjG1rT0cWp8hHDJZ28?usp=sharing)

### コーシー分布に従う確率変数の逆数の分布

確率変数$X$がコーシー分布に従う時、その逆数 $Y = 1/X$もコーシー分布に従います.

> 証明

<div class="math display" style="overflow: auto">
$$
\begin{align*}
f_Y(y)&= f_X(\frac{1}{y})\left(\frac{1}{y^2}\right)\\
&= \frac{1}{\pi\left[1 +\left(\frac{1}{y}\right)^2\right]}\left(\frac{1}{y^2}\right)\\
&= \frac{1}{\pi\left(1 + y^2\right)}
\end{align*}
$$
</div>

すなわち、コーシー分布となる.

また、標準正規分布の比がコーシー分布に従うことよりも導出可能です.


## 3. 対数正規分布

確率変数$X$を変数変換した$\log X$が正規分布に従うならば、もとの$X$は対数正規分布, log-normal distributionに従うといいます.

### 確率密度関数の導出

$\log X\sim N(\mu, \sigma^2)$のときの$X$の確率密度関数を求めます.

> 証明

$f(\cdot)$を$\log X$が従う確率密度関数とします. $\exp(\cdot)$は単調増加関数かつ逆関数は$\log(\cdot)$。また$X$の組み立て方から $x \leq 0$なので

$$
\begin{aligned}
P(X\leq x) &= P(\exp(\log X)\leq x)\\[8pt]
&= P(\log X \leq \log x)\\[8pt]
&= \int^{\log x}_{-\infty}f(x)d\log x
\end{aligned}
$$

両辺を$x$で微分すると, $X$の確率密度関数$g(\cdot)$は

$$
\begin{align*}
g(x) &= f(\log x)\frac{1}{x}\\
&= \frac{1}{\sqrt{2\pi}\sigma}\exp\left(-\frac{(\log x-\mu)^2}{2\sigma^2}\right)\frac{1}{x}
\end{align*}
$$

- PythonでのSimulation結果は[こちら](https://colab.research.google.com/drive/18Yx43GhX56-jlE-m0SdMDIjVxHGeh5N-?usp=sharing)


### 対数正規分布の特性値の導出

> 中央値の導出

$X$の中央値を$M$とおくと

<div class="math display" style="overflow: auto">
$$
\begin{align*}
0.5 &= P(X \leq M)\\
&= P(\log X \leq \log M)\\
&= P(\log X \leq \mu)
\end{align*}
$$
</div>

従って、$M = \exp(\mu)$

> 平均と分散

$Y \equiv \log X$とすると、$E[X] = E[\exp(Y)]$と表現できます.

正規分布のモーメント母関数が

<div class="math display" style="overflow: auto">
$$
\begin{align*}
M_Y(t) &= E[\exp(tY)]\\
&= \exp\left(\mu t + \frac{\sigma^2t^2}{2}\right)
\end{align*}
$$
</div>

であり、$M_Y(1) = E[X]$に相当することから

$$
E[X] = \exp\left(\mu+ \frac{\sigma^2}{2}\right)
$$

分散は平均の導出と同様に, $E[X^2] = M_Y(2)$を利用し、

$$
E[X^2] = \exp\left(2\mu  + 2\sigma^2\right)
$$

従って

<div class="math display" style="overflow: auto">
$$
\begin{align*}
V(X) &= E[X^2] - E[X]^2\\
&= \exp\left(2\mu  + 2\sigma^2\right) - \exp\left(2\mu+ \sigma^2\right)\\
&= \exp(2\mu+ \sigma^2)(\exp(\sigma^2) - 1)
\end{align*}
$$
</div>

## Appendix: 最強力検定
### 定義：検出力関数

$\theta$を識別したいパラメータ, $\Theta_0$を帰無仮説パラメータースペース, $R$を棄却域とした時、

$$
\beta(\theta) = P_\theta(\mathbf X \in R)
$$

を検出力関数(power function)といいます. $\theta\in\Theta_0$に対しては$\beta(\theta)$はType I Error(帰無仮説が正しいのに棄却してしまう誤り)を表し、
$\theta\in\Theta_0^c$に対しては$1 - \beta(\theta)$がType II Error(帰無仮説が正しくないのに受容してしまう誤り)を指します.

### 定義：検定のレベルとサイズ

有意水準 $\alpha \in (0, 1)$に対して、 $\sup_{\theta\in\Theta_0}\beta(\theta)=\alpha$のとき、サイズ$\alpha$の検定といい、
$\sup_{\theta\in\Theta_0}\beta(\theta)\leq\alpha$のとき、レベル$\alpha$の検定といいます.

### 定義：検出力関数がより強力

２つの検定手法$T_1, T_2$がありそれぞれの検出力関数を$\beta_1(\theta), \beta_2(\theta)$とします. 
この時、次の条件を満たすとき、$T_1$は$T_2$より強力(more powerful)であるといいます.

- すべての$\theta\in\Theta_0$に対して、$\beta_1(\theta)\leq \alpha, \beta_2(\theta)\leq \alpha$である
- すべての$\theta\in\Theta_0^C$に対して、$\beta_1(\theta)\geq\beta_2(\theta)$であり、少なくとも1点で不等式が成り立つ

### 定義：一様最強力検定

レベル$\alpha$の検定クラスの全体を$C_\alpha$で表す. このとき、検定$T$が一様最強力検定であるとは、$T$が
レベル$\alpha$の検定クラスに属しており、レベル$\alpha$の検定クラスの中のどんな検定よりも強力であることをいう.

すなわち、

- すべての$\theta\in\Theta_0$に対して、$\beta_T(\theta)\leq \alpha$である
- 任意の検定$S\in C_\alpha$に対して、その検出力関数を$\beta_S(\theta)$とすると、すべての$\theta\in\Theta_0^C$に対して$\beta_T(\theta)\geq\beta_S(\theta)$が成り立つ



## References

- [Ryo's Tech Blog > 変数変換のルールをまとめる](https://ryonakagami.github.io/2021/04/21/variable-transformation/)
- [明解演習 数理統計, 小寺 平治著](https://www.kyoritsu-pub.co.jp/bookdetail/9784320013810)
- [現代数理統計学の基礎, 久保川 達也著](https://www.kyoritsu-pub.co.jp/bookdetail/9784320111660)
