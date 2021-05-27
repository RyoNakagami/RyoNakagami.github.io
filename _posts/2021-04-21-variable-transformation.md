---
layout: post
title: "変数変換のお勉強 Part 1"
subtitle: "変数変換のルールをまとめる"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- math
- 統計
- Python
---
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|変数変換のルールをまとめる|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [変数変換](#%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B)
  - [例題](#%E4%BE%8B%E9%A1%8C)
  - [累積分布関数と一様分布](#%E7%B4%AF%E7%A9%8D%E5%88%86%E5%B8%83%E9%96%A2%E6%95%B0%E3%81%A8%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83)
  - [確率変数の線形変換](#%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E7%B7%9A%E5%BD%A2%E5%A4%89%E6%8F%9B)
  - [平方変換](#%E5%B9%B3%E6%96%B9%E5%A4%89%E6%8F%9B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 変数変換
> 定理(1)

確率変数 $$X$$ の確率密度関数を$$f_X(x)$$とし、 $$Y = g(X)$$とする. $$g(\cdot)$$が単調増加もしくは単調減少な関数とし、$$g^{-1}(y)$$が微分可能であるとき、

$$
f_Y(y) = f_X(g^{-1}(y))\left|\frac{d}{dy}g^{-1}(y)\right| = f_X(g^{-1}(y))\left|\frac{1}{g'(g^{-1}(y)})\right|
$$

<div style="text-align: right;">
■
</div>

> 説明

- 確率変数 $$X$$
- 関数 $$g(\cdot)$$
- $$Y = g(X)$$

このとき、$$Y$$ の分布を導きたいとします.分布関数$$F_Y(y)$$は

$$
\begin{aligned}
F_Y(y) &= P(g(X)\leq y)\\
&= P(X\in \{x\mid g(x)\leq y\})
\end{aligned}
$$

$$X$$が連続型確率変数のときには、$$Y$$の確率密度関数は

<div class="math display" style="overflow: auto">
$$
f_Y(y) = \frac{d}{dy}F_Y(y) = \frac{d}{dy}P(X\in \{x\mid g(x)\leq y\})
$$
</div>

特に、$$g(\cdot)$$が単調増加関数のときには、$$g(\cdot)$$の逆関数$$g^{-1}(\cdot)$$が存在することから、

$$
\{x\mid g(x)\leq y\} = \{x\mid x\leq g^{-1}(y)\} 
$$

従って、

$$
F_Y(y) = \int^{g^{-1}(y)}_{-\infty}f_X(x)dx
$$

確率密度関数は

$$
f_Y(y) = f_X(g^{-1}(y))\frac{d}{dy}g^{-1}(y)
$$

ここで、$$g(g^{-1}(y)) = y$$の両辺を$$y$$で微分すると

$$
g'(g^{-1}(y))\frac{d}{dy}g^{-1}(y) = 1
$$

なので

$$
f_Y(y) = f_X(g^{-1}(y))\frac{1}{g'(g^{-1}(y))}
$$

### 例題

$$X \sim N(0, 1)$$のとき, $$Y= \exp(X)$$の確率密度関数を求めよ

> 解答

$$\exp(\cdot)$$は連続な単調増加関数で逆関数 $$X = \log (Y)$$をもつ. 従って、

$$
F_Y(y) = F_X(\log (y))
$$

両辺を$$y$$で微分すると

$$
\begin{aligned}
f_Y(y) &= f_X(\log(y))\frac{1}{y}\\
&= \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{(\ln y)^2}{2}\right)\frac{1}{y} \: (t\leq 0)
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

### 累積分布関数と一様分布

> 命題 2

連続型確率変数 $$X$$ の分布関数を$$F_X(x)$$ とし、新たに確率変数 $$Y$$ を $$Y = F_X(X)$$ で定義する.このとき

$$
Y \sim \mathrm{U}(0, 1)
$$

> 証明

区間$$y \in (0, 1)$$に対して、$$F_X(x)$$は単調増加関数. 従って、

$$
\begin{aligned}
F_Y(y) &= P(F_X(X)\leq y)\\
&= P(X\leq F^{-1}_X(y))\\
&= F_X(F^{-1}_X(y))
\end{aligned}
$$

両辺を$$y$$で微分すると

$$
f_Y(y) = f_X(F^{-1}_X(y))\frac{1}{f_X(F^{-1}_X(y))} = 1
$$

従って、$$Y \sim \mathrm{U}(0, 1)$$

<div style="text-align: right;">
■
</div>

### 確率変数の線形変換

連続型確率変数 $$Z$$ の確率密度関数が $$f(z)$$で与えられているとする. $$\mu$$を実数, $$\sigma$$を正の実数とし

$$
X = \sigma Z + \mu
$$

としたとき、$$X$$の確率密度関数は

$$
f_X(x) = \frac{1}{\sigma}f\left(\frac{x-\mu}{\sigma}\right)
$$

### 平方変換

連続型確率変数 $$Z$$ の確率密度関数が $$f(z)$$で与えられているとする. 

$$
X = Z^2
$$

としたとき、$$X$$の確率密度関数は

$$
\begin{aligned}
F_X(x) &= P(Z^2 \leq x)\\
&= P(-\sqrt{x} \leq Z \leq \sqrt{x})\\
&= F_Z(\sqrt{x}) - F_Z(-\sqrt{x})
\end{aligned}
$$

従って、

$$
f_X(x) = (f_Z(\sqrt{x}) + f_Z(-\sqrt{x}))\frac{1}{2\sqrt{z}}
$$



