---
layout: post
title: "変数間の直線的関係性の尺度としてのPearsonの相関係数"
subtitle: "相関係数 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-12-08
tags:

- 統計検定
- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Pearsonの相関係数](#pearson%E3%81%AE%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0)
  - [Pearsonの相関係数の性質 (1): Peason相関係数の値域](#pearson%E3%81%AE%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA-1-peason%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%AE%E5%80%A4%E5%9F%9F)
  - [Pearsonの相関係数の性質 (2): スケール変換に対して不変](#pearson%E3%81%AE%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA-2-%E3%82%B9%E3%82%B1%E3%83%BC%E3%83%AB%E5%A4%89%E6%8F%9B%E3%81%AB%E5%AF%BE%E3%81%97%E3%81%A6%E4%B8%8D%E5%A4%89)
  - [正の相関係数の非推移性](#%E6%AD%A3%E3%81%AE%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%AE%E9%9D%9E%E6%8E%A8%E7%A7%BB%E6%80%A7)
- [Pearson相関係数の例題](#pearson%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%AE%E4%BE%8B%E9%A1%8C)
  - [Pearson相関係数が 0 となるケース](#pearson%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%8C-0-%E3%81%A8%E3%81%AA%E3%82%8B%E3%82%B1%E3%83%BC%E3%82%B9)
  - [Pearson相関係数の絶対値が 1 となるケース](#pearson%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%AE%E7%B5%B6%E5%AF%BE%E5%80%A4%E3%81%8C-1-%E3%81%A8%E3%81%AA%E3%82%8B%E3%82%B1%E3%83%BC%E3%82%B9)
  - [基本統計量から相関係数を計算する](#%E5%9F%BA%E6%9C%AC%E7%B5%B1%E8%A8%88%E9%87%8F%E3%81%8B%E3%82%89%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%82%92%E8%A8%88%E7%AE%97%E3%81%99%E3%82%8B)
- [Appendix](#appendix)
  - [確率変数の和の分散の分解](#%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E5%92%8C%E3%81%AE%E5%88%86%E6%95%A3%E3%81%AE%E5%88%86%E8%A7%A3)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Pearsonの相関係数

とある母集団からランダムサンプリングされた 2変数 $(x, y)$ からなる大きさ $n$ の数値データが存在するとします:

$$
\bigg(\begin{array}{c}  x_1\\y_1\end{array}\bigg), \cdots,\bigg(\begin{array}{c}x_n\\ y_n \end{array}\bigg)
$$

このサンプルについて, 2変数間の「直線的関係」の尺度としてPearsonの相関係数, $r_{xy}$ がしばしば用いられます:

$$
r_{xy} = \frac{\sum_{i=1}^n (x_i - \bar x)(y_i - \bar y)}{\sqrt{\sum_{i=1}^n (x_i - \bar x)^2 \sum_{i=1}^n (y_i - \bar y)^2}}
$$

### Pearsonの相関係数の性質 (1): Peason相関係数の値域 

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property 1: Peason相関係数の値域 </ins></p>

$$
-1 \leq r_{xy} \leq 1
$$

$\vert r_{xy}\vert=1$は2変数間に1次式の関係があるときに限定されます. つまり, 

$$
\vert r_{xy}\vert=1 \Longleftrightarrow y_i = a + bx_i
$$ 

</div>

**証明**

Schwarzの不等式より

$$
\sum a_i^2 \sum b_i^2 \geq \bigg(\sum a_ib_i\bigg)^2
$$

$a_i = (x_i - \bar x), b_i = (y_i - \bar y)$ とすると

$$
\sum_{i=1}^n (x_i - \bar x)^2 \sum_{i=1}^n (y_i - \bar y)^2 \geq \bigg(\sum_{i=1}^n (x_i - \bar x)(y_i - \bar y)\bigg)^2
$$

従って,

$$
r_{xy}^2 \leq 1
$$

Schwarzの不等式の等号成立条件を考えると, **すべての $i$ について $a_i: b_i$ が一定**(ここではその比率を$k$とおく) なので, ここから

$$
y_i = kx_i + \bar y - k\bar x = kx_i + c \ \ ( \text{ c は定数とする})
$$

となり, $\vert r_{xy}\vert=1$ は変数間に1次式の関係があるときに限定されるときとわかる.

**証明終了**

---

### Pearsonの相関係数の性質 (2): スケール変換に対して不変

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: スケール変換に対して不変</ins></p>

$a_1 \neq 0, b_1, a_2\neq 0, b_2$ を定数として, 以下のような変数変換を考える

$$
\begin{align*}
u_i &= a_1 x_i + b_1\\
v_i &= a_2 y_i + b_2
\end{align*}
$$

このとき, 

$$
r_{uv} = \text{sgn}(a_1a_2)r_{xy}
$$

</div>


**証明**

$$
\begin{align*}
r_{uv} &= \frac{\sum_{i=1}^n (a_1x_i - a_1\bar x)(a_2y_i - a_2\bar y)}{\sqrt{\sum_{i=1}^n a_1^2(x_i - \bar x)^2 \sum_{i=1}^n a_2^2(y_i - \bar y)^2}}\\
&= \frac{a_1a_2}{|a_1a_2|}\frac{\sum_{i=1}^n (x_i - \bar x)(y_i - \bar y)}{\sqrt{\sum_{i=1}^n (x_i - \bar x)^2 \sum_{i=1}^n (y_i - \bar y)^2}}\\
&= \frac{a_1a_2}{|a_1a_2|}r_{xy}\\
&= \text{sgn}(a_1a_2)r_{xy}
\end{align*}
$$


**証明終了**

---

### 正の相関係数の非推移性

3つの独立な確率変数 $X, Y, Z$ にたいして、

$$
\begin{align*}
U &= X + Y\\
V &= Y + Z\\
W &= Z - X
\end{align*}
$$

とおくと, 

$$
\begin{align*}
\text{Cov}(U, V) &= \mathbf V(Y) > 0\\ 
\text{Cov}(V, W) &= \mathbf V(Z) > 0\\ 
\text{Cov}(U, W) &= -\mathbf V(X) < 0 
\end{align*}
$$

となり, 正の推移性我成立しないことがわかる

**終了**

## Pearson相関係数の例題
### Pearson相関係数が 0 となるケース

単位円周上の一様分布に従う確率変数 $\Theta$ を考える. このとき, 確率変数 $\Theta$ のpdfは

$$
f(\theta)=\frac{1}{2\pi} \  \ \  \ (\theta \in [0, 2\pi))
$$

次に, $\Theta$ から次の確率変数 $X, Y$ を 以下のように定義する:


$$
\begin{align*}
X & = \cos\Theta\\
Y & = \sin\Theta
\end{align*}
$$

ここで定義より $X^2 + Y^2 = 1$ という関係性は自明である. 
このとき, $corr(X, Y)$は以下の式展開より $0$ となることがわかる.

$$
\begin{align*}
\mathbb E[XY] &= \frac{1}{2\pi} \int^{2\pi}_{0}\cos\theta \sin\theta d\theta\\
&= \frac{1}{4\pi} \int^{2\pi}_{0}\sin(\theta+\theta) - \sin(\theta-\theta) d\theta\\
&= \frac{1}{4\pi} \int^{2\pi}_{0}\sin(2\theta)d\theta\\
&= 0
\end{align*}
$$

従って、

$$
corr(X, Y) = \frac{\mathbb E[XY] - \mathbb E[X]\mathbb[Y] }{\sqrt{\mathbb V(X)\mathbb V(Y)}} = 0
$$

**終了**

---

### Pearson相関係数の絶対値が 1 となるケース

上の例題同様に単位円周上の一様分布に従う確率変数 $\Theta$ を考える. $\Theta$による円周の分割によってできる2つの線分のうち, 長い方を $X$, 短い方を $Y$ とする.


このとき, 

$$
\begin{align*}
X &\sim U(\pi, 2\pi)\\
Y &\sim U(0, \pi)\\
X & = 2\pi - Y
\end{align*}
$$

となる. 一様分布の性質より

$$
\mathbb V(X) = \mathbb V(Y) = \frac{\pi^2}{12}
$$

このときの$X, Y$間の相関係数は

$$
\begin{align*}
corr(X, Y) &= \frac{\mathbb E[XY] - \mathbb E[X]\mathbb E[Y]}{\sqrt{\mathbb V(X)\mathbb V(Y)}}\\
&= \frac{\mathbb E[Y(2\pi - Y)] - \pi/2 \cdot 3\pi/2}{\pi^2/12}\\
&= -1
\end{align*}
$$

ただ, 計算するまでもなく $X = 1 - Y$ という1次線形関係で表されることかあら $corr(X, Y) = -1$ とわかる


**終了**

---

### 基本統計量から相関係数を計算する

とある母集団から$(x_i, y_i, z_i)$の組標本を $n$サンプルサイズで収集したとする. また 三変数の関係として

$$
z_i = x_i + y_i
$$

このとき標本より以下のようなことが分かったとする

|変数|標本平均|標準偏差($s$と表記する)|
|---|---|---|
|$x$| 250|80|
|$y$| 200|75|
|$z$| 450|145|

この情報しかないときでも 相関係数 $\rho_{xy}$は以下のように計算可能.

$$
\rho_{xy} = \frac{s_{xy}}{s_xs_y}
$$

なので, $s_{xy}$のみが未知.


$$
\begin{align*}
Var(z_i) &= Var(x_i + y_i)\\
         &= Var(x_i) + Var(y_i) + 2Cov(x_i, y_i)\\
\Rightarrow s_{xy}&= \frac{1}{2} (s_z^2 - s_x^2 - s_y^2)
\end{align*}
$$

従って, 計算により $\rho_{xy} = 0.75$ とわかる

## Appendix
### 確率変数の和の分散の分解

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem </ins></p>

確率変数 $X$, $Y$に対して

$$
\text{Var}(X+Y) = \text{Var}(X) + \text{Var}(Y) + 2\text{Cov}(X,Y)
$$

</div>

**証明**

$\mathbb E[X] = \mu_x, \mathbb E[Y] = \mu_y$とおき

$$
\begin{align*}
\text{Var}(X+Y) &= \mathbb E[(X+Y - \mu_x - \mu_y)^2]\\
         &= \mathbb E[(X-\mu_x)^2] + 2\mathbb E[(X-\mu_x)(Y-\mu_y)] + \mathbb E[(Y-\mu_y)^2]\\
         &= \text{Var}(X) + \text{Var}(Y) + 2\text{XCov}(X,Y)
\end{align*}
$$

**証明終了**

---

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem </ins></p>

確率変数 $X_1 \cdots, X_n$, それぞれの期待値が存在し $\mu_1, \cdots, \mu_n$ と表せるとき

$$
\text{Var}(X_1+X_2 + \cdots + X_n) = \sum_i^n Var(X_i) + 2\sum_{i<j}Cov(X_i, X_j)
$$

</div>

**証明**

$$
\begin{align*}
Var(X_1+\cdots+X_n) &= \mathbb E[(X_1+\cdots+X_n - \mu_1 - \cdots - \mu_n)^2]\\
         &= \mathbb E[\sum (X_i - \mu_i)^2 + 2\sum_{i<j}(X_i - \mu_i)(X_j-\mu_j)]\\
         &= \sum \mathbb E[(X_i - \mu_i)^2] +2\sum_{i<j}\mathbb E[(X_i - \mu_i)(X_j-\mu_j)]\\
         &= \sum_i^n \text{Var}(X_i) + 2\sum_{i<j}\text{Cov}(X_i, X_j)
\end{align*}
$$


**証明終了**
