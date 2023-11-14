---
layout: post
title: "機械学習モデル精度の評価"
subtitle: "意思決定とモデル精度の橋渡し 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-03-13
tags:

- Metrics
- 統計
- statistical inference
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [評価指標の基本原則](#%E8%A9%95%E4%BE%A1%E6%8C%87%E6%A8%99%E3%81%AE%E5%9F%BA%E6%9C%AC%E5%8E%9F%E5%89%87)
  - [RULE 1: ビジネスの構造を理解する](#rule-1-%E3%83%93%E3%82%B8%E3%83%8D%E3%82%B9%E3%81%AE%E6%A7%8B%E9%80%A0%E3%82%92%E7%90%86%E8%A7%A3%E3%81%99%E3%82%8B)
  - [RULE 2: ビジネスKPIと結びつきの強い評価指標を選択する](#rule-2-%E3%83%93%E3%82%B8%E3%83%8D%E3%82%B9kpi%E3%81%A8%E7%B5%90%E3%81%B3%E3%81%A4%E3%81%8D%E3%81%AE%E5%BC%B7%E3%81%84%E8%A9%95%E4%BE%A1%E6%8C%87%E6%A8%99%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%99%E3%82%8B)
- [ビジネスにおける評価指標](#%E3%83%93%E3%82%B8%E3%83%8D%E3%82%B9%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E8%A9%95%E4%BE%A1%E6%8C%87%E6%A8%99)
  - [KPI](#kpi)
  - [KPIの４つの必要条件](#kpi%E3%81%AE%EF%BC%94%E3%81%A4%E3%81%AE%E5%BF%85%E8%A6%81%E6%9D%A1%E4%BB%B6)
- [Confusion matrix](#confusion-matrix)
- [Metrics](#metrics)
  - [特異度 (specificity, True Negative Rate, TNR)](#%E7%89%B9%E7%95%B0%E5%BA%A6-specificity-true-negative-rate-tnr)
  - [False Positive Rate, FPR](#false-positive-rate-fpr)
  - [Accuracy](#accuracy)
  - [Precision-Recall](#precision-recall)
  - [F-measures](#f-measures)
- [ROC曲線](#roc%E6%9B%B2%E7%B7%9A)
  - [AUCの計算式について](#auc%E3%81%AE%E8%A8%88%E7%AE%97%E5%BC%8F%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [Appendix](#appendix)
  - [DSがビジネス問題を解くときに考えるべきこと](#ds%E3%81%8C%E3%83%93%E3%82%B8%E3%83%8D%E3%82%B9%E5%95%8F%E9%A1%8C%E3%82%92%E8%A7%A3%E3%81%8F%E3%81%A8%E3%81%8D%E3%81%AB%E8%80%83%E3%81%88%E3%82%8B%E3%81%B9%E3%81%8D%E3%81%93%E3%81%A8)
- [Refrences](#refrences)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 評価指標の基本原則
### RULE 1: ビジネスの構造を理解する

- ビジネスの利益構造をまず理解する
- ビジネスの利益構造を踏まえた上で, 解くべき目的関数を定式化する

> 誤り起因の損失の非対称と目的関数

観測データを基にクラス分類を実行する時, 性病検査のように梅毒感染者を陰性と分類するときと非感染者を陽性と分類する時の損失が違うように, 
**誤りを犯すことによって発生する危険性はクラス間で対称とは限らない**ということを忘れてはいけません.

このような状況における目的関数の定式化例として以下:

$$
\min\sum_{i=1}^N \sum_{k=1}^K L_{ik} P(C_{k}|\pmb{x_i})
$$

- $i$: 観測単位
- $C_k$: モデルが予測するクラス
- $\pmb{x_i}$: $i$についての特徴量ベクトル
- $L_{ik}$: $i$についてクラス$k$と分類した時の損失を表すベクトル, 正しいクラスを予測した時は $0$


### RULE 2: ビジネスKPIと結びつきの強い評価指標を選択する

- AUC, F1スコア, RMSEというモデル指標自体はビジネスKPIではないケースが多い
- ビジネスKPIと相関のあるモデル指標を選ばないと, モデル改善の努力が無駄になるリスクがある


## ビジネスにおける評価指標
### KPI

KPIは健康診断と施策評価という２つの側面で用いられます.

---|---
健康診断指標|組織の目標を達成するための重要な業績評価の指標を意味し, 達成状況を定点観測することで, 目標達成に向けた組織のパフォーマンスの動向を把握するためのもの
施策評価指標|ビジネス施策が正しくビジネスに対してインパクトを与えたかを判断するための指標として現場では用いられる

ビジネスモデルやビジネス課題に応じてどのKPIに着目すべきかは異なります. ECビジネスでトップライン成長率に課題がある場合は, 
新規契約者数や商品ページCVR, MRR(Monthly Recurring Revenue)などがKPIになりますし, ボトムライン改善の場合は配送費や返品率がKPIとなる場合もあります.

> トップラインとボトムライン

---|---
トップライン|損益計算書の一番上（トップ）の項目である売上高（営業収益）のこと
ボトムライン|総収益から, 商品のコスト、税金、負債の利子を含む全ての損失を引いた金額のこと(=当期純利益)

### KPIの４つの必要条件

1. **aligned**: KGIと整合的な指標であること
2. **actionable**: 施策によって改善できる指標でなければ, 単なる状態観察指標になってします
3. **realistic**: 業務フローの中でアクションすることが現実的な指標にすべき
4. **measurable**: 観察できなかったら意味がない



## Confusion matrix

混同行列は、観測単位に対して（予測されるグループ、真のグループ）の組を表す行列のことです.
二値分類問題では、混合行列の表現は４つに分けられます：

- TP: True positive
- TN: True negative
- FP: False positive, 検定の文脈ではType I Errorに対応する
- FN: False Negative, 検定の文脈ではType II errorに対応する

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
from sklearn.metrics import ConfusionMatrixDisplay


y_true = [1, 0, 1, 1, 0, 1]
y_pred = [0, 0, 1, 1, 0, 1]
cm = confusion_matrix(y_true, y_pred)

disp = ConfusionMatrixDisplay(confusion_matrix=cm, display_labels=['0', '1'])
disp.plot()
plt.title('Confusion matrix without normalization');
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220202-01.png?raw=true">

> ３クラス以上の多値クラス問題に拡張する場合

```python
import numpy as np
import matplotlib.pyplot as plt

from sklearn import svm, datasets
from sklearn.model_selection import train_test_split
from sklearn.metrics import ConfusionMatrixDisplay

# import some data to play with
iris = datasets.load_iris()
X = iris.data
y = iris.target
class_names = iris.target_names

# Split the data into a training set and a test set
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=0)

# Run classifier, using a model that is too regularized (C too low) to see
# the impact on the results
classifier = svm.SVC(kernel="linear", C=0.01)
classifier.fit(X_train, y_train)


# Plot non-normalized confusion matrix
np.set_printoptions(precision=2)
titles_options = [
    ("Confusion matrix, without normalization", None),
    ("Normalized confusion matrix", "true"),
]

fig, axs = plt.subplots(1, 2, figsize=(16,9))

for i, options in enumerate(titles_options):
    title, normalize = options
    disp = ConfusionMatrixDisplay.from_estimator(
        classifier,
        X_test,
        y_test,
        display_labels=class_names,
        cmap=plt.cm.Blues,
        normalize=normalize,
        ax = axs[i]
    )
    disp.ax_.set_title(title)

    print(title)
    print(disp.confusion_matrix)
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220202-02.png?raw=true">

## Metrics
### 特異度 (specificity, True Negative Rate, TNR)

$$
\text{TNR} = \frac{\text{TN}}{\text{TN} + \text{FP}}
$$

### False Positive Rate, FPR

$$
\begin{align*}
\texttt{FPR} &= 1 - \frac{\text{TN}}{\text{TN} + \text{FP}}\\
&= \frac{\text{FP}}{\text{TN} + \text{FP}}
\end{align*}
$$

### Accuracy

$$
\text{Accuracy} = \frac{\text{TP} + \text{TN}}{\text{TP} + \text{FP} + \text{TN} + \text{FN}}
$$

または

$$
\texttt{accuracy}(y, \hat{y}) = \frac{1}{n_\text{samples}} \sum_{i=0}^{n_\text{samples}-1} 1(\hat{y}_i = y_i)
$$


- 二値分類問題では`jaccard_score`と同じになります
- 不均衡データ（例: Tが90%など）ではすべてをTと判定するモデルでも90%という高いスコアを出してしまうデメリットがある

```python
import numpy as np
from sklearn.metrics import accuracy_score
y_pred = [0, 2, 1, 3]
y_true = [0, 1, 2, 3]
print(accuracy_score(y_true, y_pred))
print(accuracy_score(y_true, y_pred, normalize=False))
>>> 0.5
>>> 2
```

### Precision-Recall

- Precision: 適合率, 予測結果の誤検知の程度を表す
- Recall: 再現率, 正しいクラスをどれだけ検知することができたかを示す指標, True Positive Rate
- Precision-Recallはトレードオフの関係にある

$$
\texttt{precision} = \frac{TP}{TP+FP}
$$

$$
\texttt{recall} = \frac{TP}{TP+FN}
$$

$$
\begin{align*}
\texttt{False Negative Rate} &= 1 - \frac{TP}{TP+FN}\\
&= \frac{FN}{TP+FN}
\end{align*}
$$

$$
\texttt{average precision} = \sum_n (Recall_n - Recall_{n-1}) Precision_n
$$

APはRerecision-Recall Curveにて各閾値で計算されるPrecisionの加重平均を返す関数. 
APの解釈は難しいがすべてを1と返す予測モデルだとテストデータのtrue labelの割合を返すので、
その値からどれだけ改善されたのかを見るものと理解しています.

> Rerecision-Recall Curve

PrecisionとRecallのトレードオフはRerecision-Recall Curveで確認できます.
Rerecision-Recall Curveは予測結果を確率に応じて降順ソートし、それぞれの閾値ごとの
RerecisionとRecallを計算し、plotしたものです.

```python
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
from scipy.special import logit
from sklearn.model_selection import train_test_split
from sklearn.metrics import PrecisionRecallDisplay

## set parameters
N = 1000
test_size = 0.3
_scale = 1

## Data generation
X = np.random.uniform(-2, 2, N)
X = sm.add_constant(X)

eps = np.random.default_rng().logistic(0,_scale,N)
y_p = X @ np.array([2, 2]) + eps
y = np.where(y_p > 0, 1, 0)

print(np.mean(y))
>>> 0.739
```

```python

## train-test split
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=test_size, random_state=42)

## regression
logit_mod = sm.Logit(y_train, X_train)
logit_res = logit_mod.fit(disp=0)
print(logit_res.summary())
```

```raw
                           Logit Regression Results                           
==============================================================================
Dep. Variable:                      y   No. Observations:                  700
Model:                          Logit   Df Residuals:                      698
Method:                           MLE   Df Model:                            1
Date:                Thu, 14 Apr 2022   Pseudo R-squ.:                  0.4321
Time:                        10:55:17   Log-Likelihood:                -230.16
converged:                       True   LL-Null:                       -405.26
Covariance Type:            nonrobust   LLR p-value:                 3.822e-78
==============================================================================
                 coef    std err          z      P>|z|      [0.025      0.975]
------------------------------------------------------------------------------
const          2.1443      0.187     11.471      0.000       1.778       2.511
x1             2.0663      0.165     12.534      0.000       1.743       2.389
==============================================================================
```

```python
## 正解データと予測確率2Darrayを作成
test_pred_array = np.array([y_test, logit_res.predict(X_test)])

## prediction valueに応じてinverse sort
test_pred_array = test_pred_array[:,np.argsort(test_pred_array[1])[::-1]]

precision = np.cumsum(test_pred_array[0,:])/np.arange(1,len(test_pred_array[0,:])+1)
recall =  np.cumsum(test_pred_array[0,:])/sum(test_pred_array[0,:])
average_precision = np.sum(np.diff(recall) * np.array(precision)[:-1])

## plot
fig, axs = plt.subplots(1, 2, figsize=(18,7))
for ind, title in enumerate(['sklearn-base', 'numpy-based']):
    axs[ind].set_title(title,fontsize=14)

PrecisionRecallDisplay.from_predictions(y_test, logit_res.predict(X_test), ax=axs[0])
axs[1].plot(recall, precision, label='Classifier (AP = {:.2f})'.format(average_precision))
axs[1].set_xlabel('Recall (Positive label:1)')
axs[1].set_ylabel('Precision (Positive label:1)')
axs[1].legend(loc='lower left');
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220202-03.png?raw=true">

### F-measures

F-measures(F1スコアやFβスコア)はprecisionとrecallの調和平均で計算される指標です. どちらもスコアが1のときモデルの汎化性能が良く, 0のときが悪いことを示しています. F1スコアはFβスコアの$\beta=0$のときに相当します.

$$
\begin{align*}
F_\beta&= \frac{(1 + \beta^2)}{\beta^2/\texttt{recall} + 1/\texttt{precision}} \\[8pt]
&= (1 + \beta^2) \frac{\texttt{precision} \times \texttt{recall}}{\beta^2 \texttt{precision} + \texttt{recall}}
\end{align*}
$$


## ROC曲線

ROC(Receiver Operating Characteristic)曲線は, TPRとfalse positive(Type I Error)の関係をグラフにしたものです. 
グラフの面積が大きいほど性能指標が良く, そのエリアの面積の計算はAUCとしてよばれます.

> REMARKS

- 完全な予測を行った場合は、ROC曲線は左上の(0.0, 1.0)の点を通り, AUCは1.0になる
- ランダムな予測を実行した場合は, AUCは0.5程度となる
- AUCは、各レコードの予測値の大小関係のみが値に影響するので, 予測値は確率でなくても構わない(= AUCはscale-invariant)
- class所属確率については何も答えてくれないので、予測値の順序性が満たされる条件の下（noiseがheavy tailではないなども必要だが）, probability calibrationで予測値を補正することによって, class確率を計算するなどの対処が必要になる


```python
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
from scipy.special import logit
from sklearn.model_selection import train_test_split
from sklearn.metrics import PrecisionRecallDisplay
from sklearn import metrics

## set seed
np.random.seed(42)

## set parameters
N = 2000
test_size = 0.3
_scale = 1

## Data generation
X = np.random.uniform(-2, 2, N)
X = sm.add_constant(X)

eps = np.random.default_rng().logistic(0,_scale,N)
y_p = X @ np.array([2, 2]) + eps
y = np.where(y_p > 0, 1, 0)

## train-test split
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=test_size, random_state=42)

## regression
logit_mod = sm.Logit(y_train, X_train)
logit_res = logit_mod.fit(disp=0)


## 正解データと予測確率2Darrayを作成
## prediction valueに応じてinverse sort
test_pred_array = np.array([y_test, logit_res.predict(X_test)])
test_pred_array = test_pred_array[:,np.argsort(test_pred_array[1])[::-1]]

## ランダムに予測した場合
random_pred = np.random.uniform(0, 1, len(y_test))
random_pred = np.where(random_pred < 0.5, 1, 0) ##0.5じゃなくても良い

# Compute ROC curve and ROC area for each class
fpr = dict()
tpr = dict()
auc = dict()

tpr[0] = np.cumsum(test_pred_array[0,:])/np.sum(test_pred_array[0,:])
fpr[0] = np.cumsum(1 - test_pred_array[0,:])/np.sum(1 - test_pred_array[0,:])
auc[0] = np.sum(np.diff(fpr[0]) * tpr[0][:-1])

fpr[1], tpr[1], thresholds = metrics.roc_curve(y_test, logit_res.predict(X_test), pos_label=1)
auc[1] = metrics.auc(fpr[1], tpr[1])

fpr[2], tpr[2], thresholds = metrics.roc_curve(y_test, random_pred, pos_label=1)
auc[2] = metrics.auc(fpr[2], tpr[2])

fpr[3], tpr[3], thresholds = metrics.roc_curve(y_test, y_test, pos_label=1)
auc[3] = metrics.auc(fpr[3], tpr[3])

## plot
fig, axs = plt.subplots(2, 2, figsize=(18,12))
for idx, title in enumerate([
                                'ROC curve: numpy-based', 'ROC curve: sklearn-base',
                                'ROC curve: random-prediction', 'ROC curve: perfect-prediction'
                            ]):
    ax_idx = (idx // 2,idx % 2)
    axs[ax_idx].set_title(title,fontsize=14)
    axs[ax_idx].plot(
            fpr[idx],
            tpr[idx],
            lw=2,
            color="darkorange",
            label="ROC curve (area = %0.2f)" % auc[idx],
            )
    axs[ax_idx].plot([0, 1], [0, 1], color="navy", lw=2, linestyle="--")
    axs[ax_idx].set_xlabel("False Positive Rate")
    axs[ax_idx].set_ylabel("True Positive Rate")
    axs[ax_idx].legend(loc='lower right');
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220202-04.png?raw=true">

### AUCの計算式について

$N$からなる観測対象$i \in \\{1, \cdots, N\\}$について、その所属クラスが$c_i \in \\{C_0, C_1\\}$の日分類問題を考えます. True labelを$1[i \in C_1]$としたとき、そのラベルの予測確率を$y_i$とします.

このとき、AUCは以下の計算式に基づきます:

$$
\begin{align*}
\texttt{AUC} &= \frac{1}{nm}\sum^n_{j=1}\sum^m_{z=1}1(y_j > y_z)\\
&= 1 - \frac{1}{nm}\sum^n_{j=1}\sum^m_{z=1}1(y_j \leq y_z)
\end{align*}
$$

- $(n, m) = (C_1\text{に属する観測数}, C_0\text{に属する観測数})$
- $j$: $C_1$に属する観測対象を表すindex
- $z$: $C_0$に属する観測対象を表すindex
- 実質的にthe Mann-Whitney U-test(Wilcoxon rank sum test)の統計量を計算している

## Appendix
### DSがビジネス問題を解くときに考えるべきこと

- どういうビジネス課題を解くのか？
- モデルでビジネス課題の内, どの部分を解くのか？
- 予測結果にも基づき, どういうビジネス施策を行うのか？（クーポン配布のパーソナライズなど）
- なにをもってモデルの良し悪しをビジネス的に判断するのか？
- 開発段階でのモデルの良し悪しをどのように判断するのか？
- どういうモデルを使うのか？
- どういうアーキテクチャー, 体制でモデルを運用, 改善していくのか？




## Refrences

> 関連ポスト

- [Ryo's Tech Blog > いかにして問題を解くか](https://ryonakagami.github.io/2021/03/09/How-to-Solve-It/#%E9%96%A2%E4%BF%82%E8%80%85%E3%82%92%E8%AA%AC%E5%BE%97%E3%81%99%E3%82%8B-%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%83%89%E3%83%AA%E3%83%96%E3%83%B3)


> 書籍

- [技術評論社, Kaggleで勝つデータ分析の技術, 門脇大輔，阪田隆司，保坂桂佑，平松雄司著](https://gihyo.jp/book/2019/978-4-297-10843-4)
- [森北出版株式会社, はじめてのパターン認識, 平井有三(著)](https://www.morikita.co.jp/books/mid/084971)

> オンラインマテリアル

- [Machine Learning Crash Course > Classification: ROC Curve and AUC](https://developers.google.com/machine-learning/crash-course/classification/roc-and-auc)