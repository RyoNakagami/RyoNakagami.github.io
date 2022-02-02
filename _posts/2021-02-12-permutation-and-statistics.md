---
layout: post
title: "数理統計: 重複順列と順列"
subtitle: "Permuation and Permutation with repetitionの実装"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
tags:

- Permuation
- Python
- 競技プログラミング
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

|概要||
|---|---|
|目的|Permuation and Permutation with repetitionの実装|
|プログラミング言語|Python 3.9|
|実行環境|Google Colab|
|参考|- 明解演習数理統計 小寺平治著<br>- [高校数学の美しい物語～定期試験から数学オリンピックまで800記事～](https://mathtrain.jp/tyohukuc)<br>- [note.nkmk.me](https://note.nkmk.me/python-math-factorial-permutations-combinations/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 順列と組合せ](#1-%E9%A0%86%E5%88%97%E3%81%A8%E7%B5%84%E5%90%88%E3%81%9B)
  - [それぞれの総数の計算方法](#%E3%81%9D%E3%82%8C%E3%81%9E%E3%82%8C%E3%81%AE%E7%B7%8F%E6%95%B0%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
- [2. Permuation/Combination/Permutation with repetitionの実装](#2-permuationcombinationpermutation-with-repetition%E3%81%AE%E5%AE%9F%E8%A3%85)
  - [Permutationの紹介](#permutation%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [Combination/Permuatiton with repetitionの実装](#combinationpermuatiton-with-repetition%E3%81%AE%E5%AE%9F%E8%A3%85)
- [3. 順列と重複組合せの例題](#3-%E9%A0%86%E5%88%97%E3%81%A8%E9%87%8D%E8%A4%87%E7%B5%84%E5%90%88%E3%81%9B%E3%81%AE%E4%BE%8B%E9%A1%8C)
  - [例題 1](#%E4%BE%8B%E9%A1%8C-1)
    - [解答](#%E8%A7%A3%E7%AD%94)
  - [例題２：どれも1つ以上選ぶパターン](#%E4%BE%8B%E9%A1%8C%EF%BC%92%E3%81%A9%E3%82%8C%E3%82%821%E3%81%A4%E4%BB%A5%E4%B8%8A%E9%81%B8%E3%81%B6%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
    - [解答](#%E8%A7%A3%E7%AD%94-1)
  - [例題3: 整数解の個数](#%E4%BE%8B%E9%A1%8C3-%E6%95%B4%E6%95%B0%E8%A7%A3%E3%81%AE%E5%80%8B%E6%95%B0)
    - [解答(1)](#%E8%A7%A3%E7%AD%941)
    - [解答(2)](#%E8%A7%A3%E7%AD%942)
  - [例題4](#%E4%BE%8B%E9%A1%8C4)
    - [解答](#%E8%A7%A3%E7%AD%94-2)
- [4. 写像の個数と重複組合せ](#4-%E5%86%99%E5%83%8F%E3%81%AE%E5%80%8B%E6%95%B0%E3%81%A8%E9%87%8D%E8%A4%87%E7%B5%84%E5%90%88%E3%81%9B)
  - [問題: 写像の個数](#%E5%95%8F%E9%A1%8C-%E5%86%99%E5%83%8F%E3%81%AE%E5%80%8B%E6%95%B0)
    - [解答](#%E8%A7%A3%E7%AD%94-3)
  - [問題：写像の個数その２](#%E5%95%8F%E9%A1%8C%E5%86%99%E5%83%8F%E3%81%AE%E5%80%8B%E6%95%B0%E3%81%9D%E3%81%AE%EF%BC%92)
    - [解答](#%E8%A7%A3%E7%AD%94-4)
- [5. 二項分布の期待値と分散](#5-%E4%BA%8C%E9%A0%85%E5%88%86%E5%B8%83%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%A8%E5%88%86%E6%95%A3)
  - [期待値の計算](#%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AE%E8%A8%88%E7%AE%97)
  - [分散の計算](#%E5%88%86%E6%95%A3%E3%81%AE%E8%A8%88%E7%AE%97)
- [Appendix: ガンマ関数](#appendix-%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0)
  - [ガンマ関数の性質](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
    - [証明](#%E8%A8%BC%E6%98%8E)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 順列と組合せ

相異なるn個の元からなる集合 $A=\{a_1, a_2, ..., a_n\}$ について、

- 重複順列: 任意のr重対 $(a_{k_1}, ..., a_{k_r})$のこと。その総数を$_n\Pi_r$と表す。
- 順列: 異なる元のr重対 $(a_{k_1}, ..., a_{k_r})$のこと。その総数を$_nP_r$と表す。
- 重複組合せ: $k_1\leq \cdots \leq k_r$なる $(a_{k1}, ..., a_{kr})$のこと。その総数を$_nH_r$と表す。
- 組合せ: $k_1< \cdots < k_r$なる $(a_{k1}, ..., a_{kr})$のこと。その総数を$_nC_r$と表す。

### それぞれの総数の計算方法

$$
\begin{aligned}
_n\Pi_r &= n^r\\
_nP_r &= \frac{n!}{(n-r)!}\\
_nH_r &= \frac{(n+r-1)!}{r!(n-1)!} = _{n+r-1}C_{r}\\
_nC_r &= \frac{n!}{r!(n-r)!}\\
\end{aligned}
$$

## 2. Permuation/Combination/Permutation with repetitionの実装

SciPyには順列の総数を返す関数`scipy.special.perm()`や`scipy.special.comb()`が用意されています。AtCoderにおいては、2020年4月12日（ABC162）以降のコンテスト（SciPy1.4.1）では使えます。Scipyの各関数を参考に各総数の計算方法を紹介します。

### Permutationの紹介

`perm(N, k, exact=False, repetition=False)`は$_nP_k$の計算結果を返してくれます。実装の概要は以下となります。

```py
import numpy as np
import math

def poch(z, m):
    """The Pochhammer symbol (rising factorial), is defined as
        (z)_m = Gamma(z+m)/Gamma(z)
        Gamma(z) = (z-1)! where m is int
    Parameters:	
    ----------
    z : array_like(int or float)
    m : array_like(int or float)
    Returns:	
    ----------
    poch : ndarray The value of the function.
    """
    if (z <= 0) or (m < 0):
        return 0
    return math.gamma(z+m)/math.gamma(z)

def perm(N, k, exact=False, repetition=False):
    """Permutations of N things taken k at a time, i.e., k-permutations of N.
    It's also known as "partial permutations".
    Parameters
    ----------
    N : int, ndarray
        Number of things.
    k : int, ndarray
        Number of elements taken.
    exact : bool, optional
        If `exact` is False, then floating point precision is used, otherwise
        exact long integer is computed.
    Returns
    -------
    val : int, ndarray
        The number of k-permutations of N.
    Notes
    -----
    - Array arguments accepted only for exact=False case.
    - If k > N, N < 0, or k < 0, then a 0 is returned.
    Examples
    --------
    >>> k = np.array([3, 4])
    >>> n = np.array([10, 10])
    >>> perm(n, k)
    array([  720.,  5040.])
    >>> perm(10, 3, exact=True)
    720
    """
    if exact:
        if (k > N) or (N < 0) or (k < 0):
            return 0
        val = 1
        for i in range(N - k + 1, N + 1):
            val *= i
        return val
    else:
        _poch = np.vectorize(poch)
        k, N = np.asarray(k), np.asarray(N)
        cond = (k <= N) & (N >= 0) & (k >= 0)
        vals = _poch(N - k + 1, k)
        if isinstance(vals, np.ndarray):
            vals[~cond] = 0
        elif not cond:
            vals = np.float64(0)
        return vals
```

### Combination/Permuatiton with repetitionの実装

```py
import numpy as np
import math

def poch(z, m):
    """The Pochhammer symbol (rising factorial), is defined as
        (z)_m = Gamma(z+m)/Gamma(z)
        Gamma(z) = (z-1)! where m is int
    Parameters:	
    ----------
    z : array_like(int or float)
    m : array_like(int or float)
    Returns:	
    ----------
    poch : ndarray The value of the function.
    """
    if (z <= 0) or (m < 0):
        return 0
    return math.gamma(z+m)/math.gamma(z)

def comb(N, k, exact=False, repetition=False):
    """The number of combinations of N things taken k at a time.
    This is often expressed as "N choose k".
    Parameters
    ----------
    N : int, ndarray
        Number of things.
    k : int, ndarray
        Number of elements taken.
    exact : bool, optional
        If `exact` is False, then floating point precision is used, otherwise
        exact long integer is computed.
    repetition : bool, optional
        If `repetition` is True, then the number of combinations with
        repetition is computed.
    Returns
    -------
    val : int, float, ndarray
        The total number of combinations.
    See Also
    --------
    binom : Binomial coefficient ufunc
    Notes
    -----
    - Array arguments accepted only for exact=False case.
    - If N < 0, or k < 0, then 0 is returned.
    - If k > N and repetition=False, then 0 is returned.
    Examples
    --------
    >>> k = np.array([3, 4])
    >>> n = np.array([10, 10])
    >>> comb(n, k, exact=False)
    array([ 120.,  210.])
    >>> comb(10, 3, exact=True)
    120
    >>> comb(10, 3, exact=True, repetition=True)
    220
    """
    if repetition:
        return comb(N + k - 1, k, exact)
    if exact:
        if (k > N) or (N < 0) or (k < 0):
            return 0
        val = 1
        for i in range(N - k + 1, N + 1):
            val *= i
        for i in range(2, k + 1):
            val //= i
        return val
    else:
        _poch = np.vectorize(poch)
        _gamma = np.vectorize(math.gamma)
        k, N = np.asarray(k), np.asarray(N)
        cond = (k <= N) & (N >= 0) & (k >= 0)
        vals = _poch(N - k + 1, k)/_gamma(k+1)
        if isinstance(vals, np.ndarray):
            vals[~cond] = 0
        elif not cond:
            vals = np.float64(0)
        return vals
```

## 3. 順列と重複組合せの例題
### 例題 1

```
青，赤，黒の三種類の玉がたくさんある。この中から4つ玉を選ぶときに得られる色のパターンが何通りあるか求めよ。
```

#### 解答

４つの玉を仕切り２つで分ける問題と捉え直すことで計算することができます。いいかえると3種類のものから重複を許して4個選ぶ場合の数なので，

$$
_3H_4 = _6C_4 = 15
$$

全パターンを列挙したい場合は、

```py
import itertools

all = itertools.combinations_with_replacement(['blue', 'red', 'black'], 4)
card = 0
print("---出力結果---")
for x in all:
    card +=1
    print(x)
print("---総数---")
print(card)
```

出力結果は以下、

```raw
---出力結果---
('blue', 'blue', 'blue', 'blue')
('blue', 'blue', 'blue', 'red')
('blue', 'blue', 'blue', 'black')
('blue', 'blue', 'red', 'red')
('blue', 'blue', 'red', 'black')
('blue', 'blue', 'black', 'black')
('blue', 'red', 'red', 'red')
('blue', 'red', 'red', 'black')
('blue', 'red', 'black', 'black')
('blue', 'black', 'black', 'black')
('red', 'red', 'red', 'red')
('red', 'red', 'red', 'black')
('red', 'red', 'black', 'black')
('red', 'black', 'black', 'black')
('black', 'black', 'black', 'black')
---総数---
15
```

### 例題２：どれも1つ以上選ぶパターン

```
青，赤，黒の三種類の玉がたくさんある。この中から5つ玉を選ぶときに得られる色のパターンのうち，どの色の玉も一つ以上選ぶものが何通りあるか求めよ。
```

#### 解答

最初に三種類の玉を1つずつ取ってくる。残り二つの玉の選び方を数えればよい、つまり、2つの玉を仕切り２つで分ける問題と捉え直すことで計算することができます。

$$
_3H_2 = _4C_2 = 6
$$

```py
color_list = ['blue', 'red', 'black']
all = itertools.combinations_with_replacement(color_list, 2)
card = 0

print("---出力結果---")
for x in all:
    card +=1
    tmp = color_list + list(x)
    print(sorted(tmp))
print("---総数---")
print(card)
```

出力結果は

```raw
---出力結果---
['black', 'blue', 'blue', 'blue', 'red']
['black', 'blue', 'blue', 'red', 'red']
['black', 'black', 'blue', 'blue', 'red']
['black', 'blue', 'red', 'red', 'red']
['black', 'black', 'blue', 'red', 'red']
['black', 'black', 'black', 'blue', 'red']
---総数---
6
```


### 例題3: 整数解の個数

```
x+y+z+w=6 という方程式について，
（1）非負整数解の個数を求めよ。
（2）正の整数解の個数を求めよ。
```

#### 解答(1)

6個のものを4つに割り当てる状況なので

$$
_4H_6 = _9C_6 = 84
$$

すべてのパターンを列挙する場合は以下

```py
import collections
import itertools

coef_list = ['x', 'y', 'z', 'w']
all = itertools.combinations_with_replacement(coef_list, 6)
card = 0

print("---出力結果---")
for x in all:
    card +=1
    print(collections.Counter(x))
print("---総数---")
print(card)
```

出力結果（一部）は以下、

```raw
---出力結果---
Counter({'x': 6})
Counter({'x': 5, 'y': 1})
Counter({'x': 5, 'z': 1})
Counter({'x': 5, 'w': 1})
Counter({'x': 4, 'y': 2})
Counter({'x': 4, 'y': 1, 'z': 1})
〜〜〜〜〜〜
（一部省略）
〜〜〜〜〜〜
Counter({'z': 6})
Counter({'z': 5, 'w': 1})
Counter({'z': 4, 'w': 2})
Counter({'z': 3, 'w': 3})
Counter({'w': 4, 'z': 2})
Counter({'w': 5, 'z': 1})
Counter({'w': 6})
---総数---
84
```

#### 解答(2)

最初に x,y,z,w に 1 ずつ分配するので

$$
_2H_4 = _5C_4 = 10
$$

### 例題4

つぎの値を計算せよ：

$$
\begin{aligned}
&\sum_{k=0}^n \:_nC_k\\
&\sum_{k=0}^n (-1)^k \:_nC_k
\end{aligned}
$$

#### 解答

$$
(x+1)^n = \sum_{k=0}^n\: _nC_k x^k
$$

より, $$x = 1$$を代入すると

$$
(1+1)^n = \sum_{k=0}^n \:_nC_k 1^k = \sum_{k=0}^n \:_nC_k = 2^n
$$

同様に、

$$
(-1+1)^n = \sum_{k=0}^n \:_nC_k (-1)^k = 0
$$

### 例題5

$$(1+x)^{m+n} = (1+x)^m(1+x)^n$$の両辺の$$x^k$$の係数を比較することにより以下の公式を証明せよ

$$
\sum_{i=0}^k \:_mC_i \:_nC_{k-i} = \:_{m+n}C_k
$$

#### 解答

$$
\begin{aligned}
(1+x)^{n+m} &= \sum^{m+n}_{i=0} \:_{m+n}C_i x^i\\
(1+x)^{m}(1+x)^{n} &= \sum^{m}_{i=0} \:_{m}C_i x^i\sum^{n}_{i=0} \:_{n}C_i x^i
\end{aligned}
$$

よってそれぞれの$$x^k$$の係数は

$$
\sum_{i=0}^k \:_mC_i \:_nC_{k-i} =\: _{m+n}C_k
$$

## 4. 写像の個数と重複組合せ
### 問題: 写像の個数

$A = \{1, 2, ..., r\}$, $B = \{1, 2, ..., n\}$であるとき、次の条件を満たす写像$f:A\to B$はそれぞれ全部でいくつあるか？ただし、$r\leq n$とする。

- (1) 任意の写像
- (2) 1対1
- (3) 広義単調増加
- (4) 狭義単調増加

#### 解答

(1)は$n^r$個。(2)は$_nP_r$個。(3)は$_nH_r$個。(4)は$_nC_r$個。

<div style="text-align: right;">
■
</div>

### 問題：写像の個数その２

$A = \{1, 2, ..., r\}$, $B = \{1, 2, ..., n\}$, $C = \{1, 2, ..., n+r-1\}$のとき、$f:A\to B$に対して、$F(k)= f(k)+(k-1)$と定義される$F:A\to C$を考えます。このことを利用して、$_nH_r = _{n+r-1}C_r$を示しなさい。


#### 解答

Fが狭義単調増加のとき、fは広義単調増加となる. 一方、fが広義単調増加のときFは狭義単調増加となる.

$$f$$と$$F$$は１対１に対応するので、$_nH_r = _{n+r-1}C_r$

<div style="text-align: right;">
■
</div>


## 5. 二項分布の期待値と分散

確率変数$$X$$は$$X \sim B(n, P)$$に従うとする。

### 期待値の計算
<div class="math display" style="overflow: auto">
$$
\begin{aligned}
E(X) &= \sum_{x=0}^n x _nC_x P^x(1-P)^{n-x}\\
&= \sum_{x=0}^n x \frac{n!}{x!(n-x)!} P^x(1-P)^{n-x}\\
&= nP\sum_{x=1}^n \frac{n-1!}{(x-1)!((n-1)-(x-1))!} P^{x-1}(1-P)^{(n-1)-(x-1))}\\
&= nP\sum_{j=0}^n \frac{n-1!}{j!((n-1)-j)!} P^{j}(1-P)^{(n-1)-j} \text{ where } j = x-1\\
&= nP(P+1-P)^{n-1}\\
& = nP
\end{aligned}
$$

</div>

### 分散の計算

$$V(X) = E(X^2) - E(X)^2$$より$$E(X^2)$$を計算すれば分散は計算できます。

<div class="math display" style="overflow: auto">

$$
\begin{aligned}
E(X^2) &= \sum_{x=0}^n x^2 _nC_x P^x(1-P)^{n-x}\\
& = \sum_{x=1}^n x^2 _nC_x P^x(1-P)^{n-x}\\
& = nP\sum_{x=1}^n x \frac{n-1!}{(x-1)!((n-1)-(x-1))!} P^{x-1}(1-P)^{(n-1)-(x-1))}\\
& = nP\left[\sum_{x=1}^n (x-1) \frac{n-1!}{(x-1)!((n-1)-(x-1))!} P^{x-1}(1-P)^{(n-1)-(x-1))} + \sum_{x=1}^n \frac{n-1!}{(x-1)!((n-1)-(x-1))!} P^{x-1}(1-P)^{(n-1)-(x-1))}\right]\\
& = nP + nP \left[\sum_{x=2}^n (x-1) \frac{n-1!}{(x-1)!((n-1)-(x-1))!} P^{x-1}(1-P)^{(n-1)-(x-1))}\right]\\
& = nP + nP(n-1)P \left[\sum_{x=2}^n \frac{n-2!}{(x-2)!((n-2)-(x-2))!} P^{x-2}(1-P)^{(n-2)-(x-2))}\right]\\
& = nP + n^2P^2 - nP^2\\
& = nP(1 - P) + n^2P^2
\end{aligned}
$$

</div>

よって

$$
V(x) = E(X^2) - E(X)^2 = nP(1 - P) + n^2P^2 - n^2P^2 = nP(1 - P) 
$$

## Appendix: ガンマ関数

ガンマ関数を次のように定義する。

$$
\Gamma(x) = \int^\infty_0t^{x-1}\exp(-t)dt (x>0)\tag{1}
$$


(1)式の右辺において、$t=as(a>0)$と変換すると、$s = t/a$, $t:0\to\infty$のｔき$s:0\to\infty$, $dt = ads$なので

$$
\Gamma(x)= \int^\infty_0t^{x-1}\exp(-t)dt = \int^\infty_0(as)^{x-1}\exp(-as)a ds = a^x\int^\infty_0(s)^{x-1}\exp(-as) ds\tag{2}
$$

を得る。よって

$$
\frac{\Gamma(x)}{a^x} = \int^\infty_0(s)^{x-1}\exp(-as) ds
$$

### ガンマ関数の性質

$$
\begin{aligned}
\Gamma(x+1) & = x\Gamma(x)\\
\Gamma(1) & = 1\\
\Gamma(n) & = (n-1)! \text{ ただしnは自然数}\\
\Gamma(1/2) & = \sqrt{\pi}
\end{aligned}
$$

#### 証明

$$
\begin{aligned}
\Gamma(x+1) & = \int^\infty_0t^{x+1-1}\exp(-t)dt\\
& = \int^\infty_0t^{x}\exp(-t)dt\\
& = [-t^{x}\exp(-t)]^{\infty}_0 - (-x\int^\infty_0t^{x-1}\exp(-t)dt) \text{ 部分積分より }\\
& = x\Gamma(x)
\end{aligned}
$$

$$[-t^x\exp(-t)]_0^{\infty}$$ はロピタルの定理より$$\lim_{t\to\infty}t^{x}\exp(-t)=0$$を用いている。


$$\Gamma(1) = 1$$は$$x=1$$を直接計算すれば良いので

$$
\Gamma(1)  = \int^\infty_0t^{0}\exp(-t)dt = \int^\infty_0\exp(-t)dt = [-\exp(-t)]^{\infty}_0 = 1
$$

$$\Gamma(1/2)  = \sqrt{\pi}$$については、まず$$\Gamma(1/2)$$を次のように変形する。

$$
\Gamma(1/2) = \int^\infty_0t^{1/2-1}\exp(-t)dt
$$

ここで、$$t = y^2/2$$と変形すると、$$y = \sqrt{2t}$$, $$t:0\to\infty$$のｔき$$y:0\to\infty$$, $$dt = ydy$$なので

<div class="math display" style="overflow: auto">

$$
\begin{aligned}
\Gamma(1/2) &= \int^{\infty}_0\left(\frac{y^2}{2}\right)^{-1/2}\exp(-y^2/2)ydy = \sqrt{2}\int^{\infty}_0\exp(-y^2/2)ydy\\
&=\frac{\sqrt{2}}{2}\int^{\infty}_{-\infty}\exp(-y^2/2)ydy\\
&=\pi\int^{\infty}_{-\infty}\frac{1}{\sqrt{2\pi}}\exp(-y^2/2)ydy\\
&=\pi
\end{aligned}
$$

</div>

最後の積分は標準正規分布$N(0, 1)$の確率密度関数を全範囲で積分しているので1になる。
