---
layout: post
title: "Hashing: Hash Table, Hash Set, Hash Map"
subtitle: "Data Structures 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-09-28
tags:

- 競技プログラミング
- データ構造
- Python

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Hash Tableとは？](#hash-table%E3%81%A8%E3%81%AF)
  - [どうやってkey-valueの対応関係を実現しているのか？: hash function](#%E3%81%A9%E3%81%86%E3%82%84%E3%81%A3%E3%81%A6key-value%E3%81%AE%E5%AF%BE%E5%BF%9C%E9%96%A2%E4%BF%82%E3%82%92%E5%AE%9F%E7%8F%BE%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B-hash-function)
  - [Collision in Hashing](#collision-in-hashing)
    - [Open addressの実装](#open-address%E3%81%AE%E5%AE%9F%E8%A3%85)
  - [Hash Setの実装](#hash-set%E3%81%AE%E5%AE%9F%E8%A3%85)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Hash Tableとは？

Hash Tableとは抽象的に言えばkey value lookup(=key-valueの対応関係サーチ)を実現するデータ構造です.
任意のキーが与えられたとき, そのキーに紐づくvalueを理想ならば$O(1)$runtimeでサーチできるという意味です.

例として, 以下のような個人名と個人情報を対応させるhash tableを考えます.

```python
## hash table example
{
    "kirby": [{"id":"0001", "address":"123-4567"}],
    "goo": [{"id":"0002", "address":"124-4567"}],
    "Dev": [{"id":"0003", "address":"125-4567"}]
}

hashtable.put("kirby", [{"id":"0001", "address":"123-4567"}])
hashtable.get("kirby")
>> [{"id":"0001", "address":"123-4567"}]
```

個人名をキーとして, それに対応するvalue = 個人情報を簡単にサーチしたいときのデータ構造としてhash tableは役に立ちます.
また, keyに対応したvalueの insertion という観点からもhash tableはperformance的に役に立つデータ構造です.


### どうやってkey-valueの対応関係を実現しているのか？: hash function

基本的にはhash tableも結局の所, array(配列, リスト)でデータを保持しています.
ここで問題となるのが, どのようにkey(上の例では個人名)をarray indexに対応させるかです.

```
"kirby" => a[0]
"ryo"   => a[1]
"alex"  => a[2]
...
"goo"   => a[10]
...
```

この場面で登場するのがhash functionです.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: hash function</ins></p>

ハッシュ関数は, 与えられた数値または文字列のキーを整数値に変換する関数のことで, この変換後の数値のことを特に
ハッシュ値と呼ぶ. Hash tableではハッシュ値自体を配列のindexとして利用することは少なく, 

```
hash(key) % length(array)
```

というように配列indexに合わせた数値変換を行い, その値をindexとして用いる

</div>

シンプルなhash関数の実装方法としてDivision Methodがあります.

```python
def dm_hash(key, array_size):
    """
    Division Methodに基づいたhash関数

    Parameters
    ----------
    param1 : int
        The hash key.
    param2 : int
        The hash table size.

    Returns
    -------
    int
        The hash value
    """
    return key % array_size
```

> Example

```
"kirby" => a[0]
"ryo"   => a[1]
"alex"  => a[2]
...
"goo"   => a[10]
...
```

この例ではkirbyというkeyがhash関数を介すことで, kirbyは`a[0]`という格納場所(=Bucketともいう)にアサインされている解釈できます.

### Collision in Hashing

ハッシュプロセスは, 大きなキーに対して小さな数値を生成するため, 2つのキーが同じ値を生成する可能性があります.
この衝突のことはCollisionといいます.

上記の例では

```python
dm_hash(15, 10)
>> 5

dm_hash(5, 10)
>> 5
```

となり, `5`, `15`の異なるキーに対して同じBucketを返してしまいます.
この問題の解決をするには以下のポイントを考える必要があります:

- bucketでどのようにvalueを格納すべきか？
- 特定のbucketの中からどのように特定のkeyに対応するvalueを見つけるか？

複数のkeyがassignされたbucketの最大保有key数を`N`としたとき, `N`が小さいならば連結配列を用いますが, `N`が大きいならば Open address法 を使ったりします.

#### Open addressの実装

open address法ではダブルハッシュという２つのハッシュ関数を用いてデータを格納する仕組みのことです.

まず実装コードを以下紹介します

```python
class OpenAdressHashTable:
    def __init__(self, hash_length: int):
        self.hash_length = hash_length
        self.bucket = [None] * self.hash_length
    
    def h1(self, key: int) -> int:
        return key % self.hash_length
    
    def h2(self, key: int) -> int:
        return 1 + (key % (self.hash_length - 1))

    def double_hash(self, key: int, i: int) -> int:
        return (self.h1(key) + i * self.h2(key)) % self.hash_length
    
    def insert(self, key: int):
        if self.search(key) is not None:
            raise ValueError("The key already exists")
        else:
            i = 0
            while True:
                idx = self.double_hash(key, i)
                if self.bucket[idx] == None:
                    self.bucket[idx] = key
                    break
                elif i >= self.hash_length:
                    raise Exception("The hash_length is not enough")
                else:
                    i += 1
    
    def search(self, key: int) -> int:
        i = 0
        while True:
            idx = self.double_hash(key, i)
            if self.bucket[idx] == key:
                return idx
            elif self.bucket[idx] == None or i >= self.hash_length:
                return None
            else:
                i += 1

    def remove(self, key: int):
        idx = self.search(key)
        if idx is None:
            raise ValueError("The key does not exists")        
        self.bucket[idx] = None 
```

特徴はHash関数（上記では`double_hash`）が, ２つのハッシュ関数の組み合わせとなっていることです.

$$
H(key) = h(k,i) = (h_1(k) + i \times h_2(k)) \ \ \text{mod } m
$$

- $m$: hash length
- $i\in [0, m]: 衝突が発生した回数
- $h_2(k)$の分だけindexが移動するので, $h_2(k)$とhash lengthは互いに素になる必要がある
  - hash lengthを素数として, $h_2(k)$の閾値をそれより小さい値に設定することで回避できる


### Hash Setの実装

Hash setはHash Tableの一種です. ただしvalueを重複することなく格納するという特徴があります(=`set`と同じ).
HashSet Classとして最低限必要な機能は

- `add(key)`: insert
- `remove(key)`: remove
- `contains(key)`: search

です. Pythonではbuilt-in libraryとして既に`set`として実装させていますが, 自分で定義すると以下のようになります.

```python
# Time: O(1)
# Memory Space: O(N)

class MyHashSet:
  def __init__(self):
    self.bucket = [False] * 1000001

  def add(self, key: int) -> None:
    self.bucket[key] = True

  def remove(self, key: int) -> None:
    self.bucket[key] = False

  def contains(self, key: int) -> bool:
    return self.bucket[key]
```

もう少し効率的にやるならば

```python
class MyHashSet:
  def __init__(self):
    self.bucket = set()

  def add(self, key: int) -> None:
    self.bucket.add(key)

  def remove(self, key: int) -> None:
    if self.contains(key):
        self.bucket.remove(key)

  def contains(self, key: int) -> bool:
    return key in self.bucket
```




References
----------------

- [geeksforgeeks > Hash Functions and list/types of Hash functions](https://www.geeksforgeeks.org/hash-functions-and-list-types-of-hash-functions/)
- [GitHub > RyoNakagami/PythonCompetitiveProgramming](https://github.com/RyoNakagami/PythonCompetitiveProgramming/blob/main/algorithm/data_structure/hashtable_openaddress.py)
