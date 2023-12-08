---
layout: post
title: "Angular Bisector and Tangent - Project Euler Problem 296"
subtitle: "Python: Competitive Programming 4/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-11-14
tags:

- 競技プログラミング
- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem: Angular Bisector and Tangent](#problem-angular-bisector-and-tangent)
  - [解答方針を立てるまで](#%E8%A7%A3%E7%AD%94%E6%96%B9%E9%87%9D%E3%82%92%E7%AB%8B%E3%81%A6%E3%82%8B%E3%81%BE%E3%81%A7)
  - [Python Solution](#python-solution)
- [実行時間が遅い問題について](#%E5%AE%9F%E8%A1%8C%E6%99%82%E9%96%93%E3%81%8C%E9%81%85%E3%81%84%E5%95%8F%E9%A1%8C%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [](#)
  - [Python code](#python-code)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Problem: Angular Bisector and Tangent

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

辺の長さが整数で BC ≤ AC ≤ AB を満たす三角形 ABC がある.
k は角 ACB の二等分線である.
m は ABC の外接円に対する C での接線である.
n は B を通る m に平行な線である.
n と k の交点を E とする.

BE の長さが整数で周長が 100 000 を超えない三角形 ABC はいくつあるか?

<img src="https://projecteuler.net/resources/images/0296_bisector.gif?1678992056">

</div>

この問題は計算は大変ですが, 解答方針の立て方自体は三角形の相似と内角の二等分線の性質を利用するだけという
良問です.


### 解答方針を立てるまで

<iframe scrolling="no" title="Project-Euler-296" src="https://www.geogebra.org/material/iframe/id/jzadsg4a/width/800/height/378/border/888888/sfsb/true/smb/false/stb/false/stbh/false/ai/false/asb/false/sri/false/rc/false/ld/false/sdz/true/ctl/false" width="800px" height="378px" style="border:0px;"> </iframe>


### Python Solution

```python
import math
    
class Solution:
    """ 
    Problem
        https://projecteuler.net/problem=296
    
    Solution
        Using the similarity between the triangle ACD and BCE
        and BE = BD
    
    Usage
        Solver = Solution()
        Solver.find_solution()
        >>> 1137208419
    """
    def gcd(self, a, b):
        while b > 0:
            a, b = b, a % b
        return a
    
    #def check_length(self, AB, AC, BC):
    #    return BC <= AC & AC <= AB

    def find_solution(self, perimeter:int=100000):
        count = 0
        for BC in range(1, perimeter//3 + 1):
            for AC in range(BC, (perimeter - BC)//2 + 1):
                k = self.gcd(AC, BC)
                step =  AC//k + BC//k
                min_AB = math.ceil(AC / step) * step
                max_AB = min(AC + BC, perimeter - AC - BC + 1)
                count += math.ceil((max_AB - min_AB) / step)

        return count
```




## 実行時間が遅い問題について

実行時間が遅い問題に直面した場合,

- アルゴリズムの改善
- マルチコアとメモリの暴力で殴る

という対応策が考えられます. 今回は「**マルチコアとメモリの暴力で殴る**」の方針での対応策を採用します.
そもそも, 上記で紹介した解答を実行時のシステムモニターを見てみると, 少なくとも僕の場合はCPU１コアのみが稼働している状態となっていたので,
これを30コアにすればオーバヘッドが発生するかもしれませんが, 単純に20~30倍近くの実行スピードが確保できると期待できます.

### 


### Python code

```python
import math
from multiprocessing import Pool
    
class Solution:
    """
    Note
        faster version using the multiprocessing module
    
    Problem
        https://projecteuler.net/problem=296
    
    Solution
        Using the similarity between the triangle ACD and BCE
        and BE = BD
    
    Usage
        Solver = Solution()
        Solver.find_solution()
        >>> 1137208419
    """
    def gcd(self, a, b):
        while b > 0:
            a, b = b, a % b
        return a

    def compute(self, BC):
        count = 0
        for AC in range(BC, (self.perimeter - BC)//2 + 1):
            k = self.gcd(AC, BC)
            step = AC//k + BC//k
            min_AB = math.ceil(AC / step) * step
            max_AB = min(AC + BC, self.perimeter - AC - BC + 1)
            count += math.ceil((max_AB - min_AB) / step)
        return count
    
    def find_solution(self, cpu, perimeter:int=100000):
        self.perimeter = perimeter
        with Pool(processes=cpu) as pool:
            return sum(pool.map(Solver.compute, range(1, perimeter//3 + 1)))

Solver = Solution()
Solver.find_solution(cpu=30, perimeter=100000)
```

爆速の実行スピードが確保できるようになった.


References
------------
- [Project Euler Problem 296](https://projecteuler.net/problem=296)
- [GitHub > problem_0296_angular_bisector_and_tangent.py](https://github.com/RyoNakagami/PythonCompetitiveProgramming/blob/main/projecteuler/problem_0296_angular_bisector_and_tangent.py)
- [GitHub > problem_0296_angular_bisector_and_tangent_2.py](https://github.com/RyoNakagami/PythonCompetitiveProgramming/blob/main/projecteuler/problem_0296_angular_bisector_and_tangent_2.py)