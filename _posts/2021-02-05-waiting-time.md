---
layout: post
title: "信号と待ち時間について"
subtitle: "確率と数学ドリル 11/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-16
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

- [１つの信号における待ち時間の確率](#%EF%BC%91%E3%81%A4%E3%81%AE%E4%BF%A1%E5%8F%B7%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E5%BE%85%E3%81%A1%E6%99%82%E9%96%93%E3%81%AE%E7%A2%BA%E7%8E%87)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## １つの信号における待ち時間の確率

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

自宅から駅に行く途中に横断歩道が一つある. ここの信号について以下の情報がわかっている

- 青信号1分
- 赤信号2分
- 信号の切り替わりタイミングは全くわからない

「信号の切り替わりタイミングは全くわからない」ので, 信号の３分サイクルのどのタイミングで信号の場所にたどり着くかは
一旦は一様分布に従うとする. このとき,

1. $r$分以上待つ確率
2. $0 \leq a < b \leq 2$について, $a$分から$b$分まつ確率
3. 待ち時間の期待値と分散

を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(1) $r$分以上待つ確率</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

「**信号の３分サイクルのどのタイミングで信号の場所にたどり着くかは一旦は一様分布に従う**」としているので,

- 待たないで信号を渡る確率は $1/3$
- $r > 0$分待つのは$2/3$の確率で$Unif(0, 2)$に従う確率変数

従って, $0 < r < 2$のとき, $r$分以上待つ確率は待ち時間についての確率変数を$X$とすると

$$
\begin{align*}
\Pr(X\geq r) &= \Pr(\text{待ち時間発生}) \times \Pr(X\geq r |\vert \text{待ち時間発生})\\[3pt]
             &= \frac{2}{3}\times \frac{2 - r}{2}\\[3pt]
             &= \frac{2 - r}{3}
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(2) $0 \leq a < b \leq 2$について, $a$分から$b$分まつ確率</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

(1)の答えより, $0 < a < b \leq 2$のときは

$$
\begin{align*}
\Pr(a \leq X \leq b) &= \Pr(X \leq b) - \Pr(X < a)\\
                     &= \bigg(1 - \frac{2 - b}{3}\bigg) - \bigg(1 - \frac{2 - a}{3}\bigg)\\
                     &= \frac{b-a}{3}
\end{align*}
$$

$0 = a <  b \leq 2$のときは, 待たずに渡る確率を考慮する必要があるので

$$
\begin{align*}
\Pr(X \leq b) &= \frac{1}{3} + \bigg(\frac{2}{3} - \frac{2 - b}{3}\bigg)\\[3pt]
              &= \frac{1+b}{3}
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(3) 待ち時間の期待値と分散</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X] &= \mathbb E[X\vert \text{待ち時間発生}]\Pr(\text{待ち時間発生}) + \mathbb E[X\vert \text{待ち時間not発生}]\Pr(\text{待ち時間not発生})\\
             &= 1 \times \frac{2}{3} + 0 \times 0\\
             &= \frac{2}{3}
\end{align*}
$$
</div>


分散は $V(X) = \mathbb E[X^2] - \mathbb E[X]^2$なので,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \mathbb E[X^2\vert \text{待ち時間発生}]\Pr(\text{待ち時間発生}) + \mathbb E[X^2\vert \text{待ち時間not発生}]\Pr(\text{待ち時間not発生})\\
             &= \frac{8}{3}
\end{align*}
$$
</div>

従って, 

$$
V(X) = \frac{20}{9}
$$

</div>

References
-------------

- [Ryo's Tech Blog > 半円周上に一様分布する点の高さの分布](https://ryonakagami.github.io/2021/02/04/uniform-on-circular-and-height-distribution/)
