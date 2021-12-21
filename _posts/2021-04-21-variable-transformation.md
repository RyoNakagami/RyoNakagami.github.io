---
layout: post
title: "数理統計：変数変換 1/n"
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

  gtag('config', 'G-LVL413SV09' {
  'user_id': 'USER_ID'
});

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

## 1: １次元変数変換
### 定理：変数変換と確率密度関数

> 定理


確率変数 $$X$$ の確率密度関数を$$f_X(x)$$とし、 $$Y = g(X)$$とする. $$g(\cdot)$$が単調増加もしくは単調減少な関数とし、$$g^{-1}(y)$$が微分可能であるとき、

$$
f_Y(y) = f_X(g^{-1}(y))\left|\frac{d}{dy}g^{-1}(y)\right| = f_X(g^{-1}(y))\left|\frac{1}{g'(g^{-1}(y))}\right| \tag{1.1}
$$

<div style="text-align: right;">
■
</div>

> 直感的説明

連続型確率変数 $X$, 関数 $g(\cdot)$, $Y = g(X)$としたとき、$$Y$$ の確率密度関数を導きたいとします.分布関数$$F_Y(y)$$は

$$
\begin{aligned}
F_Y(y) &= P(g(X)\leq y)\\
&= P(X\in \{x\mid g(x)\leq y\})
\end{aligned}
$$

$Y$の確率密度関数は、$F_Y(y)$の$y$に対する一次導関数で導けるので、

$$
\begin{aligned}
f_Y(y) &= \frac{d}{dy}F_Y(y) \\
& = \frac{d}{dy}P(X\in \{x\mid g(x)\leq y\})
\end{aligned}
$$

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

<div style="text-align: right;">
■
</div>


### 命題：累積分布関数と一様分布

> 命題 

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

従って、$$Y \sim \mathrm{U}(0, 1)$$となることがわかる.

<div style="text-align: right;">
■
</div>

### 定理：確率変数の線形変換

連続型確率変数 $$Z$$ の確率密度関数が $$f_Z(z)$$で与えられているとします. $$\mu$$を実数, $$\sigma$$を正の実数とし

$$
X = \sigma Z + \mu \tag{1.2}
$$

としたとき、$$X$$の確率密度関数は

$$
f_X(x) = \frac{1}{\sigma}f_Z\left(\frac{x-\mu}{\sigma}\right)
$$

> 証明

(1.1)に(1.2)を代入すると

$$
f_X(x) = f_Z\left(\frac{X - \mu}{\sigma}\right)\frac{1}{\sigma}
$$

<div style="text-align: right;">
■
</div>


### 練習問題
#### (1) 平方変換

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
\begin{align*}
f_X(x) &= \frac{d}{dx}F_Z(\sqrt{x}) - F_Z(-\sqrt{x})\\
&= \frac{1}{2\sqrt{x}}f_Z(\sqrt{x}) + \frac{1}{2\sqrt{x}}f_Z(-\sqrt{x}) \\
&= (f_Z(\sqrt{x}) + f_Z(-\sqrt{x}))\frac{1}{2\sqrt{x}} \tag{1.3}
\end{align*}
$$

<div style="text-align: right;">
■
</div>


#### (2) 平方変換と絶対値を用いた確率密度関数

$X$を連続型確率変数で、その確率密度関数が

$$
f_X(x) = \begin{cases}
|x| & x \in [-1, 1)\\
0 & otherwise
\end{cases}
$$

このとき, $Y = X^2$の確率密度関数は(1.3)より $f_Y(y )= 1 \text{ where } y \in [0, 1]$


> Python 
 
```python
## Library
import random
import numpy as np
import matplotlib.pyplot as plt

## Class and methods
class SampleGenerator:
    def __init__(self, sample_size, seed = 42):
        self.sample_size = sample_size
        self.seed = seed
    
    def random_sampling(self):
        """
        Return random samples which follows the density function:
          f(x) = |x| where x in (-1, 1) else 0
        
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

        mean, var =  np.mean(tmp_data), np.var(tmp_data, ddof = 1)
        print("the mean: %.3f\nthe variance: %.3f" % (mean, var))

    @staticmethod
    def inv_cumulative(prob):
        """
        the density function:
          f(x) = |x| in (-1, 1) else 0    
        """
        x = None
        if prob > 0.5:
            x = (2 * (prob - 0.5)) ** 0.5
        else:
            x = -(-2 * (prob - 0.5)) ** 0.5

        return x

def x_density(x):
    """
    the density function:
        f(x) = |x| where x in (-1, 1) else 0
    """

    return abs(x) if -1 <= x <= 1 else 0

def y_density(y):
    """
    the density function:
        f(y) = 1 wehre y in (0, 1) else 0
    """
    dens_y = 1 if 0 <= y <= 1 else 0

    return dens_y

def plot_simulation(data, grid, density_func, title, xlabel, ax = None):
    dens_vec = np.vectorize(density_func, otypes=[np.float64])

    if ax is None:
        fig, ax = plt.subplots(1, 1,figsize=(10, 7))
    
    ax.hist(data, density = True, bins = 100, label = 'sampling')
    ax.plot(grid, dens_vec(grid),lw=2, color='#A60628',label = 'True density')
    ax.set_title(title, fontsize=15)
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel('density', fontsize=12)
    ax.legend()
```

変数変換前と変数変換後のmean, varを出力してみると

```python
Experiment = SampleGenerator(100000)
Experiment.random_sampling()

print("the original data")
Experiment.describe()

print("\nthe transformed data")
Experiment.describe(transformed=1)

>> the original data
>> the mean: 0.001
>> the variance: 0.501
>> 
>> the transformed data
>> the mean: 0.501
>> the variance: 0.083
```

またランダムサンプリング及び変数変換後の分布をplotで確認してみます.

```python
xgrid = np.linspace(-1.2, 1.2, 200)
ygrid = np.linspace(-0.2, 1.2, 200)
fig, ax = plt.subplots(1, 2,figsize=(14, 7))

plot_simulation(data = Experiment.data, 
                grid = xgrid, 
                density_func = x_density,
                xlabel= 'sampling',
                title = 'density function: $f(x) = |x|$ where $x \in (-1, 1)$',
                ax = ax[0])



plot_simulation(data = Experiment.transformed_data, 
                grid = ygrid, 
                density_func = y_density,
                xlabel= 'sampling',
                title = 'density function: $f(y) = 1$ where $y \in (0, 1)$',
                ax = ax[1])
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2021-12-19%2004-46-59.png?raw=true">

#### (3) Truncated Distribution

> 問題

確率密度関数 $f(x)$ と分布関数 $F(x)$ について、適当に実数 $a$ をとって関数 $g(x)$ を

$$
g(x) = \begin{cases}
f(x)/(1 - F(a)) & x > a\\
0 & \text{ otherwise }
\end{cases}
$$

この関数をtruncated distributionといいます. これが確率密度関数になることを示します.

> 解答

定義から

$$
g(x) = f(x)/(1 - F(a))I(x>a)
$$

なので、$g(x) \geq 0$ と $\int_a^\infty f(x)/(1 - F(a))I(x>a) dx = 1$は自明. 従って、$g(x)$は確率密度関数になっている.


> 例

$$
f(x) = \begin{cases}
\exp(-x) & x > 0\\
0 & \text{ otherwise }
\end{cases}
$$

としたとき、$a = 1$のときの$g(x)$を考えたいと思います.

上記の確率密度関数が与えられた時の$F(a)$は

$$
\begin{aligned}
F(a) &= \int^a_0 \exp(-x) dx\\
&= [-\exp(-x)]^a_0\\
&= 1 - \exp(-a)
\end{aligned}
$$

なので

$$
\begin{aligned}
g(x) &= \frac{\exp(-x)}{\exp(-a)}\\
& \exp(a - x)
\end{aligned}
$$

これに $a=1$を代入すると、$g(x) = \exp(1-x)$

> Python Simulation

$$
\begin{aligned}
F(x) &= 1 - \exp(-x)\\
F^{-1}(F(x)) &= -\log(1 - F(x)) = x
\end{aligned}
$$

これに注意すると、「(2) 平方変換と絶対値を用いた確率密度関数」で用いたクラスを以下のように修正.

```python
    def random_sampling(self):
        random.seed(self.seed)
        self.data = [self.inv_cumulative(random.uniform(0, 1)) for i in range(self.sample_size)]
        self.transformed_data = list(filter(lambda x: x >= 1, self.data))

    @staticmethod
    def inv_cumulative(prob):
        x = - np.log(1 - prob)

        return x

def x_density(x):

    return np.exp(-x)

def y_density(y):
    return np.exp(1-y) if y >= 1 else 0
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210421-truncated.png?raw=true">




#### (4) 標準正規分布に従う確率変数の指数変換

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
&= \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{(\log y)^2}{2}\right)\frac{1}{y} \: (t\leq 0)
\end{aligned}
$$

$E[y], E[y^2]$は

$$
\begin{aligned}
\int_0^\infty \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{(\ln y)^2}{2}\right) dy & = \sqrt{e}\\
\int_0^\infty \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{(\ln y)^2}{2}\right) dy & = e^2
\end{aligned}
$$

と計算されます. 実際にPythonで確認してみると

```python
np.random.seed(42)
x = np.exp(np.random.normal(0, 1, 100000))
print(np.mean(x))
print(np.mean(x**2))

>>>1.6504022457562608
>>>7.323861940067089
```

と近い値が出力されることが確認できます.

## 2: 2次元変数変換
### 変数変換の公式
