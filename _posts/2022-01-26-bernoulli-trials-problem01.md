---
layout: post
title: "ベルヌーイ試行と漸化式"
subtitle: "練習問題編"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
uu_cnt: 100
session_cnt: 100 
tags:

- 統計
- 統計検定
- ベルヌーイ試行
---
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題: 2回連続で表が出る確率](#%E5%95%8F%E9%A1%8C-2%E5%9B%9E%E9%80%A3%E7%B6%9A%E3%81%A7%E8%A1%A8%E3%81%8C%E5%87%BA%E3%82%8B%E7%A2%BA%E7%8E%87)
  - [(1) $q_n$に関する漸化式を求めよ](#1-q_n%E3%81%AB%E9%96%A2%E3%81%99%E3%82%8B%E6%BC%B8%E5%8C%96%E5%BC%8F%E3%82%92%E6%B1%82%E3%82%81%E3%82%88)
  - [(2) pが$2/3$のとき、$q_n$をnの関数として求めよ](#2-p%E3%81%8C23%E3%81%AE%E3%81%A8%E3%81%8Dq_n%E3%82%92n%E3%81%AE%E9%96%A2%E6%95%B0%E3%81%A8%E3%81%97%E3%81%A6%E6%B1%82%E3%82%81%E3%82%88)
  - [$p$についての一般解について](#p%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6%E3%81%AE%E4%B8%80%E8%88%AC%E8%A7%A3%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [問題：$k$回連続で表が出るまでのコイン投げ回数の期待値](#%E5%95%8F%E9%A1%8Ck%E5%9B%9E%E9%80%A3%E7%B6%9A%E3%81%A7%E8%A1%A8%E3%81%8C%E5%87%BA%E3%82%8B%E3%81%BE%E3%81%A7%E3%81%AE%E3%82%B3%E3%82%A4%E3%83%B3%E6%8A%95%E3%81%92%E5%9B%9E%E6%95%B0%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4)
  - [MGFを用いてコイン投げ回数の分散を求める](#mgf%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6%E3%82%B3%E3%82%A4%E3%83%B3%E6%8A%95%E3%81%92%E5%9B%9E%E6%95%B0%E3%81%AE%E5%88%86%E6%95%A3%E3%82%92%E6%B1%82%E3%82%81%E3%82%8B)
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



## References

- [Ryo's Tech Blog > 死神とのコイントスゲーム](https://ryonakagami.github.io/2020/10/22/CoinFlip-Programming/)
- [Wolframalpha > 漸化式](https://ja.wolframalpha.com/input?i=RSolve%5B%7Bg%5B0%5D+%3D%3D+1%2C+g%5B1%5D+%3D%3D+1%2C+g%5Bn%5D+%3D%3D+%281+-+p%29+p+g%5B-2+%2B+n%5D+%2B+%281+-+p%29+g%5B-1+%2B+n%5D%7D%2C+%7Bg%5Bn%5D%7D%2C+n%5D)