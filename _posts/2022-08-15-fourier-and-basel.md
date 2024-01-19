---
layout: post
title: "フーリエ級数展開とバーゼル問題の関係性"
subtitle: "フーリエ解析 4/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-19
header-mask: 0.0
header-style: text
tags:

- math
- フーリエ解析
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [$f(x)=x^2$を周期的に拡張した関数のフーリエ係数](#fxx%5E2%E3%82%92%E5%91%A8%E6%9C%9F%E7%9A%84%E3%81%AB%E6%8B%A1%E5%BC%B5%E3%81%97%E3%81%9F%E9%96%A2%E6%95%B0%E3%81%AE%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E4%BF%82%E6%95%B0)
- [バーゼル問題とフーリエ展開](#%E3%83%90%E3%83%BC%E3%82%BC%E3%83%AB%E5%95%8F%E9%A1%8C%E3%81%A8%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E5%B1%95%E9%96%8B)
- [Appendix: フーリエ級数展開plot用Pythonプログラム](#appendix-%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E7%B4%9A%E6%95%B0%E5%B1%95%E9%96%8Bplot%E7%94%A8python%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## $f(x)=x^2$を周期的に拡張した関数のフーリエ係数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$f(x) = x^2 \ \ (-\pi\leq x < \pi)$を$f(x + 2\pi) = f(x)$と周期的に拡張した関数を$\tilde f(x)$としたとき, その拡張した関数のフーリエ係数を求めよ

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$\tilde f(x)$は偶関数なのでフーリエ余弦展開のみで十分であるので

$$
\begin{align*}
a_0 &= \frac{1}{\pi}\int_{-\pi}^\pi x^2\ dx\\[3pt]
    &= \frac{2}{\pi}\int_{0}^\pi x^2\ dx\\[3pt]
    &= \frac{2\pi^2}{3}\\
    \\
a_n &= \frac{1}{\pi}\int_{-\pi}^\pi x^2\cos nx\ dx\\[3pt]
    &= \frac{2}{\pi}\int_{0}^\pi x^2\cos nx\ dx\\[3pt]
    &= 4\frac{(-1)^n}{n^2}
\end{align*}
$$

従って, 

$$
\tilde f(x) \sim \frac{\pi^2}{3} + 4\sum_{n=1}^\infty \frac{(-1)^n}{n^2}\cos nx
$$

{% include plotly/20220815_squaredx.html %}

</div>

## バーゼル問題とフーリエ展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>バーゼル問題</ins></p>

平方数の逆数和は$\displaystyle \frac{\pi^2}{6}$ に収束する. つまり,

$$
\sum_{n=1}^\infty\frac{1}{n^2} = \frac{\pi^2}{6}
$$

</div>

この収束は上でもとめたフーリエ級数展開から理解することができます

$$
\tilde f(x) \sim \frac{\pi^2}{3} + 4\sum_{n=1}^\infty \frac{(-1)^n}{n^2}\cos nx
$$

に対し, $x = \pi$を代入すると

$$
\pi^2 = \frac{\pi^2}{3} + \sum_{n=1}^\infty \frac{4}{n^2}
$$

これを整理すると

$$
\begin{align*}
\frac{2}{3}\pi^2 &= \sum_{n=1}^\infty \frac{4}{n^2}\\[3pt]
\Rightarrow \frac{\pi^2}{6} &= \sum_{n=1}^\infty \frac{1}{n^2}
\end{align*}
$$

従って, バーゼル問題の級数を得ることが出来ました.





## Appendix: フーリエ級数展開plot用Pythonプログラム


```python
import plotly.express as px
import numpy as np

## LaTex記述用
from IPython.display import display, HTML
import plotly

plotly.offline.init_notebook_mode()
display(HTML(
    '<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_SVG"></script>'
))

## 級数展開
def fourier(x, max_n):
    y = np.pi ** 2 / 3
    term = 1
    while max_n + 1 > term:
        y += 4 * ((-1) ** term) * np.cos(term * x) / np.power(term, 2)
        term += 1

    return y

## True Function
def f_x(x):
    if x >= -np.pi and x < np.pi:
        return x ** 2
    elif x < -np.pi:
        return f_x(x+2*np.pi)
    else:
        return f_x(x-2*np.pi)
    

## Plot
x = np.linspace(-3*np.pi*1.1, 3*np.pi*1.1, 1000)
y, y2, y3 = fourier(x, max_n=1), fourier(x, max_n=2), fourier(x, max_n=100)
y4 = np.vectorize(f_x)(x)


fig = px.line(x=x, y=[y, y2, y3, y4], 
              render_mode='SVG', 
              title='フーリエ級数展開例<br><sup>opacity=.6 , n = 1, 2, 100</sup>',
              )
newnames = {'wide_variable_0':'n=1', 
            'wide_variable_1':'n=2',
            'wide_variable_2':'n=3',
            'wide_variable_3':'true'}
fig.update_traces(opacity=.8)
fig.for_each_trace(lambda t: t.update(name = newnames[t.name],
                                      legendgroup = newnames[t.name],
                                      hovertemplate = t.hovertemplate.replace(t.name, newnames[t.name])
                                     )
                  )
fig.update_xaxes(tickangle=0,
                 tickmode = 'array',
                 tickvals = [-3*np.pi, -2*np.pi, -3/2*np.pi, -np.pi, -1/2*np.pi, 
                             0, 1/2*np.pi, np.pi, 3/2*np.pi, 2*np.pi, 3*np.pi],
                 ticktext=['$-3\pi$', '$-2\pi$', '', '$-\pi$', '', '0', '', '$\pi$', '', '$2\pi$', '$3\pi$'])
fig.show()
fig.write_html('test.html')
```
