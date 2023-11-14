---
layout: post
title: "円卓テーブルの座り方問題"
subtitle: "組合せ論シリーズ 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
doctoc: false
last_modified_at: 2023-04-03
tags:

- math
---

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem </ins></p>

円形のテーブルに25人の男子と25人の女子が座っている. このとき, 隣りに座っている人が両方共女子であるような人が少なくとも
1人は存在することを示せ

</div>

**証明**

背理法を用いて証明する.
隣りに座っている人が両方共女子である人が１人もいない並び方があると仮定し, その並び方を

<p style="text-align: center;">

$$
(a_1, a_2, \cdots, a_{50})
$$

</p>

と表現されるとする. なお, $a_1$ と $a_{50} $は隣り合っているとする.
ここから, indexが偶数と奇数のグループにそれぞれ分けて, 以下のような２つのグループを考える:

<p style="text-align: center;">
$$
\begin{align*}
\text{Group A: }&(a_2, a_4, \cdots, a_{50})\\
\text{Group B: }&(a_1, a_3, \cdots, a_{49})
\end{align*}
$$
</p>

仮定より, `F`を女子, `M`を男子としたとき, `FMF`という並び方が存在しないので, 
Group A, Group Bともに女子が隣り合ってならんでいるパターンは存在しない.

つまり, Group Aに属する女子とGroup Bに属する女子の人数はそれぞれ12人以下となる.
すると, Group A と Group Bを合わせた女子の人数は24人以下となるが, 問題設定より女子は25人存在する.

従って, 矛盾が発生する = 仮定が間違っている, ので隣りに座っている人が両方共女子であるような人が少なくとも
1人は存在する.

**証明終了**


## References

- [数学オリンピックへの道 1 組合せ論の精選102問](https://www.asakura.co.jp/detail.php?book_code=11807)
