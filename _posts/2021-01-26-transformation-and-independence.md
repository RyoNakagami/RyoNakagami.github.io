---
layout: post
title: "独立な確率変数と関数変換後の独立"
subtitle: "確率と数学ドリル 6/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-20
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

- [条件付き確率からの独立性](#%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E7%A2%BA%E7%8E%87%E3%81%8B%E3%82%89%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7)
  - [事象の独立の必要十分条件](#%E4%BA%8B%E8%B1%A1%E3%81%AE%E7%8B%AC%E7%AB%8B%E3%81%AE%E5%BF%85%E8%A6%81%E5%8D%81%E5%88%86%E6%9D%A1%E4%BB%B6)
  - [確率事象 $B$ に依存しないなら余事象にも依存しないことの確認](#%E7%A2%BA%E7%8E%87%E4%BA%8B%E8%B1%A1-b-%E3%81%AB%E4%BE%9D%E5%AD%98%E3%81%97%E3%81%AA%E3%81%84%E3%81%AA%E3%82%89%E4%BD%99%E4%BA%8B%E8%B1%A1%E3%81%AB%E3%82%82%E4%BE%9D%E5%AD%98%E3%81%97%E3%81%AA%E3%81%84%E3%81%93%E3%81%A8%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [組独立と独立](#%E7%B5%84%E7%8B%AC%E7%AB%8B%E3%81%A8%E7%8B%AC%E7%AB%8B)
- [関数変換後の独立性](#%E9%96%A2%E6%95%B0%E5%A4%89%E6%8F%9B%E5%BE%8C%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7)
  - [関数変換後の独立性の活用例: 積率母関数の導出](#%E9%96%A2%E6%95%B0%E5%A4%89%E6%8F%9B%E5%BE%8C%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7%E3%81%AE%E6%B4%BB%E7%94%A8%E4%BE%8B-%E7%A9%8D%E7%8E%87%E6%AF%8D%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Appendix: Laplaceによる確率の定義](#appendix-laplace%E3%81%AB%E3%82%88%E3%82%8B%E7%A2%BA%E7%8E%87%E3%81%AE%E5%AE%9A%E7%BE%A9)
- [Refernces](#refernces)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 条件付き確率からの独立性

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

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

> 必要条件について

A, Bが独立ならば

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(A\vert B) & = \frac{\Pr(A\cap B)}{\Pr(B)}\\[3pt]
              & = \frac{\Pr(A)\Pr(B)}{\Pr(B)} = \Pr(A)
\end{align*}
$$
</div>

> 十分条件について

次に十分条件について確かめる. $\Pr(A\vert B) = \Pr(A)$ならば,

$$
\Pr(A\cap B) = \Pr(A\vert B)\Pr(B) = \Pr(A)\Pr(B)
$$

したがって, 事象の独立性が導かれた.


</div>

### 確率事象 $B$ に依存しないなら余事象にも依存しないことの確認

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

が成立するので[加比の理](https://manabitimes.jp/math/941)より

<div class="math display" style="overflow: auto">
$$
\begin{align*}
&\frac{\Pr(A) - \Pr(A\cap B)}{1 - \Pr(B)} = \frac{\Pr(A\cap B)}{\Pr(B)}\\[3pt]
&\Rightarrow \Pr(A|B^c) = \Pr(A)
\end{align*}
$$
</div>

したがって, $B, B^c$のもとでのという条件をつけても$A$の確率に影響を与えないことがわかる.


## 組独立と独立

２つ以上の事象についての独立の問題を考えてみる. その前に「**組独立と独立**」という概念を導入します.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 組独立と独立</ins></p>

事象$A_1, \cdots, A_n$について

$$
\Pr(A_i \cap A_j) = \Pr(A_i)\Pr(A_j) \  \ \text{where}  \ \ i\neq j
$$

が成り立つとき, **組独立**と呼ぶ.

事象$A_1, \cdots, A_n$が, 任意の$1\leq i_1 < i_2 < \cdots < i_k \leq n$について

$$
\Pr(A_{i1} \cap \cdots \cap A_{ik}) = \Pr(A_{i1})\cdots \Pr(A_{ik}) 
$$

が成り立つとき, **互いに独立**と呼ぶ.

</div>

上の定義より「**独立**」が成り立つならば, 「**組独立**」は成立するが逆は正ではありません.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Example: コイン投げ</ins></p>

歪みのないコインを独立に２回投げるとする. このとき以下の３つの事象を考える

- A: 1回目に表が出る
- B: 2回目に表が出る
- C: 表が出る回数はちょうど1回のみ

これら事象A, B, Cは組独立であるが互いに独立ではない

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

> 組独立について

AとBの独立性は自明なので, AとCの独立性について調べる

コインの出方は $\Omega = \{HH, HT, TH, TT\}$の同様に確からしい4パターンが考えられる. このとき,

$$
\begin{align*}
&\Pr(A) = \frac{1}{2}\\[3pt]
&\Pr(C) = \frac{\sharp C}{\sharp\Omega} = \frac{2}{4} = \frac{1}{2}\\[3pt]
&\Pr(A\cap C) = \frac{\sharp A\cap C}{\sharp\Omega} = \frac{1}{4} 
\end{align*}
$$

従って, $\Pr(A\cap C) = \Pr(A)\Pr(C)$が成り立ち独立である(ラプラス的確率を使っている). B, Cについても同様の議論で組独立がいえるため,
A, B, Cは組独立が成立する.

> 互いに独立ではない

$$
\begin{align*}
&\Pr(A\cap B\cap C) = 0\\[3pt]
&\Pr(A)\Pr(B)\Pr(C) = \frac{1}{8}
\end{align*}
$$

従って, 互いに独立ではない.

</div>



なお, この例ではA, Cが独立であるが感覚的には無関係ではないことがわかるので, 独立だからといって無関係と思うことは回避したほうが良いと言えます(= 無関係なら独立だけど, 独立だからといって無関係ではない)

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: 組独立だけど互いに独立ではないパターン</ins></p>

フェアコインを3回独立に投げたとき, 以下の３つの事象を考える

- A: 1回目の結果と2回目の結果が同じ
- B: 2回目の結果と3回目の結果が同じ
- C: 1回目の結果と3回目の結果が同じ

このときも, A, B, Cは組独立が成立するが互いに独立ではありません.

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

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

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

</div>

### 関数変換後の独立性の活用例: 積率母関数の導出

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 積率母関数と確率母関数</ins></p>

確率変数 $X, Y$が独立であるとき $X+Y$の積率母関数をもとめよ.
また, $X, Y$が非負の整数値のみをとる場合の確率母関数も求めよ

</div>

[関数変換後の独立性](#%E9%96%A2%E6%95%B0%E5%A4%89%E6%8F%9B%E5%BE%8C%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7)が成立することを利用すると簡単に求めることができます.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

<div class="math display" style="overflow: auto">
$$
\begin{align*}
M_{X+Y}(t) &= \mathbb E[\exp(t(X+Y))]\\[3pt]
           &= \mathbb E[\exp(t(X))\exp(t(Y))]\\[3pt]
           &= \mathbb E[\exp(t(X))]\mathbb E[\exp(t(Y))] \because \text{関数変換後の独立}\\[3pt]
           &= M_{X}(t)M_{Y}(t)
\end{align*}
$$
</div>

確率母関数についても同様に

<div class="math display" style="overflow: auto">
$$
\begin{align*}
g_{X+Y}(t) &= \mathbb E[t^{X+Y}]\\[3pt]
           &= \mathbb E[t^Xt^Y]\\[3pt]
           &= \mathbb E[t^X]\mathbb E[t^Y]\because \text{関数変換後の独立}\\[3pt]
           &= g_{X}(t)g_{Y}(t)
\end{align*}
$$
</div>

</div>

## Appendix: Laplaceによる確率の定義

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Laplaceによる確率の定義</ins></p>

標本空間が $\Omega=\{a_1,a_2,\cdots,a_n\}$ で、根元事象

$$
\displaystyle \{a_1\}, \{a_2\}, \cdots, \{a_n\} 
$$

が同様に確からしいとき, 事象 $A\subset \Omega $ の確率 $\Pr(A)$ を、

$$
\Pr(A){\stackrel{\text{def}}{=}}\frac{\sharp A}{\sharp \Omega} \ \  \text{ where } \sharp A \text{で事象 A に含まれる標本点の個数を表わす}
$$

と定義するときLaplaceによる確率の定義という

</div>

Laplaceによる確率の定義は「**同様に確からしい**」が重要な仮定となっているため

$$
\Pr(\{1\}) = 2/7, \Pr(\{2\}) = \Pr(\{3\})= \Pr(\{4\})= \Pr(\{5\})= \Pr(\{6\}) = 1/7, 
$$

といういびつなサイコロを扱うことが難しくなってしまうという問題点があります. そこで, 現代の確率論では個々の問題における確率法則 $\Pr$ の 決め方については言及せず, ただ $\Pr$ の満たすべき法則だけを指定しそこから導かれることを論じています(例として測度論的確率論など). 


Refernces
-------------
- [Ryo's Tech Blog > Propensity score & Conditional Independence Assumption](https://ryonakagami.github.io/2023/07/06/propensity-score-conditional-independence/)
- [高校数学の美しい物語 > 加比の理と傾きによる証明](https://manabitimes.jp/math/941)
