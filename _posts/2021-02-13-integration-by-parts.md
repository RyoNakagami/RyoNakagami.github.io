---
layout: post
title: "部分積分練習帳"
subtitle: "統計のための数学 4/N"
author: "Ryo"
catelog: true
mathjax: true
last_modified_at: 2023-12-11
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

- [部分積分](#%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86)
  - [三角関数と部分積分](#%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%A8%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86)
  - [ベータ分布密度関数の分子に似た関数と部分積分](#%E3%83%99%E3%83%BC%E3%82%BF%E5%88%86%E5%B8%83%E5%AF%86%E5%BA%A6%E9%96%A2%E6%95%B0%E3%81%AE%E5%88%86%E5%AD%90%E3%81%AB%E4%BC%BC%E3%81%9F%E9%96%A2%E6%95%B0%E3%81%A8%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86)
  - [自然対数と部分積分](#%E8%87%AA%E7%84%B6%E5%AF%BE%E6%95%B0%E3%81%A8%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86)
  - [ネイピア数と部分積分](#%E3%83%8D%E3%82%A4%E3%83%94%E3%82%A2%E6%95%B0%E3%81%A8%E9%83%A8%E5%88%86%E7%A9%8D%E5%88%86)
- [Appendix: 三角関数の公式](#appendix-%E4%B8%89%E8%A7%92%E9%96%A2%E6%95%B0%E3%81%AE%E5%85%AC%E5%BC%8F)
- [Appendix: Python code](#appendix-python-code)
  - [ベータ関数もどきのplot](#%E3%83%99%E3%83%BC%E3%82%BF%E9%96%A2%E6%95%B0%E3%82%82%E3%81%A9%E3%81%8D%E3%81%AEplot)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 部分積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Proposition: 部分積分</ins></p>

関数 $f,g$ について以下が成立する

$$
\int^b_a f^{\prime}(x)g(x) = [f(x)g(x)]^b_a - \int^b_a f(x)g^{\prime}(x)
$$

</div>

証明は積の微分公式から導くことができます

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$G(x)$ を $g(x)$の原始関数とすると

$$
\begin{align*}
&(f(x)G(x))^{\prime} = f^{\prime}(x)g(x) + f(x)g(x)\\[3pt]
&\Leftrightarrow f(x)g(x)\ = (f(x)G(x))^{\prime} - f^{\prime}(x)g(x)
\end{align*}
$$

両辺を $x$で不定積分すると

$$
\int f(x)g(x)\ = f(x)G(x) - \int f^{\prime}(x)g(x)
$$

両辺 $a$ から $b$ で定積分すると

$$
\int^b_a f(x)g(x)\ = [f(x)G(x)]^b_a - \int^b_a f^{\prime}(x)g(x)
$$

</div>

### 三角関数と部分積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

自然数$n$について, 以下を計算せよ

$$
I_n = \int^{\pi/2}_0\sin^nxdx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$d\cos x = -\sin x dx$であるので与えられた定積分を以下のように変換します

<div class="math display" style="overflow: auto">
$$
\begin{align*}
I_n &= \int^{\pi/2}_0\sin^nxdx \\[3pt]
    &= [-\cos x\sin^{n-1}x]^{\pi/2}_0 + \int^{\pi/2}_0(n-1)\sin^{n-2}x\cos^2xdx \\[3pt]
    &= \int^{\pi/2}_0(n-1)\sin^{n-2}x(1-\sin^2x)dx \\[3pt]
    &= (n-1)\int^{\pi/2}_0\sin^{n-2}xdx - (n-1)\int^{\pi/2}_0\sin^nxdx\\[3pt]
    &= (n-1)I_{n-2} - (n-1)I_{n}
\end{align*}
$$
</div>

従って, 

$$
I_n = \frac{n-1}{n}I_{n-2}
$$

また,

$$
\begin{align*}
I_0 &= \int^{\pi/2}_0\sin^0xdx = \frac{\pi}{2}\\[3pt]
I_1 &= \int^{\pi/2}_0\sin xdx = 1
\end{align*}
$$

帰納法より

<div class="math display" style="overflow: auto">
$$
\begin{align*}
I_n = \begin{cases}
\frac{n-1}{n}\frac{n-3}{n-2}\cdots\frac{1}{2}\frac{\pi}{2} & n\text{が偶数}\\[3pt]
\frac{n-1}{n}\frac{n-3}{n-2}\cdots\frac{2}{3}\times 1 & n\text{が奇数}
\end{cases}
\end{align*}
$$
</div>


</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

以下の定積分を計算せよ

$$
\int^\pi_0 x\cos x dx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\int^\pi_0 x\cos x dx &= \bigg[x\sin x\bigg]^\pi_0 - \int^\pi_0\sin xdx\\[3pt]
                      &= -\bigg[-\cos x\bigg]^\pi_0\\[3pt]
                      &= -2
\end{align*}
$$


</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

次の不定積分を求めよ

$$
\int x\sin x\cos xdx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答パターン1</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\sin x\cos x = \frac{1}{2}\sin 2x
$$

を用いて


<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int x\sin x\cos xdx &= \frac{1}{2}\int x \sin2xdx\\[3pt]
                     &= -\frac{1}{4}x\cos2x - \bigg(\int-\frac{1}{4}\cos 2x dx\bigg)\\[3pt]
                     &= -\frac{1}{4}x\cos2x + \frac{1}{8}\sin 2x + C
\end{align*}
$$
</div>


</div>

----

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答パターン2</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int x\sin x\cos xdx &= \frac{1}{2}x\sin^2x - \int\frac{1}{2}\sin^2xdx\\[3pt]
                     &= \frac{1}{2}x\sin^2x - \int\frac{1}{2}(1-\cos^2x)dx\\[3pt]
                     &= \frac{1}{2}x\sin^2x - \int\frac{1}{4}(1-\cos2x)dx\\[3pt]
                     &= \frac{1}{2}x\sin^2x  - \frac{x}{4} + \frac{\sin2x}{8} + C
\end{align*}
$$
</div>

</div>

---

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$$
\int^1_0 x\arctan x dx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\int^1_0 x\arctan x dx\\[3pt]
&= \left[\frac{1}{2}x^2\arctan x\right]^1_0 - \int^1_0 \frac{x^2}{2}\frac{1}{1+x^2} dx\\[3pt]
&= \frac{\pi}{8} - \int^1_0 \frac{1}{2}\left(1 - \frac{1}{1+x^2}\right) dx\\[3pt]
&= \frac{\pi}{8} - \frac{1}{2} + \left[\frac{1}{2}\arctan x\right]^1_0\\[3pt]
&= \frac{\pi}{4}-\frac{1}{2}
\end{align*}
$$

</div>




### ベータ分布密度関数の分子に似た関数と部分積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

自然数$n$に対して次の定積分を計算せよ

$$
\int^b_a(x-a)(b-x)^ndx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\int^b_a(x-a)(b-x)^ndx &= \int^b_a\exp(x)(x-a)\bigg(-\frac{(b-x)^{n+1}}{n+1}\bigg)^{\prime}dx\\[3pt]
                       &= \bigg[-(x-a)\frac{(b-x)^{n+1}}{n+1}\bigg]^b_a + \int^b_a\frac{(b-x)^{n+1}}{n+1}dx\\[3pt]
                       &= \int^b_a\frac{(b-x)^{n+1}}{n+1}dx\\[3pt]
                       &= \bigg[-\frac{(b-x)^{n+2}}{(n+2)(n+1)}\bigg]^b_a\\[3pt]
                       &= \frac{(b-a)^{n+2}}{(n+2)(n+1)}
\end{align*}
$$
</div>

</div>



なお, 関数 $(x-a)(b-x)^n$をパラメーター$n$に応じてplotすると以下のようになります

{% include plotly/20210213_figure_01.html %}

### 自然対数と部分積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

以下の不定積分をもとめよ

$$
\int x^2\log x dx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\int x^2\log x dx &= \frac{1}{3}x^3\log x - \int \frac{1}{3}x^2dx\\[3pt]
                  &= \frac{x^3}{3}\log x - \frac{x^3}{9} + C
\end{align*}
$$

</div>

----

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

以下の不定積分をもとめよ

$$
\int\frac{\log x}{\sqrt{x}}dx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
&\int\frac{\log x}{\sqrt{x}}dx\\[3pt]
&= (2\sqrt{x}\log x) - \int 2\frac{1}{\sqrt{x}}dx\\[3pt]
&= 2\sqrt{x}\log x - 4\sqrt{x} + C
\end{align*}
$$


</div>

----

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

次の定積分をもとめよ

$$
\int^e_1 x\log xdx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\int^e_1 x\log xdx &= \bigg[\frac{1}{2}x^2\log x\bigg]^e_1 - \int^e_1\frac{1}{2}xdx\\[3pt]
                   &= \bigg[\frac{1}{2}x^2\log x\bigg]^e_1 - \bigg[\frac{1}{4}x^2\bigg]^e_1\\[3pt]
                   &= \frac{e^2 + 1}{4}
\end{align*}
$$

</div>



### ネイピア数と部分積分

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

以下の不定積分をもとめよ

$$
\int x(\exp(x) + \exp(-x))dx
$$

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\int x(\exp(x) + \exp(-x))dx &= x (\exp(x) - \exp(-x)) - \int  (\exp(x) - \exp(-x)) dx\\[3pt]
                             &= x (\exp(x) - \exp(-x)) - \exp(x) - \exp(-x) + C\\[3pt]
                             &= (x - 1)\exp(x) - (x + 1)\exp(-x) 
\end{align*}
$$

</div>

## Appendix: 三角関数の公式

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>２倍角の公式</ins></p>

$$
\begin{align*}
\sin2\theta &= 2\cos\theta\sin\theta\\[3pt]
\cos2\theta &= \cos^2\theta - \sin^2\theta\\
            &= 2\cos^2\theta - 1\\
            &= 1 - 2\sin^2\theta\\[3pt]
\tan2\theta &= \frac{2\tan\theta}{1-\tan^2\theta}
\end{align*}
$$
</div>

証明はそれぞれ以下のように加法定理より示せる.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >証明</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$$
\begin{align*}
\sin(\theta + \theta) &= \sin\theta\cos\theta + \cos\theta\sin\theta\\
                      &= 2\cos\theta\sin\theta\\[3pt]
\cos2\theta &= \cos\theta\cos\theta - \sin\theta\sin\theta\\
            &= \cos^2\theta - \sin^2\theta\\[3pt]
\tan2\theta &= \frac{\tan\theta + \tan\theta}{1 - \tan\theta\tan\theta}\\
            &= \frac{2\tan\theta}{1-\tan^2\theta}
\end{align*}
$$

</div>


## Appendix: Python code
### ベータ関数もどきのplot

```python
import numpy as np
import plotly.express as px

from IPython.display import display, HTML
import plotly
## Tomas Mazak's workaround
plotly.offline.init_notebook_mode()
display(HTML(
    '<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_SVG"></script>'
))
    
def pdf(x, a, b ,n):
    return (n+1)* (n+2) *(x - a) * (b - x) ** n / (b-a)**(n+2)

a = 0
b = 1
n = 4

x = np.linspace(0, 1, 100)
y = pdf(x, a, b , n)

fig = px.line(x=x, 
              y=[pdf(x, a, b, 1), pdf(x, a, b, 2), pdf(x, a, b, 4), pdf(x, a, b, 8)],
              title=r'$\text{Plot function} \int^b_a(x-a)(b-x)^ndx \text{ where } a = 0, b = 1$', 
              render_mode='SVG')

newnames = {'wide_variable_0':'N = 1', 
            'wide_variable_1':'N = 2',
            'wide_variable_2':'N = 4',
            'wide_variable_3':'N = 8'}

fig.for_each_trace(lambda t: t.update(name = newnames[t.name],
                                      legendgroup = newnames[t.name],
                                      hovertemplate = t.hovertemplate.replace(t.name, newnames[t.name])
                                     )
                  )
fig.show()
```






References
---------
- [Ryo's Tech Blog > 置換積分を用いて基本統計量を計算する](https://ryonakagami.github.io/2021/02/07/daily-statistics-quiz/)
- [高校数学の美しい物語 > ウォリスの公式とその3通りの証明](https://manabitimes.jp/math/760)
