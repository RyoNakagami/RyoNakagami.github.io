---
layout: post
title: "Propensity score & Conditional Independence Assumption"
subtitle: "条件付き期待値の基本的理解 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-11-18
tags:

- 統計
- Python
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [条件付き独立とPropensity score](#%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E7%8B%AC%E7%AB%8B%E3%81%A8propensity-score)
- [CIAが成立するならばなぜCounter-factualが導けるのか？](#cia%E3%81%8C%E6%88%90%E7%AB%8B%E3%81%99%E3%82%8B%E3%81%AA%E3%82%89%E3%81%B0%E3%81%AA%E3%81%9Ccounter-factual%E3%81%8C%E5%B0%8E%E3%81%91%E3%82%8B%E3%81%AE%E3%81%8B)
- [Propensity scoreでコントロールするとなぜCIAが成立するのか？](#propensity-score%E3%81%A7%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B%E3%81%A8%E3%81%AA%E3%81%9Ccia%E3%81%8C%E6%88%90%E7%AB%8B%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)
  - [Propensity scoreは特徴量のバランシングスコアである](#propensity-score%E3%81%AF%E7%89%B9%E5%BE%B4%E9%87%8F%E3%81%AE%E3%83%90%E3%83%A9%E3%83%B3%E3%82%B7%E3%83%B3%E3%82%B0%E3%82%B9%E3%82%B3%E3%82%A2%E3%81%A7%E3%81%82%E3%82%8B)
  - [Propensity scoreで条件づけたPotential outcome](#propensity-score%E3%81%A7%E6%9D%A1%E4%BB%B6%E3%81%A5%E3%81%91%E3%81%9Fpotential-outcome)
    - [MHE version 証明](#mhe-version-%E8%A8%BC%E6%98%8E)
    - [関数変換後の独立性に基づいた証明](#%E9%96%A2%E6%95%B0%E5%A4%89%E6%8F%9B%E5%BE%8C%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7%E3%81%AB%E5%9F%BA%E3%81%A5%E3%81%84%E3%81%9F%E8%A8%BC%E6%98%8E)
    - [条件付き期待値の独立性](#%E6%9D%A1%E4%BB%B6%E4%BB%98%E3%81%8D%E6%9C%9F%E5%BE%85%E5%80%A4%E3%81%AE%E7%8B%AC%E7%AB%8B%E6%80%A7)
- [Heterogeneous Treatment Effectがある場合](#heterogeneous-treatment-effect%E3%81%8C%E3%81%82%E3%82%8B%E5%A0%B4%E5%90%88)
  - [DGP and Distribution check](#dgp-and-distribution-check)
  - [推定値の確認](#%E6%8E%A8%E5%AE%9A%E5%80%A4%E3%81%AE%E7%A2%BA%E8%AA%8D)
    - [シミュレーションでバイアスがあるかの確認](#%E3%82%B7%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%A7%E3%83%90%E3%82%A4%E3%82%A2%E3%82%B9%E3%81%8C%E3%81%82%E3%82%8B%E3%81%8B%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [Propensity scoreで条件づけたHeterogeneityの推定](#propensity-score%E3%81%A7%E6%9D%A1%E4%BB%B6%E3%81%A5%E3%81%91%E3%81%9Fheterogeneity%E3%81%AE%E6%8E%A8%E5%AE%9A)
- [Follow up Question](#follow-up-question)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 条件付き独立とPropensity score

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Propensity Score Theorem</ins></p>

$X_i$ がcovariates vector, $D_i$ がbinary treatmentを指すとする. 以下のようにPotential Outcome $\{Y_{1i}, Y_{0i}\}$ に対してConditional Independence Assumption(CIA)が成立するとする:

$$
\{Y_{1i}, Y_{0i}\} \perp D_i |X_i
$$

このとき, 

$$
\{Y_{1i}, Y_{0i}\} \perp D_i |p(X_i) \text{ s.t } \mathbb E[D_i|X_i] \equiv p(X_i)
$$

が成立する

</div>

2022年時点に会社Aに在籍している人を対象に以下のデータを集めたとします

- $D_i$: 2022年時点での会社提供スキルアップクラス受講ステータス
- $Y_i$: 2022年開始時点での推定年収と2023年期末時点での年収の差分
- $X_i$: 従業員の属性

会社提供スキルアップクラス受講のyes, noは個人の自発的意思に任されているとします. この状況下でスキルアップクラス受講の
翌年年収への影響を推定したいときに,単純比較を実施してしまうと

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[Y | D_i=1] - \mathbb E[Y | D_i=0] &=\mathbb E[Y_1 | D_i=1] - \mathbb E[Y_0 | D_i=0]\\
&= (\mathbb E[Y_1 | D_i=1] - \mathbb E[Y_0 | D_i=1]) + (\mathbb E[Y_0 | D_i=1] - \mathbb E[Y_0 | D_i=0])\\
&= \text{ATT } + \text{selection bias }
\end{align*}
$$
</div>

以上のようにATT + selection biasのように見たい効果が見ることができません. 
また, そもそも会社の意思決定問題に応じて「**見たい効果**」というのも変わってきます. 例えば, 

1. スキルアップクラス受講を廃止したい
2. スキルアップクラス受講を強制したい
3. スキルアップクラス受講を強制したときに, 他の施策との効果を比較したい

というそれぞれのケースを考えた場合, (1)ならばATT(=Average Treatment effect on the treaed)を知りたいですし, (2)ならばATU(=Average Treatment effect on the untreaed), (3)ならば ATE / 一人あたり実施コストを知りたいと考えられます.

意思決定問題と照らし合わせて, 見たい指標が決まったとしても, 単純比較ではいずれも見ることができません.

じゃあ, 「どうやって ATE, ATT, ATUを推定すべきか？」という問題が出てきますがとのとき便利なAssumptionがCIAです

$$
\{Y_{1i}, Y_{0i}\} \perp D_i |X_i
$$

これは指し示すことは簡単に言うと, 

- スキルアップクラス受講ステータスについて, 特徴量で説明した後に発生するノイズはPOMの分布と関係ないと確信を持っている
- 分析者はこれらの特徴量が観察できる

ということです. これが成立していると仮定できると, 実際に観察できない 

$$
\mathbb E[Y_0 | D_i=1], \mathbb E[Y_1 | D_i=0]
$$

が推定できるようになります. 

## CIAが成立するならばなぜCounter-factualが導けるのか？

$\mathbb E[Y_1 \vert D_i=0]$をなぜ推定できるようになるのか簡単に以下示します:

$S_0$をunteatedの特徴量$X_i$の特徴量空間としたときに

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[Y_1 | D_i=0] &= \mathbb E[\mathbb E[Y_1| D_i=0, X_i] | D_i=0]\\
&= \mathbb E[\mathbb E[Y_1|X_i] | D_i=0] \  \   \  \ \because \text{ CIA}\\
&= \sum_{x\in S_0} \mathbb E[Y_1|X_i = x]\Pr(X_i=x |D_i = 0)\\  
&= \sum_{x\in S_0} \mathbb E[Y_1|D_i = 1, X_i = x]\Pr(X_i=x |D_i = 0) \because \text{CIA and support condition}
\end{align*}
$$
</div>

なお, Support conditionとは

$$
\Pr(X_i=x |D_i = 1) > 0 \ \ \forall x \in S_0
$$

のことです. とある $x \in S_0$ について 

$$
\Pr(X_i=x |D_i = 1) = 0
$$ 

だと, Counter-factualが計算できなくなってしまいます. 一方, ATUを推定するにあたって 

$$
\Pr(X_i=x |D_i = 0) = 0
$$

は問題になりません. なぜならば, ATUを推定したいときのpopulationは $D_i = 0$の従業員ですが, $\Pr(X_i=x \vert D_i = 0) = 0$のような特徴量水準$x$はそのpopulationに属していないからです.

これは$\Pr(X_i=x \vert D_i = 0) = 0$ならば, $x\not\in S_0$というところからも直感的にはわかります.


## Propensity scoreでコントロールするとなぜCIAが成立するのか？
### Propensity scoreは特徴量のバランシングスコアである

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>balancing Score</ins></p>

$ \mathbb E[D_i\vert X_i] \equiv p(X_i)$ のとき, 

$$
D_i \perp X_i|p(X_i)
$$

が成立する.

</div>

この証明は$Pr(D_i\vert X_i, p(X_i)) = Pr(D_i\vert p(X_i))$の証明ができればOkです. なぜなら

<div class="math display" style="overflow: auto">
$$
\begin{align*}
&\Pr(D_i|X_i, p(X_i)) = \Pr(D_i|p(X_i))\\
&\Rightarrow \Pr(D_i, X_i|P(X_i)) = \Pr(D_i|X_i, p(X_i)) \Pr(X_i| p(X_i))\\
&= \Pr(D_i|p(X_i))\Pr(X_i| p(X_i))
\end{align*}
$$
</div>

$\Pr(D_i\vert X_i, p(X_i)) = \mathbb E[D_i\vert X_i, p(X_i)]$であることに留意すると,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[D_i|X_i, p(X_i)] &= \mathbb E[D_i|X_i] = p(X_i)\\
\mathbb E[D_i|p(X_i)] &= \mathbb E[\mathbb E[D_i|X_i, p(X_i)]|p(X_i)]\\
&= \mathbb E[p(X_i)|p(X_i)] = p(X_i)
\end{align*}
$$
</div>

したがって,

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(D_i|X_i, p(X_i)) &= \mathbb E[D_i|X_i, p(X_i)] \\
&= \mathbb E[D_i|p(X_i)]\\
&= \Pr(D_i|p(X_i))
\end{align*}
$$
</div>

したがって, 

- 適切なpropensity scoreで条件付けると特徴量$X_i$はtreatment status$D_i$と独立になる. 
- 言い換えると, 適切なpropensity scoreで条件付けると特徴量$X_i$の分布は$D_i$とバランスされる. 


### Propensity scoreで条件づけたPotential outcome

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Propensity score theorem</ins></p>


$X_i$ がcovariates vector, $D_i$ がbinary treatmentを指すとする. 以下のようにPotential Outcome $\{Y_{1i}, Y_{0i}\}$ に対してConditional Independence Assumption(CIA)が成立するとする:

$$
\{Y_{1i}, Y_{0i}\} \perp D_i |X_i
$$

このとき, 

$$
\{Y_{1i}, Y_{0i}\} \perp D_i |p(X_i) \text{ s.t } \mathbb E[D_i|X_i] \equiv p(X_i)
$$

が成立する

</div>

#### MHE version 証明

MHEにならって以下のように証明できます.

$\{Y_{1i}, Y_{0i}\} \perp D_i \vert p(X_i)$が成立することを言い換えると

$$
\begin{align*}
\Pr(D_i=1|Y_{1i}, Y_{0i}, p(X_i)) = \Pr(D_i=1|p(X_i)) = p(X_i)
\end{align*}
$$

なのでこれを示せれば十分ということがわかります.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr(D_i=1|Y_{1i}, Y_{0i}, p(X_i)) &= \mathbb E[D_i|Y_{1i}, Y_{0i}, p(X_i)]\\[3pt]
&= \mathbb E[\mathbb[D_i|Y_{1i}, Y_{0i}, X_i]|Y_{1i}, Y_{0i}, p(X_i)]\\[3pt]
&= \mathbb E[\mathbb[D_i|X_i]|Y_{1i}, Y_{0i}, p(X_i)] \because \text{ CIA holds}\\[3pt]
&= \mathbb E[p(X_i)|Y_{1i}, Y_{0i}, p(X_i)] \because \text{ definition}\\[3pt]
&= p(X_i)
\end{align*}
$$
</div>

したがって, $\{Y_{1i}, Y_{0i}\} \perp D_i \vert p(X_i)$が成立する.

#### 関数変換後の独立性に基づいた証明

$p(X_i)$について, 逆写像$p^{-1}$が定義できるとします. 任意の事象$A, B, C$について

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\Pr((Y_{0i}, Y_{1i})\in A, D_i\in B \vert p(X_i)\in C) &= \frac{\Pr((Y_{0i}, Y_{1i})\in A, D_i\in B, p(X_i)\in C)}{\Pr(p(X_i)\in C)}\\[3pt]
    &= \frac{\Pr((Y_{0i}, Y_{1i})\in A, D_i\in B, X_i\in p^{-1}(C))}{\Pr(X_i\in p^{-1}(C))}\\[3pt]
    &= \Pr((Y_{0i}, Y_{1i})\in A, D_i\in B \vert X_i\in p^{-1}(C))\\[3pt]
    &= \Pr((Y_{0i}, Y_{1i})\in A \vert X_i\in p^{-1}(C))\Pr(D_i\in B \vert X_i\in p^{-1}(C)) \\[3pt]
    &= \Pr((Y_{0i}, Y_{1i})\in A \vert p(X_i)\in C)\Pr(D_i\in B \vert p(X_i)\in C)
\end{align*}
$$
</div>

したがって, $\{Y_{1i}, Y_{0i}\} \perp D_i \vert p(X_i)$が成立する.


#### 条件付き期待値の独立性

conditional expectationに着目して以下を示すことも可能です:

$$
\mathbb E[Y_{ji} | D_i, p(X_i)] = \mathbb E[Y_{ji} | p(X_i)] \text{ for } j = 0,1
$$

証明は以下です:

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[Y_{ji} | D_i, p(X_i)] &= \mathbb E[\mathbb E[Y_{ji}| D_i, p(X_i), X_i] | D_i, p(X_i)]\\
&=  \mathbb E[\mathbb E[Y_{ji}| D_i, X_i] | D_i, p(X_i)]\\
&=  \mathbb E[\mathbb E[Y_{ji}| X_i] | D_i, p(X_i)] \because \text{ CIA }
\end{align*}
$$
</div>

このとき, 簡略化のため $\mathbb E[Y_{ji}\vert X_i] \equiv \mu(X_i)$と表記します.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[\mathbb E[Y_{ji}| X_i] | D_i, p(X_i)] &= \mathbb E[\mu(X_i) | D_i, p(X_i)]\\
&= \int_{x\in \Theta_x} \mu(x) f(x|D_i, p(X_i))\\
&= \int_{x\in \Theta_x} \mu(x) f(x|p(X_i)) \because \text{ balancing score peroperty}\\
&= \mathbb E[\mathbb E[Y_{ji}| X_i] | p(X_i)]\\
&= \mathbb E[Y_{ji}| p(X_i)] \because \text{ the smaller info set always dominates}
\end{align*}
$$
</div>

したがって, Propensity scoreで条件付けるとPotential outcomeの期待値は$D_i$に依存しないことがわかります.

## Heterogeneous Treatment Effectがある場合

理論的な背景は追いませんが, PythonでHeterogeneityがあるときのPSMを確認してみます.
いわずもがなですが, Heterogeneous Treatment effectがある場合にPropensity scoreで条件づけて
CATEを推定しにいこうとしても, よくわからないCATEが出てくることを以下確認します.

設定は以下です:

$$
\begin{align*}
& X_1 \sim Uniform(0, 1) \\
& X_2 \sim Uniform(0, 1) \\
& \Pr(D_i=1|X_i) =
    \begin{cases}
    0.3 & \text{ if } X_1 > 0.5, X_2 \leq 0.5 \\
    0.3 & \text{ if } X_1 \leq 0.5, X_2 > 0.5 \\
    0.5 & \text{ otherwise}
    \end{cases}\\
& Y_{0i} \sim Normal(0, 1)\\
& \text{uplift } =  \begin{cases}
    2 & \text{ if } X_1 > 0.5, X_2 \leq 0.5 \\
    2 & \text{ if } X_1 \leq 0.5, X_2 > 0.5 \\
    8 & \text{ if } X_1 > 0.5, X_2 > 0.5 \\
    -8 & \text{ otherwise }
    \end{cases}
\end{align*}
$$

簡単に言うと, $(x_1, x_2)$によって, 1辺長さ1の空間が四等分され, 各ブロックごとに
Treatment effectと割当確率が定まっている状況を考えます.

なお, 分析の簡略化のため, 分析者は**Trueの割当確率がわかっているものとします**. 
これは, 分析者が優秀で割当確率のTrue formの推定ができている状況と同じと考えていただけたらです.


### DGP and Distribution check

```python
import numpy as np
import pandas as pd
from plotly.subplots import make_subplots
import plotly.graph_objects as go

np.random.seed(42)

#-------------
# DGP
#-------------

def dgp(effect=[2, 8, -8]):
    N = 10000
    x1 = np.random.uniform(0, 1, N)Heterogeneityの存在
    x2 = np.random.uniform(0, 1, N)

    z1 = np.where(x1 > 0.5, 1, 0)
    z2 = np.where(x2 > 0.5, 1, 0)
    assignment_rule = z1 + z2
    assignment_prob = np.where(assignment_rule == 1, 0.3, 0.5)
    assigment = np.random.binomial(1, assignment_prob)

    potential_untreated = np.random.normal(0, 1, N)
    uplift = np.where(assignment_rule == 1, effect[0], 0.0)\
             + np.where(assignment_rule == 2, effect[1], 0.0) \
             + np.where(assignment_rule == 0, effect[2], 0.0)
    potential_treated = potential_untreated + uplift

    df = pd.DataFrame({
        'x1': x1,
        'x2': x2,
        'prob': assignment_prob,Heterogeneityの存在
        'D': assigment,
        'uplift':uplift, 
        'y0': potential_untreated,
        'y1': potential_treated
    })
    df['observed'] = (1 - df['D']) * df['y0'] + (df['D']) * df['y1']

    return df

df = dgp()
df = dgp()
df.head()
```

{% include plotly/20230706_data.html %}

```python
fig = make_subplots(rows=1, cols=2, 
                    subplot_titles=("Assignment Prob distribution", 
                                    "uplift distribution"))
trace1 = go.Scatter(x=df['x1'],
                    y=df['x2'],
                    mode='markers',
                    name='prob',
                    hovertemplate="%{marker.color}%",
                    marker=dict(color=df['prob'], colorscale='bluered'),
                    showlegend=False
                   )
trace2 = go.Scatter(x=df['x1'],
                    y=df['x2'],
                    mode='markers',
                    name='uplift',
                    hovertemplate="%{marker.color}",
                    marker=dict(color=df['uplift'],colorscale='bluered'),
                    showlegend=False
                   )
fig.append_trace(trace1,1,1)
fig.append_trace(trace2,1,2)
fig.update_layout(title_text="Assignment probability and uplift distirbution conditional on X")
```

{% include plotly/20230706_assignment_prob_and_uplift_dist.html %}


1辺長さ1の空間が四等分され, 各ブロックごとに
Treatment effectと割当確率が定まっている状況がこれで確認できたと思います.


### 推定値の確認

まずTrue effectの確認をしてみます.

```python
#--------------------
# True ATE, ATT, ATU
#--------------------
def get_true_effect(df):
    stats_df = df.groupby('D')[['y0', 'y1']].mean().reset_index(drop=True)
    stats_df = pd.concat([stats_df, 
                          pd.DataFrame(df.loc[:, ['y0', 'y1']].mean(axis=0)).T], 
                          axis=0).set_index(pd.Index(['ATU', 'ATT', 'ATE']))
    stats_df['effect'] = stats_df['y1'] - stats_df['y0']
    return stats_df

get_true_effect(df)
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>y0</th>
      <th>y1</th>
      <th>effect</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>ATU</th>
      <td>-0.006425</td>
      <td>1.248268</td>
      <td>1.254693</td>
    </tr>
    <tr>
      <th>ATT</th>
      <td>-0.005599</td>
      <td>0.578174</td>
      <td>0.583773</td>
    </tr>
    <tr>
      <th>ATE</th>
      <td>-0.006097</td>
      <td>0.981503</td>
      <td>0.987600</td>
    </tr>
  </tbody>
</table>


次に, PSMによって効果を推定してみます.

```python
def estimate_effect(df):
    y0_treated_weight = ((1 - df['D']) * df['prob']) / (1 - df['prob'])
    y1_untreated_weight = (df['D']) * (1 - df['prob']) / df['prob']
    y1_ate_weight = df['D'] / df['prob']
    y0_ate_weight = (1 - df['D'])/(1 - df['prob'])

    y0_untreated, y1_treated = df.groupby('D')['observed'].mean().values
    y0_treated = np.sum(y0_treated_weight * df['observed']) / np.sum(y0_treated_weight)
    y1_untreated = np.sum(y1_untreated_weight * df['observed']) / np.sum(y1_untreated_weight)
    
    y1_ate = np.sum(y1_ate_weight * df['observed'])/ np.sum(y1_ate_weight)
    y0_ate = np.sum(y0_ate_weight * df['observed'])/ np.sum(y0_ate_weight)

    res_df = pd.DataFrame({'y0':[y0_untreated, y0_treated, y0_ate],
                           'y1':[y1_untreated, y1_treated, y1_ate]})
    res_df = res_df.set_index(pd.Index(['ATU', 'ATT', 'ATE']))
    res_df['effect'] = res_df['y1'] - res_df['y0']

    return res_dfHeterogeneityの存在


estimate_effect(df)
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>y0</th>
      <th>y1</th>
      <th>effect</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>ATU</th>
      <td>-0.006425</td>
      <td>1.047781</td>
      <td>1.054207</td>
    </tr>
    <tr>
      <th>ATT</th>
      <td>-0.006641</td>
      <td>0.578174</td>
      <td>0.584815</td>
    </tr>
    <tr>
      <th>ATE</th>
      <td>-0.006512</td>
      <td>0.858955</td>
      <td>0.865467</td>
    </tr>
  </tbody>
</table>


ATUとATEが結構ぶれています. これがたまたまの結果なのか, 推定量のバイアスがあるかは
まだ判断できないのでシミュレーションで確かめて見る必要があります

#### シミュレーションでバイアスがあるかの確認

```python
res_true = []
res_estimates = []

for i in range(1000):
    tmp = dgp([2, 8, -8])
    res_true.append(get_true_effect(tmp).loc['ATE', 'effect'])
    res_estimates.append(estimate_effect(tmp).loc['ATE', 'effect'])

compare_df = pd.DataFrame({'true':res_true, 'estimate':res_estimates})
compare_df.describe()
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>true</th>
      <th>estimate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1000.000000</td>
      <td>1000.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1.001301</td>
      <td>1.000366</td>
    </tr>
    <tr>
      <th>std</th>
      <td>0.057647</td>
      <td>0.084449</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0.825200</td>
      <td>0.766833</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>0.963600</td>
      <td>0.945542</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1.000700</td>
      <td>1.002053</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1.039250</td>
      <td>1.056441</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.176400</td>
      <td>1.262194</td>
    </tr>
  </tbody>
</table>

- standard errorの大きさと比べてもPSMのバイアスはそこまで大きいものではない
- 上で見えたバイアスらしきものはたまたま乱数の結果発生したものを考えることができる

### Propensity scoreで条件づけたHeterogeneityの推定

```python
hetero_df = df.groupby('prob')[['y0', 'y1']].mean()
hetero_df['effect'] = hetero_df['y1'] - hetero_df['y0']
hetero_df
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>y0</th>
      <th>y1</th>
      <th>effect</th>
    </tr>
    <tr>
      <th>prob</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0.3</th>
      <td>-0.000718</td>
      <td>1.999282</td>
      <td>2.000000</td>
    </tr>
    <tr>
      <th>0.5</th>
      <td>-0.011445</td>
      <td>-0.030592</td>
      <td>-0.019146</td>
    </tr>
  </tbody>
</table>


`prob == 0.3`は問題設定上, TrueのCATEと対応する関係だったのでうまく推定できていますが, `prob == 0.5`は2つの属性に分割されており, それらCATEの平均の値が計算結果として出力されています. そのため, Heterogeneityがあるのはわかりますが, Heterogeneityの背景にあるメカニズムを示唆するような内容にはなっていません. 

> REMARKS

- propensity scoreで条件づけたCATEが異なっている場合はHeterogeneityの存在を示唆するが, 正しく推定できるとは限らない
- propensity scoreで条件づけたCATEが似通っているとしてもHeterogeneityの存在がないとは限らない
- Heterogeneityがある場合, ATEが効果がないように見えてしまうケースもある


## Follow up Question

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins> Question </ins></p>

- 会社Aは複数の事業所に分かれており, 事業所単位でスキルアップクラスを提供したりしていなかったりする
- 事業所がスキルアップクラスを提供するかどうかは完全にrandomに定まっているとする

このとき, このrandom assignment変数をpropensity scoreに組み込んだとき, 推定量はどのような影響を受けるか？ 

</div>

このときの答えは

- Nothing (in expectation) to the effect
- standard errorsは増加する

となります. これを考えてみましょう.

またこのときトライすべきこととしては

- ITT(=クラス受講ではなくてクラス提供の効果)を推定する
- IVでクラス受講効果を推定する(perfect complianceがあるわけではないと思われるので)


References
-----------

- [Mostly Harmless Econometrics: An Empiricist's Companion](https://www.mostlyharmlesseconometrics.com/)
