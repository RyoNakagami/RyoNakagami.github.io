---
layout: post
title: "指数分布と幾何分布の関係性"
subtitle: "確率と数学ドリル 8/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-20
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

- [指数分布と幾何分布の関係](#%E6%8C%87%E6%95%B0%E5%88%86%E5%B8%83%E3%81%A8%E5%B9%BE%E4%BD%95%E5%88%86%E5%B8%83%E3%81%AE%E9%96%A2%E4%BF%82)
  - [証明](#%E8%A8%BC%E6%98%8E)
- [無記憶性（Memorylessness）について](#%E7%84%A1%E8%A8%98%E6%86%B6%E6%80%A7memorylessness%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [幾何分布の無記憶性の証明](#%E5%B9%BE%E4%BD%95%E5%88%86%E5%B8%83%E3%81%AE%E7%84%A1%E8%A8%98%E6%86%B6%E6%80%A7%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [指数分布の無記憶性](#%E6%8C%87%E6%95%B0%E5%88%86%E5%B8%83%E3%81%AE%E7%84%A1%E8%A8%98%E6%86%B6%E6%80%A7)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 指数分布と幾何分布の関係

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

確率変数 $X$ はパラメーター$\lambda$の指数分布に従うとする. つまり, $f$を$X$の確率密度関数とすると

$$
f(x) = \lambda\exp(-\lambda x)
$$

$Y = \lfloor X \rfloor$という変数変換をおいたときの $Y$ の確率関数を求めよ

</div>

これは指数分布の離散型が幾何分布に対応することを確認する問題となります.

### 証明

$k$を正の整数としたとき,

$$
\begin{align*}
&Y = \lfloor X \rfloor = k \\[3pt]
&\Leftrightarrow k\leq X < k+1
\end{align*}
$$

したがって,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(Y=k) &= \int^{k+1}_k\lambda\exp(-\lambda x)dx\\[3pt]
         &= [1 - \exp(-\lambda x)]^{k+1}_{k}\\
         &= \exp(-\lambda k) - \exp(-\lambda (k+1))\\
         &= (1 - \exp(-\lambda))\exp(-\lambda k)
\end{align*}
$$
</div>

なお, 

$$
(1 - \exp(-\lambda))\exp(-\lambda k) = (1 - \exp(-\lambda))\exp(-\lambda)^k
$$

と変形させると確率変数 $Y$ が$p=1 - \exp(-\lambda)$の幾何分布に従うことがわかる.

## 無記憶性（Memorylessness）について

幾何分布や指数分布は**無記憶性**という性質が知られています. 幾何分布を例とすると, 
$m$回までの試行に追いて成功していない条件の下で次の$n$回までの試行で成功しないという確率は,
$m$回までの試行に追いて成功していない条件に依存しないという性質です. 

つまり, $X$が幾何分布に従うとき以下が成立します

$$
\Pr(X\geq m+n\vert X\geq m) = \Pr(X\geq n)
$$

### 幾何分布の無記憶性の証明

$X \sim Ge(p)$とすると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(X\geq m+n\vert X\geq m) &= \frac{\Pr(X\geq m+n, X\geq m)}{\Pr(X\geq m)}\\[3pt]
                            &= \frac{\Pr(X\geq m+n)}{\Pr(X\geq m)}
\end{align*}
$$
</div>

ここで, $\Pr(X\geq m)=\sum_{k\geq m}(1-p)^kp=(1-p)^m$であるので,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(X\geq m+n\vert X\geq m) &= \frac{(1-p)^{m+n}}{(1-p)^m}\\[3pt]
                            &= (1-p)^n\\
                            &= \Pr(X\geq n)
\end{align*}
$$
</div>

したがって, 無記憶性が確認できた.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: 無記憶性について</ins></p>

$$
\Pr(X\geq m+n\vert X\geq m) = \Pr(X\geq n)
$$

を無記憶性の定義として紹介しましたが, この式を変形させると以下を得ることができます:

$$
\Pr(X\geq m+n) = \Pr(X\geq m)\Pr(X\geq n)
$$

</div>

### 指数分布の無記憶性

幾何分布の場合と同様に

<div class="math display" style="overflow: auto">
$$
\begin{align*}
F(X\geq x+y\vert X\geq x) &= \frac{F(X\geq x+y, X\geq x)}{F(X\geq x)}\\[3pt]
                            &= \frac{F(X\geq x+y)}{F(X\geq x)}
\end{align*}
$$
</div>

なので, 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
F(X\geq x+y\vert X\geq x) &= \frac{\exp(-\lambda(x+y))}{\exp(-\lambda(x))}\\[3pt]
                          &= \exp(-\lambda y)\\
                          &= F(X\geq y)
\end{align*}
$$
</div>

よって無記憶性が確認できた.
