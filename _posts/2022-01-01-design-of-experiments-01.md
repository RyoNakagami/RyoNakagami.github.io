---
layout: post
title: "分散分析の考え方"
subtitle: "Design of Experiments 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-08-13
tags:

- DoE
- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [分散分析の考え方](#%E5%88%86%E6%95%A3%E5%88%86%E6%9E%90%E3%81%AE%E8%80%83%E3%81%88%E6%96%B9)
  - [within-differenceとbetween-differenceへの分解](#within-difference%E3%81%A8between-difference%E3%81%B8%E3%81%AE%E5%88%86%E8%A7%A3)
  - [F検定の導入](#f%E6%A4%9C%E5%AE%9A%E3%81%AE%E5%B0%8E%E5%85%A5)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 分散分析の考え方

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 分散分析(Analysis of variance)</ins></p>

分散分析はデータ全体の変動を

- treatmentの差異にもどづく変動
- 実験誤差に基づく変動

に分解することによってデータを解析する統計手法のこと.

</div>

単純化のため反復数の等しい一元配置完全無作為化法実験のデータを以下のように考えます:

- $j$: treatmentのクラスを表すindex, $j \in \{1, \cdots, J\}$
- $i$: とあるtreatmentクラスの中で $i$ 番目に観測された値, $i \in \{1, \cdots, N\}$
- $y_{ij}$: $i$番目に観測された, 処置 $j$ クラスの観測値
- treatmentの付与の順番と観測順番は完全にランダムに実施されたとする

このとき, 以下のように総合計, 総平均, 処理別合計, 処理別平均を定義する:

$$
\begin{align*}
\text{処理別合計: } T_j &= \sum^N_{i=1} y_{ij} \\[8pt]
\text{処理別平均: } \bar y_j &= \frac{1}{N}\sum^N_{i=1} y_{ij} = \frac{T_j}{N} \\[8pt]
\text{総合計: } T &= \sum^J_{j=1}\sum^N_{i=1} y_{ij} \\[8pt]
\text{総平均: } \bar y &= \frac{1}{JN}\sum^J_{j=1}\sum^N_{i=1} y_{ij} = \frac{1}{J}\sum_{j=1}^J \bar y_j
\end{align*}
$$

### within-differenceとbetween-differenceへの分解

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>個々の観測値と総平均の差の分解</ins></p>

$$
y_{ij} - \bar y = (y_{ij} - \bar y_j) + (\bar y_j - \bar y)
$$

- treatment別平均と観測値の差(第一項)とtreatment平均と総平均との差(第二項)に分解できる

</div>

二乗誤差に着目すると, total sum of squaresは

$$
\begin{align*}
S_{total} &= \sum_j\sum_i (y_{ij} - \bar y)^2\\
    &= \sum_j\sum_i y_{ij}^2 - JN \bar y^2\\
    &= \sum_j\sum_i y_{ij}^2  - \frac{T^2}{JN} \tag{1} \\
\text{自由度: }v_{total} &= JN - 1
\end{align*}
$$

第一項についてのwithin-treatment sum of squaresは

$$
\begin{align*}
S_{within} &= \sum_j\sum_i (y_{ij} - \bar y_j)^2\\
    &= \sum_j\sum_i y_{ij}^2 - N \sum_{j}^J\bar y_j^2\\
    &= \sum_j\sum_i y_{ij}^2  - \frac{1}{N}\sum_j^J T_j^2 \tag{2}\\
\text{自由度: }v_{within} &= J(N-1)
\end{align*}
$$

第二項についてのbetween-treatment sum of squaresは

$$
\begin{align*}
S_{between} &= \sum_j\sum_i (\bar y_j - \bar y)^2\\
    &= N\sum_j \bar y_j^2  - NJ\bar y^2\\
    &= \frac{1}{N}\sum_j^J T_j^2 - \frac{T^2}{JN} \tag{3}\\
\text{自由度: }v_{between} &= J - 1
\end{align*}
$$

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>

したがって, (1), (2), (3)より

$$
\begin{align*}
S_{total} &= S_{within} + S_{between}\\
v_{total} &= v_{within} + v_{between}
\end{align*}
$$

</div>

### F検定の導入