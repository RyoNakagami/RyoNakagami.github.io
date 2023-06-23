---
layout: post
title: "Chebyshev inequalityの導出"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-03-09
tags:

- 統計
- statistical inference
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Chebyshev inequalityの定理](#chebyshev-inequality%E3%81%AE%E5%AE%9A%E7%90%86)
  - [Cantelli's inequality](#cantellis-inequality)
    - [Chebyshev's inequalityとの比較](#chebyshevs-inequality%E3%81%A8%E3%81%AE%E6%AF%94%E8%BC%83)
- [例題: 合計診察時間の確率計算](#%E4%BE%8B%E9%A1%8C-%E5%90%88%E8%A8%88%E8%A8%BA%E5%AF%9F%E6%99%82%E9%96%93%E3%81%AE%E7%A2%BA%E7%8E%87%E8%A8%88%E7%AE%97)
- [Appendix: Markov's inequlity](#appendix-markovs-inequlity)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Chebyshev inequalityの定理

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

確率変数 $X$ に対して $\mathbb E[X] = \mu, Var(X) = \sigma^2$とおいたとき,

$$
\begin{align*}
\ \ &Pr(|X - \mu|\geq k\sigma) \leq \frac{1}{k^2}\\
\ \ &\text{where } k > 1 \text{ and constant}
\end{align*}
$$


</div>

**証明**

以下のような確率変数 $D$ を定義する

$$
D = \begin{cases}
1 & \text{ if } |X - \mu|\geq k\sigma\\[8pt]
0 & \text{ otherwise}
\end{cases}
$$

すると, 以下の式が常に成り立つ

$$
(X - \mu)^2 \geq k^2\sigma^2U
$$

従って, 

$$
\begin{align*}
\sigma^2 &= Var(X)\\
         &= \mathbb E[(X - \mu)^2]\\
         &\geq \mathbb E[k^2\sigma^2U]\\
         &= k^2\sigma^2\mathbb E[U]\\
\Rightarrow& \frac{1}{k^2} \geq  \mathbb E[U]
\end{align*}
$$

定義より, $\mathbb E[U]$は $Pr(\|X - \mu\| \geq k\sigma)$と同値なので

$$
Pr\{|X - \mu|\geq k\sigma\} \leq \frac{1}{k^2}
$$

**証明終了**

---

### Cantelli's inequality

Chebyshev's inequalityのよりweakerなboundの定理としてCantelli's inequalityがあります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: Cantelli's inequality</ins></p>

期待値 $\mu$ と分散 $\sigma^2$ を持つ確率変数$X$ について

$$
\begin{align*}
&Pr(X\geq \mu + t\sigma) \leq \frac{1}{1 + t^2}\\[8pt]
&Pr(X\leq \mu - t\sigma) \leq \frac{1}{1 + t^2}
\end{align*}
$$

</div>

**証明**

証明にはMarkov's inequlityを用います. for any $v>0$, 

$$
\begin{align*}
Pr(X - \mu \geq t) &= Pr(X - \mu + v \geq t + v)\\
                   &\leq Pr((X - \mu +v)^2 \geq (t + v)^2)\\
                   &\leq \frac{\mathbb E[(X - \mu +v)^2]}{ (t + v)^2}\\
                   &= \frac{v^2 + v^2}{(t + v)^2}
\end{align*}
$$

ここで $v = \sigma/t$ とすると

$$
\begin{align*}
Pr(X \geq \mu + t) &\leq \frac{\sigma^2 + v^2}{(t + v)^2}\\
                           &= \frac{\sigma^2}{t^2 + \sigma^2}
\end{align*}
$$

さらに $t = t^*\sigma$と変換すると

$$
Pr(X \geq \mu + t^*\sigma) \leq \frac{1}{1+t^{*2}}
$$

**証明終了**



#### Chebyshev's inequalityとの比較

> Chebyshev's inequality

$$
\begin{align*}
Pr(X - \mu \geq k\sigma) \leq Pr(|X - \mu|\geq k\sigma) \leq \frac{1}{k^2}
\end{align*}
$$

> Cantelli's inequality

$$
Pr(|X - \mu|\geq k\sigma) = Pr(X - \mu\geq k\sigma) + Pr(|X - \mu|\leq -k\sigma) \leq \frac{2}{1+k^2}
$$

従って, two-sidedにおける比較においては$k>1$について常にChebyshev's inequalityに対して劣るboundであることがわかる.


## 例題: 合計診察時間の確率計算

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

100人の患者を次々と診察する１人医者を考える. 一人あたりの診察時間についての確率変数 $X$について
$\mathbb E[X] = 1$, $Var(X) = 0.64$ が事前に知られている.

患者の診察は互いに独立に実施されるとして, 100人全員の診察が完了するまでに要した時間を $T$ としたとき, 
平均を中央とした上下区間が下限96%になるような区間を求めよ.

</div>

**解答**

問題文より, $\mathbb E[T] = 100$, $Var(T) = 64$は自明.

Chebyshev inequalityより

$$
Pr(|T - 100|< 8k) \geq 1-\frac{1}{k^2} = 0.96
$$

従って, $k=5$のときを求めればいいので

$$
Pr(60 < T < 140) \geq 0.96
$$




**解答終了**



## Appendix: Markov's inequlity

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem </ins></p>

期待値 $\mu$ のnon-negativeな確率変数 $X$について

$$
Pr(X\geq t) \leq \frac{\mu}{t} \  \ \forall t>0
$$

or

$$
Pr(X\geq t\mu) \leq \frac{1}{t} \  \ \forall t>0
$$

</div>

**証明**

non-negativeな確率変数 $X$について以下は常に成り立つ

$$
1\{X\geq t\} = 1\{X/t\geq 1\} \leq X/t
$$

これについて期待値をとると

$$
\begin{align*}
\mathbb E[1\{X\geq t\}] &= Pr(X\geq t)\\
                        &\leq \mathbb E[X/t]\\
                        &= \frac{\mu}{t}
\end{align*}
$$


**証明終了**

---


## References

> Book

- [Principles of Statistical Analysis Learning from Randomized Experiments](https://www.cambridge.org/core/books/principles-of-statistical-analysis/74C6545BBEF83D5E41C48BA11756032C)