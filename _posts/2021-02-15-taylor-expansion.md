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
- [コイン投げ問題とマクローリン展開](#%E3%82%B3%E3%82%A4%E3%83%B3%E6%8A%95%E3%81%92%E5%95%8F%E9%A1%8C%E3%81%A8%E3%83%9E%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%AA%E3%83%B3%E5%B1%95%E9%96%8B)
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
\begin{align*}
(1 + x)^a &= \sum_{k=0}^\infty \frac{a(a-1)\cdots(a-n+1)}{n!}x^n\\[3pt]
          &= \sum_{k=0}^\infty \bigg(\begin{array}{c}a\\ k \end{array}\bigg)x^k
\end{align*}
$$

これは拡張された２項定理と一致することがわかる.

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

整数全体を考える. 表と裏がそれぞれ確率50%のフェアコインを投げて,

- 表なら $+1$
- 裏なら $-1$

次に, 以下の確率を考える

- $f_n$: 0から始めてコイン投げ$n$回目に初めて0に戻る確率, $f_0=0$
- $u_n$: コイン投げ$n$回目に0に戻る確率, $u_0 = 0$

このとき以下の問題を答えよ:

1. $u_n$を求めよ
2. $U(t) = u_1t + u_2t^2 + \cdots$のとき, $U(t)=1/\sqrt{1-t^2} - 1$で有ることを示せ
3. $F(t) = f_1t + f_2t^2 + \cdots$を求めよ
4. いずれ0に戻ってくる確率を求めよ
5. はじめて0に戻ってくるまでの平均回数を求めよ

</div>

$F(t)$が確立母関数の形式となっていることがわかるとかんたんに解けます.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(1) の解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
u_n =\begin{cases}
0 & n \text{が奇数のとき}\\
_nC_{n/2}(\frac{1}{2})^n & n \text{が偶数のとき}
\end{cases}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(2) の解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

(1)の解答より

$$
U(t) = \sum_{k=1}^\infty \bigg(\begin{array}{c}2k\\ k\end{array}\bigg)\bigg(\frac{t^2}{4}\bigg)^k
$$

次に, $1/\sqrt{1-t^2}$について考える. このとき, 拡張された２項定理(基本問題(6)参照)より

$$
\begin{align*}
(1 + x)^{-1/2} = \sum_{n=0}^\infty\bigg(\begin{array}{c}-\frac{1}{2}\\ n\end{array}\bigg)x^n
\end{align*}
$$

ここで

$$
\begin{align*}
\bigg(\begin{array}{c}-\frac{1}{2}\\ n\end{array}\bigg) &= \bigg(-\frac{1}{2}\bigg)\bigg(-\frac{1}{2} - 1\bigg)\bigg(-\frac{1}{2} - 2\bigg)\cdots \bigg(-\frac{1}{2} - (n-1)\bigg)\bigg/n!\\[3pt]
&= (-1)^n\frac{1\cdot 3\cdot5\cdots (2n-1)}{2^n n!}
\end{align*}
$$

$$
\begin{align*}
1\cdot 3\cdot5\cdots (2n-1) = \frac{(2n)!}{2^n n!} 
\end{align*}
$$

より

$$
\bigg(\begin{array}{c}-\frac{1}{2}\\ n\end{array}\bigg) = (-1)^n\left(\frac{1}{2}\right)^{2n} \frac{(2n)!}{n!n!} 
$$

従って,

$$
\begin{align*}
\frac{1}{\sqrt{1-t^2}} - 1 &= \sum_{n=0}^\infty\bigg(\begin{array}{c}-\frac{1}{2}\\ n\end{array}\bigg)(-t^2)^n - 1\\[3pt]
&= \sum_{n=0}^\infty \left(\frac{t}{2}\right)^{2n} \frac{(2n)!}{n!n!} - 1\\[3pt] 
&= \sum_{n=1}^\infty \left(\frac{t}{2}\right)^{2n} \frac{(2n)!}{n!n!} \\[3pt]
&= U(t)
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(3)の解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$u_n = f_n + \sum_{k=1}^{n-1} f_k u_{n-k}$より

$$
\begin{align*}
U(t) &= \sum_{n=1}^\infty u_n t^n\\[3pt]
     &= \sum_{n=1}^\infty (f_n + \sum_{k=1}^{n-1} f_k u_{n-k}) t^n\\[3pt]
     &= F(t) + \sum_{n=1}^\infty\sum_{k=1}^{n-1} f_k u_{n-k} t^n\\[3pt]
     &= F(t) + \sum_{k=1}^\infty f_k t^k \sum_{m=1}^\infty u_m t^m\\[3pt]
     &= F(t) + F(t)U(t)
\end{align*}
$$

従って

$$
\begin{align*}
F(t) &= \frac{U(t)}{1 + U(t)}\\[3pt]
     &= 1 - \sqrt{1 -t^2}
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(4)の解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

いずれ0に戻る確率は

$$
f_0 + f_1 + f_2 + \cdots = F(1) = 1
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >(5)の解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
F^\prime(1) = \sum_{i=1}^\infty i f_i
$$

となるのでこれが平均と一致することがわかる.

$$
F^\prime(t) = \frac{t}{\sqrt{1-t^2}}
$$

従って, 

$$
\lim_{t\to 1}F^\prime(t) = \infty
$$

より平均は定義できないことがわかる.

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
