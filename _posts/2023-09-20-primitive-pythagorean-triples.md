---
layout: post
title: "原始ピタゴラス数"
subtitle: "競技プログラミングに役に立つ数学 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-09-28
tags:

- 競技プログラミング
- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [原始ピタゴラス数](#%E5%8E%9F%E5%A7%8B%E3%83%94%E3%82%BF%E3%82%B4%E3%83%A9%E3%82%B9%E6%95%B0)
- [なぜピタゴラス数が表現できるのか？](#%E3%81%AA%E3%81%9C%E3%83%94%E3%82%BF%E3%82%B4%E3%83%A9%E3%82%B9%E6%95%B0%E3%81%8C%E8%A1%A8%E7%8F%BE%E3%81%A7%E3%81%8D%E3%82%8B%E3%81%AE%E3%81%8B)
- [原始ピタゴラス数を網羅する証明](#%E5%8E%9F%E5%A7%8B%E3%83%94%E3%82%BF%E3%82%B4%E3%83%A9%E3%82%B9%E6%95%B0%E3%82%92%E7%B6%B2%E7%BE%85%E3%81%99%E3%82%8B%E8%A8%BC%E6%98%8E)
  - [原始ピタゴラス数について$a$ と $b$ のどちらか一方のみ奇数で他方は偶数, $c$ は奇数](#%E5%8E%9F%E5%A7%8B%E3%83%94%E3%82%BF%E3%82%B4%E3%83%A9%E3%82%B9%E6%95%B0%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6a-%E3%81%A8-b-%E3%81%AE%E3%81%A9%E3%81%A1%E3%82%89%E3%81%8B%E4%B8%80%E6%96%B9%E3%81%AE%E3%81%BF%E5%A5%87%E6%95%B0%E3%81%A7%E4%BB%96%E6%96%B9%E3%81%AF%E5%81%B6%E6%95%B0-c-%E3%81%AF%E5%A5%87%E6%95%B0)
  - [$(a, b)$のうち奇数の値を$x$としたとき, $(x+c)/2$, $(x-a)/2$は共に平方数](#a-b%E3%81%AE%E3%81%86%E3%81%A1%E5%A5%87%E6%95%B0%E3%81%AE%E5%80%A4%E3%82%92x%E3%81%A8%E3%81%97%E3%81%9F%E3%81%A8%E3%81%8D-xc2-x-a2%E3%81%AF%E5%85%B1%E3%81%AB%E5%B9%B3%E6%96%B9%E6%95%B0)
  - [原始ピタゴラス数を網羅する証明](#%E5%8E%9F%E5%A7%8B%E3%83%94%E3%82%BF%E3%82%B4%E3%83%A9%E3%82%B9%E6%95%B0%E3%82%92%E7%B6%B2%E7%BE%85%E3%81%99%E3%82%8B%E8%A8%BC%E6%98%8E-1)
- [原始ピタゴラス数の性質](#%E5%8E%9F%E5%A7%8B%E3%83%94%E3%82%BF%E3%82%B4%E3%83%A9%E3%82%B9%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [$a, b$のいずれか１つのみ３の倍数](#a-b%E3%81%AE%E3%81%84%E3%81%9A%E3%82%8C%E3%81%8B%EF%BC%91%E3%81%A4%E3%81%AE%E3%81%BF%EF%BC%93%E3%81%AE%E5%80%8D%E6%95%B0)
  - [$a, b$のいずれか１つのみ4の倍数](#a-b%E3%81%AE%E3%81%84%E3%81%9A%E3%82%8C%E3%81%8B%EF%BC%91%E3%81%A4%E3%81%AE%E3%81%BF4%E3%81%AE%E5%80%8D%E6%95%B0)
  - [$a, b, c$のいずれか１つのみ5の倍数になる](#a-b-c%E3%81%AE%E3%81%84%E3%81%9A%E3%82%8C%E3%81%8B%EF%BC%91%E3%81%A4%E3%81%AE%E3%81%BF5%E3%81%AE%E5%80%8D%E6%95%B0%E3%81%AB%E3%81%AA%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 原始ピタゴラス数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 原始ピタゴラス数</ins></p>

$$
a^2 + b^2 = c^2
$$

となる正の整数の組 $(a, b, c)$をピタゴラス数という. 特に, $gcd(a, b, c) = 1$のとき, 原始ピタゴラス数という

</div>

例として, $(3, 4, 5)$は原始ピタゴラス数ですが, $(6, 8, 10)$はピタゴラス数ではあるけれども原始ピタゴラス数ではない.
原始ピタゴラス数を求めることができれば, その各辺の定数倍で原始ピタゴラス数以外のピタゴラス数は表現できます.

この性質を利用して解く競技プログラミングの問題として, [Project Euler Problem 309. Integer Ladders](https://projecteuler.net/problem=309)があります.

この原始ピタゴラス数ジェネレーターとして以下の式が知られています

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Primitive Pythagorean Triples Generator</ins></p>

$a^2+b^2=c^2$を満たす原始ピタゴラス数$(a, b, c)$であって, $b$ が偶数であるものは

- $m > n >0$は整数
- $gcd(m, n)=1$
- $m, n$のいずれかは偶数

$$
\begin{align*}
a &= m^2 - n^2\\
b &= 2mn\\
c &= m^2 + n^2
\end{align*}
$$

</div>

## なぜピタゴラス数が表現できるのか？

$$
\begin{align*}
a &= m^2 - n^2\\
b &= 2mn\\
c &= m^2 + n^2
\end{align*}
$$

でピタゴラス数が表現できることの確認は簡単です.

$$
\begin{align*}
(m^2 - n^2)^2 + (2mn)^2 &= m^4 + m^4 + 2m^2n^2\\
                        &= (m^2 + n^2)^2
\end{align*}
$$

以上より, 正の整数の組$(m, n)$によってピタゴラス数が表現できることがわかります.
この段階ではまだ, 正の整数の組$(m, n)$がすべてのピタゴラス数を表現できるかどうかはわかりません.

## 原始ピタゴラス数を網羅する証明

$a^2+b^2=c^2$を満たす, 互いに素なピタゴラス数$(a,b,c)$について以下をまず考えます

- $a$ と $b$ のどちらか一方のみ奇数で他方は偶数, $c$ は奇数
- $(a, b)$のうち奇数の値を$x$としたとき, $(x+c)/2$, $(x-a)/2$は共に平方数

これらから正の整数の組$(m, n)$によって原始ピタゴラス数が網羅できることが証明できます.

### 原始ピタゴラス数について$a$ と $b$ のどちらか一方のみ奇数で他方は偶数, $c$ は奇数

$(a, b)$が共に偶数だと, $c$も偶数になり, 互いに素という仮定に矛盾.

つぎに, $(a, b)$が共に奇数である場合を考える. すると以下が成り立つ

$$
\begin{align*}
a \bmod 4 &\equiv \pm 1 \\
a^2 \bmod 4 &\equiv 1 \\
a^2 + b^2 \bmod 4 &\equiv 2 
\end{align*}
$$

- $c^2 = a^2 + b^2$
- $c^2$は平方数

という条件から

$$
c^2 \bmod 4 \equiv 0
$$

これは $a^2 + b^2 \bmod 4 \equiv 2$と矛盾なので, $a$ と $b$ のどちらか一方のみ奇数で他方は偶数となる.
したがって, $a^2 + b^2$は奇数となるので$c$も奇数となり, 題意が示された.


### $(a, b)$のうち奇数の値を$x$としたとき, $(x+c)/2$, $(x-a)/2$は共に平方数

原始ピタゴラス数の組$(a, b, c)$について, 一般性を失うことなく $a$を奇数と仮定します

このとき, $(a+c)/2$, $(c-a)/2$の少なくともいずれかが平方数ではないと仮定します.

このとき,

$$
\frac{a+c}{2}\frac{c-a}{2} = \frac{b^2}{4}
$$

が成り立つので, $b^2$は４の倍数なので, $(a+c), (c-a)$は共通因子$p\geq 2$を持ちます.

$$
\begin{align*}
a+c &= 2pu\\
c-a &= 2pv
\end{align*}
$$

これについて解くと

$$
\begin{align*}
a &= p(u-v)\\
c &= p(u+v) 
\end{align*}
$$

となり, $a, b, c$すべて$p$の倍数と表現されてしまい, 原始ピタゴラス数の仮定 $gcd(a, b, c)=1$の仮定に矛盾.
したがって, $(a, b)$のうち奇数の値を$x$としたとき, $(x+c)/2$, $(x-a)/2$は共に平方数。

### 原始ピタゴラス数を網羅する証明

上の証明より, $(a,b,c)$が原始ピタゴラス数であるならば, 下記を満たす整数の組$(m,n)$が存在することがわかる:

$$
\begin{align*}
\frac{c+a}{2} &= m^2\\
\frac{c-a}{2} &= n^2\\
gcd(m,n) &= 1\\
mn \bmod 2 &\equiv 0
\end{align*}
$$

これを解くと, $(a,b,c)$が原始ピタゴラス数であるならば

$$
\begin{align*}
a &= m^2 - n^2\\
c &= m^2 + n^2\\
b &= 2mn
\end{align*}
$$

といえる. したがって, 原始ピタゴラス数ジェネレーターがすべての原始ピタゴラスを網羅することが証明された.


## 原始ピタゴラス数の性質

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins> 原始ピタゴラス数の性質　</ins></p>

$(a,b,c)$を$a^2+b^2=c^2$を満たす原始ピタゴラス数としたとき, 以下が成り立つ

- $a, b$のいずれか１つのみ３の倍数
- $a, b$のいずれか１つのみ4の倍数
- $a, b, c$のいずれか１つのみ5の倍数になる
</div>

### $a, b$のいずれか１つのみ３の倍数

任意の正の整数$x$について$x \bmod 3 \pm 1$ or $x \bmod 3 \equiv 0$と表されることを利用して

$a,b$どちらも3の倍数ではないとすると

$$
\begin{align*}
a^2 + b^2 \bmod 3 \equiv 2
\end{align*}
$$

$c^2 \bmod 3$は$1, 0$のいずれかにしかならないので, 矛盾.

$a,b$どちらも3の倍数のとき,

$$
\begin{align*}
a^2 + b^2 \bmod 3 \equiv 0
\end{align*}
$$

このとき$c \bmod 3 \equiv 0$となってしまうので, $gcd(a, b, c)=1$に矛盾
したがって, $a, b$のいずれか１つのみ３の倍数となる.


### $a, b$のいずれか１つのみ4の倍数

$a,b$どちらも4の倍数とすると$c$も偶数となるので$gcd(a, b, c)=1$に矛盾.

$a,b$どちらも4の倍数でないとすると, 片方は偶数なので, $b$を一般生失うことなく偶数と仮定すると

$$
\begin{align*}
a \bmod 8 &\equiv \pm 1 \text{ or } \pm 3\\
b \bmod 8 &\equiv \pm 2\\
a^2 + b^2 \bmod 8 &\equiv 5
\end{align*}
$$

このとき $c^2 \bmod 1$なので矛盾. 
したがって, $a, b$のいずれか１つのみ4の倍数となる


### $a, b, c$のいずれか１つのみ5の倍数になる

$a, b$について片方は偶数なので, $b$を一般生失うことなく偶数と仮定すると$b$は４の倍数となる.

このとき, 

$$
\begin{align*}
a \bmod 5 &\equiv 0 \text{ or } \pm 2\\
b \bmod 5 \equiv 0 \text{ or } \pm 1
\end{align*}
$$

ここで$a, c$が５の倍数であることを仮定すると

$$
\begin{align*}
a^2 + b^2 \bmod 5 &\equiv 1\\
c^2 \bmod &\equiv 0
\end{align*}
$$

となり矛盾.

$b, c$が５の倍数であることを仮定すると

$$
\begin{align*}
a^2 + b^2 \bmod 4 &\equiv 1\\
c^2 \bmod 5 &\equiv  0
\end{align*}
$$

となり矛盾. 

$a,b,c$どれも5の倍数ではないとすると

$$
\begin{align*}
a^2 + b^2 \bmod 5 &\equiv 0\\
c^2 \bmod 5 & \not\equiv 0
\end{align*}
$$

となり矛盾. したがって, $a, b, c$のいずれか１つのみ5の倍数になる.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: 円周上の有理点とピタゴラス数</ins></p>

$x>0, y>0$と$x^2 + y^2 = 1$を満たす有理数$x,y\in \mathbb Q$を求める問題は

$$
\begin{align*}
x &= \frac{a}{c}\\
y &= \frac{b}{c}\\
a,b,c & \in \mathbb N
\end{align*}
$$

と表現することで$a^2+b^2=c^2$の原始ピタゴラス数の問題と帰着できる. このことをふまえると

$$
\begin{align*}
x &= \frac{m^2-n^2}{m^2+n^2}\\
y &= \frac{2mn}{m^2+n^2}
\end{align*}
$$

と表現される.

</div>



References
-------------

- [高校数学の美しい物語 > ピタゴラス数の求め方とその証明](https://manabitimes.jp/math/661)
- [数学の景色 > ピタゴラス数の求め方(解)・性質とその証明](https://mathlandscape.com/pythagoras-triple/)
- [Project Euler Problem 309. Integer Ladders](https://projecteuler.net/problem=309)
