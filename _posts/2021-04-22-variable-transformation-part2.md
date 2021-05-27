---
layout: post
title: "変数変換のお勉強 Part 2"
subtitle: "練習問題編"
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
|目的|変数変換のお勉強 Part 2|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [１次元変数変換](#%EF%BC%91%E6%AC%A1%E5%85%83%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B)
  - [問題その1](#%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE1)
    - [Pythonで確認してみる](#python%E3%81%A7%E7%A2%BA%E8%AA%8D%E3%81%97%E3%81%A6%E3%81%BF%E3%82%8B)
  - [問題その2](#%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE2)
    - [Simulation with Python](#simulation-with-python)
  - [問題その3](#%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE3)
- [2次元変数変換](#2%E6%AC%A1%E5%85%83%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B)
  - [問題その4](#%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE4)
  - [問題その5](#%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE5)
  - [問題その6](#%E5%95%8F%E9%A1%8C%E3%81%9D%E3%81%AE6)
- [Appendix](#appendix)
  - [変数変換を用いた定積分の計算](#%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E5%AE%9A%E7%A9%8D%E5%88%86%E3%81%AE%E8%A8%88%E7%AE%97)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## １次元変数変換
### 問題その1

確率変数 $$X$$ の確率密度関数が

$$
f(x) = \frac{1 + x}{2}, \: \text{s.t. } x \in (-1, 1)
$$

で与えられているとき、変数変換 $$Y = X^2$$ の確率密度関数と平均と分散を求めよ

> 解答

$$
\int^{1}_{-1} \frac{1 + x}{2} dx = \left[\frac{1}{4}(1 + x)^2\right]^1_{-1} = 1
$$

より確率密度関数の条件を満たしている.

$$
\begin{align*}
F_Y(y) &= P(Y \leq y)\\[8pt]
&= P(X^2 \leq y)\\[8pt]
&= P(-\sqrt{y} \leq X \leq \sqrt{y})\\[8pt]
&= F_X(\sqrt{y}) - F_X(-\sqrt{y}) \tag{A}
\end{align*}
$$

(A)を$$y$$で微分すれば良いので

$$
f_Y(y) = \frac{1}{2}\frac{1}{\sqrt{y}}(f_X(\sqrt{y})+f_X(-\sqrt{y})) = \frac{1}{2\sqrt{y}}
$$

次に平均を求める.

$$
\begin{aligned}
E[Y] &= \int^1_0\frac{1}{2}y\frac{1}{\sqrt{y}}dy\\
&= \frac{1}{2}\int^1_0\sqrt{y}dy\\
&= \frac{1}{3}
\end{aligned}
$$

次に分散を求める

$$
\begin{aligned}
E[Y^2] &= \int^1_0\frac{1}{2}y^2\frac{1}{\sqrt{y}}dy\\
&= \frac{1}{2}\int^1_0 y^{\frac{3}{2}}dy\\
&= \frac{1}{5}
\end{aligned}
$$

$$
\therefore \: Var(Y) = \frac{1}{5} - \frac{1}{9} = \frac{4}{45}
$$

<div style="text-align: right;">
■
</div>

#### Pythonで確認してみる

> import modules

```python
import random
import numpy as np
import matplotlib.pyplot as plt
```

> 方針

1. $$(0, 1)$$区間の一様乱数を発生させる
2. 逆関数法を用いて、$$F_X(x)$$に従う乱数を生成する

> Classと関数の定義

```python
class SampleGenerator:
    def __init__(self, sample_size, seed = 42):
        self.sample_size = sample_size
        self.seed = seed
    
    def random_sampling(self):
        """
        Return random samples which follows the density function:
          f(x) = (1 + x)/2 where x in (-1, 1) else 0
        
        And

        Return Y = X^2
        """
        random.seed(self.seed)
        self.data = [self.inv_cumulative(random.uniform(0, 1)) for i in range(self.sample_size)]
        self.transformed_data = [i**2 for i in self.data]

    def describe(self, transformed = None):
        """
        Reutrn the mean and variable of the data

        Note
          the variance is based on the unbiased variance
        """
        if transformed:
            tmp_data = self.transformed_data
        else:
            tmp_data = self.data

        mean, var =  np.mean(self.data), np.var(tmp_data, ddof = 1)
        print("the mean: {}\nthe variance: {}".format(mean, var))

    @staticmethod
    def inv_cumulative(prob):
        """
        the density function:
          f(x) = (1 + x)/2 where x in (-1, 1) else 0

        the cumulative function
          F(x) = (1 + x)^2/4 where x in (-1, 1)
            if x <= -1 then 0
            if x >= 1 then 1      
        """

        return 2 * prob ** 0.5 - 1

def x_density(x):
    """
    the density function:
        f(x) = (1 + x)/2 where x in (-1, 1) else 0
    """

    return (1 + x)/2

def y_density(y):
    """
    the density function:
        f(y) = 1/(2 * y**0.5) else 0
    """

    return 1/(2 * y**0.5)
```

> 平均と分散の確認

```python
Experiment = SampleGenerator(10000)
Experiment.random_sampling()

print("the original data")
Experiment.describe()

print("\nthe transformed data")
Experiment.describe(transformed=1)
```

Then,

```
the original data
the mean: 0.3346733874809254
the variance: 0.21967269701823616

the transformed data
the mean: 0.3346733874809254
the variance: 0.08801896143609267
```

上の計算結果とほぼ一致する結果が確認できました.

> XとYの分布の確認

まず確率変数 $$X$$ の分布を確認します

```python
fig, ax = plt.subplots(1, 1,figsize=(10, 10))

xgrid = np.linspace(-1, 1, 200)

ax.hist(Experiment.data, density = True, bins = 100, label = 'sampling')
ax.plot(xgrid, x_density(xgrid),lw=2, color='#A60628',label = 'True density')
ax.set_title('density function: $f(x) = (1 + x)/2$', fontsize=15)
ax.set_xlabel('x value', fontsize=12)
ax.set_ylabel('density', fontsize=12)
ax.legend(fontsize=12);
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210422_x_density.png?raw=true">

つぎに同様のコードを実行して $$Y$$の分布を確認します

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210422_y_density.png?raw=true">


### 問題その2

確率変数 $$X$$ の密度関数が 

$$
f_X(x) = \frac{2}{9}(x + 1) \: -1 \leq x \leq 2
$$

で与えられているとき、$$Y = X^2$$の密度関数を求めよ

> 解答

$$0 < y < 1$$ と $$1 \leq y < 4$$ に分けて考える.

前者について、

$$
f_Y(y) = \frac{1}{2\sqrt{y}}(f_X(\sqrt{y}) + f_X(-\sqrt{y})) = \frac{2}{9\sqrt{y}}
$$

後者については、1 対 1 変換となることに注意すると

$$
\begin{aligned}
F_Y(y) &= P(X^2 \leq 1) + P(1 < X^2 \leq y)\\
&= \frac{2}{9}\int^{1}_{-1}(1 + x)dx + P(1 < X^2 \leq y)\\
&= \frac{4}{9} + \int^{\sqrt{y}}_1\frac{2}{9}(1+x)dx\\
&= \frac{1}{9} + \frac{1}{9}(y + 2\sqrt{y})
\end{aligned}
$$

従って、$$y$$で両辺を微分すればよいので

$$
f_Y(y) = \frac{1}{9}\left(1 + \frac{1}{\sqrt{y}}\right)
$$

まとめると、

$$
f_Y(y) = 
\begin{cases}
\frac{2}{9\sqrt{y}} & \: 0 < y < 1\\
\frac{1}{9}\left(1 + \frac{1}{\sqrt{y}}\right)& \:  1 \leq y < 4
\end{cases}
$$


<div style="text-align: right;">
■
</div>

#### Simulation with Python

今回の $$X$$の累積分布関数は

$$
F_X(x) = \frac{1}{9}(x + 1)^2
$$

なので

$$
F_X^{-1}(p) = 3\sqrt{p} - 1
$$

として、上と同じコードを実行すれば良い(→参考[こちら](https://colab.research.google.com/drive/1CIrrIEr3bxptUKYy87u5z04JbyILLNY0?usp=sharing))

### 問題その3

$$X\sim N(0, 1)$$のとき、 $$Y = \exp(X)$$の確率密度関数を求めよ

> 解答

$$\exp(\cdot)$$は単調増加関数かつ逆関数は$$\log(\cdot)$$。また$$Y$$の組み立て方から $$y \leq 0$$なので

$$
\begin{aligned}
P(Y\leq y) &= P(\exp(X)\leq y)\\
&= P(X \leq \log y)\\
&= \int^{\log y}_{-\infty}f(x)dx
\end{aligned}
$$

両辺を$$y$$で微分すると

$$
\begin{aligned}
g(y) &= f(\log y)\frac{1}{y}\\
&= \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{(\log y)^2}{2}\right)\frac{1}{y}
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

PythonでのSimulation結果は[こちら](https://colab.research.google.com/drive/18Yx43GhX56-jlE-m0SdMDIjVxHGeh5N-?usp=sharing)

## 2次元変数変換
### 問題その4

$$X, Y$$ は独立で、ともに $$N(0, 1)$$ に従う時、

$$ 
\begin{aligned}
U &= \frac{X}{Y}\\
V &= Y
\end{aligned}
$$

の同時密度関数 $$g(u, v)$$を求めよ

> 解答

$$X, Y$$ は独立なので

$$
\begin{aligned}
f(x, y) &= \frac{1}{\sqrt{2\pi}}\exp\left(- \frac{x^2}{2}\right)\frac{1}{\sqrt{2\pi}}\exp\left(- \frac{y^2}{2}\right)\\
&= \frac{1}{2\pi}\exp\left(- \frac{x^2 + y^2}{2}\right)
\end{aligned}
$$

$$x = uv, y = v$$とおいて変数変換を行うと

$$
\begin{aligned}
g(u, v)&= f(x, y)\times \left|
\begin{array}{cc}
\frac{\partial x}{\partial u} & \frac{\partial x}{\partial v}\\
\frac{\partial y}{\partial u} & \frac{\partial y}{\partial v}
\end{array} \right|\\[8pt]
&= \frac{1}{2\pi}\exp\left(- \frac{x^2 + y^2}{2}\right)\times \left|
\begin{array}{cc}
v & u\\
0 & 1
\end{array} \right|\\[8pt]
&=\frac{1}{2\pi}\exp\left(- \frac{x^2 + y^2}{2}\right)|v|
&=\frac{1}{2\pi}\exp\left(- \frac{(uv)^2 + v^2}{2}\right)|v|
\end{aligned}
$$

周辺分布 $$h(u)$$は

$$
\begin{aligned}
h(u) &= \frac{1}{2\pi}\int^\infty_{-\infty}\exp\left(- \frac{(uv)^2 + v^2}{2}\right)|v|dv\\
&=\frac{2}{2\pi}\int^\infty_{0}\exp\left(- \frac{(uv)^2 + v^2}{2}\right)vdv\\
&=\frac{1}{\pi}\int^\infty_{0}\exp\left(- \frac{(u^2 + 1)v^2}{2}\right)vdv
\end{aligned}
$$

ここで $$(u^2 + 1)v^2/2 = t$$と変数変換すると

$$
\begin{aligned}
h(u) &= \frac{1}{\pi}\int^\infty_{0}\exp\left(- \frac{(u^2 + 1)v^2}{2}\right)vdv\\
&=\frac{1}{\pi}\int^\infty_{0}\exp(- t)\sqrt{\frac{2t}{1 + u^2}}\frac{dv}{dt}dt\\
&=\frac{1}{\pi}\int^\infty_{0}\exp(- t)\sqrt{\frac{2t}{1 + u^2}}\sqrt{\frac{2}{1+u^2}}\frac{1}{2\sqrt{t}}dt\\
&=\frac{1}{\pi(1+u^2)}\int^\infty_{0}\exp(-t)dt\\
&=\frac{1}{\pi(1+u^2)}
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

PythonでのSimulation結果は[こちら]((https://colab.research.google.com/drive/1b7XdjoqzPZKJefXjG1rT0cWp8hHDJZ28?usp=sharing)

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210422_problem_04.png?raw=true">

### 問題その5

確率変数 $$X, Y$$ は独立でそれぞれの確率密度関数は$$f(x), g(y)$$とする. 新しい確率変数 $$Z = X + Y$$の確率密度関数を求めよ

> 解答

$$Z$$の分布関数を$$H(z)$$とすると

$$
\begin{aligned}
H(z) &= \int\int_{x+y = z}f(x)g(y)dxdy\\
&=\int^{\infty}_{-\infty}f(x)dx\int^{z-x}_{-\infty}g(y)dy
\end{aligned}
$$

両辺を$$z$$で微分して

$$
h(z) = \int^{\infty}_{-\infty}f(x)g(z-x)dx
$$

<div style="text-align: right;">
■
</div>

### 問題その6

確率変数 $$X, Y$$ は独立で, 

$$
\begin{aligned}
X&\sim \text{Exp}\left(\frac{1}{2}\right)\\
Y&\sim \text{Exp}\left(\frac{1}{3}\right)
\end{aligned}
$$

このとき、新しい確率変数 $$Z = X + Y$$の確率密度関数を求めよ

> 解答

それぞれ指数分布に従うので定義域は正の値となることに注意すると

$$
\begin{aligned}
H(z) &= int^{z}_{0}f(x)g(z-x)dx\\
&=int^{z}_{0}2\exp(-2x)\times 3\exp(-3(z-x))dx\\
&= 6\exp(-3z)\int^{z}_{0}\exp(-2x+3x)dx\\
&= 6(\exp(-2z)-\exp(-3z)) \: (z \geq 0)
\end{aligned}
$$

これを$$z$$で微分し

$$
\begin{aligned}
h(z) &= \int\int_{x+y = z}f(x)g(y)dxdy\\
&=\int^{\infty}_{-\infty}f(x)dx\int^{z-x}_{-\infty}g(y)dy
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

## Appendix
### 変数変換を用いた定積分の計算

$$x = g(t)$$ (ただし $$g(t)$$は積分区間で単調な関数)と変換する. $$x$$ が $$a$$ から $$b$$ へと動くとき, $$t$$ は$$\alpha = g^{-1}(a)$$から $$\beta = g^{-1}(b)$$ へと動くとする. 

$$
\begin{aligned}
\int^b_a f(x) dx &= \int^{\beta}_{\alpha}f(g(t))\frac{dx}{dt}dt\\
&= \int^{\beta}_{\alpha}f(g(t))g'(t)dt
\end{aligned}
$$

> 例

$$
\begin{aligned}
\int^1_0x\exp(x^2)dx &= \int^1_0 \sqrt{t}\exp(t)\frac{1}{2\sqrt{t}}dt \: (x^2 = t)\\
&= \frac{1}{2}\int^1_0\exp(t)dt\\
&= \frac{1}{2}(e - 1)
\end{aligned}
$$



