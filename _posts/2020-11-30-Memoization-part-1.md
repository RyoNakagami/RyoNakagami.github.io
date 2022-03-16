---
layout: post
title: "Memoization(メモ化)のまとめ Part 1"
subtitle: "PythonにおけるMemoizationの実践"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Python
- Memoization
---



|概要||
|---|---|
|目的|メモ化を用いたプログラム高速化技法の紹介 part 1|
|プログラミング言語|Python 3.6.9 (Google Colabのデフォルト)|
|実行環境|Google Colab|
|前提|Pythonの`decorators`の概念を知っていること|
|参考|[Memoization with Decorators](https://www.python-course.eu/python3_memoization.php)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. Memoizationとは？](#1-memoizationとは)
- [2. Memoizationの実装 in Python](#2-memoizationの実装-in-python)
  - [実行時間の比較](#実行時間の比較)
- [3. Exercise: Ackermann関数とMemoization](#3-exercise-ackermann関数とmemoization)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. Memoizationとは？

`memorization`ではなく`Memoization`（メモ化）であることに注意。Memoizationは`to be remembered`を意味する。プログラム高速化を目的としてよく用いられる。

とある関数について、一度呼ばれたinputsとそのinputsに対応するoutputをメモに記録し（メモ化し）、のちに同じinputsでcallされたときにわざわざもう一度計算するのではなく、メモからそのinputsに対応するoutputsを返すことでプログラムの実行時間の短縮を実現する技法がmemoizationです。メモのデータ構造としては、Pythonでは辞書型がよく用いられる。

メモ化は関数の時間コストを領域コストに交換して、時間コスト（実行回数）を低減させる手段です。なので、「メモ化された関数は速度の面で最適化され、記憶装置の領域という面ではより多く消費する」というトレードオフに留意が必要です。実行回数を減らすことができるため、maximum recursion depth制約を回避する手法として用いることができます。

## 2. Memoizationの実装 in Python

以下のようなフィボナッチrecursive functionを考える：

```py
def fib(n):
    if n == 0:
        return  0
    elif n == 1:
        return 1
    else:
        return fib(n-1) + fib(n-2)
```

これをmemoization機能を加味して書き直すと、

```py
def memoize(f):
    memo = {}
    def helper(x):
        if x not in memo:            
            memo[x] = f(x)
        return memo[x]
    return helper
    

def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n-1) + fib(n-2)

fib = memoize(fib)
```

decoratorを用いて表現すると

```py
def memoize(f):
    memo = {}
    def helper(x):
        if x not in memo:            
            memo[x] = f(x)
        return memo[x]
    return helper
    
@memoize
def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n-1) + fib(n-2)
```

### 実行時間の比較

実行環境はGoogle Colabとする。Test codeは以下：

```py
import time 
  
# Function that computes Fibonacci  
# numbers without memoization
def fib_without_cache(n): 
    if n < 2: 
        return n 
    return fib_without_cache(n-1) + fib_without_cache(n-2) 

def memoize(f):
    memo = {}
    def helper(x):
        if x not in memo:            
            memo[x] = f(x)
        return memo[x]
    return helper
  
# Function that computes Fibonacci 
# numbers with memoization
@memoize
def fib_with_cache(n): 
    if n < 2: 
        return n 
    return fib_with_cache(n-1) + fib_with_cache(n-2) 

# Execution start time 
begin = time.time() 
fib_without_cache(30) 
  
# Execution end time 
end = time.time() 
  
print("Time taken to execute the function without memoization is", end-begin) 

# Execution start time 
begin = time.time() 
fib_with_cache(30) 
# Execution end time 
end = time.time() 
  
print("Time taken to execute the function with memoization is", end-begin) 
```

実行結果は

```
Time taken to execute the function without memoization is 0.3091275691986084
Time taken to execute the function with memoization is 9.918212890625e-05
```

## 3. Exercise: Ackermann関数とMemoization

ここではメモ化を用いてAckermann関数を実装してみる。Ackermann関数とは

$$
A(m, n) =\begin{cases}
n + 1 & \text{ if } m = 0\\
A(m-1, 1) & \text{ if } m>0, n = 0\\
A(m-1, A(m, n-1)) & \text{ if } m>0, n > 0
\end{cases}
$$

で定義されます。

```py
import time 
  
# Function that computes Ackermann 
# numbers without memoization
def ackermann_without_cache(m, n):
    if m < 0 or n < 0:
        raise ValueError("m, n must be non-negative integers")
    elif m == 0: 
        return n + 1
    elif m > 0 and n == 0:
        return ackermann_without_cache(m-1, 1)
    elif m > 0 and n > 0:
        return ackermann_without_cache(m-1, ackermann_without_cache(m, n-1))

def memoize(f):
    memo = {}
    def helper(m, n):
        if (m, n) not in memo:            
            memo[(m, n)] = f(m, n)
        return memo[(m, n)]
    return helper
  
# Function that computes  Ackermann 
# numbers with memoization
@memoize
def ackermann_with_cache(m, n):
    if m < 0 or n < 0:
        raise ValueError("m, n must be non-negative integers")
    elif m == 0: 
        return n + 1
    elif m > 0 and n == 0:
        return ackermann_with_cache(m-1, 1)
    elif m > 0 and n > 0:
        return ackermann_with_cache(m-1, ackermann_with_cache(m, n-1))

# Execution start time 
begin = time.time() 
print(ackermann_without_cache(3, 6))
  
# Execution end time 
end = time.time() 
  
print("Time taken to execute the function without memoization is", end-begin) 

# Execution start time 
begin = time.time() 
print(ackermann_with_cache(3, 6))
# Execution end time 
end = time.time() 
  
print("Time taken to execute the function with memoization is", end-begin) 
```

実行結果は

```
509
Time taken to execute the function without memoization is 0.03899407386779785
509
Time taken to execute the function with memoization is 0.002206802368164062
```
