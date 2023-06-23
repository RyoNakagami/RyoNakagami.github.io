---
layout: post
title: "Vandermondeの行列式"
subtitle: "Vandermondeの行列式の証明"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 
tags:

- math
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [2. Vandermondeの行列式](#2-vandermonde%E3%81%AE%E8%A1%8C%E5%88%97%E5%BC%8F)
  - [前提ルール](#%E5%89%8D%E6%8F%90%E3%83%AB%E3%83%BC%E3%83%AB)
  - [命題](#%E5%91%BD%E9%A1%8C)
  - [証明](#%E8%A8%BC%E6%98%8E)
- [3. Pythonでの計算方法](#3-python%E3%81%A7%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 1. 今回のスコープ

- Vardemondeの行列式の証明

## 2. Vandermondeの行列式
### 前提ルール

1. 行列の余因子展開
2. 行列$A$の行列式の計算において、ある列の$\alpha$倍を他の行から引くとき、det($A$)の値は変わらない
3. 行列Aのある行を非ゼロ定数$\beta$倍するとき、$\text{det}(A)$は$\alpha$倍となる

### 命題
<div class="math display" style="overflow: auto">

$$
\text{det}\left(
\begin{array}{ccccc}
1 & a_1 & \cdots & a_1^{n-2} & a_1^{n-1}\\
1&a_2 & \cdots & a_2^{n-2} & a_2^{n-1}\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
1 & a_{n-1} & \cdots & a_{n-1}^{n-2} & a_{n-1}^{n-1}\\
1 & a_n & \cdots & a_n^{n-2} & a_n^{n-1}
\end{array}  
\right)= (-1)^{n(n-1)/2}{\displaystyle\prod_{1\leq i<j\leq n}}(a_i - a_j)
$$

</div>

### 証明 

証明は帰納法を用います。(1) $n = 1$のときは両辺が1で成立。念の為、(2) $n = 2$のときを見てみると、
<div class="math display" style="overflow: auto">
$$
\text{det}\left(\begin{array}{cc}1 & a_1\\1&a_2\end{array}\right) = (a_2 - a_1)
$$
</div>

で成立します。

(3) $n=k$ の場合：

$n=k-1$で成立することを仮定します。このとき、$n=k$でみてみます。なお簡略化のため
<div class="math display" style="overflow: auto">

$$
A \equiv \left(
\begin{array}{ccccc}
1 & a_1 & \cdots & a_1^{k-2} & a_1^{k-1}\\
1&a_2 & \cdots & a_2^{k-2} & a_2^{k-1}\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
1 & a_{k-1} & \cdots & a_{k-1}^{k-2} & a_{k-1}^{k-1}\\
1 & a_k & \cdots & a_k^{k-2} & a_k^{k-1}
\end{array} \right) 
$$
</div>

と表記します。

まず、(k-1)列目を$a_1$倍して、k列目から引きます。

<div class="math display" style="overflow: auto">
$$
\text(det)(A) = \text(det)\left(
\begin{array}{ccccc}
1 & a_1 & \cdots & a_1^{k-2} & 0\\
1&a_2 & \cdots & a_2^{k-2} & a_2^{k-2}(a_2 - a_1)\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
1 & a_{k-1} & \cdots & a_{k-1}^{k-2} & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
1 & a_k & \cdots & a_k^{k-2} & a_k^{k-2}(a_k - a_1)
\end{array} \right) 
$$
</div>

次に(k-2)列目を$a_1$倍して、(k-1)列目から引きます。

<div class="math display" style="overflow: auto">
$$
\text{det}(A) = \text(det)\left(
\begin{array}{ccccc}
1 & a_1 & \cdots & a_1^{k-2} & 0\\
1&a_2 & \cdots & a_2^{k-2} & a_2^{k-2}(a_2 - a_1)\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
1 & a_{k-1} & \cdots & a_{k-1}^{k-2} & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
1 & a_k & \cdots & a_k^{k-2} & a_k^{k-2}(a_k - a_1)
\end{array} \right) = 
\text{det}\left(
\begin{array}{ccccc}
1 & a_1 & \cdots & 0 & 0\\
1&a_2 & \cdots & a_2^{k-3}(a_2-a_1) & a_2^{k-2}(a_2 - a_1)\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
1 & a_{k-1} & \cdots & a_{k-1}^{k-3}(a_{k-1}-a_1) & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
1 & a_k & \cdots & a_k^{k-3}(a_k-a_1) & a_k^{k-2}(a_k - a_1)
\end{array} \right) 
$$

</div>

これを繰り返していき

<div class="math display" style="overflow: auto">

$$
\begin{aligned}
\text{det}(A) &= \text{det}\left(
\begin{array}{ccccc}
1 & 0 & \cdots & 0 & 0\\
1&a_2-a_1 & \cdots & a_2^{k-3}(a_2-a_1) & a_2^{k-2}(a_2 - a_1)\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
1 & a_{k-1}-a_1 & \cdots & a_{k-1}^{k-3}(a_{k-1}-a_1) & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
1 & a_k-a_1 & \cdots & a_k^{k-3}(a_k-a_1) & a_k^{k-2}(a_k - a_1)
\end{array} \right)\\

&= \text{det}\left(
\begin{array}{ccccc}
1 & 0 & \cdots & 0 & 0\\
0&a_2-a_1 & \cdots & a_2^{k-3}(a_2-a_1) & a_2^{k-2}(a_2 - a_1)\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
0 & a_{k-1}-a_1 & \cdots & a_{k-1}^{k-3}(a_{k-1}-a_1) & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
0 & a_k-a_1 & \cdots & a_k^{k-3}(a_k-a_1) & a_k^{k-2}(a_k - a_1)
\end{array} \right)
\end{aligned}
$$

</div>

を得ます。余因子展開からわかるように

<div class="math display" style="overflow: auto">
$$
\text{det}\left(
\begin{array}{ccccc}
1 & 0 & \cdots & 0 & 0\\
0&a_2-a_1 & \cdots & a_2^{k-3}(a_2-a_1) & a_2^{k-2}(a_2 - a_1)\\
\vdots&\vdots & \cdots & \vdots & \vdots\\
0 & a_{k-1}-a_1 & \cdots & a_{k-1}^{k-3}(a_{k-1}-a_1) & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
0 & a_k-a_1 & \cdots & a_k^{k-3}(a_k-a_1) & a_k^{k-2}(a_k - a_1)
\end{array} \right)=\text{det}\left(
\begin{array}{cccc}
a_2-a_1 & \cdots & a_2^{k-3}(a_2-a_1) & a_2^{k-2}(a_2 - a_1)\\
\vdots & \cdots & \vdots & \vdots\\
a_{k-1}-a_1 & \cdots & a_{k-1}^{k-3}(a_{k-1}-a_1) & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
a_k-a_1 & \cdots & a_k^{k-3}(a_k-a_1) & a_k^{k-2}(a_k - a_1)
\end{array} \right)
$$

</div>

前提ルール3より

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
\text{det}\left(
\begin{array}{cccc}
a_2-a_1 & \cdots & a_2^{k-3}(a_2-a_1) & a_2^{k-2}(a_2 - a_1)\\
\vdots & \cdots & \vdots & \vdots\\
a_{k-1}-a_1 & \cdots & a_{k-1}^{k-3}(a_{k-1}-a_1) & a_{k-1}^{k-2}(a_{k-1} - a_1)\\
a_k-a_1 & \cdots & a_k^{k-3}(a_k-a_1) & a_k^{k-2}(a_k - a_1)
\end{array} \right) &=(a_2-a_1)\cdots(a_k-a_1)\text{det}\left(
\begin{array}{cccc}
1& \cdots & a_2^{k-3} & a_2^{k-2}\\
\vdots & \cdots & \vdots & \vdots\\
1 & \cdots & a_{k-1}^{k-3} & a_{k-1}^{k-2}\\
1 & \cdots & a_k^{k-3} & a_k^{k-2}
\end{array} \right) \\
&= (-1)^k(a_1-a_2)\cdots(a_1-a_k)(-1)^{(k-1)(k-2)/2}{\displaystyle\prod_{2\leq i<j\leq k}}(a_i - a_j)\\
&= (-1)^{k(k-1)/2}{\displaystyle\prod_{1\leq i<j\leq k}}(a_i - a_j)
\end{aligned}
$$

</div>

証明終了。

## 3. Pythonでの計算方法

```py
import numpy as np

def vandermonde(A):
    """
    INPUT: 
        [[  1   2   4   8]
         [  1   3   9  27]
         [  1   4  16  64]
         [  1   5  25 125]]
    
    Returns: 
        determinant
    """
    det = 1
    #array_size = A.shape[0]
    #col_array = A[:, 1]
    col_array = [i[1] for i in A]
    array_size = len(col_array)


    for i in range(array_size):
        for j in range(i):
            det *= (col_array[j] - col_array[i])

    return det * (-1) ** (array_size*(array_size-1)/2)

def main():
    A = np.vander(np.arange(2, 6))[:, ::-1]
    A = [l.tolist() for l in list(A)]
    res = vandermonde(A)
    print(res)

if __name__ = 'main':
  main()
```
