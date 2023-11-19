---
layout: post
title: "独立な確率変数と関数変換後の独立"
subtitle: "確率と数学ドリル 6/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-18
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

- [関数変換後の独立性](#%E9%96%A2%E6%95%B0%E5%A4%89%E6%8F%9B%E5%BE%8C%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7)
- [条件付き確率の解釈について](#%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E7%A2%BA%E7%8E%87%E3%81%AE%E8%A7%A3%E9%87%88%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [事象の独立の必要十分条件](#%E4%BA%8B%E8%B1%A1%E3%81%AE%E7%8B%AC%E7%AB%8B%E3%81%AE%E5%BF%85%E8%A6%81%E5%8D%81%E5%88%86%E6%9D%A1%E4%BB%B6)
    - [確率事象 $B$ に依存しないなら $B^c$ にも依存しないことの確認](#%E7%A2%BA%E7%8E%87%E4%BA%8B%E8%B1%A1-b-%E3%81%AB%E4%BE%9D%E5%AD%98%E3%81%97%E3%81%AA%E3%81%84%E3%81%AA%E3%82%89-b%5Ec-%E3%81%AB%E3%82%82%E4%BE%9D%E5%AD%98%E3%81%97%E3%81%AA%E3%81%84%E3%81%93%E3%81%A8%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [Refernces](#refernces)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 関数変換後の独立性

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

確率変数$X, Y$が独立ならば任意の関数$f, g$について, 

$$
f(X) \perp g(Y)
$$

が成立することを示せ.

</div>

厳密な証明ではないですが, 独立性の定義を$\Pr(A \cap B) = \Pr(A)\Pr(B)$であることに留意すると以下のように示せます.

任意の事象A, Bについて

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(f(X)\in A, g(Y)\in B) &= \Pr(X\in f^{-1}(A), Y\in g^{-1}(B))\\[3pt]
                          &= \Pr(X\in f^{-1}(A)) \Pr(Y\in g^{-1}(B)) \  \  \because \text{ 独立性}\\[3pt]
                          &= \Pr(f(X)\in A) \Pr(g(Y)\in B)
\end{align*}
$$
</div>

したがって, $f(X) \perp g(X)$が成立する. 

## 条件付き確率の解釈について

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 条件付き確率</ins></p>

標本空間を$\Omega$, 確率事象を$A, B$かつ, $\Pr(B)\neq 0$のとき, 条件付き確率は

$$
\Pr(A\vert B)=\frac{\Pr(A\cap B)}{\Pr(B)}
$$

</div>

この条件付き確率の意味を考えてみたいと思います. わかりやすく, ある試行に対応する標本空間として$\Omega$を
考え, この試行を何回も独立に繰り返し行う状況を考えます. 

十分大きな回数の$n$回を試行して, その中で 

- $B$の生起した回数を$r$
- $A\cap B$の生起した回数を$s$

このとき以下のように書き表せる

$$
\frac{s}{r}=\frac{s/n}{r/n}\approx \frac{\Pr(A\cap B)}{\Pr(B)} = \Pr(A\vert B)
$$

したがって, $\Pr(A\vert B)$は, $B$が生起した中で $A$も生起した割合$s/r$の近似値を与えることがわかる.

### 事象の独立の必要十分条件

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

A, Bが確立事象で $\Pr(B)\neq 0$とする. このとき, A, Bが互いに独立になるための必要十分条件は

$$
\Pr(A\vert B) = \Pr(A)
$$

</div>

A, Bが独立ならば

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(A\vert B) & = \frac{\Pr(A\cap B)}{\Pr(B)}\\[3pt]
              & = \frac{\Pr(A)\Pr(B)}{\Pr(B)} = \Pr(A)
\end{align*}
$$
</div>

次に十分条件性について確かめる. $\Pr(A\vert B) = \Pr(A)$ならば,

$$
\Pr(A\cap B) = \Pr(A\vert B)\Pr(B) = \Pr(A)\Pr(B)
$$

したがって, 事象の独立性が導かれた.

#### 確率事象 $B$ に依存しないなら $B^c$ にも依存しないことの確認

確率事象 A, Bが独立ならば 

$$
\Pr(A|B^c) = \Pr(A)
$$

も成立することを確認します.

$$
A = (A\cap B)\cup(A\cap B^c)
$$

なので, RHSはどちらも排反事象なので

$$
\Pr(A) = \Pr(A\cap B) + \Pr(A\cap B^c)
$$

したがって, 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(A|B^c) &= \frac{\Pr(A\cap B^c)}{\Pr(B^c)}\\[3pt]
           &= \frac{\Pr(A) - \Pr(A\cap B)}{1 - \Pr(B)}
\end{align*}
$$
</div>

独立性より

$$
\frac{\Pr(A\cap B)}{\Pr(B)} = \frac{\Pr(A)}{1}
$$

が成立するので加比の理より

<div class="math display" style="overflow: auto">
$$
\begin{align*}
&\frac{\Pr(A) - \Pr(A\cap B)}{1 - \Pr(B)} = \frac{\Pr(A\cap B)}{\Pr(B)}\\[3pt]
&\Rightarrow \Pr(A|B^c) = \Pr(A)
\end{align*}
$$
</div>

したがって, $B, B^c$のもとでのという条件をつけても$A$の確率に影響を与えないことがわかる.


Refernces
-------------
- [Ryo's Tech Blog > Propensity score & Conditional Independence Assumption](https://ryonakagami.github.io/2023/07/06/propensity-score-conditional-independence/)
- [高校数学の美しい物語 > 加比の理と傾きによる証明](https://manabitimes.jp/math/941)
