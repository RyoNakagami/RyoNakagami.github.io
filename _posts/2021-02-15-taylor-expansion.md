---
layout: post
title: "テイラー展開"
subtitle: "統計のための数学 6/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-16
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

- [Taylor展開](#taylor%E5%B1%95%E9%96%8B)
  - [基本問題](#%E5%9F%BA%E6%9C%AC%E5%95%8F%E9%A1%8C)
  - [オイラーの公式](#%E3%82%AA%E3%82%A4%E3%83%A9%E3%83%BC%E3%81%AE%E5%85%AC%E5%BC%8F)
- [Appendix: 平均値の定理](#appendix-%E5%B9%B3%E5%9D%87%E5%80%A4%E3%81%AE%E5%AE%9A%E7%90%86)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Taylor展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

ある区間に追いて, $f(x)$ は第$n$階まで微分可能とする. その区間において$a$は定点, $x$は任意の点とすると

$$
\begin{align*}複素数とはなにか 
f(x) =& f(a) + \sum_{k=1}^{n-1} \frac{f^{(k)}(a)}{k!}(x-a)^k + \frac{f^n(\xi)}{n!}(x-a)^n\\[3pt]
      & \text{where } \xi= a + \theta(x - a), \qquad 0 < \theta < 1
\end{align*}
$$

</div>

最後項は, $a$の代わりに$a$と$x$の中間値$\xi$に対する導関数を用いており, この項を**剰余項**と呼び, $R_n$とかで表記されたりする.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
F(x) = f(x) - \left\{f(a) + \sum_{k=1}^{n-1} \frac{f^{(k)}(a)}{k!}(x-a)^k\right\}
\end{align*}
$$

とおく. $F(x)$がすなわち$R_n$である. $F(x)$は仮定より第$n$階まで微分可能でまた計算により以下のことがわかる

$$
\begin{align*}
F(a) = F^\prime(a)=&\cdots = F^{(n-1)}(a) = 0\\
F^{(n)}(x) &= f^{(n)}(x)
\end{align*}
$$

ここで$G(x) = (x-a)^n$と定義して[平均値の定理]((#appendix-%E5%B9%B3%E5%9D%87%E5%80%A4%E3%81%AE%E5%AE%9A%E7%90%86))を利用すると, $x_0$を$a, x$の中間値とすると
複素数とはなにか 
$$
\begin{align*}
\frac{F(x) - F(a)}{G(x) - G(a)} = \frac{F(x)}{(x-a)^n} = \frac{F^\prime(x_0)}{n(x_0-a)^{n-1}}
\end{align*}
$$

同様に, $F^\prime(a) = 0, G^\prime(a) = 0$から

$$
\frac{F^\prime(x_0)}{n(x_0-a)^{n-1}} = \frac{F^{\prime\prime}(x_1)}{n(n-1)(x_1-a)^{n-2}}
$$

これはRHSに$F^{(n)}$がでてくるところまで続けられるので

$$
\frac{F(x)}{(x-a)^n} = \frac{F^{(n)}(\xi)}{n!} = \frac{f^{(n)}(\xi)}{n!}
$$

従って

$$
F(x) = (x-a)^n\frac{f^{(n)}(\xi)}{n!}
$$

よって式変形より

$$
\begin{align*}
f(x) =& f(a) + \sum_{k=1}^{n-1} \frac{f^{(k)}(a)}{k!}(x-a)^k + \frac{f^n(\xi)}{n!}(x-a)^n\\[3pt]
      & \text{where } \xi= a + \theta(x - a), \qquad 0 < \theta < 1
\end{align*}
$$

</div>


### 基本問題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

次の関数のマクローリン展開を求めよ

$$
\begin{array}{ccc}
(1) e^x \qquad \ \ \ \ \ \ & (2) \sin(x) & (3) \cos x \ \ \ \ \ \\\
(4) \log(1+x) & (5) \frac{1}{1-x} \ \ \ \ \  & (6) (1 + x)^a
\end{array}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\exp(0) = 1$, $(\exp(x))^\prime = \exp(x)$より

$$
\begin{align*}
e^x &= 1 + \frac{x}{1!} + \frac{x^2}{2!} + \cdots\\[3pt]
    &= \sum_{n=0}^\infty\frac{x^n}{n!}
\end{align*}
$$

$\cos 0 = 1, \sin 0 = 0, (\cos x)^\prime = -\sin x, (\sin x)^\prime = \cos x$より

$$
\begin{align*}
\cos x &= 1 - \frac{x^2}{2!} + \frac{x^4}{4!} + \cdots = \sum_{k=0}^\infty \frac{(-1)^{k}x^{2k}}{(2k)!}\\[3pt]
\sin x &= \frac{x}{1!} - \frac{x^3}{3!} + \frac{x^5}{5!} \cdots = \sum_{k=0}^\infty \frac{(-1)^{k}x^{2k + 1}}{(2k + 1)!}
\end{align*}
$$

$$
\log(1 + x) = x - \frac{x^2}{2} + \frac{x^3}{3} - \frac{x^4}{4} + \cdots = \sum_{k=1}(-1)^{k-1}\frac{x^k}{k}
$$

$$
\frac{1}{1-x} = 1 + x + x^2 +x^3 + \cdots = \sum_{n=0}^\infty x^n
$$

これは $x\in (0, 1)$のときの等比級数の和と一致することがわかる

$$
(1 + x)^a = \sum_{k=0} \bigg(\begin{array}{c}a\\ k \end{array}\bigg)x^k
$$

これは２項定理と一致することがわかる.

</div>

### オイラーの公式

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: Euler's formula</ins></p>

$$
e^{i\theta} = \cos\theta + i\sin\theta
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

LHSをマクローリン展開すると

$$
e^{i\theta} = 1 + i\theta - \frac{\theta^2}{2!} + i\frac{\theta^3}{3!} - \frac{\theta^4}{4!} + \cdots
$$

RHSをマクローリン展開すると

$$
\begin{align*}
\cos\theta &= 1 - \frac{\theta^2}{2!} + \frac{\theta^4}{4!} + \cdots \\[3pt]
i\sin\theta &= i\theta - i\frac{x^3}{3!} + i\frac{x^5}{5!} \cdots
\end{align*}
$$

従って, LHS = RHSが成立する.

</div>

オイラーの公式を拡張することで次の関係式を得ることができます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: オイラーの公式の拡張</ins></p>

$z\in\mathbb C$に対して,

$$
\begin{align*}
e^{iz} &= \cos z + i \sin z\\
\cos z &= \frac{e^{iz} + e^{-iz}}{2}\\[3pt]
\sin z &= \frac{e^{iz} - e^{-iz}}{2}
\end{align*}
$$

</div>


## コイン投げ問題とマクローリン展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>



</div>




## Appendix: 平均値の定理

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 平均値の定理</ins></p>

区間 $[a,b]$ において, $f(x), g(x)$ は連続で, $(a,b)$において微分可能, かつ$g'(x)\neq 0$とする.
このとき, $\xi \in (a,b)$において

$$
\frac{f(a) - f(b)}{g(a) - g(b)} = \frac{f^\prime(\xi)}{g^\prime(\xi)}
$$

</div>

この定理の利用方法として例えば, $e\leq p < q,$ ($e$はネイピア数とする)のとき

$$
\log(\log q) - \log(\log p) < \frac{q-p}{e}
$$

が成立することが示せます.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$e\leq p < q$より $\log(\log x)$は定義域に追いて連続かつ微分可能なので, 平均値の定理より
以下を満たすような$\xi \in (\log p\, log p)$が存在する

$$
\frac{\log(\log q) - \log(\log p)}{q -p} = \frac{1}{\xi\log(\xi)}
$$

ここで$g(x) = x\log x$について考えると

$$
g^\prime(x) = \log x + 1
$$

なので$x \geq e$においては$g(x)$は単調増加であることがわかる

$$
g(e) = e\log e = e
$$

より, $\xi > e$なので$g(\xi) > g(e)$

従って, 

$$
\begin{align*}
&\frac{\log(\log q) - \log(\log p)}{q -p} = \frac{1}{\xi\log(\xi)} < \frac{1}{e}\\[3pt]
&\Rightarrow \log(\log q) - \log(\log p) < \frac{q-p}{e}
\end{align*}
$$

</div>

References
--------
- [高校数学の美しい物語 > 平均値の定理の意味・証明・応用例題２パターン](https://manabitimes.jp/math/980)
