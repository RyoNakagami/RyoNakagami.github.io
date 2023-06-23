---
layout: post
title: "カイ二乗適合度検定"
subtitle: "数理統計：適合度検定 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-08-03
tags:

- 統計
- Python
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [カイ二乗分布の定義](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E5%AE%9A%E7%BE%A9)
  - [カイ二乗分布の成り立ち](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E6%88%90%E3%82%8A%E7%AB%8B%E3%81%A1)
    - [自由度1の場合の証明](#%E8%87%AA%E7%94%B1%E5%BA%A61%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%AE%E8%A8%BC%E6%98%8E)
    - [自由度Nの場合の証明](#%E8%87%AA%E7%94%B1%E5%BA%A6n%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [モード, 平均, 分散の導出](#%E3%83%A2%E3%83%BC%E3%83%89-%E5%B9%B3%E5%9D%87-%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
- [適合度検定](#%E9%81%A9%E5%90%88%E5%BA%A6%E6%A4%9C%E5%AE%9A)
  - [ピアソンのカイ2乗検定統計量がカイ2乗分布に収束する証明](#%E3%83%94%E3%82%A2%E3%82%BD%E3%83%B3%E3%81%AE%E3%82%AB%E3%82%A42%E4%B9%97%E6%A4%9C%E5%AE%9A%E7%B5%B1%E8%A8%88%E9%87%8F%E3%81%8C%E3%82%AB%E3%82%A42%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AB%E5%8F%8E%E6%9D%9F%E3%81%99%E3%82%8B%E8%A8%BC%E6%98%8E)
  - [例: メンデルの遺伝の法則と適合度検定](#%E4%BE%8B-%E3%83%A1%E3%83%B3%E3%83%87%E3%83%AB%E3%81%AE%E9%81%BA%E4%BC%9D%E3%81%AE%E6%B3%95%E5%89%87%E3%81%A8%E9%81%A9%E5%90%88%E5%BA%A6%E6%A4%9C%E5%AE%9A)
- [Appendix](#appendix)
  - [ガンマ関数の公式](#%E3%82%AC%E3%83%B3%E3%83%9E%E9%96%A2%E6%95%B0%E3%81%AE%E5%85%AC%E5%BC%8F)
  - [自由度1のカイ二乗分布の確率密度関数の導出：別解](#%E8%87%AA%E7%94%B1%E5%BA%A61%E3%81%AE%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E7%A2%BA%E7%8E%87%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA%E5%88%A5%E8%A7%A3)
  - [カイ二乗分布の積率母関数の導出](#%E3%82%AB%E3%82%A4%E4%BA%8C%E4%B9%97%E5%88%86%E5%B8%83%E3%81%AE%E7%A9%8D%E7%8E%87%E6%AF%8D%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
- [Refereneces](#refereneces)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## カイ二乗分布の定義

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def:カイ二乗分布 </ins></p>

$n$を自然数とした時,確率変数 $X$ の確率密度関数が

$$
f_X(x) = \frac{1}{\Gamma(n/2)}\left(\frac{1}{2}\right)^{n/2}x^{n/2-1}\exp(-x/2), \  \ x>0
$$

で与えられる時,自由度 $n$ のカイ二乗分布といい, $\chi^2_n$ で表す.

</div>


---|---
特性関数|$(1 - 2it)^{-n/2}$
積率母関数|$(1 - 2t)^{-n/2}$
期待値|$n$
分散|$2n$


### カイ二乗分布の成り立ち

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem </ins></p>


確率変数 $Z_i \sim N(0, 1), \  \ i \in \{1,\cdots, N\}$がi.i.d条件を満たす時,

$$
\chi^2(N) = \sum_{i}^N Z_i^2
$$

と定義すると,$\chi^2(N)$は自由度 $N$ のカイ二乗分布に従う.

</div>


#### 自由度1の場合の証明

$f(z)$を標準正規分布の確率密度関数とし, $$f^*$$を$f(x)$の原始関数の1つとする. $$Y = Z^2$$が従う分布の確率密度関数$g(y)$は以下のように導出される:

$$
\begin{align*}
g(y) &= \frac{d}{dy}Pr(Z^2 \leq y)\\
     &= \frac{d}{dy}Pr(-\sqrt{y} \geq Z \leq \sqrt{y})\\
     &= \frac{d}{dy}\int^{\sqrt{y}}_{-\sqrt{y}}f(x)dx\\
     &= \frac{d}{dy}\{f^*(\sqrt{y}) - f^*(-\sqrt{y})\}\\
     &= \frac{1}{2\sqrt{y}}\frac{1}{\sqrt{2\pi}}\exp(-y/2) + \frac{1}{2\sqrt{y}}\frac{1}{\sqrt{2\pi}}\exp(-y/2)\\
     &= \frac{1}{\sqrt{2\pi}}y^{-1/2}\exp(-y/2)\\
     &= \frac{1}{\Gamma(1/2)}\left(\frac{1}{2}\right)^{1/2}y^{1/2-1}\exp(-y/2)
\end{align*}
$$

となり, $Y$ が自由度１のカイ二乗分布に従うことがわかる.

> コラム:変数変換Tips

上の式展開を見ればわかるが$ X$ の確率密度関数を$f(x)$としたとき, $Y = X^2 $という変数変換をした時の確率密度関数は

$$
g(y) = \begin{cases}
\frac{1}{2\sqrt{y}}\left[f(-\sqrt{y})+f(\sqrt{y})\right] & \  \ (y\geq 0)\\
0 & \  \ (y < 0)
\end{cases}
$$



#### 自由度Nの場合の証明

カイ二乗分布の自由度$N$は自然数, 自由度$1$の場合の証明は上記で完了しているので, 自由度 $N-1$の場合のとき成立することを仮定して帰納法を用いて証明すれば十分です.

まず,証明したい内容は以下:

$Y = \sum_{i}^{N-1}Z_i^2$ が自由度 $N-1$のカイ二乗分布に従うとき, $Y + Z_N^2$ が自由度 $N$ のカイ二乗分布に従う, つまり

$$
f_N(x) = \int^x_0f_{N-1}(t)f_1(x-t)dt
$$

ここで $f_{n-1}, f_1$ はそれぞれ自由度 $ N-1, 1$ のカイ自乗分布の確率密度関数なので

$$
\begin{align*}
f_N(x) &= \int^x_0f_{N-1}(t)f_1(x-t)dt\\[8pt]
       &= \frac{\exp(-x/2)}{\Gamma((N-1)/2)\Gamma(1/2)}\left(\frac{1}{2}\right)^{N/2}\int^x_0t^{\frac{N-3}{2}}(x-t)^{-\frac{1}{2}}dt
\end{align*}
$$

ここで $u = t/x$と変数変換すると

$$
\begin{align*}
f_N(x) = \frac{\exp(-x/2)x^{N/2-1}}{\Gamma((N-1)/2)\Gamma(1/2)}\left(\frac{1}{2}\right)^{N/2}\int^1_0u^{(N-3)/2}(1-u)^{-1/2}du
\end{align*}
$$

$\int^1_0u^{(N-3)/2}(1-u)^{-1/2}du$に対してベータ関数の積分公式を用いると

$$
\begin{align*}
\int^1_0u^{(N-3)/2}(1-u)^{-1/2}du &= B\left(\frac{N-1}{2}, \frac{1}{2}\right)\\
&= \frac{\Gamma((N-1)/2)\Gamma(1/2)}{\Gamma(N/2)}
\end{align*}
$$

従って, $f_N(x)$ は自由度 $N$ のカイ二乗分布の確率密度関数と一致する.

### モード, 平均, 分散の導出

> モード

$n\geq 3$ のときに限定して導出します.

カイ二乗分布の確率密度関数$$f_n(x)$$を$x$について微分すると

$$
f'_n(x) = -\frac{1}{2}Cx^{\frac{n}{2}-2}\exp(-\frac{x}{2})\{x - (n-2)\}, \  \ C\equiv \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}
$$

従って, 

$$
f'_n(n-2)=0
$$

よって, $x=n-2$のとき最大値を取ることがわかります.

> 平均

$$
\begin{align*}
\mathbb E[X] &= \int^\infty_0 xf_n(x)dx\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\int^\infty_0 x^{\frac{n}{2}}\exp\left(-\frac{x}{2}\right)\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}+1\right)}{\left(\frac{1}{2}\right)^{\frac{n}{2}+1}}\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}\right)\frac{n}{2}}{\left(\frac{1}{2}\right)^{\frac{n}{2}+1}}\\
             &= n
\end{align*}
$$

> 分散

$$
\begin{align*}
\mathbb E[X^2] &= \int^\infty_0 x^2f_n(x)dx\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\int^{\infty}_0 x^{\frac{n}{2}+1}\exp\left(-\frac{x}{2}\right)\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}+2\right)}{\left(\frac{1}{2}\right)^{\frac{n}{2}+2}}\\
             &= \frac{1}{2^{\frac{n}{2}}\Gamma\left(\frac{n}{2}\right)}\frac{\Gamma\left(\frac{n}{2}\right)\frac{n}{2}\left(\frac{n}{2}+1\right)}{\left(\frac{1}{2}\right)^{\frac{n}{2}+1}}\\
             &= n(n+2)
\end{align*}
$$

従って, 

$$
\begin{align*}
V(x) &= n(n+2) - n^2\\
     &= 2n
\end{align*}
$$

## 適合度検定

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: カイ2乗適合度検定</ins></p>

全体で $n$個のデータが $C_1, \cdots, C_K$の $K$個のカテゴリーに分類され,
それぞれ $X_1, \cdots, X_K$個観測されたとする.

それぞれのカテゴリーに入る確率を $p_1, \cdots, p_K  (\text{ where } p_i = X_i/n)$, また
$\pi_1, \cdots, \pi_K$ を理論上想定される確率であるとしたとき, 観測データに基づいた確率分布が
理論上想定される確率分布に等しいか否かを検定する問題以下のように定式化される

$$
\begin{align*}
H_0 &: p_i=\pi_i \forall i \in \{1, \cdots, K\}\\
H_1 &: p_i\neq\pi_i \exists i \in \{1, \cdots, K\}
\end{align*}
$$

そして, 

$$
Q(\boldsymbol x , \boldsymbol\pi) \equiv \sum^{K}_{i=1}\frac{(X_i - \pi_in)^2}{\pi_in}
$$

このピアソンのカイ2乗検定統計量は $H_0$のもとで $Q(\boldsymbol x , \boldsymbol\pi)\to_d \chi^2_{K-1}$に
収束することが知られている. なので, 水準$\alpha$での棄却域は

$$
\mathbf R = \{\boldsymbol x \in \mathcal\chi | Q(\boldsymbol x , \boldsymbol\pi) > \chi^2_{K-1, \alpha}\}
$$

</div>

### ピアソンのカイ2乗検定統計量がカイ2乗分布に収束する証明

<div style='padding-left: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>定理 </ins></p>

帰無仮説 $H_0$ のもとで, 

$$
Q(\boldsymbol x , \boldsymbol\pi) \to_d \chi^2_{K-1}
$$

</div>

**証明**

設定より, 以下が成り立つことをまず確認する

$$
\begin{align*}
X_K & = n - \sum_{i=1}^{K-1} X_i\\
\pi_K & = n - \sum_{i=1}^{K-1} \pi_i
\end{align*}
$$

次に, $Q(\boldsymbol x \mathbb, \pi)$を以下のように式変形する:

$$
\begin{align*}
Q(\boldsymbol x , \boldsymbol\pi) =& \sum^{K-1}_{i=1}\bigg(\frac{1}{\pi_i} + \frac{1}{\pi_K}\bigg) \bigg[\sqrt{n}(X_i/n - \pi_i)\bigg]^2\\[8pt]
&+ \frac{1}{\pi_K}\sum_{i}^{K-1}\sum_{j\neq i}^{K-1}\sqrt{n}(X_i/n - \pi_i)\sqrt{n}(X_j/n - \pi_j)\\[8pt]
=& \boldsymbol Z^T \boldsymbol A \boldsymbol Z
\end{align*}
$$

$\boldsymbol A$ は $(K-1)\times(K-1)$ 行列で, その $(i,j)$ 成分は

$$
a_{ij} = \begin{cases}
       \frac{1}{\pi_i} + \frac{1}{\pi_K} & (i=j)\\
       \frac{1}{\pi_K} & (i\neq j)
\end{cases}
$$

$\boldsymbol Z$ について理解するために, $\boldsymbol Y_j = (Y_{1j}, \cdots, Y_{Kj})^T$ というどれか１つが
$1$, 残りが $0$ となるような確率変数を考える. (イメージとしては個人 $j$ さんがどのカテゴリーに属するかを表す変数)

このとき, $\boldsymbol Y_1, \cdots, \boldsymbol Y_n$ は互いに独立に分布し,

$$
\begin{align*}
\mathbf E[Y_{ij}] &= \pi_i\\
\mathbf V(Y_{ij}) &= \pi_i(1- \pi_i)\\
Cov(Y_{ij}, Y_{i'j}) &= -\pi_i\pi_{i'}
\end{align*}
$$

$$
X_i = \sum_{j=1}^n Y_{ij}
$$

であることに留意すると, 中心極限定理より

$$
\begin{align*}
&\boldsymbol Z \to_d N_{K-1}(\boldsymbol 0, \boldsymbol \Sigma)\\
&\text{ where }\boldsymbol\Sigma = 
\begin{cases}
\pi_i(1-\pi_i) & (i=j)\\
-\pi_i\pi_j & (i\neq j)
\end{cases}
\end{align*}
$$

$\boldsymbol A^{-1} = \boldsymbol\Sigma$ が成り立つので, 

$$
Q(\boldsymbol x , \boldsymbol\pi) = \boldsymbol Z^T \boldsymbol \Sigma^{-1} \boldsymbol Z \to_d \chi^2_{K-1} 
$$

**証明終了**






### 例: メンデルの遺伝の法則と適合度検定

ある農園でのえんどう豆の交配実験の結果, 以下のような観測値が得られた:

---|---|---|---|---|---
種類|A  | B | C | D | 合計
観測数| 479 | 146 | 163 | 44 | 832

メンデルの遺伝の法則によると $A: B: C :D = 9: 3:3:1$ となるはずである.
このとき, 観測データはメンデルの法則に適合しているか, 有意水準 0.05 で検定してみる

(本来は仮説検定が棄却されないときは, 何も言えないが正しい)

**解答**

カイ2乗検定統計量を$T$とすると, 

$$
\begin{align*}
T &= \frac{(479 - 468)^2}{468} + \frac{(146 - 156)^2}{156} + \frac{(163 - 156)^2}{156} + \frac{(44 - 64)^2}{64} \\
  &= 2.444 < \chi_3^2(0.05)
\end{align*}
$$

従って, $H_0$ は棄却されない. 

**証明終了**




## Appendix
### ガンマ関数の公式

$$
\int^\infty_0 x^r \exp(-ax)dx = \frac{\Gamma(r+1)}{a^{r+1}}
$$

### 自由度1のカイ二乗分布の確率密度関数の導出：別解

$Z\sim N(0,1)$に従うとき, $$X = Z^2$$の変数変換を考える. $z > 0$のとき

$$
\frac{dz}{dx} = \frac{1}{2\sqrt{x}}
$$

であり,かつ$$Z$$の分布は原点を中心に左右対称であることに注意すると


$$
\begin{align*}
f(x) &= 2\phi(\sqrt{x})\frac{dz}{dx}\\
     &= \frac{2}{\sqrt{2\pi}}\exp\left(-\frac{x}{2}\right)\frac{1}{2\sqrt{x}}\\
     &= \frac{1}{\sqrt{2\pi}\sqrt{x}}\exp\left(-\frac{x}{2}\right)\\
     &= \frac{1}{\sqrt{2}\Gamma\left(\frac{1}{2}\right)}x^{\frac{1}{2}-1}\exp\left(-\frac{x}{2}\right)
\end{align*}
$$

となり, $X$ が自由度１のカイ二乗分布に従うことがわかる.

### カイ二乗分布の積率母関数の導出

$$
\begin{align*}
M_{X}(t)&=E[\exp(tX)]\\
        &=\int_{ 0 }^{ \infty }\exp(tx)f(x)dx\\
        &=\int_{ 0 }^{ \infty }\exp(tx)\frac{x^{(\frac{N}{2} - 1)}\exp(-x/2)}{\Gamma\left(\frac{N}{2}\right)2^{\frac{N}{2}}}dx\\
        &=\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp(-x/2 + tx)}{\Gamma\left(\frac{N}{2}\right)2^{\frac{N}{2}}}dx\\
        &=\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)2^{\frac{N}{2}}}dx\\
        &=\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)(1-2t)^{\frac{N}{2}}\left(\frac{2}{1-2t}\right)^{\frac{N}{2}}}dx\\
        &=(1-2t)^{-\frac{N}{2}}\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)\left(\frac{2}{1-2t}\right)^{\frac{N}{2}}}dx
\end{align*}
$$



ここで以下のように変数変換する:

$$
\theta \equiv \frac{2}{1-2t}
$$

すると, 積分箇所がscale parameter $\theta$のカイ二乗分布関数に以下のように書き換えられるので合計1となるので

$$
\begin{align*}
&(1-2t)^{-\frac{N}{2}}\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2} - 1)}\exp\left\{-\left(\frac{1-2t}{2}\right)x\right\}}{\Gamma\left(\frac{N}{2}\right)\left(\frac{2}{1-2t}\right)^{\frac{N}{2}}}dx \\
&= (1-2t)^{-\frac{N}{2}}\int_{ 0 }^{ \infty }\frac{x^{(\frac{N}{2}-1)}\exp\left(-\frac{x}{\theta}\right)}{\Gamma(\frac{N}{2})\theta^{\frac{N}{2}}}dx\\
&=(1-2t)^{-\frac{N}{2}}
\end{align*}
$$


## Refereneces

> オンラインマテリアル

- [高校数学の美しい物語 > 正規分布の二乗和がカイ二乗分布に従うことの証明](https://manabitimes.jp/math/1083)

> 書籍

- [現代数理統計学の基礎 - 共立出版, 久保川 達也 著・ 新井 仁之 編・ 小林 俊行 編・ 斎藤 毅 編・ 吉田 朋広 編, P156-157](https://www.kyoritsu-pub.co.jp/book/b10003681.html)