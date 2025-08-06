---
layout: post
title: "傾向スコアのAUCの良さは推定量の性質の良さにつながるのか？"
subtitle: "Propensity score & Conditional Independence Assumption（続編）"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-11-05
tags:

- 統計
- Python
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
- [シミュレーション設定](#%E3%82%B7%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E8%A8%AD%E5%AE%9A)
  - [推定量について](#%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [シミュレーション結果](#%E3%82%B7%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E7%B5%90%E6%9E%9C)
  - [Normalized Differenceの確認](#normalized-difference%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [結び](#%E7%B5%90%E3%81%B3)
- [Appendix: Python code](#appendix-python-code)
  - [DGP](#dgp)
  - [Estimator](#estimator)
  - [Simulation code](#simulation-code)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## 問題設定


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins> Question </ins></p>

- 会社Aは複数の事業所に分かれており, 事業所単位でスキルアップクラスを提供したりしていなかったりする
- 事業所がスキルアップクラスを提供するかどうかは完全にrandomに定まっているとする

このとき, このrandom assignment変数$Z_i$をpropensity scoreに組み込んだとき, 推定量に対する影響としては

- Nothing (in expectation) to the effect
- standard errorsは増加する

</div>

propensity scoreによるATEの推定(IPWを含む)にあたって, CIAが成立しているもとでのバランシングスコアが理論的根拠なので, 
Potential Outcomeに対するCIAが少ない変数の集合で成立しているならば, 

- 変数を増やしても影響はない
- $\mathbb E[Y_{ij} \vert D_i, X_i, Z_i]$のノイズが大きくなるので推定量のstandard errorsは増加する

というのは直感的には理解できると思います. これを数値計算で確認するのが本記事の目的です


## シミュレーション設定

datasetはsample size, $N = 10000$として以下のData Generating Processに従うとします

$$
\begin{align*}
x_1 &\sim Uniform(0, 1)\\[3pt]
x_2 &\sim Uniform(0, 1)\\[3pt]
x_3 &\sim Uniform(0, 1)\\[3pt]
\epsilon_i &\sim N(0, 0.5)\\[3pt]
prob_i &= \frac{1}{1 + \exp(0.5 - 2x_1 + 2x_2 + 2x_1x_2 - x_3)}\\
D_i &\sim binom(1, prob_i)\\[3pt]
Y_{0i} &= \exp(2x_1) + \epsilon_i\\[3pt]
Y_{1i} &= Y_{0i} + 1\\[3pt]
Y_i &= D_iY_{1i} + (1 - D_i)Y_{0i}
\end{align*}
$$

施策$D_i$の割当確率はlogitに従うとし, $(x_1, x_2, x_3)$によって決定される. 
一方, potential outcomeの分布に影響を与えるのは $x_1$ のみ. つまり

$$
\mathbb E[Y_{ji}|D_i,x_1, x_2, x_3] = \mathbb E[Y_{ji}|D_i,x_1] = \mathbb E[Y_{ji}|x_1] 
$$


という状況を考えます. また, uplift effect = 1という形で施策効果はconstantとしています.

DGPの結果の一例として, observed outcome $Y_i$の$D_i$ごとの平均は以下となります.
単純比較では施策効果が1.5近辺となりupward biasが発生してしまっています, 

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>D</th>
      <th>0</th>
      <th>1</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="8" valign="top">observed</th>
      <th>count</th>
      <td>6149.000000</td>
      <td>3851.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>2.955953</td>
      <td>4.465919</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1.774988</td>
      <td>1.893814</td>
    </tr>
    <tr>
      <th>min</th>
      <td>-0.501517</td>
      <td>-0.031790</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1.564539</td>
      <td>2.893273</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>2.508593</td>
      <td>4.125529</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>4.070802</td>
      <td>5.898188</td>
    </tr>
    <tr>
      <th>max</th>
      <td>8.575620</td>
      <td>9.463890</td>
    </tr>
    <tr>
      <th rowspan="8" valign="top">logit_cia</th>
      <th>count</th>
      <td>6149.000000</td>
      <td>3851.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>0.378282</td>
      <td>0.395986</td>
    </tr>
    <tr>
      <th>std</th>
      <td>0.063560</td>
      <td>0.064856</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0.278799</td>
      <td>0.278796</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>0.322965</td>
      <td>0.339708</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>0.371775</td>
      <td>0.399320</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>0.429691</td>
      <td>0.453660</td>
    </tr>
    <tr>
      <th>max</th>
      <td>0.502034</td>
      <td>0.501983</td>
    </tr>
    <tr>
      <th rowspan="8" valign="top">logit_full</th>
      <th>count</th>
      <td>6149.000000</td>
      <td>3851.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>0.317717</td>
      <td>0.492693</td>
    </tr>
    <tr>
      <th>std</th>
      <td>0.176661</td>
      <td>0.197903</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0.068672</td>
      <td>0.078593</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>0.172645</td>
      <td>0.333182</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>0.272893</td>
      <td>0.500188</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>0.429088</td>
      <td>0.654429</td>
    </tr>
    <tr>
      <th>max</th>
      <td>0.886679</td>
      <td>0.897462</td>
    </tr>
  </tbody>
</table>



### 推定量について

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>推定量方針</ins></p>

- propensity score推定後のATE推定量はIPW推定量を用いる
- propensity score自体の推定は分析者はlogitが妥当するとしっているとする
- propensity scoreの推定にあたっては以下2つのパターンを試す
    - `cia_model`: 分析者は$x_1$のみを用いた単回帰logitを実行するパターン
    - `full_model`: $x_1, x_2, x_3$をtrue formでlogit回帰を実行するパターン
- シミュレーションは1000回実施する(1000回DGPを回す)

</div>

なお, 2つのpropensity score推定量の性能比較として今回は簡易的にAUCを用います.

予想される結果としては

- `full_model`のほうがAUCスコアが圧倒的に良い
- ATE推定量としては`cia_model`, `full_model`どちらもバイアスはない
- 推定量の分散を加味すると`cia_model`のほうが効率的である

> REMARKS

- 今回はtrain-testに分けようがデータの分布は同じと確信があるので, めんどくさいので推定の段階では分けていないです

## シミュレーション結果

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>true</th>
      <th>estimate_cia</th>
      <th>estimate_full</th>
      <th>auc_cia</th>
      <th>auc_full</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1.000000e+03</td>
      <td>1000.000000</td>
      <td>1000.000000</td>
      <td>1000.000000</td>
      <td>1000.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1.000000e+00</td>
      <td>0.996162</td>
      <td>0.999949</td>
      <td>0.575555</td>
      <td>0.743761</td>
    </tr>
    <tr>
      <th>std</th>
      <td>5.450743e-16</td>
      <td>0.012943</td>
      <td>0.018541</td>
      <td>0.006137</td>
      <td>0.004751</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000e+00</td>
      <td>0.956735</td>
      <td>0.931434</td>
      <td>0.556370</td>
      <td>0.728875</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1.000000e+00</td>
      <td>0.987529</td>
      <td>0.987892</td>
      <td>0.571321</td>
      <td>0.740480</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1.000000e+00</td>
      <td>0.996294</td>
      <td>1.000240</td>
      <td>0.575663</td>
      <td>0.743732</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1.000000e+00</td>
      <td>1.004821</td>
      <td>1.012625</td>
      <td>0.579839</td>
      <td>0.746824</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.000000e+00</td>
      <td>1.037352</td>
      <td>1.056248</td>
      <td>0.594460</td>
      <td>0.757005</td>
    </tr>
  </tbody>
</table>


- `cia_model`, `full_model`ともにバイアスはないと解釈できる形で推定値が出ている
  - 若干, `full_model`のほうがバイアスは少ないように見受けられる
- AUCに着目すると`full_model`のほうが圧倒的に`cia_model`より性能が良いと解釈できる
- 一方, 予想されていたようにATE推定量は`full_model`のほうが分散が `cia_model` よりも大きい


> 推定値の傾向について

以下のように傾向としては一致しているので, Robustness checkで両方の推定量が大きくかけ離れていないか？を確認することは今回のケースでは有用であると示唆してくれている.

{% include plotly/20230707_fullmodel_vs_ciamodel.html %}



### Normalized Differenceの確認

傾向スコアはそもそも, バランシングスコアであることがモットーなので各特徴量のバランシング, 
特に$x_1$特徴量のバランシングがどのように調整されているか確認してみる.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Normalized Differnce</ins></p>

- covariateのバランスはnormalized differenceがよく用いられる
- 差が小さいほどよく,0.25を超えるか否かがrule of thumbとされている

$$
\text{Normalized Difference}_j = \frac{|\bar x_{treated, j} - \bar x_{control, j}|}{(s_{treated, j}^2 + s_{control, j}^2)^{1/2}}
$$

</div>

simulationの最後に出てきたdatasetを用いて簡易的に比較してみると以下のような結果になる.

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>features</th>
      <th>snd_cia</th>
      <th>snd_fill</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>x1</td>
      <td>0.160808</td>
      <td>0.209398</td>
    </tr>
    <tr>
      <th>1</th>
      <td>x2</td>
      <td>0.594803</td>
      <td>0.470987</td>
    </tr>
    <tr>
      <th>2</th>
      <td>x3</td>
      <td>0.145993</td>
      <td>0.125899</td>
    </tr>
  </tbody>
</table>


- `cia_model`と`full_model`を比較すると$x_1$のバランシングは`cia_model`のほうが良い
- Potential outcomeの分布は$x_1$に依存するのでこの変数がバランシングしている方が良い推定量であるはず
- `cia_model`推定量のほうが推定値の分散が小さいことと整合的である
- $x_2, x_3$を見てみると, `full_model`のほうが比較的バランシングしている（考慮した形で推定しているのでそれはそう）
- ただし, $x_2, x_3$のバランシングはCIAの成立形態を踏まえると重要ではない

## 結び

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS</ins></p>

- propensity scoreという推定量のクラスを考えた場合, AUCがよいモデルが本当に良いとは限らない(あくまで反例の紹介)
- propensity scoreという推定量が機能するか否かはあくまでCIAがどのような形で成立しているかに依存する
- Normazlied differenceは重要な特徴量がバランスしているかを判断する指標にはなるが, 解釈はあくまでCIAがどのような形で成立しているかに依存する

</div>

ただし, 上記のシミュレーションではcommon supportの仮定を満たすようにいい感じにパラメータを設定した状況での数値計算の結果であって, 現実的なpropensity scoreの問題はどちらかというとpropensity score推定量のmisspecificationに起因するバイアスの発生です.

また, 今回のケースで$Y_{0i}$のheterogeneityを$\exp(10x_1)$などのように大きくすると, IPW推定量は大きくずれたりするので, Propensity scoreはRobustness checkで複数のspecificationでの結果を踏まえながら解釈する必要がありそうです.


## Appendix: Python code
### DGP
```python
#%%
import numpy as np
import pandas as pd
import plotly.express as px
import statsmodels.api as sm 
from sklearn import metrics

#-------------
# DGP
#-------------
def dgp():
    N = 10000
    x1 = np.random.uniform(0, 1, N)
    x2 = np.random.uniform(0, 1, N)
    x3 = np.random.uniform(0, 1, N)

    logit_model = np.exp(-0.5 + 2 * x1 - 2 * x2 - 2 * x1*x2 + 1 * x3)
    assignment_prob = logit_model / (1 + logit_model)
    assigment = np.random.binomial(1, assignment_prob)

    potential_untreated = np.exp(2 * x1) + np.random.normal(0, 0.5, N)
    uplift = 1
    potential_treated = potential_untreated + uplift


    df = pd.DataFrame({
        'const': 1,
        'x1': x1,
        'x2': x2,
        'x3': x3,
        'x1x2': x1*x2,
        'prob': assignment_prob,
        'D': assigment,
        'uplift':uplift, 
        'y0': potential_untreated,
        'y1': potential_treated
    })
    df['observed'] = (1 - df['D']) * df['y0'] + (df['D']) * df['y1']

    return df

def logit_compute(df):
    y = df.loc[:, 'D'].values
    x_simple = df.loc[:, ['const', 'x1']]
    x_true = df.loc[:, ['const', 'x1', 'x2', 'x1x2', 'x3']]

    logit_reg_simple = sm.Logit(y, x_simple).fit()
    logit_reg_true = sm.Logit(y, x_true).fit()

    df['logit_cia'] = logit_reg_simple.predict(x_simple)
    df['logit_full'] = logit_reg_true.predict(x_true)
    return df

def get_auc(df, col):
    fpr, tpr = metrics.roc_curve(df['D'], df[col], pos_label=1)[:2]
    return metrics.auc(fpr, tpr)

def compute_normalized_diff(df, prob='logit_cia'):
    features = ['x1', 'x2', 'x3']
    snd = []

    wtavg = lambda x: np.average(x.loc[:,features], weights = x[prob].values, axis = 0)
    tmp_df = df.loc[:, features + ['D', prob]]
    weighted_mean = tmp_df.groupby(['D']).apply(wtavg)
    weighted_var = tmp_df.groupby(['D']).var()
    
    for i, j in enumerate(features):
        mean_dif = abs(weighted_mean[0][i] - weighted_mean[1][i])
        denominator = np.sqrt(np.sum(weighted_var[j]))
        smd = mean_dif/denominator
        snd.append(smd)
    
    return pd.DataFrame({'features': features, 'snd': snd})

df = dgp()
df = logit_compute(df)
```

### Estimator

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

def estimate_effect(df, col='logit_cia'):
    y0_treated_weight = ((1 - df['D']) * df[col]) / (1 - df[col])
    y1_untreated_weight = (df['D']) * (1 - df[col]) / df[col]
    y1_ate_weight = df['D'] / df[col]
    y0_ate_weight = (1 - df['D'])/(1 - df[col])

    y0_untreated, y1_treated = df.groupby('D')['observed'].mean().values
    y0_treated = np.sum(y0_treated_weight * df['observed']) / np.sum(y0_treated_weight)
    y1_untreated = np.sum(y1_untreated_weight * df['observed']) / np.sum(y1_untreated_weight)
    
    y1_ate = np.sum(y1_ate_weight * df['observed'])/ np.sum(y1_ate_weight)
    y0_ate = np.sum(y0_ate_weight * df['observed'])/ np.sum(y0_ate_weight)

    res_df = pd.DataFrame({'y0':[y0_untreated, y0_treated, y0_ate],
                           'y1':[y1_untreated, y1_treated, y1_ate]})
    res_df = res_df.set_index(pd.Index(['ATU', 'ATT', 'ATE']))
    res_df['effect'] = res_df['y1'] - res_df['y0']

    return res_df
```

### Simulation code

```python
#-----------------
# simulation
#-----------------
np.random.seed(42)

res_true = []
res_estimates_cia = []
res_estimates_full = []
cia_auc = []
cia_full = []    

for i in range(1000):
    tmp = dgp()
    tmp = logit_compute(tmp)
    res_true.append(get_true_effect(tmp).loc['ATE', 'effect'])
    res_estimates_cia.append(estimate_effect(tmp).loc['ATE', 'effect'])
    res_estimates_full.append(estimate_effect(tmp, col='logit_full').loc['ATE', 'effect'])
    cia_auc.append(get_auc(tmp, 'logit_cia'))
    cia_full.append(get_auc(tmp, 'logit_full'))

compare_df = pd.DataFrame({'true':res_true, 
                           'cia_model_ATE':res_estimates_cia, 
                           'full_model_ATE':res_estimates_full,
                           'cia_model_AUC': cia_auc,
                           'full_model_AUC': cia_full})
compare_df.describe()
```


References
-----------

- [Mostly Harmless Econometrics: An Empiricist's Companion](https://www.mostlyharmlesseconometrics.com/)
- [Ryo's Tech Blog > Propensity score & Conditional Independence Assumption](https://ryonakagami.github.io/2023/07/06/propensity-score-conditional-independence/)
