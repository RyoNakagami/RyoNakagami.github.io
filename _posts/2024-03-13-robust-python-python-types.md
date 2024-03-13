---
layout: post
title: "Python Typesのすすめ"
subtitle: "Robust Python Programming 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: true
last_modified_at: 2024-03-13
tags:

- coding
- 方法論
- Python
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [データの型付け, typingはなぜ必要か](#%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E5%9E%8B%E4%BB%98%E3%81%91-typing%E3%81%AF%E3%81%AA%E3%81%9C%E5%BF%85%E8%A6%81%E3%81%8B)
  - [Mechanical Representation](#mechanical-representation)
  - [Semantic Representation](#semantic-representation)
- [Typing Systems](#typing-systems)
  - [Strong vs Weak](#strong-vs-weak)
  - [Dynamic Versus Static](#dynamic-versus-static)
  - [Duck Typing](#duck-typing)
- [Appendix: Glossary](#appendix-glossary)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## データの型付け, typingはなぜ必要か

Pythonランタイムは, 関数と変数のtype annotationを強制しません. 
にもかかわらず typing が推奨されるのはtypeが次の情報を伝えてくれるからです

- Mechanical representation: Python側に挙動の範囲や制約を知らせる意味(静的解析などへ)
- Semantic representation: 他の開発者にに挙動の範囲や制約を知らせる意味(refactoringなどへの活用)

### Mechanical Representation

Python compilerはPython programにおけるobjectsのtypeについては何も認識せず, 初めてわかるタイミングが
Python run-timeです. わざわざ変数の型を宣言/制約することなく柔軟なcodingが実現できるメリットがある一方, 
予期せぬBugsを引き寄せるリスクもあります.

例として, 最大公約数を計算する次の関数を定義したとします

```python
def gcd(a, b):
    while a:
        a, b = b%a, a
    return b
```

シンプルで良いコードですが, 最大公約数を計算するという観点から`a`や`b`に`float`型が入ることは開発者は想定
していないのが一般的です. 一方, このままだとPythonは`float`型が入ってきてもそのまま何も気にせず計算を始めてしまいます.

さらに`str`が入ってきてしまったときは`while`から抜け出せなくなってしまうというBugが発生します. このようなBugsを回避するために, typingが重要となります. PythonではDynamic typingを採用しているのでtype annotationを用いて以下のように記載するのが良いでしょう:

```python
def gcd(a: int, b: int) -> int:
    while a:
        a, b = b%a, a
    return b
```

### Semantic Representation

Semantic representationの意味におけるTypingは, エンティティについての期待される
挙動や制約, 使用方法などの情報を非同期的に他の開発者に対して伝えることを可能にします.

`int`型の変数が与えられとき,

- 四則演算などの算術演算が可能
- `<`, `>`, `==`, `!=`といった比較演算子が利用可能
- Bitwise演算が利用可能
- `ceil`, `floor`, `round`といったmethodが利用可能

という情報を得ることができます. 他にも `datetime`型が与えられたならば, `timedelta`による
加算/減算が可能, TZの変更が可能, `.strftime` methodを利用して`str`型へ変換可能ということがわかります.

Semantic RepresentationがRobust codeへどのようにつながるか以下の関数を例に考えてみます.

```python
def close_kitchen_if_past_cutoff_time(point_in_time):
    if point_in_time >= closing_time():
        close_kitchen()
        log_time_closed(point_in_time)
```

`point_in_time`を用いて動かす関数ということはわかりますが, 

- `str`型で`2024-03-13`のような値を`point_in_time`に入れるべきかのか?
- `datetime`型を予定しているのか?

この辺が判別できず, 適切な使い方がわからないという事象が発生してしまいます.
以下のようなtypingを用いることでこのような判断の迷いを低減することができます

```python
def close_kitchen_if_past_cutoff_time(point_in_time: datetime.datetime):
    if point_in_time >= closing_time():
        close_kitchen()
        log_time_closed(point_in_time)
```

このようにtypingされることで, 他の開発者はわざわざdocumentationを見たり, unittestを実施したり, 
わざわざオフィスに出社して対面で聞くなどの労力を割かなくても良くなります.

## Typing Systems

Typingの具体的アクションを紹介する前にまず, Pythonは動的かつ強力なTyping Systemをもつことを紹介します.
そこから, Pythonは互換性のない型を使用した際にエラーを通知してくれる一方, 動的型付けの性質より変数の型がruntime中に変化してしまうことを確認します.

### Strong vs Weak

Typing systemには強弱というものがあります. Haskell, TypeScript, Rustといった言語は
強い型付けシステム(Typing system)の代表例です. 型の意味的表現を破った操作をするとコンパイラエラーやランタイムエラーによって通知されます.

一方, JavaScript, Perlなどの弱い型付けシステム言語は, 型の不整合があっても暗黙的な変換（自動的な変換）により型エラーが検出されなかったりします. この意味でPythonは強い型付けシステム言語に分類されます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>異なるデータ型同士の演算: Python vs JavaScript</ins></p>

**Python**

```python
>>>[] + {}
TypeError: can only concatenate list (not "dict") to list

>>> {} + []
TypeError: unsupported operand type(s) for +: 'dict' and list
```

**JavaScript**

```js
>>> [] + {}
"[object Object]"

>>> {} + []
0
```

</div>

しかしながらこのエラーはruntime時に初めてわかるものです. Typingをはじめから実施しておけば, 実行しなくても
このようなエラーを見つける & 回避することができるので時間節約という観点からもTypingは重要であることがわかります.

### Dynamic Versus Static

Typingの文脈において, Dynamic typingとStatic Typingという分類があります.

- Dynamic typing: 変数の型が実行時に解釈され, 変数を宣言する際に型を明示的に指定する必要がないことを意味
- Static typing: 変数の型が定義時に宣言され, runtime中に変化することがない(= static)ことを意味

Pythonは基本的には動的型付け言語で, 変数の値の中に型情報が埋め込まれています.
Pythonは変数の型を実行時に変更することについて何のエラーも通知するなく以下のように実行できます:

```python
>>> a = 5
>>> a = "string"
>>> a
"string"

>>> a = tuple()
>>> a
()

>>> a: int = 5
>>> a = "string"
>>> a
"string"
```

最後のブロックの例は変数 `a`を`int`型で定義したにもかかわらず文字列が格納可能というPythonの悪い部分の例です.

### Duck Typing

> **Duck Typing** <br>
> If it walks like a duck and it quacks like a duck, then it must be a duck.

Duck typingとは**latent typing(潜在的なtyping)**や**structural typing(構造的ななtyping)**を意味します.

Duck Typingの有名な引用と照らし合わせるならば,

- I don't care what type you really are, as long as you walk() and quack().

ということなります. 例として以下のコードを見てみます.

```python
from typing import Iterable
def print_items(items: Iterable):
    for item in items:
        print(item)

print_items([1,2,3])
print_items({4, 5, 6})
print_items({"A": 1, "B": 2, "C": 3})
```

関数 `print_items` は引数 `items`について厳密な型確認は行っていませんが, データ型が`Iterable`かどうか
の確認はしています. 渡されたオブジェクトについて `__iter__` methodが存在するか確認し, 確認できたらloop処理に入るという挙動をします. `__iter__` methodが存在しないobjectを渡すと以下のようなエラーが出ます

```python
>>> print_items(5)

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 2, in print_items
TypeError: 'int' object is not iterable

>>> '__iter__' in dir(int)
False
>>> '__iter__' in dir(list)
True
```

関数で使用される変数やmethodをサポートしている型であれば(=構造的型付け), その関数で自由にその型を使用できるというのがDuck Typingです. だからこそ, I don't care what type you really are, as long as you walk() and quack().


## Appendix: Glossary

|Word|Explanation|
|----|-----------|
|Entity|Pythonにおけるobjectやinstance, variable, function, class, moduleを示す言葉|
|Python runtime|Python codeが実行されるシステムや環境のこと|
|Semantics|意味論. operationの意味とプログラミング文脈では解釈される|



References
----------
- [Robust Python > Chapter 1. Introduction to Robust Python](https://learning.oreilly.com/library/view/robust-python/9781098100650/ch01.html#idm44996902834672)
- [ALL Things Pythonic - Adding Optional Static Typing to Python](https://www.artima.com/weblogs/viewpost.jsp?thread=85551)
- [Computing Thoughts - Duck Typing, Libraries, and Concurrency](https://www.artima.com/weblogs/viewpost.jsp?thread=131502)
- [Ryo's Tech Blog > Coding Style Guide Part 1](https://ryonakagami.github.io/2021/05/02/Coding-Guide/#%E8%89%AF%E3%81%84%E3%82%B3%E3%83%BC%E3%83%89%E3%81%A8%E3%81%AF)
- [Ryo's Tech Blog > Robust Codeを書くためのプログラミング姿勢について](https://ryonakagami.github.io/2024/03/12/robust-python-what-is-robustness/)