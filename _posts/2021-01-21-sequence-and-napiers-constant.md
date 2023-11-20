---
layout: post
title: "自然対数の底ネイピア数とバウンド"
subtitle: "統計のための数学 1/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-21
header-mask: 0.0
header-style: text
tags:

- math
- 統計

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [ネイピア数のバウンド](#%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0%E3%81%AE%E3%83%90%E3%82%A6%E3%83%B3%E3%83%89)
  - [解答](#%E8%A7%A3%E7%AD%94)
- [ネイピア数数列の収束について](#%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0%E6%95%B0%E5%88%97%E3%81%AE%E5%8F%8E%E6%9D%9F%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [単調性の証明](#%E5%8D%98%E8%AA%BF%E6%80%A7%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [上に有界の証明](#%E4%B8%8A%E3%81%AB%E6%9C%89%E7%95%8C%E3%81%AE%E8%A8%BC%E6%98%8E)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## ネイピア数のバウンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 平成28年東大前期理数学第１問 </ins></p>

$$
e = \lim_{t\to\infty}\bigg(1 + \frac{1}{t}\bigg)^t
$$

としたとき, すべての正の実数$x$に対して, 次の不等式が次の不等式が成り立つことを示せ

$$
\bigg(1 + \frac{1}{x}\bigg)^x < e < \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}
$$

</div>

### 解答

$$
\bigg(1 + \frac{1}{x}\bigg)^x < e < \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}
$$

について, すべての正の実数$x$について0より厳密に大きい値をとることは自明なので自然対数をとり以下のように変形します

$$
x\ln\bigg(1 + \frac{1}{x}\bigg) < 1 < \bigg(x+\frac{1}{2}\bigg)\ln\bigg(1 + \frac{1}{x}\bigg)
$$

これを示せば, 題意が示せます. 次に, 


$$
f(x) = (x+a)\ln\bigg(1 + \frac{1}{x}\bigg)
$$

これを微分すると, 

$$
\begin{align*}
f'(x) &= \ln\bigg(1 + \frac{1}{x}\bigg) - (x+a)\frac{1}{x(x+1)}\\
f''(x) &= \frac{(2a-1)x + a}{x^2(x+1)^2}
\end{align*}
$$

$f^{\prime\prime}(x)$に着目すると, 

$$
f''(x) \begin{cases}
< 0 & \forall x \in \mathbb R_{+} \text{ when } a < \frac{1}{2} \\[8pt]
> 0 & \forall x \in \mathbb R_{+} \text{ when } a \geq \frac{1}{2}
\end{cases}
$$

とわかるので, 

$$
f'(x) \text{ is }\begin{cases}
\text{単調減少} & \text{ when } a < \frac{1}{2} \\[8pt]
\text{単調増加} & \forall x \in \mathbb R_{+} \text{ when } a \geq \frac{1}{2}
\end{cases}
$$

であることがわかります. また, 

$$
\lim_{x\to\infty}\ln\bigg(1 + \frac{1}{x}\bigg) - (x+a)\frac{1}{x(x+1)} = 0
$$

なので, 

$$
f'(x)\begin{cases}
> 0 \text{ and } \text{単調減少} & \text{ when } a < \frac{1}{2} \\[8pt]
< 0 \text{ and }\text{単調増加} & \forall x \in \mathbb R_{+} \text{ when } a \geq \frac{1}{2}
\end{cases}
$$

であることわかり, 対数変換は単調変換であることに留意すると

$$
\begin{align*}
& \bigg(1 + \frac{1}{x}\bigg)^x \text{is 単調増加関数} \\
& \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}  \text{is 単調減少関数}
\end{align*}
$$


したがって, 

- $\bigg(1 + \frac{1}{x}\bigg)^x$は$x\to\infty$に近づくにあたって, $e$を超えることなく近づいていく 
- $\bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}$は$x\to\infty$に近づくにあたって, $e$を下回ることなく近づいていく 

ので

$$
\bigg(1 + \frac{1}{x}\bigg)^x < e < \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}
$$

と言える.

> Plotlyで実際にそれぞれの単調性を確認してみる

{% include plotly/20210121_napier_plot.html %}


## ネイピア数数列の収束について
### 単調性の証明

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
a_n = \bigg(1 + \frac{1}{n}\bigg)^n
$$

と数列を定義すると, $a_n$は単調増加であることをしめせ.

</div>

相加相乗平均の不等式を用いることで示すことができます.

$n$個の$\frac{n+1}{n}$と1個の1について相加相乗平均の不等式を表すと

$$
\begin{align*}
&\frac{\frac{n+1}{n}n + 1}{n+1} > \bigg(\frac{n+1}{n}\bigg)^{\frac{n}{n+1}} \\[3pt]
& \Rightarrow \bigg(1+\frac{1}{n+1}\bigg)^{n+1} >\bigg(1+\frac{1}{n}\bigg)^{n}
\end{align*}
$$

したがって, $a_{n+1}> a_n$となり単調性が示せた.

### 上に有界の証明

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
a_n = \bigg(1 + \frac{1}{n}\bigg)^n
$$

と数列を定義すると, $a_n$は上に有界である

</div>

二項定理より簡単に証明できます.

$$
\begin{align*}
a_n &= \bigg(1 + \frac{1}{n}\bigg)^n\\[3pt]
&= \sum_{k=0}^n \frac{n!}{k!(n-k)!n^k}\\[3pt]
&= \sum_{k=0}^n \frac{1}{k!}\bigg(1 - \frac{1}{n}\bigg)\bigg(1 - \frac{2}{n}\bigg)\cdots\bigg(1 - \frac{k-1}{n}\bigg)\\[3pt]
& < \sum_{k=0}^n \frac{1}{k!}\\
& < 1 + \sum_{k=0}^n \frac{1}{2^k}\\
& \leq 3
\end{align*}
$$

したがって, $a_n < 3$となるので上に有界であることが示せた.


## 級数によるネイピア数の表現

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>級数によるネイピア数の表現</ins></p>

ネイピア数は

$$
\exp(x) = \sum^{\infty}_{n=0}\frac{x}{n!} 
$$

という級数によって表すことができる.

</div>

この性質はテイラー展開によっても確認できますが, ここでは二項定理を用いて証明します.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\bigg(1 + \frac{x}{n}\bigg)^n &= \sum_{k=0}^n\bigg(\begin{array}{c}n\\k\end{array}\bigg)\bigg(\frac{x}{n}\bigg)^{k}\\[3pt]
                              &= 1 + \frac{n}{1!}\bigg(\frac{x}{n}\bigg) + \frac{n(n-1)}{2!}\bigg(\frac{x}{n}\bigg)^{2} + \cdots + \frac{n(n-1)\cdots(n-k+1)}{k!}\bigg(\frac{x}{n}\bigg)^{k}+\cdots
\end{align*}
$$
</div>

したがって, 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\lim_{n\to\infty}\bigg(1 + \frac{x}{n}\bigg)^n &= 1 + \frac{n}{1!}\bigg(\frac{x}{n}\bigg) + \frac{n(n-1)}{2!}\bigg(\frac{x}{n}\bigg)^{2} + \cdots + \frac{n(n-1)\cdots(n-k+1)}{k!}\bigg(\frac{x}{n}\bigg)^{k}+\cdots\\[3pt]
                                               &= 1 + \frac{x}{1!} + \frac{x^2}{2!} + \cdots + \frac{x^k}{k!} + \cdots\\[3pt]
                                               &= \frac{x^0}{0!} + \frac{x}{1!} + \frac{x^2}{2!} + \cdots + \frac{x^k}{k!} + \cdots\\[3pt]
                                               &= \sum_{k=0}\frac{x^k}{k!}
\end{align*}
$$
</div>

### 例：ポワソン分布の期待値と分散

パラメーター$\lmabda$のポワソン分布に従う確率変数 $X$ の期待値と分散を求めるときに「級数表現されたネイピア数」を用います.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X] &= \sum_{x=0}x\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
             &= \exp(-\lambda)\sum_{x=1}\frac{\lambda^x}{(x-1)!}\\[3pt]
             &= \exp(-\lambda)\lambda\sum_{x=1}\frac{\lambda^{x-1}}{(x-1)!}\\[3pt]
             &= \exp(-\lambda)\lambda\sum_{k=0}\frac{\lambda^k}{k!}\\[3pt]
             &= \exp(-\lambda)\lambda\exp(\lambda) \  \ \because \text{ 級数表現されたネイピア数より}\\[3pt]
             &= \lambda
\end{align*}
$$
</div>

分散は$\mathbb E[X^2] - \mathbb E[X]^2$なので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \sum_{x=0}x^2\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
               &= \sum_{x=0}(x(x-1) +x)\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
               &= \sum_{x=0}(x(x-1))\exp(-\lambda)\frac{\lambda^x}{x!} + \sum_{x=0}x\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
               &= \lambda^2\sum_{x=2}\exp(-\lambda)\frac{\lambda^{x-2}}{(x-2)!} + \lambda\\[3pt]
               &= \lambda^2\exp(-\lambda)\sum_{x=2}\frac{\lambda^{x-2}}{(x-2)!} + \lambda\\[3pt]
               &= \lambda^2\exp(-\lambda)\sum_{k=0}\frac{\lambda^{k}}{(k)!} + \lambda\\[3pt]
               &= \lambda^2\exp(-\lambda)\exp(\lmambda) + \lambda\\[3pt]
               &= \lambda^2 + \lmambda
\end{align*}
$$
</div>

したがって, $V(X) = \lambda^2 + \lmambda - \lmabda^2 = \lmabda$.





References
-----

- [高校数学の美しい物語 > 自然対数の底（ネイピア数）の定義：収束することの証明 ](https://manabitimes.jp/math/714)
- [理数アラカルト > ネイピア数とは？](https://risalc.info/src/Napiers-constant.html)
