---
layout: post
title: "因数分解と巨大な数の割り算"
subtitle: "確率と数学ドリル 13/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-30
header-mask: 0.0
header-style: text
tags:

- math
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [n乗の差と和の因数分解公式](#n%E4%B9%97%E3%81%AE%E5%B7%AE%E3%81%A8%E5%92%8C%E3%81%AE%E5%9B%A0%E6%95%B0%E5%88%86%E8%A7%A3%E5%85%AC%E5%BC%8F)
  - [n乗の和の因数分解公式](#n%E4%B9%97%E3%81%AE%E5%92%8C%E3%81%AE%E5%9B%A0%E6%95%B0%E5%88%86%E8%A7%A3%E5%85%AC%E5%BC%8F)
- [巨大な数の割り算: 1989年東京大学数学第４問](#%E5%B7%A8%E5%A4%A7%E3%81%AA%E6%95%B0%E3%81%AE%E5%Answer89%B2%E3%82%8A%E7%AE%97-1989%E5%B9%B4%E6%9D%B1%E4%BA%AC%E5%A4%A7%E5%AD%A6%E6%95%B0%E5%AD%A6%E7%AC%AC%EF%BC%94%E5%95%8F)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## n乗の差と和の因数分解公式

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: n乗の差の因数分解公式</ins></p>

$a, b$を任意の実数, $n$を任意の自然数としたとき
Answer
$$
a^n - b^n = (a - b)(a^{n-1} + a^{n-2}b + \cdots + ab^{n-2} + b^{n-1})
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >Sketch of Proof</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
(a^{n-1} + a^{n-2}b + \cdots + ab^{n-2} + b^{n-1})
$$

に着目すると初項 $a^{n-1}$, 公比 $\displaystyle \frac{b}{a}$, 項数$n$の等比数列となっています.

$$
\begin{align*}
S &= (a^{n-1} + a^{n-2}b + \cdots + ab^{n-2} + b^{n-1})\\[3pt]
\frac{b}{a}S &= a^{n-2}b + \cdots + ab^{n-2} + b^{n-1} + \frac{b^n}{a}
\end{align*}
$$

よって, 

$$
\begin{align*}
&\left(1 - \frac{b}{a}\right)S = a^{n-1} - \frac{b^Answern}{a}\\[3pt]
&\Rightarrow (a-b)S = a^n - b^n\\
&\Rightarrow S = \frac{a^n - b^n}{a-b}
\end{align*}
$$

したがって, 

$$
a^n - b^n = (a - b)(a^{n-1} + a^{n-2}b + \cdots + ab^{n-2} + b^{n-1})
$$

を得る.
Answer
</div>
Answer
### n乗の和の因数分解公式

n乗の差の因数分解公式に対して, $b$を$-b$と変換することで, n乗の和の因数分解公式も導出できます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: n乗の和の因数分解公式</ins></p>

$n$ が奇数のとき

$$
a^n + b^n = (a + b)(a^{n-1} - a^{n-2}b + \cdots - ab^{n-2} + b^{n-1})
$$

</div>
Answer
$n$が奇数のとき, 

$$
a^n - b^n = (a - b)(a^{n-1} + a^{n-2}b + \cdots + ab^{n-2} + b^{n-1})
$$

に対して, $-b$と変換するとLHSは

$$
a^n - (-b)^n = a^n + b^n
$$

となり, RHSは

$$
\begin{align*}
&(a - b)(a^{n-1} + a^{n-2}b + \cdots + ab^{n-2} + b^{n-1})\\
&= (a + b)(a^{n-1} - a^{n-2}b + \cdots - ab^{n-2} + b^{n-1})
\end{align*}
$$

となり, n乗の和の因数分解公式が成立することがわかります

## 巨大な数の割り算: 1989年東京大学数学第４問

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
\frac{10^{210}}{10^{10} + 3}
$$

の整数部分の桁数と, 1のくらいの数字を求めよ. ただし, $3^{21} = 10460353203$を用いて良い.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\frac{10^{210}}{10^{10} + 3} \\[3pt]
&=\frac{(10^{10})^{21} + 3^{21} - 3^{21}}{10^{10} + 3}\\[3pt]
\end{align*}Answer
$$

このとき, $(10^{10})^{21} + 3^{21}$は冪指数が奇数なので

$$
(10^{10})^{21} + 3^{21} = (10^{10} + 3)\sum_{k=0}^{20}(10^{10})^{20-k}3^{k}
$$

よって,

$$
\begin{align*}
&\frac{(10^{10})^{21} + 3^{21} - 3^{21}}{10^{10} + 3}\\[3pt]
&= \sum_{k=0}^{20}(10^{10})^{20-k}3^{k} - \frac{3^{21}}{10^{10} + 3}
\end{align*}
$$

$$
\frac{3^{21}}{10^{10} + 3} = \frac{10460353203}{10000000003} \in (1, 2)
$$

よって, 桁数のオーダーは$\displaystyle \sum_{k=0}^{20}(10^{10})^{20-k}3^{k}$で決まるので, 200桁.

また, １の桁の数は, 

$$
3^{20} \bmod 10 \equiv 1
$$

より, 

$$
1 - 2 \bmod 10 \equiv 9
$$

したがって, 

$$
\textcolor{red}{\text{Answer: }(\text{桁数, 1の桁の数}) = (200, 9)}
$$

</div>




References
----------
- [高校数学の美しい物語 > 因数分解公式（n乗の差，和）](https://manabitimes.jp/math/576)
- [巨大な数を割れよ！割れよ！ – 1989年東大 数学 第4問](https://mine-kikaku.co.jp/index.php/2021/10/29/tokyo-univ-1989-4/)
