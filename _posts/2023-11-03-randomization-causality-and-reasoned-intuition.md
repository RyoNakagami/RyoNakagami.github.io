---
layout: post
title: "論文紹介: Basu 2014, Randomisation, Causality and the Role of Reasoned Intuition"
subtitle: "RCT分析におけるReasoningやIntuitionの重要性"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: true
last_modified_at: 2023-11-05
tags:

- 統計
- 論文

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題意識](#%E5%95%8F%E9%A1%8C%E6%84%8F%E8%AD%98)
- [RCT分析結果が意思決定にそのままつかえるのか？](#rct%E5%88%86%E6%9E%90%E7%B5%90%E6%9E%9C%E3%81%8C%E6%84%8F%E6%80%9D%E6%B1%BA%E5%AE%9A%E3%81%AB%E3%81%9D%E3%81%AE%E3%81%BE%E3%81%BE%E3%81%A4%E3%81%8B%E3%81%88%E3%82%8B%E3%81%AE%E3%81%8B)
- [RCTで主張可能なcausalityの範囲](#rct%E3%81%A7%E4%B8%BB%E5%BC%B5%E5%8F%AF%E8%83%BD%E3%81%AAcausality%E3%81%AE%E7%AF%84%E5%9B%B2)
- [分析結果から意思決定へ](#%E5%88%86%E6%9E%90%E7%B5%90%E6%9E%9C%E3%81%8B%E3%82%89%E6%84%8F%E6%80%9D%E6%B1%BA%E5%AE%9A%E3%81%B8)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 問題意識

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>著者の問題意識</ins></p>

- 経済学や政策立案の分野において, causalityのメカニズムを明らかにすることは有用であり, それらを明らかにする手法としてRCTはgolden standardである
- ただし, RCTが明らかにする因果とはいわゆる"universal causality"ではなく, 状況的な因果関係(="circumstantial causality")であることに留意が必要
- circumstantial causalityから政策立案などのアクションへつなげるには, 分析を解釈するという工程が必要である 

</div>


「**circumstantial causalityから政策立案などのアクションへつなげるには, 分析を解釈するという工程が必要である**」という考えに基づいて, 
この論文では

- RCTの結果をuniversal causalityと判断してしまうとどのような問題が発生しうるのか？
- RCTの結果をどのように解釈すべきなのか？

を紹介しています.

## RCT分析結果が意思決定にそのままつかえるのか？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Statement</ins></p>

仮にあなたが所属する母集団に対して, なにかしらのアクションの有効性を検証するRCTが適切な形で実施されていたとしても, 
その分析結果を根拠として, 「そのアクションの有効性があなたに適応される」という主張を信じる理由にはならない.

</div>

例として, ある科学者が以下のような効果を持つ薬を開発したとします:

- 記憶力が10%改善される
- 副作用はなんもない

この薬を日本のマーケットで売りたい考えた科学者はその薬の有効性を検証するため, 日本国民を対象にランダムにくじでtreatedとuntreatedを選んで適切に分析し, 
平均的に記憶力が10%改善 & どんな指標でみても平均的に副作用は確認されなかったという結果が得られたとします.

この結果を見た上で, 仮に自分が日本国民の10代の高校生だったとして, 記憶力改善させたいとおもっているからこの分析結果を信じて服薬するかどうか？という問題を考えたとき,
その判断は一筋縄では行きません.

薬の効果に関してわかっていることは「**平均的に記憶力が10%改善 & どんな指標でみても平均的に副作用は確認されなかった**」ということだけで, 細かく考えてみると

- constant treatment effectならば服薬してもいいかも
- heterogeneous treatment effectがあるならばCATEが知った上で判断したい

という意思決定の分岐があり得ます. 前者ならば, 時期の問題などあるかもしれませんが一旦はそのリスクは取れるとして, 
後者の場合で

- 後期高齢者の記憶力が凄まじく改善 but 10代には効果がない
- 副作用は全体的には確認されなかったが, 10代だけに絞って検証すると精神不安定になるかもしれない

というメカニズムがあったあった場合, 「**確かに自分は日本国民という母集団に属している & その母集団を対象にしたRCTで有効性が確認されたとしても, 直ちに服薬したほうが良いとは考えられない**」
という主張は十分理解できます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS</ins></p>

上記の例はtreatement effectのheterogeneityの存在や科学者と高校生の意思決定問題における母集団のズレという観点で理解することもできる

</div>

## RCTで主張可能なcausalityの範囲

RCT分析結果を意思決定に用いるためには, 

- そもそもRCTで主張可能な範囲はなにか？
- 直接的にはあくまで「状況証拠的な因果関係(= circumstantial causality)」である

ということを確認する必要があります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>circumstantial causality</ins></p>

state of the worldを表す変数 $X$, Outcome $Y$, action変数 $D = \{0, 1\}$ が与えられたとする.

$X$の条件のもと, $D=0$から$D=1$への変化がOutcome $Y$の変化が予測可能な変化を導く場合, 
「**circumstantial causality**」が存在するという

</div>

state of the worldを表す変数 $X$は基本的には部分的にしか観測できないので, RCTの主張は基本的には

```
RCT discoveries never graduate from something “was a cause” of something else to something “is a cause”.
```

にとどまることに留意が必要と論文では主張しています. 過去のRCTの分析結果を将来も成立し得ると考える際には, 
state variable(すくなくとも因果メカニズムを踏まえた上で関連するstate variableの集合)が将来のある時点でも成立するはずという信念が必要になります.

## 分析結果から意思決定へ

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Intuition and Evidence</ins></p>

- 分析結果をアクションにつなげるにあたって, RCTのexternal validityについて科学的に検証する手法がない現状において, 結局の所, Intuition, common senseというものに依拠しなくてはらならない
- Intuitionやcommon senseと結びついた分析結果がわれわれに知識を与えてくれる.
- ただし, Intuitionやcommon senseというのは厳密な定義がないので, TheoryにもとづいたIntuitionであるのかどうかという検証も必要

</div>

なお, Intuitionやcommon senseというものを合致するかどうかという観点で分析を解釈する必要がある一方, 注意しなくてはならいないことは
そもそもIntuitionやcommon sense自体が正しいのかということです. 

極端な例ですが, もし政策Xがある結果Rを達成する可能性があるかどうかを調査する場合, common senseと照らし合わせて
過去にYの結果としてRが達成されたことを示すだけで, Xが機能しないと結論するのは不十分です. 
この場合は, Xが過去に試されたかどうかを確認し, その後推論を行うことが重要です. Xが過去に試されなかったためXがRを達成しなかった場合, 
Xの有効性/非有効性に関する証拠はどちらも存在しないと考えるべきとなります.




References
------------

- [Basu 2014. Randomisation, Causality and the Role of Reasoned Intuition](https://www.tandfonline.com/doi/full/10.1080/13600818.2014.961414)
