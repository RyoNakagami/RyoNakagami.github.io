---
layout: post
title: "A Clockwork Orange, Anthony Burgess"
subtitle: "Pythonista Tips 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-10-08
tags:

- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Pythonにおける`None`とは？](#python%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Bnone%E3%81%A8%E3%81%AF)
- [Noneの判定](#none%E3%81%AE%E5%88%A4%E5%AE%9A)
  - [なぜ `is None`を使うべきなのか？](#%E3%81%AA%E3%81%9C-is-none%E3%82%92%E4%BD%BF%E3%81%86%E3%81%B9%E3%81%8D%E3%81%AA%E3%81%AE%E3%81%8B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Pythonにおける`None`とは？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: None in Python</ins></p>

- `None`とは, 関数が返すvalueが存在しないときや, 関数のデフォルトパラメーターとして何も渡さないときなど, **表現するvalueが存在しないときに使用するvalue**のこと
- `NoneType` objectの唯一のvalue

```python
type(None)
>> <type 'NoneType'>
```

</div>

`None`は「空の値」と「存在しない値」を区別するためにPythonでは使用されます. 

```python
EmptyString = ''
EmptyList = []
EmptySet = set()
EmptyDict = dict({})
```

上記はそれぞれ「空の値」ですが, `None`ではありません.
また, `False`や`0`とも異なります. 

```python
def is_none(obj):
    if obj is None:
        print(obj, ": It's None")
    elif obj:
        print(obj, ": It's True")
    elif obj is False:
        print(obj, ": It's False")
    else:
        print(obj, ": others")

check_list = [True, False, None, 0, 0.0, 1, -1, '', 'a']
for i in check_list:
    is_none(i)

>> True : It's True
>> False : It's False
>> None : It's None
>> 0 : others
>> 0.0 : others
>> 1 : It's True
>> -1 : It's True
>>  : others
>> a : It's True
```


## Noneの判定

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Rule: Noneの判定</ins></p>

- `None` のようなシングルトンと比較をする場合は, 常に `is` か `is not` を使うべき
- 絶対に等値演算子を使わない

from コーディング規約PEP8

</div>

```python
a = None
print(a is None)
>> True

print(a is not None)
>> False
```

### なぜ `is None`を使うべきなのか？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>is と == の違い</ins></p>

`is`と`==`は, 

- 前者が同一性(=Identity)の比較
- 後者が同値性(=Equality)の比較

となってるという違いがあります. オブジェクトの同一性は `id()` 関数を使って判定しています. 
例として, `x is y` は、 `x` と `y` が同じオブジェクトを指すとき, かつそのときに限り真になります.

</div>

これは例を見たほうが早いので, 

```python
class NoneTest():
    def __init__(self):
        pass

    def __eq__(self, other):
        return True

class BrokenNoneTest():
    def __eq__(self, other):
        return True

NoneTester_1 = NoneTest()
NoneTester_2 = BrokenNoneTest()

## type check
print(type(NoneTester_1))
>> <class '__main__.NoneTest'>

print(type(NoneTester_2))
>> <class '__main__.BrokenNoneTest'>

print(type(None))
>> <class 'NoneType'>

## 違うobject idを返すことの確認
print(id(NoneTester_1), id(NoneTester_2), id(None))
>> 139844009293264 139844009290512 139844232076320

## 判定
print(NonTester_1 == None)
>> True

print(NonTester_2 == None)
>> True

print(NonTester_1 is None)
>> False

print(NonTester_2 is None)
>> False
```
