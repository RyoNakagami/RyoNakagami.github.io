---
layout: post
title: "ベルヌーイ試行と漸化式"
subtitle: "練習問題編"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
uu_cnt: 100
session_cnt: 100 
tags:

- 統計
- 統計検定
- ベルヌーイ試行
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題: 2回連続で表が出る確率](#%E5%95%8F%E9%A1%8C-2%E5%9B%9E%E9%80%A3%E7%B6%9A%E3%81%A7%E8%A1%A8%E3%81%8C%E5%87%BA%E3%82%8B%E7%A2%BA%E7%8E%87)
  - [(1) $q_n$に関する漸化式を求めよ](#1-q_n%E3%81%AB%E9%96%A2%E3%81%99%E3%82%8B%E6%BC%B8%E5%8C%96%E5%BC%8F%E3%82%92%E6%B1%82%E3%82%81%E3%82%88)
  - [(2) pが$2/3$のとき、$q_n$をnの関数として求めよ](#2-p%E3%81%8C23%E3%81%AE%E3%81%A8%E3%81%8Dq_n%E3%82%92n%E3%81%AE%E9%96%A2%E6%95%B0%E3%81%A8%E3%81%97%E3%81%A6%E6%B1%82%E3%82%81%E3%82%88)
  - [$p$についての一般解について](#p%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6%E3%81%AE%E4%B8%80%E8%88%AC%E8%A7%A3%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [問題：$k$回連続で表が出るまでのコイン投げ回数の期待値](#%E5%95%8F%E9%A1%8Ck%E5%9B%9E%E9%80%A3%E7%B6%9A%E3%81%A7%E8%A1%A8%E3%81%8C%E5%87%BA%E3%82%8B%E3%81%BE%E3%81%A7%E3%81%AE%E3%82%B3%E3%82%A4%E3%83%B3%E6%8A%95%E3%81%92%E5%9B%9E%E6%95%B0%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4)
  - [MGFを用いてコイン投げ回数の分散を求める](#mgf%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6%E3%82%B3%E3%82%A4%E3%83%B3%E6%8A%95%E3%81%92%E5%9B%9E%E6%95%B0%E3%81%AE%E5%88%86%E6%95%A3%E3%82%92%E6%B1%82%E3%82%81%E3%82%8B)
- [問題: 交互にサーブを行う時に、2点差つけることができる確率](#%E5%95%8F%E9%A1%8C-%E4%BA%A4%E4%BA%92%E3%81%AB%E3%82%B5%E3%83%BC%E3%83%96%E3%82%92%E8%A1%8C%E3%81%86%E6%99%82%E3%81%AB2%E7%82%B9%E5%B7%AE%E3%81%A4%E3%81%91%E3%82%8B%E3%81%93%E3%81%A8%E3%81%8C%E3%81%A7%E3%81%8D%E3%82%8B%E7%A2%BA%E7%8E%87)
- [問題: 交互に2回ずつサーブを行う時に、2点差つけることができる確率](#%E5%95%8F%E9%A1%8C-%E4%BA%A4%E4%BA%92%E3%81%AB2%E5%9B%9E%E3%81%9A%E3%81%A4%E3%82%B5%E3%83%BC%E3%83%96%E3%82%92%E8%A1%8C%E3%81%86%E6%99%82%E3%81%AB2%E7%82%B9%E5%B7%AE%E3%81%A4%E3%81%91%E3%82%8B%E3%81%93%E3%81%A8%E3%81%8C%E3%81%A7%E3%81%8D%E3%82%8B%E7%A2%BA%E7%8E%87)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題: 2回連続で表が出る確率

表の出る確率が$p$のコインを$n$回続けて投げる時、表が続けては現れない確率を$q_n$とする.

1. $q_n$に関する漸化式を求めよ
2. pが$2/3$のとき、$q_n$をnの関数として求めよ

### (1) $q_n$に関する漸化式を求めよ

$q_n$に該当する事象は「$n$回目に表が出るが表は２回連続で表れることはない」事象と「$n$回目に裏が出るが表は２回連続で表れることはない」事象に分けて考えることができます. 従って、


<div class="math display" style="overflow: auto">
$$
\begin{align*}
q_n = (1 - p)q_{n-1} + p(1-p)q_{n-2} \quad\quad\tag{1.1}
\end{align*}
$$
</div>

また、$q_0 = q_1 = 1$となります.

### (2) pが$2/3$のとき、$q_n$をnの関数として求めよ

pが$2/3$のとき, (1.1)は以下のようになる：


$$
q_n = \frac{1}{3}q_{n-1} + \frac{1}{3}\frac{2}{3}q_{n-1}
$$

従って、

$$
\begin{align*}
q_n - \frac{2}{3} &= -\frac{1}{3}\left(q_{n-1} - \frac{2}{3}q_{n-2}\right)\\
q_n + \frac{1}{3} &= \frac{2}{3}\left(q_{n-1} + \frac{1}{3}q_{n-2}\right)
\end{align*}
$$

更に整理すると

$$
\begin{align*}
q_n - \frac{2}{3} &= \left(-\frac{1}{3}\right)^{n-1}\frac{1}{3}\\
q_n + \frac{1}{3} &= \left(\frac{2}{3}\right)^{n-1}\frac{4}{3}
\end{align*}
$$

以上より、

$$
q_n = (-1)^{n-1}\left(\frac{1}{3}\right)^{n+1} + 2 \left(\frac{2}{3}\right)^{n+1}
$$

### $p$についての一般解について

ここは[Wolfram alpha](https://ja.wolframalpha.com/input?i=RSolve%5B%7Bg%5B0%5D+%3D%3D+1%2C+g%5B1%5D+%3D%3D+1%2C+g%5Bn%5D+%3D%3D+%281+-+p%29+p+g%5B-2+%2B+n%5D+%2B+%281+-+p%29+g%5B-1+%2B+n%5D%7D%2C+%7Bg%5Bn%5D%7D%2C+n%5D)さんのお力をお借りしました...

$$
A \equiv \sqrt{-3p^2 + 2p + 1}
$$

とすると

$$
\begin{align*}
q_n =& \frac{1}{A}2^{-n-1}\\[8pt]
& \left[-p(-A - p + 1)^n + (A - 1)(-A - p + 1)^n + (p + A + 1)(A - p + 1)^n\right]
\end{align*}
$$

これに対して、$p=2/3$を代入すると$A = 1$となり計算しやすくなり

$$
q_n\left(\frac{2}{3}\right) = (-1)^{n+1}\left(\frac{1}{3}\right)^{n+1} + 2 \left(\frac{2}{3}\right)^{n+1}
$$

## 問題：$k$回連続で表が出るまでのコイン投げ回数の期待値

表の出る確率が$p$のコインを投げ続け、$k$回連続で表がでるまでの回数を$n$としたとき、この$N$の期待値を求めよ.

> 解答

まず、$k=4$で探索的に調べてみます. 表が$z$回連続で出たとし，連続4回になるまでにあと何回くらいコインを投げるかという期待値を$x_z$で表すとします.

状態$Z=z$のとき、追加でコインを一回投げると確率$p$で$z+1$の状態へ遷移、$1-p$で$Z=0$へ遷移することに着目すると期待値は以下のように表せます.

$$
\begin{align*}
x_0 &= 1 + p x_1 + (1-p)x_0\\[8pt]
x_1 &= 1 + p x_2 + (1-p)x_0\\[8pt]
x_2 &= 1 + p x_3 + (1-p)x_0\\[8pt]
x_3 &= 1 + (1-p)x_0
\end{align*}
$$

従って、これを連立させて解くと

$$
x_0 = \left(\frac{1}{1-p}\right)\left(\frac{1}{p^4}-1\right)
$$

次に、一般化して$k$回連続して表が得られたら終了とする場合、期待値の連立方程式は

$$
\begin{align*}
x_0 &= 1 + p x_1 + (1-p)x_0\\[8pt]
x_1 &= 1 + p x_2 + (1-p)x_0\\[8pt]
\vdots&\\
x_{k-2} &= 1 + p x_{k+1} + (1-p)x_0\\[8pt]
x_{k-1} &= 1 + (1-p)x_0
\end{align*}
$$

なので

$$
\begin{align*}
x_0 &= \left(\frac{1}{1-p}\right)\left(\frac{1}{p^k}-1\right)\\[8pt]
x_{k-1} &= \frac{1}{p^k}\\
x_{z} &= 1 + \sum_{i=z}^{k-1}\frac{1}{p^{i+1}}
\end{align*}
$$

と表現できます. なお、$p=1/2$のときは

$$
x_0 = 2(2^k - 1)
$$

と覚えやすく求めることができます.

### MGFを用いてコイン投げ回数の分散を求める

次にコイン投げ回数$N$の分散を求めたいとします. まず $N\<k$ の範囲では$P(N < k) = 0$となります.
また、$P(N = k) = p^k$も自明です.

次に、$N > k$の場合を考えます. この場合、最後の$k+1$回の試行は裏１回表$k$回なので, $n>k$としたとき

$$
P(N = n) = (1 - P(N < N-k-1))(1-p)p^k
$$

次に、MGFを定義します

$$
\begin{align*}
E[\exp(tN)] &= \sum_{n=0}^\infty\exp(tn)P(N=n)\\[8pt]
&= \exp(tk)p^k + (1 - p)p^k\sum_{n=k+1}^\infty \exp(tn)P(N > n - k - 1)\\[8pt]
&= \exp(tk)p^k + (1 - p)p^k\sum_{n=k+1}^\infty \exp(tn)\sum_{z=n-k}^\infty P(N=z)\\[8pt]
&= \exp(tk)p^k + (1 - p)p^k\sum_{n=k+1}^\infty\sum_{z=n-k}^\infty  \exp(tn)P(N=z)\\[8pt]
&= \exp(tk)p^k + (1 - p)p^k\sum_{z=1}^\infty\sum_{n=k+1}^{k+z} \exp(tn)P(N=z)\\[8pt]
&= \exp(tk)p^k + (1 - p)p^k\sum_{z=1}^\infty P(N=z) \frac{\exp(t(k+1)) - \exp(t(k+z+1)}{1 - \exp(t)}\\[8pt]
&= \exp(tk)p^k + (1 - p)p^k\frac{\exp(t(k+1))}{1 - \exp(t)}(1 - E[\exp(tN)])
\end{align*}
$$

あとはこれを整理し、$E[N^2]$ を計算すれば良いだけになります. なおこれの計算は手間がかかるので$p=1/2$のケースを考えてみたいと思います.

$$
E[\exp(tN)|p=1/2] = \frac{\exp((k+1)t) - 2\exp(tk)}{2^{k+1}(\exp(t)-1) - \exp((k+1)t)}
$$

従って、分散は

$$
\begin{align*}
V(N) &= E[N^2] - E[N]^2\\[8pt]
&= 2 (-2^{k + 1} k - 2^k + 2^{2 k + 1} - 1)
\end{align*}
$$

## 問題: 交互にサーブを行う時に、2点差つけることができる確率

実力が拮抗しているA, Bの二人が、卓球をすることにした. ルールは交互にサーブをし、先に相手よりも2点差つけたプレイヤーが勝ちとします.
２人は実力が拮抗しているため、どちらもサーブをした時の勝率は等しく $p$ だとします. このとき、先にサーブをした人が有利なのかどうか確認せよ

> 解答

先にサーブする人の勝率を$P_1$とします. 先手の勝利パターンを分類すると

- 初回サーブに勝利 & 次の後手のサーブもブレイク
- 初回サーブは勝利 & 次の後手のサーブはブレイク失敗 & 初期状態に戻る
- 初回サーブはブレイクされる & 次の後手のサーブはブレイク成功 & 初期状態に戻る

の３つに分けることができます. 従って、

$$
\begin{align*}
P_1 &= p(1-p) + ppP_1 + (1-p)(1-p)P_1\\[8pt]
&\Rightarrow P_1 = \frac{1}{2}
\end{align*}
$$

従って、先行有利はこの問題設定上は存在しない.

## 問題: 交互に2回ずつサーブを行う時に、2点差つけることができる確率

実力が拮抗しているA, Bの二人が、今度はテニスのデュースで勝負するにした. ルールは交互に２回ずつサーブをし、先に相手よりも2点差つけたプレイヤーが勝ちとします.
２人は実力が拮抗しているため、どちらもサーブをした時の勝率は等しく $p$ だとします. このとき、先にサーブをした人が有利なのかどうか確認せよ.

> 解答

今回どのような状態があり得るか整理します.

- 自分がサーブで、アドバンテージなしの状態 
- 自分がサーブで、アドバンテージありの状態
- 自分がサーブで、相手にアドバンテージありの状態
- 相手がサーブで、アドバンテージなしの状態 
- 相手がサーブで、自分にアドバンテージありの状態
- 相手がサーブで、相手にアドバンテージありの状態

ここで、確率変数$S$を自分がサーブの時1, 相手がサーブの時0と定義します. また確率変数$X$を自分のアドバンテージのポイントを示す変数とします（相手にアドバンテージがある場合は$X = -1$）.

このとき状態$(s, x)$ごとに今回のゲームに勝利する確率を$P(s, x)$とすると、

$$
\begin{align*}
P(1, 0) &= p\times P(1,1) + (1-p)\times P(1,1)\\[8pt]
P(1, 1) &= p + (1-p)\times P(0,0)= p + (1-p)\times (1- P(1,0))\\[8pt] 
P(1, -1) &= p\times P(0,0) = p\times (1 - P(1,0)) 
\end{align*}
$$

なお途中の式展開は今回は２人の実力が拮抗しているので以下の等式が成り立つことを利用しています

$$
\begin{align*}
P(0,0) &= 1 - P(1, 0)
\end{align*}
$$

従って、上述の連立方程式を解くと

$$
P(1, 0) = \frac{2p(1-p) + p^2}{2p(1-p) + 1}
$$

$p=1/2$のときは先手後手の有利はないが

$$
\begin{cases}
\text{先手有利} & \ \ \text{ if }\ \ p> \frac{1}{2}\\[8pt]
\text{後手有利} & \ \ \text{ if }\ \ p< \frac{1}{2}
\end{cases}
$$

> 優勝決定までゲーム数の期待値

優勝決定のゲーム数は偶数しかありえないことに留意して書き出してみると

|ゲーム数|確率|
|---|---|
|2|$p^2 + (1-p)^2$|
|4|$(p^2 + (1-p)^2)(2p(1-p))$|
|6|$(p^2 + (1-p)^2)(2p(1-p))^2$|
|8|$(p^2 + (1-p)^2)(2p(1-p))^3$|

従って、優勝決定までゲーム数を表す確率変数を$X$とすると, $2p(1-p) < 1$であることに留意すると

$$
\begin{align*}
E[X] &= \sum_{k=1}^\infty 2k(p^2 + (1-p)^2)(2p(1-p))^{k-1}\\
&= \frac{2(p^2 + (1-p)^2)}{[1 - 2p(1-p)]^2}
\end{align*}
$$

$p = 1/2$のとき最大値を取り、$E[X\|p = 1/2] = 4$ということがわかる. また、これをplotすると

```python
import numpy as np
import matplotlib.pyplot as plt

p = np.linspace(0, 1, 100)
result = 2* (p**2 + (1-p)**2)/(1 - 2 * p * (1 - p))**2

plt.figure(figsize= (18, 11))
plt.plot(p, result)
plt.xlabel('serve winning probability')
plt.ylabel('the expected number of games')
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220126-fig1.png?raw=true">

## References

- [Ryo's Tech Blog > 死神とのコイントスゲーム](https://ryonakagami.github.io/2020/10/22/CoinFlip-Programming/)
- [Ryo's Tech Blog > 巴戦の確率](https://ryonakagami.github.io/2021/04/14/tomoesen-problem/)
- [Ryo's Tech Blog > ベルヌーイ試行と二進数](https://ryonakagami.github.io/2021/04/15/binomial-distribution/#2-%E3%83%99%E3%83%AB%E3%83%8C%E3%83%BC%E3%82%A4%E8%A9%A6%E8%A1%8C%E3%81%A8%E4%BA%8C%E9%80%B2%E6%95%B0-h31%E6%9D%B1%E4%BA%AC%E5%A4%A7%E5%AD%A6%E5%A4%A7%E5%AD%A6%E9%99%A2%E5%B7%A5%E5%AD%A6%E7%B3%BB%E7%A0%94%E7%A9%B6%E7%A7%91%E5%85%A5%E5%AD%A6%E8%A9%A6%E9%A8%93)
- [Ryo's Tech Blog > マルコフ過程 一橋1992年](https://ryonakagami.github.io/2021/04/15/binomial-distribution/#3-%E3%83%9E%E3%83%AB%E3%82%B3%E3%83%95%E9%81%8E%E7%A8%8B-%E4%B8%80%E6%A9%8B1992%E5%B9%B4)
- [Wolframalpha > 漸化式](https://ja.wolframalpha.com/input?i=RSolve%5B%7Bg%5B0%5D+%3D%3D+1%2C+g%5B1%5D+%3D%3D+1%2C+g%5Bn%5D+%3D%3D+%281+-+p%29+p+g%5B-2+%2B+n%5D+%2B+%281+-+p%29+g%5B-1+%2B+n%5D%7D%2C+%7Bg%5Bn%5D%7D%2C+n%5D)
