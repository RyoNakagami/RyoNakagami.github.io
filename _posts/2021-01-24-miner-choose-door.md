---
layout: post
title: "Trapped Miner Problem"
subtitle: "確率と数学ドリル 4/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-14
header-mask: 0.0
header-style: text
tags:

- math
- 統計

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [鉱山に閉じ込められた作業員問題](#%E9%89%B1%E5%B1%B1%E3%81%AB%E9%96%89%E3%81%98%E8%BE%BC%E3%82%81%E3%82%89%E3%82%8C%E3%81%9F%E4%BD%9C%E6%A5%AD%E5%93%A1%E5%95%8F%E9%A1%8C)
- [期待値の導出](#%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [期待値の導出別解](#%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AE%E5%B0%8E%E5%87%BA%E5%88%A5%E8%A7%A3)
- [分散の導出](#%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Pythonで数値確認](#python%E3%81%A7%E6%95%B0%E5%80%A4%E7%A2%BA%E8%AA%8D)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 鉱山に閉じ込められた作業員問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

作業員が３つのドアを持つ鉱山内に閉じ込められた. 

- Door A: 2時間で出口にでる
- Door B: 3時間後に最初のドア選択地点に戻る
- Door C: 5時間後に最初のドア選択地点に戻る

作業員がどのドアを選ぶかは等しく同じで1/3とする. このとき出口にたどり着くまでの時間を$T$としたとき, 
$T$の期待値と分散を求めよ.

</div>

$T$が最初の状態からゴールまでにたどり着く時間の確率変数を表していて, 
毎回初期状態にもどり過去と独立にドアを選択することに留意して解きます.

## 期待値の導出

$D_i, i \in \{A, B, C\}$をドアの選択を表す確率変数とすると$\mathbb E[T]$は以下のように表現できる

$$
\begin{align*}
\mathbb E[T] &= \mathbb E[\mathbb E[T|D_i]]\\[3pt]
             &= \mathbb E[T|D_A]\Pr(D_A) + \mathbb E[T|D_B]\Pr(D_B) + \mathbb E[T|D_C]\Pr(D_C)\\[3pt]
             &= \mathbb 2 \times \Pr(D_A) + \mathbb E[3 + T]\Pr(D_B) + \mathbb E[5 + T]\Pr(D_C)\\[3pt]
             &= \frac{1}{3}(2 + 3 + 5 + 2\mathbb E[T])
\end{align*}
$$

上記を整理すると, $\mathbb E[T] = 10$とわかる

### 期待値の導出別解

作業員がゴールするまでに開いたドアの回数を$N$という確率変数で表すと, $N=n$のとき作業員は
$n-1$回A以外のドアを開いて最後にAのドアを選択するので, 

$$
\begin{align*}
\mathbb E[T\vert N=n] &= \bigg(\frac{1}{3}\sum_{k=0}^{n-1}\frac{1}{3^k}\frac{1}{3^{n-k}}\bigg)^{-1}\sum_{0\leq k \leq n-1}\frac{3k + 5(n-1-k) + 2}{3^n}\bigg(\begin{array}{c}n-1\\k\end{array}\bigg)\\[3pt]
&= \frac{3^n}{2^{n-1}}\frac{1}{3^n}\bigg[(5n-3)\sum\bigg(\begin{array}{c}n-1\\k\end{array}\bigg) - 2\sum k\bigg(\begin{array}{c}n-1\\k\end{array}\bigg)\bigg]\\
&= \frac{3^n}{2^{n-1}}\frac{1}{3^n}[2^{n-1}(5n-3) - 2\times2^{n-2}(n-1)]\\[3pt]
&= \frac{3^n}{2^{n-1}}\frac{2^{n-1}}{3^n}(4n-2)\\
&= (4n-2)
\end{align*}
$$

したがって,

$$
\begin{align*}
\mathbb E[T] &= \mathbb E[\mathbb E[T\vert N=n]]\\[3pt]
             &= \sum_n \mathbb E[T\vert N=n] \Pr(N=n)\\[3pt]
             &= \sum_{n\geq1}(4n-2)\frac{1}{3}\sum_{k=0}^{n-1}\frac{1}{3^k}\frac{1}{3^{n-k}}\\[3pt]
             &= \sum_{n\geq1}\frac{2^{n-1}}{3^n}(4n-2)\\[3pt]
             &= 12 - 2 = 10
\end{align*}
$$

と計算できます.

## 分散の導出

上記で期待値は$\mathbb E[T] = 10$とわかっているので $\mathbb E[T^2]がわかれば分散が導出できる.

期待値と同様に

$$
\begin{align*}
\mathbb E[T^2] &= \mathbb E[\mathbb E[T^2|D_i]]\\[3pt]
             &= \mathbb E[T^2|D_A]\Pr(D_A) + \mathbb E[T^2|D_B]\Pr(D_B) + \mathbb E[T^2|D_C]\Pr(D_C)\\[3pt]
             &= \mathbb 2^2 \times \Pr(D_A) + \mathbb E[(3 + T)^2]\Pr(D_B) + \mathbb E[(5 + T)^2]\Pr(D_C)\\[3pt]
             &= \frac{1}{3}(4 + 9 + 25 + (6 + 10)\mathbb E[T] + 2\mathbb E[T^2])
\end{align*}
$$

$\mathbb E[T] = 10$とわかっているので

$$
\mathbb E[T^2] = 38 + 160
$$

したがって, $V(T) = 198 - 100 = 98$.

## Pythonで数値確認

上記と同じ問題設定で$\mathbb E[T] = 10$と$V(T) = 98$をPythonで簡易的に確認してみます.
設定としては, 

- Recursive programmingでMinerの意思決定を表現する（閾値は設けない）
- ゴールするまでを一回として, 2,000,000回シミュレーションする
- 2,000,000回分のゴールまでの時間配列を対象に平均と分散を計算する


```python
import numpy as np
from multiprocessing import Pool

np.random.seed(42)

def choose_door(T=0):
    door = np.random.choice([0, 1, 2], p=[1/3, 1/3, 1/3])

    if door == 0:
        return T + 2
    elif door == 1:
        return choose_door(T=T+3)
    elif door == 2:
        return choose_door(T=T+5)

def wrapper(iter):
    return choose_door(T=0)

with Pool(processes=30) as pool:
    res = pool.map(wrapper, range(1, 2000000))

print(np.mean(res), np.var(res))
>>> 10.022142511071255 98.45919243904486
```

とそこそこ近い値が出力されることが一応確認できました.








References
---------

- [StackExchange > Probability brain teaser with infinite loop](https://math.stackexchange.com/questions/2521890/probability-brain-teaser-with-infinite-loop)