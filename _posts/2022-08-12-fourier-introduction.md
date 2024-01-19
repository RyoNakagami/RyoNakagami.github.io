---
layout: post
title: "フーリエ級数の着想"
subtitle: "フーリエ解析 1/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-15
header-mask: 0.0
header-style: text
tags:

- math
- フーリエ解析
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [フーリエが考えた問題設定: 熱伝導方程式](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E3%81%8C%E8%80%83%E3%81%88%E3%81%9F%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A-%E7%86%B1%E4%BC%9D%E5%B0%8E%E6%96%B9%E7%A8%8B%E5%BC%8F)
- [簡単な形の関数: 変数分離](#%E7%B0%A1%E5%8D%98%E3%81%AA%E5%BD%A2%E3%81%AE%E9%96%A2%E6%95%B0-%E5%A4%89%E6%95%B0%E5%88%86%E9%9B%A2)
- [フーリエ級数の登場](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E7%B4%9A%E6%95%B0%E3%81%AE%E7%99%BB%E5%A0%B4)
  - [正弦関数の積の積分公式の証明](#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%A9%8D%E3%81%AE%E7%A9%8D%E5%88%86%E5%85%AC%E5%BC%8F%E3%81%AE%E8%A8%BC%E6%98%8E)
- [登場時のフーリエ級数の問題点](#%E7%99%BB%E5%A0%B4%E6%99%82%E3%81%AE%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E7%B4%9A%E6%95%B0%E3%81%AE%E5%95%8F%E9%A1%8C%E7%82%B9)
- [Appendix](#appendix)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## フーリエが考えた問題設定: 熱伝導方程式

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>フーリエ級数</ins></p>

実関数$f(x)$が$x\in(-L, L)$で定義され, その外側では$f(x+2L) = f(x)$とする. このとき, $f(x)$は以下のように表現できる:

$$
f(x) = \frac{a_0}{2} + \sum^\infty_{n=1}\left(a_n\cos\frac{n\pi x}{L} + b_n\sin\frac{n\pi x}{L}\right)
$$

</div>

フーリエ(1768-1830)が活躍した頃のヨーロッパでは, 産業革命による蒸気機関の登場という出来事がありました.
蒸気機関は, 蒸気を利用して熱エネルギーを機械を動かすためのエネルギーへと変換する動力機関です. このような熱という自然現象を微分方程式という数式で説明し, その解を求めようということに科学者たちは関心をもっており, その流れの中で生まれたのがフーリエ級数です.

ここではまず, 熱伝導という現象の分析からフーリエ級数がどのように生まれたのか簡単に説明します.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/math/20220812_fourier_01.png?raw=true">

図のように細長い密度が一定の棒が与えられたとします. 時刻$t$における, 左端から右に向かっての距離$x$の位置での物体の温度を$u(x, t)$で表すとします.

まずフーリエは物理的考察より$u$の変化が以下の偏微分方程式に従うことを示しました.

$$
\frac{\partial u}{\partial t} = \frac{\lambda}{\rho c}\frac{\partial^2 u}{\partial x}
$$

- $\lambda$ : 熱伝導率
- $\rho$ : 密度
- $c$ : 比熱


問題を単純化するため, RHSの第一項が定数1である場合を考えます. よって, 上の式は以下のように表現されます

$$
\frac{\partial u}{\partial t} = \frac{\partial^2 u}{\partial x}
$$

フーリエは個々で以下のような問題を考えました.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Question</ins></p>

熱伝導方程式が以下のように与えられたとき

$$熱伝導
\frac{\partial u}{\partial t} = \frac{\partial^2 u}{\partial x}
$$


与えられた棒の両端の温度を0に保ち, 初期状態での温度が位置$x$の関数$f(x)$で与えられるとする. このとき温度$u$は時間と共に下がっていくとしたとき, どのように変化していくか？

</div>

つまり,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\text{初期条件: }& u(x, 0) = f(x) \qquad \qquad \ \ (0\leq x\leq \pi)\\
\text{境界条件: }& u(0, t) = u(\pi, t) = 0 \qquad (t\geq 0)
\end{align*}
$$
</div>


**重ね合わせの原理より**$u_1, u_2$が熱伝導方程式と境界条件を満たすならば, $k, z$を定数としたとき

- $ku_1 + zu_2$も熱伝導方程式と境界条件を満たす

このことにフーリエは着目し,

1. 熱伝導方程式と境界条件を満たす関数を簡単な形で見つける
2. 見つかった関数を足し合わせることで初期熱伝導条件を満たす関数を作る

という二段構えで問題を解こうとしました. 

## 簡単な形の関数: 変数分離


フーリエは簡単な関数の形として以下のような変数分離型の解を考えました

$$
u(x, t) = v(x)w(t)
$$

この関数についてまず各変数で微分してみます

$$
\begin{align*}
\frac{\partial u }{\partial t} &= v(x)w^{\prime}(t)\\[3pt]
\frac{\partial u }{\partial x} &= w(t)v^{\prime\prime}(x)
\end{align*}
$$

熱伝導方程式を満たすとしたとき, 以下が成立することがわかります

$$
\begin{align*}
&v(x)w^{\prime}(t) = w(t)v^{\prime\prime}(x)\\
&\Rightarrow \frac{v^{\prime\prime}(x)}{v(x)} = \frac{w^{\prime}(t)}{w(t)}
\end{align*}
$$

ここで$\frac{v^{\prime\prime}(x)}{v(x)} = C$とおくと

$$
\begin{align*}
v^{\prime\prime}(x) &= Cv(x)\\
w^{\prime}(x) &= Cw(t)
\end{align*}
$$

これらからまず, $A$を定数とすると

$$
w(t) = A\exp(Ct)
$$

時間の経過と共に温度は下がっていくので $C < 0$を満たす実数でなければなりません. そこで

$$
C = - n^2
$$

と書き直して$v(x)$に着目すると

$$
\begin{align*}
&v^{\prime\prime}(x) = -n^2v(x)\\
&\Rightarrow v(x) = B\sin(nx + \theta) \ \ \text{ s.t } \text{ constant } B, \theta
\end{align*}
$$

関数$u(t)$は境界条件$u(0, t) = u(\pi, t) = 0$を満たさなくてならないので

- $n$は整数
- $\theta = 0$

でなければならないことがわかります. 以上より簡単な形の関数が変数分離型としたとき

$$
u(x, t) = B\exp(-n^2t)\sin(nx) \qquad (n=1,2,3,\cdots)
$$

だけであることがわかります. 

## フーリエ級数の登場

$$
u(x, t) = B\exp(-n^2t)\sin(nx) \qquad (n=1,2,3,\cdots)
$$

が熱伝導方程式と境界条件を満たすとき, 重ね合わせの原理より線型結合も満たすので

$$
\sum_{n=1}^Nb_n\exp(-n^2t)\sin(nx)
$$

も熱伝導方程式と境界条件を満たします. 詳しい説明はしませんがフーリエはここから$N$を無限にしても熱伝導方程式と境界条件を満たすと主張しました. つまり, 

$$
g(x) = \sum_{n=1}^\infty b_n\exp(-n^2t)\sin(nx)
$$

つぎに, $b_n$をどのように求めるかという問題が出てきます. このとき, 正弦関数の積の積分公式

$$
\begin{align*}
\int^{\pi}_0\sin nx \sin kx dx =\begin{cases}
\displaystyle 0 & (k\neq n)\\[4pt]
\displaystyle \frac{\pi}{2} & (k = n)
\end{cases}
\end{align*}
$$

より, 

$$
\begin{align*}
&\int^{\pi}_0g(x)\sin kx\ dx = \frac{\pi}{2}b_k\\
&b_n = \frac{2}{\pi}\int^{\pi}_0g(x)\sin nx \ dx
\end{align*}
$$

このようにして, 熱伝導方式を境界条件と初期条件から得方法として三角関数の和で表現するというフーリエ級数が誕生しました.


### 正弦関数の積の積分公式の証明

<div class="math display" style="padding-left: 2em;  border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">

$n,k$をそれぞれ自然数としたとき

$$
\begin{align*}
\int^{\pi}_0\sin nx \sin kx dx =\begin{cases}
\displaystyle 0 & (k\neq n)\\[4pt]
\displaystyle \frac{\pi}{2} & (k = n)
\end{cases}
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

積和の公式より

$$
\sin \alpha\sin \beta=-\frac{1}{2} \left\{\cos(\alpha+\beta)-\cos(\alpha-\beta)\right\}
$$

この積和の公式を用いると

$$
\begin{align*}
\int^{\pi}_0\sin nx \sin kx\ dx &= -\frac{1}{2}\int^{\pi}_0 \left\{\cos(n+k)x-\cos(n-k)x\right\} dx \\
&= -\frac{1}{2}\left\{\int^{\pi}_0\cos(n+k)x\ dx- \int^{\pi}_0\cos(n-k)x\ dx\right\}
\end{align*}
$$

つぎに以下のケースを考えます

- $n=k$のとき
- $n\neq k$のとき

> $n=k$のとき

$$
-\frac{1}{2}\left\{\int^{\pi}_0\cos(n+k)x\ dx- \int^{\pi}_0\cos(n-k)x\ dx\right\}
$$

の第二項は$\pi$となる一方, 第一項は

$$
\begin{align*}
\int^{\pi}_0\cos(n+k)x dx &= -\left[\sin(n+k)x\right]^{\pi}_0\\
&= 0
\end{align*}
$$

従って, 

$$
-\frac{1}{2}\left\{\int^{\pi}_0\cos(n+k)x\ dx- \int^{\pi}_0\cos(n-k)x\ dx\right\} = \frac{\pi}{2}
$$


> $n\neq k$のとき

$$
\begin{align*}
\int^{\pi}_0\cos(n-k)x\ dx &= -\left[\sin(n-k)x\right]^{\pi}_0 = 0\\[3pt]
\int^{\pi}_0\cos(n+k)x\ dx &= -\left[\sin(n+k)x\right]^{\pi}_0 = 0
\end{align*}
$$

より

$$
-\frac{1}{2}\left\{\int^{\pi}_0\cos(n+k)x\ dx- \int^{\pi}_0\cos(n-k)x\ dx\right\} = ０
$$

</div>


## 登場時のフーリエ級数の問題点

一般に, $-\pi$から$\pi$までの実数$x$で定義された関数$f(x)$に対して

$$
\begin{align*}
a_n = \frac{1}{\pi}\int^\pi_{-\pi}f(x) \cos nx\ dx\\[3pt]
b_n = \frac{1}{\pi}\int^\pi_{-\pi}f(x) \sin nx\ dx
\end{align*}
$$

と定めると, $f(x)$のフーリエ級数は

$$
f(x)\sim \frac{a_0}{2} + \sum^{\infty}_{n=1}(a_n\cos nx + b_n \sin nx)
$$

と表現されます. $\sim$ と表記している理由としては, 

- フーリエ級数は収束するかわからない
- 収束しても値が$f(x)$と一致するかわからない

そのため, 等号で結ぶわけにはいかないことが理由となります. 

フーリエ級数が登場初期には以下のような批判にさらされました:

- $-\pi$から$\pi$までの特定の一個の$x$について$f(x)$の値を変更しても積分の値には影響しないので異なる関数が同じフーリエ級数で表現されてしまうのではないか？
- 無限級数の項別積分(無限和と積分の順序交換)ができる保証はどこにあるのか？

無限和と積分の順序交換の批判とは

$$
\begin{align*}
&\int^\pi_{-\pi}\sum_{k=1}^\infty (a_k \cos kx + b_k \sin kx)\cos nx\ dx\\[3pt]
&=\sum_{k=1}^\infty \left(a_k \int^\pi_{-\pi}\cos kx \cos nx\ dx + b_k \int^\pi_{-\pi}\sin kx \cos nx\ dx\right)
\end{align*}
$$

ができる保証がないというものです. フーリエの時代では積分の理論が十分なものではなく, この問題の解決は後の時代まで待つこととなりました.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: 異なる関数間でフーリエ係数が一致してしまうとき</ins></p>

区分的になめらかで基本周期が$2\pi$の関数$f(x), g(x)$を考える. $[-\pi, \pi]$区間の有限個の点を除いて
$f(x) = g(x)$が成り立つと

$$
\int^\pi_{-\pi}f(x)dx = \int^\pi_{-\pi}g(x)dx
$$

となってしまう. フーリエ係数は積分によって定義されるので, $[-\pi, \pi]$区間において有限個の点を除いて一致してしまうと, ２つの関数の関数のフーリエ係数は一致してしまいます.

</div>




## Appendix

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 比熱</ins></p>

- 比熱とは  1kg の物質の温度を 1K （＝1℃）上げるのに必要な熱量のこと
- 「温まりやすさ」 「冷めにくさ」 を表す物理量と理解できる

例えば, 水1kgの場合, 1K 上げるのに必要な熱量は4186J. 

</div>



References
----------

- [「集合と位相」をなぜ学ぶのか―数学の基礎として根づくまでの歴史](https://gihyo.jp/book/2018/978-4-7741-9612-1)
- [フーリエ解析（理工系の数学入門コース［新装版］）](https://pro.kinokuniya.co.jp/search_detail/product?ServiceCode=1.0&UserID=PLATON&isbn=9784000298889&lang=en-US&search_detail_called=1&table_kbn=A%2CE%2CF)
- [Ryo's Tech Blog > 加法定理と積和の公式の図形的理解](https://ryonakagami.github.io/2021/02/14/addition-theorem/)