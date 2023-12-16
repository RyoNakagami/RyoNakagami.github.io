---
layout: post
title: "自然対数の底ネイピア数とバウンド"
subtitle: "統計のための数学 1/N"
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

- [ネイピア数](#%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0)
- [ネイピア数のバウンド](#%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0%E3%81%AE%E3%83%90%E3%82%A6%E3%83%B3%E3%83%89)
- [ネイピア数数列の収束について](#%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0%E6%95%B0%E5%88%97%E3%81%AE%E5%8F%8E%E6%9D%9F%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [単調性の証明](#%E5%8D%98%E8%AA%BF%E6%80%A7%E3%81%AE%E8%A8%BC%E6%98%8E)
    - [二項定理の展開を用いて単調性を証明](#%E4%BA%8C%E9%A0%85%E5%AE%9A%E7%90%86%E3%81%AE%E5%B1%95%E9%96%8B%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6%E5%8D%98%E8%AA%BF%E6%80%A7%E3%82%92%E8%A8%BC%E6%98%8E)
    - [相加相乗平均の不等式で単調性を証明](#%E7%9B%B8%E5%8A%A0%E7%9B%B8%E4%B9%97%E5%B9%B3%E5%9D%87%E3%81%AE%E4%B8%8D%E7%AD%89%E5%BC%8F%E3%81%A7%E5%8D%98%E8%AA%BF%E6%80%A7%E3%82%92%E8%A8%BC%E6%98%8E)
  - [上に有界の証明](#%E4%B8%8A%E3%81%AB%E6%9C%89%E7%95%8C%E3%81%AE%E8%A8%BC%E6%98%8E)
- [級数によるネイピア数の表現](#%E7%B4%9A%E6%95%B0%E3%81%AB%E3%82%88%E3%82%8B%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0%E3%81%AE%E8%A1%A8%E7%8F%BE)
  - [例：ポワソン分布の期待値と分散](#%E4%BE%8B%E3%83%9D%E3%83%AF%E3%82%BD%E3%83%B3%E5%88%86%E5%B8%83%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%A8%E5%88%86%E6%95%A3)
  - [ネイピア数が無理数であることの証明](#%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0%E3%81%8C%E7%84%A1%E7%90%86%E6%95%B0%E3%81%A7%E3%81%82%E3%82%8B%E3%81%93%E3%81%A8%E3%81%AE%E8%A8%BC%E6%98%8E)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## ネイピア数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ネイピア数</ins></p>

ネイピア数, $e$は以下のように定義される

$$
\begin{align*}
e &= \lim\bigg(1+\frac{1}{n}\bigg)^n\\
  &\approx 2.718281828\cdots
\end{align*}
$$

</div>

$$
\lim\bigg(1+\frac{1}{n}\bigg)^n
$$

が収束するかどうかは証明が必要で後述しますが, 収束するとすると以下のような性質が導けます

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Property</ins></p>

$x$を任意の固定の実数としたとき, 

$$
\exp(x) = \lim\bigg(1 + \frac{x}{n}\bigg)^n
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$e$の定義より$e^x$は以下のように表現される

$$
\begin{align*}
\exp(x) = \lim_{n\to\infty}\bigg(1 + \frac{1}{n}\bigg)^{nx}
\end{align*}
$$

$x$は定数であることに留意して, $u=nx$と変換を行うと

$$
\begin{align*}
\lim_{n\to\infty}\bigg(1 + \frac{1}{n}\bigg)^{nx} = \lim_{u\to\infty}\bigg(1 + \frac{x}{u}\bigg)^{u}
\end{align*}
$$

従って,

$$
\exp(x) = \lim\bigg(1 + \frac{x}{n}\bigg)^n
$$


</div>






## ネイピア数のバウンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: 平成28年東大前期理数学第１問 </ins></p>

$$
e = \lim_{t\to\infty}\bigg(1 + \frac{1}{t}\bigg)^t
$$

としたとき, すべての正の実数$x$に対して, 次の不等式が次の不等式が成り立つことを示せ

$$
\bigg(1 + \frac{1}{x}\bigg)^x < e < \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\bigg(1 + \frac{1}{x}\bigg)^x < e < \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}
$$

について, すべての正の実数$x$について0より厳密に大きい値をとることは自明なので自然対数をとり以下のように変形します

$$
x\ln\bigg(1 + \frac{1}{x}\bigg) < 1 < \bigg(x+\frac{1}{2}\bigg)\ln\bigg(1 + \frac{1}{x}\bigg)
$$

これを示せば, 題意が示せます. 次に, 


$$
f(x) = (x+a)\ln\bigg(1 + \frac{1}{x}\bigg)
$$

これを微分すると, 

$$
\begin{align*}
f'(x) &= \ln\bigg(1 + \frac{1}{x}\bigg) - (x+a)\frac{1}{x(x+1)}\\
f''(x) &= \frac{(2a-1)x + a}{x^2(x+1)^2}
\end{align*}
$$

$f^{\prime\prime}(x)$に着目すると, 

$$
f''(x) \begin{cases}
< 0 & \forall x \in \mathbb R_{+} \text{ when } a < \frac{1}{2} \\[8pt]
> 0 & \forall x \in \mathbb R_{+} \text{ when } a \geq \frac{1}{2}
\end{cases}
$$

とわかるので, 

$$
f'(x) \text{ is }\begin{cases}
\text{単調減少} & \text{ when } a < \frac{1}{2} \\[8pt]
\text{単調増加} & \forall x \in \mathbb R_{+} \text{ when } a \geq \frac{1}{2}
\end{cases}
$$

であることがわかります. また, 

$$
\lim_{x\to\infty}\ln\bigg(1 + \frac{1}{x}\bigg) - (x+a)\frac{1}{x(x+1)} = 0
$$

なので, 

$$
f'(x)\begin{cases}
> 0 \text{ and } \text{単調減少} & \text{ when } a < \frac{1}{2} \\[8pt]
< 0 \text{ and }\text{単調増加} & \forall x \in \mathbb R_{+} \text{ when } a \geq \frac{1}{2}
\end{cases}
$$

であることわかり, 対数変換は単調変換であることに留意すると

$$
\begin{align*}
& \bigg(1 + \frac{1}{x}\bigg)^x \text{is 単調増加関数} \\
& \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}  \text{is 単調減少関数}
\end{align*}
$$


したがって, 

- $\bigg(1 + \frac{1}{x}\bigg)^x$は$x\to\infty$に近づくにあたって, $e$を超えることなく近づいていく 
- $\bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}$は$x\to\infty$に近づくにあたって, $e$を下回ることなく近づいていく 

ので

$$
\bigg(1 + \frac{1}{x}\bigg)^x < e < \bigg(1 + \frac{1}{x}\bigg)^{x+\frac{1}{2}}
$$

と言える.

</div>


Plotlyで実際にそれぞれの単調性を確認してみると以下のようになります

{% include plotly/20210121_napier_plot.html %}


## ネイピア数数列の収束について

「上に有界な単調増加数列は収束する」という性質があるので

$$
\lim_{n\to\infty} \bigg(1 + \frac{1}{n}\bigg)^n
$$

が収束するかどうかは 

$$
a_n = \bigg(1 + \frac{1}{n}\bigg)^n
$$

と数列を定義して, 

- 数列$\{a_n\}$は単調増加
- 数列$\{a_n\}$は上に有界

を示せれば十分です.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem: 上に有界な単調増加数列は収束する</ins></p>

実数の数列$\{a_n\}$は広義単調増加, i.e., $a_n\leq a_{n+1}$, かつ上に有界とする $a_n < K$.
このとき, 数列$\{a_n\}$は収束する.

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

数列$\{a_n\}$は上に有界なので

$$
\alpha = \sup\{a_n \vert n\geq 1 \} < \infty
$$

上限の定義より, 任意の$\epsilon > 0$に対して, ある$N\geq 1$が存在して

$$
\begin{align*}
&a_n > \alpha - \epsilon\\
\Rightarrow & 0 \leq a_n - \alpha < \epsilon
\end{align*}
$$

数列$\{a_n\}$は広義単調増加なので

$$
\forall n \geq N \Rightarrow 0 \leq a_n - \alpha < \epsilon
$$

従って

$$
\forall \epsilon > 0, \exist N(\epsilon) \text{ such that } \vert a_n - \alpha\vert < \epsilon
$$

となるので, $\lim_{n\to\infty} a_n = \alpha$

</div>

### 単調性の証明

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
a_n = \bigg(1 + \frac{1}{n}\bigg)^n
$$

と数列を定義すると, $a_n$は単調増加であることをしめせ.

</div>

証明方法として

- 二項定理の展開
- 相加相乗平均の不等式

があります.

#### 二項定理の展開を用いて単調性を証明

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

<div class="math display" style="overflow: auto">
$$
\begin{align*}
a_n &= \bigg(1 + \frac{1}{n}\bigg)^n\\[3pt]
    &= \sum_{k=0}^n \bigg(\begin{array}{c}n \\ k\end{array}\bigg)\bigg(\frac{1}{n}\bigg)^k\\[3pt]
    &= 1 + n\frac{1}{n}\sum_{k=2}^n \bigg(\begin{array}{c}n \\ k\end{array}\bigg)\bigg(\frac{1}{n}\bigg)^k\\[3pt]
    &= 2 + \sum_{k=2}^n\frac{n(n-1)\cdots(n-k-1)}{k!}\frac{1}{n^k}\\[3pt]
    &= 2 + \sum_{k=2}^n\frac{1}{k!}\bigg(1-\frac{1}{n}\bigg)\bigg(1-\frac{2}{n}\bigg)\cdots\bigg(1-\frac{k-1}{n}\bigg)
\end{align*}
$$
</div>

なお$a_{n+1}$については

<div class="math display" style="overflow: auto">
$$
\begin{align*}
a_{n+1} = 2 + \sum_{k=2}^{n+1}\frac{1}{k!}\bigg(1-\frac{1}{n+1}\bigg)\bigg(1-\frac{2}{n+1}\bigg)\cdots\bigg(1-\frac{k-1}{n+1}\bigg)
\end{align*}
$$
</div>

$a_n, a_{n+1}$を比べると, 後者のほうが項数が１つ多い上に, $\sum$ の内側の各項で後者のほうが大きいので

$$
a_n < a_{n+1}
$$

したがって, 単調性が示せた.

</div>



#### 相加相乗平均の不等式で単調性を証明

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

n$個の$\frac{n+1}{n}$と1個の1について相加相乗平均の不等式を表すと

$$
\begin{align*}
&\frac{\frac{n+1}{n}n + 1}{n+1} > \bigg(\frac{n+1}{n}\bigg)^{\frac{n}{n+1}} \\[3pt]
& \Rightarrow \bigg(1+\frac{1}{n+1}\bigg)^{n+1} >\bigg(1+\frac{1}{n}\bigg)^{n}
\end{align*}
$$

したがって, $a_{n+1}> a_n$となり単調性が示せた.

</div>

### 上に有界の証明

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
a_n = \bigg(1 + \frac{1}{n}\bigg)^n
$$

と数列を定義すると, $a_n$は上に有界である

</div>

二項定理より簡単に証明できます.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
a_n &= \bigg(1 + \frac{1}{n}\bigg)^n\\[3pt]
&= \sum_{k=0}^n \frac{n!}{k!(n-k)!n^k}\\[3pt]
&= \sum_{k=0}^n \frac{1}{k!}\bigg(1 - \frac{1}{n}\bigg)\bigg(1 - \frac{2}{n}\bigg)\cdots\bigg(1 - \frac{k-1}{n}\bigg)\\[3pt]
& < \sum_{k=0}^n \frac{1}{k!}\\
& < 1 + \sum_{k=0}^n \frac{1}{2^k}\\
& \leq 3
\end{align*}
$$

したがって, $a_n < 3$となるので上に有界であることが示せた.

</div>


## 級数によるネイピア数の表現

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>級数によるネイピア数の表現</ins></p>

ネイピア数は

$$
\exp(x) = \sum^{\infty}_{n=0}\frac{x}{n!} 
$$

という級数によって表すことができる.

</div>

この性質はテイラー展開によっても確認できますが, ここでは二項定理を用いて証明します.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\bigg(1 + \frac{x}{n}\bigg)^n &= \sum_{k=0}^n\bigg(\begin{array}{c}n\\k\end{array}\bigg)\bigg(\frac{x}{n}\bigg)^{k}\\[3pt]
                              &= 1 + \frac{n}{1!}\bigg(\frac{x}{n}\bigg) + \frac{n(n-1)}{2!}\bigg(\frac{x}{n}\bigg)^{2} + \cdots + \frac{n(n-1)\cdots(n-k+1)}{k!}\bigg(\frac{x}{n}\bigg)^{k}+\cdots
\end{align*}
$$
</div>

したがって, 

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\lim_{n\to\infty}\bigg(1 + \frac{x}{n}\bigg)^n &= 1 + \frac{n}{1!}\bigg(\frac{x}{n}\bigg) + \frac{n(n-1)}{2!}\bigg(\frac{x}{n}\bigg)^{2} + \cdots + \frac{n(n-1)\cdots(n-k+1)}{k!}\bigg(\frac{x}{n}\bigg)^{k}+\cdots\\[3pt]
                                               &= 1 + \frac{x}{1!} + \bigg(1 - \frac{1}{n}\bigg)\frac{x^2}{2!} + \cdots + \bigg(1 - \frac{1}{n}\bigg)\bigg(1 - \frac{2}{n}\bigg)\cdots\bigg(1 - \frac{n-k+1}{n}\bigg)\frac{x^k}{k!} + \cdots\\[3pt]
                                               &= 1 + \frac{x}{1!} + \frac{x^2}{2!} + \cdots + \frac{x^k}{k!} + \cdots\\[3pt]
                                               &= \frac{x^0}{0!} + \frac{x}{1!} + \frac{x^2}{2!} + \cdots + \frac{x^k}{k!} + \cdots\\[3pt]
                                               &= \sum_{k=0}\frac{x^k}{k!}
\end{align*}
$$
</div>

</div>

### 例：ポワソン分布の期待値と分散

パラメーター$\lambda$のポワソン分布に従う確率変数 $X$ の期待値と分散を求めるときに「級数表現されたネイピア数」を用います.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X] &= \sum_{x=0}x\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
             &= \exp(-\lambda)\sum_{x=1}\frac{\lambda^x}{(x-1)!}\\[3pt]
             &= \exp(-\lambda)\lambda\sum_{x=1}\frac{\lambda^{x-1}}{(x-1)!}\\[3pt]
             &= \exp(-\lambda)\lambda\sum_{k=0}\frac{\lambda^k}{k!}\\[3pt]
             &= \exp(-\lambda)\lambda\exp(\lambda) \  \ \because \text{ 級数表現されたネイピア数より}\\[3pt]
             &= \lambda
\end{align*}
$$
</div>

分散は$\mathbb E[X^2] - \mathbb E[X]^2$なので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[X^2] &= \sum_{x=0}x^2\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
               &= \sum_{x=0}(x(x-1) +x)\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
               &= \sum_{x=0}(x(x-1))\exp(-\lambda)\frac{\lambda^x}{x!} + \sum_{x=0}x\exp(-\lambda)\frac{\lambda^x}{x!}\\[3pt]
               &= \lambda^2\sum_{x=2}\exp(-\lambda)\frac{\lambda^{x-2}}{(x-2)!} + \lambda\\[3pt]
               &= \lambda^2\exp(-\lambda)\sum_{x=2}\frac{\lambda^{x-2}}{(x-2)!} + \lambda\\[3pt]
               &= \lambda^2\exp(-\lambda)\sum_{k=0}\frac{\lambda^{k}}{(k)!} + \lambda\\[3pt]
               &= \lambda^2\exp(-\lambda)\exp(\lambda) + \lambda\\[3pt]
               &= \lambda^2 + \lambda
\end{align*}
$$
</div>

したがって, $V(X) = \lambda^2 + \lambda - \lambda^2 = \lambda$.

### ネイピア数が無理数であることの証明

$$
e = \sum^{\infty}_{n=0}\frac{1}{n!} 
$$

と上記で示したので, ここから以下の式を得ます.

$$
\begin{align*}
&e = 1 + \frac{1}{1!} + \frac{1}{2!} + \cdots + \frac{1}{n!} + R_{n+1}\\[3pt]
&\text{where } R_{n+1} = \frac{e^\theta}{(n+1)!} < \frac{3}{(n+1)!}\\[3pt]
& \qquad\qquad \theta \in (0, 1) 
\end{align*}
$$

仮に$e$を有理数として $e = \frac{m}{n}$と表せるとすると, $m, n \in \mathbb Z$なので

$$
\begin{align*}
n!e &\in \mathbb Z\\
\frac{e^\theta}{n+1} > 0 \ \ &\land \ \ \frac{e^\theta}{n+1} \in \mathbb Z
\end{align*}
$$

従って, 

$$
1 \leq \frac{e^\theta}{n+1} < \frac{3}{n+1}
$$

これを満たすためには $n = 1$である必要があるが, このとき$e=m$となるが

$$
2 < e < 3
$$

より矛盾する. 従って, $e$は有理数ではない.



References
-----

- [高校数学の美しい物語 > 自然対数の底（ネイピア数）の定義：収束することの証明 ](https://manabitimes.jp/math/714)
- [理数アラカルト > ネイピア数とは？](https://risalc.info/src/Napiers-constant.html)
