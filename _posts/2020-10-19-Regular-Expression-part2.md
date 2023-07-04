---
layout: post
title: "正規表現入門 part 2"
subtitle: "Pythonと正規表現によるパターンマッチング"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 成果物：Pythonのre モジュールを用いた文字列操作ができるようになる
tags:

- regex
- Python
---



|概要||
|---|---|
|目的|Pythonの`re` モジュールを用いた文字列操作を紹介する|
|参考|[退屈なことはPythonにやらせよう――ノンプログラマーにもできる自動化処理プログラミング](https://www.oreilly.co.jp/books/9784873117782/)|
|前回記事|[正規表現入門 part 1](https://ryonakagami.github.io/2020/10/16/Regular-Expression-part1/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. `re`モジュールと正規表現を用いた文字列マッチング](#1-re%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%81%A8%E6%AD%A3%E8%A6%8F%E8%A1%A8%E7%8F%BE%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E6%96%87%E5%AD%97%E5%88%97%E3%83%9E%E3%83%83%E3%83%81%E3%83%B3%E3%82%B0)
  - [Regexオブジェクトを生成する](#regex%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%82%92%E7%94%9F%E6%88%90%E3%81%99%E3%82%8B)
  - [`search()` methodを用いてegexオブジェクトと文字列のマッチング](#search-method%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6egex%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%A8%E6%96%87%E5%AD%97%E5%88%97%E3%81%AE%E3%83%9E%E3%83%83%E3%83%81%E3%83%B3%E3%82%B0)
  - [エスケープとraw文字列](#%E3%82%A8%E3%82%B9%E3%82%B1%E3%83%BC%E3%83%97%E3%81%A8raw%E6%96%87%E5%AD%97%E5%88%97)
- [2. 丸括弧を用いたグルーピングとインデックス参照](#2-%E4%B8%B8%E6%8B%AC%E5%BC%A7%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%94%E3%83%B3%E3%82%B0%E3%81%A8%E3%82%A4%E3%83%B3%E3%83%87%E3%83%83%E3%82%AF%E3%82%B9%E5%8F%82%E7%85%A7)
- [3. グルーピングと選択マッチ](#3-%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%94%E3%83%B3%E3%82%B0%E3%81%A8%E9%81%B8%E6%8A%9E%E3%83%9E%E3%83%83%E3%83%81)
- [4. 貪欲マッチと非貪欲マッチ](#4-%E8%B2%AA%E6%AC%B2%E3%83%9E%E3%83%83%E3%83%81%E3%81%A8%E9%9D%9E%E8%B2%AA%E6%AC%B2%E3%83%9E%E3%83%83%E3%83%81)
  - [控えめマッチ通しのグルーピングのキャプチャの結果](#%E6%8E%A7%E3%81%88%E3%82%81%E3%83%9E%E3%83%83%E3%83%81%E9%80%9A%E3%81%97%E3%81%AE%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%94%E3%83%B3%E3%82%B0%E3%81%AE%E3%82%AD%E3%83%A3%E3%83%97%E3%83%81%E3%83%A3%E3%81%AE%E7%B5%90%E6%9E%9C)
  - [正規表現と循環小数の抽出](#%E6%AD%A3%E8%A6%8F%E8%A1%A8%E7%8F%BE%E3%81%A8%E5%BE%AA%E7%92%B0%E5%B0%8F%E6%95%B0%E3%81%AE%E6%8A%BD%E5%87%BA)
- [5. `findall()`](#5-findall)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. `re`モジュールと正規表現を用いた文字列マッチング

文字列から電話番号を検索したいとします。電話番号は`080-7777-9999`といった３桁の数字、ハイフン、４桁の数字、ハイフン、４桁の数字といった形式だとします。与えられた文字列が電話番号の形式に合致してる部分列を含んでいたら

```
電話番号が見つかりました: <電話番号>
```

という出力するPythonのプログラムを作りたいとします。Pythonで正規表現を用いた文字列マッチングを実施したい場合、`re`モジュールを使います。

### Regexオブジェクトを生成する

まず`re`モジュールをインポートし、マッチさせたい文字列に対応したRegexオブジェクトを作成します

```python
import re

# Regexパターンオブジェクト
phone_pattern_regex = re.compile(r'\d{3}-\d{4}-\d{4}')
```

まずこのRegexオブジェクトのmethod, attributeを紹介します。便宜上Regexオブジェクトを`Pattern`とします。

|method/attribute|説明|
|---|---|
|`Pattern.search(string)`|stringに対し、この正規表現がマッチを生じさせる最初の場所を探して、対応するマッチオブジェクトを返します。文字列がパターンにマッチしなければ None を返します。substring一致に対応する。|
|`Pattern.match(string`|stringの先頭で0文字以上がこの正規表現とマッチするなら、対応するマッチオブジェクトを返します。文字列がパターンにマッチしなければ None を返します。prefix一致に対応する。|
|`Pattern.fullmatch(string)`|string 全体がこの正規表現にマッチすれば、対応するマッチオブジェクトを返します。文字列がパターンにマッチしなければ`None`を返します。完全一致に対応する。|
|`Pattern.split(string)`|string を、出現したpatternで分割します。|
|`Pattern.sub(repl, string, count=0)`|string中に出現する最も左の重複しない`pattern`を置換 `repl` で置換することで得られる文字列を返します。 パターンが見つからない場合、 string がそのまま返されます。 `repl` は文字列または関数です。オプション引数 count は出現したパターンを置換する最大の回数です。 count は非負整数です。省略されるか 0 なら、出現した全てが置換されます。|
|`Pattern.pattern`|パターンオブジェクトがコンパイルされた元のパターン文字列|

今回はsubstring一致機能を使いたいので`search` methodを用いてプログラムを作ります。

### `search()` methodを用いてegexオブジェクトと文字列のマッチング

`search()` methodは文字列に対して、コンパイルされた正規表現と最初にマッチする部分のマッチオブジェクトを返します。

```python
import re

# 電話番号を検索したい文字列
strings = '''
A: LINEで認証するのでコード送った～番号教えて。僕のは080-1234-5678。
B: 私のは090-1234-5678よ
'''

# Regexパターンオブジェクト
phone_pattern_regex = re.compile(r'\d{3}-\d{4}-\d{4}')

# search()
phone_num = phone_pattern_regex.search(strings)

print('電話番号が見つかりました:' + phone_num.group())
```

というプログラムを実行すると

```
>>> 電話番号が見つかりました:080-1234-5678
```

と返ってきます。正規表現にマッチする文字列は`080-1234-5678`と`090-1234-5678`の二つがありますが、`Pattern.search()`は文字列を前方から探索していき、正規表現にマッチした最初の部分文字列しか返さないので、後者は出力されないということになります。

### エスケープとraw文字列

Pythonではraw文字という概念があります。文字列の前に`r`とつけるとその文字列がraw文字となります。一例として、

```python
# Regexパターンオブジェクト
phone_pattern_regex = re.compile(r'\d{3}-\d{4}-\d{4}')
```

raw文字列では、`\`がエスケープ文字になりません。すなわち、単独の`\`でバックスラッシュを表します。たとえば、`r'\n'`は`'\\n'`と同じになります。

```python
print('aaa\nbbb')
print('')
print(r'aaa\nbbb')
```
とすると実行結果は

```
aaa
bbb

aaa\nbbb
```
となります。正規表現を用いる場合は、`ごく単純な表現以外は、全て raw 文字列を使うことを強く推奨します`と公式ドキュメントにも書いてあるので、基本的にはつけましょう。

## 2. 丸括弧を用いたグルーピングとインデックス参照

「Hatamoto Hiroshi」のようなアルファベットで与えられた Family Name, space, First Nameという形式の文字列をFirst Name, space, Family Nameという形式に変換したいとします。

```python
import re

strings = 'レキシ - 年貢って歌を歌っている人のレキシネームはHatamoto Hiroshiです。'

# Regexパターンオブジェクト
rekishiname_regex = re.compile(r'([A-Za-z]{1,})\s([A-Za-z]{1,})')

rekishi_match = rekishiname_regex.search(strings)

print('その人の名前は' + rekishi_match.group(2) + ' ' + rekishi_match.group(1) + 'です\n')
print('group(0)の出力:' + rekishi_match.group(0) + '\n')
print('groups() methodはマッチした各要素をタプルで出力する')
print(rekishi_match.groups())
```

実行結果は

```
その人の名前はHiroshi Hatamotoです

group(0)の出力:Hatamoto Hiroshi

groups() methodはマッチした各要素をタプルで出力する
('Hatamoto', 'Hiroshi')
```

全てのグループを一度に取得したい場合は`groups()` methodを用います。なお、bashにおける正規表現のインデックス参照と同様で、`rekishi_match.group(0)`と指定するとマッチした文字列全体が出力されます。see [here](https://ryonakagami.github.io/2020/10/16/Regular-Expression-part1/#事例-1-順番キャプチャ-bashと正規表現を用いてファイルをrenameする)。


## 3. グルーピングと選択マッチ

正規表現 `|`を用いて選択マッチを確認します。与えられた文字列からballを含む単語を抽出したいとします。

```py
import re

sport_object = re.compile(r'(foot|base)ball')

sport1 = sport_object.search('I love football and baseball')
print(sport1.group())

sport2 = sport_object.search('I love baseball and football')
print(sport2.group())
```

このときの結果は、
```
football
baseball
```

となります。`Pattern.search()`は文字列先頭から検索していき最初に指定した正規表現とマッチする部分文字列を取得します。そのため、footballとbaseballの順番が前後すると、それに合わせて出力結果も前後します。

次に、`Pattern.group()`の引数を変更した以下のプログラムを実行します。

```py
import re

sport_object = re.compile(r'(foot|base)ball')

sport1 = sport_object.search('I love football and baseball')
print(sport1.group())
print(sport1.group(1))
```

このときの結果は、
```
football
foot
```

`sport1.group()`はマッチした文字列全体を出力し、`sport1.group(1)`はグループ内のマッチした文字列だけを出力します。

## 4. 貪欲マッチと非貪欲マッチ

`*`, `+`, `?`といった量指定子が関わる場合、貪欲マッチ(greedy match)と非貪欲マッチ(lazy match)の２種類があります。量指定子はデフォルトでは貪欲マッチであり、量指定子の直後に`?`を付加すると非貪欲マッチになります。

まず挙動の違いを確認します。

```py
import re

stand_object = re.compile(r'(foo)??')
regex_match_1 = stand_object.search('foofoofoo')
print('出力結果')
print(regex_match_1.group())

stand_object_2 = re.compile(r'(foo)?')
regex_match_2 = stand_object_2.search('foofoofoo')
print(regex_match_2.group())

stand_object_3 = re.compile(r'(foo){2,3}?')
regex_match_3 = stand_object_3.search('foofoofoo')
print(regex_match_3.group())

stand_object_4 = re.compile(r'(foo){2,3}')
regex_match_4 = stand_object_4.search('foofoofoo')
print(regex_match_4.group())
```

実行結果は

```
出力結果

foo
foofoo
foofoofoo
```

となります。貪欲マッチは正規表現で指定された最も長いマッチを抽出し、非貪欲マッチは最も短いマッチを抽出します。

### 控えめマッチ通しのグルーピングのキャプチャの結果

「どちらも控え目」である正規表現のマッチングを確認します。`^(a*?)(a*?)$`という正規表現を考えます。これは「aの0回以上の繰り返しの直後にaの0回以上の繰り返し」というパターンです。これに対し、`aaaaa`という文字列をマッチさせます。

```py
import re

regex_object = re.compile(r'^(a*?)(a*?)$')
print(regex_object.match('aaaaa').groups())
```

この実行結果は

```
('', 'aaaaa')
```
となります。正規表現の基本は「左から右」という優先順位の原則が適用されるので、空文字のキャプチャは一つ目のグルーピングにマッチします。

### 正規表現と循環小数の抽出

ここでは非貪欲マッチを用いた循環小数の抽出を紹介します。[Project Euler problem 26](https://projecteuler.net/problem=26)という問題を参考にしています。問題は以下です。

分子に1を持つ有理数を考えます。2から10までの自然数が分母に与えられた場合

```
1/2  = 0.5
1/3  = 0.(3)
1/4  = 0.25
1/5  = 0.2
1/6  = 0.1(6)
1/7  = 0.(142857)
1/8  = 0.125
1/9  = 0.(1)
1/10 = 0.1
```
と表記されます。`0.1(6)` は `0.166666...`を意味します。`1/7` は6-digit recurring cycleです。このとき、1000未満の自然数を分母にとったとき、最も長いecurring cycleを持つ自然数を見つけてください。

```py
import re
from decimal import Decimal
from decimal import getcontext

length = 0
max_len = 0
d = 1
getcontext().prec = 2000
regex_pattern = r"^0\.[0-9]{0,}?([0-9]{7,}?)(\1+)[0-9]*?$" # ^ means the initial

for i in range(10, 1000):
    frac_val = 1/Decimal(i)
    pattern = re.search(regex_pattern, str(frac_val))

    if pattern is None:
        continue
    else:
        length = len(pattern.group(1))
    
    if length > max_len:
        max_len = length
        d = i

print(d, max_len)
```

実行結果は`983 982`となります。` \1`は1つ目のグルーピングの参照となります。`(\1+)`で１個目のグループが１回以上繰り返されることを指定しています。

## 5. `findall()`

上で紹介した`search()`が最初にマッチした文字列のMatchオブジェクトを返すのに対し、`findall()`は見つかった文字列を返します。返ってくる文字列とその形式はグルーピングによって変わります。

下のPythonプログラムは与えられた文字列に対してグルーピングを用いて正規表現を指定した場合とそうでない場合の結果をそれぞれ出力しています。

```py
import re 
  
# A sample text string where regular expression  
# is searched. 
string  = """Hello my Number is 123456789 and 
             my friend's number is 987654321"""
  
# A sample regular expression to find digits. 
regex = r'my[\sA-Za-z\']{0,}?\sis\s\d+'             
  
match = re.findall(regex, string) 
print(match)

regex_2 = r'(my[\sA-Za-z\']{0,}?)\sis\s(\d+)'             
  
match_2 = re.findall(regex_2, string) 
print(match_2)
```

出力結果は

```
['my Number is 123456789', "my friend's number is 987654321"]
[('my Number', '123456789'), ("my friend's number", '987654321')]
```

これからわかるようにグルーピングを用いない場合は、マッチした文字列のリストを返しますが、グルーピングした場合は、グルーピングに対応した要素のタプルのリストを返しています。
