---
layout: post
title: "数学的帰納法の原理"
subtitle: "数学の技法その１"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 
tags:

- math
---


||概要|
|---|---|
|目的|数学的帰納法の原理の紹介|
|参考|- [高校数学の美しい物語> 数学的帰納法のパターンまとめ](https://manabitimes.jp/math/644)<br>- [青空学園: 数学的帰納法](http://aozoragakuen.sakura.ne.jp/suuron/node5.html)<br>- [青空学園: 問題と考え方](http://aozoragakuen.sakura.ne.jp/houhou/houhou02/node20.html)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [数学的帰納法とは](#%E6%95%B0%E5%AD%A6%E7%9A%84%E5%B8%B0%E7%B4%8D%E6%B3%95%E3%81%A8%E3%81%AF)
  - [数学的帰納法の根拠](#%E6%95%B0%E5%AD%A6%E7%9A%84%E5%B8%B0%E7%B4%8D%E6%B3%95%E3%81%AE%E6%A0%B9%E6%8B%A0)
  - [例題](#%E4%BE%8B%E9%A1%8C)
- [累積帰納法](#%E7%B4%AF%E7%A9%8D%E5%B8%B0%E7%B4%8D%E6%B3%95)
  - [例題: 素因数分解の一意性](#%E4%BE%8B%E9%A1%8C-%E7%B4%A0%E5%9B%A0%E6%95%B0%E5%88%86%E8%A7%A3%E3%81%AE%E4%B8%80%E6%84%8F%E6%80%A7)
  - [例題その2](#%E4%BE%8B%E9%A1%8C%E3%81%9D%E3%81%AE2)
- [帰納法とガウスと素数定理](#%E5%B8%B0%E7%B4%8D%E6%B3%95%E3%81%A8%E3%82%AC%E3%82%A6%E3%82%B9%E3%81%A8%E7%B4%A0%E6%95%B0%E5%AE%9A%E7%90%86)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## 数学的帰納法とは

まず「帰納」とは多くの例を調べその間になり立つ法則を推測して きっとこうに違いなという「仮説」を立てることです。数学的帰納法とは

- 1のときはこうだ，2のときはこうだと調べていって 
- $$n$$ のときもこうに違いないと推測して仮説を立て， 
- $$n=1$$ で成立する． $$n=k$$ で成立すれば $$n=k+1$$ でも成立する． ゆえに任意の $$n$$ で成立することを証明する． 

以上が，数学的帰納法を使った証明方法の流れです。全ての自然数 $$n$$ に対して○○が成り立つことを証明せよ」というタイプの問題に有効です.

> 数学的帰納法の型

(1) $$p(1)$$ が成立する．<br>
(2) $$p(k)$$が成立するなら $$p(k+1)$$ が成立する．<br>
(3) (1), (2)より, すべての $$n$$ に対して $$p(n)$$が成立する．

> 数学的帰納法は演繹論理

帰納法とは、結果Bと、推論仮定である「AならばB」から、前提Aを推測するという論理です. 何回もの実験や実測を経て、だから前提Aは正しいに違いないという結論を出すものです. 例として、袋の中から何回玉を取り出しもいつも黒かった, なので袋の中の玉は全て黒いに違いない. 一方、数学的帰納法は、

- $$P(1)$$である. 
- $$P(k)$$ならば$$P(k+1)$$である.
- 従って、$$P(n)$$である

という構造なので、演繹的論理構造をしています. 

### 数学的帰納法の根拠

数学的帰納法の論証の進展を真理集合の面から説明します． 

- 条件 $$p(n)$$ の真理集合を$$M$$とする． つまり， $$M=\{n\ \vert\ p(n)が真,\ n \in \mathbb{N}\}$$

すべての自然数 $$n$$ で真であるということは， $$p(n)$$が真となるような$$n$$の集合$$M$$が自然数の集合$$\mathbb{N}$$と一致することです. 数学的帰納法は$$1\in M$$，及び$$k\in M$$なら$$k+1\in M$$が成り立つことを示しています.

- 自然数の集合というのは,「1があって$$k$$が要素であれば$$k+1$$も要素である」ような集合のうちでいちばん小さいものとして特徴づけられます．

この自然数の性質(最小性)によって，$$M$が$\mathbb{N}$$と一致します．従って、条件が成立する $$n$$ の集合 $$M$$ が自然数全体となり，すべての自然数 $$n$$ で成り立つという仕組みです.

### 例題

$$n$$ が正の整数のとき、等式

$$
1^2 + 2^2 + 3^2 + \cdots + (n-1)^2 + n^2 = \frac{1}{6}n(n+1)(2n+1)
$$

が成り立つことを示せ.

> 証明

$$n=1$$のとき、

$$
1 = \frac{1}{6}\times 2\times 3 = 1
$$

なので、目標の等式が成立します。

$$n=k$$ のとき目標の等式が正しいと仮定します. このとき、

$$
\begin{aligned}
\sum_{k}^{n+1} k^2 &= \sum_{k}^{n} k^2 + (n+1)^2\\
&= \frac{1}{6}n(n+1)(2n+1) + (n+1)^2\\
&= \frac{1}{6}(n+1)\{n(2n+1) + 6n + 6\}\\
&= \frac{1}{6}(n+1)(n+2)(2n+3)
\end{aligned}
$$

$$ n=k+1$$のときにも目標の等式が正しいことが確認できます。

よって，数学的帰納法により，全ての自然数 $$n$$ に対して目標の等式が正しいことが証明されました。


<div style="text-align: right;">
■
</div>

## 累積帰納法

基本的論法は以下です:

(1) $$P(1)$$は真である<br>
(2) 「$$P(1), P(2), \cdots, P(k)$$のすべてが真であれば、$$P(k+1)$$も真である」ということが、すべての正の整数$$n$$について正しい

### 例題: 素因数分解の一意性

2以上の任意の整数 $$n$$は、次の形で一意に表せることを示せ:

$$
n = p_1p_2\cdots p_r \: \text{(} r \text{は正の整数}, p_1p_2\cdots p_r \text{ は素数)}
$$

> 証明

(i) $$n=2$$について、２は素数なので $$n=2$$について等式及び一意性は成り立つ.

(ii) 2以上の整数 $$k$$について、$$P(1), P(2), \cdots, P(k)$$のすべてが真と仮定します.

$$k+1$$が素数のとき、問題文の等式が成立することは自明. 次に、$$k+1$$が素数でない(= 合成数)場合を考えます. 素数の定義から、$$k+1$$は $$1$$ 以外の $$k+1$$ 未満の整数を約数にもちます. その約数の一つを $$d_1$$ と定めます.　このとき、

$$
d_2  = \frac{k+1}{d_1} \:\text{ where } \: d_2\in \mathbf{N}
$$

ここで、仮定より$$d_1, d_2$$はそれぞれ以下のように表せる

$$
\begin{aligned}
d_1 &= a_1\cdots a_r\\
d_2 &= b_1\cdots b_s
\end{aligned}
$$

ここで、$$s, r$$はそれぞれ正の整数. $$a_i, b_j \: i \in \{1, \cdots, r\} \: j \in \{1, \cdots, s\}$$は素数. したがって,

$$
k+1 = d_1d_2 = a_1\cdots a_r b_1\cdots b_s
$$

つぎに、分解の一意性を示す． $$k+1$$を素因数分解して２つの分解

$$
k+1=p_1p_2\cdots p_m=q_1q_2\cdots q_n
$$

を得たとする. 二つの整数の積が素数 $$p$$ で割り切れるなら， 因数のなかの少なくとも一つがその素数で割り切れるので、$$p_1,\ p_2,\ \cdots,\ p_m$$ のいずれかは $$q_1$$ で割り切れる．いま $$p_1$$ が $$q_1$$ で割りきれるとすれば, $$p_1$$ は素数なので, $$p_1=q_1$$ である． 

$$
\therefore \: p_2\cdots p_m = q_2\cdots q_n
$$

この両辺の数を $$b$$ とすれば $$b < k+1$$より、数学的帰納法の仮定からこの分解は順序を除いて一意である．

したがって、$$P(1), P(2), \cdots, P(k)$$のすべてが真であれば、$$P(k+1)$$も真。以上より、すべての正の整数 $$n$$ について$$P(n)$$は真.

<div style="text-align: right;">
■
</div>

### 例題その2

数列 $$\{ a_n \}$$ を

$$
a_0=1,\ a_n=\sum_{k=1}^n3^ka_{n-k} \quad (n=1,\ 2,\ \cdots)
$$

で定める.数列 $$\{ a_n \}$$ の一般項 $$a_n$$ を求めよ. 

> 解

$$n = 1, 2, 3$$について調べる.

$$
\begin{aligned}
a_1 &= 3\\
a_2 &= 3a_1 + 9a_0 = 18\\
a_3 &= 3a_2 + 9a_1 + 27a_0 = 108
\end{aligned}
$$

となるので $$a_n=3\cdot6^{n-1}(n=1,\ 2,\ \cdots)$$ と推測される. これを数学的帰納法で示す. 

(i) $$n=1$$ のとき， $$a_1=3$$ より成立.<br>
(ii) $$n=1,\ 2,\ \cdots,\ m$$ で成立するとする. このとき 

$$
\begin{aligned}
a_{m+1}=& \sum_{k=1}^{m+1}3^k a_{m+1-k}\\ 
=&\sum_{k=1}^m 3^k \cdot 3 \cdot 6^{m-k} + 3^{m+1}\\
=& 3^{m+1} \sum_{k=1}^m 2^{m-k} + 3^{m+1}\\
=& 3\cdot6^m 
\end{aligned}
$$

よって $$n=m+1$$ でも成立する. 以上から $$n=1,\ 2,\ \cdots$$ に対し $$a_n=3\cdot6^{n-1}$$ が示された. 

ゆえに一般項は 

$$
a_n= \left\{ \begin{array}{ll} 1&(n=0)\\ 3\cdot6^{n-1}&(n\ge 1) \end{array}\right. 
$$

である．


<div style="text-align: right;">
■
</div>

## 帰納法とガウスと素数定理

上でも書きましたが、帰納法とは、結果Bと、推論仮定である「AならばB」から、前提Aを推測するという論理です. 何回もの実験や実測を経て、だから前提Aは正しいに違いないという結論を出すものです. 帰納法を用いて、数学の大定理の一つ, 素数定理を推測した人物がガウスです.

素数定理とは,正の実数$$x$$を越えない素数の個数を$$\pi(x)$$と表したとき、

$$
pi(x)\sim \frac{x}{\log x}
$$

少し言い換えると$$x$$近くの自然数が素数である確率は$$1/\log x$$になるということになります.

ガウスは素数表を前にして、素数が表れる頻度が次第に減少していくことを系統立てて調べようとしました.10万までの数を100ずつ及び1000ずつの区間に分けて素数の個数を計算してリストアップしていき、素数の出現は不規則であってもその頻度は平均的には対数に反比例していると予測しました. $$n$$以下の素数の個数は

$$
\int \frac{dn}{\log n}
$$

と予測し、素数表や素数を数え上げてこの予測が正しい否か検証していきました.