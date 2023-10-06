---
layout: post
title: "Single Number - Leetcode 136"
subtitle: "Python: Competitive Programming 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-09-28
tags:

- 競技プログラミング
- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem](#problem)
- [Solution](#solution)
  - [XORと結合法則](#xor%E3%81%A8%E7%B5%90%E5%90%88%E6%B3%95%E5%89%87)
  - [O(1) memory space](#o1-memory-space)
  - [Python Solution](#python-solution)
    - [PythonにおけるXOR](#python%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Bxor)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Problem

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: Single Number</ins></p>

Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

You must implement a solution with a linear runtime complexity and use only constant extra space.

 
Example 1:

Input: `nums = [2,2,1]`<br>
Output: 1<br>

Example 2:

Input: `nums = [4,1,2,1,2]`<br>
Output: 4<br>

Example 3:

Input: `nums = [1]`<br>
Output: 1
 

Constraints:

$1$ <= `nums.length` <= $3 * 10^4$

$-3 * 10^4$  <= `nums[i]` <= $3 * 10^4$

Each element in the array appears twice except for one element which appears only once.

</div>


この問題のポイントとして, 

- 一つの例外を除いて, intgersは偶数回(2回出現する)
- array lengthに対して, Linear runtime complexity, i.e., $O(n)$
- extra memory spaceしか使えない, i.e.,  $O(1)$ memory space

extra memory spaceしか使えないのでhash tableは今回使用できません.

## Solution

「**一つの例外を除いて, intgersは偶数回(2回出現する)**」というポイントから
bitwise XORを連想できるかがキーポイントとなります.

例として, Example 2を見たとき, これを２進数変換してみます

```python
## the given list
nums = [4,1,2,1,2]

## the binary version
[
    100,
    001,
    010,
    001,
    010
]
```

２進数変換されたリストに対してXORをbitwiseで計算してみると

```python
100 ^ 001 ^ 010 ^ 001 ^ 010 = 100
```

と例外の`100`, つまり`4`がリターンされました.

### XORと結合法則

XORで上記の問題が解けるためには結合法則と交換法則が成立する必要があります. 
でないと, 要素を同じ but 出現順番が異なる`nums`に応じてリターンが異なるのは認められないからです.

交換法則は

```
A xor B == B xor A
```

で自明なので, 結合法則について以下確認します.
これは真理表を書くことで簡単に確かめられます

```
(A xor B) xor C == A xor (B xor C)
```

が成り立てば良いので

|A|B|C|A xor B|B xor C|RHS|LHS|LHS == RHS|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|T|T|T|F|F|T|T|T|
|T|T|F|F|T|T|T|T|
|T|F|T|T|F|T|T|T|
|T|F|F|T|F|T|T|T|
|F|T|T|T|F|T|T|T|
|F|T|F|T|T|T|T|T|
|F|F|T|F|T|T|T|T|
|F|F|F|F|F|F|F|T|

`(A, B, C)`がどんな組み合わせでも `LHS == RHS`が常に成り立っているので, 交換法則が成立することがわかります. そのため, `nums`がどのような順番であろうとも, 奇数回登場する唯一の例外が１つの整数のみであるならば, その整数を返してくれることがわかります.

### O(1) memory space

XORは交換法則が成り立つので, 残りは$O(1)$ memory spaceでどのように計算するかです.
ここで役に立つのが`reduce`関数です. `reduce`関数は, 

- 配列の先頭から2つの要素を取り出して処理を行う(今回はXOR)
- 次はその結果とその次の要素に処理を行う

つまり, どんなarray lengthだろうがそのextra spaceに２つのintegersを格納できるmemory spaceがあれば十分となります.

### Python Solution

```python
from functools import reduce

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        return reduce(xor, nums)
```

#### PythonにおけるXOR

Pythonでは `^` が ビット単位排他的論理和(bitwise XOR)として予約されています.

```python
x = 12  # 0b1100
y = 10  # 0b1010

print(x ^ y)
print(bin(x ^ y))
# 6
# 0b110
```


References
--------------

- [Leetcode 136. Single Number](https://leetcode.com/problems/single-number/)
- [Python Solution: problem_0136_single_number](https://github.com/RyoNakagami/PythonCompetitiveProgramming/blob/main/Leetcode/problem_0136_single_number.py)