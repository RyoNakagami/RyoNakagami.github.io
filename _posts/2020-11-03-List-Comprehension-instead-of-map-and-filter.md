---
layout: post
title: "List comprehensionとmapとfilterの比較"
subtitle: "PythonとList comprehension"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Python
- 前処理
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

|概要||
|---|---|
|目的|List comprehensionとmapとfilterの比較|
|プログラミング言語|Python 3.6.9 (Google Colabのデフォルト)|
|実行環境|Google Colab|



<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. `map()`とは？](#1-map%E3%81%A8%E3%81%AF)
- [2. `filter()`とは？](#2-filter%E3%81%A8%E3%81%AF)
- [3. List comprehensionとmapとfilterの比較](#3-list-comprehension%E3%81%A8map%E3%81%A8filter%E3%81%AE%E6%AF%94%E8%BC%83)
  - [List comprehensionとmapの比較](#list-comprehension%E3%81%A8map%E3%81%AE%E6%AF%94%E8%BC%83)
  - [List comprehensionとfilterの比較](#list-comprehension%E3%81%A8filter%E3%81%AE%E6%AF%94%E8%BC%83)
  - [filterとmapとList comprehension](#filter%E3%81%A8map%E3%81%A8list-comprehension)
- [Referenece](#referenece)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. `map()`とは？

```py
map(function, iterable, ...)
```

function を、結果を返しながら iterable の全ての要素に適用するイテレータを返します。Python2まではリストを返す仕様となっていたが、Python 3.xからイテレータを返す。

例えば、以下の二つのコードは同じ結果を出力する。

```py
items = [1, 2, 3, 4, 5]
squared = []
for i in items:
    squared.append(i**2)
```

```py
items = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x**2, items))
```

## 2. `filter()`とは？

```py
filter(function, iterable, ...)
```

iterable の要素のうち function が真を返すものでイテレータを構築します。iterable はシーケンスか、反復をサポートするコンテナか、イテレータです。function が None なら、恒等関数を仮定します。すなわち、iterable の偽である要素がすべて除去されます。

例として、

```py
def is_even(n):
    return n % 2 == 0

m = filter(is_even, range(10))
print(m)
# <filter object at 0x114d178d0>
print(list(m))
# [0, 2, 4, 6, 8]
print(list(m))
# []
```

## 3. List comprehensionとmapとfilterの比較

`map`や`filter`を否定するわけではないが、List comprehensionを用いた方が可読性の観点から好ましいと考えてます。

### List comprehensionとmapの比較

ここではList comprehensionとmapを実行時間の観点から比較してみます。自分が実行した環境ではList comprehensionの方が実行時間は短いとの結論でした。

```py
theoldlist = [i for i in range(1000)]
```

とlistを定義します。このリストに対して、各要素に23を加算した結果のリストを返すプログラムで実行時間の比較をします。

```py
%%time
a = list(map(lambda x: x + 23, theoldlist))
```

このとき

```
CPU times: user 163 µs, sys: 0 ns, total: 163 µs
Wall time: 168 µs
```

一方、

```py
%%time
a = [x + 23 for x in theoldlist]
```

の実行時間は

```
CPU times: user 76 µs, sys: 2 µs, total: 78 µs
Wall time: 82 µs
```

### List comprehensionとfilterの比較

こちらでもList comprehensionの方が実行時間が短い結果が得られました。

```py
theoldlist = [i for i in range(1000)]
```

と定義したリストに対して、値が５以上の要素を抽出し、そのリストを返すプログラムを考えます。

```py
%%time
thenewlist = list(filter(lambda x: x > 5, theoldlist))
```

結果は

```
CPU times: user 238 µs, sys: 0 ns, total: 238 µs
Wall time: 244 µs
```

List comprehensionの場合は、

```py
%%time
thenewlist = [x for x in theoldlist if x > 5]
```

実行時間は

```
CPU times: user 90 µs, sys: 0 ns, total: 90 µs
Wall time: 93 µs
```

### filterとmapとList comprehension

今回は値が５以上の要素に対して23を加算した結果のリストを返すプログラムを考えます。ポイントは`map`と`filter`を組み合わせて実施したプログラムとList comprehensionのみで書いたプログラムの実行時間を比較することです。

```py
%%time
thenewlist = list(map(lambda x: x+23, filter(lambda x: x>5, theoldlist)))
```

出力結果は

```
CPU times: user 241 µs, sys: 0 ns, total: 241 µs
Wall time: 245 µs
```

List comprehensionの場合は

```py
%%time
thenewlist = [x + 23 for x in theoldlist if x > 5]
```

実行時間は

```
CPU times: user 90 µs, sys: 3 µs, total: 93 µs
Wall time: 94.2 µs
```

となります。

## Referenece

- [Using List Comprehensions Instead of map and filter](https://www.oreilly.com/library/view/python-cookbook/0596001673/ch01s11.html)
