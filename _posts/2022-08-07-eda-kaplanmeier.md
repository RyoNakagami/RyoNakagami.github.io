---
layout: post
title: "EDA CookBook - 生存分析とKaplanMeier推定量"
subtitle: "生存分析 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-10-06
tags:

- Python
- 統計
- 統計検定
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題意識](#%E5%95%8F%E9%A1%8C%E6%84%8F%E8%AD%98)
  - [生存分析の特徴](#%E7%94%9F%E5%AD%98%E5%88%86%E6%9E%90%E3%81%AE%E7%89%B9%E5%BE%B4)
  - [censoringの種類](#censoring%E3%81%AE%E7%A8%AE%E9%A1%9E)
  - [Notation and Terminology](#notation-and-terminology)
- [Kaplan-Meier推定量](#kaplan-meier%E6%8E%A8%E5%AE%9A%E9%87%8F)
  - [Survival Dataの形式](#survival-data%E3%81%AE%E5%BD%A2%E5%BC%8F)
  - [Kaplan-Meier推定量](#kaplan-meier%E6%8E%A8%E5%AE%9A%E9%87%8F-1)
  - [Confidence Intervalの導出](#confidence-interval%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [ネルソンアーレン推定量との関係](#%E3%83%8D%E3%83%AB%E3%82%BD%E3%83%B3%E3%82%A2%E3%83%BC%E3%83%AC%E3%83%B3%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%A8%E3%81%AE%E9%96%A2%E4%BF%82)
    - [Standard errors for the Nelson-Aalen estimator](#standard-errors-for-the-nelson-aalen-estimator)
  - [Medianの評価](#median%E3%81%AE%E8%A9%95%E4%BE%A1)
- [The log-rank test](#the-log-rank-test)
  - [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [検定統計量の導出](#%E6%A4%9C%E5%AE%9A%E7%B5%B1%E8%A8%88%E9%87%8F%E3%81%AE%E5%B0%8E%E5%87%BA)
  - [Multiple groupsへの拡張](#multiple-groups%E3%81%B8%E3%81%AE%E6%8B%A1%E5%BC%B5)
  - [Pythonで検定関数を書いてみる](#python%E3%81%A7%E6%A4%9C%E5%AE%9A%E9%96%A2%E6%95%B0%E3%82%92%E6%9B%B8%E3%81%84%E3%81%A6%E3%81%BF%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題意識

- とある属性や処置が顧客の生存時間にどのように影響するのかを分析する機会は多い
- 生存分析に置いて, 分析データの制約より, 顧客がchurnする前に観測期間が終了時点を迎えたり, study dropoutという問題に直面することが多い
- いわゆるtime-to-event data, failure-time dataの分析手法を身につけたい

### 生存分析の特徴

- 連続時間をベースに分析, 時間は正の実数
- subjectに応じて, exactな生存時間がわかったり, 打ち切りを迎えたりする(partially right-censored data)
- 打ち切りデータ(= partially observed data)の存在のため, meanやvarianceといったmomentの計算が困難

### censoringの種類

打ち切り(Censoring)の種類はおもに３つに区分されます:

- Fixed type I censoring
- Random type I censoring
- Type II censoring

> Fixed type I censoring

分析期間が$C$時間経過後に, すべてのsubjectについて終了となる場合に発生するCensoringです.
故障分析を例にするならば, 100日を $C$ としたとき, 100日以内に故障を迎えた機会については`故障フラグ=True`と故障までの日数 `T = 78`　と観察されるが, 100日以内に故障しなかったものについては, `故障フラグ=False`と`T = 100`という形で打ち切りとなった生存時間しか観察できません.

> Random type I censoring

分析期間が$C_i$時間経過後に終了という形でデザインされているが, $C_i$がsubject毎に異なる場合のCensoringのことです.

> Type II censoring

観察期間が事前に定めたCensring time, $C$, 時間経過することなく打ち切りを迎えてしまった場合のことです.
実験プロトコルからの逸脱などが例としてあります.

### Notation and Terminology

> Survival Function

Survival Functionは以下のようによく表現されます

$$
S(t) = Pr(T > t) = 1 - F(t)
$$

- $T$: event発生までの生存時間
- $S(t)$: $t$まで生存している確率, non-increasing w.r.t Time
- $F(t)$: $t$まで死亡している確率, increasing w.r.t Time
- $f(t)$: $t$時点での死亡についての確率密度関数

> Hazard Function

t時間まで生存している条件のもとで瞬間的に死亡する確率密度を表現したものをHazard関数, $h(t)$, といいます.
80歳と100歳の老人を考えた時, 後者のほうが死亡リスクが高いですが, 平均寿命的には多くの人は80歳近傍で死を迎えるのでdensity function的には前者近傍のほうが大きい値が出ます.
ただ, density functionが80歳近傍のほうが100歳近傍と比べ大きいため前者のほうが死亡リスクが高いというのは解釈がおかしくなってしまいます. そこでそれぞれの年齢における死亡リスクを表現した関数がHazard関数です.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
h(t) &= \lim_{\Delta t \to 0} \frac{Pr(t < T \leq t + \Delta t| T >t)}{\Delta t}\\
&= \frac{f(t)}{S(t)}
\end{align*}
$$
</div>

- なお$F(t) = 1 - \exp(-\lambda t)$という指数分布を仮定するとhazard関数は時間$t$には無関係に$h(t)=\lambda$となります.

hazard関数を積分してcumulative hazard関数を以下のように定義します:

$$
H(t) = \int^t_0 h(u)du
$$

このとき, hazard関数の定義に注意すると

$$
\begin{align*}
H(t) &= \int^t_0 h(u)du\\
&= \int^t_0\frac{f(u)}{1 - F(u)}du\\
& = \left[-\log (1 - F(u))\right]_0^t
\end{align*}
$$

よって, 以下の関係式を得ることができます

$$
\begin{align*}
F(t) &= 1 - \exp\left(-\int^t_0h(u)du\right)\\
f(t) &= h(t)\exp\left(-\int^t_0h(u)du\right)
\end{align*}
$$

- 生存時間が指数分布従う場合, hazard関数が時間に無関係の定数であることから確率密度関数, 累積分布関数の導出が可能となります

## Kaplan-Meier推定量

KM推定量はnonparametricな生存関数の推定量です. Parametricに指数分布やワイブル分布を仮定しMLEで推定する方法もありますが,
Parametric推定量では用いる分布形状から要請される仮定(harzard関数はコンスタントなど)を現実のものと適合させる, or 仮定の妥当性について分析者間で合意する事が困難のため,
基本的にはnonparametric(or semiparametric)アプローチが生存分析では推奨されます.

### Survival Dataの形式

- $T_i$: the eventを迎えた時の潜在的生存時間 for the $i$th subject, 分析者には見えない場合がある
- $C_i$: the censoring time for the $i$th subject
- $\delta_i$: the event indicator

$$
\delta_i = \begin{cases}1 & \text{ if the eventが観察された場合, } T_i \leq C_i\\ 
0 & \text{ if the censoring timeを迎えた場合, }  T_i > C_i\end{cases}
$$

- $Y_i$: 観察された生存時間

$$
Y_i = \min(C_i, T_i)
$$

> データ例: `sksurv.datasets`より

```python
import pandas as pd
from sksurv.datasets import load_veterans_lung_cancer

df_x, array_y  = load_veterans_lung_cancer()
df_y = pd.DataFrame(array_y)
df = pd.concat([df_y, df_x], axis=1)
df.head()
```

Then,

|Status|Survival_in_days|Age_in_years|Celltype|Karnofsky_score|Months_from_Diagnosis|Prior_therapy|Treatment|
|---|---|---|---|---|---|---|---|
|True|72.0|69.0|squamous|60.0|7.0|no|standard|
|True|411.0|64.0|squamous|70.0|5.0|yes|standard|
|True|228.0|38.0|squamous|60.0|3.0|no|standard|
|True|126.0|63.0|squamous|60.0|9.0|yes|standard|
|True|118.0|65.0|squamous|70.0|11.0|yes|standard|


- `Status`: the eventを迎えた場合`True`, $\delta_i$
- `Survival_in_days`: 観察された生存時間, $Y_i$
- `Age_in_years`: 年齢

データ型が`np.float64`以外のカラムのvalueを確認して見る場合は以下:

```python
cat_cols = df.select_dtypes(exclude=np.float64).columns.tolist()
(pd.DataFrame(
            df[cat_cols].melt(var_name='column', 
                              value_name='value'
                             ).value_counts())
            .rename(columns={0: 'counts'})
            .sort_values(by=['column', 'counts']))
```

Then,

|column|value|counts|
|---|---|---|
|Celltype|adeno|27|
||large|27|
||squamous|35|
||smallcell|48|
|Prior_therapy|yes|40|
||no|97|
|Status|False|9|
||True|128|
|Treatment|test|68|
||standard|69|

### Kaplan-Meier推定量

> 基本方針

- subjectが同じ生存分布関数に従う仮定の下でKaplan-Meier推定量というnonparametric推定量を用いることができます
- the empirical cumulative distribution function, $F_n(t)$を計算し $S(t) \equiv 1 - F_n(t)$で推定

> 推定量

$$
\hat{S}(t) = \prod_{j \lt t} \frac{n_j - d_j}{n_j}
$$

- $n_j$: the total number of observations at time $j$, $j-1$期末時点で生存 & 今期censoredされていないsubject
- $d_j$: $j$期に死亡した人数

> `sksurv.nonparametric`を用いた推定

```python
is_therapy = df['Prior_therapy'] == 'yes'
event = df['Status'].values
time = df['Survival_in_days'].values
x_total, y_total = kaplan_meier_estimator(event, time)
x_treated, y_treated = kaplan_meier_estimator(event[is_therapy], time[is_therapy])
x_control, y_control = kaplan_meier_estimator(event[~is_therapy], time[~is_therapy])

plt.step(x_treated, y_treated, where="post", label='treated')
plt.step(x_control, y_control, where="post", label='controled')
plt.ylim(0, 1)
plt.legend();
```

> pandasとnumpyを用いて再現したい場合

```python
## x_total, y_totalの再現のみ
km_idx, km_freq = np.unique(time, return_counts=True)
km_freq = np.cumsum(km_freq[::-1])[::-1]
death_idx, death_freq = np.unique(time[event], return_counts=True)

df_left = pd.DataFrame(np.array([km_idx, km_freq],dtype=np.int64).T,columns=['time', 'obs'])
df_right = pd.DataFrame(np.array([death_idx, death_freq],dtype=np.int64).T,columns=['time', 'death'])
df_merge = (pd.merge(df_left, df_right, how='left', on='time')).fillna(0)
df_merge['ratio'] = np.cumprod(1 - df_merge['death']/df_merge['obs'])

## 95% confidence intervalの計算
df_merge['std_err'] = np.sqrt(np.cumsum(df_merge['death']/(df_merge['obs'] * (df_merge['obs'] - df_merge['death']))))
df_merge['CI_lower'] = np.clip(df_merge['ratio'] * np.exp(-1.96 * df_merge['std_err']), 0, 1)
df_merge['CI_upper'] = np.clip(df_merge['ratio'] * np.exp(1.96 * df_merge['std_err']), 0, 1)

## plotの再現
plt.step(df_merge['time'].values, df_merge['ratio'].values,where="post", label='survival')
plt.fill_between(df_merge['time'].values, df_merge['CI_lower'].values,df_merge['CI_upper'].values, color = 'b', alpha = 0.2, step="post")


plt.legend();
```

### Confidence Intervalの導出

Nonparametricに推定したとはいえ, 推定値がどれほどreliableか？という問題はデータ分析の解釈において重要となります.
推定値のreliablityを評価する際よく用いられるのが,推定値のstandard errorとConfidence Intervalです.

なお, Notationとして $\hat f(t)$はKM推定量から得られた確率密度関数とします.

$$
\hat f(t) \equiv \frac{d_t}{n_t}
$$

> Central Limit Theorem for $\hat f(t)$

$\hat f(t)$はbinomial likelihoodに基づき計算されるので,

$$
\sqrt{n_t}(\hat f(t) - f(t)) \xrightarrow{d}N(0, f(t)(1 - f(t)))
$$

言い換えると, $\hat f(t)$はapproximately normal with mean $f(t)$ and variance $f(t)(1 - f(t))/n_t$なので

$$
Var(\hat f(t)) = \frac{d_t(n_t - d_t)}{n_t^3}
$$

> Log transformation & Delta Method

Log transformationしたSurvival Functionを考えます

$$
\log S(t) = \sum_{j \leq t}\log(1 - f(j))
$$

$f(t)$が互いにindependentであるという仮定の下で$\log S(t)$のVarianceはDelta Methodを用いて以下のように計算することができます. 

$$
Var(log(1 - \hat f(t)) = \frac{Var(\hat f(t))}{(1 - \hat f(t))^2}
$$

従って, $Var(\log \hat S(t))$の推定量を$\hat s^2(t)$としたとき,

$$
\hat s^2(t) = \sum_{j\leq t} \frac{d_j}{n_j(n_j - d_j)}
$$

よって, Confidence Intervalは

$$
\begin{align*}
CI &= \exp(\log \hat S(t) \pm 1.96 \hat s(t))\\
&= \hat S(t)\exp(\pm 1.96 \hat s(t))
\end{align*}
$$

> どのような仮定下正当化されるのか？

- 確率変数としての生存日数が各$t_j$ポイントで評価される離散分布に従っている場合
- 各$t_j$ポイントで評価される$f(t_j)$が互いに独立
- 生存日数がcontinuousの場合は, 別の切り口が必要
- なおここでは紹介はしないがlog-log approachでのCI導出が良いとされている(Rでは上記のCIがデフォルトで出力される)


### ネルソンアーレン推定量との関係

累積ハザード関数がその瞬間瞬間ごとのリスクの合計値に着目し, イベント発生者数/リスク集合の和で評価したものをネルソンアーレン推定量といいます:

$$
\tilde H(t) = \sum_{j=1}^t\frac{d_j}{n_j}
$$

累積ハザード関数と生存関数の関係式が

$$
S(t) = \exp(-H(t))
$$

で表せられることに着目し, 累積ハザード関数の推定量としてのネルソンアーレン推定量, $\tilde H(t)$, から生存関数を以下のように表現することができます

$$
\begin{align*}
\tilde H(t) &= \sum_{j=1}^t\frac{d_j}{n_j}\\
\tilde S(t) &=\prod_{j=1}^t\exp(-\frac{d_j}{n_j})
\end{align*}
$$

一般にこれは小サンプルに有効な推定量と言われていますが, KM推定量との関係性として以下が知られています:

$$
\tilde S(t) \geq \hat S(t) \forall t
$$

> Proof

まず$f(x) = \exp(-x) - (1 - x)$を考えます. 導関数を確認すればわかりますが, 任意の$x$において 

$$
\exp(-x) \geq (1 - x)
$$

が成立します. 従って,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\tilde S(t) &= \prod_{j=1}^t\exp(-\frac{d_j}{n_j})\\
&\geq \prod_{j=1}^t \left(1 - \frac{d_j}{n_j}\right)\\
&= \hat S(t)
\end{align*}
$$
</div>

#### Standard errors for the Nelson-Aalen estimator

standard errorの計算のIntuitionは, NA推定量は毎期のイベント発生 or notのbinomial probabilityの合計を計算しているのと同じなので

<div class="math display" style="overflow: auto">
$$
\begin{align*}
Var(\tilde H(t)) &= \sum Var\left(\frac{d_j}{n_j}\right)\\
&= \sum\left(\frac{d_j(n_j - d_j)}{n_j^3}\right)
\end{align*}
$$
</div>


### Medianの評価

生存分析のデータの多くはcensored dataなので means を計算することができません(条件付き means なら計算できますが).
一方, median は計算することができ

$$
\text{Median}(t) = \min(t) \text{ s.t. } \hat S(t) \leq 0.5
$$

## The log-rank test
### 問題設定

- ２つのグループの生存時間分布に差が存在するか検定したいとする, i.e., 生存関数について$H_0: S_1 = S_2$
- $n_{1j}, d_{1j}$: the time, $t_j$におけるグループ1の観察人数と死亡人数
- $n_{2j}, d_{2j}$: the time, $t_j$におけるグループ2の観察人数と死亡人数

### 検定統計量の導出

> the time, $t_j$, におけるContingency Table

||Group 1|Group 2|Total|
|---|---|---|---|
|Deaths|$d_{1j}$|$d_{2j}$|$d_{j}$|
|Survivors|$n_{1j} - d_{1j}$|$n_{2j} - d_{2j}$|$n_{j} - d_{j}$|
|Obs|$n_{1j}$|$n_{2j}$|$n_{j}$|

> chi-squared distributionの導出

The null hypothesis, $S_1 = S_2$の下では, 確率変数$D_{1j}$はthe hypergeometric distribution(超幾何分布)に従うので, meanとvarianceはそれぞれ

$$
\begin{align*}
e_{1j} &= n_{1j}\frac{d_j}{n_j}\\
v_{1j} &= \frac{d_j}{n_j}\frac{n_j - d_j}{n_j}\frac{n_{1j}n_{2j}}{n_j - 1}
\end{align*}
$$

このとき, $w_j = d_{1j} − e_{1j}$はaprroximatelyに$N(0, v_{1j})$に従うと考えられるので, 条件付き独立の仮定の下, 

$$
W \sim N(0, V), \text{ where } W = \sum_{j=1}^T w_j, V = \sum_{j=1}^T v_j
$$

従って, 検定統計量は, 自由度1のカイ自乗分布に従うことから

$$
\frac{W^2}{V} = \frac{(\sum w_j)^2}{\sum v_j} \sim \chi^2_1
$$

- これはthe log-rank test, または the Cochran-Mantel-Haenszel testと呼ばれます

### Multiple groupsへの拡張

Reference Group１つ(便宜上group indexは0とする)を含む$K + 1$ groupsを考えます. このとき, 次のベクトルを考えます:

$$
\bold w_j = (w_{1j}, w_{2j}, \cdots, w_{Kj})
$$

$\bold w_j$のconditional covariance matrix, $\bold V_j$は

$$
\begin{align*}
(V_j)_{ii} & = \frac{d_j}{n_j}\frac{n_j - d_j}{n_j}\frac{n_{1j}(n_{j}-n_{ij})}{n_j - 1}\\
(V_j)_{ik} & = - \frac{n_{ij}n_{kj}d_j(n_j - d_j)}{n_j^2(n_j-1)}\text{ where } i \neq k
\end{align*}
$$

Then,

$$
\bold w^T \bold V^{-1} \bold w \sim \chi^2_K
$$

### Pythonで検定関数を書いてみる

- `lifelines.statistics.logrank_test`と出力結果が一致することは確認済み

```python
from scipy import stats
import numpy as np
import pandas as pd
from collections import OrderedDict

def survival_logrank_test(duration_array, event_array, group_array):
    """K-sample log-rank hypothesis test of identical survival functions.
    Compares the pooled hazard rate with each group-specific
    hazard rate. The alternative hypothesis is that the hazard
    rate of at least one group differs from the others at some time.

    Parameters
    ----------
    duration_array : time of event or time of censoring array, shape = (n_samples,)
    
    event_array : the binary event indicator array
                  1: event observed
                  0: censored
    
    group_array : array-like, shape = (n_samples,)
                  Group membership of each sample.
    
    Returns
    -------
    chisq : float
        Test statistic.
    pvalue : float
        Two-sided p-value with respect to the null hypothesis
        that the hazard rates across all groups are equal.
    stats : pandas.DataFrame
        Summary statistics for each group:  number of samples,
        observed number of events, expected number of events,
        and test statistic.
        Only provided if `return_stats` is True.
    covariance : array, shape=(n_groups, n_groups)
        Covariance matrix of the test statistic.
        Only provided if `return_stats` is True.
    
    References
    ----------
    .. [1] Fleming, T. R. and Harrington, D. P.
           A Class of Hypothesis Tests for One and Two Samples of Censored Survival Data.
           Communications In Statistics 10 (1981): 763-794.
    """

    n_samples = len(duration_array)
    groups, group_counts = np.unique(group_array, return_counts=True)
    n_groups = groups.shape[0]

    # sort descending
    o = np.argsort(-duration_array, kind="mergesort")
    x = group_array[o]
    event = event_array[o]
    time = duration_array[o]

    at_risk = np.zeros(n_groups, dtype=int)
    observed = np.zeros(n_groups, dtype=int)
    expected = np.zeros(n_groups, dtype=float)
    covar = np.zeros((n_groups, n_groups), dtype=float)
    covar_indices = np.diag_indices(n_groups)

    k = 0
    while k < n_samples:
        ti = time[k]
        total_events = 0
        while k < n_samples and ti == time[k]:
            idx = np.searchsorted(groups, x[k])
            if event[k]:
                observed[idx] += 1
                total_events += 1
            at_risk[idx] += 1
            k += 1
        if total_events != 0:
            total_at_risk = k
            expected += at_risk * (total_events / total_at_risk)
            if total_at_risk > 1:
                multiplier = total_events * (total_at_risk - total_events) / (total_at_risk * (total_at_risk - 1))
                temp = at_risk * multiplier
                covar[covar_indices] += temp
                covar -= np.outer(temp, at_risk) / total_at_risk
    
    chi_df = n_groups - 1
    numerator = observed[:chi_df] - expected[:chi_df]
    
    chisq = np.linalg.solve(covar[:chi_df, :chi_df], numerator) @ numerator
    pval = stats.chi2.sf(chisq, chi_df)
    
    table = OrderedDict()
    table["counts"] = group_counts
    table["observed"] = observed
    table["expected"] = expected
    table["statistic"] = observed - expected
    table = pd.DataFrame.from_dict(table)
    table.index = pd.Index(groups, name="group", dtype=groups.dtype)
    
    return chisq, pval, table, covar, chi_df


# numpy example
G = np.array([0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2])
T = np.array([5, 3, 9, 8, 7, 4, 4, 3, 2, 5, 6, 7])
E = np.array([1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0])
survival_logrank_test(duration_array=T, event_array=E, group_array=G)
```



## References

> ライブラリー

- [LIFELINES](https://i.imgur.com/EOowdSD.png)
- [scikit-survival > Introduction to Survival Analysis with scikit-survival](https://scikit-survival.readthedocs.io/en/stable/user_guide/00-introduction.html)

> Lecture Notes

- [BIOST 515, 2004, Lecture 15 Introduction to Survival Analysis](http://www.stat.columbia.edu/~madigan/W2025/notes/survival.pdf)
- [Inference for the Kaplan-Meier Estimator](https://myweb.uiowa.edu/pbreheny/7210/f15/notes.html)


> Stackoverflow

- [How to get value counts for multiple columns at once in Pandas DataFrame?](https://stackoverflow.com/questions/32589829/how-to-get-value-counts-for-multiple-columns-at-once-in-pandas-dataframe)