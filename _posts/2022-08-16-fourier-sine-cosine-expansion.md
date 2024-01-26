---
layout: post
title: "フーリエ正弦展開と余弦展開"
subtitle: "フーリエ解析 5/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-24
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

- [フーリエ余弦・正弦展開](#%E3%83%95%E3%83%BC%E3%83%AA%E3%82%A8%E4%BD%99%E5%BC%A6%E3%83%BB%E6%AD%A3%E5%BC%A6%E5%B1%95%E9%96%8B)
  - [三角関数の直交性についての再確認](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%AE%E7%9B%B4%E4%BA%A4%E6%80%A7%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6%E3%81%AE%E5%86%8D%E7%A2%BA%E8%AA%8D)
  - [クロネッカーデルタを用いた余弦係数, 正弦係数の表記](#%E3%82%AF%E3%83%AD%E3%83%8D%E3%83%83%E3%82%AB%E3%83%BC%E3%83%87%E3%83%AB%E3%82%BF%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E4%BD%99%E5%BC%A6%E4%BF%82%E6%95%B0-%E6%AD%A3%E5%BC%A6%E4%BF%82%E6%95%B0%E3%81%AE%E8%A1%A8%E8%A8%98)
- [Appendix: 奇関数同士の積は偶関数](#appendix-%E5%A5%87%E9%96%A2%E6%95%B0%E5%90%8C%E5%A3%AB%E3%81%AE%E7%A9%8D%E3%81%AF%E5%81%B6%E9%96%A2%E6%95%B0)
- [Appendix: Python code for visualization](#appendix-python-code-for-visualization)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## フーリエ余弦・正弦展開

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: フーリエ余弦展開</ins></p>

関数 $f(x)$ を $0 \leq x \leq \pi$で定義された関数とする. これを

$$
f(-x) = f(x) \qquad (0 \leq x \leq \pi)
$$

と $-\pi \leq x \leq \pi$上の偶関数に拡張子, さらに

$$
f(x) = f(x + 2\pi)
$$

によって周期$2\pi$の周期関数に拡張する. このとき, $f(x)$が区分的になめらかな関数でフーリエ級数展開ができるとすると

$$
\begin{align*}
f(x) &= \frac{a_0}{2} + \sum_{n=1}^\infty a_n \cos nx \\[3pt]
a_n &= \frac{2}{\pi}\int^{\pi}_0 f(x) \cos nx\ dx
\end{align*}
$$

となり, この一連の展開のことを**フーリエ余弦級数展開**という.

</div>

もとの関数を

$$
f(-x) = -f(x) \qquad (0 \leq x \leq \pi)
$$

と展開した場合は, 

$$
\begin{align*}
f(x) &= \sum_{n=1}^\infty b_n \sin nx \\[3pt]
b_n &= \frac{2}{\pi}\int^{\pi}_0 f(x) \sin nx\ dx
\end{align*}
$$

となり, この一連の展開のことを**フーリエ正弦級数展開**という.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >例題</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem </ins></p>

関数

$$
f(x) = x \qquad (0 \leq x \leq \pi)
$$

をフーリエ余弦級数展開せよ

</div>

定義より, 


$$
\begin{align*}
f(x) &= \frac{a_0}{2} + \sum_{n=1}^\infty a_n \cos nx \\[3pt]
a_n &= \frac{2}{\pi}\int^{\pi}_0 x \cos nx\ dx
\end{align*}
$$

従って, 

$$
a_0 = \pi
$$

また, $n\neq 0$の場合は, 瞬間部分積分を用いると

|符号|第１項|第２項|
|---|---|---|
|+| $x$ | $\frac{1}{n}\sin nx$|
|-| $1$ | $-\frac{1}{n^2}\cos nx$|

となるので

$$
a_n = \begin{cases}
\displaystyle 0 & n:\text{even}\\[3pt]
\displaystyle -\frac{4}{\pi n^2} & n:\text{odd}
\end{cases}
$$

従って, 

$$
\begin{align*}
f(x) &\sim \frac{\pi}{2} - \frac{4}{\pi}\left(\cos x + \frac{\cos 3x}{9} + \frac{\cos 5x}{25} + \cdots \right)\\[3pt]
     &= \frac{\pi}{2} - \frac{4}{\pi}\sum_{n=1}^\infty \frac{\cos (2n-1)x}{2n-1}
\end{align*}
$$

なお, これは$\vert x\vert (-\pi\leq x\leq \pi)$のフーリエ級数展開と同じになる.

</div>

<br>

フーリエ級数展開との関係で考えてみると, 余弦展開を考えた場合, 定義より偶関数への拡張を行っているので $a_n$のみに注目すればいいことはわかるが, 
もともとのフーリエ級数展開では

$$
\begin{align*}
a_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} f(x) \cos nx dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 f(x) \cos nx dx
\end{align*}
$$

であることから直感的に理解できる. 正弦級数展開をするときも, 同様の理由で $b_n$のみに着目すればよく, また, 奇関数 $\times$ 奇関数 は偶関数になるので

$$
\begin{align*}
b_n &= \frac{1}{\pi}\int^{\pi}_{-\pi} f(x) \sin nx dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 f(x) \sin nx dx
\end{align*}
$$

であることからも理解できる.


<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >例題</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem </ins></p>

関数

$$
f(x) = \begin{cases}
1 & \qquad (0 \leq x < \pi/2)\\[3pt]
0 & \qquad (\pi/2 \leq x < \pi)
\end{cases}
$$

を周期$2\pi$へ拡張したときのフーリエ余弦級数展開, 正弦級数展開せよ

</div>

> **フーリエ余弦級数展開**

$n=0$のとき, 

$$
\begin{align*}
a_0 &= \frac{2}{\pi}\int^\pi_0 f(x) \ dx\\[3pt]
    &= 1
\end{align*}
$$


$n\neq 0$の場合, 

$$
\begin{align*}
a_n &= \frac{2}{\pi}\int^\pi_0 f(x) \cos nx\ dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi/2}_0 \cos nx\ dx\\[3pt]
    &= \frac{2}{\pi}\left[\frac{\sin nx}{n}\right]^{\pi/2}_0\\[3pt]
    &= \begin{cases}
        \displaystyle 0 & n:\text{even}\\[3pt]
        \displaystyle \frac{2}{\pi n} & n \equiv 1 \mod 4 \\[3pt]
        \displaystyle -\frac{2}{\pi n} & n \equiv 3 \mod 4
    \end{cases}
\end{align*}
$$

従って, 

$$
f(x) \sim \frac{1}{2} + \frac{2}{\pi}\left(\sum_{n=0}^\infty \frac{\cos (4n+1)x}{4n+1} -\sum_{n=0}^\infty \frac{\cos (4n+3)x}{4n+3} \right)
$$

{% include plotly/20220816_example_2.html %}

> **フーリエ正弦級数展開**

$$
\begin{align*}
b_n &= \frac{2}{\pi}\int^\pi_0 f(x) \sin nx\ dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi/2}_0 \sin nx\ dx\\[3pt]
    &= \frac{2}{\pi}\left[-\frac{\cos nx}{n}\right]^{\pi/2}_0\\[3pt]
    &= \begin{cases}
        \displaystyle \frac{2}{\pi n} & n:\text{odd}\\[3pt]
        \displaystyle 0 & n \equiv 0 \mod 4 \\[3pt]
        \displaystyle \frac{4}{\pi n} & n \equiv 2 \mod 4
    \end{cases}
\end{align*}
$$

従って, 

$$
f(x) \sim  \frac{2}{\pi}\left(\sum_{n=0}^\infty \sin(2n+1)x + \sum_{n=0}^\infty \frac{2\sin (4n+2)x}{4n+2} \right)
$$

{% include plotly/20220816_example_3.html %}

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >例題</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

関数

$$
f(x) = x^2
$$

を周期$2\pi$へ拡張したときの正弦級数展開せよ

</div>


> **フーリエ正弦級数展開**

$$
\begin{align*}
b_n &= \frac{2}{\pi}\int^\pi_0 f(x) \sin nx\ dx\\[3pt]
    &= \frac{2}{\pi}\int^{\pi}_0 x^2\sin nx\ dx
\end{align*}
$$

瞬間部分積分より

|符号|第一項|第二項|
|---|---|---|
|+|$x^2$|$\displaystyle -\frac{1}{n}\cos nx$|
|-|$2x$|$\displaystyle -\frac{1}{n^2}\sin nx$|
|+|$2$|$\displaystyle \frac{1}{n^3}\cos nx$|

$$
\begin{align*}
b_n &= \frac{2}{\pi}\frac{1}{n}\left[-x^2\cos nx + \frac{2\cos nx}{n^2} \right]^\pi_0\\[3pt]
    &= \begin{cases}
    \displaystyle \frac{-2\pi}{n} & n:\text{even}\\[3pt]
    \displaystyle \frac{2}{n}\left(\pi - \frac{4}{\pi n^2}\right) & n:\text{odd}
    \end{cases}
\end{align*}
$$

従って, 


$$
f(x) \sim \sum_{n=1}^\infty \frac{-2\pi}{2n} \sin 2nx + \sum_{n=1}^\infty \frac{2}{2n-1}\left(\pi - \frac{4}{\pi (2n-1)^2}\right) \sin (2n-1)x
$$

{% include plotly/20220816_example_4.html %}


</div>


### 三角関数の直交性についての再確認

[Ryo's Tech Blog > 三角関数系の直交性](https://ryonakagami.github.io/2022/08/13/triangular-functions/#%E6%AD%A3%E5%BC%A6%E9%96%A2%E6%95%B0%E3%81%AE%E7%9B%B4%E4%BA%A4%E6%80%A7)にて, 

$$
\frac{1}{\pi}\int^\pi_{-\pi}\cos m\theta \cos n\theta\ d\theta = \delta_{mn} \qquad (m,n\text{は整数})
$$

は確認しましたが,　

$$
\begin{align*}
\int^\pi_{0}\cos m\theta \cos n\theta\ d\theta,  \ \ \int^\pi_{0}\sin m\theta \sin n\theta\ d\theta, \ \ \int^\pi_{0}\cos m\theta \sin n\theta\ d\theta
\end{align*}
$$

について確認していないので念の為, ここで再確認します.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >余弦関数同士の直交性</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$m\neq 0$のとき, 偶関数同士の積は偶関数なので

$$
\begin{align*}
\int^\pi_{0}\cos m\theta \cos n\theta\ d\theta &= \frac{1}{2}\int^\pi_{-\pi}\cos m\theta \cos n\theta\ d\theta\\[3pt]
&= \frac{\pi}{2}\delta_{mn} \qquad (\delta_{mn}: \text{Kroneker delta})
\end{align*}
$$

$m=0$のとき,

$$
\begin{align*}
\int^\pi_{0}\cos 0 \cos n\theta\ d\theta &= \frac{1}{2}\int^\pi_{-\pi} \cos n\theta\ d\theta\\[3pt]
&= \pi\delta_{0n} \qquad (\delta_{0n}: \text{Kroneker delta})
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >正弦関数同士の直交性</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$m\neq 0$のとき, 奇関数同士の積は偶関数なので

$$
\begin{align*}
\int^\pi_{0}\sin m\theta \sin n\theta\ d\theta &= \frac{1}{2}\int^\pi_{-\pi}\sin m\theta \sin n\theta\ d\theta\\[3pt]
&= \frac{\pi}{2}\delta_{mn} \qquad (\delta_{mn}: \text{Kroneker delta})
\end{align*}
$$

$m=0$のとき,

$$
\begin{align*}
\int^\pi_{0}\sin 0\theta \sin n\theta\ d\theta &= \frac{1}{2}\int^\pi_{-\pi}0 \sin n\theta\ d\theta\\[3pt]
&= 0
\end{align*}
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明: 正弦関数と余弦関数の直交性</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$m,n$のいずれかが0のときは積分計算結果が0になることが自明なのでそれ以外のケースを考える.

積和の公式より

$$
\sin \alpha \cos \beta = \frac{\sin(\alpha + \beta) + \sin(\alpha - \beta)}{2}
$$

これを用いると

$$
\begin{align*}
\int^\pi_{0}\sin m\theta \cos n\theta\ d\theta 
    &= \frac{1}{2}\int^\pi_{0}\sin(m + n)\theta + \sin(m - n)\theta\ d\theta\\[3pt]
    &= \frac{1}{2}\left[-\frac{1}{m+n}\cos(m+n)\theta - \frac{1}{m-n}\cos(m-n)\theta\right]^\pi_0\\[3pt]
    &= \begin{cases}
    \displaystyle 0 & \text{if } m + n \text{: even}\\[3pt]
    \displaystyle \frac{1}{m+n} + \frac{1}{m-n} & \text{if } m + n \text{: odd}
    \end{cases}
\end{align*}
$$

従って, $m+n$が偶数のときは直交するが, それ以外のときではしない.


</div>



### クロネッカーデルタを用いた余弦係数, 正弦係数の表記

上で確認した定義にように関数$f(x)$のフーリエ余弦展開は

$$
\begin{align*}
f(x) &= \frac{a_0}{2} + \sum_{n=1}^\infty a_n \cos nx \\[3pt]
a_n &= \frac{2}{\pi}\int^{\pi}_0 f(x) \cos nx\ dx
\end{align*}
$$


と書き表せます. $a_n \ (n\neq 0)$について

積和の公式より

$$
\begin{align*}
\cos a \cos b &= \frac{\cos (a + b) + \cos (a - b)}{2}\\[3pt]
\cos^2 nx &= \frac{\cos 2nx + 1}{2}
\end{align*}
$$

なので

$$
\int^\pi_0\cos^2 nx\ dx = \frac{\pi}{2}
$$

とわかります. 従って, $n\neq 0$について

$$
a_n = \frac{\int^{\pi}_0 f(x) \cos nx\ dx}{\int^\pi_0\cos^2 nx\ dx}
$$

また, $n=0$については

$$
\int^\pi_0\cos^2 0\ dx = \pi
$$

より

$$
a_0 = \frac{2}{\int^\pi_0\cos^2 0\ dx}\int^{\pi}_0 f(x) \cos 0\ dx
$$


この２つを合わせると, フーリエ余弦係数はクロネッカーデルタを用いて以下のように表現できます

$$
a_n = (1 + \delta_{0n})\frac{\int^{\pi}_0 f(x) \cos nx\ dx}{\int^\pi_0\cos^2 nx\ dx}
$$

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >例: 正弦係数の表現</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

正弦係数も同様に

$$
\begin{align*}
f(x) &= \sum_{n=1}^\infty b_n \sin nx \\[3pt]
b_n &= \frac{2}{\pi}\int^{\pi}_0 f(x) \sin nx\ dx
\end{align*}
$$

とフーリエ正弦展開は表される. 積和の公式より

$$
\sin a\sin b = -\frac{\cos (a + b) - \cos (a-b)}{2}
$$

これより

$$
\int^\pi_0 \sin nx\ dx = \frac{\pi}{2}
$$

を得る.

従って, 


$$
b_n = \frac{\int^{\pi}_0 f(x) \sin nx\ dx}{\int^\pi_0\sin^2 nx\ dx}
$$

と表現できることがわかる.


</div>


## Appendix: 奇関数同士の積は偶関数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Theorem</ins></p>

$$
\text{奇関数} \times \text{奇関数} = \text{偶関数} 
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$f(x), g(x)$が共に奇関数とする. $h(x) = f(x) \cdot g(x)$とすると

$$
\begin{align*}
h(x) &= f(x) \cdot g(x)\\
     &= -f(x) \cdot -g(x)\\
     &= f(-x) \cdot g(-x)\\
     &= h(-x)
\end{align*}
$$

従って, $h(x)$は偶関数である.

</div>

## Appendix: Python code for visualization

```python
import plotly.express as px
import numpy as np
from IPython.display import display, HTML
import plotly

plotly.offline.init_notebook_mode()
display(HTML(
    '<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_SVG"></script>'
))

# 定数

def constant_fourier(x, max_n):
    y = 1/2
    term = 0
    while max_n + 1 > term:
        y += 2/np.pi * (np.cos((4*term + 1) * x) / (4*term + 1) - np.cos((4*term + 3) * x) / (4*term + 3)) 
        term += 1

    return y

## 偶関数
def f_x(x):
    if x >= 0 and x < np.pi/2:
        return 1
    elif x >= np.pi/2 and x < np.pi:
        return 0
    elif x < 0:
        return f_x(-x)
    else:
        return f_x(x-2*np.pi)

x = np.linspace(-2*np.pi*1.1, 2*np.pi*1.1, 700)
y, y2, y3 = constant_fourier(x, max_n=5), constant_fourier(x, max_n=10), constant_fourier(x, max_n=100)
y4 = np.vectorize(f_x)(x)

fig = px.line(x=x, y=[y, y2, y3, y4], 
              render_mode='SVG', 
              title='フーリエ余弦展開例<br><sup>opacity=.6 , n = 5, 10, 100</sup>',
              )
newnames = {'wide_variable_0':'n=10', 
            'wide_variable_1':'n=20',
            'wide_variable_2':'n=200',
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
```



References
----------
- [高校数学の美しい物語 > 偶関数と奇関数の意味，性質などまとめ ](https://manabitimes.jp/math/1052)
- [フーリエ解析（理工系の数学入門コース［新装版］）](https://pro.kinokuniya.co.jp/search_detail/product?ServiceCode=1.0&UserID=PLATON&isbn=9784000298889&lang=en-US&search_detail_called=1&table_kbn=A%2CE%2CF)
- [Ryo's Tech Blog > 三角関数系の直交性](https://ryonakagami.github.io/2022/08/13/triangular-functions/)
