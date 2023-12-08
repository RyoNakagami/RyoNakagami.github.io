---
layout: post
title: "Causality - an Introduction"
subtitle: "Memo on Causal Inference and Discovery in Python 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-08-09
tags:

- Python
- Econometrics

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Scope](#scope)
- [What is Causality?](#what-is-causality)
  - [同時分布とAssociation](#%E5%90%8C%E6%99%82%E5%88%86%E5%B8%83%E3%81%A8association)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Scope 

**Book**

---|---
Title|Causal Inference and Discovery in Python
Author|Aleksander Molak
版社 |Packt Publishing (2023/5/31)
発売日 |2023/5/31
言語 |英語
ペーパーバック |456ページ
ISBN-10 |1804612987
ISBN-13 |978-1804612989
Amazon URL|https://www.amazon.co.jp/-/en/Aleksander-Molak/dp/1804612987


**Contents on the note**

- causal approachを用いるモチベーション
- linear regression, grephs, and causal modelsの繋がり

## What is Causality?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: David Hume's theory of causality</ins></p>

- AとBという２つの事象があるとき, 人間が観察できるのはあくまでAがBの前に発生したという関係性のみ
- 上記の関係性が十分な回数観察されたとき, 人間はAが発生したならばBがその後発生するという期待を形成する
- この期待が人間が知覚するcausality(=因果関係). これはあくまで人間の知覚に基づくものであって, 世界の成り立ちを規律する法則自体ではない

</div>

ヒュームの提唱する因果関係は今の言葉でいうならば「人間は**association**によって物事を学習し, その学習した法則自体はassociationであってcausalityではない」という世界観に近いです.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Counterfactuals</ins></p>

- 1, 2個の変数の値を変え, かつその他の変数を固定したとき(=holding evrything else constant)における結果変数の推定値をCounterfactualsという
- 推定という言葉からもわかるように基本的には直接は観察できない

</div>

もしxxxをやっていたならば結果変数はどのような値になっていただろうか？というQuestionに答える際にCounterfactualsはよく使用されます. 

### 同時分布とAssociation

とあるECサイトのとある断面での会員全体について, 商品Aを購入したことのある人の割合は30%だが, 
商品Bを購入したことのある人に限って商品Aを購入したことのある人の割合を見たところ70%だったとします.

各会員が「商品Aを購入したことのある人」グループに所属する確率についてナイーブに数式で表現すると

$$
\begin{align*}
&Pr(\text{商品Aを購入したことのある人}) = 0.3\\
&Pr(\text{商品Aを購入したことのある人}|\text{商品Bを購入したことのある人}) = 0.7
\end{align*}
$$

商品Aと商品Bの親和性が高そうに思えるが, 上記の情報だけでは親和性が高いくらいしか言えず, 商品Aを購入すると商品Bを購入する or vice versaといった因果関係については何も言えません. あくまでここで見える関係性については**non-causal association**にとどまります.
