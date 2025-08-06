---
layout: post
title: "Type Annotationsのすすめ"
subtitle: "Robust Python Programming 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: true
last_modified_at: 2024-03-14
tags:

- coding
- 方法論
- Python
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [この記事のスコープ](#%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [Type Annotationsとはなんなのか？](#type-annotations%E3%81%A8%E3%81%AF%E3%81%AA%E3%82%93%E3%81%AA%E3%81%AE%E3%81%8B)
  - [Type Annotationsによるcognitive overheadの低減](#type-annotations%E3%81%AB%E3%82%88%E3%82%8Bcognitive-overhead%E3%81%AE%E4%BD%8E%E6%B8%9B)
  - [Annotating `return types`](#annotating-return-types)
  - [変数の定義とType Annotations](#%E5%A4%89%E6%95%B0%E3%81%AE%E5%AE%9A%E7%BE%A9%E3%81%A8type-annotations)
- [Type Annotationsの機能面でのメリット](#type-annotations%E3%81%AE%E6%A9%9F%E8%83%BD%E9%9D%A2%E3%81%A7%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
  - [Autocomplete](#autocomplete)
  - [Typecheckers](#typecheckers)
  - [いつTypechekerをつかうべきか?](#%E3%81%84%E3%81%A4typecheker%E3%82%92%E3%81%A4%E3%81%8B%E3%81%86%E3%81%B9%E3%81%8D%E3%81%8B)
- [BUG発見EXERCISE](#bug%E7%99%BA%E8%A6%8Bexercise)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## この記事のスコープ

Python 3.5以降で導入された type annotationsについて解説した記事です. 

> **Guido van Rossum**より引用
>> I’ve learned a painful lesson that for small programs dynamic typing is great. For large programs you have to have a more disciplined approach and it helps if the language actually gives you that discipline, rather than telling you “Well, you can do whatever you want.

Type annotationsとは, 動的型付け言語であるPythonで書かれたcodeに規律(discipline)を与える
Pythonの仕組みの一つです. なお留意点としては, 上の引用でもあるように

- ちょっとしたスクリプトを書くときは厳密にやらなくても良い
- あくまで長くメンテされることを予定した大きいコードを書くときに有用な仕組み

であることを忘れないでください. あくまで他人と非同期的なコミュニケーションをする際に有用なツールであり, 
探索的に自分だけでプログラミングするときなどは別に使わなくて良いと思います.

## Type Annotationsとはなんなのか？

Type Annotationsとは, 開発者が取り扱っている変数について期待されているデータ型を示すsyntaxのことです.

```python
def close_kitchen_if_past_close(point_in_time: datetime.datetime): 
    if point_in_time >= closing_time():
        close_kitchen()
        log_time_closed(point_in_time)
```

この例では, `point_in_time`のデータ型として `datetime.datetime`型が期待されていることがType Annotations
によって示されています. この`close_kitchen_if_past_close()`関数を使用するときのみならず, 変更するときにどのようなデータ型の範囲で変更してよいのかを示唆してくれるというメリットがあります.

### Type Annotationsによるcognitive overheadの低減

```python
import datetime
import random

def schedule_restaurant_open(open_time, workers_needed):
    workers = find_workers_available_for_time(open_time)
    # Use random.sample to pick X available workers
    # where X is the number of workers needed.
    for worker in random.sample(workers, workers_needed):
        worker.schedule(open_time)
```

という他の人が書いたコードが与えられ, `schedule_restaurant_open()`関数を使いたい状況を想定します.
このとき, 

- open_timeは`datetime`型を入れればいいのか？それとも`YYYY-MM-DD`のような文字列を入れればいいのか?
- workers_needed: 必要なthe number of workersという意味で`int`を入れればよいのか？

が一見ではわかりません. `random.sample`が使われていることから`workers_needed`は`int`型を予定していることが推察できますが, line-by-lineで読んでわかることであり, cognitive overheadが発生します. また, 実装を読んでも`opentime`のデータ型は推察することができず, `worker` classのコードを見に行かなくてはなりません.

```python
import datetime
import random

def schedule_restaurant_open(open_time: datetime.datetime,
                             number_of_workers_needed: int):
    workers = find_workers_available_for_time(open_time)
    # Use random.sample to pick X available workers
    # where X is the number of workers needed.
    for worker in random.sample(workers, number_of_workers_needed):
        worker.schedule(open_time)
```

とType Annotationsが活用されていれば, 

- open_timeは`datetime`型
- workers_neededは`int`型

と`random.sample`にたどり着く前に判断することができます. `number_of_workers_needed`という変数名もType Annotationsの内容と整合的であり, より理解しやすくなったコードになったと言えます.

### Annotating `return types`

上記の`schedule_restaurant_open()`関数の中に`find_workers_available_for_time()`が呼ばれています. 

- `workers`を返している
- `workers`は`for`文で呼ばれているのでイタラブル型

ということは推察できますが, `list`型なのか, `tuple`型なのか, それ以外なのか？よくわかりません.
そこで実装を見てみると次のようなコードでした.

```python
def find_workers_available_for_time(open_time: datetime.datetime):
    workers = worker_database.get_all_workers()
    available_workers = [worker for worker in workers
                           if is_available(worker)]
    if available_workers:
        return available_workers

    # fall back to workers who listed they are available
    # in an emergency
    emergency_workers = [worker for worker in get_emergency_workers()
                           if is_available(worker)]

    if emergency_workers:
        return emergency_workers

    # Schedule the owner to open, they will find someone else
    return [OWNER]
```

Returnのパターンが

- `available_workers`
- `emergency_workers`
- `[OWNER]`

と３つ存在しており, 一貫性があるのかすらよくわかりません. `worker_database.get_all_workers()`関数や`get_emergency_workers()`関数を調査し, 簡易なテストの実行しなくてはならないような状況です. ここで役に立つのが`return type`です.

```python
def find_workers_available_for_time(open_time: datetime.datetime) -> list[str]:
```

のように関数宣言の最後に `-> <type>` を付与することで返り値に期待されるデータ型をコミュニケーションすることができます.  `worker_database.get_all_workers()`関数や`get_emergency_workers()`関数を調査し, 簡易なテストの実行という工数をちょっとした文字列を付与するだけで解決することができました.

### 変数の定義とType Annotations

変数の定義時にも以下のようにType Annotationsを利用することができます.

```python
workers: list[str] = find_workers_available_for_time(open_time)
numbers: list[int] = []
ratio: float = get_ratio(5,3)
number: int = 0
text: str = "useless"
values: list[float] = [1.2, 3.4, 6.0]
worker: Worker = Worker()
```

ただし, 上記の例のいくつかはType Annotationsを用いなくても良いです.
`"useless"`や`0`はそれぞれ`str`や`int`と一目でわかります. あくまで他人と非同期的なコミュニケーションをする際に有用なツールだからType Annotationsを使うのであって, **Type Annotationsを使うためにType Annotationsを使うわけではありません**.

## Type Annotationsの機能面でのメリット

上での説明はsemanticな意味でのメリットを用いながらType Annotationsのメリットを紹介しましたが, 

- Autocomplete
- Typecheckers

などPythonの機能面でのメリットをここでは紹介します.


### Autocomplete

VSCodeを使っている人の多くは Pylance を拡張機能に入れているかもしれません.
Pylance は, その背後にMicrosoftの静的型チェックツールであるPyrightが動いており, その機能を利用することで豊富な型情報を用いたPythonのIntelliSenseを提供してくれます.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/CodingGuide/robustpython_ropy_0301.png?raw=true">

open_time変数に対してType Annotationsを利用することで, open_time変数を利用するとき, methodやattributesの候補提示を利用することができます.

### Typecheckers

Typecheckersとは静的解析の1つです. PylanceでもTypecheker機能を使うことができますが, Defaultでは
offになっているので

```json
{
    // Typecheker
    "python.analysis.typeCheckingMode": "standard",
}
```

と`settings.json`で設定する必要があります. 設定後, Pythonファイルを適当に開き, 

```python
a: int = 5
a = 'string'
```

と記載すると, 解析時に以下のようなWarningが出てきます.

```
Expression of type "Literal['string']" cannot be assigned to declared type "int"
"Literal['string']" is incompatible with "int"
```

`None`も許容したいときに警告が吐かれてしまう場合もありますが, その場合は

```python
a: int | None = 5
a = None
```

とすればTypechecker解析を警告なしでやり過ごすことができます.


### いつTypechekerをつかうべきか?

すべてのエンティティに対して, Type Annotationsを実施することはすごく労力を有します.
プライベートでちょっとした関数を試したいときなどは必要は無いですし, 大人数で開発するときもすべての変数に必要なわけではありません.

基本的には以下に該当するときにtypecheckerを利用することを検討する方針が良いとされます:

- public APIs, library entry pointsなど他のモジュールや開発者が利用すると思われる関数
- データ型を強調したいときや, counter-intuitiveなロジック展開をする場合

## BUG発見EXERCISE

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Exercise 1</ins></p>

```python
def read_file_and_reverse_it(filename: str) -> str:
    with open(filename) as f:
        # Convert bytes back into str
        return f.read().encode("utf-8")[::-1]
```

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

` -> str`とreturnについてType Annotationされているが, UTF-8にエンコードされたものを返している = byte型を返しているので

```
Incompatible return value type
(got "bytes", expected "str")
```

のバグがある

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Exercise 2</ins></p>

```python
# takes a list and adds the doubled values
# to the end
# [1,2,3] => [1,2,3,2,4,6]
def add_doubled_values(my_list: list[int]):
    my_list.update([x*2 for x in my_list])

add_doubled_values([1,2,3])
```

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

`my_list: list[int]`と引数についてType Annotationされているが, `List`型に`update` methodは存在しない. つまり, 

```
"list[int]" has no attribute "update"
```

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Exercise 3</ins></p>

```python
# The restaurant is named differently
# in different parts of the world
def get_restaurant_name(city: str) -> str:
    if city in ITALY_CITIES:
            return "Trattoria Viafore"
    if city in GERMANY_CITIES:
            return "Pat's Kantine"
    if city in US_CITIES:
            return "Pat's Place"
    return None


if get_restaurant_name('Boston'):
    print("Location Found")
```

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

` -> str`とreturnについてType Annotationされているが, `None`を返すパターンがある. つまり, 

```
Incompatible return value type
(got "None", expected "str")
```

これを許容したい場合は 

```python
def get_restaurant_name(city: str) -> str | None:
    ...
```

と宣言すべき

</div>



References
----------
- [Robust Python > Chapter 3. Type Annotations](https://learning.oreilly.com/library/view/robust-python/9781098100650/ch03.html)
- [Ryo's Tech Blog > Coding Style Guide Part 1](https://ryonakagami.github.io/2021/05/02/Coding-Guide/#%E8%89%AF%E3%81%84%E3%82%B3%E3%83%BC%E3%83%89%E3%81%A8%E3%81%AF)
- [Ryo's Tech Blog > Robust Codeを書くためのプログラミング姿勢について](https://ryonakagami.github.io/2024/03/12/robust-python-what-is-robustness/)
- [Ryo's Tech Blog > Python Typesのすすめ](https://ryonakagami.github.io/2024/03/13/robust-python-python-types/)
