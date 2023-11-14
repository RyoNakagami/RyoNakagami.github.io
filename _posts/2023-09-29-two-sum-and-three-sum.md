---
layout: post
title: "2Sum and 3Sum - Leetcode 1 & 15"
subtitle: "Python: Competitive Programming 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-09-29
tags:

- 競技プログラミング
- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem 1: 2Sum](#problem-1-2sum)
  - [$O(N^2)$ Solution: Nested Loop](#on%5E2-solution-nested-loop)
  - [$O(N)$ Solution: Hash Map](#on-solution-hash-map)
  - [$O(N \log N)$ Solution: sorted array](#on-%5Clog-n-solution-sorted-array)
- [Problem 15: 3Sum](#problem-15-3sum)
  - [Solution](#solution)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Problem 1: 2Sum

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

`intger`を格納したリスト `nums`と integer `target`が与えられたとき, 
`nums`の要素を２つ抽出したとき, その合計が`target`となるような`nums`のindexを`list`で出力してください.

- `nums`のうち同じindexのもの２つは抽出できない
- 解はユニークに必ず存在するとする

</div>

例えば, 

- Input: `nums = [2,7,11,15], target = 9`
- Output: `[0,1]`

`nums[0] + nums[1] == target`となるため上記の出力となる.

また, 以下のように`nums`の要素は重複している可能性もあるが, 必ずユニークな答えが存在するとする.

- Input: `nums = [3,3], target = 6`
- Output: `[0,1]`

### $O(N^2)$ Solution: Nested Loop

```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        for left_idx in range(0, len(nums)):
            for right_idx in range(left_idx+1, len(nums)):
                if nums[left_idx] + nums[right_idx] == target:
                    return [left_idx, right_idx]
```

この答えは二重ループで, 最悪の場合`if`文が`nums` sizeを$N$としたとき,

$$
\frac{N(N+1)}{2} = \frac{1}{2}(N^2 + N) 
$$

呼ばれるので, Time Complexityは$O(N^2)$となっていることがわかる.

### $O(N)$ Solution: Hash Map

```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        thresh = target - min(nums)
        d = {j:i for i, j in enumerate(nums) if j <= thresh}
        for i, num in enumerate(nums):
            diff = target - num
            if diff in d and d[diff] != i:
                return [i, d[diff]]
```

これは仮定の一つの「**解はユニークに必ず存在するとする**」に依拠した解答となっています.

```python
d = {j:i for i, j in enumerate(nums) if j <= thresh}
```

で`nums`の要素をkey, indexをvalueとした（重複要素の場合は大きい方のindexを用いた）`dict`(Hash Map)を
$O(N)$の計算量で定義します. このとき, `target - min(target)`より大きい要素を格納してもメモリスペースの無駄なので, 
予め除去しておきます.


その後, `nums`の各要素`num`に対して, 

```python
diff = target - num
```

を計算し, `diff`をkeyとして持つ`item`が存在するか, $O(N)$の計算量で判定しています.
そのため, この解はlinear time comlexityの解答となっています.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: 計算量</ins></p>

計算量とはアルゴリズムの効率性を表す指標で, 時間計算量と空間計算量の２つがあります.

- 時間計算量, Time Complexity: 入力データに対してアルゴリズムを実行するための必要な時間の指標
- 空間計算量, Memory Space: 計算に必要なメモリ量の指標

</div>

### $O(N \log N)$ Solution: sorted array

```python
from typing import List

class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        sorted_num = sorted(nums)
        left_idx = 0
        right_idx = len(nums) - 1

        while left_idx < right_idx and right_idx < len(nums):
            left_val, right_val = sorted_num[left_idx], sorted_num[right_idx]
            tmp = left_val + right_val
            if tmp < target:
                left_idx += 1
            elif tmp > target:
                right_idx -= 1
            else:
                first_idx = nums.index(left_val)
                second_idx = len(nums) - 1 - nums[::-1].index(right_val)
                return [first_idx, second_idx]
```

この解のtime complexity, $O(N\log(N))$ は以下のように分解して考えることができます:

- `sorted(nums)`: worst caseにおいて $O(N \log(N))$
- while loop: sorted arrayの要素は一回ずつしか読み込まれないので $O(N)$

なお, Leetcodeで手法別計算量を確認してみると, Hash Map/sorted array Solutionの優秀さが以下のように確認できます.

|手法|Runtime|Memory|
|---|-------|------|
|Nested Loop|2467 ms|17 MB|
|Hash Map|73 ms|17.3 MB|
|sorted array|68 ms|17 MB|



## Problem 15: 3Sum

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

`intger`を格納したリスト `nums`が与えられたとする. 
indexが異なるという条件のもと, `nums`の要素を3つ抽出したとき, 
その合計が`target`となるような`nums`の`list`で出力してください.

- ３つの要素の組について重複するものは除去した上で`nums`の`list`を出力

</div>

例として, 

- Input: `nums = [-1,0,1,2,-1,-4]`
- Output: `[[-1,-1,2],[-1,0,1]]`

このとき, `[[-1,-1,2],[-1,0,1],[-1, 2, -1]]`のように出力すると, `[-1, 2, -1]`と`[-1,-1,2]`は組み合わせが
重複しているので片方の出力は認められない.

### Solution

```python
from typing import List


class Solution:
    """
    Problem
        https://leetcode.com/problems/3sum/

        Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] 
        such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
        Notice that the solution set must not contain duplicate triplets.
    
    Related
        https://leetcode.com/problems/two-sum/
    
    Note
        this time, required to retund list of values, not index
    """
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        res = []
        max_idx = len(nums)-1
        prev = None
        for first_idx in range(max_idx):
            # reduce the search area
            if nums[first_idx] > 0:
                return res
            if nums[first_idx] == prev:
                continue
            
            # Main Part
            target = 0 - nums[first_idx]
            second_idx = first_idx + 1
            third_idx = max_idx
            while second_idx < third_idx and third_idx <= max_idx:
                tmp = nums[second_idx] + nums[third_idx]
                if tmp > target:
                    third_idx -= 1
                elif tmp < target:
                    second_idx += 1
                else:
                    res.append([nums[first_idx], nums[second_idx], nums[third_idx]])
                    second_idx += 1
                    while nums[second_idx] == nums[second_idx - 1] and second_idx < third_idx:
                        second_idx += 1
            prev = nums[first_idx]
        
        return res
```

- Runtime complexyは$O(N^2)$
- Runtime: 739 ms
- Memory: 20.3 MB



References
------------------

- [Leetcode Problem 1. Two Sum](https://leetcode.com/problems/two-sum/description/)
- [Leetcode Problem 15. 3Sum](https://leetcode.com/problems/3sum/)
- [GitHub > RyoNakagami/PythonCOmpetitiveProgramming](https://github.com/RyoNakagami/PythonCompetitiveProgramming)