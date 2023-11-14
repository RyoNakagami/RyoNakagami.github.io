---
layout: post
title: "Convert list of ints to one number"
subtitle: "Pythonista Tips 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-10-08
tags:

- Python
- 競技プログラミング
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem](#problem)
- [Solution](#solution)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## Problem

```python
nums = [1, 5, 8, 9, 2, 1]
```

上記のように1桁の`int`を要素とする`num`リストが与えられているとする. 
このとき, 左から数えてn個目の要素が桁を表しているして, そのの整数計算したいとする.

例として, 

```python
func([1, 5, 8, 9, 2, 1])
>> 158921

func([1, 5])
>> 15

func([0, 5])
>> 5
```

## Solution

```python
from functools import reduce

def conver_to_singleint(array):
    return reduce(lambda a, b: a**10 + b, array)
```

また, 本件とは関係ないが要素が`str`の場合は

```python
def conver_str_to_singleint_1(array):
    return int(reduce(lambda a, b: a + b, array))

def conver_str_to_singleint_2(array):
    num = int(''.join(array))
```
