---
layout: post
title: "コインの両替問題とプログラミング"
subtitle: "コインの両替問題に関係して面白いなと思った問題をまとめる"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- math
- プログラミング
- 競技プログラミング
- Python
- Dynamic Programming
---
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|コインの両替問題に関係して面白いなと思った問題をまとめる|
|参考|- [Project Euler Problem 31](https://projecteuler.net/problem=31)<br>- [5.12. Dynamic Programming](https://runestone.academy/runestone/books/published/pythonds/Recursion/DynamicProgramming.html)<br>- [飯田浩志. 整数ナップサック問題が多項式時間で解ける特殊な場合を定める条件について.](https://github.com/ryonakimageserver/lecturenotes/blob/main/math/%E9%A3%AF%E7%94%B0%E6%B5%A9%E5%BF%97%20-%20%20%E6%95%B4%E6%95%B0%E3%83%8A%E3%83%83%E3%83%97%E3%82%B5%E3%83%83%E3%82%AF%E5%95%8F%E9%A1%8C.pdf)<br>- [OR - Optimality of a Heuristic Solution for a Class of Knapsack Problems.pdf](https://github.com/ryonakimageserver/lecturenotes/blob/main/math/OR%20-%20Optimality%20of%20a%20Heuristic%20Solution%20for%20a%20Class%20of%20Knapsack%20Problems.pdf)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem 1: 100円を両替する方法](#problem-1-100%E5%86%86%E3%82%92%E4%B8%A1%E6%9B%BF%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95)
  - [解答その１](#%E8%A7%A3%E7%AD%94%E3%81%9D%E3%81%AE%EF%BC%91)
  - [解答その２](#%E8%A7%A3%E7%AD%94%E3%81%9D%E3%81%AE%EF%BC%92)
- [Problem 2: Project Euler Problem 31より](#problem-2-project-euler-problem-31%E3%82%88%E3%82%8A)
  - [解答: Python](#%E8%A7%A3%E7%AD%94-python)
- [Problem 3: 階段の昇り方, 07京大理系](#problem-3-%E9%9A%8E%E6%AE%B5%E3%81%AE%E6%98%87%E3%82%8A%E6%96%B9-07%E4%BA%AC%E5%A4%A7%E7%90%86%E7%B3%BB)
  - [解答](#%E8%A7%A3%E7%AD%94)
- [Problem 4: コイン最小支払い枚数問題（Change-Making Problem : CMP）](#problem-4-%E3%82%B3%E3%82%A4%E3%83%B3%E6%9C%80%E5%B0%8F%E6%94%AF%E6%89%95%E3%81%84%E6%9E%9A%E6%95%B0%E5%95%8F%E9%A1%8Cchange-making-problem--cmp)
  - [解答方針](#%E8%A7%A3%E7%AD%94%E6%96%B9%E9%87%9D)
  - [最小支払い枚数のコインの組合せを返す関数](#%E6%9C%80%E5%B0%8F%E6%94%AF%E6%89%95%E3%81%84%E6%9E%9A%E6%95%B0%E3%81%AE%E3%82%B3%E3%82%A4%E3%83%B3%E3%81%AE%E7%B5%84%E5%90%88%E3%81%9B%E3%82%92%E8%BF%94%E3%81%99%E9%96%A2%E6%95%B0)
  - [貪欲法で解けるための条件](#%E8%B2%AA%E6%AC%B2%E6%B3%95%E3%81%A7%E8%A7%A3%E3%81%91%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE%E6%9D%A1%E4%BB%B6)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Problem 1: 100円を両替する方法

1円, 5円, 10円, 50円の貨幣があるとき、100円を支払う方法は何通りあるか？

### 解答その１

1円, 5円, 10円, 50円のいずれかを０枚以上使って$$n$$円を支払う通りを$$D(n)$$と表すとする。1円, 5円, 10円のいずれかを０枚以上使って$$n$$円を支払う通りを$$C(n)$$と表すとする。1円, 5円のいずれかを０枚以上使って$$n$$円を支払う通りを$$B(n)$$と表すとする。1円を０枚以上使って$$n$$円を支払う通りを$$A(n)$$と表すとする。

|種類|説明|
|---|---|
|$$D(n)$$|1円, 5円, 10円, 50円のいずれかを０枚以上使って$$n$$円払う|
|$$C(n)$$|1円, 5円, 10円のいずれかを０枚以上使って$$n$$円払う|
|$$B(n)$$|1円, 5円のいずれかを０枚以上使って$$n$$円払う|
|$$A(n)$$|1円を０枚以上使って$$n$$円払う|

このとき$$A(0) = B(0) = C(0) = D(0) = 1$$及び$$n<0$$のときは $$0$$ に注意します。今回求めたい問題は$$D(100)$$の値です。このとき、

$$
D(100) = C(100) + D(50)
$$

となります。同様に分割していくと

$$
\begin{aligned}
D(100)& = C(100) + D(50)\\
& = B(100) + C(90) + C(50) + D(0)\\
& = B(100) + B(90) + C(80) + C(50) + D(0)
\end{aligned}
$$

このとき、$$B(n)$$について

$$
B(n) = n\div 5 + 1
$$

が成立します。$$C(n)$$について

$$
C(n) = \sum_{i=0}^{n/10}B(10i)
$$

これを用いて計算していくと

$$
\begin{aligned}
D(100) &= B(100) + B(90) + C(80) + C(50) + D(0)\\
& = 3 + 2\times(B(10)+ B(20)+ B(30) + B(40) + B(50)) + B(60) + B(70) + B(80) + B(90) + B(100)\\
& = 3 + 70 + 85\\
&= 158
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

### 解答その２

$$5n$$円の５円と１円の両替は $$n+1$$通りあります。$$10n$$円の10円と５円と１円の両替を $$a_n$$通りとしたとき。

$$
a_{n} = a_{n-1} + 2n+1
$$

$$a_0 = 1$$なので、

$$
a_n = (n+1)^2
$$

$$50n$$円の50円と10円と５円と１円の両替を $$b_n$$通りとしたとき。

$$
b_n = b_{n-1} + a_{5n} = b_{n-1} + (5n+1)^2
$$

よって、

$$
b_n = \frac{1}{6}(n+1)(50n^2 + 55n + 6)
$$

<div style="text-align: right;">
■
</div>


## Problem 2: Project Euler Problem 31より

問題文は以下です：

```raw
In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation:

1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

It is possible to make £2 in the following way:

1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?
```

### 解答: Python

```python
target = 200
coin_list = [1, 2, 5, 10, 20, 50, 100, 200]
ways = [1] + [0]*target

for coin in coin_list:
    for i in range(coin, target + 1):
        ways[i] += ways[i - coin]

print(ways[target])
>>> 73682
```

<div style="text-align: right;">
■
</div>


## Problem 3: 階段の昇り方, 07京大理系

問題は以下です：     

1歩で1段または2段のいずれかで階段を昇るとき，1歩で2段昇ることは連続しないものとする．15段の階段を昇る昇り方は何通りあるか． 

### 解答

$$n$$段の階段を登る方法を$$a(n)$$と表します。このとき、$$a(1) = 1, a(2) = 2, a(3) = 3$$となります。

$$n$$段の階段を上がる場合、2回続けて二段登りができないので、1段前の方法数と2段前の方法数のうち直前が一段登りの方法数を足せば良いので、

$$
a(n) = a(n-1) + a(n-3)
$$　

```python
def find_steps(n):
    if not isinstance(n, int) or n <= 0:
        raise ValueError('the input must be a positive integer')

    if n == 1:
        return 1

    elif n == 2:
        return 2
    
    elif n == 3:
        return 3

    else:
        return find_steps(n-1) + find_steps(n-3)
```

よって、

```python
print(find_steps(15))
>>> 277
```

<div style="text-align: right;">
■
</div>

## Problem 4: コイン最小支払い枚数問題（Change-Making Problem : CMP）

額面が$$c_1, c_2, ..., c_m$$円の$$m$$種類のコインを使って、$$n$$円を支払うときのコインの最小の枚数を求めてください。各額面のコインは何度でも使用することができるとします。

入力は以下です：

```
n m
c1 c2 ... cm
```

入力例

```
15 6
1 2 7 8 12 50
```

出力例

```
2
```

### 解答方針

仮にコインの額面が1, 5, 10, 50, 100と決められていたら与えられた額$$n$$円に対して、額面の大きいものから引いていけば（貪欲法）最小の枚数を求めることができます。一方、一般的な方法では必ずしもうまくは行きません。(→[参考はこちら](https://github.com/ryonakimageserver/lecturenotes/blob/main/math/OR%20-%20Optimality%20of%20a%20Heuristic%20Solution%20for%20a%20Class%20of%20Knapsack%20Problems.pdf))

たとえば、15円を支払うにあたって、1, 2, 7, 8, 9円のコインで支払うとすると、貪欲法だと4枚選んでしまいます。

```python
def get_coin_greedy(target, coin_list):
    coin = 0
    coin_list = sorted(coin_list, reverse = True)
    for i in coin_list:
        coin_tmp, target = divmod(target, i)
        coin += coin_tmp
        if target == 0:
            break
    
    return coin

print(get_coin_greedy(15, [1, 2, 7, 8, 9]))
>>> 4
```

そこで[Find the shortest path](https://python.quantecon.org/short_path.html)のように、DPを定式化し解くことを考えます。

|変数|説明|
|---|---|
|`C`|コインの配列, 額面の大きさでsortしてあります, `C[i]`がi番目に小さいコインとなります.|
|`T`|長さ `target` の配列. `target`は支払う金額. `T[target]`は`target`を支払うにあたって最小のコインの枚数.|

このとき、j 番目の`T`は次のように書けます：

$$
T(j) = \min_{i \in C} (1 + T(j - i)) \:\text{ where } T(j-1) = \inf \text{ if } j - i < 0  
$$

これをPythonで実装すると

```python
def get_coin(target, coin_list):
    ways = [0] + [target] * target
    coin_list = sorted(coin_list)

    for i in range(target+1):
        for j in coin_list:
            tmp = i - j
            ways[i] = min(ways[tmp if tmp >= 0 else -1] + 1, ways[i])
    
    return ways[-1]

print(get_coin(15, [1,2,7,8, 9]))
>>> 2
```

この実装は二重ループを使用しています。`O(mn)`の計算量となります。

<div style="text-align: right;">
■
</div>

### 最小支払い枚数のコインの組合せを返す関数

```python
class Find_Coin_Combination():
    def __init__(self, target, coin_list):
        self.target = target
        self.coin_list = coin_list
        self.coin_path = None
        self.minimum_coin_num = None
        self.coin_combination = None
        
    def get_coin(self):
        ways = [0] + [self.target] * self.target
        self.coin_path = [0]*(self.target+1)

        for i in range(1, self.target+1):
            for j in self.coin_list:
                tmp = i - j
                if ways[tmp if tmp >= 0 else -1] + 1 <= ways[i]:
                    self.coin_path[i] = j
                    ways[i] = min(ways[tmp if tmp >= 0 else -1] + 1, ways[i])
        
        self.minimum_coin_num = ways[-1]
    
    def print_result(self):
        tmp_target = self.target
        self.coin_combination = dict(zip(self.coin_list ,[0]*len(self.coin_list)))

        while tmp_target > 0:
             tmp_coin = self.coin_path[tmp_target]
             self.coin_combination[tmp_coin] += 1
             tmp_target -= tmp_coin
        
        return self.minimum_coin_num, self.coin_combination

coin_instance = Find_Coin_Combination(2345, [1, 2, 7, 8, 12, 25, 100])
coin_instance.get_coin()
print(coin_instance.print_result())
>>> (26, {1: 0, 2: 0, 7: 0, 8: 1, 12: 1, 25: 1, 100: 23})
```

### 貪欲法で解けるための条件

CMPは整数ナップサック問題の特殊ケースです。よって、整数ナップサック問題が貪欲法で解けるための条件がそのまま適用できます。今回はCMPの文脈に沿ってそれを紹介します。

**問題設定**

以下のCMPを以下のように定式化します：

$$
\min_{(x_1, ..., x_m)} \sum_{i=1}^m x_i \: \text{ s.t. } \sum_{i=1}^m a_ix_i = b、, x_i \geq 0
$$

- $$(a_1, ..., a_m)$$はコインの種類, $$i < j \Rightarrow a_i < a_j$$のようにソートされている
- $$(x_1, ..., x_m)$$はコインの枚数
- $$b$$は支払金額
- $$a_1 = 1$$とします（解の存在条件）

このとき、

$$
F_k(y) = \min_{(x_1, ..., x_k)} \sum_{i=1}^k x_i \: \text{ s.t. } \sum_{i=1}^k a_ix_i = y、, x_i \geq 0
$$

と定義します。つまり、$$F_k(y)$$は下から$$ｋ$$種類のコインのみ使える状況で$$y$$円を支払うときの最適な支払い枚数となります。また、$$H_k(y)$$を以下のように定義します。

$$
H_k(y) \text{ : k 種類のコインのみ使える状況で y 円を支払うとき、貪欲法で導かれる支払い枚数}
$$

なお、$$a_1 = 1$$より、すべての正の整数 $$y$$ について

$$
H_1(y) = F_1(y)
$$

が成立します。$$x(k)^*_{k+1}$$を$$F_{k+1}(y)$$のときのコイン $$k$$ の最適枚数とします。

**定理**

すべての正の整数$$y$$ととある$$k$$について、$$H_k(y) = F_k(y)$$が成立するとする。このとき、$$(j, j+1)$$ where $$j \in [1, m-1]$$について

$$
a_{j+1}=p_ja_j-\delta_j \: \text{ s.t. } 0 \leq \delta_j < a_j
$$

と$$(p_j, \delta_j)$$がそれぞれの $$j$$ につきユニークに定まるならば、以下は同値である。

$$
\begin{aligned}
\text{(a')} \: & H_{k+1}(y) \leq H_k(y) \text{ for all positive integers } y \\
\text{(a) } \: & H_{k+1}(y) = F_{k+1}(y) \text{ for all positive integers } y \\
\text{(b) } \: & H_{k+1}(p_ka_k) = F_{k+1}(p_ka_k) \\
\text{(c) } \: & 1 + H_{k}(\delta_k) \leq p_k
\end{aligned}
$$


**証明**

(a') $$\Rightarrow$$ (a) $$\Rightarrow$$ (b) $$\Rightarrow$$ (c) $$\Rightarrow$$ (a')を示します。


>(a') $$\Rightarrow$$ (a)を示す

(a')より

$$
H_k(y) \leq H_{k+1}(y) \leq F_{k+1}(y)\text{ for all positive integers } y \tag{1}
$$

関数の性質より、$$H_{k+1}(y)$$における(k+1)コインの使用枚数を$$x(k+1)^H_{k+1}$$とすると、

$$
x(k+1)^H_{k+1} \geq x(k+1)^*_{k+1}
$$

次に以下のように変数を定義します：

$$
y' = y -  x(k+1)^*_{k+1}\cdot a_{k+1} 
$$

このとき、すべての正の整数$$y$$ととある$$k$$について、$$H_k(y) = F_k(y)$$が成立するので

$$
F_{k+1}(y') = F_{k}(y') = H_k(y') = H_{k+1}(y')\tag{2}
$$

(1) より

$$
H_k(y') \leq H_{k+1}(y')
$$

なので、

$$
H_{k+1}(y')=F_{k+1}(y') \tag{3}
$$

(3) に $$a_{k+1}x(k+1)^*_{k+1}$$ を足すと

$$
\begin{aligned}
H_{k+1}(y') + a_{k+1}x(k+1)^*_{k+1} &= H_{k+1}(y) \:\because H_{k+1}(y') = H_{k}(y')\\ 
F_{k+1}(y') + a_{k+1}x(k+1)^*_{k+1} &= F_{k+1}(y)
\end{aligned}
$$

よって

$$
H_{k+1}(y) = F_{k+1}(y) \text{ for all positive integers } y
$$

>(a) $$\Rightarrow$$ (b)を示す

$$y=p_ka_k$$とすれば自明。

>(b) $$\Rightarrow$$ (c)を示す

$$F(\cdot)$$の定義より

$$
F_{k+1}(y)\leq F_{k}(y) = H_{k}(y) \text{ for all positive integers } y
$$

(b)より

$$
H_{k+1}(p_ka_k) \leq H_{k}(p_ka_k)\tag{4}
$$

(4)を変形すると

$$
\begin{aligned}
H_{k+1}(p_ka_k) &= H_{k+1}(a_{k+1}+\delta) = 1 + H_{k+1}(\delta)\\
H_{k}(p_ka_k) &= p_k
\end{aligned}
$$

よって

$$
1 + H_{k+1}(\delta) \leq p_k
$$

>(c) $$\Rightarrow$$ (a')を示す

not (a') $$\Rightarrow$$ not (c) を示します。

$$\bar y$$ を(a')が成立しない最も小さい positive integerとします。$$\bar y$$は明らかに$$\bar y > a_{k+1}$$。よって、

$$
H_k(\bar y) < H_{k+1}(\bar y) = 1 + H_{k+1}(\bar y - a_{k+1}) \tag{5}
$$

(5)の両式に $$H_{k}(\delta)$$を加えると、

$$
1 + H_{k+1}(\bar y - a_{k+1}) + H_{k}(\delta) > H_{k}(\delta) + H_k(\bar y) \geq H_k(\bar y + \delta)　\tag{6}
$$

$$\bar y + \delta$$を変形すると、

$$
\bar y + \delta = a_{k+1} + \delta + (\bar y - a_{k+1}) = p_ka_k + (\bar y - a_{k+1}) \tag{7}
$$

よって

$$
H_k(\bar y + \delta) = H_k(p_ka_k + (\bar y - a_{k+1})) = p_k + H_k(\bar y - a_{k+1})\tag{8}
$$

(6)~(8)によって、

$$
\begin{aligned}
&1 + H_{k+1}(\bar y - a_{k+1}) + H_{k}(\delta) > p_k + H_k(\bar y - a_{k+1})\\
&\Rightarrow 1 + H_{k}(\delta) > p_k + H_k(\bar y - a_{k+1} - H_{k+1}(\bar y - a_{k+1}) + H_{k}(\delta)
\end{aligned}
$$

$$\bar y$$の定義より、

$$
1 + H_{k}(\delta) > p_k
$$

よって、not (a') $$\Rightarrow$$ not (c)が成立。

<div style="text-align: right;">
■
</div>

これは１円コインが存在する問題では、すべての正の整数$$y$$ととある$$k$$について、$$H_k(y) = F_k(y)$$が成立することは簡単に確認できます。また整数ナップサックやCMPにおいて、sortされたコインのうち隣り合うモノ同士が割り切れる関係なら貪欲法で解くことができると覚えとくといいことがあると思います。
