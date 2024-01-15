---
layout: post
title: "条件を満たす整数の選び方について"
subtitle: "組合せ論 4/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-16
header-mask: 0.0
header-style: text
tags:

- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [差が２以上の整数の選び方](#%E5%B7%AE%E3%81%8C%EF%BC%92%E4%BB%A5%E4%B8%8A%E3%81%AE%E6%95%B4%E6%95%B0%E3%81%AE%E9%81%B8%E3%81%B3%E6%96%B9)
  - [差が5の場合](#%E5%B7%AE%E3%81%8C5%E3%81%AE%E5%A0%B4%E5%90%88)
- [AIME 1998: 合計が98となる４つの正の奇数の組](#aime-1998-%E5%90%88%E8%A8%88%E3%81%8C98%E3%81%A8%E3%81%AA%E3%82%8B%EF%BC%94%E3%81%A4%E3%81%AE%E6%AD%A3%E3%81%AE%E5%A5%87%E6%95%B0%E3%81%AE%E7%B5%84)
- [ARML 1999: 連続する４つ要素の合計が3で割り切れる並べ方](#arml-1999-%E9%80%A3%E7%B6%9A%E3%81%99%E3%82%8B%EF%BC%94%E3%81%A4%E8%A6%81%E7%B4%A0%E3%81%AE%E5%90%88%E8%A8%88%E3%81%8C3%E3%81%A7%E5%89%B2%E3%82%8A%E5%88%87%E3%82%8C%E3%82%8B%E4%B8%A6%E3%81%B9%E6%96%B9)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 差が２以上の整数の選び方

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

18以下の正の整数から, どの２つの差も2以上であるような5個の整数を選び出す方法は何通りあるか？ ただし,
順番を変えただけの選び出し方は同一のものと考える

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

問題の条件を満たすような選び出し方$a_1< a_2 < a_3 < a_4 < a_5$が与えられたとする. このとき,

$$
(b_1, b_2, b_3, b_4, b_5) = (a_1, a_2-1, a_3-2, a_4-3, a_5-4)
$$

とすると相異なる14以下の整数$b_1< b_2 < b_3 < b_4 < b_5$が得られる. 逆に相異なる14以下の整数$b_1< b_2 < b_3 < b_4 < b_5$が与えられるとすると, その組み合わせは
$(a_1, a_2, a_3, a_4, a_5)$と1対1に対応する. 

従って, 

$$
_{14}\text{C}_5 = 2002\text{通り}
$$

</div>

### 差が5の場合

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

50以下の正の整数から, どの２つの差も5以上であるような5個の整数を選び出す方法は何通りあるか？ ただし,
順番を変えただけの選び出し方は同一のものと考える

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

問題の条件を満たすような選び出し方$a_1< aa_2\equiv a_6 \bmod 3_2 < a_3 < a_4 < a_5$が与えられたとする. このとき,

$$\text{C}
(b_1, b_2, b_3, b_4, b_5) = (a_1, a_2-4, a_3-8, a_4-12, a_5-16)
$$

とすると相異なる36以下の整数$b_1< b_2 < b_3 < b_4 < b_5$が得られる. 逆に相異なる36以下の整数$b_1< b_2 < b_3 < b_4 < b_5$が与えられるとすると, その組み合わせは
$(a_1, a_2, a_3, a_4, a_5)$と1対1に対応する. 

従って, 

$$
_{36}\text{C}_5 = 278256\text{通り}
$$

</div>

実際にPythonで確かめても同様の答えが確認できました

```python
from itertools import combinations

def choose_numbers(n, k=5):
    return combinations(range(1, n+1), k)

def check_diff(Array, thresh=2):
    i = 1
    while i < len(Array):
        diff = Array[i] - Array[i-1]
        if diff < thresh:
            return False
        i += 1
    return True

def count_groups(n, k, thresh):
    return sum((map(lambda x: check_diff(x, thresh), choose_numbers(n, k))))

count_groups(50, 5, 5)
>>> 278256
```

また, この問題より満たすべき差が$m$のとき

$$
(b_1, b_2, b_3, b_4, b_5) = (a_1, a_2-(m-1), a_3-2(m-1), a_4-3(m-1), a_5-4(m-1))
$$

になることがわかります. $N$以下の正の整数という問題が与えられたら求めるべき答えは $_{N- 4(m-1)}\text{C}_5$ 通りとなります.

## AIME 1998: 合計が98となる４つの正の奇数の組

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
x_1 + x_2 + x_3 + x_4 = 98
$$

を満たす正の奇数の組はいくつあるか？

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解法</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$x_i$を$2y_i - 1$ ( ただし, $y_i$は正の整数)と置き換えると

$$
\begin{align*}
98 = \sum_{i=1}^4(2y_i - 1)
\end{align*}
$$

従って,

$$
51 = \sum_{i=1}^4 y_i \ \ \text{where } y_i > 0
$$

を満たす組を見つければ良い. 従って, $_{50}\text{C}_3 = 19600$通り.

</div>

## ARML 1999: 連続する４つ要素の合計が3で割り切れる並べ方

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
21, 31, 41, 51, 61, 71 ,81
$$

を1列にならべ, どの連続する4つの数を取り出してもその和が3で割り切れるようにしたい. 
そのような並べ方は何通りあるか？

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\{21, 31, 41, 51, 61, 71 ,81\}$について$\bmod 3$をとると

$$
0, 1, 2, 0, 1, 2, 0
$$a_2\equiv a_6 \bmod 3

となる. 

条件を満たす並べ方, $a_1, a_2, a_3, a_4, a_5, a_6, a_7$としたとき

$$
\begin{align*}
0 &\equiv (a_1 + a_2 + a_3 + a_4) + (a_4 + a_5 + a_6 + a_7)\\
  &\equiv (a_1 + a_2 + a_3 + a_4 + a_5 + a_6 + a_7) + a_4\\
  &\equiv a_4 \bmod 3
\end{align*}
$$

となるので

$$
\begin{align*}
0 &\equiv a_4 \bmod 3\\
0 &\equiv (a_1 + a_2 + a_3) \bmod 3\\
\Rightarrow & (a_1, a_2, a_3)\text{は}0,1,2\text{の並べ替え}
\end{align*}
$$

また, 

$$
\begin{align*}
&(a_1 + a_2 + a_3 + a_4) \equiv (a_2 + a_3 + a_4 + a_5) \bmod 3\\
&\Rightarrow a_1 \equiv a_5 \bmod 3
\end{align*}
$$

同様にのやり方で, $a_2\equiv a_6 \bmod 3, a_3\equiv a_7 \bmod 3$を得るので

並び方は

$$
3!\times 3! \times 2! \times 2! = 144\text{通り}
$$

</div>

