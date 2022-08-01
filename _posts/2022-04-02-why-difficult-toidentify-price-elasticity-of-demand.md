---
layout: post
title: "需要の価格弾力性の識別はなぜ難しいのか?"
subtitle: "市場均衡価格とEndogeneity bias"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-01
tags:

- Economics
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Introduction: 問題設定](#introduction-%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
- [市場需要と市場供給](#%E5%B8%82%E5%A0%B4%E9%9C%80%E8%A6%81%E3%81%A8%E5%B8%82%E5%A0%B4%E4%BE%9B%E7%B5%A6)
  - [需要関数が価格の減少関数のIntuitiuon](#%E9%9C%80%E8%A6%81%E9%96%A2%E6%95%B0%E3%81%8C%E4%BE%A1%E6%A0%BC%E3%81%AE%E6%B8%9B%E5%B0%91%E9%96%A2%E6%95%B0%E3%81%AEintuitiuon)
- [市場均衡価格とEndogeneity bias](#%E5%B8%82%E5%A0%B4%E5%9D%87%E8%A1%A1%E4%BE%A1%E6%A0%BC%E3%81%A8endogeneity-bias)
  - [Endogeneity biasの導出](#endogeneity-bias%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Pythonでのシミュレーション](#python%E3%81%A7%E3%81%AE%E3%82%B7%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)
- [参考資料](#%E5%8F%82%E8%80%83%E8%B3%87%E6%96%99)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)
  - [書籍](#%E6%9B%B8%E7%B1%8D)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Introduction: 問題設定

需要の価格弾力性の推定は多くの分析者の興味の対象だと思います.例えば,

---|---
企業目線|利潤最大化を目的としている企業は, (1) 自社製品の価格が上昇した時需要が減るか否か? (2) 減るとしてもその時の最終的な売上はどうなるのか? (3) 自社製品をxxx円で設定した時どれくらい事前に在庫を積んでおくべきか?という問題に直面しているため,需要の価格弾力性(特に自社製品の需要関数)を理解したいと望んでいる.
政府目線|市場支配力による厚生損失を測定するために、価格変動が需要に与える影響を理解したい(例：低い価格弾力性＋独占権力＝高い厚生損失)

市場均衡価格と市場均衡販売数量とその他特徴量からなるデータを用いて需要関数を推定したくなりますが,データ生成過程に着目することなく分析してしまうとEndogeneity biasを含んだパラメーターを推定してしまう=需要の価格弾力パラメーターの識別ができない問題が発生します.

このポストではEndogeneity biasを含んだパラメーターが推定されてしまう仕組みを簡単に説明します.

## 市場需要と市場供給

> 仮定

- ここでは１つの市場だけに注目し、他の市場価格や所得などは一定と仮定する
- 市場に参加するConsumer, Firmsはprice takerとする(=市場均衡価格を所与に,各自供給/需要数量を決定する)

> 市場均衡水準の決定プロセス

市場需要と市場供給についてまず考えます.

いま,消費者は全部で$I$人いるとして,分析対象の財に対する消費者$i$の需要を$D_i(p)$, $p$は財の価格としたとき,市場需要は

$$
D(p) = \sum_{i\in I}D_i(p)
$$

また、単純化するため,$D(p)$はpについての連続関数で

$$
\frac{\partial D(p)}{\partial p} < 0
$$


同様に,企業が全部で$J$社いるとして,分析対象の財について$j\in J$の供給量を$S_j(p)$としたとき,市場供給は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
S(p) &= \sum_{j\in J}S_i(p)\\
\frac{\partial S(p)}{\partial p} &> 0
\end{align*}
$$
</div>

また,需要関数同様に$(p)$はpについての連続関数とします.

上記の設定上,価格に応じてそれぞれ需要/供給水準が定まりますが,$D(p^*) = S(p^*)$を満たす価格$p^*$が市場均衡価格となります.
つまり,完全競争的な市場では,需要と供給がバランスするように市場均衡価格と市場均衡数量が定まります.

需要と供給が市場均衡価格でバランスするメカニズムとして,もし任意の価格において $D(p_0) > S(p_0)$が成立するならば,超過需要の状態が発生します.
このとき、需要は価格に関する減少関数, 供給は価格に関する増加関数であることに留意すると,超過需要関数を

$$
Z(p)\equiv D(p) - S(p), \text{ where } Z(p)\in \mathbb R
$$

としたとき,$p_0$のとき超過需要が発生しているのであるならば市場価格を増加させ,逆の場合は減少させるという裁定を行っていくと

$$
Z(p^*) = 0 \Rightarrow D(p^*) = S(p^*)
$$

となり均衡点に落ち着くことになります.

### 需要関数が価格の減少関数のIntuitiuon

単純化のため, consumerの各個人 $i$ のutility functionは以下の形状をしているとします:

$$
U_i = \theta_i - p
$$

- $\theta_i$は消費者ごとに異なるパラメータであり,財について各個人が感じる品質を反映するパラメータとします
- $\theta_i$は$[0,\theta_{max}]$区間で一様に分布しているとします

そして0個または1個の商品を以下のルールで買うとします:

<div class="math display" style="overflow: auto">
$$
D_i(p)=
\begin{cases}
1 & \  \ \text{ if } \ \theta_i > p \\
0 & \  \ \text{ otherwise} 
\end{cases}
$$
</div>

このとき、価格$p$における市場需要は$\theta_i > p$を満たす人数なので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
D(p) &= \text{Pr}(\theta > p)I\\
&= [1 - \text{Pr}(\theta \leq p)]I\\
&= \left[1 - \frac{p}{\theta_{max}}\right]I\\
&= I - \frac{I}{\theta_{max}}p
\end{align*}
$$
</div>

このことから,市場需要は市場消費者人数には正に,価格には負に依存することがわかります.

> REMARKS

- あくまでUtility Functionの設定を問題と適合するように定めているからです
- モデルの設定次第ではギッフェン財とかも発生しうるのであくまでIntuitionです

## 市場均衡価格とEndogeneity bias

とある一つの市場について,複数時点$t$の市場均衡価格と数量の関係がデータとして手元にあるとします.

> モデル設定

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\text{Demand Function}: & \log(D_t) = \alpha_d +\beta_d\log(p_t) + \epsilon_{dt}\\
\text{Supply Function}: & \log(S_t) = \alpha_s +\beta_s\log(p_t) + \epsilon_{st}
\end{align*}
$$
</div>

- $\mathbb E[\epsilon_{dt}] = \mathbb E[ \epsilon_{ds}] = 0$
- $Var(\epsilon_{dt}) = \sigma^2_d$
- $Var(\epsilon_{st}) = \sigma^2_s$
- $Cov(\epsilon_{dt},\epsilon_{ds})=0$
- $Cov(\epsilon_{dt},\epsilon_{dt'})=0$
- $Cov(\epsilon_{st},\epsilon_{st'})=0$


> データ生成過程

すべての$t$時点において$D_t = S_t = Q_t$が成立する市場均衡価格が成立するとします.

### Endogeneity biasの導出

$D_t = S_t = Q_t$が成立する価格のみ観測されるので,そのときの市場均衡価格は$\log(p_t)=\tilde p_t$とすると

$$
\tilde p_{t,observed} = \frac{(\alpha_d - \alpha_s) + (\epsilon_d - \epsilon_s)}{\beta_s - \beta_d}
$$

また,上記の式より

<div class="math display" style="overflow: auto">
$$
\begin{align*}
Var(\tilde p_{t,observed}) &= \frac{\sigma^2_d + \sigma^2_s}{(\beta_s - \beta_d)^2}\\
Cov(\tilde p_{t,observed}, \epsilon_d) &= \frac{\sigma^2_d}{\beta_s-\beta_d}
\end{align*}
$$
</div>

したがって,市場均衡数量を市場均衡価格に回帰して得られる推定量$\beta^*$は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
plim \beta^* &= \frac{Cov(\tilde D_t, \tilde p_{t,observed})}{Var(\tilde p_{t,observed})}\\
&= \frac{\sigma^2_s}{\sigma^2_d+\sigma^2_s}\beta_d+\frac{\sigma^2_d}{\sigma^2_d+\sigma^2_s}\beta_s
\end{align*}
$$
</div>

ここから以下のことがわかります:

- $\beta^*$は$\beta_d$の一致推定量ではない
- 推定されるパラメータは需要価格弾力性と供給価格弾力性のweighted mean

## Pythonでのシミュレーション

<iframe src="https://nbviewer.org/github/RyoNakagami/Blog_Supplementary_Materials/blob/main/econometrics/Endogeneity_bias.ipynb" width="100%" height="5000" frameborder="0"></iframe>

## 参考資料
### オンラインマテリアル

- [Advanced Industrial Organization Identification of Demand Functions](http://www.soderbom.net/demand_final_slides11.pdf)

### 書籍

- [計量経済学 第2版, 浅野　皙 (筑波大学教授)，中村　二朗 (日本大学教授)／著](http://www.yuhikaku.co.jp/books/detail/9784641163362)