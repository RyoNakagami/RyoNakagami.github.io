---
layout: post
title: "RSA公開鍵暗号方式の仕組み"
subtitle: "RSAとEuler's totient function"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- RSA
- 公開鍵暗号方式
- 素数
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
|目的|RSA公開鍵暗号方式の仕組み|
|参考|- [【図解】初心者も分かる”公開鍵/秘密鍵”の仕組み～公開鍵暗号方式の身近で具体的な利用例やメリット〜](https://milestone-of-se.nesuke.com/sv-advanced/digicert/public-private-key/)<br>- [wolfram.com: TotientFunction](https://mathworld.wolfram.com/TotientFunction.html)<br>- [高校数学の美しい物語: フェルマーの小定理の証明と例題](https://mathtrain.jp/fermat_petit)<br>- [ucdenver lecture note](http://www-math.ucdenver.edu/~wcherowi/courses/m5410/ctcrsa.html)<br>- [RSA暗号のpython実装](https://banboooo.hatenablog.com/entry/2018/07/12/162800)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. コンピューターがインターネットを介して機密情報の通信を行うとは？](#1-%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%8C%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%8D%E3%83%83%E3%83%88%E3%82%92%E4%BB%8B%E3%81%97%E3%81%A6%E6%A9%9F%E5%AF%86%E6%83%85%E5%A0%B1%E3%81%AE%E9%80%9A%E4%BF%A1%E3%82%92%E8%A1%8C%E3%81%86%E3%81%A8%E3%81%AF)
  - [RSA公開鍵暗号方式の概要](#rsa%E5%85%AC%E9%96%8B%E9%8D%B5%E6%9A%97%E5%8F%B7%E6%96%B9%E5%BC%8F%E3%81%AE%E6%A6%82%E8%A6%81)
  - [RSAの仕組み](#rsa%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [AさんからBさんに秘密のメッセージを送る方法](#a%E3%81%95%E3%82%93%E3%81%8B%E3%82%89b%E3%81%95%E3%82%93%E3%81%AB%E7%A7%98%E5%AF%86%E3%81%AE%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%82%92%E9%80%81%E3%82%8B%E6%96%B9%E6%B3%95)
  - [RSA暗号の数値例](#rsa%E6%9A%97%E5%8F%B7%E3%81%AE%E6%95%B0%E5%80%A4%E4%BE%8B)
- [2. Euler's Totient Function: オイラーのトーシェント関数](#2-eulers-totient-function-%E3%82%AA%E3%82%A4%E3%83%A9%E3%83%BC%E3%81%AE%E3%83%88%E3%83%BC%E3%82%B7%E3%82%A7%E3%83%B3%E3%83%88%E9%96%A2%E6%95%B0)
  - [証明](#%E8%A8%BC%E6%98%8E)
  - [Proof of sketch: 因数のふるいのイメージ](#proof-of-sketch-%E5%9B%A0%E6%95%B0%E3%81%AE%E3%81%B5%E3%82%8B%E3%81%84%E3%81%AE%E3%82%A4%E3%83%A1%E3%83%BC%E3%82%B8)
  - [Implementation](#implementation)
- [3. Euler's Theorem: オイラーの定理](#3-eulers-theorem-%E3%82%AA%E3%82%A4%E3%83%A9%E3%83%BC%E3%81%AE%E5%AE%9A%E7%90%86)
  - [定理：フェルマーの小定理](#%E5%AE%9A%E7%90%86%E3%83%95%E3%82%A7%E3%83%AB%E3%83%9E%E3%83%BC%E3%81%AE%E5%B0%8F%E5%AE%9A%E7%90%86)
    - [証明](#%E8%A8%BC%E6%98%8E-1)
  - [系２：フェルマーの小定理](#%E7%B3%BB%EF%BC%92%E3%83%95%E3%82%A7%E3%83%AB%E3%83%9E%E3%83%BC%E3%81%AE%E5%B0%8F%E5%AE%9A%E7%90%86)
    - [証明：数学的帰納法](#%E8%A8%BC%E6%98%8E%E6%95%B0%E5%AD%A6%E7%9A%84%E5%B8%B0%E7%B4%8D%E6%B3%95)
    - [証明：フェルマーの小定理より](#%E8%A8%BC%E6%98%8E%E3%83%95%E3%82%A7%E3%83%AB%E3%83%9E%E3%83%BC%E3%81%AE%E5%B0%8F%E5%AE%9A%E7%90%86%E3%82%88%E3%82%8A)
  - [系３：フェルマーの小定理の補題](#%E7%B3%BB%EF%BC%93%E3%83%95%E3%82%A7%E3%83%AB%E3%83%9E%E3%83%BC%E3%81%AE%E5%B0%8F%E5%AE%9A%E7%90%86%E3%81%AE%E8%A3%9C%E9%A1%8C)
    - [証明](#%E8%A8%BC%E6%98%8E-2)
  - [オイラーの定理の証明](#%E3%82%AA%E3%82%A4%E3%83%A9%E3%83%BC%E3%81%AE%E5%AE%9A%E7%90%86%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [まとめ：オイラーの定理から得られる系](#%E3%81%BE%E3%81%A8%E3%82%81%E3%82%AA%E3%82%A4%E3%83%A9%E3%83%BC%E3%81%AE%E5%AE%9A%E7%90%86%E3%81%8B%E3%82%89%E5%BE%97%E3%82%89%E3%82%8C%E3%82%8B%E7%B3%BB)
- [4. RSAの仕組み：数式編](#4-rsa%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF%E6%95%B0%E5%BC%8F%E7%B7%A8)
  - [public number $n_U$の選び方](#public-number-n_u%E3%81%AE%E9%81%B8%E3%81%B3%E6%96%B9)
  - [public number $e_U$の選び方](#public-number-e_u%E3%81%AE%E9%81%B8%E3%81%B3%E6%96%B9)
  - [private number $d_U$の選び方](#private-number-d_u%E3%81%AE%E9%81%B8%E3%81%B3%E6%96%B9)
  - [RSA公開鍵暗号方式のdecode: 公開鍵で暗号化](#rsa%E5%85%AC%E9%96%8B%E9%8D%B5%E6%9A%97%E5%8F%B7%E6%96%B9%E5%BC%8F%E3%81%AEdecode-%E5%85%AC%E9%96%8B%E9%8D%B5%E3%81%A7%E6%9A%97%E5%8F%B7%E5%8C%96)
  - [RSA公開鍵暗号方式のdecode: 秘密鍵で暗号化](#rsa%E5%85%AC%E9%96%8B%E9%8D%B5%E6%9A%97%E5%8F%B7%E6%96%B9%E5%BC%8F%E3%81%AEdecode-%E7%A7%98%E5%AF%86%E9%8D%B5%E3%81%A7%E6%9A%97%E5%8F%B7%E5%8C%96)
  - [なぜ素因数分解のスピードがRSA公開鍵暗号法のセキュリティと関係するのか](#%E3%81%AA%E3%81%9C%E7%B4%A0%E5%9B%A0%E6%95%B0%E5%88%86%E8%A7%A3%E3%81%AE%E3%82%B9%E3%83%94%E3%83%BC%E3%83%89%E3%81%8Crsa%E5%85%AC%E9%96%8B%E9%8D%B5%E6%9A%97%E5%8F%B7%E6%B3%95%E3%81%AE%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3%E3%81%A8%E9%96%A2%E4%BF%82%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)
- [5. RSAの実装: Python編](#5-rsa%E3%81%AE%E5%AE%9F%E8%A3%85-python%E7%B7%A8)
  - [基本方針](#%E5%9F%BA%E6%9C%AC%E6%96%B9%E9%87%9D)
  - [実装](#%E5%AE%9F%E8%A3%85)
  - [実行](#%E5%AE%9F%E8%A1%8C)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. コンピューターがインターネットを介して機密情報の通信を行うとは？

Amazon.comで何かしらの商品を注文したいとします。このとき、商品をカートに入れたあとに決済というプロセスをしなくてはいけませんが、クレジットカード情報のやり取りをOver the Internetで自分のラップトップとAmazonのサーバーの間で実施する必要があります。Over the Internetでやり取りすると、ルーターと呼ばれる無数のコンピューターを経由して、自分のラップトップからAmazonのサーバーに情報が送られるため、ルーターにアクセスできるあらゆる人が情報を覗く（ときには改変する）ことができてしまいます。例えるなら、クレジットカード情報を封のされていない葉書でやり取りするようなものです。葉書を２つの住所間で郵送するとき、複数の配達人を経由して送られるので、葉書に書かれた内容は郵便配達員に見られてしまうリスクがあります。

この問題の一つの解決方法として、予めAmazonサーバーと自分のラップトップの間で他の人には秘密の符牒（二人だけに共有された秘密）を使ってメッセージを暗号化してOver the Internetでやり取りをしたり、VPNを張ってやり取りをするという手法が考えられます。しかし、(1) 一番最初に秘密の符牒をどのように共有するのか, (2) 他の人にバレないようにVPNの設定をどのように実施すればよいのかという問題が生まれてしまいます。

結局、見知らぬ人同士の間でオープンな場でどのように「共有された秘密」を確立するのか？が問題になります。この一つの解決方法がRSA公開鍵暗号方式です。

### RSA公開鍵暗号方式の概要

特定のサーバ A がRSA秘密鍵を持ち、任意のクライアントがその対となるRSA公開鍵 (サーバ A のRSA公開鍵) を持っているとします。RSA公開鍵を使って暗号化するとRSA秘密鍵でのみ復号できます。RSA秘密鍵は原則サーバ A 以外には知られないため、サーバ A のみが復号でき、機密性が確保できます。逆に、RSA秘密鍵を使って暗号化すると、RSA公開鍵でのみ復号できます。RSA公開鍵は広く知られる前提であるため、機密性の確保はできませんが、「サーバ A のRSA公開鍵で復号できた」通信というのは、「発信源が間違いなくサーバ A であり、内容は改竄されていない」という完全性・真正性が確保できます。後者はデジタル署名で主に用いられます。

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210304_RSA_how_it_works.webp">

### RSAの仕組み

RSAの仕組み自体はシンプルです。ここでは二人のユーザー(AさんとBさん)の間でRSA公開鍵暗号方式に則ったやり取りをする場面を考えます。まずそれぞれのユーザーは３つの数を指定します。

|数|説明|
|---|---|
|$$e_u$$|public, uはユーザーindexを示す, 正の整数|
|$$n_u$$|public, 正の整数|
|$$d_u$$|private, 正の整数|

### AさんからBさんに秘密のメッセージを送る方法

AさんからBさんに数値$$m$$というメッセージを送りたいとします。このとき、AさんはBさんが公開している$$e_B$$と$$n_B$$をまず確認します。$$m$$が$$n_B$$より小さいことを確認した後、次の数$$c$$を計算します。

$$
\begin{aligned}
c = m^{e_B} \text{ mod } n_B
\end{aligned}
$$

そして、$$c$$をBさんに送ります。Bさんは$$c$$を次のようにしてdecodeします。

$$
\begin{aligned}
m = c^{d_B} \text{ mod } n_B
\end{aligned}
$$

以上がRSA公開鍵暗号方式を用いたやりとりです。しかし、$$e_u$$, $$n_u$$, $$d_u$$をどのように選ぶのかが疑問として残ります。任意の数ではここで紹介したやり取りは成立しません。これら数の選び方を理解するためには、Euler's Totient Functionとオイラーの定理を理解する必要があります。

### RSA暗号の数値例 

$$(e, n, d) = (13, 33, 17)$$とします。このとき、

$$
\phi(33) = 20
$$

メッセージ$$x$$をおくるとき、まずRSA公開鍵暗号で暗号化します。

$$
m \equiv x^{13} (\:\mathrm{mod}\:33)
$$

これを復号化するとき

$$
m^{17} \equiv (x^{13})^{17} \equiv x^{20\times 11 + 1} \equiv x^{11\times \phi(33) + 1} \equiv x (\:\mathrm{mod}\:33)
$$


## 2. Euler's Totient Function: オイラーのトーシェント関数

任意の自然数$$n$$について、Euler's Totient Function $$\phi(n)$$はn以下の自然数についてnと互いに素となる自然数(1を含む)の個数となります。

<div class="math display" style="overflow: auto">
$$
\begin{array}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|}
\hline
n & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 & 21 \\ \hline
\phi(n) & 1 & 1 & 2 & 2 & 4 & 2 & 6 & 4 & 6 & 4 & 10 & 4 & 12 & 6 & 8 & 8 & 16 & 6 & 18 & 8 & 12 \\ \hline
\end{array}
$$
</div>

Euler's Totient Functionは以下のような性質を持ちます。

<div class="math display" style="overflow: auto">
$$
\phi(n) = n \displaystyle \prod_{p\in S}\left(1 - \frac{1}{p}\right) \text{ where } S = \{s| s \text{ is prime factors of } n\}
$$
</div>

### 証明

(i) 素数$$p$$についてのEuler's Totient Functionを計算します。

$$gcd(p, q) = 1$$ for all $$1 \leq q < p$$より

$$
\phi(p) = p - 1
$$


(ii) 素数$$p$$、$$k \geq 1$$となる自然数$$p^k$$について考えます。

$$p$$で割り切れる数の個数は$$p^k/p = p^{k-1}$$個となる。よって、

$$
\phi(p^k) = p^k - p^{k-1}
$$

(iii) 異なる素数$$a, b$$についてEuler Totient関数の乗法性を示します

$$
\phi(a^xb^y) = \phi(a^x)\phi(b^y)\: \text{ ただし SSx, ySS は正の整数}
$$

一般性を失うことなく、$$a< b$$とする。$$a^xb^y$$以下の正の整数を小さい方から、１行にa個づつならべます:

$$
\begin{array}{ccccc}
1 & 2 &\cdots & a^x-1 & a\\
1 + a & 2 + a & \cdots & 2a-1 & 2a\\
\vdots &\vdots &\vdots &\vdots &\vdots \\
1 + (b-1)a & 2+ (b-1)a& \cdots & ab- 1 & ab\\
\vdots &\vdots &\vdots &\vdots &\vdots \\
1 + (a^{x-1}b^y-1)a & 2+ (a^{x-1}b^y-1)a& \cdots & a^xb^y- 1 & a^xb^y
\end{array}
$$

$$ab$$までの各行で$$a$$と互いに素ではない整数の個数は1つのみ存在します。同様に$$ab$$までの各列について$$b$$と互いに素ではない整数の個数は1つのみ存在します。一方、$$ab$$以下の整数につき、$$a$$と$$b$$両方と素ではない正の整数は1個のみとなります。よって、$$ab$$以下の整数について、$$a^xb^y$$と互いに素な整数の個数は

$$
ab - a - b + 1 = (a-1)(b-1)=\phi(a)\phi(b)
$$

となります。$$ab+1$$から$$2ab$$に関しても同様に$$\phi(a)\phi(b)$$個の$$a^xb^y$$と互いに素な整数が存在します。よって、$$a^xb^y$$以下の正の整数について、$$a^xb^y$$と互いに素な整数の個数は

<div class="math display" style="overflow: auto">
$$
\phi(a^xb^y) = a^{x-1}b^{y-1}\phi(a)\phi(b) = (a^x - a^{x-1})(b^y - b^{y-1}) = \phi(a^x)\phi(b^y)
$$
</div>

となることがわかります。


(i), (ii), (iii)を踏まえると、$$n = {p_1}^{a_1} \cdot {p_2}^{a_2} \cdots {p_k}^{a_k}$$について

<div class="math display" style="overflow: auto">

$$
\begin{aligned}
\phi (n) &= \phi ({p_1}^{a_1}) \cdot \phi ({p_2}^{a_2}) \cdots  \phi ({p_k}^{a_k}) \\
&= \left({p_1}^{a_1} - {p_1}^{a_1 - 1}\right) \cdot \left({p_2}^{a_2} - {p_2}^{a_2 - 1}\right) \cdots \left({p_k}^{a_k} - {p_k}^{a_k - 1}\right) \\
&= p_1^{a_1} \cdot \left(1 - \frac{1}{p_1}\right) \cdot p_2^{a_2} \cdot \left(1 - \frac{1}{p_2}\right) \cdots p_k^{a_k} \cdot \left(1 - \frac{1}{p_k}\right) \\
&= n \cdot \left(1 - \frac{1}{p_1}\right) \cdot \left(1 - \frac{1}{p_2}\right) \cdots \left(1 - \frac{1}{p_k}\right)
\end{aligned}
$$

</div>

<div style="text-align: right;">
■
</div>




### Proof of sketch: 因数のふるいのイメージ

$$n = {p_1}^{a_1} \cdot {p_2}^{a_2} \cdots {p_k}^{a_k}$$とします。まず$$p_1$$と素のになる個数をカウントすると、

$$
\begin{aligned}
\phi_{p_1}(n) & = n - \frac{n}{p_1} = n\left(1-\frac{1}{p_1}\right)
\end{aligned}
$$

つぎに$$p_2$$と互いに素となる数のカウントも加味するとなると、

$$
\phi_{p_2}(n)  = n - \frac{n}{p_2}
$$

を引きたいところですが、$$p_1p_2$$というlcmを考慮する必要があるので

$$
\begin{aligned}
\phi_{p_1, p_2}(n) & = n - \frac{n}{p_1} - (n - \frac{n}{p_2}) + (n - \frac{n}{p_1p_2})\\
&= n\left(1-\frac{1}{p_1}\right)\left(1-\frac{1}{p_2}\right)
\end{aligned}
$$

以下同様の工程を繰り返すことで


$$
\phi(n) = n \displaystyle \prod_{p|n}\left(1 - \frac{1}{p}\right) 
$$



### Implementation

```c
int phi(int n) {
    int result = n;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            while (n % i == 0)
                n /= i;
            result -= result / i;
        }
    }
    if (n > 1)
        result -= result / n;
    return result;
}
```

## 3. Euler's Theorem: オイラーの定理

オイラーの定理とは、$$a$$と$$n$$を互いに素な自然数としたとき, i.e., $$gcd(a, n)=1$$、

$$
a^{\phi(n)}\equiv 1 \:\mathrm{mod}\:n
$$

これを証明する前にまずフェルマーの小定理の確認します。

### 定理：フェルマーの小定理

$$p$$ が素数で，自然数$$a$$ が $$p$$ と互いに素な自然数のとき

$$
a^{p-1}\equiv 1\:\mathrm{mod}\:p
$$

#### 証明

$$a, 2a, ..., (p-1)a$$を取ると、これらはいずれも$$p$$を法として合同にならない。なぜなら、もしも$$p-1$$以下の相異なる自然数$$r, s$$に対して

$$
ra \equiv sa\:\mathrm{mod}\:p
$$

となったとすると

$$
(r-s)a \equiv 0\:\mathrm{mod}\:p \Rightarrow p\mid(r-s)a
$$

$$p$$と$$a$$は互いに素なので $$p\mid(r-s)$$ とならなけらばならない。しかし、$$r,s$$は$$p-1$$なのでこれは矛盾。したがって、$$a, 2a, ..., (p-1)a$$はいずれも$$p$$を法として合同にならない、つまり、pで割ったときのあまりはすべて異なるとわかる。よって

$$
a^{p-1}(p-1)!\equiv (p-1)!\:\mathrm{mod}\:p
$$

素数$$p, (p-1)!$$は互いに素なので、両辺を$$(p-1)!$$で割ると、

$$
a^{p-1}\equiv 1\:\mathrm{mod}\:p
$$

<div style="text-align: right;">
■
</div>

### 系２：フェルマーの小定理

$$p$$ が素数，$$a$$ が任意の自然数のとき

$$
a^{p}\equiv a \:\mathrm{mod}\:p
$$

#### 証明：数学的帰納法

$$a=1$$のときは明らかに$$a^p\equiv a\:\mathrm{mod}\:p$$
つぎに$$a = m$$のとき、命題が成立するとする。このとき、

$$
(m+1)^p = m^p + 1 + \sum_{i=1}^{p-1} \:_pC_i m^i \equiv m+1
$$

よって、$$m^p\equiv m$$ならば$$(m+1)^p\equiv m+1$$。以上から数学的帰納法よりすべての$$a$$に対して

$$
a^{p}\equiv a \:\mathrm{mod}\:p
$$

<div style="text-align: right;">
■
</div>

#### 証明：フェルマーの小定理より

$$\text{gcd}(p, a) = p$$ならば自明。$$\text{gcd}(p, a) = 1$$ならばフェルマーの小定理より

$$
a^{p-1} \equiv 1 \:\mathrm{mod}\:p
$$

両辺に$$a$$をかけると

$$
a^p \equiv a \:\mathrm{mod}\:p
$$

<div style="text-align: right;">
■
</div>

### 系３：フェルマーの小定理の補題

$$p$$を素数とし，$$a$$を$$p$$と互いに素な整数とすると，任意の自然数$$n$$に対して

$$
a^{(p-1)p^{n-1}}\equiv 1\:\mathrm{mod}\:p^n
$$

#### 証明

$$n$$に関する数学的帰納法を用いる．$$n = 1$$のときは上で示したフェルマーの定理そのものである．$$n$$のとき成り立つと仮定すると

$$
a^{(p-1)p^{n-1}} = 1 + p^nk  \: (k\in \mathbb Z)
$$


これに対してp乗すると

<div class="math display" style="overflow: auto">

$$
a^{(p-1)p^n} = 1 + p\cdotp^nk + \sum_{j=2}^p\:_pC_j (p^nk)^j \equiv 1\:\mathrm{mod}\: p^{n+1}
$$

</div>

以上から数学的帰納法よりすべてのnについて成立する。

<div style="text-align: right;">
■
</div>

### オイラーの定理の証明

$$n$$を素因数分解して$$n = {p_1}^{b_1} \cdot {p_2}^{b_2} \cdots {p_k}^{b_k}$$とします。$$gcd(a, n)=1$$よりfor all $$p_j \in \{p_1, ..., p_k\}, gcd(a, p_j)=1$$

フェルマーの小定理の補題より

$$
a^{p_j^{b_j}-p_j^{b_j-1}} = a^{\phi(p_j^{b_j})} \equiv 1 \:\mathrm{mod}\: p_j^{b_j}
$$

オイラーのトーシェント関数の性質より、$$\phi(n)$$は$$\phi(p_j^{b_j})$$の倍数で、各$$j$$について上の合同式は成立するので、

$$
a^{\phi(n)}\equiv 1 \:\mathrm{mod}\:n
$$

<div style="text-align: right;">
■
</div>

### まとめ：オイラーの定理から得られる系

(1) 合同式のべき乗の性質

$$
a\equiv b \Rightarrow a^n\equiv b^n
$$

(2) 合同式の積

$$
a\equiv b, c\equiv d \Rightarrow ac\equiv bd
$$

の２つより, 任意の整数tについて, nがa product of distinct primesならば

$$
a^{1+t\phi(n)}\equiv a \:\mathrm{mod}\:n
$$

## 4. RSAの仕組み：数式編

前準備が整ったので、$$e_u$$, $$n_u$$, $$d_u$$をどのように選び方とdecodeの仕組みを以下解説します。

### public number $n_U$の選び方

まず任意に２つ以上の秘密の素数$$(p_1, ..., p_n)$$を選びます。そして、

$$
n_u = \displaystyle \prod_{1\leq i\leq n}p_i
$$

と設定します。

以下、単純化のため

$$
n_u = pq \:　p, q\text{は素数}
$$

とします。
### public number $e_U$の選び方

オイラーのトーシェント関数の性質より$$\phi(n_U)=(p-1)(q-1)$$です。

つぎに、以下の２つの条件を満たす数を$$e_U$$として設定します。

1. $$1 < e_U < \phi(n_U)$$
2. $$gcd(e_U, \phi(n_U)) = 1$$

### private number $d_U$の選び方

以下の条件を満たす$d_U$を選びます。

$$
e_U\cdot d_U \equiv 1 \:\mathrm{mod}\:\phi(n_U)
$$

この問題は

$$
e_Ud_u + v\phi(n_u) = 1
$$

を満たす$$(d_U, v)$$の組を見つける問題に変換することができます。今回、$$(e_U, \phi(n_U))$$は互いの素なので[拡張ユークリッド互除法](https://ryonakagami.github.io/2021/04/08/Euclidean-Algorithm/#2-%E6%8B%A1%E5%BC%B5%E3%83%A6%E3%83%BC%E3%82%AF%E3%83%AA%E3%83%83%E3%83%89%E4%BA%92%E9%99%A4%E6%B3%95)を用いることで候補を見つけることができます。

### RSA公開鍵暗号方式のdecode: 公開鍵で暗号化

上で見たようにBさんのRSA公開鍵を用いてAさんがメッセージ$$m$$をBさんに送ることを考えます。(1)合同式の性質, (2) private number $d_U$の選び方より

$$
\begin{aligned}
c^{d_B} &\equiv (m^{e_B})^{d_B}\equiv m^{1+r\phi(n_B)} \equiv m \:\mathrm{mod}\:n_B
\end{aligned}
$$

### RSA公開鍵暗号方式のdecode: 秘密鍵で暗号化

上で見たようにBさんのRSA秘密鍵を用いてBさんがメッセージ$$x < n_B$$をAさんに送ることを考えます。これはデジタル署名の相当します。まず

$$
y  = x^{d_B} \:\mathrm{mod}\:n_B
$$

を計算します。つぎにAさんが$$y$$を受け取った後、$$e_B$$を用いて復号化します。

$$
\begin{aligned}
y^{e_B} &\equiv (x^{d_B})^{e_B}\equiv x^{d_Be_B} \equiv x^{1+z\phi(n_B)} \equiv x \:\mathrm{mod}\:n_B
\end{aligned}
$$

### なぜ素因数分解のスピードがRSA公開鍵暗号法のセキュリティと関係するのか

RSA公開鍵暗号法で$$d_U$$は決して知らてはいけない数ですが、

$$
e_U\cdot d_U \equiv 1 \:\mathrm{mod}\:\phi(n_U)
$$

が計算できれば簡単に知ることができます。しかし、$$\phi(n_U)$$は$$n_U$$を知っていても素因数分解を実行することに時間がかかるので簡単に計算することができません。そのため、$$d_U$$を悪意のある外部の人は容易に知ることができません。逆に、素因数分解が一瞬できるようになると、$$d_U$$を推定することは簡単になります。

## 5. RSAの実装: Python編
### 基本方針

1. エラストテネスのふるいを用いてランダムに1000以上10000未満の素数を２つ$$(p, q)$$選ぶ
2. public number $$n = pq$$を計算する
3. $$\phi(n_U) = (p-1)(q-1)$$を計算する
4. public number $$e$$を計算する
5. $$e\cdot d \equiv 1 \:\mathrm{mod}\:\phi(n)$$に従ってprivate number $d$を計算する

### 実装

```python
import random

class RSA_in_practice:
    def __init__(self, lower, upper):
      self.__p,self.__q = self.__sieve_of_Eratosthenes(lower, upper)
      self.__d,self.e,self.n = self.__makeKeys()

    def __gcd (self,a,b):
      if a < b:
          a,b = b,a
      return a if b == 0 else self.__gcd(b,a%b)
    
    def __extended_euclid(self,a,b):
      cc = gg = 1
      ee = ff = 0
      while b:
          div,mod = divmod(a,b)
          hh = cc - div * ee
          ii = ff - div * gg
          a,b = b,mod
          cc,ee = ee,hh
          ff,gg = gg,ii
      return cc
    
    def __sieve_of_Eratosthenes(self, lower_num, upper_num):
        num_list = [0 if i % 2 == 0 else i for i in range(0, upper_num)]
        num_list[2] = 2
        prime = 3
        while prime **2 < upper_num:
            if num_list[prime]:
                for i in range(prime*2, upper_num, prime):
                    num_list[i] = 0
            prime += 2
        
        num_list = [s for s in num_list if s != 0 and s > lower_num]
        return random.sample(num_list, 2)
    
    def __choose_public_e(self, phi_n):
        candidate_array = [i for i in range(2, phi_n)]
        random.shuffle(candidate_array)

        for i in range(len(candidate_array)):
            if self.__gcd(candidate_array[i], phi_n) == 1:
                return candidate_array[i]

    def __makeKeys(self):
        n = self.__p * self.__q
        phi = (self.__p - 1) * (self.__q - 1)
        e = self.__choose_public_e(phi_n = phi)
        d = self.__extended_euclid(e,phi)
        if d <= 0:
            	d += phi
        return d,e,n
    
    def encode(self, encoded_message_with_number):
        if encoded_message_with_number > self.n:
            print("x must be under {0}".forat(self.n))
            exit(1)
        return pow(encoded_message_with_number, self.e, self.n)
    
    def decode(self,encoded_message):
        return pow(encoded_message, self.__d, self.n)
    
    def encode_str(self,message):
      encoded_message = []
      for i in range(len(message)):
            encoded_message.append(self.encode(ord(message[i])))
      return encoded_message
    
    def decode_str(self, decoded_message_with_number):
      decoded_message = []
      for i in range(len(decoded_message_with_number)):
        decoded_message.append(chr(self.decode(decoded_message_with_number[i])))
      return "".join(decoded_message)
```

### 実行

```python
random.seed(42)
rsa_instance = RSA_in_practice(100, 1000) 

## RSA公開鍵
print("public key e is %d\npublic key n is %d\n" % (rsa_instance.e, rsa_instance.n))

## メッセージの定義
message = "Telling People You Drive a Nissan Almera Is Like Telling Them You’ve Got The Ebola Virus And You’re About To Sneeze."
print(message)

## メッセージの暗号化
encoded_message = rsa_instance.encode_str(message)
print("\nMr. A sent the following message; ")
print(encoded_message)

## メッセージの復号化
decoded_message = rsa_instance.decode_str(encoded_message)
print("\n"+decoded_message) # "Hello"に戻る
print("\nMessage Consistency: %r" % (message == decoded_message))
```

Then, 

```
public key e is 25383
public key n is 32881

Telling People You Drive a Nissan Almera Is Like Telling Them You’ve Got The Ebola Virus And You’re About To Sneeze.

Mr. A sent the following message; 
[9746, 13911, 16671, 16671, 32431, 11030, 13140, 29756, 3969, 13911, 17246, 14097, 16671, 13911, 29756, 1237, 17246, 24664, 29756, 15529, 23157, 32431, 11778, 13911, 29756, 20228, 29756, 28497, 32431, 8118, 8118, 20228, 11030, 29756, 25400, 16671, 13272, 13911, 23157, 20228, 29756, 19990, 8118, 29756, 30290, 32431, 1933, 13911, 29756, 9746, 13911, 16671, 16671, 32431, 11030, 13140, 29756, 9746, 21108, 13911, 13272, 29756, 1237, 17246, 24664, 14285, 11778, 13911, 29756, 5064, 17246, 25764, 29756, 9746, 21108, 13911, 29756, 22419, 4127, 17246, 16671, 20228, 29756, 22994, 32431, 23157, 24664, 8118, 29756, 25400, 11030, 19378, 29756, 1237, 17246, 24664, 14285, 23157, 13911, 29756, 25400, 4127, 17246, 24664, 25764, 29756, 9746, 17246, 29756, 7315, 11030, 13911, 13911, 13621, 13911, 29248]

Telling People You Drive a Nissan Almera Is Like Telling Them You’ve Got The Ebola Virus And You’re About To Sneeze.

Message Consistency: True
```








