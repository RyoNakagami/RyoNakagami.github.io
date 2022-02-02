---
layout: post
title: "死神とのコイントスゲーム"
subtitle: "制約条件付きコイントスゲームとゲーム勝率の計算"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 成果物：制約条件付きコイントスゲームのDPの実装
tags:

- Dynamic Programming
- Python
- 競技プログラミング
- 統計
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
|目的|PythonでDPを書いてみる|
|プログラミング言語|Python 3.6.9 (Google Colabのデフォルト)|
|実行環境|Google Colab|
|参考|[2ch あなたの前に死神が現れて言いました](http://usi32.com/archives/7533325)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. 問題設定](#1-問題設定)
- [2. Dynamic Programming解法](#2-dynamic-programming解法)
  - [`value_func_prob(x, y)`の説明](#value_func_probx-yの説明)
  - [コラム：`@functools.lru_cache()`](#コラムfunctoolslru_cache)
- [3. 配列を用いた遷移確率列挙方式](#3-配列を用いた遷移確率列挙方式)
  - [計算ロジック](#計算ロジック)
  - [`float`を用いて計算するのに抵抗がある場合](#floatを用いて計算するのに抵抗がある場合)
- [4. Naiveなsimulationによる近似解](#4-naiveなsimulationによる近似解)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 問題設定

知人から、[2ch あなたの前に死神が現れて言いました](http://usi32.com/archives/7533325)という2ch記事の1ヶ月の生存確率求めることできる？って聞かれたのが今回の記事のきっかけです。ここに書いてあった問題は以下：

```
今あなたにコインを5枚渡す。 
あなたはこれから一ヶ月間の間、一日の始めに必ずコイントスをしなくてはならない。コイントスをして表が出た場合、私がコインをもう1枚渡す。裏が出た場合、あなたからコインを1枚没収する。 
あなたはコインを最大15枚まで持つことができ、勝手に捨てたり複製したりはできず、また15枚目以降は増やすことはできない。コインが0枚になった時点で、あなたは何らかの形で必ず死ぬ。 
一ヶ月の終わりに、1枚でもコインがあればあなたは月収の倍の金額か50万円か2ヶ月の寿命好きなものを獲得し、コイン5枚からまた一ヶ月続けるかを選択できる。やるかい？
```

求めて欲しいって言われたものは一ヶ月の生存確率。ちょっと原文のままだと不明確のところがあるので、この問題文を次のように解釈しました。

```
1ヶ月を30日とする。

0日目にコインを初期値5枚保有している。

１日の始まりにコイントスゲームを１回する。

コイントスゲームは、表(以下 H)が出たら保有コインが1枚増える。裏(以下 T)が出たら保有コインが1枚なくなる。

コインはフェアコイン（表裏の出る確率が同じ）とする。

コインは最大15枚までしか持てず、コイン15枚保有しているでコイントスゲームの結果表が出てもコインは増えない（裏が出たら減る）。

１日の期末に保有コインが0枚になったらその時点で死亡。二度と生き返らない（コイントスゲームはできない）。

30日目の期末まで生き残ってる確率を計算せよ。
```

この問題の解き方はいろいろあると思いますが、

1. Dynamic Programming解法
2. 配列を用いた遷移確率列挙方式
3. Naiveなsimulationによる近似解

以上の３つをこの記事で紹介します。

## 2. Dynamic Programming解法

まず解答を紹介します。PythonにおけるDPの書き方詳細は[こちら](https://realpython.com/python-thinking-recursively/)を参照してください。

```py
from functools import lru_cache

@lru_cache(maxsize=None)
def value_func_prob(x, y):
    p = 0.5
    if x == y:
        return (1-p)**x
    elif x > y:
        return 0
    elif x < 1:
        return 1
    #elif y < 1:
    #    return 0

    return p*value_func_prob(min(x+1, 15), y-1) + (1-p)*value_func_prob(x-1, y-1)

def main():
    print(1 - value_func_prob(x = 5, y = 30))

if __name__ == "__main__":
    main()
```

実行結果は`0.6384049290791154`となります。実行時間は

```
CPU times: user 965 µs, sys: 0 ns, total: 965 µs
Wall time: 971 µs
```

### `value_func_prob(x, y)`の説明

この関数はコインを `x` 枚保有している状態で `y` 日後までに死ぬ確率を計算しています。まず、以下のパートを説明します。

```py
    if x == y:
        return (1-p)**x
    elif x > y:
        return 0
    elif x < 1:
        return 1
    #elif y < 0:
    #    return 0
```

- `x == y`のときは、y 回連続して T が出ないと死ねません。なので裏が出る確率を $1-p$ とすると $(1-p)^y$ と死ぬ確率が計算できます。
- `x > y`のときは、残り日数よりコイン保有枚数が多いので死ねません。なので `Return` は `0` になります。
- `x < 1` は死んだ人は生き返らないので、つまり確率 1 で死ぬので `1`を返します。

次に、

```py
    return p*value_func_prob(min(x+1, 15), y-1) + (1-p)*value_func_prob(x-1, y-1)
```

を説明します。コイン保有枚数 `x > 0` 枚保有している状態で `y > x` 日後までに死ぬ確率は、表が出る確率を `p`, $Y$ を残り寿命, $X$ を残りコイン保有枚数 とした場合

<div class="math display" style="overflow: auto">
$$
\textrm{Pr}(Y \leq y | X = x) = p \cdot\textrm{Pr}(Y \leq y - 1| X = \min(x + 1, 15)) + (1-p) \cdot\textrm{Pr}(Y \leq y - 1| X = x-1)
$$
</div>

と表現できます。これをさらに展開すると、

<div class="math display" style="overflow: auto">
$$
\begin{aligned}
\textrm{Pr}(Y \leq y| X = x) =& p \cdot \textrm{Pr}(Y \leq y - 1| X = \min(x + 1, 15)) + (1-p) \cdot\textrm{Pr}(Y \leq y - 1| X = \max(x-1, 0 ))\\
= & p^2 \cdot\textrm{Pr}(Y \leq y - 2| X = \min(x + 2, 15)) + p(1-p) \cdot\textrm{Pr}(Y \leq y - 2| X = x)\\
& + p(1-p) \cdot\textrm{Pr}(Y \leq y - 2| X = x) + (1-p)^2 \cdot\textrm{Pr}(Y \leq y - 2| X = \max(x - 2, 0))\\
=&  \cdots
\end{aligned}
$$
</div>

となります。これは $X = x$ から遷移できる state は $X = x+1$ または $X = x-1$ にそれぞれ確率 $p$, $1 - p$で遷移することを意味してます。(詳しくは[こちら](https://python-advanced.quantecon.org/discrete_dp.html))

### コラム：`@functools.lru_cache()`

`@functools.lru_cache(maxsize=128, typed=False)`とは、文字通りleast recently usedアルゴリズム（= `Discards the least recently used items first`）に則ってサブルーチン実行結果をキャッシュしてくれる関数です。もう少し正確にいうと、関数をメモ化用の呼び出し可能オブジェクトでラップし、最近の呼び出し最大 maxsize 回（Noneの場合は上限なし）まで保存するするデコレータです。メモ化とは、サブルーチン呼び出しの結果を後で再利用するために保持する手法のことです。結果のキャッシュには辞書が使われるので、関数の位置引数およびキーワード引数はハッシュ可能でなくてはなりません。

また、引数のパターンが異なる場合は、異なる呼び出しと見なされ別々のキャッシュエントリーとなります。例えば、 `f(a=1, b=2)` と `f(b=2, a=1)` はキーワード引数の順序が異なっているので、2つの別個のキャッシュエントリーになります。

フィボナッチ数列をDPを用いて書く場合を例にすると、

```py
@lru_cache(maxsize=None)
def fib(n):
    if n < 2:
        return n
    return fib(n-1) + fib(n-2)

>>> [fib(n) for n in range(16)]
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]

>>> fib.cache_info()
CacheInfo(hits=28, misses=16, maxsize=None, currsize=16)
```

## 3. 配列を用いた遷移確率列挙方式

よりメモリ効率的かつシンプルな書き方です。この解き方を教えてくださった上司に感謝です（小学生でも思いつく方法と罵られましたが）。

```py
def main():
    init = 5
    ub = 15
    att = 30
    s = [[0]*(ub + 1), [0]*(ub + 1)]
    s[0][init] = 1
    p = 0.5
    
    for d in range(att):
        a = s[d%2]
        b = s[(d+1)%2]

        # リストの初期化
        for i in range(ub+1):
          b[i] = 0
        b[0] += a[0] # +=を用いているのは参照する値のデータアドレスを変えるため

        for i in range(1, ub):
            b[i-1] += a[i]*(1-p)
            b[i+1] += a[i]*p
        b[ub-1] += a[ub]*(1-p)
        b[ub] += a[ub]*p
    print(1 - b[0])
```

実行結果は`0.6384049290791154`となります。実行時間は

```
CPU times: user 596 µs, sys: 0 ns, total: 596 µs
Wall time: 542 µs
```

基本的な考え方は[Dynamic Programming解法](#2-dynamic-programming解法)と同じ。ここでは配列2つのみを用いているが、リストを31個用意しているイメージで解いている。

- まず、長さ16で全ての要素0がゼロのリストを31個用意する。31個のリストを順番に`D_0, D_1, ..., D_30`と命名します。（0個目のリスト、1個目のリスト ... 30個目のリスト）。
- リスト名 `D_xx`のxx(数値)は xx 日後を表しています。
- 各リストのindexはコインの所有枚数を表しており、valueはそこに到達する確率を表しています（例：`D_10[5] = 0.6` は10日後にコイン5枚持っている確率は`60%`）
- `p = 0.5`をコインの表が出る確率とします

### 計算ロジック

初期値設定として、ゲーム開始時点でプレーヤーは5枚のコインを持っているので、まずリスト`D_0`に対してindex 5に1を代入する。

```
D_0:  [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

１日目が到来します。このとき、保有コイン5枚から移動できる遷移先は保有コイン4枚と保有コイン6枚。なのでリスト`D_1`のindex 4 に対して`(1-p)*D_0[5]`を加え、index 6 に対して`p*D_0[5]`を加えます。

```
D_1:  [0, 0, 0, 0, 0.5, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

2日目が到来します。このとき、保有コイン4, 6枚から移動できる遷移先はそれぞれ保有コイン3枚と保有コイン5枚, 保有コイン5枚と保有コイン7枚。なのでリスト`D_2`のindex 3 に対して`(1-p)*D_1[4]`を加え、index 5 に対して`p*D_1[4] + (1-p)*D_1[6]`を加え、index 7 に対して`p*D_1[6]`を加えます。

```
D_2:  [0, 0, 0, 0.25, 0, 0.5, 0, 0.25, 0, 0, 0, 0, 0, 0, 0, 0]
```

この作業を繰り返していくだけです。注意点は任意のリストのindex 0の要素とindex 15の計算方法です。まずindex 0の注意点を説明します。死んだ人は生き返らないので

```
D_10[0] = D_9[0] + (1-p)*D_9[1]
```

と計算されます。同様にindex 15も保有枚数の上限があるので

```
D_10[15] = p*D_9[15] + p*D_9[14]
```

と計算します。

### `float`を用いて計算するのに抵抗がある場合

`float`を理由に発生する数値誤差が気になる場合は試行毎に人数が分裂すると考えて、以下のようにプログラムを書くこともできます。

```py
def main():
    init = 5
    ub = 15
    att = 30
    s = [[0]*(ub + 1), [0]*(ub + 1)]
    s[0][init] = 1
    p = 0.5
    
    for d in range(att):
        a = s[d%2]
        b = s[(d+1)%2]
        for i in range(ub+1):
          b[i] = 0
        b[0] += a[0]*2
        for i in range(1, ub):
            b[i-1] += a[i]
            b[i+1] += a[i]
        b[ub-1] += a[ub]
        b[ub] += a[ub]
    print(1 - b[0]/sum(b))
```

unfair coinの場合で`p = 0.6`の場合は、試行毎に10人に分裂し毎回4人と6人がそれぞれ次のindexに移動すると考えて計算すれば良いと思います。

## 4. Naiveなsimulationによる近似解

最後にNaiveなsimulationによる近似解を紹介します。

```py
import random

def game_func():
    money = 5
    days = 0
    while days < 30 and money > 0:
        money += 1 if random.randint(0, 1) > 0 else -1
        days += 1
    
    return min(money, 1)


def main():
    random.seed(42)
    survival = 0
    trial = 100000

    for t in range(trial):
        survival += game_func()
    
    print(survival/trial)
```

trial回数を100000回に設定して実行した結果は

```
0.6386
```

実行時間は

```
CPU times: user 3.31 s, sys: 2.02 ms, total: 3.31 s
Wall time: 3.31 s
```

とてつもなく遅い。
