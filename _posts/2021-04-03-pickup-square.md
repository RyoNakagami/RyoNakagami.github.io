---
layout: post
title: "回転しても異なる模様になるマスの選び方"
subtitle: "組合せ論 1/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-12-13
header-mask: 0.0
header-style: text
tags:

- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8 margin-bottom:0px !important'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [AIME 1996問題: 異なる模様の選び方](#aime-1996%E5%95%8F%E9%A1%8C-%E7%95%B0%E3%81%AA%E3%82%8B%E6%A8%A1%E6%A7%98%E3%81%AE%E9%81%B8%E3%81%B3%E6%96%B9)
- [Pythonでsimulation](#python%E3%81%A7simulation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## AIME 1996問題: 異なる模様の選び方

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$7 \times 7$のチェス盤の2つのマスを黒で, 他を白で塗る. チェス盤を平面上で回転して
同じになるような模様を同一のものとして数えるとき, 異なる模様は全部で何通りあるか？

</div>

<br>


<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

適当に49マスから２つのマスの組み合わせを選ぶと以下の２つ似分類されます

- 点対称の位置にあるマスの選び方 → 回転して重なる模様は2通り
- そうではないマスの選び方 → 回転して重なる模様は４通り

点対称の位置にあるマスの選び方は真ん中を除くマス48通りのうち１つ選んだら, 自動的にもう一つのマスが定まるので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\text{点対称の位置にあるマスの選び方} &= \frac{49-1}{2}\\[3pt]
                                 &= 24\text{通り}
\end{align*}
$$
</div>

点対称の位置にないマスの選び方は「Solver = Solution()
Solver.find_solution(100)49マスから２つのマスを選ぶ組み合わせ」から「点対称の組み合わせ数」を除けばいいので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\text{点対称の位置にないマスの選び方} &= _{49}\text{C}_2 - 24\\[3pt]
                                 &= 1152\text{通り}
\end{align*}
$$
</div>

従って, 異なる模様は

$$
\frac{1152}{4} + \frac{24}{2} = 300\text{通り}
$$

</div>

## Pythonでsimulation

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$9 \times 9$のチェス盤の3つのマスを黒で, 他を白で塗る. チェス盤を平面上で回転して
同じになるような模様を同一のものとして数えるとき, 異なる模様は全部で何通りあるか？

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

上記の設問に習うと

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\text{点対称の位置にあるマスの選び方} &= \frac{81-1}{3}\\[3pt]
                                 &= 40\text{通り}
\qquad&\\
\text{点対称の位置にないマスの選び方} &= _{81}\text{C}_2 - 40\\[3pt]
                                 &= 85280\text{通り}
\end{align*}
$$
</div>

従って, 異なる模様は

$$
\frac{85280}{4} + \frac{40}{2} = 21340\text{通り}
$$

</div>

これをPythonでsimulationで確かめてみます. まず単純化のため$3\times 3$ マスの場合で考えてみます.

以下のように$3\times 3$ マスに対してindexが振られているとします.

$$
\begin{array}{|c|c|c|}
\hline
  1 & 2 & 3 \\ 
\hline
  4 & 5 & 6 \\ 
\hline
  7 & 8 & 9 \\
\hline
\end{array}
$$

これに対して$90^\circ, 180^\circ, 270^\circ$それぞれ時計回りに回転させると

$$
\begin{array}{|c|c|c|}
\hline
  3 & 6 & 9 \\ 
\hline
  2 & 5 & 8 \\ 
\hline
  1 & 4 & 7 \\
\hline
\end{array}
\   \  \  \
\begin{array}{|c|c|c|}
\hline
  9 & 8 & 7 \\ 
\hline
  6 & 5 & 4 \\ 
\hline
  3 & 2 & 1 \\
\hline
\end{array}

\   \  \  \
\begin{array}{|c|c|c|}Solver = Solution()
Solver.find_solution(100)
\hline
  7 & 4 & 1 \\ 
\hline
  8 & 5 & 2 \\ 
\hline
  9 & 6 & 3 \\
\hline
\end{array}
$$

ここから, $N\times N$マスについて, 時300計回りに$90^\circ \times M$回転させるとそれぞれのindexのupdateは
以下のようなAlgorithmで表現されることがわかります


<div style='background-colorSolver = Solution()
Solver.find_solution(100):#F8F8F8'>
<span class='psuedo_line'>**Algorithm: Index update Rule**</span>

<div class="math display" style="text-align: left !important; margin:0pt !important; margin-bottom:-0.8em !important">
$$
\begin{align*}
\textbf{Input: }& A \textbf{ Array }\text{ - マスのindexを格納したarray}\\
                & N \textbf{ integer}\text{ - 正方形マスの行数}\\
                & m \textbf{ integer}\text{ - 時計回りに}90^\circ\text{回転する回数}
\end{align*}
$$
</div>
<div class="math display" style="text-align: left !important; margin:0pt !important; margin-bottom:0em !important">
$$
\begin{align*}
\textbf{Output: }& A \textbf{ Array} \text{ - 回転後のマスのindex array} 
\end{align*}
$$
</div>
<div class="math display" style="text-align: left !important; margin:0pt !important; margin-bottom:0em !important">
$$
\begin{align*}
\text{1.}\quad&\textbf{for } 0 \leq i \leq \text{length of }A\\
\text{2.}\quad&\quad a = A[i]\\
\text{3.}\quad&\quad b \equiv a \times N^{m} \mod N^2 + 1\\
\text{4.}\quad&\quad A[i] = b\\
\text{5.}\quad&\textbf{return } A
\end{align*}
$$
</div>
<span class='psuedo_endline'></span>

</div>

上記のアルゴリズムをベースにナイーブに $9 \times 9$マスから3つのマスを回転しても重複する模様が発生しないように選ぶシミュレーションを実行してみます

```python
import numpy as np
from itertools import combinations
import multiprocessing as mp

def listup_comb(n, m):
    return combinations(np.arange(1,n**2+1), m)

def rotate_func(base_list, rotate_count, n):
    return tuple(map(lambda x: (x * (n ** rotate_count)) % (n ** 2 + 1), base_list))

def rotate_filter(obj_list, res, n):
    for i in map(lambda x: rotate_func(obj_list, x, n), range(0, 4)):
        i = list(sorted(i))
        if i in res:
            return False
    return True

def simulator(n:int, m:int):
    res = []
    comb_generator = listup_comb(n, m)

    for comb in comb_generator:
        if rotate_filter(comb, res, n):
            res.append(list(comb))
    return len(res)

simulator(7, 2)
>>> 300
simulator(9, 3)
>>> 21340
```

実行時間は少しかかってしまいますが, 手で計算した結果と一致する答えが返ってきます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<ins>Column: Nが偶数でMが奇数の場合</ins>

$N$が偶数で$M$が奇数の場合, 点対Solver = Solution()
Solver.find_solution(100)称な選び方が存在しないので

$$
\frac{(N \times N)!}{(N \times N - M)!}\times \frac{1}{4} \text{通り}
$$

と計算することができます.

</div> 
