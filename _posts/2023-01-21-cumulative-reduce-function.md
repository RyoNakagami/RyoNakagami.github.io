---
layout: post
title: "Arrayに対する任意のReduce Operationの定義の仕方"
subtitle: "itertools.accumulate の確認"
author: "Ryo"
header-img: "img/cpu.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-01-26
purpose: 
tags:

- Python
- 前処理
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [`itertools.accumulate` を用いた関数定義](#itertoolsaccumulate-%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E9%96%A2%E6%95%B0%E5%AE%9A%E7%BE%A9)
  - [`itertools.accumulate` はどんな関数なのか？](#itertoolsaccumulate-%E3%81%AF%E3%81%A9%E3%82%93%E3%81%AA%E9%96%A2%E6%95%B0%E3%81%AA%E3%81%AE%E3%81%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## やりたいこと

任意の正の実数 $x$ に対して，

$$
\Gamma(x+1) = x\Gamma(x)
$$

というガンマ関数の性質を`math.gamma`を用いずに表現したい.
具体的には, index 0 の値が `1` から始まる任意の長さの等差 `1` の数列を表現する `array` が 
`input` として与えられたら

```python
def compute_cumprod(array):
    return [reduce(a * (b-1), array[:i]) for i in range(1, len(array)+1)]
```

と同じ結果が返ってくる関数をもっとうまい表現で書くことがゴールです.

### `itertools.accumulate` を用いた関数定義

```python
from itertools import accumulate

def compute_cumprod(array):
    return list(accumulate(array, lambda a, b: a*(b-1)))

x_array = np.arange(1, 6)
compute_cumprod(x_array)
>>> [1, 1, 2, 6, 24]
```

### `itertools.accumulate` はどんな関数なのか？

`accumulate`は, 第2引数として関数を受け付け, この引数が要素を一つにまとめた値を計算する際に使われます.
なお, この関数は2個の引数を受け付け, 1個の値を返すものでなければなりません.

ループ系の関数が呼び出されるような時, 状態を記憶しながら要素の反復処理をし, 更にその結果をリストとして返してくれる関数という
理解を僕はしています.

> 第2引数をしてしなかった場合は加算処理を返す

```python
from itertools import accumulate
import numpy as np
print(list(accumulate(np.arange(1, 10, 2))))
>>> [1, 4, 9, 16, 25]
```


## References

> stack overflow

- [Is there a function like `cumreduce` along the lines of `numpy.cumsum` or `numpy.cumprod` in python?](https://stackoverflow.com/questions/57797301/is-there-a-function-like-cumreduce-along-the-lines-of-numpy-cumsum-or-numpy)