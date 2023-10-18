---
layout: post
title: "Generator: yield and filter"
subtitle: "Pythonista Tips 4/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-10-12
tags:

- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Generator](#generator)
  - [ジェネレーターの例](#%E3%82%B8%E3%82%A7%E3%83%8D%E3%83%AC%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AE%E4%BE%8B)
  - [ジェネレーターはいつも早いのか？](#%E3%82%B8%E3%82%A7%E3%83%8D%E3%83%AC%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AF%E3%81%84%E3%81%A4%E3%82%82%E6%97%A9%E3%81%84%E3%81%AE%E3%81%8B)
- [Generatorの値をfilterする](#generator%E3%81%AE%E5%80%A4%E3%82%92filter%E3%81%99%E3%82%8B)
  - [`filter`関数](#filter%E9%96%A2%E6%95%B0)
  - [Generator objectに対するfilter](#generator-object%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8Bfilter)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Generator

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Generator</ins></p>

- ジェネレーターオブジェクトとは, Pythonのシーケンスを作成するオブジェクトのこと. 
- ジェネレーターを用いることで, シーケンス全体を作ってメモリに格納しなくても, シーケンスを反復処理することができる
- ジェネレーターは反復処理のたびに最後に呼び出されたときにどこにいたかを管理し, 次の値を返す

</div>

Python 3.xでは`range`はジェネレーターの一つですが, Python 2.xでは`range`はリストを返す挙動でした.
そのため, リスト形式でメモリに収まる範囲内の整数のシーケンスしか扱うことができないというデメリットがありました.

### ジェネレーターの例

平方数を返すジェネレーターを以下のように定義してみます.

```python
def squared_generator(START: int, LIMIT: int):
    num = START
    while num < LIMIT:
        yield num**2
        num += 1
```

このとき, `squared_generator`は以下のようにジェネレーターオブジェクトを返します

```py
print(squared_generator(1, 5))
>>> <generator object squared_generator at 0x7f4cfc53fd30>
```

反復処理は以下のようにして実行可能です

```py
for x in squared_generator(1, 5):
    print(x)

>>> 1
>>> 4
>>> 9
>>> 16
```

### ジェネレーターはいつも早いのか？

メモリ効率的ではありますが, 実行速度は必ずしも早いとは限りません.

```py
def compute_by_generator(N):
    start_map = time.time()
    res = sum(squared_generator(0, N))
    print(time.time() - start_map, res)

def compute_by_list(N):
    squared_list = []
    for i in range(0, N):
        squared_list.append(i**2)
    start_map = time.time()
    res = sum(squared_list)
    print(time.time() - start_map, res)

N = 10000000
compute_by_list(N)
>>> 0.1008293628692627 333333283333335000000

compute_by_generator(N)
>>> 0.4377624988555908 333333283333335000000
```

## Generatorの値をfilterする
### `filter`関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: </ins></p>

`filter`関数は第1引数に指定した関数を用いて, 第2引数に指定した反復可能オブジェクトの要素を評価し,
その結果が真となる要素だけを反復するイテレータを返す機能を持つ.

```py
filter(function, iterable)
```

なお, `function`と`iterable`について以下のような制約がある

- 受け取る反復可能オブジェクトは1つだけ
- `function`に指定する関数の引数は1つだけ

</div>

例として, 与えられたリストから偶数の要素のみを抽出したい場合は

```py
def is_even(x):
    return x % 2 == 0

result = filter(is_even, [1, 2, 3, 4])
print(result)
>>> <filter object at 0x7f1b70294ac0>

print(list(result))
>>> [2, 4]
```

### Generator objectに対するfilter

0から始まる平方数を返すgeneratorを以下のように定義します

```py
def squared_generator():
    base = 0
    while True:
        yield(base**2)
        base += 1
```

このとき, 先頭の3個の平方数を出力したい場合は

```py
for i in range(0, 3):
    print(i, next(A))

>>> 0 0
    1 1
    2 4
```

1000以上の平方数の中から先頭の３個の平方数を出力したい場合は

```py
squaered_over_thousand = filter(lambda x: x >= 1000, squared_generator())

for i in range(0, 3):
    print(i, next(squaered_over_thousand))

>>> 0 1024
    1 1089
    2 1156
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS</ins></p>

Generatorの定義にもよりますが, 上記のように`while True`で定義されたGeneratorに対して

```py
list(filter(lambda x: x >= 1000, squared_generator()))
```

を実行してしまうと, すべての要素（実質無限）に対して真偽判定してから`list` objectを返そうとしてしまうので,
いつまで経っても実行結果が返ってこないという悲惨な結果が起こってしまいます.

</div>
