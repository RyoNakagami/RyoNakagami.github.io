---
layout: post
title: "指数分布に従う複数の独立な確率変数の最小値の分布"
subtitle: "確率と数学ドリル 2/N"
author: "Ryo"
catelog: true
mathjax: true
revise_date: 2023-10-01
header-mask: 0.0
header-style: text
tags:

- math
- 統計

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>

## 指数分布

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 指数分布の確率密度関数</ins></p>

平均が$\lambda$に従う指数分布の確率密度関数は

$$
f(x, \lambda) = \frac{1}{\lambda}\exp\bigg(-\frac{x}{\lambda}\bigg) \ \ (x\geq 0)
$$

と表現される.

</div>

ポアソン過程に従う事象の発生時間間隔を表す確率分布として知られています. 指数分布の累積分布関数は

$$
\begin{align*}
F(x, \lambda) &= \int_0^x \frac{1}{\lambda}\exp\bigg(-\frac{t}{\lambda}\bigg) dt\\[3pt]
     &= \frac{1}{\lambda}\int_0^x\exp\bigg(-\frac{t}{\lambda}\bigg) dt\\[3pt]
     &= \frac{1}{\lambda}\bigg[-\lambda\exp\bigg(-\frac{t}{\lambda}\bigg)\bigg]^x_0\\[3pt]
     &= 1 - \exp\bigg(-\frac{x}{\lambda}\bigg)
\end{align*}
$$

と表されます.

## 指数分布に従う複数の独立な確率変数の最小値の分布

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Question </ins></p>

確率変数 $X_1, X_2, \cdots, X_n$ は独立に指数分布 $\text{Exp}(\mu)$ に従うとき

$$
Y_n = \min(X_1, X_2, \cdots, X_n)
$$

が従う確率密度関数と累積分布関数を求めよ

</div>

累積分布関数を求めるのが簡単なので先に求める.

$$
\begin{align*}
1 - F_y(a) &= \Pr(Y_n > a)\\
           &= \Pr(X_1>a, X_2>a, \cdots, X_n > a)\\
           &= [1 - (1 - \exp(-a/\mu))]^n \because \text{ i.i.d }\\
           &= \exp(-na/\mu)
\end{align*}
$$

したがって 

$$
F_y(y) = 1 - \exp(-ny/\mu)
$$

確率密度関数は微分すればいいので

$$
f_y(y) = \frac{n}{\mu}\exp(-ny/\mu) \  \ \text{ where } y\geq 0
$$

### Pythonでの検証

$\mu = 1$, $n=2, 5, 10$について, Pythonで上で求めた累積分布関数に従う確率変数を乱数で発生させ, 
scipyで発生させた乱数と比較して正しそうか否か簡易的に検証してみる.

なお, $f_y(y)$ に着目すると平均 $\mu/n$ に従う指数分布と同じ形状をしているので指数分布の逆関数法サンプリングを用いて以下のように乱数を10000個それぞれ発生させる

$$
\begin{align*}
U &\sim Unif(0, 1)\\
x &= -\frac{\mu}{n} \ln U
\end{align*}
$$

ks testにかけても一応は棄却されないし, histogram上もfitは良いように見える.

{% include plotly/20210122_simulation.html %}

### 元の指数分布への分布収束

$$
Z_n = \frac{Y_n}{\ln(1 + \frac{1}{n})}
$$

という確率変数を考えてみる. 累積分布関数に着目すると

$$
\begin{align*}
\Pr(Z_n < z) &= \Pr\bigg(Y_n < z\ln\bigg(1 + \frac{1}{n}\bigg)\bigg)\\
             &= 1 - \exp\bigg(-\frac{z}{\mu} \times \ln\bigg(1 + \frac{1}{n}\bigg)^n\bigg)
\end{align*}
$$

つぎに $\plim_{n\to\infty}Z_n$を考えてみる.

$$
\lim_{n\to\infty} -\frac{z}{\mu} \times \ln\bigg(1 + \frac{1}{n}\bigg)^n = -\frac{z}{\mu}e
$$

となるので

$$
\lim_{n\to\infty} \exp\bigg(-\frac{z}{\mu} \times \ln\bigg(1 + \frac{1}{n}\bigg)^n\bigg) = \exp\bigg(-\frac{z}{\mu}\bigg)
$$


となるので $Z_n\xrightarrow{d}\text{Exp}(\mu)$と分布収束する.


## Appendix: Pythonコード

```python
import numpy as np
from scipy.stats import expon
from scipy.stats import ks_2samp
from plotly.subplots import make_subplots
import plotly.graph_objects as go

def generate_data(n, lam=1):
    size = 10000
    ## true
    r = expon.rvs(size=(size, n))
    x = np.min(r, axis=1)

    ## inverse sampling
    u = np.random.uniform(0, 1, size)
    y = -lam/n * np.log(u)

    ## ks test pval
    z = ks_2samp(x, y)[1]

    return x, y, z


#----------------
# simulation
#----------------

np.random.seed(42)

X1, Y1, pval1 = generate_data(n=2, lam=1)
X2, Y2, pval2 = generate_data(n=5, lam=1)
X3, Y3, pval3 = generate_data(n=10, lam=1)

fig = make_subplots(rows=1, cols=3, 
                    subplot_titles=("n=2, ks-pval: {:.2f}".format(pval1), 
                                    "n=5, ks-pval: {:.2f}".format(pval2), 
                                    "n=10, ks-pval: {:.2f}".format(pval3)))
tracex1 = go.Histogram(x=X1, histnorm='probability', name='min(X)')
tracey1 = go.Histogram(x=Y1, histnorm='probability', name='Y')

tracex2 = go.Histogram(x=X2, histnorm='probability', name='min(X)')
tracey2 = go.Histogram(x=Y2, histnorm='probability', name='Y')

tracex3 = go.Histogram(x=X3, histnorm='probability', name='min(X)')
tracey3 = go.Histogram(x=Y3, histnorm='probability', name='Y')

fig.append_trace(tracex1,1,1)
fig.append_trace(tracey1,1,1)

fig.append_trace(tracex2,1,2)
fig.append_trace(tracey2,1,2)

fig.append_trace(tracex3,1,3)
fig.append_trace(tracey3,1,3)

fig.update_layout(title_text="乱数シミュレーション")
fig.update_traces(opacity=0.5)

fig.show()

```
