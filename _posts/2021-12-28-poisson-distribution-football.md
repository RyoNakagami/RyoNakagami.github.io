---
layout: post
title: "統計検定：ポワソン分布と条件付き分布 その２"
subtitle: "19-20シーズンのMan Utdの得点力をポワソン分布で表現してみる"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
tags:

- 統計
- ポワソン分布
- スポーツ
---

> 目的

- プレミアリーグ（Man Utd）の試合結果を使って, サッカーの得点分布とポワソン分布の適合度を確認するものです
- この分析において結果的には結構Fitしますが, たまたまだと思ってます.
- アーセナルやシティ, 川崎Fといった攻撃的チームの得点分布はポワソンじゃ説明できない感じです


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Dependency](#dependency)
- [19-20シーズンのMan Utdの得点力分析](#19-20%E3%82%B7%E3%83%BC%E3%82%BA%E3%83%B3%E3%81%AEman-utd%E3%81%AE%E5%BE%97%E7%82%B9%E5%8A%9B%E5%88%86%E6%9E%90)
  - [READ Data](#read-data)
  - [前処理](#%E5%89%8D%E5%87%A6%E7%90%86)
  - [得点分布をヒストグラムで確かめてみる](#%E5%BE%97%E7%82%B9%E5%88%86%E5%B8%83%E3%82%92%E3%83%92%E3%82%B9%E3%83%88%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%A7%E7%A2%BA%E3%81%8B%E3%82%81%E3%81%A6%E3%81%BF%E3%82%8B)
  - [Poisson Fitting](#poisson-fitting)
    - [推定量$\hat\lambda$についてのワルド型信頼区間の計算](#%E6%8E%A8%E5%AE%9A%E9%87%8F%5Chat%5Clambda%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6%E3%81%AE%E3%83%AF%E3%83%AB%E3%83%89%E5%9E%8B%E4%BF%A1%E9%A0%BC%E5%8C%BA%E9%96%93%E3%81%AE%E8%A8%88%E7%AE%97)
  - [ZIP Fitting](#zip-fitting)
- [Appendix: ZIP推定量のクラス](#appendix-zip%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%AE%E3%82%AF%E3%83%A9%E3%82%B9)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Dependency

> Python version

- Python 3.9.x

> Library

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
from scipy.optimize import minimize
import math
```

## 19-20シーズンのMan Utdの得点力分析
### READ Data

この[Man Utd English Premier League 2019/20 fixture and results](https://fixturedownload.com/results/epl-2019/man-utd)というサイトではプレミアリーグの各シーズン及び各チームの試合結果が保存されています. ここで抽出にあたってのTipsとして、上記サイトのURLの構造は

```
https://fixturedownload.com/results/epl-<シーズン>/<team名>
```

となっています. この構造に注意して今回は

|parameter|parameter value|意味|
|---|---|---|
|team名| `man-utd`|Man Utd, すべて小文字、スペースはハイフンとなる|
|シーズン| `2019`|2019-2020シーズン|

という軸でデータを抽出します.


> Python

```python
target_team = 'man-utd'
TARGET_TEAMNAME = target_team.replace('-', ' ').title()
URL_PATH = 'https://fixturedownload.com/results/epl-2019/'+target_team

df = pd.read_html(URL_PATH, flavor="bs4")[0]
df.head()
```

出力結果は

<table border="1" class="dataframe">  <thead>    <tr style="text-align: right;">      <th></th>      <th>Round Number</th>      <th>Date</th>      <th>Location</th>      <th>Home Team</th>      <th>Away Team</th>      <th>Result</th>    </tr>  </thead>  <tbody>    <tr>      <th>0</th>      <td>1</td>      <td>11/08/2019 16:30</td>      <td>Old Trafford</td>      <td>Man Utd</td>      <td>Chelsea</td>      <td>4 - 0</td>    </tr>    <tr>      <th>1</th>      <td>2</td>      <td>19/08/2019 20:00</td>      <td>Molineux Stadium</td>      <td>Wolves</td>      <td>Man Utd</td>      <td>1 - 1</td>    </tr>    <tr>      <th>2</th>      <td>3</td>      <td>24/08/2019 15:00</td>      <td>Old Trafford</td>      <td>Man Utd</td>      <td>Crystal Palace</td>      <td>1 - 2</td>    </tr>    <tr>      <th>3</th>      <td>4</td>      <td>31/08/2019 12:30</td>      <td>St. Mary\'s Stadium</td>      <td>Southampton</td>      <td>Man Utd</td>      <td>1 - 1</td>    </tr>    <tr>      <th>4</th>      <td>5</td>      <td>14/09/2019 15:00</td>      <td>Old Trafford</td>      <td>Man Utd</td>      <td>Leicester</td>      <td>1 - 0</td>    </tr>  </tbody></table>

### 前処理

> どのような処理が必要か？

`read_html`で呼び出されたDataFrameは試合結果が`Result`カラムに格納されていますが、以下の問題点があります:

- `Home - Away`の順番でスコアが格納されているので、試合ごとのAwayチーム(or Homeチーム)を参照して、どちらの数値がMan Utdの数値か判断する必要あり
- 今回はポワソン回帰したいので、スコアが現状では文字列になっているが、それをIntegerに修正する必要があり


> Pythonで前処理用関数の定義

```python
def extract_score(data, target_team, score_col = 'Result'):
    score_list = data[score_col].str.split(r'\s-\s', expand= True)
    score_list.columns = ['home_score', 'away_score']
    score_list = score_list.astype({'home_score': 'int64', 'away_score': 'int64'})

    df = pd.concat([data, score_list], axis = 1)
    df['score_per_game'] = np.where(df['Home Team'] == target_team, df['home_score'], df['away_score'])
    df['loss_per_game'] = np.where(df['Away Team'] == target_team, df['home_score'], df['away_score'])

    return df

def extract_opponent_team(data, target_team, columns = ['Home Team', 'Away Team'], export_column = 'opponent_team'):
    data[export_column] = data[columns[0]] + data[columns[1]]
    data[export_column] = data[export_column].replace(target_team, '', regex=True)

    return data
```


> Pythonで前処理実行

```python
df_transformed = extract_opponent_team(data = df, target_team = TARGET_TEAMNAME)
df_transformed = extract_score(df_transformed, target_team = TARGET_TEAMNAME)
df_transformed.head()
```

出力結果は

<table border="1" class="dataframe">  <thead>    <tr style="text-align: right;">      <th></th>      <th>Round Number</th>      <th>Date</th>      <th>Location</th>      <th>Home Team</th>      <th>Away Team</th>      <th>Result</th>      <th>opponent_team</th>      <th>home_score</th>      <th>away_score</th>      <th>score_per_game</th>      <th>loss_per_game</th>    </tr>  </thead>  <tbody>    <tr>      <th>0</th>      <td>1</td>      <td>11/08/2019 16:30</td>      <td>Old Trafford</td>      <td>Man Utd</td>      <td>Chelsea</td>      <td>4 - 0</td>      <td>Chelsea</td>      <td>4</td>      <td>0</td>      <td>4</td>      <td>0</td>    </tr>    <tr>      <th>1</th>      <td>2</td>      <td>19/08/2019 20:00</td>      <td>Molineux Stadium</td>      <td>Wolves</td>      <td>Man Utd</td>      <td>1 - 1</td>      <td>Wolves</td>      <td>1</td>      <td>1</td>      <td>1</td>      <td>1</td>    </tr>    <tr>      <th>2</th>      <td>3</td>      <td>24/08/2019 15:00</td>      <td>Old Trafford</td>      <td>Man Utd</td>      <td>Crystal Palace</td>      <td>1 - 2</td>      <td>Crystal Palace</td>      <td>1</td>      <td>2</td>      <td>1</td>      <td>2</td>    </tr>    <tr>      <th>3</th>      <td>4</td>      <td>31/08/2019 12:30</td>      <td>St. Mary\'s Stadium</td>      <td>Southampton</td>      <td>Man Utd</td>      <td>1 - 1</td>      <td>Southampton</td>      <td>1</td>      <td>1</td>      <td>1</td>      <td>1</td>    </tr>    <tr>      <th>4</th>      <td>5</td>      <td>14/09/2019 15:00</td>      <td>Old Trafford</td>      <td>Man Utd</td>      <td>Leicester</td>      <td>1 - 0</td>      <td>Leicester</td>      <td>1</td>      <td>0</td>      <td>1</td>      <td>0</td>    </tr>  </tbody></table>

> Summary statistics

|	|score_per_game|loss_per_game|
|---|---|---|
|count |38.00 | 38.0 0|
|mean |1.73 | 0.94 |
|std |1.34 | 0.83 |
|var |1.82 | 0.69 |
|min |0.00 | 0.00 |
|25% |1.00 | 0.00 |
|50% |2.00 | 1.00 |
|75% |3.00 | 1.75 |
|max |5.00 | 3.00 |

### 得点分布をヒストグラムで確かめてみる

```python
plt.subplots(figsize=(12, 8))
plt.bar(*np.unique(df_transformed['score_per_game'], return_counts=True))
plt.xlabel('Score per game in 2019-20')
plt.ylabel('Count');
```

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211228-01.png?raw=true">


### Poisson Fitting

確率変数$X$を一試合あたりの得点数とし, かつポワソン分布に従うとすると確率関数は以下のように書けます:

$$
\begin{align*}
p(X=x) = \frac{\lambda^x}{x!}\exp(-\lambda)
\end{align*}
$$

$\hat\lambda$は標本平均で推定できるのでFittingの程度を確認すると以下のようになります:


```python
## generating data
N = len(df_transformed['score_per_game'])
x_range = np.arange(0, max(df_transformed['score_per_game'])+2) 


## poisson object
observed_lambda = np.mean(df_transformed['score_per_game'])
observed_var = np.var(df_transformed['score_per_game'], ddof=1)
poisson_rv = stats.poisson(observed_lambda)

## plot
fig, ax = plt.subplots(1, 1,figsize=(10, 7))
ax.bar(*np.unique(df_transformed['score_per_game'], return_counts=True), alpha = 0.5)
ax.plot(x_range, poisson_rv.pmf(x_range)*N, label = 'theoretical pmf')
ax.set_xlabel('outcome')
ax.set_ylabel('Frequency')
ax.set_title('the observed $\lambda$: {:.2f}, the data variance:{:.2f}'.format(observed_lambda, observed_var))
plt.legend();
```

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211228-02.png?raw=true">

- Fittingはそんなに悪くないがscoreがゼロのところが理論頻度より実現地のほうが多くZIPモデルで回帰してもいいとかも
- 上位チームと戦うときと下位チームで戦うときで戦型を変えてると仮定すると得点は２つ以上の分布の混合分布かもしれない

#### 推定量$\hat\lambda$についてのワルド型信頼区間の計算

推定量$\hat\lambda$の95%信頼区間, $CI$, を簡易的に表現すると以下のようになります

$$
CI = \left(\hat\lambda - 1.96 \sqrt{\frac{\hat\lambda}{N}}, \hat\lambda + 1.96 \sqrt{\frac{\hat\lambda}{N}}\right)
$$

Intuitionとしては, 1試合ごとの得点数を表す確率変数$X_i$, (なお$i$は試合indexを示す), を考えた時, $\hat\lambda$は次のように計算されます:

$$
\hat\lambda =\frac{1}{N}\sum_{i}^N X_i
$$

このとき, $X_i$はパラメーター$\lambda$のポワソン分布に独立に従うと仮定すると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbb E[\hat\lambda] &= \sum_{i}^N\frac{\mathbb E[X_i]}{N} = \lambda\\
V(\hat\lambda) &= \frac{1}{N^2}\sum_{i}^N V[X_i] = \frac{\lambda}{N}
\end{align*}
$$
</div>

従って, $\lambda$を推定量と置き換えて,簡易的に計算すると

$$
CI = \left(\hat\lambda - 1.96 \sqrt{\frac{\hat\lambda}{N}}, \hat\lambda + 1.96 \sqrt{\frac{\hat\lambda}{N}}\right)
$$

が導出されます.

### ZIP Fitting

- [Appendix: ZIP推定量のクラス](#appendix-zip%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%AE%E3%82%AF%E3%83%A9%E3%82%B9)で作ったPython Classを用いてZIP paramters $(\lambda, w)$を推定します


```python
zip_mle = ZeroInflatedPoissonRegression(data=df_transformed['score_per_game'])
zip_result = zip_mle.fit()
print(zip_result)
```

Then,

```raw
Optimization terminated successfully.
         Current function value: 62.424527
         Iterations: 36
         Function evaluations: 70
 final_simplex: (array([[1.85621155, 0.06431309],
       [1.85626758, 0.06431888],
       [1.85628597, 0.0643349 ]]), array([62.42452735, 62.42452736, 62.42452738]))
           fun: 62.4245273467983
       message: 'Optimization terminated successfully.'
          nfev: 70
           nit: 36
        status: 0
       success: True
             x: array([1.85621155, 0.06431309])
```

> ZIPパラメータに基づくFittingと可視化

```python
## poisson object
observed_lambda, zip_w = zip_result.x

## plot
fig, ax = plt.subplots(1, 1,figsize=(10, 7))
ax.bar(*np.unique(df_transformed['score_per_game'], return_counts=True), alpha = 0.5)
ax.plot(x_range, ZeroInflatedPoissonRegression.zip_pmf(x_range, theta = [observed_lambda, zip_w])*N, label = 'theoretical pmf')
ax.set_xlabel('outcome')
ax.set_ylabel('Frequency')
ax.set_title('the zip $\lambda$: {:.2f}, the zip w:{:.2f}, the data variance:{:.2f}'.format(observed_lambda, zip_w, observed_var))
plt.legend();
```

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211228-03.png?raw=true">

- 当たり前だけど、普通のポワソン分布で回帰したときよりもFitは上昇する(パラメータ増えているため)
- plotによって可視化したFitをみると、ZIPのあてはまりのよさを見ることができる

## Appendix: ZIP推定量のクラス

くわしくは「[Ryo's Tech Blog>統計検定：ポワソン分布と条件付き分布](https://ryonakagami.github.io/2021/12/27/poisson-distribution/)」を読んでください.

```python
class ZeroInflatedPoissonRegression:

    def __init__(self, data):
        self.data = data
        self.init_value = None

    @staticmethod
    def zip_pmf(x, theta):
        vec_factorial = np.vectorize(math.factorial)
        return (theta[1] + (1 - theta[1])*np.exp(-theta[0]))**np.where(x > 0, 0, 1) * ((1 - theta[1]) * np.exp(-theta[0]) * theta[0]**x / vec_factorial(x)) **np.where(x > 0, 1, 0)
    
    @staticmethod
    def em_update(x, theta):    
        next_theta_1 = (len(x[x < 1]) - len(x) * np.exp(-theta[0]))/ (1 - np.exp(-theta[0])) 
        next_theta_0 = np.sum(x)/(len(x) - next_theta_1)

        return [next_theta_0, next_theta_1]

    def estimate_conditional_poisson(self):
        lambert_w = np.mean(self.data[self.data > 0])
        estimated_lambda = lambertw(-lambert_w/np.exp(lambert_w), 0) + lambert_w
        
        return estimated_lambda.real

    def method_of_moment(self):
        sample_mean = np.mean(self.data)
        sample_second_moment = np.mean(self.data**2)

        theta_moment = [sample_second_moment / sample_mean - 1, 1 - sample_mean **2 / (sample_second_moment - sample_mean)]
        return theta_moment
    
    def neg_loglike(self, theta, _data, normalize = False):
        if normalize:
            theta = theta[0], theta[1]/len(_data)

        return np.sum(np.log(self.zip_pmf(x = _data, theta = theta)))

    def fit(self):
        f = lambda theta: -self.neg_loglike(theta = theta, _data = self.data)
        self.init_value = self.method_of_moment()

        return minimize(fun = f, x0=self.init_value, method = 'Nelder-Mead', options={'disp': True})

    def em_fit(self, eps = 1e-10):
        lambda_t = self.estimate_conditional_poisson()
        m_t = len(self.data[self.data < 1])
        theta = [lambda_t, m_t]
        next_theta = self.em_update(self.data, theta)

        while abs(self.neg_loglike(theta = next_theta, _data = self.data, normalize=True) - self.neg_loglike(theta = theta, _data = self.data, normalize=True)) > eps:
            theta = next_theta
            next_theta = self.em_update(self.data, theta)
        
        next_theta[1] = next_theta[1]/len(self.data)

        return next_theta
        

## Generating Data
#data = np.repeat(np.arange(0, 7), np.array([22, 23, 26, 18, 6, 4, 1]))
#
## Create the instance
#poisson_mle = ZeroInflatedPoissonRegression(data=data)
#
## fit
#res_mle = poisson_mle.fit().x
#res_em = poisson_mle.em_fit()
#res_mom = poisson_mle.method_of_moment()
#
#print(res_mle, res_em, res_mom)
```


## References

- [Man Utd English Premier League 2019/20 fixture and results](https://fixturedownload.com/results/epl-2019/man-utd)
- [Ryo's Tech Blog>統計検定：ポワソン分布と条件付き分布](https://ryonakagami.github.io/2021/12/27/poisson-distribution/)

> 統計検定過去問

- 2012年11月統計検定１級 > 応用数理(共通分野)問２