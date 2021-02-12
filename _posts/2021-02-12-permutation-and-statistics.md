---
layout: post
title: "数理統計: 重複順列と順列"
subtitle: "Permuation and Permutation with repetitionの実装"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
tags:

- C
- Permuation
- Python
- 競技プログラミング
- 統計
---

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
- [4. 写像の個数と重複組合せ](#4-%E5%86%99%E5%83%8F%E3%81%AE%E5%80%8B%E6%95%B0%E3%81%A8%E9%87%8D%E8%A4%87%E7%B5%84%E5%90%88%E3%81%9B)
  - [問題: 写像の個数](#%E5%95%8F%E9%A1%8C-%E5%86%99%E5%83%8F%E3%81%AE%E5%80%8B%E6%95%B0)
    - [解答](#%E8%A7%A3%E7%AD%94-2)
  - [問題：写像の個数その２](#%E5%95%8F%E9%A1%8C%E5%86%99%E5%83%8F%E3%81%AE%E5%80%8B%E6%95%B0%E3%81%9D%E3%81%AE%EF%BC%92)
    - [解答](#%E8%A7%A3%E7%AD%94-3)

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

## 4. 写像の個数と重複組合せ
### 問題: 写像の個数

$A = \{1, 2, ..., r\}$, $B = \{1, 2, ..., n\}$であるとき、次の条件を満たす写像$f:A\to B$はそれぞれ全部でいくつあるか？ただし、$r\leq n$とする。

- (1) 任意の写像
- (2) 1対1
- (3) 広義単調増加
- (4) 狭義単調増加

#### 解答

(1)は$n^r$個。(2)は$_nP_r$個。(3)は$_nH_r$個。(4)は$_nC_r$個。

### 問題：写像の個数その２

$A = \{1, 2, ..., r\}$, $B = \{1, 2, ..., n\}$, $C = \{1, 2, ..., n+r-1\}$のとき、$f:A\to B$に対して、$F(k)= f(k)+(k-1)$と定義される$F:A\to C$を考えます。このことを利用して、$_nH_r = _{n+r-1}C_r$を示しなさい。


#### 解答

Fが狭義単調増加のとき、fは広義単調増加となる。一方、fが広義単調増加のときFは狭義単調増加となる。よって、$_nH_r = _{n+r-1}C_r$。








