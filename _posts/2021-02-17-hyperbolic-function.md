---
layout: post
title: "双曲線関数の定義と性質: sinh, cosh, tanh"
subtitle: "統計のための数学 8/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-02-08
header-mask: 0.0
header-style: text
tags:

- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [双曲線関数](#%E5%8F%8C%E6%9B%B2%E7%B7%9A%E9%96%A2%E6%95%B0)
  - [双曲線関数の性質](#%E5%8F%8C%E6%9B%B2%E7%B7%9A%E9%96%A2%E6%95%B0%E3%81%AE%E6%80%A7%E8%B3%AA)
  - [三角関数と双曲線関数の関係](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%A8%E5%8F%8C%E6%9B%B2%E7%B7%9A%E9%96%A2%E6%95%B0%E3%81%AE%E9%96%A2%E4%BF%82)
  - [双曲線関数と加法定理](#%E5%8F%8C%E6%9B%B2%E7%B7%9A%E9%96%A2%E6%95%B0%E3%81%A8%E5%8A%A0%E6%B3%95%E5%AE%9A%E7%90%86)
- [双曲線関数の微積分](#%E5%8F%8C%E6%9B%B2%E7%B7%9A%E9%96%A2%E6%95%B0%E3%81%AE%E5%BE%AE%E7%A9%8D%E5%88%86)
  - [マクローリン展開](#%E3%83%9E%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%AA%E3%83%B3%E5%B1%95%E9%96%8B)
    - [cosh, sinhのマクローリン展開その２](#cosh-sinh%E3%81%AE%E3%83%9E%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%AA%E3%83%B3%E5%B1%95%E9%96%8B%E3%81%9D%E3%81%AE%EF%BC%92)
    - [tanhのマクローリン展開](#tanh%E3%81%AE%E3%83%9E%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%AA%E3%83%B3%E5%B1%95%E9%96%8B)
- [懸垂線上の点の移動](#%E6%87%B8%E5%9E%82%E7%B7%9A%E4%B8%8A%E3%81%AE%E7%82%B9%E3%81%AE%E7%A7%BB%E5%8B%95)
  - [曲線の長さ](#%E6%9B%B2%E7%B7%9A%E3%81%AE%E9%95%B7%E3%81%95)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 双曲線関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 双曲線関数</ins></p>

$$
\begin{align*}
\cosh x &= \frac{\exp(x)+\exp(-x)}{2} \\[3pt]
\sinh x &= \frac{\exp(x)-\exp(-x)}{2} \\[3pt]
\tanh x &= \frac{\sinh x}{\cosh x}=\frac{\exp(x)-\exp(-x)}{\exp(x)+\exp(-x)}
\end{align*}
$$

</div>

{% include plotly/20210217_hyperbolic.html %}

関数 $f(x)$ を任意の関数としたとき,

$$
\begin{align*}
\text{偶関数} &= \frac{f(x) + f(-x)}{2}\\[3pt]
\text{奇関数} &= \frac{f(x) - f(-x)}{2}
\end{align*}
$$

と表すことが出来ます. このことから$\cosh x, \sinh x$がそれぞれ偶関数, 奇関数であることがわかります. つまり,

$$
\begin{align*}
\cosh(x) = \cosh(-x)\\
\sinh(x) = -\sinh(-x)
\end{align*}
$$

また, $\cosh x$の逆数も偶関数なので, 

$$
\text{奇関数} = \text{奇関数} \times \text{偶関数}
$$

したがって, $\tanh x$は奇関数となります.


### 双曲線関数の性質

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Property 1</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

$$
\cosh^2 x - \sinh^2 x = 1
$$

</div>

$$
\begin{align*}
\cosh^2 x - \sinh^2 x &= \left(\frac{\exp(x)+\exp(-x)}{2}\right)^2 - \left(\frac{\exp(x)-\exp(-x)}{2}\right)^2\\[3pt]
&= \frac{1}{4}\left(\exp(2x) + \exp(-2x) - \exp(2x) - \exp(-2x) + 4\right)\\[3pt]
&= 1
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Property 2</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

$$
\begin{align*}
1 - \tanh^2 x = \frac{1}{\cosh^x}
\end{align*}
$$

</div>

$$
\begin{align*}
1 - \tanh^2 x &= \frac{\cosh^2 x}{\cosh^2 x} - \frac{\sinh^2 x}{\cosh^2 x}\\[3pt]
              &= \frac{\cosh^2 x - \sinh^2 x}{\cosh^2 x}\\[3pt]
              &= \frac{1}{\cosh^2 x}
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Property 3</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

$$
\begin{align*}
1 -\frac{1}{\tanh^2 x} = -\frac{1}{\sinh^x}
\end{align*}
$$

</div>

$$
\begin{align*}
1 -\frac{1}{\tanh^2 x} &= \frac{\sinh^2 x}{\sinh^2 x} - \frac{\cosh^2 x}{\sinh^2 x}\\[3pt]
                       &= \frac{-(\cosh^2 x-\sinh^2 x)}{\sinh^2 x}\\[3pt]
                       &= -\frac{1}{\sinh^x}
\end{align*}
$$

</div>

### 三角関数と双曲線関数の関係

オイラーの公式を用いると三角関数は次のように表わせます

$$
\begin{align*}
\exp(i\theta) &= \cos\theta + i\sin\theta\qquad\text{(オイラーの公式)}\\[3pt]
\cos\theta &= \frac{\exp(i\theta) + \exp(-i\theta)}{2}\\[3pt]
\sin\theta &= \frac{\exp(i\theta) - \exp(-i\theta)}{2i}
\end{align*}
$$

この関係に留意すると

$$
\begin{align*}
\sin(iz) &= i\sinh z\\
\cos(iz) &= \cosh z\\
\end{align*}
$$

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

> **正弦関数とhyperbolic sine**

$$
\begin{align*}
\sin(iz) &= \frac{\exp(i(iz)) - \exp(-i(iz))}{2i}\\[3pt]
         &= \frac{\exp(-z) - \exp(z)}{2i}\\[3pt]
         &= i \frac{\exp(-z) - \exp(z)}{-2}\\[3pt]
         &= i \frac{\exp(z) - \exp(-z)}{2}\\[3pt]
         &= i\sinh z
\end{align*}
$$

> **余弦関数とhyperbolic cosine**

$$
\begin{align*}
\cos(iz) &= \frac{\exp(i(iz)) + \exp(-i(iz))}{2}\\[3pt]
         &= \frac{\exp(-z) + \exp(z)}{2}\\[3pt]
         &= \cosh z
\end{align*}
$$

</div>

### 双曲線関数と加法定理

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>双曲線関数と加法定理</ins></p>

$$
\begin{align*}
\sinh(x \pm y) &= \sinh x\cosh y \pm \cosh x\sinh y\\[3pt]
\cosh(x \pm y) &= \cosh x\cosh y \pm \sinh x\sinh y\\[3pt]
\tanh(x\pm y) & \frac{\tanh x\pm \tanh y}{1\pm\tanh x\tanh y}
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

三角関数の加法定理より

$$
\begin{align*}
\sin(x\pm y) &= \sin x\cos y \pm \cos x \sin y\\
\cos(x\pm y) &= \cos x\cos y \mp \sin x\sin y
\end{align*}
$$

$(x, y) = (iz, iw)$とするとLHSは

$$
\begin{align*}
\sin(iz \pm iw) &= \sin(i (z\pm w))\\
                &= i\sinh(z\pm w)\\
\cos(iz \pm iw) &= \cos(i (z\pm w))\\
                &= \cosh(z\pm w)
\end{align*}
$$

RHSはそれぞれ

$$
\begin{align*}
\sin iz\cos iw \pm \cos iz \sin iw &= i\sinh z\cosh w \pm \cosh z i\sinh w\\
\cos iz\cos iw \mp \sin iz\sin iw &= \cosh z\cosh w \pm \sinh z\sinh w
\end{align*}
$$

したがって,

$$
\begin{align*}
\sinh(x \pm y) &= \sinh x\cosh y \pm \cosh x\sinh y\\[3pt]
\cosh(x \pm y) &= \cosh x\cosh y \pm \sinh x\sinh y
\end{align*}
$$

</div>

## 双曲線関数の微積分

双曲線関数の定義より微分に関しては以下のことがすぐわかります

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition: 双曲線関数の微分</ins></p>

$$
\begin{align*}
&\frac{d}{dz}\cosh z = \sinh z\\[3pt]
&\frac{d}{dz}\sinh z = \cosh z\\[3pt]
&\frac{d}{dz}\tanh z = \frac{1}{\cosh^2 z}
\end{align*}
$$

</div>

積分も以下のようになります

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition: 双曲線関数の積分</ins></p>

$$
\begin{align*}
&\int\cosh z dz = \sinh z + C\\[3pt]
&\int\sinh z dz = \cosh z + C\\[3pt]
&\int\tanh z dz = \log(\cosh z) + C
\end{align*}
$$

$\int \tan x dx$と異なり, $\cosh z > 0$なので\tanh x の積分に絶対値は不要であることに留意.

</div>

### マクローリン展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition: 双曲線関数のマクローリン展開</ins></p>

$$
\begin{align*}
\sinh x &= x + \frac{x^3}{3!} + \frac{x^5}{5!} + \cdots\\[3pt]
\cosh x &= 1 + \frac{x^2}{2!} + \frac{x^4}{4!} + \cdots\\[3pt]
\tanh x &= x - \frac{1}{3}x^3 + \frac{2}{15}x^5 - \frac{17}{315}x^7 + \cdots
\end{align*}
$$

</div>

$\sinh x, \cosh x$のマクローリン展開の導出は

$$
\begin{align*}
\exp(x) = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \cdots\\[3pt]
\exp(-x) = 1 - x + \frac{x^2}{2!} - \frac{x^3}{3!} + \cdots
\end{align*}
$$

と指数関数$\exp(x)$のマクローリン展開から計算することが出来ます.

#### cosh, sinhのマクローリン展開その２

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >三角関数との関係式からの導出</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

オイラーの公式より

$$
\begin{align*}
\sin(iz) &= i\sinh z\\
\cos(iz) &= \cosh z
\end{align*}
$$

また, $\sin x, \cos x$のマクローリン展開はそれぞれ

$$
\begin{align*}
\sin x &= \sum_{n=1}^\infty (-1)^{n+1}\frac{x^{2n-1}}{(2n-1)!}\\[3pt]
\cos x &= 1 + \sum_{n=1}^\infty (-1)^{n}\frac{x^{2n}}{(2n)!}
\end{align*}
$$

したがって,

$$
\begin{align*}
\sinh x &= \frac{1}{i}\sin ix\\[3pt]
        &= \frac{1}{i}\left\{(ix) - \frac{(ix)^3}{3!} + \frac{(ix)^5}{5!} + \cdots\right\}\\[3pt]
        &= x + \frac{x^3}{3!} + \frac{x^5}{5!} + \cdots\\[3pt]
        \\
\cosh x &= \cos ix\\[3pt]
        &= 1 - \frac{(ix)^2}{2!} + \frac{(ix)^4}{4!} + \cdots\\[3pt]
        &= 1 + \frac{x^2}{2!} + \frac{x^4}{4!} + \cdots
\end{align*}
$$

</div>

#### tanhのマクローリン展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>tanh xのマクローリン展開</ins></p>

$$
\tanh x = x - \frac{1}{3}x^3 + \frac{2}{15}x^5 - \frac{17}{315}x^7 + \cdots
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\tan ix=i \tanh x
$$

であるので

$$
\begin{align*}
\tanh x &= \frac{1}{i}\tan ix\\[3pt]
        &= \frac{1}{i}\left\{(ix) + \frac{1}{3}(ix)^3 + \frac{2}{15}(ix)^5 + \cdots\right\}
        &= x - \frac{1}{3}x^3 + \frac{2}{15}x^5+ \cdots
\end{align*}
$$

</div>

## 懸垂線上の点の移動

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$x\in [0, 1]$区間上に定義された以下の双曲線関数を考えます

$$
y = \frac{\exp(x) + \exp(-x)}{2}
$$

$(x, y) = (0, 1)$に点があり, 時間がすすむにつれてこの双曲線上を速さ $0.01$で右向きに進むとします.
この時間を$t$と表したとき, $t=100$のときこの点が位置するxy座標を答えよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

時刻$t$における点の位置を $\vec{x}(t) = (x(t), y(t))$と表現したとき,

$$
\begin{align*}
\text{速度 } \vec{v} &= \frac{d\vec{x}(t)}{dt} = \left(\frac{d x(t)}{dt}, \frac{d y(t)}{dt}\right)\\[3pt]
\text{速さ } \vert\vec{v}\vert &= \sqrt{\left(\frac{d x(t)}{dt}\right)^2 +  \left(\frac{d y(t)}{dt}\right)^2}\\[3pt]
&= 0.01
\end{align*}
$$

と問題文を整理できます.

$$
\begin{align*}
&\sqrt{\left(\frac{d x(t)}{dt}\right)^2 +  \left(\frac{d y(t)}{dt}\right)^2}\\[3pt]
&= \sqrt{\left(1 + \left(\frac{d y(t)}{dx}\right)^2\right)\left( \frac{d x(t)}{dt}\right)^2}\\[3pt]
&= \sqrt{\left(1 + \sinh^2 x\right)\left( \frac{d x(t)}{dt}\right)^2}\\[3pt]
&= \sqrt{\cosh x^2\left( \frac{d x(t)}{dt}\right)^2}\\[3pt]
&= \cosh x \frac{dx(t)}{dt}
\end{align*}
$$

したがって,

$$
\cosh x \frac{dx(t)}{dt} = 0.01
$$

を得る. $\displaystyle \frac{dx(t)}{dt}$という$t$についての関数を得るために, 上記の式を$t$について積分します.

$$
\begin{align*}
&\int^T_0\cosh x \frac{dx(t)}{dt}dt = \int^T_0 0.01 dt\\[3pt]
&\Rightarrow \int^{x(T)}_0\cosh x\ dx = \int^T_0 0.01 dt\\[3pt]
\end{align*}
$$

よって,

$$
\begin{align*}
\sinh(x(T)) &= 0.01T\\
x(T) &= \log(0.01T+\sqrt{(0.01T)^2+1})
\end{align*}
$$

$t=100$のときの$\vec{x}$を求めたいので, 上記の式に対して$T=100$として,

$$
x(100) = \log(1 + \sqrt{2})
$$

また

$$
y(100) = \sqrt{2}
$$

よって, $\vec{x}(100) = ( \log(1 + \sqrt{2}), \sqrt{2})$


</div>

### 曲線の長さ

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

上記の問題設定で点のx座標が1となるまで移動した距離を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答 1</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

移動距離は

$$
\text{移動距離} = \text{速さ} \times \text{移動時間}
$$

で表されるので $x(t) = 1$となるときの$t$を求めることを考える. 

$$
x(T) = \log(0.01T+\sqrt{(0.01T)^2+1})
$$

なので

$$
\begin{align*}
& e = 0.01T+\sqrt{(0.01T)^2+1}\\[3pt]
&\Rightarrow  e - 0.01 T = \sqrt{(0.01T)^2+1}\\[3pt]
&\Rightarrow  e^2 + (0.01 T)^2 - 2 e(0.01 T)= (0.01T)^2+1\\[3pt]
&\Rightarrow  e^2 -1 = 2 e(0.01 T)\\[3pt]
&\Rightarrow T = \frac{e^2-1}{2e \times 0.01}
\end{align*}
$$

したがって, 移動距離は

$$
\frac{e^2-1}{2e \times 0.01} \times 0.01 = \frac{e^2-1}{2e} = \sinh 1
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答 2</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

関数$f(x)$が微分可能で, $f^\prime(x)$が連続のとき, $y=f(x)$で表される曲線の$a\leq x\leq b$部分の長さは

$$
\int^b_a \sqrt{1 + f^\prime(x)^2}\ dx
$$

で計算できる.

</div>

この定理を用いると

$$
\text{移動距離} = \int^1_0 \sqrt{1 + \sinh^2 x}\ dx
$$

なので

$$
\begin{align*}
&\int^1_0 \sqrt{1 + \sinh^2 x}\ dx\\[3pt]
&= \int^1_0\sqrt{1 + \frac{\exp{2x}-2 + \exp{-2x}}{4}}\ dx \\[3pt]
&= \int^1_0\sqrt{\left(\frac{\exp(x)+\exp(-x)}{2}\right)^2}\ dx\\[3pt]
&= \int^1_0\cosh(x)\ dx\\[3pt]
&= [\sinh x]^1_0 \\[3pt]
&= \sinh 1
\end{align*}
$$

</div>


References
----------
- [高校数学の美しい物語 > 双曲線関数(sinh,cosh,tanh)の意味・性質・楽しい話題まとめ](https://manabitimes.jp/math/617)
- [電線を歩くアリの方程式](https://www.youtube.com/watch?v=krbTuZ9l1bc)
