---
layout: post
title: "後手番で序盤でなにを考えるか？"
subtitle: "角換わり戦法研究 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-03-13
tags:

- 将棋
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [相手の戦型を見定める](#%E7%9B%B8%E6%89%8B%E3%81%AE%E6%88%A6%E5%9E%8B%E3%82%92%E8%A6%8B%E5%AE%9A%E3%82%81%E3%82%8B)
- [早繰り銀の相手のミスをつく：先手のアンチパターン](#%E6%97%A9%E7%B9%B0%E3%82%8A%E9%8A%80%E3%81%AE%E7%9B%B8%E6%89%8B%E3%81%AE%E3%83%9F%E3%82%B9%E3%82%92%E3%81%A4%E3%81%8F%E5%85%88%E6%89%8B%E3%81%AE%E3%82%A2%E3%83%B3%E3%83%81%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
- [先手のミスをついて相手玉を詰む](#%E5%85%88%E6%89%8B%E3%81%AE%E3%83%9F%E3%82%B9%E3%82%92%E3%81%A4%E3%81%84%E3%81%A6%E7%9B%B8%E6%89%8B%E7%8E%89%E3%82%92%E8%A9%B0%E3%82%80)
  - [飛車ぶっちで詰む](#%E9%A3%9B%E8%BB%8A%E3%81%B6%E3%81%A3%E3%81%A1%E3%81%A7%E8%A9%B0%E3%82%80)
    - [７七玉で逃げたパターン](#%EF%BC%97%E4%B8%83%E7%8E%89%E3%81%A7%E9%80%83%E3%81%92%E3%81%9F%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
    - [飛車ぶっちに同玉出来た場合（正統派）](#%E9%A3%9B%E8%BB%8A%E3%81%B6%E3%81%A3%E3%81%A1%E3%81%AB%E5%90%8C%E7%8E%89%E5%87%BA%E6%9D%A5%E3%81%9F%E5%A0%B4%E5%90%88%E6%AD%A3%E7%B5%B1%E6%B4%BE)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 相手の戦型を見定める

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_001.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 1: 最初の４手で考えるべきこと </ins></p>

- 相手先手で, 初手７六歩
- 自分は８四歩と居飛車を宣言
- その後相手も居飛車を宣言してきたので、こちらは様子見で３二金と指した場面

この時、相手の戦型を見定めるにあたってどのようなパターンを想定すべきか？

</div>

> 想定解

---|---
矢倉銀|▲６八銀 → △８五歩 → ▲７七銀
相掛かり|相手が飛車先を伸ばしてきた場合
角換わり|▲７七角の場合は, 角換わりっぽい. その後は相手の４八銀の出方を見る

なお,「**角換わり**」をこちらが採用したとき, 相手の４八銀の上がりが早い(=▲３七銀を早いタイミングで指してくる)
場合は「**早繰り銀**」と見て良い. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem 2</ins></p>

相手は居飛車, こちらが「角換わり」を採用した時, 相手の何をみるべきか？

</div>

> 想定解

相手が以下のうちどのような銀の使い方をしてくるか考える

- 早繰り銀（さっそうと飛車先の突破を狙う）
- 棒銀
- 腰掛け銀（じっくり）

相手の右の銀の使い方によって, こちらの角換わりの戦い方が変わってきます. 早繰り銀で来たならば「**腰掛け銀**」でこちらは対応すれば良いと思います.
いずれにしても, 「**歩越し銀には歩で対抗**」という筋は使えるので覚えておきます.

## 早繰り銀の相手のミスをつく：先手のアンチパターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_002.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

上記のように先手早繰り銀でやってきた場合, 後手のおすすめは様子見として８五歩となります.
このとき, 先手が３五歩と３筋の歩を狙ってきた場合, 上記のように △同歩 → ▲同銀 に対して「△８五歩からの△８八歩からの△５五角」と狙えるからです.

この時, まだ金が上がっていないので, 先手は対応せざる得なくなり, 同銀で対処しても同歩と対処しても△５五角を防ぐことは困難になります.
自分が先手番ならば▲７八金 or ▲７八玉 で備える事が有力です.

> △８五歩のメリット

- 相手の６七角からの馬成を消すことができる

## 先手のミスをついて相手玉を詰む

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_003.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

後手手番で△９八飛成と寄せにいったとき, 先手が誤って▲８八歩打と受けてきたとします. このときの詰み筋を考えたいと思います.

### 飛車ぶっちで詰む

ここでの詰み方はパワータイプです

#### ７七玉で逃げたパターン

> パターン 1

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_004.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> パターン 2

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_005.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

#### 飛車ぶっちに同玉出来た場合（正統派）

> 叩きの歩に対して下がった場合

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_006.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> 叩きの歩に対して同玉で上がってきた場合

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_007.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> 叩きの歩に対して端で上がってきた場合

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/kakugawari/20230313_kakugawari_joban_008.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

## References

> Youtube

- [将棋放浪記 > 「角換わり」の定跡と細かいカラクリを徹底解説します](https://www.youtube.com/watch?v=EveEnfc-Jv8)
