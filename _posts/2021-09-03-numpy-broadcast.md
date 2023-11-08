---
layout: post
title: "Numpy 1D-arrayを複製して2D-arrayへ変換する"
subtitle: "Pythonista Tips 5/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-11-08
tags:

- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What I Want to Do](#what-i-want-to-do)
- [`numpy.tile`: 元配列に影響なく編集可能](#numpytile-%E5%85%83%E9%85%8D%E5%88%97%E3%81%AB%E5%BD%B1%E9%9F%BF%E3%81%AA%E3%81%8F%E7%B7%A8%E9%9B%86%E5%8F%AF%E8%83%BD)
- [`numpy.broadcast_to`: ただし原則編集はできない](#numpybroadcast_to-%E3%81%9F%E3%81%A0%E3%81%97%E5%8E%9F%E5%89%87%E7%B7%A8%E9%9B%86%E3%81%AF%E3%81%A7%E3%81%8D%E3%81%AA%E3%81%84)
  - [ブロードキャストした配列を編集することはできない](#%E3%83%96%E3%83%AD%E3%83%BC%E3%83%89%E3%82%AD%E3%83%A3%E3%82%B9%E3%83%88%E3%81%97%E3%81%9F%E9%85%8D%E5%88%97%E3%82%92%E7%B7%A8%E9%9B%86%E3%81%99%E3%82%8B%E3%81%93%E3%81%A8%E3%81%AF%E3%81%A7%E3%81%8D%E3%81%AA%E3%81%84)
- [`numpy.reshape`で次元を増やしてから, `numpy.repeat`の実行](#numpyreshape%E3%81%A7%E6%AC%A1%E5%85%83%E3%82%92%E5%A2%97%E3%82%84%E3%81%97%E3%81%A6%E3%81%8B%E3%82%89-numpyrepeat%E3%81%AE%E5%AE%9F%E8%A1%8C)
  - [reshape後の配列に対する値変化の影響](#reshape%E5%BE%8C%E3%81%AE%E9%85%8D%E5%88%97%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8B%E5%80%A4%E5%A4%89%E5%8C%96%E3%81%AE%E5%BD%B1%E9%9F%BF)
- [`numpu.resize`: 元配列に影響なく編集可能](#numpuresize-%E5%85%83%E9%85%8D%E5%88%97%E3%81%AB%E5%BD%B1%E9%9F%BF%E3%81%AA%E3%81%8F%E7%B7%A8%E9%9B%86%E5%8F%AF%E8%83%BD)
- [どの変換が一番早いのか？](#%E3%81%A9%E3%81%AE%E5%A4%89%E6%8F%9B%E3%81%8C%E4%B8%80%E7%95%AA%E6%97%A9%E3%81%84%E3%81%AE%E3%81%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What I Want to Do

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

`numpy.array([1, 2, 3, 4])`が与えられているとき, これと同じ配列が$N$行ある `2-D numpy.array`を生成したい.
例として以下, 

```python
np.array([[1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4]])
```

</div>

配列の繰り返しなのでrepeatが考えられますが, 単純に配列の繰り返しだけを指定すると

```python
import numpy as np

np.repeat([1, 2, 3, 4], 2)
>>> array([1, 1, 2, 2, 3, 3, 4, 4])
```

となり欲しい結果が返ってきません. 配列の次元を増やし繰り返すためには以下の手法が考えられます

- `numpy.tile`を用いて配列を複製しタイル状に並べる
- `numpy.broadcast_to`を用いて新しいshapeへブロードキャストする(ただし, 原則編集はできない)
- `numpy.reshape`を用いて一度2D配列へ変更し, `numpy.repeat`で配列を複製する
- `numpy.resize`を用いる

## `numpy.tile`: 元配列に影響なく編集可能

```python
## 指定された回数分繰り返した配列を返す
numpy.tile(array, shape)
```

- `array`: 複製の元となる配列
- `shape`引数で繰り返し方法を指定, `tuple` or `int`

この手法が推奨手法となります.

```python
import numpy as np

## 1D配列をそのまま繰り返す
np.tile([1, 2, 3, 4], 2)
>>> array([1, 2, 3, 4, 1, 2, 3, 4])

## 1D配列を2D配列にし行を増やす方向に繰り返す
np.tile([1, 2, 3, 4], (2, 1))
>>> array([[1, 2, 3, 4],
           [1, 2, 3, 4]])

## 1D配列を2D配列にし列を増やす方向に繰り返す
np.tile([1, 2, 3, 4], (1, 2))
>>> array([[1, 2, 3, 4, 1, 2, 3, 4]])

## 2D配列を行を増やす方向に繰り返す
np.tile([[1, 2, 3, 4], [5, 6, 7, 8]], (2, 1))
>>> array([[1, 2, 3, 4],
           [5, 6, 7, 8],
           [1, 2, 3, 4],
           [5, 6, 7, 8]])

## 2D配列を列を増やす方向に繰り返す
np.tile([[1, 2, 3, 4], [5, 6, 7, 8]], (1, 2))
>>> array([[1, 2, 3, 4, 1, 2, 3, 4],
           [5, 6, 7, 8, 5, 6, 7, 8]])
```

## `numpy.broadcast_to`: ただし原則編集はできない

複製する形でブロードキャストした配列を参照するのみの場合は`numpy.broadcast_to`のほうが実行時間が早くなります

```python
## 指定された回数分繰り返した配列を返す
numpy.broadcast_to(array, shape)
```

- `array`: 複製の元となる配列
- `shape`: 引数で繰り返し方法を指定, `tuple` or `int`
- 注意点としては繰り返しの回数というよりは感覚的には次元を増やして行数/列数を指定するイメージ
- ブロードキャスト専用の関数と認識したほうが良い

```python
## D配列をそのまま繰り返すことはできない
np.broadcast_to([1, 2, 3, 4], (1, 4))
>>> array([[1, 2, 3, 4]])

np.broadcast_to([1, 2, 3, 4], (1, 8))
>>> ValueError: operands could not be broadcast together with remapped 
    shapes [original->remapped]: (4,)  and requested shape (1,2)


## 1D配列を2D配列にし行を増やす方向に繰り返す
np.broadcast_to([1, 2, 3, 4], (2, 4))
>>> array([[1, 2, 3, 4],
           [1, 2, 3, 4]])

np.broadcast_to([1, 2, 3, 4], (3,　4))
>>> array([[1, 2, 3, 4],
           [1, 2, 3, 4],
           [1, 2, 3, 4]])
```

### ブロードキャストした配列を編集することはできない

`numpy.broadcast_to`を用いてブロードキャストキャストした配列はイミュータブルであることに
留意が必要です.

```python
import numpy as np
A = np.broadcast_to([1, 2, 3, 4], (2, 4))
A[0, 0] = 1
>>> ValueError: assignment destination is read-only
```

`flags.writeable = True` を用いて書き込み禁止を強引に外すことも可能ですが, もとの
オブジェクトを参照しているだけなので一つの要素への変更が他にも波及してしまいます

```python
## np.tileだと問題はない
a = [1, 2, 3, 4]
A = np.tile(a, (2, 1))
A[1][1]=3
print(A)
>>> array([[1, 2, 3, 4],
           [1, 3, 3, 4]])
print(a)
>>> [1, 2, 3, 4]

## np.broadcastだと参照渡しなので影響が広がる
a = [1, 2, 3, 4]
A = np.broadcast_to(a, (2, 4))
A.flags.writeable = True
A[1][1] = ３
print(A)
>>> array([[1, 3, 3, 4],
           [1, 3, 3, 4]])

print(a)
>>> [1, 2, 3, 4]


## np.broadcastだと参照渡しなので影響が広がる
a = np.array([1, 2, 3, 4])
A = np.broadcast_to(a, (2, 4))
A.flags.writeable = True
A[1][1] = ３
print(a)
>>> [1, 3, 3, 4]
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: イミュータブル</ins></p>

オブジェクトに入っているデータの値を変更できる場合, そのオブジェクトのことを**ミュータブル**と呼び,
変更できない場合は**イミュータブル**と呼ぶ.

よく聞く例えとして, 中身は見れるけど書き換えられないことか「イミュータブルなオブジェクトは密閉されているが透明な窓がついている箱のようなもの」と言われる.

</div>

## `numpy.reshape`で次元を増やしてから, `numpy.repeat`の実行

```python
numpy.reshape(array, newshape)
```

- `array`: 変換元の配列
- `newshape`: 変換後の配列の形状を指定, `tuple` or `int`
- あくまで要素数が変化しない範囲での形状変換しかできない


```python
import numpy as np

## 4要素の1D配列を2D配列にし, 行を増やす方向でrepeat: 元配列には影響なし
a = np.array([1, 2, 3, 4])
A = np.repeat(np.reshape(a, (1, 4)), 2, axis=0)
A[1][1] = 3
print(A)
>>> array([[1, 2, 3, 4],
           [1, 3, 3, 4]])

print(a)
>>> array([1, 2, 3, 4])

## 4要素の1D配列を2D配列へ変換する際に要素数をオーバーする形状を指定した場合
a = [1, 2, 3, 4]
np.reshape(a, (2, 4))
>>> ValueError: cannot reshape array of size 4 into shape (2,4)
```

### reshape後の配列に対する値変化の影響

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>

reshape前の`ndarray`の要素は, reshape後の`ndarray`と共有されているので,
変換後のある値を変化させると変換前の`ndarray`の要素も影響をうける

</div>

これは, 変換前が`ndarray`の場合野天に注意が必要です, 例は以下,

```python
import numpy as np

## 変換前がListの場合は影響はない（型変換を噛ませているので）
a = [1, 2, 3, 4]
A = np.reshape(a, (2, 2))
A[1][1] = 3
print(a)
>>> [1, 2, 3, 4]

## 変換前がndarrayの場合は影響がある
a = np.array([1, 2, 3, 4])
A = np.reshape(a, (2, 2))
A[1][1] = 3
print(a)
>>> array([1, 2, 3, 3])
```

元の配列までに影響を与えてしまうので注意が必要です.


## `numpu.resize`: 元配列に影響なく編集可能

`numpy.reshape`は要素数が揃わないと変換ができなかったですが, 
`numpy.resize`は要素数をオーバーするような形状変換のときは繰り返しで対応してくれます

```python
numpy.resize(array, newshape)
```

- `array`: 変換元の配列
- `newshape`: 変換後の配列の形状を指定, `tuple` or `int`

```python
import numpy as np

## 1Dを要素数をオーバーする形で2Dへ変換
a = np.array([1, 2, 3, 4])
A = np.resize(a, (2, 4))
print(A)
>>> array([[1, 2, 3, 4],
           [1, 2, 3, 4]])


## 1Dを要素数をオーバーする形で2Dへ変換
a = np.array([1, 2, 3, 4])
A = np.resize(a, (2, 6))
print(A)
>>> array([[1, 2, 3, 4, 1, 2],
           [3, 4, 1, 2, 3, 4]])

## 変更
a = np.array([1, 2, 3, 4])
A = np.resize(a, (1, 4))
A[0][1] = 3
print(a)
>>> array([1, 2, 3, 4])
```

## どの変換が一番早いのか？

以下の条件でどの変換が一番早いか簡易的に検証してみます.

```python
import numpy as np 
import timeit

## 元配列の定義
a = np.array([1, 2, 3, 4])

## 実行時間計測
%timeit A = np.tile(a, (2, 1))
%timeit B = np.broadcast_to(a, (2, 4))
%timeit C = np.repeat(np.reshape(a, (1, 4)), 2, axis=0)
%timeit D = np.resize(a, (2, 4))

## 要素一致検証
print(np.all(A == B), np.all(A == C), np.all(A == D))
```

結果は以下となります

```
1.82 µs ± 15.1 ns per loop (mean ± std. dev. of 7 runs, 1,000,000 loops each)
1.68 µs ± 2.6 ns per loop (mean ± std. dev. of 7 runs, 1,000,000 loops each)
1.16 µs ± 4.21 ns per loop (mean ± std. dev. of 7 runs, 1,000,000 loops each)
1.73 µs ± 2.52 ns per loop (mean ± std. dev. of 7 runs, 1,000,000 loops each)
True True True
```

`numpy.broadcast_to`が流石に一番早いかな？と期待していたところ, `numpy.repeat` & `reshape`
が圧倒的に速いという結果になった. これは実行順番を変えてみても同じ結論だった.

念の為, 変数のメモリ使用量も確認してみる

```python
import sys

print(sys.getsizeof(A))
>> 128

print(sys.getsizeof(B))
>> 128

print(sys.getsizeof(C))
>> 192

print(sys.getsizeof(D))
>> 128
```

一番実行時間が短いオブジェクトだけがメモリを多く使用しているが, 理由がよくわからない.
後ほど調べる.


References
------------

- [stackoverflow > Repeat a 2D NumPy array N times [duplicate]](https://stackoverflow.com/questions/53643526/repeat-a-2d-numpy-array-n-times)
- [ブロードキャストしたNumpy配列に代入するときにハマった話](https://blog.shikoan.com/assign-to-broadcasted-numpy-array/)