---
layout: post
title: "握手会における社交的な人数の最大値問題"
subtitle: "組合せ論 3/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-16
header-mask: 0.0
header-style: text
tags:

- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [AHSME 1978](#ahsme-1978)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## AHSME 1978

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$N = \{x \vert x \in \mathbb Z, x \geq 3\}$と定義する. ある部屋に$N$人の人がいる. この部屋の自分を除くすべての人と握手したことある人を社交的な人, そうでない人を社交的ではない人と呼ぶことにする. 社交的でない人が少なくとも1人いるとき, 社交的な人の人数として考えられる最大値はいくつか？

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

部屋にいる人をそれぞれ$a_1, a_2, \cdots, a_n$とする. この内, 社交的でない人を一般性を失うことなく$a_1$とすると, 少なくとも$a_1$はだれかと握手しておらずその人を$a_2$とする. このとき, $a_2$も社交的でない人となるので, 社交的な人は高々 $N- 2$人となる. 

従って, 最大値は$N- 2$人.

</div>
