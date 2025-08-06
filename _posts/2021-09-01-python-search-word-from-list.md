---
layout: post
title: "List of stringsから正規表現で指定文字列を検索する"
subtitle: "Pythonista Tips 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-10-12
tags:

- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What I Want to Do?](#what-i-want-to-do)
- [Solution](#solution)
  - [なぜ`re.search`なのか？](#%E3%81%AA%E3%81%9Cresearch%E3%81%AA%E3%81%AE%E3%81%8B)
  - [loop methodとの比較](#loop-method%E3%81%A8%E3%81%AE%E6%AF%94%E8%BC%83)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What I Want to Do?

```py
word_list = ['Apple', 'Banana', 'Apple-juice', 'ple-ple', 'pleasure', 'Please']
pattern = 'ple'

func(pattern, word_list)
>>> ['Apple', 'Apple-juice', 'ple-ple', 'pleasure']
```

- `string`を格納した`list`の`word_list`から`ple`という文字列を含む要素をリストとして返したい
- `pattern`は正規表現での指定も可能

上記の要件を満たす関数を作成したいというのが今回の問題です.

## Solution

```py
import re
from itertools import compress

def pygrep(pattern: str, word_list: list):
    list_idx = map(lambda x: bool(re.search(pattern, x)), word_list)
    res = list(compress(word_list, list_idx))
    return res

word_list = ['Apple', 'Banana', 'Apple-juice', 'ple-ple', 'pleasure', 'Please']
pattern = 'ple'

pygrep(pattern, word_list)
>>> ['Apple', 'Apple-juice', 'ple-ple', 'pleasure']
```

### なぜ`re.search`なのか？

マッチングの対象となる`PATTERN`を用いて, 文字列`SOURCE`から検索する関数として, `re`モジュールの
`re.match`や`re.findall`といった関数がある.

それぞれ文字列検索関数ですが, 挙動は以下のように差異があります.

|関数|挙動|
|---|----|
|`re.match()`|文字列先頭からのexactマッチング|
|`re.search()`|文字列先頭からの検索し, 最初のマッチを返す, `contain`に感覚的に近い|
|`re.findall()`|文字列先頭からの検索し, マッチした文字列を`list`で返す|

`re.match()`は`SOURCE`の先頭から検索し, 先頭から一致しないと`None`を返す仕様となっています.
`re.match()`と`re.search()`の挙動の比較配下のようになります.

```python
## SOURCE
string_with_newlines = """something\nsomeotherthing"""


print(re.match('some', string_with_newlines)) # match
print(re.search('some', string_with_newlines)) # match

print(re.match('thing', string_with_newlines)) # won't match
print(re.match('.{0,}thing', string_with_newlines)) # match
print(re.match('.?thing', string_with_newlines)) # won't match
print(re.match('.*thing', string_with_newlines)) # match

print(re.search('thing', string_with_newlines)) # match
print(re.search('.{0,}thing', string_with_newlines)) # match
print(re.search('.?thing', string_with_newlines)) # match
print(re.search('.*thing', string_with_newlines)) # match

print(re.match('someother', string_with_newlines)) # won't match
print(re.match('.{0,}someother', string_with_newlines)) # won't match
print(re.match('.*someother', string_with_newlines)) # won't match

print(re.search('someother', string_with_newlines)) # match
print(re.search('.{0,}someother', string_with_newlines)) # match
print(re.search('.*someother', string_with_newlines)) # match
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS</ins></p>

`?`, `*`, `{0,}`は直前の文字が０回以上繰り返されるといういみでは共通ですが, 
以下のような違いがあります. 

- `?`: 最左最短マッチ
- `*`, `{0,}`: 最大左マッチ

```py
string_with_newlines = """something\nsomeotherthing"""

print(re.search('thing', string_with_newlines).group())
>>> thing

print(re.search('.{0,}thing', string_with_newlines).group())
>>> something

print(re.search('.?thing', string_with_newlines).group())
>>> ething

print(re.search('.*thing', string_with_newlines).group())
>>> something
```

</div>

### loop methodとの比較

正規表現を用いた検索はできませんが, 指定した`PATTERN`を含む文字列を`SOURCE`から`list`で出力する方法として
loopで以下のように処理する方法もあります

```python
def loop_grep(pattern: str, word_list: list):
    res = []
    for word in word_list:
        if pattern in word:
            res.append(word)
    return res
```

> 実行時間の比較

```python
import time
import random
import string
from itertools import compress
import re

def pygrep(pattern: str, word_list: list):
    list_idx = map(lambda x: bool(re.match(pattern, x)), word_list)
    res = list(compress(word_list, list_idx))
    return res

def loop_grep(pattern: str, word_list: list):
    res = []
    for word in word_list:
        if pattern in word:
            res.append(word)
    return res

def generate_word(LENGTH=10):
    word = [random.choice(string.ascii_lowercase) for _ in range(LENGTH)]
    word = ''.join(word)
    return word

mapsearch_execute_time = []
loopsearch_execute_time = []

for list_size in range(1000, 100000, 1000):
    tmp_list_map = 0
    tmp_list_loop = 0
    for j in range(10):
        wordlist = [generate_word() for _ in range(list_size)]

        start_loop = time.time()
        res = loop_grep('python', wordlist)
        tmp_list_loop += time.time() - start_loop

        start_map = time.time()
        res = pygrep('python', wordlist)
        tmp_list_map += time.time() - start_map

    mapsearch_execute_time.append(tmp_list_map/5)
    loopsearch_execute_time.append(tmp_list_loop/5)
```

可視化コードは以下です

```py
from matplotlib import pyplot as plt
import numpy as np

fig, ax = plt.subplots()

x = np.arange(1000, 100000, 1000)

ax.plot(x, mapsearch_execute_time, label='map')
ax.plot(x, loopsearch_execute_time, label='loop')
ax.set_xlabel('list size')
ax.set_ylabel('run-time')

ax.legend()
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/blog/pythonista/20210901-map-loop-compare.png?raw=true">

ものすごく, `pygrep`のほうが遅い...



References
------------------------
- [stackoverflow > What is the difference between re.search and re.match?](https://stackoverflow.com/questions/180986/what-is-the-difference-between-re-search-and-re-match)
