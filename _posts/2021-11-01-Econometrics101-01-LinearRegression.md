---
layout: post
title: "Econometrics101 - 復習"
subtitle: "Linear Regression"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Econometrics
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|Econometrics101 - Linear Regression|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Linear Regressionの解釈](#linear-regression%E3%81%AE%E8%A7%A3%E9%87%88)
  - [解釈 1: Linear Conditional Expectations](#%E8%A7%A3%E9%87%88-1-linear-conditional-expectations)
  - [解釈 2: The CEFの"Best"線形近似](#%E8%A7%A3%E9%87%88-2-the-cef%E3%81%AEbest%E7%B7%9A%E5%BD%A2%E8%BF%91%E4%BC%BC)
  - [解釈 3: Causal Model](#%E8%A7%A3%E9%87%88-3-causal-model)
    - [ATT and selection bias](#att-and-selection-bias)
- [Ordinary Least Squares Estimator](#ordinary-least-squares-estimator)
  - [The residualとThe error termの違い](#the-residual%E3%81%A8the-error-term%E3%81%AE%E9%81%95%E3%81%84)
  - [Demeaned Regressors](#demeaned-regressors)
  - [Projection Matrix](#projection-matrix)
  - [Residual Regression: FWL theorem](#residual-regression-fwl-theorem)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Linear Regressionの解釈

$(Y_i, X_i, U_i)$をrandom vectorで、$Y_i, U_i \in \mathbf R$, $X_i \in \mathbf R^{k+1}$とします. $X$の最初の要素は定数1とします、つまり、

$$
X_i = (X_{i0}, \cdots, X_{ik})' \: \text{ with } X_{i0} = 1
$$

このとき、以下の線型回帰問題を考えます.

$$
Y_i = X_i'\beta + U_i
$$

この$\beta$は以下の推定量を解くことで得られます.

$$
\beta = \arg\min_{b} E[(Y_i - X_i'b)] \tag{1}
$$

(1) のFOCをとると

$$
E[X_i(Y_i - X_i'b)] = 0 \Rightarrow \beta = E[X_iX_i']^{-1}E[X_iY_i] \tag{2}
$$

この$\beta$の解釈をまず解説します.

### 解釈 1: Linear Conditional Expectations


The CEFが線形であると仮定します, i.e., 
$E[Y_i|X_i] = X_i'\beta^*$ and $U_i = Y_i - E[Y_i|X_i]$. また、$E[\|Y\|] < \infty$とします

> Theorem 1-1: THE CEF Decomposition Property

$$
Y_i = E[Y_i|X_i] + U_i
$$

このとき、$E[U_i\|X_i] = 0$である. また、$U_i$はいかなる$X_i$の関数とは無相関である.

> Proof

$$
\begin{aligned}
E[U_i|X_i] & = E[Y_i - E[Y_i|X_i]|X_i]\\
& = E[Y_i|X_i] -  E[Y_i|X_i]\\
& = 0
\end{aligned}
$$

またこのことより、

$$
\begin{aligned}
E[U_i] &= \int f_x(t)E[U_i|X_i = t]dt\\
&= 0 \times \int f_x(t) dt\\
&= 0
\end{aligned}
$$

定理の後者の命題については、

$$
\begin{aligned}
E[h(X_i)U_i] &= E[h(X_i)E[U_i|X_i]]\\
&= 0
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

> Theorem 1-3: THE CEF Prediction Property

$m(X_i)$をany function of $X_i$とします. The CEFは以下の最小化問題の解と一致する:

$$
E[Y_i|X_i] = \arg\min_{m(X_i)} E[(Y_i - m(X_i))^2]
$$


> Proof

$$
\begin{aligned}
E[(Y_i - m(X_i))^2] &= E[(Y_i - E[Y_i|X_i] + E[Y_i|X_i] - m(X_i))^2]\\
&= E[(Y_i - E[Y_i|X_i])^2] + E[2(Y_i - E[Y_i|X_i])(E[Y_i|X_i] - m(X_i))] + E[(E[Y_i|X_i] - m(X_i))^2]\\
&= E[(E[Y_i|X_i] - m(X_i))^2]
\end{aligned}
$$

<div style="text-align: right;">
■
</div>


> Theorem 1-3: THE Linear CEF theorem

the CEFがLinearのとき、$$X_i'\beta$$はthe CEFそのものである.

> Proof

$E[Y_i\|X_i] = X_i'\beta^*$と仮定します. このとき、定理1-1より

$$
\begin{aligned}
&E[X_i(Y_i - E[Y_i|X_i])] = 0\\
&\Rightarrow E[X_i(Y_i - X_i'\beta^*)] = E[X_iY_i] - E[X_iX_i']\beta^* = 0
\end{aligned}
$$

よって
$$
\beta^* = E[X_iX_i']^{-1}E[X_iY_i] = \beta
$$

<div style="text-align: right;">
■
</div>

このとき、the CEFが推定できたことを以て、$$\beta_k$$を$X_{ik}$が$$Y_i$$に与える因果の意味での効果(the centeris paribus)と解釈したくなりますが、これは間違いです. あくまで$$\beta$$は $$(Y_i, X_i)$$ の同時分布の情報を集約した数値であり、必ずしもそれは因果の関係性を意味するわけではありません. 例えば、$$Y_i$$を個人の年間収入、$$X_i$$を年間所得税納付金額としたとき、$E[Y_i\|X_i]$が上昇すればするほど、$$X_i$$は上がると考えられますが、その逆はthe centeris paribusの意味において考えることは一般的には難しいです. 


### 解釈 2: The CEFの"Best"線形近似

> Theorem 2-1: The BEST MMSE linear approximation

The function $$X_i'\beta$$はthe CEFのthe MMSE linear approximationである, i.e.,

$$
\beta = \arg\min_{b} E\{(E[Y_i|X_i] - X_i'b)^2\}
$$

> Proof

$$
\begin{aligned}
E\{(E[Y_i|X_i] - X_i'b)^2\} &= E\{(Y - E[Y_i|X_i])^2 + 2(Y - E[Y_i|X_i])(Y - X_i'b) +(Y - X_i'b)^2 \} \\
&= E[U_i^2] + 2E[U_iY_i] + E[(Y - X_i'b)^2]\\
&= \text{ constant } + E[(Y - X_i'b)^2]
\end{aligned}
$$

従って、

$$
\arg\min_{b} E\{(E[Y_i|X_i] - X_i'b)^2\} = \arg\min_{b} E[(Y - X_i'b)^2]
$$

<div style="text-align: right;">
■
</div>

なお$\beta$がThe BEST MMSE linear approximationであることは以下の式からもわかります

$$
\beta = E[X_iX_i']^{-1}E[X_iY_i] = E[X_iX_i']^{-1}E[X_iE(Y_i|X_i)]
$$

> Approxiamtionはsupportに依存する

$\text{Supp}(X)$をrandom vector $X$のサポートと定義します. このとき

$$
E\{(E[Y_i|X_i] - X_i'b)^2\} = \int_{x\in \text{Supp}(X)} (E[Y|X = x] - x'b)^2f_X(x)dx
$$

よって、

- the approximationは$X$の分布に依存する
- finite sampleにおいて、$X$のdataが観測されないエリアではthe approximationのweightはゼロになる
- $\text{Supp}(X)$が非常に狭い範囲の場合、finite sampleにおいて the approximationは非常に不安定になる


### 解釈 3: Causal Model

$(Y_i, D_i)$のrandom vectorからなるデータを考えます. $Y_i$はthe outcome, $D_i$はtreatment statusを示すbinary変数とします. このとき、$D_i$と$Y_i$のthe causal relationshipはthe potential outcomeを用いて記述することができます;

$$
Y = \begin{cases}
Y_{1i} &\text{ if } D_i = 1\\
Y_{0i} &\text{ if } D_i = 0
\end{cases}
$$

このときのthe treatment effectは

$$
\theta_i \equiv Y_{1i} - Y_{0i} 
$$

と記述することができます. この設定の下、$(Y_i, D_i)$の単回帰モデルを考えてみます.

$$
Y_i = \alpha + \beta D_i + \eta_i
$$

このとき、

- $\alpha = E[Y_{0i}]$
- $\beta  = E[\theta_i]$
- $\eta_i = Y_{0i} - E[Y_{0i}]$

と対応付けて解釈することができます. The treatment statusごとにそれぞれのthe CEFを評価すると

$$
\begin{aligned}
E[Y_i|D_i=1]&=\alpha + \beta + E[\eta_i|D_i = 1]\\
E[Y_i|D_i=0]&=\alpha + E[\eta_i|D_i = 0]
\end{aligned}
$$

よって、

$$
E[Y_i|D_i = 1] - E[Y_i|D_i = 1] = \beta + E[\eta_i|D_i = 1] - E[\eta_i|D_i = 0] \tag{3}
$$

とATE + selection biasの関係性が見えてきます. 仮に $E[\eta_i \perp D_i]$が成立している場合、(3)のselection biasの項が消えるので、単回帰モデルでATEが推定できることがわかります.

#### ATT and selection bias

- $y$: the outcome variable
- $\mathbf x$: a set of explanatrory variables
- $s$: a treatment status indicator
- $\mu_0(\mathbf x) = E[y\|\mathbf x, s= 0]$
- $\mu_1(\mathbf x) = E[y\|\mathbf x, s= 1]$

このとき、treatment statusに応じたグループ間の差分はATT + selection biasで表現できます.

$$
\begin{aligned}
E[y|s=1] - E[y|s=0] &= E[E[y|\mathbf x, s = 1]|s=1] - E[E[y|\mathbf x, s = 0]|s=0]\\
&= E[\mu_1(\mathbf x)|s=1] - E[\mu_0(\mathbf x)|s=0]\\
&= \underbrace{\left(E[\mu_1(\mathbf x)|s=1] - E[\mu_0(\mathbf x)|s=1] \right)}_{\text{ATT}} + \underbrace{\left(E[\mu_0(\mathbf x)|s=1] - E[\mu_0(\mathbf x)|s=0]\right)}_{\text{selection bias}}
\end{aligned}
$$

次に、$\mu_s(\mathbf x) = \mathbf x\beta_s$とします.

$$
E[y|s=1] - E[y|s=0] = E[\mathbf x|s=1](\beta_1 - \beta_0) + \left(E[\mathbf x|s=1]-E[\mathbf x|s=0]\right)\beta_0
$$


## Ordinary Least Squares Estimator

The CEFが$E[Y_i\|X_i] = X_i'\beta$だと仮定します. このときの$\beta$を推定するためには

$$
\beta = \arg\min_b E[(Y_i - X_i'b)^2] \tag{4}
$$

を解けばよいこととなります. しかし、the joint distribution $(Y_i, X_i)$は事前には知られていないので、我々はこのthe sample analogで$\beta$を推定します.

$$
\hat\beta = \arg\min_b \frac{1}{N}\sum_{i=1}^N(Y_i - X_i'b)^2 \tag{5}
$$

$\mathbf Y = (Y_1, \cdots, Y_N)', \mathbf X = (X_1, \cdots, X_N)'$とすると、(5)は次のような最小化問題に書き換えられます

$$
(\mathbf Y - \mathbf X b)'(\mathbf Y - \mathbf X b) \tag{6}
$$

(6)について、$b$のFOCをとると

$$
-\mathbf X'(\mathbf Y - \mathbf X \hat\beta) = 0 \tag{7}
$$

$\mathbf X$がfull rankであるならば$\mathbf X'\mathbf X$の逆行列がとれるので

$$
\hat\beta = (\mathbf X'\mathbf X)^{-1}\mathbf X\mathbf Y\tag{7}
$$

残差を $e_i \equiv Y - X_i' \hat\beta$と定義したとき、(7)より

$$
\sum_{i=1}^N X_i e_i = \mathbf X'\mathbf e = 0 \tag{8}
$$

(8)が意味することは

- $\mathbf X, \mathbf e$は直交
- $\mathbf X, \mathbf e$は無相関

### The residualとThe error termの違い

上記(8)の内容を深堀したいと思います. 

$$
\begin{aligned}
y_i = 1 + x_{1i} + x_{2i} + \epsilon_i
\end{aligned}
$$

- $x_{1i}, x_{2i}, \epsilon_i$  are mutually independent standard normal random variables

という回帰モデルを考えます. Finite sampleのもとでは、OLS residualはregressorsと直交していますが、the true error termは必ずしも直交していません. Pythonコードで見ていきたいと思います.

```python
import numpy as np
import pandas as pd
import seaborn as sns

## set seed
np.random.seed(42)

## Data Generation
const = np.array([1]*1000, ndmin=2).T
data = np.random.normal(size = (1000, 3))
data = np.concatenate([const, data], axis = 1)
coefficient_matrix = np.array([1, 1, 1, 1], ndmin=2).T

y = data @ coefficient_matrix

## OLS
X = data[:,:-1]
beta_ols = np.linalg.inv(X.T @ X) @ X.T @ y
residual = y - X @ beta_ols

## regressor and residual
observed_data = np.concatenate([data, residual], axis = 1)

## Covariance matrix
sns.heatmap(np.cov(observed_data, rowvar=False), annot=True, fmt='g');
sns.heatmap(np.cov(data, rowvar=False), annot=True, fmt='g');
```

> The true error term and regressors covariance matrix

<img src='https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/output.png?raw=true'>

> The true error term and regressors covariance matrix

<img src='https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/output1.png?raw=true'>

### Demeaned Regressors

$$
Y_i = \alpha + X_i'\beta + \epsilon_i 
$$

というモデルをOLSで推定したいときの結果を以下のように表すとします:

$$
Y_i = \hat\alpha + X_i'\hat\beta + e_i \tag{9}
$$

残差とFOCの性質より、

$$
\begin{align*}
\sum_{i=1}^N e_i &= 0\tag{10}\\
\sum X_i(Y_i- \hat\alpha + X_i'\hat\beta)&=0\tag{11}
\end{align*}
$$

(10)の式より

$$
\hat\alpha = \bar Y - \bar X'\hat\beta \tag{12}
$$

(12)を(11)の式に代入すると

$$
\sum X_i(Y_i- \bar Y + (X_i' - \bar X)\hat\beta)=0 \tag{13}
$$

これを$\hat\beta$について解くと

$$
\begin{align*}
\hat\beta &= \left(\sum_{i=1}X_i\left(X_i - \bar X\right)'\right)^{-1}\left(\sum_{i=1}X_i\left(Y_i - \bar Y\right)\right)\\
&= \left(\sum_{i=1}\left(X_i - \bar X\right)\left(X_i - \bar X\right)'\right)^{-1}\left(\sum_{i=1}\left(X_i - \bar X\right)\left(Y_i - \bar Y\right)\right) \tag{14}
\end{align*}
$$

> REMARKS

- OLS regressionで得られる推定量はdemeaned dataについてinterceptなしでOLS regressionを実行した場合に得られる推定量と一致します
- (14)のことをthe demeaned formula for the least squares estimatorといいます
- sample analogではstandard errorの数値が自由度の関係から微妙に異なってしまう

> Finite sampleにおけるstandard errorの比較: OLS estimator vs demeaned OLS estimator

```python
import statsmodels.api as sm
import numpy as np

## READ DATA
duncan_prestige = sm.datasets.get_rdataset("Duncan", "carData")

## preprocessing
#----- model 1
Y = duncan_prestige.data['income']
X = duncan_prestige.data['education']

X_naive = sm.add_constant(X)

#------ demeaned data
Y_demeaned = Y - Y.mean()
X_demeaned = X - X.mean()

## Fitting
model = sm.OLS(Y,X_naive)
model_demeaned = sm.OLS(Y_demeaned,X_demeaned)
results, results_demeaned = model.fit(), model_demeaned.fit()

print(results.summary())
print(results_demeaned.summary())
```

Then, The resutls are

```raw
                            OLS Regression Results                            
==============================================================================
Dep. Variable:                 income   R-squared:                       0.525
Model:                            OLS   Adj. R-squared:                  0.514
Method:                 Least Squares   F-statistic:                     47.51
Date:                Mon, 08 Nov 2021   Prob (F-statistic):           1.84e-08
Time:                        01:43:38   Log-Likelihood:                -190.42
No. Observations:                  45   AIC:                             384.8
Df Residuals:                      43   BIC:                             388.5
Df Model:                           1                                         
Covariance Type:            nonrobust                                         
==============================================================================
                 coef    std err          t      P>|t|      [0.025      0.975]
------------------------------------------------------------------------------
const         10.6035      5.198      2.040      0.048       0.120      21.087
education      0.5949      0.086      6.893      0.000       0.421       0.769
==============================================================================
Omnibus:                        9.841   Durbin-Watson:                   1.736
Prob(Omnibus):                  0.007   Jarque-Bera (JB):               10.609
Skew:                           0.776   Prob(JB):                      0.00497
Kurtosis:                       4.802   Cond. No.                         123.
==============================================================================

Notes:
[1] Standard Errors assume that the covariance matrix of the errors is correctly specified.

                              Demeaned OLS Regression Results                                
=======================================================================================
Dep. Variable:                 income   R-squared (uncentered):                   0.525
Model:                            OLS   Adj. R-squared (uncentered):              0.514
Method:                 Least Squares   F-statistic:                              48.62
Date:                Mon, 08 Nov 2021   Prob (F-statistic):                    1.25e-08
Time:                        01:43:17   Log-Likelihood:                         -190.42
No. Observations:                  45   AIC:                                      382.8
Df Residuals:                      44   BIC:                                      384.6
Df Model:                           1                                                  
Covariance Type:            nonrobust                                                  
==============================================================================
                 coef    std err          t      P>|t|      [0.025      0.975]
------------------------------------------------------------------------------
education      0.5949      0.085      6.972      0.000       0.423       0.767
==============================================================================
Omnibus:                        9.841   Durbin-Watson:                   1.736
Prob(Omnibus):                  0.007   Jarque-Bera (JB):               10.609
Skew:                           0.776   Prob(JB):                      0.00497
Kurtosis:                       4.802   Cond. No.                         1.00
==============================================================================

Notes:
[1] R² is computed without centering (uncentered) since the model does not contain a constant.
[2] Standard Errors assume that the covariance matrix of the errors is correctly specified.
```

### Projection Matrix

次に線形代数の射影の観点からOLS estimatorの性質を考えます. $\mathbf Y = \mathbf X \beta + \epsilon$というモデルを考えます.

このとき、$\mathbf X$で張られるfieldへの射影を実行する射影行列(projection matrix) $\mathbf P$を以下のように定義します:

$$
\mathbf P \equiv \mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X' \tag{15}
$$

また残差行列 $M$を次のように定義します

$$
M \equiv (I - P) \tag{16}
$$


**射影行列の性質**

>(1) $\mathbf X$を$\mathbf P$で射影すると自分自身になる

$$
\mathbf P \mathbf X = \mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X' \mathbf X = \mathbf X
$$

<div style="text-align: right;">
■
</div>

>(2) $\mathbf X = [X_1, X_2]$としたときをsubvector $X_1$を$\mathbf P$で射影すると自分自身になる

射影行列$P$について

$$
\begin{align*}
P & = \mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\\
&= [X_1 X_2]\left(\left[\begin{array}{c}X_1'\\X_2'\end{array}\right][X_1, X_2]\right)^{-1}\left[\begin{array}{c}X_1'\\X_2'\end{array}\right]\\
&=[X_1 X_2]\left(\begin{array}{cc}X_1'X_1 & X_1'X_2\\X_2'X_1 & X_2'X_2\end{array}\right)^{-1}\left[\begin{array}{c}X_1'\\X_2'\end{array}\right]  \tag{17}
\end{align*}
$$

表記の簡略化のため

$$
\begin{align*}
\left(\begin{array}{cc}X_1'X_1 & X_1'X_2\\X_2'X_1 & X_2'X_2\end{array}\right)^{-1}&\equiv \left(\begin{array}{cc}Q_{11} & Q_{12}\\Q_{21} & Q_{22}\end{array}\right)^{-1}\\
&= \left(\begin{array}{cc}Q_{11\cdot 2}^{-1} & -Q_{11\cdot 2}^{-1}Q_{12}Q_{21}^{-1}\\-Q_{22\cdot 1}^{-1}Q_{21}Q_{11}^{-1} & Q_{22\cdot 1}^{-1}\end{array}\right)\tag{18}
\end{align*}
$$

このとき

$$
\begin{align*}
Q_{11\cdot 2} &= Q_{11} - Q_{12}Q_{22}^{-1}Q_{21} = X_1'M_2X_1\\ 
Q_{22\cdot 1} &= Q_{22} - Q_{21}Q_{11}^{-1}Q_{12} = X_2'M_1X_2
\end{align*}
$$

よって,

$$
\begin{align*}
\left(\begin{array}{cc}X_1'X_1 & X_1'X_2\\X_2'X_1 & X_2'X_2\end{array}\right)^{-1}\left[\begin{array}{c}X_1'\\X_2'\end{array}\right]X_1
&=\left(\begin{array}{cc}(X_1'M_2X_1)^{-1} & -(X_1'M_2X_1)^{-1}X_1'X_2(X_2'X_2)^{-1}\\
-(X_2'M_1X_2)^{-1}X_2'X_1(X_1'X_1)^{-1} & (X_2'M_1X_2)^{-1}\end{array}\right)\left[\begin{array}{c}X_1'X_1 \\X_2'X_1\end{array}\right]\\
&= \left(\begin{array}{c}(X_1'M_2X_1)^{-1}(X_1'M_2X_1)\\ (X_1'M_2X_1)^{-1}X_2'X_1 - (X_1'M_2X_1)^{-1}(X_2'P_1X_1) \end{array}\right)\\
&= \left(\begin{array}{c}1\\ 0 \end{array}\right)\tag{19}
\end{align*}
$$

(19)の結果を用いると

$$
\begin{aligned}
PX_1 &= [X_1 X_2] \left(\begin{array}{cc}X_1'X_1 & X_1'X_2\\X_2'X_1 & X_2'X_2\end{array}\right)^{-1}\left[\begin{array}{c}X_1'\\X_2'\end{array}\right]X_1\\
&= [X_1 X_2]\left(\begin{array}{c}1\\ 0 \end{array}\right)\\
&= X_1
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

### Residual Regression: FWL theorem

$$
Y = X_1\hat\beta_1 + \cdots + X_K\hat\beta_K + \hat e \tag{20}
$$

というOLS estimatorを考えます. ここで$X_1$を$(X_2, \cdots X_K)$に回帰します.

$$
\begin{align*}
X_1 &= X_2\hat\alpha_2 + \cdots + X_K\hat\alpha_K + \hat V
&= \hat X_1 + \hat V \tag{21}
\end{align*}
$$

(20)の両辺に $\hat V'$を左から掛けます:

$$
\begin{align*}
\hat V'Y &= \hat V'(X_1\hat\beta_1 + \cdots + X_K\hat\beta_K + \hat e)\\
&= \hat V'X_1\hat\beta_1\\
&= \hat V'(\hat X_1 + \hat V)\hat\beta_1\\
&= \hat V'\hat V\beta_1 \tag{22}
\end{align*}
$$

よって $\hat V'\hat V$の逆行列が存在する時

$$
(\hat V'\hat V)^{-1}\hat V'Y = \hat\beta_1 \tag{23}
$$

このような残差回帰で$\hat\beta$のsubvectorを推定できる性質のことをFWL定理といいます. なお、射影行列を用いると$\hat V$は以下のように表現できます

$$
\hat V = (I - P_{2K})X_1 = M_{2k}X_1 \tag{24}
$$

(23)に(24)を代入すると

$$
\begin{align*}
(\hat V'\hat V)^{-1}\hat V'Y  &= (X_1'M_{2k}X_1)^{-1}X_1'M_{2k}Y\\
&= (X_1'M_{2k}'M_2{2k}X_1)^{-1}X_1'M_{2k}'M_{2k}Y\tag{25}
\end{align*}
$$

(25)から$Y$を$(X_2, \cdots, X_K)$に回帰した残差を$X_1$を$(X_2, \cdots, X_K)$に回帰した残差すると$\hat\beta_1$が得られることがわかります. また、(25)の結果得られる残差と$\hat e$も一致します.

> 証明

$$
\begin{aligned}
(X_1'M_{2k}'M_2{2k}X_1)^{-1}X_1'M_{2k}'M_{2k}Y &= \hat\beta_1 + (X_1'M_{2k}'M_2{2k}X_1)^{-1}X_1'M_{2k}'M_{2k}\hat e_i\\
&= \hat\beta_1 + \hat e_i
\end{aligned}
$$

<div style="text-align: right;">
■
</div>

> Coded example

$$
\begin{aligned}
y_i &= \beta x_i + z_i'\gamma + u_i \: \text{ where } i = 1, \cdots 10000 \\
(x_i, z_i) &\sim N\left(\left[\begin{array}{c}0\\0\\0 \end{array}\right], \left[\begin{array}{cccc}1 & -1 & 2 & 0 \\-1 & 4 & -1 & 1\\2& -1 & 6 &-2 \\ 0 & 1 & -2 & 4 \end{array}\right]\right)\\
u_i &\sim N(0, 1)\\

\end{aligned}
$$

というregression modelを考えます. このとき, $\beta$をフルモデルのOLS, 残差回帰それぞれで以下推定します.

```python
mport statsmodels.api as sm
import numpy as np

## set seed
np.random.seed(42)

## parameter
N = 10000
mean = [0, 0, 0, 0]
cov = [[1, -1, 2, 0], [-1, 4, -1, 1], [2, -1, 6, -2], [0, 1, -2, 4]]
beta = 1
gamma = np.array([[2, 3, 4]]).T

## data generation
data = np.random.multivariate_normal(mean, cov, N)
x, z = np.hsplit(data,[1,])
u = np.random.normal(0, 1, N).reshape(N, 1)
y = x * beta + z @ gamma + u

## residuals: regress (y, x) on z and get each of the residuals
x_resid = x - z @ np.linalg.inv(z.T @ z) @ z.T @ x
y_resid = y - z @ np.linalg.inv(z.T @ z) @ z.T @ y

## estimation
reg_ols = sm.OLS(y,data)
results = reg_ols.fit()

reg_resid_1 = sm.OLS(y,x_resid)
results_resid_1 = reg_resid_1.fit()

reg_resid_2 = sm.OLS(y_resid,x_resid)
results_resid_2 = reg_resid_2.fit()
```

Then,

```raw
                                 OLS Regression Results                                
=======================================================================================
Dep. Variable:                      y   R-squared (uncentered):                   0.990
Model:                            OLS   Adj. R-squared (uncentered):              0.990
Method:                 Least Squares   F-statistic:                          2.466e+05
Date:                Tue, 09 Nov 2021   Prob (F-statistic):                        0.00
Time:                        03:49:15   Log-Likelihood:                         -14191.
No. Observations:               10000   AIC:                                  2.839e+04
Df Residuals:                    9996   BIC:                                  2.842e+04
Df Model:                           4                                                  
Covariance Type:            nonrobust                                                  
==============================================================================
                 coef    std err          t      P>|t|      [0.025      0.975]
------------------------------------------------------------------------------
x1             0.9261      0.061     15.187      0.000       0.807       1.046
x2             1.9852      0.014    139.290      0.000       1.957       2.013
x3             3.0339      0.023    129.403      0.000       2.988       3.080
x4             4.0271      0.016    253.591      0.000       3.996       4.058
==============================================================================
Omnibus:                        3.630   Durbin-Watson:                   1.985
Prob(Omnibus):                  0.163   Jarque-Bera (JB):                3.654
Skew:                          -0.046   Prob(JB):                        0.161
Kurtosis:                       2.980   Cond. No.                         19.7
==============================================================================

Notes:
[1] R² is computed without centering (uncentered) since the model does not contain a constant.
[2] Standard Errors assume that the covariance matrix of the errors is correctly specified.

                                 Residual Regression Part 1 Results                                
=======================================================================================
Dep. Variable:                      y   R-squared (uncentered):                   0.000
Model:                            OLS   Adj. R-squared (uncentered):              0.000
Method:                 Least Squares   F-statistic:                              2.315
Date:                Tue, 09 Nov 2021   Prob (F-statistic):                       0.128
Time:                        03:49:21   Log-Likelihood:                         -37200.
No. Observations:               10000   AIC:                                  7.440e+04
Df Residuals:                    9999   BIC:                                  7.441e+04
Df Model:                           1                                                  
Covariance Type:            nonrobust                                                  
==============================================================================
                 coef    std err          t      P>|t|      [0.025      0.975]
------------------------------------------------------------------------------
x1             0.9261      0.609      1.521      0.128      -0.267       2.119
==============================================================================
Omnibus:                        1.557   Durbin-Watson:                   1.999
Prob(Omnibus):                  0.459   Jarque-Bera (JB):                1.588
Skew:                          -0.026   Prob(JB):                        0.452
Kurtosis:                       2.967   Cond. No.                         1.00
==============================================================================


                              Residual Regression Part 2 Results                                
=======================================================================================
Dep. Variable:                      y   R-squared (uncentered):                   0.023
Model:                            OLS   Adj. R-squared (uncentered):              0.022
Method:                 Least Squares   F-statistic:                              230.7
Date:                Tue, 09 Nov 2021   Prob (F-statistic):                    1.57e-51
Time:                        03:49:29   Log-Likelihood:                         -14191.
No. Observations:               10000   AIC:                                  2.838e+04
Df Residuals:                    9999   BIC:                                  2.839e+04
Df Model:                           1                                                  
Covariance Type:            nonrobust                                                  
==============================================================================
                 coef    std err          t      P>|t|      [0.025      0.975]
------------------------------------------------------------------------------
x1             0.9261      0.061     15.189      0.000       0.807       1.046
==============================================================================
Omnibus:                        3.630   Durbin-Watson:                   1.985
Prob(Omnibus):                  0.163   Jarque-Bera (JB):                3.654
Skew:                          -0.046   Prob(JB):                        0.161
Kurtosis:                       2.980   Cond. No.                         1.00
==============================================================================

```