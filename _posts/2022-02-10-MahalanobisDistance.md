---
layout: post
title: "Mahalanobis Distance"
subtitle: "意思決定とモデル精度の橋渡し 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-03-03
tags:

- 統計
- Metrics
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Mahalanobis Distanceとは？](#mahalanobis-distance%E3%81%A8%E3%81%AF)
  - [Euclidian distanceとの関係](#euclidian-distance%E3%81%A8%E3%81%AE%E9%96%A2%E4%BF%82)
  - [Euclidian distanceの問題点](#euclidian-distance%E3%81%AE%E5%95%8F%E9%A1%8C%E7%82%B9)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Mahalanobis Distanceとは？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Mahalanobis Distance</ins></p>

$$
\pmb x_i \equiv (x_{1i}, x_{2i}, x_{3i}) \forall i \in (1, \cdots, N)
$$

と各観測対象 $i$ について確率変数ベクトルが観察されたとしまう. このとき, Maharalanobis Distance (MD) は以下のように定義される:

$$
\begin{align*}
MD =& \sqrt{(\pmb x_i - \bar{\pmb x})\pmb V^{-1}(\pmb x_i - \bar{\pmb x})^T}\\
\text{where } \  \ & \bar{\pmb x} \text{ : the vector of mean values of independent variables}\\
                   & \pmb V \text{ : the covariance matrix of independent variables}
\end{align*}
$$

</div>

### Euclidian distanceとの関係

$$
ED = \sqrt{(\pmb x_i - \bar{\pmb x})(\pmb x_i - \bar{\pmb x})^T}
$$

Euclidian distance (ED)は上記のように表されるので, $\pmb V = I_k$のときMDとEDは一致することが定義からわかります.
このことは, EDがすべての変数のウェイトを等しくした上で平均からの距離を計算している一方, 
MDは変数の分散や共分散を踏まえた上で平均からの距離を計算していることを示しています.

### Euclidian distanceの問題点

> (1) 距離がスケールに依存する


> (2) 変数間の相関関係を考慮した距離にならない




## References

> 関連ポスト

- [Ryo's Tech Blog > 機械学習モデル精度の評価](https://ryonakagami.github.io/2022/02/02/model-evaluation-01/)
