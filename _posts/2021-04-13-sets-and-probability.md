---
layout: post
title: "集合と確率"
subtitle: "ポーカーの手札の確率"
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
|目的|集合と確率の勉強用ノート　and ポーカーの手札の確率の計算|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [事象と集合](#%E4%BA%8B%E8%B1%A1%E3%81%A8%E9%9B%86%E5%90%88)
  - [集合演算の基礎](#%E9%9B%86%E5%90%88%E6%BC%94%E7%AE%97%E3%81%AE%E5%9F%BA%E7%A4%8E)
  - [Laplaceによる確率の定義](#laplace%E3%81%AB%E3%82%88%E3%82%8B%E7%A2%BA%E7%8E%87%E3%81%AE%E5%AE%9A%E7%BE%A9)
- [確率の性質](#%E7%A2%BA%E7%8E%87%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [定理：和事象の確率](#%E5%AE%9A%E7%90%86%E5%92%8C%E4%BA%8B%E8%B1%A1%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [定理：余事象の定理](#%E5%AE%9A%E7%90%86%E4%BD%99%E4%BA%8B%E8%B1%A1%E3%81%AE%E5%AE%9A%E7%90%86)
- [ポーカーの手札の確率](#%E3%83%9D%E3%83%BC%E3%82%AB%E3%83%BC%E3%81%AE%E6%89%8B%E6%9C%AD%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [すべてのカードの数値が異なる確率](#%E3%81%99%E3%81%B9%E3%81%A6%E3%81%AE%E3%82%AB%E3%83%BC%E3%83%89%E3%81%AE%E6%95%B0%E5%80%A4%E3%81%8C%E7%95%B0%E3%81%AA%E3%82%8B%E7%A2%BA%E7%8E%87)
  - [ツー・ペアの確率](#%E3%83%84%E3%83%BC%E3%83%BB%E3%83%9A%E3%82%A2%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [スリーカーズの確率](#%E3%82%B9%E3%83%AA%E3%83%BC%E3%82%AB%E3%83%BC%E3%82%BA%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [フォーカーズの確率](#%E3%83%95%E3%82%A9%E3%83%BC%E3%82%AB%E3%83%BC%E3%82%BA%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [フルハウスの確率](#%E3%83%95%E3%83%AB%E3%83%8F%E3%82%A6%E3%82%B9%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [ワン・ペアの確率](#%E3%83%AF%E3%83%B3%E3%83%BB%E3%83%9A%E3%82%A2%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [ロイヤル・フラッシュの確率](#%E3%83%AD%E3%82%A4%E3%83%A4%E3%83%AB%E3%83%BB%E3%83%95%E3%83%A9%E3%83%83%E3%82%B7%E3%83%A5%E3%81%AE%E7%A2%BA%E7%8E%87)
  - [ストレート・フラッシュ](#%E3%82%B9%E3%83%88%E3%83%AC%E3%83%BC%E3%83%88%E3%83%BB%E3%83%95%E3%83%A9%E3%83%83%E3%82%B7%E3%83%A5)
  - [フラッシュ](#%E3%83%95%E3%83%A9%E3%83%83%E3%82%B7%E3%83%A5)
  - [ストレート](#%E3%82%B9%E3%83%88%E3%83%AC%E3%83%BC%E3%83%88)
- [確認問題リスト](#%E7%A2%BA%E8%AA%8D%E5%95%8F%E9%A1%8C%E3%83%AA%E3%82%B9%E3%83%88)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 事象と集合

> 用語整理

|用語|説明|
|---|---|
|試行（trial）|「サイコロを振る」等の偶然の結果を伴う行為|
|標本空間（全事象，sample space)|$$\Omega$$, 確率事象の値全体、想定してる問題で起こり得る全ての事象|
|標本点 (sample point)|$$x \in \Omega$$, 標本空間の元<br><br>ある試行の標本空間が有限集合であるか、無限集合であるかに従って、その試行を有限試行または無限試行と呼ぶ。|
|事象(event)|標本空間$$\Omega$$の部分集合, $$A \subset \Omega$$|
|根元事象 (elementary event)|ただ一つの標本点だけからなる事象|

### 集合演算の基礎

ある集合 $$ U$$ の部分集合 $$ A$$, $$ B$$ について

|分類|説明|
|---|---|
|和集合(union)|$$A\cup B = \{x; x\in A \text{ or } x\in B \}$$|
|積集合(product, intersection)|$$A\cap B = \{x; x\in A \text{ and } x\in B \}$$|
|差集合|$$A - B$$, $$A\backslash B$$, これは $$A\cap B^c$$と同値|
|対象差(xor)| $$A\ominus B = (A\cap B^c)\cup(A^c\cap B)$$|

事象 $$ A$$ と $$ B$$ が互いに排反する $$ {\stackrel{\text{def}}{\iff}} A\cap B=\phi$$. $$ A$$ と $$ B$$ が同時には起こらない、ということ。事象 $$ A$$ は事象 $$ B$$ の排反事象 (exclusive events) であるという。


### Laplaceによる確率の定義

標本空間が $$ U=\{a_1,a_2,\cdots,a_n\}$$ で、根元事象

$$\displaystyle \{a_1\}, \{a_2\}, \cdots, \{a_n\} $$

が同様に確からしいとき、 $$ U$$ の事象 $$ A$$ の確率 $$ P(A)$$ を、

$$ P(A){\stackrel{\text{def}}{=}}\frac{\sharp A}{n} \: \mbox{(ただし $\sharp A$ で事象 $A$ に含まれる要素の個数を表わす)}$$

と定義した。 

> 例

「正しいサイコロ」をふるとき、事象Aの起こる確率は

$$
P(A) = \frac{\sharp A}{6}
$$

と表すことができる。

> Laplaceの確率の定義の問題点

$$
P(\{1\}) = 2/7, P(\{2\}) = P(\{3\})= P(\{4\})= P(\{5\})= P(\{6\}) = 1/7, 
$$

といういびつなサイコロを扱うことが難しくなってしまう。そこで、現代の確率論では、個々の問題における確率法則 $$ P$$ の 決め方については言及せず、ただ $$ P$$ の満たすべき法則だけを指定し、そこから導かれることを論じています。

## 確率の性質

上の例に出てきた $$ P$$ は、 $$ U$$ の任意の部分集合 $ A$ に対して定義される集合関数であり、次の性質を満たします:

1. 任意の事象 $$ A$$ に対して $$ P(A)\geq 0$$.
2. 任意の排反事象 $$ A$$, $$ B$$ に対して $$ P(A\cup B)=P(A)+P(B)$$.   (このことを確率の加法性とよびます)
3. 全事象の確率は $$ 1$$ である: $$ P(U)=1$$. 

一般に標本空間 $$ U$$ のすべての事象 $$ A$$ に対して、 実数 $$ P(A)$$ が定まっていて、 $$ P$$ が上の 3 つの性質を持つとき、 $$ P$$ を $$ U$$ の上の確率測度と呼び、 $$ U$$ と $$ P$$ を組にしたものを 確率空間 $$ (U,P)$$ という。 また、事象$$ A$$ に対して $$ P(A)$$ を事象 $$ A$$ の確率 と呼ぶ。

### 定理：和事象の確率

$$
P(A\cup B) = P(A) + P(B) - P(A\cap B)
$$

> 証明

$$A\cup B$$を排反事象の和として表すと

$$
\begin{aligned}
A\cup B &= (A \cap B^c) \cup (B \cap A^c) \cup (A \cap B)\\
&= (A - (A\cap B)) \cup (B - (A\cap B)) \cup (A \cap B)
\end{aligned}
$$

公理:任意の排反事象 $$ A$$, $$ B$$ に対して $$ P(A\cup B)=P(A)+P(B)$$, より

$$
\begin{aligned}
P(A\cup B) &= (P(A) - P(A \cap B)) + (P(B) - P(A \cap B)) + P(A \cap B)\\
& = P(A) + P(B) - P(A \cap B)
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

### 定理：余事象の定理

$$
P(A^c) = 1 - P(A)
$$

> 証明

定義より

$$
A\cap A^c = \phi, A\cup A^c = 1
$$

$$
\therefore 1 = P(U) = P(A\cup A^c) = P(A) + P(A^c)
$$

<div style="text-align: right;">
■
</div>

## ポーカーの手札の確率

ポーカーを考えます。５枚のカードの組合せ全体を$$\Omega$$とおきます。

- 同じカードが2枚以上ある組み合わせを $$A$$
- 同じカードが3枚以上ある組み合わせを $$B$$
- 同じカードが4枚ある組み合わせを $$C$$
- 同じカードが2枚以上あるのが2種類ある組み合わせを$$D$$
- フルハウスになる組合せを $$E$$

とおきます。これら集合の包含関係をまず調べます。

同じカードが3枚以上あることは必然的に同じカードが2枚以上あるので, 

$$
C \subset B \subset A
$$

同じカードが2枚以上あるのが2種類ある組合せも、同じカードが２枚以上あることを意味しているので、

$$
E \subset D\subset A
$$

かつ

$$
E\subset B
$$

### すべてのカードの数値が異なる確率

すべてのカードの数値が異なる場合は $$A^c$$と表せる。標本点の個数は数値13種類から5つ選び,それぞれのスートを4種類から1つ選べばいいので

$$
\mid A^c\mid = _{13}C_5 \times 4^5 = 1317888
$$

### ツー・ペアの確率 

ツーペアになるのは$$D\cap E^c$$と表せる。数値13種類から２つ選び、それぞれのスートを$$_4C_2$$から選んだあとに、最初のに種類の数値と異なるカード$$52 - 8 = 48$$種類から１枚選べばいいので

$$
|D\cap E^c| = _{13}C_2\cdot _4C_2 \cdot _4C_2 \cdot 48 = 123552
$$

従って、

$$
P(D\cap E^c) = \frac{123552}{2598960}
$$

### スリーカーズの確率

$$(B \cap C^c) \cap E^c$$と表せる。13種類の数値から１種類、スートを４種類から３つ、残りのカードを48通りと44通りから選び、4枚目以降(残り2枚)のカードの順序は無視していいので

$$
|(B \cap C^c) \cap E^c| = 13 \times _4C_3 \times 48 \times 44 / 2! = 54912
$$

### フォーカーズの確率

$$C$$は、13種類の数値から１種類、スートを４種類から4つ、残りのカードを48通りから選べばいいので

$$
|C| = 13 \times _4C_4 \times 48 = 624
$$

### フルハウスの確率

まず数値を13種類から３枚の数値と２枚の数値の２つ選びます。そこから、それぞれのスートを種類を計算すればいいので

$$
|E| = 13\times 12 \times _4C_3 \times _4C_2 = 3744
$$

### ワン・ペアの確率

仮に２が２枚でワンペアになったとすると、

- ２のスートの選び方: $$_4C_2$$
- 残りのカードの選びかた: 52枚から2の４枚を抜いた中から3枚かつ異なる数のカード選ぶので$$48\times 44 \times 40$$
- 残りのカードの順番：３枚目以降のカードの順序は無視していいので，$$ 3!$$で割らなければいけない

従って、

$$
13\times _4C_2 \times 48\times 44 \times 40 / 3! = 1098240
$$

52枚から5枚選ぶ場合の数は$$ _{52}C_5 = 2598960$$より、約42.2 %.

### ロイヤル・フラッシュの確率

ロイヤル・フラッシュとは，同じカードの種類（クラブ，スペード，ダイヤ，ハート）のエース，キング，クイーン，ジャック，10の組み合わせだから４通りのみです。

### ストレート・フラッシュ

同じ種類のカードが順に並んでいる組み合わせです。ただし，ロイヤル・フラッシュは別とします。ストレートというのは1以上から始まって13以下で終わるもので，13から1へとは続けてはいけません。よって、36通り.

### フラッシュ

５枚のカードが全部同じ種類の組み合わせ。ただし，ロイヤルフラッシュとストレートフラッシュの場合は除きます｡まずスートを４種類から1つ選びます。数値は13種類から５種類えらびます。

$$
\text{広義フラッシュの標本点の数} = 4\times _{13}C_5
$$

ここからロイヤルフラッシュとストレートフラッシュを覗くので

$$
4\times _{13}C_5 - 40 = 5108\text{ 通り}
$$

### ストレート

種類に関係なく，５枚のカードが順に続いている組み合わせのうち，ストレートフラッシュとロイヤルフラッシュの場合を除いたもの。ストレートのスタート地点は1~10までの10種類のいずれかでスートは４種類のうちなんでもいいので

$$
10 \times 4^5 - 40 = 10200\text{ 通り}
$$


## 確認問題リスト

> 問題 1.1

３つのボール a, b, cを３つの箱の中に分配するという実験を考える。標本点は全部で何通りあるか？

> 解

a, b, cと区別のあるボールについて、それぞれがどの箱に入るかは３通りずつ存在する.

$$
\therefore \: 3^3 = 27\text{ 通り}
$$

<div style="text-align: right;">
■
</div>

> 問題 1.2

区別のない３つのボールを３つの箱の中に分配するという実験を考える。標本点は全部で何通りあるか？

> 解

３つの箱をそれぞれ$$x, y, z$$とおくと、問題は次のように変形できる:

$$
x + y + z = 3 \text{ s.t. } x\geq 0, y\geq 0, z\geq 0
$$

したがって、

$$
_3H_3 = _5C_3 = \frac{5\times 4\times 3}{3\times 2\times 1} = 10\text{ 通り}
$$


<div style="text-align: right;">
■
</div>

> 問題1.3

区別のある３つのボール, a, b, c, を３つの箱の中に分配するという実験を考える。以下の事象に属する標本点は全部で何通りあるか？

- (1) 第２の箱は空である
- (2) ボールaは第一の箱に入っている
- (3) ボールbはボールcの入っている箱に入っていない

>　解 (1)

a, b, cと区別のあるボールについて、それぞれがどの箱に入るかは2通りずつ存在する.

$$
\therefore \: 2^3 = 8\text{ 通り}
$$

> 解 (2)

a, b, cと区別のあるボールについて、b, cがどの箱に入るかは3通りずつ存在する.

$$
\therefore \: 3^2 = 9\text{ 通り}
$$

> 解 (2)

a, b, cと区別のあるボールについて、a, bがどの箱に入るかは3通りずつ存在し、cは２通り.

$$
\therefore \: 3^2\times 2 = 18\text{ 通り}
$$


<div style="text-align: right;">
■
</div>

> 問題 1.4

区別のない３つのボールを３つの箱の中に分配するという実験を考える。以下の事象に属する標本点は全部で何通りあるか？

1. 第2の箱は空である
2. 第1の箱にはボールが1つ入っている
3. 第1の箱にはボールが1つ以上入っている
4. 第1の箱と第2の箱は空ではない

> 解(1)

３つの箱をそれぞれ$$x, y, z$$とおくと、問題は次のように変形できる:

$$
x + y + z = 3 \text{ s.t. } x\geq 0, y= 0, z\geq 0
$$

したがって、

$$
_2H_3 = _4C_3 = \frac{4\times 3\times 2}{3\times 2\times 1} = 4\text{ 通り}
$$

> 解(2)

問題は次のように変形できる:

$$
x + y + z = 3 \text{ s.t. } x=1 , y\geq 0, z\geq 0
$$

したがって、

$$
_2H_2 = _3C_2 = \frac{3\times 2}{2\times 1} = 3\text{ 通り}
$$

> 解(3)

問題は次のように変形できる:

$$
x + y + z = 3 \text{ s.t. } x\geq 1 , y\geq 0, z\geq 0
$$

Then,

$$
x + y + z = 2 \text{ s.t. } x\geq 0 , y\geq 0, z\geq 0
$$


したがって、

$$
_3H_2 = _4C_2 = \frac{4\times 3}{2\times 1} = 6\text{ 通り}
$$

> 解(4)

問題は次のように変形できる:

$$
x + y + z = 3 \text{ s.t. } x\geq 1 , y\geq 1, z\geq 0
$$

Then,

$$
x + y + z = 1 \text{ s.t. } x\geq 0 , y\geq 0, z\geq 0
$$


したがって、

$$
_3H_1 = _3C_1 = 3\text{ 通り}
$$


<div style="text-align: right;">
■
</div>

> 問題 1.5

A, B, Cを事象とする。次の事象を式で表わせ

(1) Aだけが起きる<br>
(2) A, B, Cのうち少なくとも2つが起きる<br>
(3) どれも起きない<br>
(4) 2つ以上は起きない<br>
(5) 全部が起きるか、どれも起きないかのいずれかである

> 解(1)

$$
A - (B \cup C) = A \cap (B \cup C)^c = A A \cap B^c \cap C^c
$$

> 解(2)

$$
(A\cap B)\cup (B\cap C)\cup (A\cap C)
$$

> 解(3)

$$
(A\cup B \cup C)^c = A^c\cap B^c\cap C^c
$$

> 解(4)

２つ以上起きない事象は, Aだけ起きる, Bだけ起きる,Cだけ起きる,いずれも起きない,のいずれかである。従って、

$$
\begin{aligned}
&(A - (B\cup C)) \cup(B - (A\cup C))\cup (C - (A\cup B)) \cup (A^c \cap B^c \cap C^c))\\
& = (A \cap B^c \cap C^c) \cup(A^c \cap B \cap C^c)\cup (A^c \cap B^c \cap C) \cup (A^c \cap B^c \cap C^c))
\end{aligned}
$$

> 解(5)

$$
(A \cap B \cap C) \cup ((A^c \cap B^c \cap C^c))
$$


<div style="text-align: right;">
■
</div>



> 問題 1.6

次の式を簡単にせよ.

(1) $$(A\cup B) \cap (A\cup B^c)$$<br>
(2) $$(A\cup B) \cap (A^c\cup B) \cap (A\cup B^c)$$

> 解(1)

分配法則より

$$
\begin{aligned}
(A\cup B) \cap (A\cup B^c) &= ((A\cup B)\cap A) \cup ((A\cup B) \cap B^c)\\
&= A \cup (A\cap B^c)\\
&= A 
\end{aligned}
$$

> 解(2)

上記解答を用いて

$$
\begin{aligned}
(A\cup B) \cap (A^c\cup B) \cap (A\cup B^c) \cap (A\cup B)& = ((A\cup B) \cap (A^c\cup B)) \cap ((A\cup B^c) \cap (A\cup B))\\
&= A\cap B 
\end{aligned}
$$


<div style="text-align: right;">
■
</div>
