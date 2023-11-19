---
layout: post
title: "確率変数の期待値と重心"
subtitle: "確率と数学ドリル 7/N"
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

- [離散型確率変数と重心](#%E9%9B%A2%E6%95%A3%E5%9E%8B%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%A8%E9%87%8D%E5%BF%83)
- [連続型確率変数と重心](#%E9%80%A3%E7%B6%9A%E5%9E%8B%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%A8%E9%87%8D%E5%BF%83)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 離散型確率変数と重心

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins> Problem</ins></p>

確率変数$X$は値$x_i$を確率$p_i$でとる離散型確率変数とする. 重さのない棒の中央を原点として,
右をプラス, 左をマイナスとして場所$x_i$のところに重さ$p_i$のおもりを吊り下げるとします. このとき, 期待値が重心であることを示せ.

</div>

重心はモーメントの釣り合いと考えることができるので右回りのモーメントが期待値周りで0になることを示せれば十分です.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\sum_{i}(x_i - \mathbb E[X])p_i &= \sum_{i}x_ip_i - \sum_{i}\mathbb E[X]p_i\\
                                &= \mathbb E[X] - \mathbb E[X] = 0
\end{align*}
$$
</div>

したがって, $\mathbb E[X]$は棒の重心といえる.

## 連続型確率変数と重心

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins> Problem</ins></p>

確率変数$X$は密度関数$f(x)$をもつ連続確率変数とする. 重さのある棒が与えられ, その中央を原点とし右をプラス, 左をマイナスとします.
また, 座標$x$のところの棒の断面積を$f(x)$としたとき, この棒の重心が$\mathbb E[X]$となることをしめせ.

</div>

離散型と同じように, $x$座標における右回りのモーメントは$(x - \text{重心})f(x)$に比例するので, 右回りのモーメントが期待値周りで0になることを示せれば十分です

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int (x - \mathbb E[X])f(x)dx &= \int xf(x)dx - \mathbb E[X]\int f(x)dx\\
                              &= \mathbb E[X] - \mathbb E[X] = 0
\end{align*}
$$
</div>

したがって, 連続型確率変数において$f(x)$を断面積とする棒の重心は$\mathbb E[X]$といえる.