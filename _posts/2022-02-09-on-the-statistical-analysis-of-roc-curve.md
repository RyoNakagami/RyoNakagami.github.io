---
layout: post
title: "論文紹介: Topmpson 1989, On The Statistical Analysis of ROC Curve"
subtitle: "ROC曲線の解釈指標としての「Binormal ROCを仮定したAUC」"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-03-03
tags:

- 統計
- statistical inference
- 論文
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [前提知識](#%E5%89%8D%E6%8F%90%E7%9F%A5%E8%AD%98)
  - [ROC cruves](#roc-cruves)
  - [AUC](#auc)
  - [ANOVA model](#anova-model)
- [論文解説](#%E8%AB%96%E6%96%87%E8%A7%A3%E8%AA%AC)
  - [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [Binormal ROC曲線](#binormal-roc%E6%9B%B2%E7%B7%9A)
    - [Binormal ROC曲線の仮定](#binormal-roc%E6%9B%B2%E7%B7%9A%E3%81%AE%E4%BB%AE%E5%AE%9A)
    - [Binormal ROC曲線の導出](#binormal-roc%E6%9B%B2%E7%B7%9A%E3%81%AE%E5%B0%8E%E5%87%BA)
    - [pAUCの計算方法](#pauc%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 前提知識
### ROC cruves

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ROC curves</ins></p>

ROC(Receiver Operating Characteristic)曲線は, True Positive Rateとfalse positive(Type I Error)の関係をグラフにしたものです. 
グラフの面積が大きいほど性能指標が良く, そのエリアの面積の計算はAUCとしてよばれます.

- 完全な予測を行った場合は, ROC曲線は左上の(0.0, 1.0)の点を通り, AUCは1.0になる
- ランダムな予測を実行した場合は, AUCは0.5程度となる

</div>

### AUC

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Empirical AUC</ins></p>

$C_1$, $C_2$ をそれぞれpositiveとnegativeを表すClassの集合とします. $n_1$は$n_1$に属する観察サイズ, 
$N_2$は$C_2$に属する観察サイズとします. 

各標本点 $i$ についてモデルが $D_i$ というスコアを出力し, $D_i$の大きさはpostiveに分類される確率の大きさに比例するとします.
このとき,  The area under empirically estimated ROC curve(= Empirical AUC)は

$$
\widehat{AUC} = \frac{1}{n_1n_2}
\sum_{i\in C_1}\sum_{j \in C_2}
\bigg(\frac{1}{2}I(D_{i}>D_{j})+
\frac{1}{2}I(D_{i}=D_{j})\bigg)
$$

この式から, 各標本点について同じスコアを出力（＝モデルが適当に出力している）ときAUCが0.5を出力することがわかります

</div>

### ANOVA model


## 論文解説
### 問題設定

<style>
    .heatMap {
        width: 100%;
        text-align: center;
    }
    .heatMap th {
        background: grey;
        word-wrap: break-word;
        text-align: center;
    }
    .heatMap tr:nth-child(1) { background: gray; color:white; }
</style>

<div class="heatMap">

|診断レベル|1|2|3|4|5|
|Normal(50人)|4|17|20|8|1|
|Diseased|3|3|17|19|8|
|合計|7|20|37|27|9|

</div>

50人の健康状態がNormalの患者と50人のDiseasedの患者,合計100人を考えます.
とある医師がその100人の患者を独立に診察し, その診断結果を 1~5 と数値が大きくなるほど健康状態が悪くなるスコアで分類します.

上記の診断結果の良し悪しの判断方法として, 視覚的に判別可能なROC曲線が用いられることが多いですが, 
他の人の診断結果との比較などを考える際には比較可能な数値, AUCを用いたりします.

ただ, スコアが1~5のカテゴリー, そしてそのBoundariesが4つしかないという状況のため,
本来はスムーズな曲線の下側エリアとして計算されるAUCが出来ないという問題に直面していまします.

また, 問題設定から論理的に導かれる要件からAUC全体ではなくて一部のpAUCでモデル性能比較を求められる時にどのようにpAUCを計算するか？という問題にも直面し得ます.

この論文では, binormal ROC曲線を仮定し, その下でのpAUCの計算手法とその計算手法の使い勝手良さを紹介しています.

> SensitivityとSpecificity

- Sensitivity: TPF(True Position Fraction), Recall
- Specificity: 1-FPF(False Positive Fraction)

例として, 診断レベル 5 を基準にNormalとDiseased判定をしたとすると,

$$
\begin{align*}
\text{Sensitivity} &= 8/50 = 0.16\\[5pt]
\text{Specificity} &= 1 - 1/50 = 0.98
\end{align*}
$$

基準を5から1まで変化させると(Sensitivity, Specificity)の組は, $(0.16, 0.98), (0.54, 0.82), (0.88, 0.42), (0.94, 0.08), (1.0, 0)$
と変化していきます.

### Binormal ROC曲線

[問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)と同様に, 解きたいと考えている分類問題について,
モデルが出力する患者 $i$ のついての診察結果を$X_i$ ($i$は患者index)としたとき, 
$X_i$が M個の順序性のあるcatagorized measurementsの場合を考えます.

#### Binormal ROC曲線の仮定

このとき, binormal ROC曲線の計算にあたって２つの仮定を設定します:

1. モデルが出力するcatagorized measurementsは, 分析者には見えないGaussian random variablesに従う
2. Gaussian random variablesについて, Normalの患者は $N(\mu_N, \sigma^2_N)$, Diseasedの患者は$N(\mu_D, \sigma^2_D)$に従う


１つ目の仮定は, このM個のcatagorized measurementsはcontinuous Gaussian random variables, $Z_i$に基づいており, 
M個のcatagorized measurementsは 分析者には観測できない M-1個の固定のboundaries $K_1, K_2, \cdots, K_{M-1}$に従っているとしています.

つまり,

$$
X_i = \begin{cases}
1 & \text{if } \ \ Z \in (-\infty, K_1] \\
2 & \text{if } \ \ Z \in (K_1, K_2] \\
\vdots & \\
M & \text{if } \ \ Z \in (K_{M-1}, \infty) \\
\end{cases}
$$

2つ目の仮定は,

$$
Z_i = \begin{cases}
Z_N \sim N(\mu_N, \sigma^2_N) & \text{if 患者 i がNormal}\\
Z_D \sim N(\mu_D, \sigma^2_D) & \text{if 患者 i がDiseased}
\end{cases}
$$

#### Binormal ROC曲線の導出

まず分析者が$Z_i$を観測できるとして, 任意の基準点 $u$ について $Z_i > u$ ならばDiseasedであるというルールで分類すると

$$
\begin{align*}
\text{FPF} &= Pr(Z_N > u) = 1 - \Phi\bigg(\frac{u-\mu_N}{\sigma_N}\bigg)\\
\text{TPF} &= Pr(Z_D > u) = 1 - \Phi\bigg(\frac{u-\mu_D}{\sigma_D}\bigg)
\end{align*}
$$

従って, FPFとTPFの関係について次のように表現できます:

$$
\begin{align*}
\text{TPF} &= \Phi[a + b \Phi^{-1}(FPF)]\tag{A-1}\\ 
a          &= \frac{\mu_D - \mu_N}{\sigma_D}\\
b          &= \frac{\sigma_N}{\sigma_D}
\end{align*}
$$

$(a, b)$はnoiseが混じった$\{X_i\}_{i=1}^n$によって定義されるTPF, FPFの組を用いたMLEによって推定が可能としている. 
なお, $(\mu_N, \mu_D, \sigma_N, \sigma_D)$は直接推定しないことに留意.

#### pAUCの計算方法

Binormal modelの下でのpAUC(=partial Area Under the Curve)の計算方法を紹介します.

(A-1) に基づき, FPFを$x$に書き換え, $x \in (0, c)$を定義域とするpAUCは以下のように計算されます

$$
\text{pAUC}_c = \int_0^c \text{TPF}_xdx = \int^c_0\Phi[a + b \Phi^{-1}(x)]dx\tag{A-2}
$$

ここで以下のような変数変換を導入します

$$
x_1 = \Phi(x)\tag{A-3}
$$

(A-2), (A-3)より

$$
\begin{align*}
\text{pAUC}_c &= \int^{\Phi^{-1}(c)}_{-\infty}\Phi[a + b x_1]\phi(x_1)dx_1\\
&= \int^{\Phi^{-1}(c)}_{-\infty}\int^{a+bx_1}_{-\infty}\phi(x_2)\phi(x_1)dx_2dx_1 \tag{A-4}
\end{align*}
$$

更に次のような変数変換を導入します:

$$
\begin{align*}
z_1 &= \frac{x_2 - bx_1}{\sqrt{1+b^2}} \tag{A-5}\\
z_2 &= x_1 \tag{A-6}\\
\rho &= -\frac{b}{\sqrt{1+b^2}}\tag{A-7}
\end{align*}
$$

(A-4), (A-5), (A-6), (A-7)より

$$
\begin{align*}
\text{pAUC}_c &= \int^{\Phi^{-1}(c)}_{-\infty}\int^{a/\sqrt{1+b^2}}_{-\infty}\frac{1}{\sqrt{1 - \rho^2}}\phi(z_2)\phi\bigg[\frac{z_1-\rho z_2}{\sqrt{1-\rho^2}}\bigg]dz_1dz_2\\
&=\int^{\Phi^{-1}(c)}_{-\infty}\int^{a/\sqrt{1+b^2}}_{-\infty}\phi(z_1, z_2; \rho)dz_1dz_2\\
\phi(z_1, z_2; \rho) &= \frac{1}{2\pi\sqrt{1-\rho^2}}\exp\bigg(-\frac{z_1^2 - 2\rho z_1z_2+z_2^2}{2(1-\rho^2)}\bigg)
\end{align*}
$$

このように相関係数 $\rho$ のbivariate Gaussian probability density functionの積分値で計算できることがわかります.






## References

> Paper

- [M. L. Thompson, W. Zucchini, On the statistical analysis of ROC curves, Statistics in Medicine, 1989.](https://onlinelibrary.wiley.com/doi/10.1002/sim.4780081011)

> 関連ポスト

- [Ryo's Tech Blog > 機械学習モデル精度の評価](https://ryonakagami.github.io/2022/02/02/model-evaluation-01/)

> R package

- [ROCit: An R Package for Performance Assessment of Binary Classifier with Visualization](https://cran.r-project.org/web/packages/ROCit/vignettes/my-vignette.html)
