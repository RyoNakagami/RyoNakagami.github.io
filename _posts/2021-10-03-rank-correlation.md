---
layout: post
title: "順位相関係数: Spearman と Kendall"
subtitle: "相関係数 4/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-03-02
tags:

- 統計検定
- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [順位相関係数](#%E9%A0%86%E4%BD%8D%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0)
- [Spearmanの相関係数](#spearman%E3%81%AE%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0)
  - [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [Spearmanの相関係数の定義](#spearman%E3%81%AE%E7%9B%B8%E9%96%A2%E4%BF%82%E6%95%B0%E3%81%AE%E5%AE%9A%E7%BE%A9)
  - [性質: Outlier Robust](#%E6%80%A7%E8%B3%AA-outlier-robust)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>


## 順位相関係数

順位相関係数とは順位に基づく相関係数で, SpearmanやKendallの相関係数が代表的なものとして挙げられます.
順序構造についての相関係数を見たい場面の一例として, 

- 統計/機械学習モデル開発プロジェクトにおいてモデルが追う評価指標とプロジェクトKPIで適切に相関しているか？
- モデル精度が改善したらプロジェクトKPIが改善する構造になっているか？

を判定したいケースが考えられます. 順序相関がしているならば少なくとも必要条件を満たす評価指標が設定されており, 
満たしていないならばモデルの評価指標をプロジェクトKPIの観点から見直すべきという意思決定となります.

## Spearmanの相関係数
### 問題設定

大きさnの組標本 $(x_1, y_i), i\in\{1, 2, \cdots, n\}$ が与えられたとします.
$x$についての標本順序統計量を

$$
x_{(1)} < x_{(2)} < \cdots < x_{(n)}
$$

と定義し, 標本順位を$R_{xi}$ を定義します. また, 対応する $y$の標本順位を $R_{yi}$とおき, $(R_{xi}, R_{yi})$という標本組にデータを変換します.


> 例

$$
\bigg(\begin{array}{c}
-0.6\\
0.02
\end{array}\bigg), 
\bigg(\begin{array}{c}
0.5\\
0.36
\end{array}\bigg), 
\bigg(\begin{array}{c}
-0.22\\
0.67
\end{array}\bigg), 
\bigg(\begin{array}{c}
0.29\\
1.43
\end{array}\bigg), 
\bigg(\begin{array}{c}
0.25\\
1.71
\end{array}\bigg)
$$

と組標本が与えられた場合, 一旦 $x$についてソートし, 順位について返還し次のようなデータに変換します

$$
\bigg(\begin{array}{c}
1\\
1
\end{array}\bigg), 
\bigg(\begin{array}{c}
2\\
3
\end{array}\bigg), 
\bigg(\begin{array}{c}
3\\
5
\end{array}\bigg), 
\bigg(\begin{array}{c}
4\\
4
\end{array}\bigg), 
\bigg(\begin{array}{c}
5\\
2
\end{array}\bigg)
$$

### Spearmanの相関係数の定義

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Spearmanの相関係数</ins></p>

Spearmanの相関係数, $\hat\rho_s$は以下のように定義されます

$$
\begin{align*}
\hat\rho_s &= \frac{\frac{1}{n}\sum_{i=1}^nR_{yi}(R_{xi} - \frac{n+1}{2})}{\frac{1}{12}(n^2-1)}\\
&\text{where }\hat\rho_s \in [-1, 1]
\end{align*}
$$


ここで, $(n+1)/2$は$R_{xi}$の標本平均, $(n^2-1)/12$は分散と覚えると理解しやすい.

また, 上述の式を変形させて

$$
\hat\rho_s = 1 - \frac{6\sum_{i=1}^n(R_{xi}-R_{yi})^2}{n(n^2-1)}
$$

と順位差分 $R_{xi}-R_{yi}$の平方で表現することも可能.
</div>

> REMARKS

上述の定義から順位性飲みに着目しているので, 順位関係を変化させない平方根変換や対数変換といった単調増加変数変換を実施しても
Spearman相関係数の値は変化しません.

### 性質: Outlier Robust

Spearman相関係数は順位に基づく相関係数なので, 単調増加の関係のある変数間についての尺度として用いることに適しています. また, Pearson相関係数と比べOutlier Robustであり, 以下その特徴をPythonで確認します.

> Scottish Hill Racesデータの読み込みとPlot

Scottish Hill Runners Associationはhill raceのコース条件(コース名`Race`, km換算の`climb`や`distance`)と男女のレコードタイム(`timeW`, `timeM`)のデータを提供しています. このデータを使って, コース条件とレコードタイムのPearson相関係数とSpearman相関係数を確認してみます.


```python
#%%
# cannot use polars because the separator is not a single-byte chr
# see https://stackoverflow.com/questions/73040753/how-can-i-use-s-as-a-seperator-in-polars
# import polars as pl
import pandas as pd
import seaborn as sns

# display setting
pd.options.display.precision = 3

#データ読み込み
df = pd.read_csv("http://stat4ds.rwth-aachen.de/data/ScotsRaces.dat",
                 sep="\s+")

sns.pairplot(df)
```
<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211003_scottish_hill_race.png?raw=true">

> Pearson相関係数の計算

```python
#%%
# Pearson Correlation
df.corr()

#%%
# Outlier removed Correlation
alpha = 0.025
numeric_col = ['distance', 'climb', 'timeM', 'timeW']

df_fixed = df[(df.loc[:,numeric_col] >= df.loc[:,numeric_col].quantile(alpha)) &
              (df.loc[:,numeric_col] <= df.loc[:,numeric_col].quantile(1 - alpha))]
df_fixed.corr()
```



|Peason相関係数|distance|climb|timeM|timeW|
|---|---|---|---|---|
|distance|1.000|0.514|0.963|0.956|
|climb|0.514|1.000|0.672|0.685|
|timeM|0.963|0.672|1.000|0.996|
|timeW|0.956|0.685|0.996|1.000|

|Outlier除去<br>Peason相関係数|distance|climb|timeM|timeW|
|---|---|---|---|---|
|distance|1.000|0.711|0.935|0.922|
|climb|0.711|1.000|0.810|0.804|
|timeM|0.935|0.810|1.000|0.992|
|timeW|0.922|0.804|0.992|1.000|

(`timeW`, `climb`)は $0.685$と $0.804$ と上下2.5%のOutlierの結果によって大きく変わることがわかります.


> Spearman相関係数の計算


```python
#%%
# Spearman
df.corr(method='spearman')

# Outlier removed Spearman
df_fixed.corr(method='spearman')
```


|Spearman相関係数|distance|climb|timeM|timeW|
|---|---|---|---|---|
|distance|1.000|0.757|0.944|0.937|
|climb|0.757|1.000|0.857|0.850|
|timeM|0.944|0.857|1.000|0.994|
|timeW|0.937|0.850|0.994|1.000|

|Outlier除去<br>Spearman相関係数|distance|climb|timeM|timeW|
|---|---|---|---|---|
|distance|1.000|0.737|0.933|0.920|
|climb|0.737|1.000|0.821|0.817|
|timeM|0.933|0.821|1.000|0.992|
|timeW|0.920|0.817|0.992|1.000|

(`timeW`, `climb`)は $0.850$と $0.817$とoutlierの除去の有無にかかわらず似たような数値を出力しており, Pearson相関係数に比べOutlier Robustであることが確認できます.


## References

> 前処理関係

- [Remove Outliers in Pandas DataFrame using Percentiles](https://stackoverflow.com/questions/35827863/remove-outliers-in-pandas-dataframe-using-percentiles)