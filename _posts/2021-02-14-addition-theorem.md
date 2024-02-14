---
layout: post
title: "加法定理と積和の公式の図形的理解"
subtitle: "統計のための数学 5/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-16
header-mask: 0.0
header-style: text
tags:

- math
- フーリエ解析

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [加法定理の図形的理解](#%E5%8A%A0%E6%B3%95%E5%AE%9A%E7%90%86%E3%81%AE%E5%9B%B3%E5%BD%A2%E7%9A%84%E7%90%86%E8%A7%A3)
  - [各加法定理の証明](#%E5%90%84%E5%8A%A0%E6%B3%95%E5%AE%9A%E7%90%86%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [オイラーの公式から加法定理を導く](#%E3%82%AA%E3%82%A4%E3%83%A9%E3%83%BC%E3%81%AE%E5%85%AC%E5%BC%8F%E3%81%8B%E3%82%89%E5%8A%A0%E6%B3%95%E5%AE%9A%E7%90%86%E3%82%92%E5%B0%8E%E3%81%8F)
- [積和の公式の図形的理解](#%E7%A9%8D%E5%92%8C%E3%81%AE%E5%85%AC%E5%BC%8F%E3%81%AE%E5%9B%B3%E5%BD%A2%E7%9A%84%E7%90%86%E8%A7%A3)
- [チェビチェフの多項式](#%E3%83%81%E3%82%A7%E3%83%93%E3%83%81%E3%82%A7%E3%83%95%E3%81%AE%E5%A4%9A%E9%A0%85%E5%BC%8F)
- [練習問題](#%E7%B7%B4%E7%BF%92%E5%95%8F%E9%A1%8C)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 加法定理の図形的理解

三角関数の加法定理とは$\alpha, \beta$の線型結合で表現される三角関数を$\alpha$の三角関数と$\beta$の三角関数で表現できることを示すために利用されます. 150A.Dごろに活躍したプトレマイオスは加法定理を用いて0.5度刻みの弦の表を作成したと言われています.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 加法定理</ins></p>

$$
\begin{align*}
\sin(\alpha + \beta) &= \sin\alpha\cos\beta + \cos\alpha\sin\beta\\[3pt]
\cos(\alpha + \beta) &= \cos\alpha\cos\beta - \sin\alpha\sin\beta\\[3pt]
\tan{\alpha+\beta}   &= \frac{\tan\alpha + \tan\beta}{1 - \tan\alpha\tan\beta}
\end{align*}
$$

</div>

証明は単位円上に角度$\alpha, \alpha+\beta$となる点をとり以下のように図示するとわかります.

{% include geogebra/20210214_kahoteiri.html %}

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >$\sin(\alpha+\beta)$の証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

- 線分OBの長さはBが単位円上に位置するので長さOB $= 1$
- Bの$y座標$は定義より$\sin(\alpha+\beta)$
- OCの長さは$\cos\beta$
- BCの長さは$\sin\beta$
- OCの長さが$\cos\beta$なのでCE $= \sin\alpha\cos\beta$
- $\angle BCF = 180^\circ - 90^\circ - \angle OCE = \alpha$
- BCの長さは$\sin\beta$なのでCF $=\cos\alpha\sin\beta$

従って, 

$$
\sin(\alpha + \beta) = \sin\alpha\cos\beta + \cos\alpha\sin\beta
$$

**証明終了**

</div>

### 各加法定理の証明


<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >$\sin(\alpha-\beta)$の証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\sin(\alpha + \beta) = \sin\alpha\cos\beta + \cos\alpha\sin\beta
$$

が成立しているとする.

$$
\begin{align*}
\sin(-\beta) &= -\sin\beta\\
\cos(-\beta) &= \cos\beta
\end{align*}
$$

より

$$
\begin{align*}
\sin(\alpha -\beta) &= \sin(\alpha + (-\beta))\\
                    &= \sin\alpha\cos(-\beta) + \cos\alpha\sin(-\beta)\\
                    &= \sin\alpha\cos\beta - \cos\alpha\sin\beta
\end{align*}
$$

**証明終了**

</div>

---

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >$\cos(\alpha+\beta)$の加法定理の証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\cos\theta = \sin(\frac{\pi}{2}-\theta)
$$

を利用すると

$$
\begin{align*}
\cos(\alpha+\beta) &= \sin\bigg(\frac{\pi}{2} - \alpha - \beta\bigg)\\[3pt]
                   &= \sin\bigg(\frac{\pi}{2} - \alpha\bigg)\cos\beta - \cos\bigg(\frac{\pi}{2} - \alpha\bigg)\sin\beta\\[3pt]
                   &= \cos\alpha\cos\beta - \sin\alpha\sin\beta
\end{align*}
$$

</div>

---

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >$\tan(\alpha+\beta)$の加法定理の証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\tan(\alpha+\beta) &= \frac{\sin(\alpha+\beta)}{\cos(\alpha+\beta)}\\[3pt]
                   &= \frac{\sin\alpha\cos\beta + \cos\alpha\sin\beta}{\cos\alpha\cos\beta - \sin\alpha\sin\beta}\\[3pt]
                   &= \frac{\sin\alpha\cos\beta + \cos\alpha\sin\beta}{\cos\alpha\cos\beta - \sin\alpha\sin\beta}\times \frac{\cos\alpha\cos\beta}{\cos\alpha\cos\beta}\\[3pt]
                   &= \frac{\tan\alpha + \tan\beta}{1 - \tan\alpha\tan\beta}
\end{align*}
$$


</div>

### オイラーの公式から加法定理を導く

オイラーの公式は, 一見全く異なる挙動を示す三角関数と指数関数を結びつけるものです.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: Euler's formula</ins></p>

$$
e^{i\theta} = \cos\theta + i\sin\theta
$$

</div>

上記のオイラーの公式からも加法定理を導くことができます.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

オイラーの公式より

$$
e^{i(\alpha +\beta)} = \cos(\alpha +\beta) + i\sin(\alpha +\beta)
$$

LHSに注目すると

$$
\begin{align*}
e^{i(\alpha +\beta)} &= e^{i\alpha} \times e^{i\beta}\\
                     &= (\cos\alpha + i\sin\alpha)(\cos\beta + i\sin\beta)\\
                     &= \cos\alpha\cos\beta-\sin\alpha\sin\beta + i(\sin\alpha\cos\beta + \cos\alpha\sin\beta)
\end{align*}
$$

最初の式と導かれた式のRHSの実部と虚部どうしがそれぞれ等しくなるので

$$
\begin{align*}
\cos(\alpha +\beta) &= \cos\alpha\cos\beta-\sin\alpha\sin\beta\\
\sin(\alpha +\beta) &= \sin\alpha\cos\beta + \cos\alpha\sin\beta
\end{align*}
$$

</div>


## 積和の公式の図形的理解

三角関数の積を三角関数の足し算の問題に変換する定理として積和の公式があります

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 積和の公式</ins></p>

$$
\begin{align*}
\sin A\cos B &= \frac{1}{2}\{\sin(A+B) + \sin(A-B)\}\\[3pt]
\sin A\sin B &= \frac{1}{2}\{-\cos(A+B) + \cos(A-B)\}\\[3pt]
\cos A\cos B &= \frac{1}{2}\{\cos(A+B) + \cos(A-B)\}\\[3pt]
\end{align*}
$$

</div>

これらの導出は加法定理から導くことができます.

掛け算が足し算に変換できることで計算がかんたんになるというメリットがあります. 例えば, $\sin 40^\circ\cos 20^\circ$を計算したいとき三角表を用いて, 
それぞれの角に対応する数値がわかったとしても

$$
\sin 40^\circ\cos 20^\circ = 0.6428 \times 0.9397
$$

と電卓がないと計算することが大変です. 一方, 積和の公式を用いて足し算に問題に変換すると

$$
\begin{align*}
&\sin 40^\circ\cos 20^\circ\\[3pt]
&=\frac{1}{2}\times (\sin 60^\circ + \sin 20^\circ)\\[3pt]
&= (0.8660 + 0.3420) \div 2\\[3pt]
&=0.6040
\end{align*}
$$

と計算できます.

積和に公式の図形的理解は以下のように角度$\alpha$に対して角度$\alpha+\beta, \alpha-\beta$に対応する単位円周上の点を２つ取ります.

すると, 

- $\cos\alpha\cos\beta$が$\cos(\alpha + \beta)$と$\cos(\alpha - \beta)$の平均
- $\sin\alpha\cos\beta$が$\sin(\alpha + \beta)$と$\sin(\alpha - \beta)$の平均

であることがわかります. また, $\sin\alpha\sin\beta$については$\cos(\alpha - \beta)$と$\cos(\alpha + \beta)$の差分の半分であることもわかります.

<img src= "https://github.com/ryonakimageserver/omorikaizuka/blob/master/math/20210214_sekiwa.png?raw=true">


## チェビチェフの多項式

チェビシェフの多項式とはすべての自然数$n$に対して$\cos n\theta$は$\cos\theta$の多項式で表せることを示す定理です.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

すべての自然数 $n$ に対して, $\cos n\theta= T_n(\cos\theta)$ で表せる

$$
\begin{align*}
T_1(\cos\theta) &= \cos\theta\\
T_2(\cos\theta) &= 2\cos^2\theta - 1\\
T_{n+2}(\cos\theta) &= 2 \cos\theta T_{n+1}(\cos\theta)-T_n(\cos\theta)
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$n=1,2$のときは自明.

加法定理より

$$
\begin{align*}
\cos(n+1)\theta &= \cos n\theta\cos\theta - \sin n\theta\sin\theta\\
\cos(n-1)\theta &= \cos n\theta\cos\theta + \sin n\theta\sin\theta
\end{align*}
$$

上記より以下を得る

$$
\begin{align*}
&\cos(n+1)\theta + \cos(n-1)\theta = 2\cos n\theta\cos\theta\\
&\Rightarrow \cos(n+1)\theta = 2\cos n\theta\cos\theta - \cos(n-1)\theta \\
&\Rightarrow \cos(n+2)\theta = 2\cos (n+1)\theta\cos\theta - \cos n\theta 
\end{align*}
$$

従って,

$$
\begin{align*}
T_{n+2}(\cos\theta) &= \cos(n+2)\theta \\
                    &= 2\cos (n+1)\theta\cos\theta - \cos n\theta \\
                    &= 2\cos\theta T_{n+1}(\cos\theta) - T_n(\cos\theta)
\end{align*}
$$

</div>


## 練習問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 京都大学2006年</ins></p>

$\tan 1^\circ$が無理数であることを示せ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\tan 1^\circ$が有理数であると仮定する.

加法定理より

$$
\tan 2\theta = \frac{2\tan\theta}{1-\tan^2\theta}
$$

なので, $\tan 1^\circ$が有理数であるならば$\theta = 2^\circ, 4^\circ, 8^\circ, \cdots, 64^\circ$も有理数となる

このとき, 

$$
\begin{align*}
\tan60^\circ &= \tan(64^\circ - 4^\circ)\\[3pt]
&= \frac{\tan 64^\circ - \tan4^\circ}{1 + \tan64^\circ\tan4^\circ}
\end{align*}
$$

となり, $\tan60^\circ$も有理数となるはずだが $\tan60^\circ=\sqrt{3}$ より矛盾.

従って, $\tan 1^\circ$は有理数ではない, i.e., $\tan 1^\circ$は無理数.

</div>

----

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: チェビチェフ多項式, 2023年京都大学</ins></p>

$p$を３以上の素数とする. また, $\theta$を実数とする

(1) $\cos3\theta, \cos4\theta, \cos5\theta$を$\cos\theta$の多項式で表わせ

(2) $\cos\theta=1/p$のとき, $\theta = \pi m/n$となるような正の整数$m, n$が存在するか判定せよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答(1)</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\cos3\theta &= \cos(2\theta + \theta)\\
            &= \cos2\theta\cos\theta - \sin2\theta\sin\theta\\
            &= 2\cos^3\theta - \cos\theta - 2(\cos\theta - \cos^3\theta)\\
            &= 4\cos\theta^3 - 3\cos\theta\\
\qquad\\
\cos4\theta &= \cos(2\times 2\theta)\\
            &= 2(\cos 2\theta)^2 - 1\\
            &= 2(2\cos^2\theta - 1)^2 - 1\\
            &= 8\cos^4\theta - 8\cos^2\theta + 1
\end{align*}
$$

$\cos5\theta$については以下のように加法定理を用いる

$$
\begin{align*}
& \cos(4\theta + \theta) = \cos4\theta\cos\theta - \sin4\theta\sin\theta\\
& \cos(4\theta - \theta) = \cos4\theta\cos\theta + \sin4\theta\sin\theta\\
& \Rightarrow \cos5\theta = 2\cos4\theta\cos\theta - \cos3\theta
\end{align*}
$$

従って

$$
\cos5\theta = 16\cos^5\theta - 20\cos^3\theta + 5\cos\theta
$$

</div>


<br>


<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答(2)</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$p$を３以上の素数のとき, $\theta = \pi m/n$となるような正の整数$m, n$が存在すると仮定する. つまり

$$
\begin{align*}
\cos\theta &= \frac{1}{p}\\
\cos n\theta &= \cos m\pi = \pm1
\end{align*}
$$


> $n=1$のとき

$$
\cos\theta = \frac{1}{p} \neq \pm1
$$

> $n=2$のとき

$$
\begin{align*}
\cos2\theta &= 2\cos^2\theta - 1 \\
            &= \frac{2}{p^2} - 1
\end{align*}
$$

となり$\cos2\theta = \pm 1$を満たすためには$p=\pm\sqrt{2}$でなければならず不適

> $n\geq 3$のとき

[上で示したチェビチェフの多項式]((#%E3%83%81%E3%82%A7%E3%83%93%E3%83%81%E3%82%A7%E3%83%95%E3%81%AE%E5%A4%9A%E9%A0%85%E5%BC%8F))より


<div class="math display" style="overflow: auto">
$$
\begin{align*}
&T_n\bigg(\frac{1}{p}\bigg) = \pm 1\\
&\Rightarrow 2^{n-1}\frac{1}{p^n} + a_{n-1}\frac{1}{p^{n-1}} + \cdots + a_{1}\frac{1}{p} + a_0 = \pm 1 \  \ \text{ where } \  \ a_k \in \mathbb Z
\end{align*}
$$
</div>


両辺に$p^{n-1}$をかけると

$$
\begin{align*}
\text{LHS} &= \frac{2^{n-1}}{p} + \text{整数}\\
\text{RHS} &= \pm p^{n-1}
\end{align*}
$$

RHSが整数なのでLHSも整数, つまり $2^{n-1}/p$も整数だが, $p$ は３以上の素数なので矛盾.

従って, $\cos\theta=1/p$のとき, $\theta = \pi m/n$となるような正の整数$m, n$が存在しない.

</div>

References
-----------
- [Ryo's Tech Blog > テイラー展開](https://ryonakagami.github.io/2021/02/15/taylor-expansion/)