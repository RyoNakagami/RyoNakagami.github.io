---
layout: post
title: "周期変数の平均の導出"
subtitle: "三角関数を用いた座標変換による計算"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-01-26
purpose: 
tags:

- Python
- 前処理
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [周期変数の平均の計算方法](#%E5%91%A8%E6%9C%9F%E5%A4%89%E6%95%B0%E3%81%AE%E5%B9%B3%E5%9D%87%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
  - [CIRCLE MEAN: PRML 2.3.8 周期変数より](#circle-mean-prml-238-%E5%91%A8%E6%9C%9F%E5%A4%89%E6%95%B0%E3%82%88%E3%82%8A)
  - [Pythonでの実装](#python%E3%81%A7%E3%81%AE%E5%AE%9F%E8%A3%85)
- [等差数列とCIRLCE MEAN](#%E7%AD%89%E5%B7%AE%E6%95%B0%E5%88%97%E3%81%A8cirlce-mean)
  - [Sum of sines & cosines](#sum-of-sines--cosines)
  - [等差数列のinputに対するCIRCLE MEANの性質](#%E7%AD%89%E5%B7%AE%E6%95%B0%E5%88%97%E3%81%AEinput%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8Bcircle-mean%E3%81%AE%E6%80%A7%E8%B3%AA)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 周期変数の平均の計算方法

`HH:mm:ss`形式で表現される時刻の変数や角度といった周期性を持った変数の平均を導出したいケースを考えます.

例として, 以下のような日別睡眠時間データが与えられたとき, `00:30:00`という平均時間を返してほしいというケースがモチベーションとなります.

```
## 睡眠時間 list
T = ['23:30:00',
     '00:30:00',
     '22:30:00',
     '01:30:00',
     '02:30:00']

circlemean(T)
>>> '00:30:00'
```

### CIRCLE MEAN: PRML 2.3.8 周期変数より

周期変数 $\theta_i \in [0, 2\pi)$の観測値の集合 $\theta_1, \cdots, \theta_n$の平均 $\overline \theta$を求めたいとする.

$\theta_i$から単位円上の点への写像 $F$ を以下のように設定する:

$$
F(\theta) = (\cos \theta, \sin \theta)
$$

つまり, $\theta_i$ に対応する直交座標上の観測値 $\pmb{x_i}= (\cos \theta_i, \sin \theta_i)$とする.

直交座標上の観測値の単純平均を以下のように定義する

$$
\overline{\pmb{x}} = (\overline{\pmb{x_1}}, \overline{\pmb{x_2}}  ) =  \left(\frac{1}{N}\sum^{N}_i\cos \theta_i, \frac{1}{N}\sum^{N}_i\sin \theta_i\right)
$$

なお, このとき $\overline{\pmb{x}}$は単位円の内部に必ず存在する. 

$\overline{\pmb{x}}$がなす角度を $\overline\theta$ とみなすことができるとき, $\overline\theta$ は以下のように計算できる

$$
\begin{align*}
\tan{\overline{\theta}} &= \frac{\overline{\pmb{x_2}}}{\overline{\pmb{x_1}} } = \frac{\sum_{i=1}^{n} \sin{\theta_{i}}}{\sum_{i=1}^{n} \cos{\theta_{i}}} \\
\overline{\theta} &= \arctan\left[ \frac{\sum_{i=1}^{n} \sin{\theta_{i}}}{\sum_{i=1}^{n} \cos{\theta_{i}}} \right] 
\end{align*}
$$

**導出終了**

> 注意！！

- 平均を中心に左右対称の確率変数の場合は上記の方法でcircle meanは適切に計算されると思いますが, skewの場合は誤差が発生します
- 関数 $F: R \to R^2$が今回非線形関数なので$F^{-1}F(\bar x)$と $F^{-1}\overline{F(x)}$は計算結果が異なるというのが直感的理解

### Pythonでの実装

以下の実装は基本的には `scipy.stats.circmean` のsourceコードと同じです.


```python
def circle_mean(samples, high=2*np.pi, low=0.0, nan_policy='raise', na_val=0.0):

        """Compute the circular mean for samples in a range.
    Parameters
    ----------
    samples : array_like
        Input array.
    high : float or int, optional
        High boundary for the sample range. Default is ``2*pi``.
    low : float or int, optional
        Low boundary for the sample range. Default is 0.
    nan_policy : {'impute', 'drop', 'raise'}, optional
        Defines how to handle when input contains nan. 
        'impute' fills nan values with the user specified value, 'raise' throws an error, 'drop' performs the calculations ignoring nan values. Default is 'raise'.
    na_val: float or int, optional

    Returns
    -------
    circmean : float
        Circular mean.
    """

    # Ensure samples are array-like and size is not zero
    samples = np.asarray(samples)
    if samples.size == 0:
        return np.nan, np.asarray(np.nan), np.asarray(np.nan), None

    # Recast samples as radians that range between 0 and 2 pi and calculate
    # the sine and cosine
    sin_samp = np.sin((samples - low)*2.*np.pi / (high - low))
    cos_samp = np.cos((samples - low)*2.*np.pi / (high - low))

    # Apply the NaN policy
    contains_nan = np.max(np.isnan(samples))
    if contains_nan and nan_policy == 'impute':
        mask = np.isnan(samples)
        # Set the sines and cosines that are NaN to zero
        sin_samp[mask] = na_val
        cos_samp[mask] = na_val
    elif contains_nan and nan_policy == 'drop':
        sin_samp = sin_samp[~mask] 
        cos_samp = cos_samp[~mask] 
        samples  = samples[~mask]
    else:
        if contains_nan:
            raise ValueError("The input contains nan values")

    # Compute circle mean
    sin_sum = sin_samp.sum()
    cos_sum = cos_samp.sum()
    res = np.arctan2(sin_sum, cos_sum)

    return res*(high - low)/2.0/np.pi + low
```

## 等差数列とCIRLCE MEAN

### Sum of sines & cosines

<div class="math display" style="padding-left: 2em; overflow: auto; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8">
<p class="h4">&nbsp;&nbsp;Theorem</p>

正の整数 $N$ と 実数 $a, b$について, $\sin \frac{b}{2} \neq 0$のとき, 

$$
\begin{align*}
\sum_{n=0}^{N-1} \cos(a + nd) &= R \cos (a + (N - 1) \frac{1}{2} b)\\
\sum_{n=0}^{N-1} \sin(a + nd) &= R \sin (a + (N - 1) \frac{1}{2} b)
\end{align*}
$$

ただし, 

$$
R \triangleq \frac{\sin(N \frac{1}{2}d)}{\sin(\frac{1}{2} b)}
$$

</div>

**証明**

$$
C \triangleq \sum_{n=0}^{N-1}\cos(a + nb)
$$

このとき, 両辺に $\sin \frac{b}{2} \neq 0$ を掛けると

$$
\begin{align*}
2 \sin\left(\frac{1}{2} b\right) C &= \sum_{n=0}^{N-1}2 \cos(a + nb) \sin\left(\frac{1}{2}b\right)\\
                                   &= \sum_{n=0}^{N-1} \bigg \{ \sin\bigg(a + \bigg(n + \frac{1}{2}\bigg) b\bigg) - \sin\bigg(a + \bigg(n - \frac{1}{2}\bigg) b\bigg) \bigg\}\\
                                   &= \sin\bigg(a + \bigg(N - \frac{1}{2}\bigg) b\bigg) - \sin\bigg(a - \frac{1}{2}b\bigg)
\end{align*}
$$

$\sin(x+y)−\sin(x−y)=2\cos x \sin y$ であることに留意すると

$$
2 \sin(\frac{1}{2} b) C =
2 \cos\bigg( a + (N - 1) \frac{1}{2} b \bigg) \sin\bigg( N \frac{1}{2} b \bigg)
$$

Sine sumも同様の方法で

$$
S \triangleq \sum_{n=0}^{N-1}\sin(a + nb)
$$

と定義すると

$$
2 \sin(\frac{1}{2} b) S = 2 \sin\bigg( a + (N - 1) \frac{1}{2} b \bigg) \sin\bigg( N \frac{1}{2} b \bigg)
$$

を得る.

**証明終了**

---

### 等差数列のinputに対するCIRCLE MEANの性質

上の証明より, 正の整数 $N$ と 実数 $a, b$について, $\sin \frac{b}{2} \neq 0$の場合, 

$$
\begin{align*}
\sum_{n=0}^{N-1} \cos(a + nd) &= R \cos (a + (N - 1) \frac{1}{2} b)\\
\sum_{n=0}^{N-1} \sin(a + nd) &= R \sin (a + (N - 1) \frac{1}{2} b)
\end{align*}
$$

となることがわかった. これに倣って, $\{a + (i-1)d\}_{i=1}^N$という観測値集合を考えると, Bishop 2.3.8 で紹介されていたCIRCLE MEANは

$$
\overline{\theta} = \arctan\left[ \frac{\sum_{i=1}^{n} \sin{\theta_{i}}}{\sum_{i=1}^{n} \cos{\theta_{i}}} \right] 
$$

なので

$$
\begin{align*}
\arctan\left[ \frac{\sum_{i=1}^{n} \sin{a + (i-1)d}}{\sum_{i=1}^{n} \cos{a + (i-1)d}} \right] &= \arctan\bigg[ \frac{\sin (a + (N - 1) \frac{1}{2} b)}{\cos (a + (N - 1) \frac{1}{2} b)}\bigg]\\
&= \arctan\bigg[a + (N - 1) \frac{1}{2} b\tan\left(\right)\bigg]\\
&= \frac{1}{N}\sum_{i=1}^N [a + (i-1)d]
\end{align*}
$$

となり, 「観測値の平均」と「変数変換した変数の平均比率の arctan」が一致することがわかる.


## References

> 関連ポスト


> 公式ドキュメント

- [scipy.stats.circmean](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.circmean.html)

> 書籍

- [Pattern Recognition and Machine Learning by Christopher Bishop > 2.3.8 Periodic variables](https://www.microsoft.com/en-us/research/uploads/prod/2006/01/Bishop-Pattern-Recognition-and-Machine-Learning-2006.pdf)
- [Sines and Cosines of Angles in Arithmetic Progression](https://www.maa.org/sites/default/files/Knapp200941575.pdf)