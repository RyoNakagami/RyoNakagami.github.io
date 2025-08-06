---
layout: post
title: "Gaussian Elimination, LU Decomposition"
subtitle: "数値計算入門 1/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-12-06
header-mask: 0.0
header-style: text
tags:

- 数値計算

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Gaussian Elimination](#gaussian-elimination)
  - [Lower-triangular matrixとback-substitution](#lower-triangular-matrix%E3%81%A8back-substitution)
  - [LU decomposition](#lu-decomposition)
- [Appendix](#appendix)
  - [Sparse vs. Dense](#sparse-vs-dense)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## Gaussian Elimination

連立一次方程式を解くための(多項式時間)アルゴリズムとして用いられる「Gaussian elimination, ガウスの消去法」を紹介します.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Algorithm: Gaussian Elimination</ins></p>

Objective: Solve \\(Ax = b\\)

- Step 1: Compute the LU decomposition of \\(A\\)
- Step 2: Solve \\(Lz = b\\) for \\(z\\) by back-substitution
- Step 3: Solve \\(Ux = z\\) for \\(x\\) by back-substitution

</div>

説明にあたって, 単純なケースであるtriangular matrixで考え, その後一般的なケースを以下にしてtriangular matrixの問題に帰着させるかという順番で紹介します.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: lower triangular matrix</ins></p>

lower triangular matrixとはnon-zero要素が対角または対角より下側に存在する次のような行列を指す:

$$
A = \left(\begin{array}{cccc}
a_{11} & 0 & \cdots & 0\\
a_{21} & a_{22} & \cdots & 0\\
\vdots & \vdots & \ddots & \vdots\\
a_{n1} & a_{n2} & \cdots & a_{nn}\end{array}\right)
$$

</div>

(upper or lower) triangular matrixの重要な性質の一つとして, 

- 対角要素がnon-zerosならばtriangular matrixは正則行列
- triangular matrixが正則行列ならば対角要素はnon-zeros

### Lower-triangular matrixとback-substitution

対角要素がnon-zerosのLower triangular matrixが与えられたとき, back-substitutionでナイーブに解くことができます:

$$
\begin{align*}
x_1 &= \frac{b_1}{a_{11}}\\[3pt]
x_k &= \frac{b_k - \sum_{j=1}^{k-1}a_{kj}x_j}{a_{kk}}
\end{align*}
$$

Upper triangularの場合は$x_{n} = b_n/a_{nn}$から始めて

$$
x_k = \frac{b_k - \sum_{j={k+1}}^{n}a_{kj}x_j}{a_{kk}}
$$

で解くことができます. この方法は直感的ですが, 計算時間に着目すると$n(n-1)/2$回のaddition/subtractionの計算を行っており$O(n^2)$の計算時間が発生します.

{% include plotly/20210206_gauusian_elimination.html %}


> Pythonでの確認

```python
import numpy as np
import time
import plotly.express as px


def back_substitution(A, b):
    res = np.array([b[0]/A[0,0]])

    for i in range(1, len(b)):
        size = len(res)
        numerator = b[i]
        for j in range(size):
            numerator -= A[i][j] * res[j]
        denom = A[i, i]
        res = np.append(res, numerator / denom)
    return res


def generate_array(size):
    A = np.tril(np.random.randint(1, 
                                  10, 
                                  size*size).reshape(size, size), 0)
    b = np.random.randint(1, 10, size)
    return A, b

## simulation
np.random.seed(42)
max_iter = 30
size_list = np.arange(3, 100)
time_res = []

for size in size_list:
    tmp_time = []
    for i in range(max_iter):
        A, b = generate_array(size)

        start_time = time.time()
        x = back_substitution(A, b)
        tmp_time.append(time.time() - start_time)

    time_res.append(np.mean(tmp_time))
    
fig = px.line(x=size_list, 
              y=time_res,
              title='back-substitutionはO(n^2)の計算時間が発生する')
fig.show()
```

### LU decomposition

triangularではない一般的な行列に対して$Ax = b$を解くにあたって, LU decomposition methodがあります.

$$
A = LU
$$

- $L$: Lower triangular matrix
- $U$: Upper triangular matrix

と分解できるとすると

$$
\begin{align*}
Ax &= b\\
\Rightarrow LUx &= b
\end{align*}
$$

となり, 一度$Lz = b$を解いて得られた解を$z$とすると$Ux = z$を解くことで$Ax = b$の解が得られます. 
つまり, LU decompositionは一般的な連立一次方程式問題を２つの三角行列で表現された連立方程式問題へ帰着させる手法です.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: LU decomposition</ins></p>

$a_{11}\neq 0$とする$A=(a_{ij})$という$n\times n$の行列が与えられたとします. まずupper triangular matrixを得るために以下のStepを実行します.

> Step 1

$i=2,\cdots,n$それぞれについて$l^{1}_{i1}$を以下のように定義します

$$
l^{1}_{i1} = \frac{a_{i1}}{a_{11}}
$$

次に, \\(j = 1, \cdots, n\\)に対して

$$
a^2_{ij}=a_{ij}-l^1_{i1}a_{1j}
$$

を計算し, その結果得られた\\(a^2_{ij}\\)からなる行列を\\(A^{(1)}\\)とする. この行列について

$$
a_{1j} = 0 \  \ \forall j \in \{2, \cdots, n\} 
$$

そして, \\(A^{(1)} = A\\)と行列をupdateする

> Step 2以降

Step 1を以下のルールに従って繰り返す. $a_{kk}\neq 0$であるとき, 

$$
\begin{align*}
&l_{ij}^k = \begin{cases}
\frac{a^k_{ik}}{a_{kk}}, & j=k, i=k+1, \cdots, n\\[3pt]
0, & \text{otherwise}
\end{cases}\\[5pt]

&a_{ij}^{k+1} = \begin{cases}
a^{k}_{ij} - l^k_{ik}a^k_{kj}, & i=k+1, \cdots, n, j=k, \cdots, n, \\[3pt]
a^{k}_{ij}, & \text{otherwise}
\end{cases}
\end{align*}
$$

つまり,

$$
A^{(k+1)} = \underbrace{\left[I - \left(
\begin{array}{cccccc}
0      & \cdots & 0      & 0             & \cdots & 0\\
\vdots & \ddots & \vdots & \vdots        & \vdots & \vdots \\
0      & \cdots & 0      & l_{k+1, k}^k  & \cdots & 0\\
\vdots & \ddots & \vdots & \vdots        & \vdots & \vdots \\
0      & \cdots & 0      & l_{n, k}^k  & \cdots & 0\\
\end{array}
\right)\right]}_{L^{(k)}}A^{(k)}
$$

これを\\(A^{(n)}\\)まで繰り返す. \\(A^{(n)}\\)はupper triangular matrixとなる. また,

$$
L^{(n-1)}L^{(n-2)}\cdots L^{(2)}L^{(1)}A = A^{(n)} \equiv U
$$

なので\\(L \equiv (L^{(n-1)}L^{(n-2)}\cdots L^{(2)}L^{(1)})^{-1}\\)とすると$L$がlower triangular matrixであることがわかる. なお$L$の形状は

$$
L=\left[
\begin{array}{cccccc}
1 & & & & & \\
l_{21} & 1 & & & O & \\
l_{31} & l_{32} & 1 & & & \\
l_{41} & l_{42} & l_{43} & 1 & & \\
\vdots & \vdots & \vdots & & \ddots & \\
l_{n1} & n_{n2} & l_{n3} & \ldots & l_{n,n-1} & 1
\end{array}
\right]
$$

</div>

上記に基づいて`numpy`でメモリ効率的にLU decompositionをGaussian Eliminationで求めると以下のようになります

```python
import numpy as np

# LU decomposition of square systems
def gaussian_elimination(A):
    A = A.copy()
    m=A.shape[0]
    n=A.shape[1]
    if(m!=n):
        print('Matrix is not square!')
        return
    for k in range(0,n-1):
        if A[k,k] == 0:
            return
        for i in range(k+1,n):
            # l_{ij}の計算
            A[i,k]=A[i,k]/A[k,k]
        for j in range(k+1,n):
            # u_{ij}の計算
            for z in range(k+1,n):
                A[z,j]-=A[z,k]*A[k,j]

    L = np.tril(A, -1) + np.identity(n, dtype=int)
    U = A - np.tril(A, -1)

    return L, U
```

上記では$L, U$は行列$A$から一部抽出で計算されていますが, その理由は内部的に以下のような形で行列$A$が計算されているかです:

$$
\begin{split}A=\left[
\begin{array}{ccccc}
u_{11} & u_{12} & u_{13} & \ldots & u_{1n} \\
l_{21} & u_{22} & u_{23} & \ldots & u_{2n} \\
l_{31} & l_{32} & u_{33} & \ldots & u_{3n} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
l_{n1} & l_{n2} & \ldots & l_{n-1,n} & u_{nn}
\end{array}
\right]\end{split}
$$

> REMARKS

- 上記のアルゴリズムでは$a_{kk}=0$で計算がストップするので, 元行列に対してpivotingを行う必要があります
- また, pivottingを行ったとしても$a_{kk}$が十分小さい値のときはアンダーフローなどの数値誤差によって計算がストップする可能性もあります
- ストップしなかったとしても累積誤差の関係から正確に計算することは難しいので, 基本的には自分で実装するのではなくLAPACKなどのライブラリーを用いて計算することが推奨されます


## Appendix
### Sparse vs. Dense

線形問題をSparseとDenseという言葉を用いてJuddで以下のように分類されています:

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: Sparse vs. Dense</ins></p>


線形問題は行列 $A$ の要素(entries)に応じて２つに分類することができる:

- dense: 要素 $a_{ij}$ の大半が$a_{ij}\neq 0$
- sparse: 要素 $a_{ij}$ の大半が$a_{ij}=0$

</div>

これは厳密な定義ではないですが, 線形問題を考えるとき sparse vs. denseを意識することは重要とのこと.




References
------------
- [Numerical Methods in Economics, Kenneth L. Judd](https://numericalmethodsineconomics.com/)
- [LU Decomposition](https://orionquest.github.io/Numacom/lu_decomp.html#lu-decomposition)
