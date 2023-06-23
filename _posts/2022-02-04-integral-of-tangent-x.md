---
layout: post
title: "タンジェントのN乗の区間積分と数列"
subtitle: "H31東京大学大学院工学研究科入試問1を題材に"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
uu_cnt: 100
session_cnt: 100 
tags:

- math
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題: H31東京大学大学院工学研究科入試問1](#%E5%95%8F%E9%A1%8C-h31%E6%9D%B1%E4%BA%AC%E5%A4%A7%E5%AD%A6%E5%A4%A7%E5%AD%A6%E9%99%A2%E5%B7%A5%E5%AD%A6%E7%A0%94%E7%A9%B6%E7%A7%91%E5%85%A5%E8%A9%A6%E5%95%8F1)
  - [(1): $I_0$, $I_1$, $I_2$を計算せよ](#1-i_0-i_1-i_2%E3%82%92%E8%A8%88%E7%AE%97%E3%81%9B%E3%82%88)
  - [(2): $n\geq 2$のとき、$I_n$を計算せよ](#2-n%5Cgeq-2%E3%81%AE%E3%81%A8%E3%81%8Di_n%E3%82%92%E8%A8%88%E7%AE%97%E3%81%9B%E3%82%88)
  - [Pythonでの確認方法](#python%E3%81%A7%E3%81%AE%E7%A2%BA%E8%AA%8D%E6%96%B9%E6%B3%95)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題: [H31東京大学大学院工学研究科入試問1](https://www.t.u-tokyo.ac.jp/shared/admission/data/H31_suugaku_J)

非負の整数$n$に対して$I_n$を以下のように定義します

$$
I_n = \int_0^{\pi/4} \tan^n xdx
$$

1. $I_0$, $I_1$, $I_2$を計算せよ
2. $n\geq 2$のとき、$I_n$を計算せよ

### (1): $I_0$, $I_1$, $I_2$を計算せよ

$$
\begin{align*}
I_0 &= \int_0^{\pi/4} \tan^0 xdx\\
&= \int_0^{\pi/4} 1 dx\\
&= \frac{\pi}{4} 
\end{align*}
$$

$$
\begin{align*}
I_1 &= \int_0^{\pi/4} \tan xdx\\
&= \int_0^{\pi/4} \frac{\sin x}{\cos x}dx\\
&= [-\log |\cos x|]^{\pi/4}_0\\
&= \frac{1}{2}\log 2
\end{align*}
$$

$$
\begin{align*}
I_2 &= \int_0^{\pi/4} \tan^2 xdx\\
&= \int_0^{\pi/4} 1+\tan^2 xdx - \int_0^{\pi/4} 1 dx\\
&= [\tan x]_0^{\pi/4} - \frac{\pi}{4}\\
&= 1 - \frac{\pi}{4}
\end{align*}
$$

### (2): $n\geq 2$のとき、$I_n$を計算せよ

<div class="math display" style="overflow: auto">
$$
\begin{align*}
I_n &= \int_0^{\pi/4} \tan^n xdx\\
&= \int_0^{\pi/4} \tan^{n-2} x\tan^2 xdx\\
&= \int_0^{\pi/4} \tan^{n-2} x\frac{\sin^2 x}{\cos^2 x} xdx\\
&= \int_0^{\pi/4} \tan^{n-2} x\left(1 - \frac{1}{\cos^2 x}\right) xdx\\
&= \int_0^{\pi/4} \tan^{n-2} x dx- \int_0^{\pi/4} \frac{\tan^{n-2} x}{\cos^2 x}dx \quad\quad\tag{1.1}
\end{align*}
$$
</div>

(1.1)の第一項は$I_{n-2}$と一致することがわかります. 第二項については、$t = \tan x$と変数変換すると

$$
\frac{dx}{dt}= \frac{1}{\cos^2 x}
$$

に留意すると

$$
\begin{align*}
\int_0^{\pi/4} \frac{\tan^{n-2} x}{\cos^2 x}dx &= \int_0^{\pi/4} t^{n-2} dt\\
&= \frac{1}{n-1}[\tan^{n-2} x]_0^{\pi/4}\\
&= \frac{1}{n-1}
\end{align*}
$$

従って、

$$
I_n = \frac{1}{n-1} - I_{n-2} 
$$

$I_{0}, I_{1}$については(1)ですでに求めてあるので、$n\geq 2$について, $k\in \mathbb N$としたとき

$$
I_n = \begin{cases}
(-1)^k\frac{\pi}{4} + \sum_{i=1}^k (-1)^{i+k}\frac{1}{2i - 1} & \text{ where } \ \ n = 2k\\[8pt]
(-1)^k\frac{\log 2}{2} + \sum_{i=1}^k (-1)^{i}\frac{1}{2i} & \text{ where } \ \ n = 2k + 1
\end{cases}
$$

### Pythonでの確認方法

```python
import scipy.integrate as integrate
import numpy as np
import matplotlib.pyplot as plt

def simulate_integrate_tan(power):
    n_range = np.arange(0, power+1)
    func = np.vectorize(lambda n: integrate.quad(lambda x: np.tan(x)**n, 0, np.pi/4)[0])
    return func(n_range)

def simulate_integrate_tan_series(power):
    if power == 0:
        return np.pi/4
    elif power == 1:
        return np.log(2)/2
    else:
        return 1/(power - 1) - simulate_integrate_tan_series(power - 2)

def vectorize_simulate_integrate_tan_series(power):
    n_range = np.arange(0, power+1)
    func = np.vectorize(lambda n: simulate_integrate_tan_series(power =n))
    return func(n_range)


## simulation
### set parameter
POWER = 100

### simulation
naive_result = simulate_integrate_tan(power=POWER)
analysis_result = vectorize_simulate_integrate_tan_series(power=POWER)

np.allclose(naive_result, analysis_result)
```


## References

- [H31東京大学大学院工学研究科入試問1](https://www.t.u-tokyo.ac.jp/shared/admission/data/H31_suugaku_J)