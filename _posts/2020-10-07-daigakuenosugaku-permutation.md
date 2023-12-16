---
layout: post
title: "数字の並べ替え"
subtitle: "確率と数学ドリル 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mermaid: false
mathjax: true
last_modified_at: 2023-12-16
tags:

- math
- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題](#%E5%95%8F%E9%A1%8C)
- [Python Implementation](#python-implementation)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## 問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

1から9までの数字から異なる5個をとって作った順列のうち, 次の条件を満たすものの個数を求めよ

1. 奇数番目に必ず奇数がある
2. 奇数は必ず奇数番目にある

</div>

要素5つの配列を考えたとき, 上記を満たす配列の数を求める問題です. ただし配列のindexは1から始まるものという感じです.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(1)の解答]</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

奇数番目に必ず奇数があるので, 

- index 1, 3, 5に注目した順列
- 残りの偶数indexの順列

の積が答えとなります. 


$$
\begin{align*}
\text{index 1, 3, 5に注目した順列の個数} &= {}_5P_3\\
&= 60
\end{align*}
$$

$$
\begin{align*}
\text{index 2, 4に注目した順列の個数} &= {}_6P_2\\
&= 30
\end{align*}
$$

したがって, 答えは$1800$個.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(2)の解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

偶数はたかだか4個しかないので, 奇数が使用される１個, 2個, 3個で場合分けして計算するのも一つの方法ですが, 対偶をとると(1)と同じ考えで個数を計算することができます.

- 条件: 奇数は必ず奇数番目にある
- 対偶: 奇数番目でないならば, 奇数ではない
- 対偶の言い換え: 偶数番目ならば, 偶数


したがって, (1)を偶数に置き換えたものが答えとなります


$$
\begin{align*}
\text{index 2, 4に注目した順列の個数} &= {}_4P_2\\
&= 12
\end{align*}
$$

$$
\begin{align*}
\text{index 1, 3, 5に注目した順列の個数} &= {}_7P_3\\
&= 210
\end{align*}
$$

したがって, 答えは$2520$個.

</div>

## Python Implementation

list sizeのerror判定は実装していないですが, generator functionを用いて網羅的に(1)の答えを
リストアップするclassは以下です.

```python
from itertools import permutations
from typing import List

class OddEvenPermutation:
    """
    Usage
        Solver = OddEvenPermutation(5, [1, 3, 5], [2, 4])
        perm = Solver.generator()
        print(next(perm))
    """
    def __init__(self, length, group_odd: List, group_even:List):
        self.length = length
        self.group_odd = group_odd
        self.group_even = group_even
        self.odd_length = int((length + 1) // 2)
        self.even_length = self.length - self.odd_length

    def generator(self):
        for odd_perm in permutations(self.group_odd, self.odd_length):
            odd_perm = list(odd_perm)
            non_used_odd = list(set(self.group_odd) - set(odd_perm))
            total_group = non_used_odd + self.group_even
            for even_perm in permutations(total_group, self.even_length):
                even_perm = list(even_perm)
                combined_perm = []
                for i in range(self.even_length):
                    combined_perm.extend([odd_perm[i], even_perm[i]])
                if self.odd_length > self.even_length :
                    combined_perm.append(odd_perm[-1])
                yield combined_perm

Solver = OddEvenPermutation(5, [1, 3, 5, 7, 9], [2, 4, 6, 8])
perm = Solver.generator()
print(len(list(perm)))
>>> 1800
```

References
------------

- [Ryo's Tech Blog > Generator: yield and filter](https://ryonakagami.github.io/2021/09/02/Python-generator/)