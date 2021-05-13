---
layout: post
title: "巴戦の確率"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- math
- 統計
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
|目的|巴戦の確率|
|参考|-[高校数学の美しい物語](https://manabitimes.jp/math/1360)<br>-[28年東大前期理数学.pdf](https://github.com/ryonakimageserver/lecturenotes/blob/main/%E5%A4%A7%E5%AD%A6%E5%85%A5%E8%A9%A6/28%E5%B9%B4%E6%9D%B1%E5%A4%A7%E5%89%8D%E6%9C%9F%E7%90%86%E6%95%B0%E5%AD%A6.pdf)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [巴戦の問題](#%E5%B7%B4%E6%88%A6%E3%81%AE%E5%95%8F%E9%A1%8C)
  - [解答(1)](#%E8%A7%A3%E7%AD%941)
  - [解答(1)別解](#%E8%A7%A3%E7%AD%941%E5%88%A5%E8%A7%A3)
  - [解答(2)](#%E8%A7%A3%E7%AD%942)
  - [解答(3)](#%E8%A7%A3%E7%AD%943)
  - [解答(3)別解](#%E8%A7%A3%E7%AD%943%E5%88%A5%E8%A7%A3)
  - [解答(4)](#%E8%A7%A3%E7%AD%944)
  - [解答(5)](#%E8%A7%A3%E7%AD%945)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 巴戦の問題

Ａ、Ｂ、Ｃの３人の力士で試合を行う。１試合目は、Ａ対Ｂで行い、次の試合からは、勝者が待機していた残りの１人と試合を行う。２回連続して勝てば優勝であり、誰かが優勝するまで繰り返す。Ａ、Ｂ、Ｃのいずれも、各試合で勝つ確率が５割であるとする。

(1) A, B, Cのそれぞれの優勝確率を求めよ<br>
(2) $$n$$ を 2以上の整数とする。ちょうど $$n$$ 試合目でAが優勝する確率を求めよ。<br>
(3) 優勝が決定するまで必要な試合数の期待値を求めよ<br>
(4) $$m$$ を正の整数とする。総試合数が $$3m$$ 回以下でAが優勝したとき、Aの最後の対戦相手がBである条件付確率を求めよ<br>
(5) 優勝が決定するまで必要な試合数の分散を求めよ

### 解答(1)

対戦して負けた力士が優勝する確率を$$p$$とおく。

> A, Bが優勝する確率

- 最初の2試合で連続して勝利して優勝するパターン
- 最初の試合で勝利し、2試合目に負けて、それ以降で優勝するパターン
- 最初の試合に負けて, それ以降で優勝するパターン 

$$
\frac{1}{2}\times \frac{1}{2} + \frac{1}{2}\times p + \frac{1}{2}\times \frac{1}{2} \times p = \frac{1}{4} + \frac{3}{4}p
$$

> Cが優勝する確率

- 2試合目と3試合目に連続して勝利して優勝するパターン
- 2試合目に勝って,3試合目に負けて、3試合目の勝者が4試合目に負けるという条件のもとそれ以降で優勝するパターン

$$
\frac{1}{2}\times \frac{1}{2} + \frac{1}{2}\times \frac{1}{2}\times　p = \frac{1}{4} + \frac{1}{4}p
$$

各力士が優勝する事象の和集合は全事象、かつ排反事象なので、A, B, Cのそれぞれの優勝する確率を合計すると1になる。

$$
\frac{3}{4} + \frac{7}{4}p = 1
$$

$$
\therefore p = \frac{1}{7}
$$

よって、

$$
\begin{aligned}
Pr(\text{Aが優勝する確率}) &= \frac{5}{14}\\
Pr(\text{Bが優勝する確率}) &= \frac{5}{14}\\
Pr(\text{Cが優勝する確率}) &= \frac{2}{7}\\
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

### 解答(1)別解

Aが $$n$$ 試合目に優勝する確率を $$a_n$$​ とする。 $$a_1=0$$ ，$$a_2=\frac{1}{4}$$​ ，$$a_3=0$$, $$a_4$ = \frac{1}{16}$. これを$$n\geq 2$$について整理すると

- 初戦に勝った場合、$$n=  3k+2 (k = 0, 1, 2, ....)$$回目に優勝する. また、B, Cがそれまで2連勝しない場合に限るので, $$a_n = \frac{1}{2^n}$$
- 初戦に負けた場合、$$n=  3k+1 (k = 1, 2, ....)$$回目に優勝する. また、B, Cがそれまで2連勝しない場合に限るので, $$a_n = \frac{1}{2^n}$$
- $$3k$$ 回目の試合には出ることはないので$$ a_{n} = 0 \text{ s.t. } n = 3$$

よって、Aの優勝する確率は

$$
\sum_{n=2}^\infty a_n = \frac{\frac{1}{4}}{1 - \frac{1}{2}} - \frac{\frac{1}{8}}{1 - \frac{1}{8}} = \frac{5}{14}
$$

Bの優勝確率も同様に計算できる。

Cがn回目に優勝する確率を$$c_n$$とする。

- $$n=  3k+1 (k = 0, 1, 2, ....)$$回目に優勝することはできない, そもそも出番がない
- $$n=  3k+2 (k = 0, 1, 2, ....)$$回目に優勝することはできない, 試合をしたとしてもそれは1戦目
- $$n = 3k (k = 1, 2, ....)$$回目に優勝する確率は$$a_n = \frac{1}{2^{n-1}}$$

よって、Cの優勝する確率は

$$
\sum_{n=1}^\infty c_n = \frac{\frac{1}{4}}{1 - \frac{1}{8}} = \frac{2}{7}
$$

もちろん、

$$
\sum_{n=1}^\infty c_n = 1 - 2\sum_{n=1}^\infty a_n
$$

で計算しても良い.

<div style="text-align: right;">
■
</div>

### 解答(2)

[解答(1)の別解](#%E8%A7%A3%E7%AD%941%E5%88%A5%E8%A7%A3)を参照。

<div style="text-align: right;">
■
</div>

### 解答(3)

- 優勝に要する試合数の確率変数を$$X$$.
- A, B, Cがそれぞれ優勝する事象は排反
- $$a_n, b_n, c_n$$は $$n$$回目の試合でA, B, Cが優勝する確率
- $$a_n = b_n$$

このとき、優勝に要する試合数の期待値は

$$
\mathbf E[X] = \sum_{n = 2}^{\infty}n(a_n + b_n + c_n) = \sum_{n = 2}^{\infty}n(2a_n + c_n)
$$

と表せる。

このとき、[解答(1)の別解](#%E8%A7%A3%E7%AD%941%E5%88%A5%E8%A7%A3)より

$$
2a_n = 
\begin{cases}
\frac{1}{2^{n-1}} &\text{ if } n \text{ は３の倍数ではない}\\
0 &\text{ if } n \text{ は３の倍数}
\end{cases}
$$

かつ

$$
c_n =
\begin{cases}
\frac{1}{2^{n-1}} &\text{if } n \text{ は３の倍数}\\
0 &\text{if } n \text{ は３の倍数ではない}
\end{cases}
$$

なので、

$$d_n = \frac{1}{2^{n-1}}$$とすると


$$
\therefore \mathbf E[X] = \sum_{n = 2}^{\infty}nd_n = \sum_{n = 1}^{\infty}n\frac{1}{2^{n-1}}- 1 = 3
$$

<div style="text-align: right;">
■
</div>

### 解答(3)別解

A対CでAが勝てばチャンピオンが決まるし，Cが勝ってもA，B，Cの立場が入れ替わるだけで状況は変わらないことを考えると，これから先の何戦目くらいでチャンピオンが決まるかという数値を$$r$$とすれば

$$
r＝1＋r/2
$$

が成り立つ. 従って,$$r＝2$$が求まる。結局，これに最初にA，B，Cが決まるまでの1戦を加えて対戦回数の期待値は3。

<div style="text-align: right;">
■
</div>

### 解答(4)

解答(1)別解より、Aが優勝するときにBが対戦相手のときは、$$n=  3k+1 \:(k = 1, 2, ....)$$のときのみ。

求めたいものは

$$
\text{Pr(Bが対戦相手|3m回以内にAが優勝)} = \frac{\text{Pr(3m回以内にAが優勝, Bが対戦相手)}}{\text{Pr(3m回以内にAが優勝)}}
$$

各項について、

$$
\begin{aligned}
\text{Pr(3m回以内にAが優勝)} &= \sum_{m=1}^{3m}a_n\\
&= \sum_{m=2}^{3m}\frac{1}{2^m} - \sum_{m=1}^{m}\frac{1}{2^{3m}}\\
&= \frac{1}{2} - \frac{1}{2^{3m}} - \frac{1}{7}\left(1 - \frac{1}{8^m}\right)\\
&= \frac{5}{14} - \frac{6}{7}\frac{1}{8^m}
\end{aligned}
$$

および

$$
\begin{aligned}
\text{Pr(3m回以内にAが優勝, Bが対戦相手)} &= \sum_{m=1}^{m-1} a_{3m+1}\\
&= \sum_{m=1}^{m-1} \frac{1}{2^{3m+1}}\\
&= \frac{1}{14} - \frac{4}{7}\frac{1}{8^m}
\end{aligned}
$$

総試合数が $$3m$$ 回以下でAが優勝したとき,Bが対戦相手である確率を $$B_m$$とすると

$$
\begin{aligned}
\therefore B_m  &= \frac{ \frac{1}{14} -\frac{4}{7\cdot 8^m} }{ \frac{5}{14} -\frac{6}{7\cdot 8^m} } \\
&= \frac{ 8^m -8 }{ 5\cdot 8^m -12 } 
\end{aligned}
$$


<div style="text-align: right;">
■
</div>

### 解答(5)

$$p \in (0, 1)$$のとき、

$$
\frac{1}{(1-p)^2}=\sum_{x=1}^\infty xp^{x-1}
$$

この両辺を$$p$$で微分すると

$$
\frac{2}{(1-p)^3}=\sum_{x=2}^\infty x(x-1)p^{x-2}
$$

両辺に$$p$$を掛けると

$$
\frac{2p}{(1-p)^3}=\sum_{x=2}^\infty x(x-1)p^{x-1}
$$


優勝に要する試合数の確率変数を$$X$$をしたとき

$$
\mathbf V(X) = \mathbf E[X(X - 1)] + E(X) - E(X)^2
$$

従って、

$$
\begin{aligned}
\mathbf V(X) &= \sum_{x=2}^\infty x(x-1)\frac{1}{2^{x-1}} + 3 - 9\\
&= \frac{1}{(1/2)^3} - 6\\
&= 2
\end{aligned}
$$


<div style="text-align: right;">
■
</div>