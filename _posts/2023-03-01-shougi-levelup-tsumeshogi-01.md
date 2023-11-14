---
layout: post
title: "馬の利きを通す"
subtitle: "実践詰将棋練習 居飛車編 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-03-01
tags:

- 将棋
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [居飛車系第１問:馬の利きを通す](#%E5%B1%85%E9%A3%9B%E8%BB%8A%E7%B3%BB%E7%AC%AC%EF%BC%91%E5%95%8F%E9%A6%AC%E3%81%AE%E5%88%A9%E3%81%8D%E3%82%92%E9%80%9A%E3%81%99)
  - [同金パターン](#%E5%90%8C%E9%87%91%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
  - [王逃げパターン](#%E7%8E%8B%E9%80%83%E3%81%92%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
- [居飛車系発展問題その１:馬の利きを通す](#%E5%B1%85%E9%A3%9B%E8%BB%8A%E7%B3%BB%E7%99%BA%E5%B1%95%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE%EF%BC%91%E9%A6%AC%E3%81%AE%E5%88%A9%E3%81%8D%E3%82%92%E9%80%9A%E3%81%99)
- [居飛車系発展問題その２:馬の利きを通す](#%E5%B1%85%E9%A3%9B%E8%BB%8A%E7%B3%BB%E7%99%BA%E5%B1%95%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE%EF%BC%92%E9%A6%AC%E3%81%AE%E5%88%A9%E3%81%8D%E3%82%92%E9%80%9A%E3%81%99)
  - [局面](#%E5%B1%80%E9%9D%A2)
  - [５四同玉パターン](#%EF%BC%95%E5%9B%9B%E5%90%8C%E7%8E%89%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
  - [金で左上に追い詰めるパターン](#%E9%87%91%E3%81%A7%E5%B7%A6%E4%B8%8A%E3%81%AB%E8%BF%BD%E3%81%84%E8%A9%B0%E3%82%81%E3%82%8B%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
  - [中央で仕留めたいパターン](#%E4%B8%AD%E5%A4%AE%E3%81%A7%E4%BB%95%E7%95%99%E3%82%81%E3%81%9F%E3%81%84%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
- [居飛車系第２問:４筋に逃さない](#%E5%B1%85%E9%A3%9B%E8%BB%8A%E7%B3%BB%E7%AC%AC%EF%BC%92%E5%95%8F%EF%BC%94%E7%AD%8B%E3%81%AB%E9%80%83%E3%81%95%E3%81%AA%E3%81%84)
- [居飛車系第６問](#%E5%B1%85%E9%A3%9B%E8%BB%8A%E7%B3%BB%E7%AC%AC%EF%BC%96%E5%95%8F)
  - [玉が正しく逃げたパターン](#%E7%8E%89%E3%81%8C%E6%AD%A3%E3%81%97%E3%81%8F%E9%80%83%E3%81%92%E3%81%9F%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
  - [３二同玉で即詰みが発生するパターン](#%EF%BC%93%E4%BA%8C%E5%90%8C%E7%8E%89%E3%81%A7%E5%8D%B3%E8%A9%B0%E3%81%BF%E3%81%8C%E7%99%BA%E7%94%9F%E3%81%99%E3%82%8B%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
- [居飛車系第６問改題：飛金銀のパターン](#%E5%B1%85%E9%A3%9B%E8%BB%8A%E7%B3%BB%E7%AC%AC%EF%BC%96%E5%95%8F%E6%94%B9%E9%A1%8C%E9%A3%9B%E9%87%91%E9%8A%80%E3%81%AE%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
  - [同金で対処してきた場合](#%E5%90%8C%E9%87%91%E3%81%A7%E5%AF%BE%E5%87%A6%E3%81%97%E3%81%A6%E3%81%8D%E3%81%9F%E5%A0%B4%E5%90%88)
  - [相手玉が早逃げを試みた時](#%E7%9B%B8%E6%89%8B%E7%8E%89%E3%81%8C%E6%97%A9%E9%80%83%E3%81%92%E3%82%92%E8%A9%A6%E3%81%BF%E3%81%9F%E6%99%82)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 居飛車系第１問:馬の利きを通す

### 同金パターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_A.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

### 王逃げパターン

> ６一玉へ逃げた場合

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_B.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> ４一玉へ逃げた場合

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_C.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

## 居飛車系発展問題その１:馬の利きを通す

> 合駒 & ４三玉逃げパターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_01_A.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> 合駒 & ３二玉逃げパターン 

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_01_B.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> ４三玉へ逃げた場合

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_01_C.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

## 居飛車系発展問題その２:馬の利きを通す
### 局面

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_02.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

### ５四同玉パターン

- これは後手としてやってはいけないパターン
- ３手詰みとなってしまう

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_02_A.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

### 金で左上に追い詰めるパターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_02_B.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

### 中央で仕留めたいパターン

- 先手８六飛打に対して６五玉と逃げてしまうと, 先手に金があるので即詰みしてしまうので７五に逃げるしかない

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_01_02_C.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>


## 居飛車系第２問:４筋に逃さない

> 4筋逃げるパターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_02_A.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> 上がってくるパターン

- 個のパターンが考えられるため初手は４二角(00)となる

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_02_B.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

> 相手自滅パターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_02_C.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>


## 居飛車系第６問
### 玉が正しく逃げたパターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_06_A.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

### ３二同玉で即詰みが発生するパターン

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_06_B.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

## 居飛車系第６問改題：飛金銀のパターン
### 同金で対処してきた場合

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_06_01_A.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

### 相手玉が早逃げを試みた時

<div class="math display" style="overflow: auto">
<iframe width="500" height="600" src="https://nbviewer.org/github/RyoNakagami/ryonak_kifPlayer/blob/main/kif_html/myoshu_zokusyu_levelup_01_06_01_B.html" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>

## References

- [妙手に俗手、駒余り、持駒制限もあり！実戦詰め筋事典 レベルアップ編](https://book.mynavi.jp/ec/products/detail/id=112475)