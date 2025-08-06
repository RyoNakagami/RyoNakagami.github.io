---
layout: post
title: "機械学習モデル精度の評価"
subtitle: "二値分類におけるMetricsの紹介"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-04-11
tags:

- Metrics
- 統計
- Python
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [２標本問題のノンパラメトリック検定](#%EF%BC%92%E6%A8%99%E6%9C%AC%E5%95%8F%E9%A1%8C%E3%81%AE%E3%83%8E%E3%83%B3%E3%83%91%E3%83%A9%E3%83%A1%E3%83%88%E3%83%AA%E3%83%83%E3%82%AF%E6%A4%9C%E5%AE%9A)
  - [ウィルコクソンの順位和検定(Wilcoxon rank sum test)](#%E3%82%A6%E3%82%A3%E3%83%AB%E3%82%B3%E3%82%AF%E3%82%BD%E3%83%B3%E3%81%AE%E9%A0%86%E4%BD%8D%E5%92%8C%E6%A4%9C%E5%AE%9Awilcoxon-rank-sum-test)
    - [厳密手法](#%E5%8E%B3%E5%AF%86%E6%89%8B%E6%B3%95)
- [ブログ関連記事](#%E3%83%96%E3%83%AD%E3%82%B0%E9%96%A2%E9%80%A3%E8%A8%98%E4%BA%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## ２標本問題のノンパラメトリック検定

２つのグループ(T, C)があるとします. 
それぞれのグループについて$(n, m)$のサンプルを観測し、互いに独立に確率密度関数Tグループは$f(x)$, Cグループは$g(x)$に従うものとします.

$$
\begin{align*}
\text{Group T} &= \{X_1, \cdots, X_n\}\\
\text{Group C} &= \{Y_1, \cdots, Y_m\}
\end{align*}
$$

このとき、２つの分布が等しいという仮説

$$
H_0: f(x) = g(x)
$$

を検定することを考えます.

### ウィルコクソンの順位和検定(Wilcoxon rank sum test)

#### 厳密手法

1. $K = n + m$を計算
2. 比較したい２標本の観測値に全体順位（Rank, 昇順）をつけ、その値を$R_i$とする(観測値にタイ（同一順位）がある場合は、順位の平均値)
3. グループごとに順位の合計: $w_j = \sum_{i \in j}R_i $ $\  \ ,j \in \\{T, C\\}$を計算
4. $n, m$を比較し、観測数が少ない方の$w_j$をウィルコクソンの順位和統計量$W$として計算
5. $P(W_j \leq W)$を計算し、p-valueを求める


> 背景

$$
H_0: f(x) = g(x)
$$

が正しい場合、$X_1, \cdots, X_n, Y_1, \cdots, Y_m$はすべて同一の分布に従うので$R_1, \cdots, R_n$が
$\\{1, \cdots, K\\}$の中の任意の$n$個の数$r_1, \cdots, r_n$を取る確率はすべて等しく

$$
P(R_1 = r_1, \cdots, R_n = r_n) = \frac{1}{K(K-1)\cdots(K-n+1)}
$$

となります. この帰無仮説の下で、順位和は分布の形に無関係で計算できるので、ノンパラメトリック検定と分類されます.

> Pythonでの実装

```python
def ranksums(x, y):
    """Compute the Wilcoxon rank-sum statistic for two samples.
    
    Parameters
    ----------
    x,y : array_like
        The data from the two samples.
    
    Returns
    -------
    w : float
        The rank sum statistic 

    pvalue : float
        The p-value of the test.


    distribution : array
        The rank sum statistic distribution

    Remarks
    -------
    len(x), len(y) should be lower than 20
    """
    x, y = map(np.asarray, (x, y))
    n1 = len(x)
    n2 = len(y)
    alldata = np.concatenate((x, y))
    sorter = np.argsort(alldata) ## get the sorted index

    inv = np.empty(sorter.size, dtype=np.intp)
    inv[sorter] = np.arange(sorter.size, dtype=np.intp) ## rank the element

    alldata = alldata[sorter]
    obs = np.r_[True, alldata[1:] != alldata[:-1]] #先頭はTrue
    dense = obs.cumsum()[inv]

    # cumulative counts of each unique value
    count = np.r_[np.nonzero(obs)[0], len(obs)] #extract the nonzero index and add the length at the last
    ranked = .5 * (count[dense] + count[dense - 1] + 1)

    x, y = ranked[:n1], ranked[n1:]
    idx = np.argmin([n1, n2])
    w = [np.sum(x, axis=0), np.sum(y, axis=0)][idx]
    n_length = [n1, n2][idx]

    simulated_array = np.sum(list(combinations(np.arange(1, n1+n2+1), n_length)), axis = 1)
    p_value = 1 - abs(np.sum(simulated_array <= w)/len(simulated_array) -.5) * 2

    simulated_array = np.sort(simulated_array)
    simulated_obs = np.r_[True, simulated_array[1:] != simulated_array[:-1]]
    i = np.append(np.where(simulated_array[1:] != simulated_array[:-1]), len(simulated_array) - 1) ## return the index
    z = np.diff(np.append(-1, i))

    distribution = [simulated_array[simulated_obs], np.cumsum(z)/len(simulated_array)]
    
    return w, p_value, distribution


## test
sample1 = [30, 20, 52]
sample2 = [40, 50, 35, 60]

ranksums(sample1, sample2)
>>> 9.0
>>> 0.2
>>>  [array([ 6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18]),
      array([0.02857143, 0.05714286, 0.11428571, 0.2       , 0.31428571,
             0.42857143, 0.57142857, 0.68571429, 0.8       , 0.88571429,
             0.94285714, 0.97142857, 1.        ])])
```



## ブログ関連記事

- [機械学習モデル精度の評価, 二値分類におけるMetricsの紹介](https://ryonakagami.github.io/2022/02/02/model-evaluation-01/)


## References

- [scipy.stats.ranksums](https://scipy.github.io/devdocs/reference/generated/scipy.stats.ranksums.html)
