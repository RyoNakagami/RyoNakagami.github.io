---
layout: post
title: "エアコンの仕組み"
subtitle: "身近なテクノロジーを知ろう 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-08-16
tags:

- technology

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [エアコンの仕組み](#%E3%82%A8%E3%82%A2%E3%82%B3%E3%83%B3%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [エアコンによるエネルギーの巡回](#%E3%82%A8%E3%82%A2%E3%82%B3%E3%83%B3%E3%81%AB%E3%82%88%E3%82%8B%E3%82%A8%E3%83%8D%E3%83%AB%E3%82%AE%E3%83%BC%E3%81%AE%E5%B7%A1%E5%9B%9E)
  - [ヒートポンプの効率性: COP, Coefficient Of Performance](#%E3%83%92%E3%83%BC%E3%83%88%E3%83%9D%E3%83%B3%E3%83%97%E3%81%AE%E5%8A%B9%E7%8E%87%E6%80%A7-cop-coefficient-of-performance)
- [冷暖房能力](#%E5%86%B7%E6%9A%96%E6%88%BF%E8%83%BD%E5%8A%9B)
  - [冷暖房能力から必要冷媒質量流量の導出](#%E5%86%B7%E6%9A%96%E6%88%BF%E8%83%BD%E5%8A%9B%E3%81%8B%E3%82%89%E5%BF%85%E8%A6%81%E5%86%B7%E5%AA%92%E8%B3%AA%E9%87%8F%E6%B5%81%E9%87%8F%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [圧縮機の仕様: $W$の導出](#%E5%9C%A7%E7%B8%AE%E6%A9%9F%E3%81%AE%E4%BB%95%E6%A7%98-w%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Appendix: 冷媒R410Aの物性値](#appendix-%E5%86%B7%E5%AA%92r410a%E3%81%AE%E7%89%A9%E6%80%A7%E5%80%A4)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## エアコンの仕組み

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>エアコンによる室温調整</ins></p>

物質が相変化するときに起こる「吸熱現象」と「発熱現象」を用いて, エアコンは温度のコントロールをしている

</div>

下の図のようにRA（ルームエアコン）は, 室外機と室内機が行きと帰りの2本のパイプでつながっています. 
これらパイプの内部には「**冷媒**」と呼ばれる流体が注入されており, この冷媒が室外機と室内機を循環しながら, 「**相変化**」（液体→気体→液体）することにより, エアコンとしての機能(=温度のコントロール)を実現しています.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/technology/2023-04-05-airconditioner.jpg?raw=true">

冷媒の巡回を担当しているのがヒートポンプです. **熱機関では高温の熱源から低温の熱源に向かってエネルギーの移動が起こりますが**, 低温の熱源から高温の熱源に向かってエネルギーを移動を実現する機構がヒートポンプとなります.

ヒートポンプは空気中の熱をポンプのように汲み上げて必要な場所に「移動させる」技術のことです.
ヒートポンプを実現させる機器として圧縮機, 膨張弁, 熱交換器があります.





### エアコンによるエネルギーの巡回

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>エアコンの主要コンポーネント</ins></p>

---|---
圧縮機|圧縮機は冷媒を圧縮高温にし巡回させる機器<br>振動や騒音が著しいので室外機の中にある<br>エアコンの消費電力の８割を占める
凝縮器|気体となった冷媒が液体に変化することで, 熱を放出する機器
膨張弁|冷媒を狭い隙間に通すことで低温低圧にする機器<br>室外機の中にある
蒸発器|液体となった冷媒が気体に変化することで, 熱を吸収する機器


</div>

1. 膨張弁で減圧された冷媒は蒸発器で相対的に温度の高い空気により蒸発（液相→気相）
2. 圧縮機で高圧にされ, 凝縮器で相対的に温度の低い空気により凝縮する（気相→液相）
3. 蒸発器では気化熱による吸熱, 凝縮器では凝縮熱による排熱

エアコンはこの仕組みをつかって, 暖房/冷房といった運転モードに合わせて室温をコントロールしています.
排熱と吸熱は室内機/室内機の内部にある熱交換器（内熱交と外熱交）を介して行われています.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/technology//2023-04-05-how-energy-move.jpg?raw=true">

### ヒートポンプの効率性: COP, Coefficient Of Performance

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/technology/2023-04-05-heat-pump.jpg?raw=true">

ヒートポンプは低温の熱源から$Q_{low}$のエネルギーを吸収し, 外部から$W$の仕事を受けてヒートポンプが作動し, $Q_{high}$の熱源を高温側に排出します. このとき, 以下の等式が成り立ちます

$$
W = |Q_{high}| - |Q_{low}|
$$

ヒートポンプの効率はCOPという指標で表されます. 

$$
\begin{align*}
COP = \frac{|Q_{high}|}{W} & \  \ \text{ where 暖房時}\\
COP = \frac{|Q_{low}|}{W} & \  \ \text{ where 冷房時}
\end{align*}
$$

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: ワットとジュールの関係</ins></p>

- ジュール, $J$: エネルギーそのものの大きさ
- ワット, $W$: 1秒間毎に発生・消費するエネルギーの大きさ, $J/s$と同じ

</div>



## 冷暖房能力

所定の時間で部屋の温度が所定の温度になるために必要な冷暖房能力を$A$とすると以下の形で表現できる

まず, 部屋の各辺から対象となる体積 $V_r$について

$$
\begin{align*}
V_r = \text{length}_r \times \text{width}_r \times \text{height}_r [m^3]
\end{align*}
$$

ここで, 時間 $d [min]$ あたりで部屋の空気を維持準させるために必要な秒単位風量 $f_r$は

$$
f_r = \frac{V_r}{60\times d} [m^3/s]
$$

時間 $d [min]$で温調到達するエアコンに求められる冷暖房能力を$A [W]$は

$$
A = f_r \times \rho \times c_p \times \Delta T
$$

- $\rho$: 空気密度$kg/m^3$
- $c_p$: 空気比熱$J/kg\cdot K$
- $\Delta T$: 変化させたい温度差 $[K]$



### 冷暖房能力から必要冷媒質量流量の導出

冷暖房に必要な比エンタルピーを$\Delta h [J/kg]$, 必要な冷媒質量流量を$G[kg/s]$とすると, 

$$
A = \Delta h \times G
$$

エンタルピーとは空気が持つ熱量のことで単位質量あたりのエンタルピーを比エンタルピーといいます. 比エンタルピーは冷媒の種類のよって固定されるので, 必要冷媒質量流量$G$は冷暖房能力がわかれば導出することができます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: エンタルピー</ins></p>

$$
H = U + P \times V
$$

- H: エンタルピー
- U: 内部エネルギー $[J]$
- P: 圧力 $[Pa]$
- V: 体積 $m^3$


</div>

### 圧縮機の仕様: $W$の導出

圧縮機を通過する流量 $v [m^3/s]$は, 通過するガスの比容積 $\gamma [m^3/kg]$, 圧縮機の吸い込み容積 $V_c [m^3]$, 圧縮機の回転周期 $T_c [s]$より

$$
\begin{align*}
v &= G \times \gamma\\
v &= \frac{V_c}{T_c}
\end{align*}
$$

以上より, 冷暖房能力から必要な圧縮機の吸い込み容積/回転数比率が導出される.
次にここから $W$ の導出をする

凝縮器と蒸発器に対応する低圧側温度 $p_{low}$と高圧側温度 $p_{high}$とすると
$W$ は次のように表される

$$
W \propto V_c \times (p_{high} - p_{low})
$$




## Appendix: 冷媒R410Aの物性値

|温度<br>℃|蒸気圧<br>Pa|液相密度<br>$kg/m^3$|液相定圧比熱<br>$J/kg\cdot K$|気化熱<br>$J/kg$|気相密度<br>$kg/m^3$|気相定圧密度<br>$J/kg\cdot K$|
|---|-----|-------|----------|-----|-------|---------|
|$-20$|$1.088\times 10^6$|$1128$|$1.579\times 10^3$|$2.132\times10^5$|$41.18$|$1.246\times10^3$|
|$0$|$1.889\times 10^6$|$1033$|$1.679\times 10^3$|$1.820\times10^5$|$75.31$|$1.561\times10^3$|
|$20$|$3.071\times 10^6$|$906.8$|$2.256\times 10^3$|$1.389\times10^5$|$139.2$|$2.415\times10^3$|
|$40$|$4.765\times 10^6$|$620.5$|$2.452\times 10^3$|$4.548\times10^4$|$343.2$|$2.751\times10^4$|






References
----

- [Monoist > エアコンのモデリング（その1） ～エアコンの作動原理を理解する～](https://monoist.itmedia.co.jp/mn/articles/2306/12/news030.html)
- [Monoist > エアコンのモデリング（その2） ～エアコンの作動原理を理解する～](https://monoist.itmedia.co.jp/mn/articles/2307/19/news003.html)