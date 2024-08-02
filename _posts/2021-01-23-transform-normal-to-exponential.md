---
layout: post
title: "正規分布に従う確率変数を指数関数に変換したときの分布"
subtitle: "確率と数学ドリル 3/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-11-30
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

- [標準正規分布に従う確率変数$X$を$\exp(X)$に変換したとき](#%E6%A8%99%E6%BA%96%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AB%E5%BE%93%E3%81%86%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0x%E3%82%92%5Cexpx%E3%81%AB%E5%A4%89%E6%8F%9B%E3%81%97%E3%81%9F%E3%81%A8%E3%81%8D)
  - [密度関数の導出](#%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [平均の導出](#%E5%B9%B3%E5%9D%87%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [分散の導出](#%E5%88%86%E6%95%A3%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [Pythonで確認してみる](#python%E3%81%A7%E7%A2%BA%E8%AA%8D%E3%81%97%E3%81%A6%E3%81%BF%E3%82%8B)
- [テイラー展開で変数変換後確率変数の期待値を近似的に求める](#%E3%83%86%E3%82%A4%E3%83%A9%E3%83%BC%E5%B1%95%E9%96%8B%E3%81%A7%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B%E5%BE%8C%E7%A2%BA%E7%8E%87%E5%A4%89%E6%95%B0%E3%81%AE%E6%9C%9F%E5%BE%85%E5%80%A4%E3%82%92%E8%BF%91%E4%BC%BC%E7%9A%84%E3%81%AB%E6%B1%82%E3%82%81%E3%82%8B)
- [Appendix](#appendix)
  - [変数変換のルール](#%E5%A4%89%E6%95%B0%E5%A4%89%E6%8F%9B%E3%81%AE%E3%83%AB%E3%83%BC%E3%83%AB)
  - [標準正規分布のn次モーメントについて](#%E6%A8%99%E6%BA%96%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AEn%E6%AC%A1%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## 標準正規分布に従う確率変数$X$を$\exp(X)$に変換したとき

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$X\sim N(0, 1)$のとき, $Y = \exp(x)$という変数変換を考えたとき,$Y$の密度関数, 平均, 分散を求めよ

</div>

$Y = \exp(x)$は単調増加 & 微分可能な関数による変換であることに留意します.

### 密度関数の導出

$X, Y$の密度関数をそれぞれ$f(x), g(y)$とすると

$$
\begin{align*}
g(y) = f(\ln(y))\frac{1}{y}
\end{align*}
$$

$X$は標準正規分布に従うので

$$
g(y) = \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{[\ln(y)]^2}{2}\bigg)\frac{1}{y}
$$

### 平均の導出

$Y$の定義域が$(0, \infty)$であることに留意すると

$$
\begin{align*}
\mathbb E[Y] &= \int_0^\infty y\frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{[\ln(y)]^2}{2}\bigg)\frac{1}{y} dy\\[3pt]
&= \int_0^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{[\ln(y)]^2}{2}\bigg) dy
\end{align*}
$$

ここで$\ln(y) = t$と変数変換すると

$$
\begin{align*}
&\int_0^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{[\ln(y)]^2}{2}\bigg) dy\\[3pt]
&= \int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{t^2}{2}\bigg) \frac{dy}{dt}dt\\[3pt]
&= \int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{t^2}{2}\bigg) \exp(t) dt\\[3pt]
&= \int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{t^2-2t}{2}\bigg) dt\\[3pt]
&= \int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{(t-1)^2-1}{2}\bigg) dt\\[3pt]
&= \exp\bigg(\frac{1}{2}\bigg)\int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{(t-1)^2}{2}\bigg) dt\\[3pt]
&= \exp\bigg(\frac{1}{2}\bigg)
\end{align*}
$$

### 分散の導出

$$
V(Y) = \mathbb E[Y^2] - \mathbb E[Y]^2
$$

で定義されるので$\mathbb E[Y^2]$を求めればよい.

$$
\begin{align*}
\mathbb E[Y^2] &= \int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{t^2}{2}\bigg) \exp(2t) dt\\[3pt]
&= \int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{t^2-4t}{2}\bigg)dt\\[3pt]
&= \int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{(t-2)^2-4}{2}\bigg)dt\\[3pt]
&= \exp(2)\int_{-\infty}^\infty \frac{1}{\sqrt{2\pi}}\exp\bigg(-\frac{(t-2)^2}{2}\bigg)dt\\[3pt]
&= \exp(2)
\end{align*}
$$

したがって, 

$$
\begin{align*}
V(Y) &= \mathbb E[Y^2] - \mathbb E[Y]^2\\
     &= \exp(2) - \exp(1)\\
     &= e(e-1)
\end{align*}
$$

### Pythonで確認してみる

変数変換後のpdfに基づいた分布検定は少しめんどくさいので, 平均とthe second-momentの分布を乱数シミュレーションで確認する.

```python
#%%
import numpy as np
import plotly.express as px

np.random.seed(42)
N = 1000
LOOP = 10000
X = np.random.normal(0, 1, (N, LOOP))
Y = np.exp(X)
y_mean = np.mean(Y, axis=0)
y_second_mean = np.mean(Y**2, axis=0)


fig1 = px.histogram(y_mean, 
                    histnorm='probability density', 
                    title="""Histogram of the mean of exp(x), true-val: {:.2f}, sample-mean: {:.2f}
                             """.format(np.exp(0.5), np.mean(y_mean)))
fig1.add_vline(x=np.exp(0.5), line_dash="dash", annotation_text="mean")
fig1.show()

#%%
fig2 = px.histogram(y_second_mean, 
                    histnorm='probability density', 
                    title="""Histogram of the second moment of exp(x), true-val: {:.2f}, sample-mean: {:.2f}
                             """.format(np.exp(2), np.mean(y_second_mean)))
fig2.add_vline(x=np.exp(2), line_dash="dash", annotation_text="the second moment")
fig2.show()
```

> 平均の分布

{% include plotly/20210123_mean_hist.html %}


> the second-momentの分布

{% include plotly/20210123_second_moment_hist.html %}

## テイラー展開で変数変換後確率変数の期待値を近似的に求める

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$X\sim N(0, 1)$のとき, $Y = \exp(x)$という変数変換を考えたとき,$Y$の平均をテイラー近似で求めよ

</div>


一般に, 確率変数 $X$ の期待値を$\theta$としたとき, 関数$g(X)$の近似的な期待値はデルタ法で求めることができます. $\theta$まわりでの$g(X)$の2次のテイラー展開

$$
g(x)\approx g(\theta) + g(\theta)(x-\theta) + \frac{1}{2}g''(\theta)(x-\theta)^2
$$

の両辺について期待値を取ることで求めることができます. 

k次近似を$g_k(x)$と表すとしてまず, 2次近似で考えてみると

$$
\mathbb E[g_2(x)] = \exp(0) + \frac{1}{2} = 1.5
$$

$n$を正の整数とし, 今回は $X$ は標準正規分布に従っているので$\mathbb E[X^{2n+1}] = 0$で有ることに留意すると, $2n$近似のみを考えれば良い. $2n$近似について[Appendix]((#%E6%A8%99%E6%BA%96%E6%AD%A3%E8%A6%8F%E5%88%86%E5%B8%83%E3%81%AEn%E6%AC%A1%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6))より

$$
\begin{align*}
\mathbb E[g_{2n}(x)] &= 1  + \frac{1}{2} + \frac{1}{2}\frac{1}{4}+ \frac{1}{2}\frac{1}{4}\frac{1}{6} + \cdots + \frac{1}{2}\cdots\frac{1}{2(n-1)}\frac{1}{2n}\\[3pt]
                     &= 1 + \sum_{j=1}^{n}\bigg(\prod_{k=1}^j \frac{1}{2k}\bigg)
\end{align*}
$$

ここで, 右辺第二項について[Wolfram alpha](https://www.wolframalpha.com/input?i=%5Csum_%7Bn%3D1%7D%5E%5Cinfty%28%5Cprod_%7Bk%3D1%7D%5En+1%2F%282k%29%29)で計算してみると

$$
\lim_{n\to\infty}\sum_{j=1}^{n}\bigg(\prod_{k=1}^j \frac{1}{2k}\bigg)=\exp\bigg(\frac{1}{2}\bigg)-1
$$

従って,

$$
\lim_{k\to\infty}g_k(x) = \exp\bigg(\frac{1}{2}\bigg)
$$

となり上記で求めた答えと一致します.


### 近似誤差が$n$が大きくなるに従ってどのように変化するか？

近似誤差のオーダーについてPythonで確認すると以下のようになります


{% include plotly/20210123_taylor_approx.html %}


> Python code

```python
import math
import numpy as np
import plotly.express as px

def taylor_term(n):
    return np.sum(list(map(lambda x: (1/2)**x * 1/math.gamma(x+1), np.arange(1, n+1))))

x = 1 + np.array(list(map(taylor_term, np.arange(1, 10))))
y = np.exp(1/2)

fig = px.line(x=np.arange(1, 20), 
              y=(y-np.r_[1, np.repeat(x, 2)])/y,
              title='テイラー近似とTrue-valueのpercentage error: 6次近似で誤差は0.2%を下回る')
fig.update_xaxes(title_text="近似レベル")
fig.update_yaxes(title_text="percentage error")
fig.update_traces(hovertemplate='テイラー展開%{x}次近似<br>percentage error: %{y:.5%}')
```




References
------------

- [Ryo's Tech Blog > 変数変換のルールをまとめる](https://ryonakagami.github.io/2021/04/21/variable-transformation/)
- [Wolfram alpha > テイラー展開の項についての計算](https://www.wolframalpha.com/input?i=%5Csum_%7Bn%3D1%7D%5E%5Cinfty%28%5Cprod_%7Bk%3D1%7D%5En+1%2F%282k%29%29)
