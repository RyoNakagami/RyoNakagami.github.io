---
layout: post
title: "Ridge/Lasso推定量の性質"
subtitle: "LassoとRidgeの性能比較"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-04-11
tags:

- 統計
- Python
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回のスコープ](#%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [Shrinkage Methodのモチベーション](#shrinkage-method%E3%81%AE%E3%83%A2%E3%83%81%E3%83%99%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)
- [Ridge Regression](#ridge-regression)
  - [Ridge推定量の導出](#ridge%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%AE%E5%B0%8E%E5%87%BA)
    - [Ridge推定量がBiasedであることの証明](#ridge%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%8Cbiased%E3%81%A7%E3%81%82%E3%82%8B%E3%81%93%E3%81%A8%E3%81%AE%E8%A8%BC%E6%98%8E)
  - [Ridge推定量の性質](#ridge%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%AE%E6%80%A7%E8%B3%AA)
    - [ペナルティー水準に応じた推定値の変化の確認](#%E3%83%9A%E3%83%8A%E3%83%AB%E3%83%86%E3%82%A3%E3%83%BC%E6%B0%B4%E6%BA%96%E3%81%AB%E5%BF%9C%E3%81%98%E3%81%9F%E6%8E%A8%E5%AE%9A%E5%80%A4%E3%81%AE%E5%A4%89%E5%8C%96%E3%81%AE%E7%A2%BA%E8%AA%8D)
    - [ペナルティー水準に応じたBias-Variance Decomposition](#%E3%83%9A%E3%83%8A%E3%83%AB%E3%83%86%E3%82%A3%E3%83%BC%E6%B0%B4%E6%BA%96%E3%81%AB%E5%BF%9C%E3%81%98%E3%81%9Fbias-variance-decomposition)
- [Lasso Regression](#lasso-regression)
  - [Lasso推定量の導出](#lasso%E6%8E%A8%E5%AE%9A%E9%87%8F%E3%81%AE%E5%B0%8E%E5%87%BA)
    - [CASE (1): $X^TX = nI$と直交するケース](#case-1-x%5Etx--ni%E3%81%A8%E7%9B%B4%E4%BA%A4%E3%81%99%E3%82%8B%E3%82%B1%E3%83%BC%E3%82%B9)
    - [CASE (2): 直交仮定を外した一般のケース](#case-2-%E7%9B%B4%E4%BA%A4%E4%BB%AE%E5%AE%9A%E3%82%92%E5%A4%96%E3%81%97%E3%81%9F%E4%B8%80%E8%88%AC%E3%81%AE%E3%82%B1%E3%83%BC%E3%82%B9)
      - [凸二次計画法に基づいた計算方法](#%E5%87%B8%E4%BA%8C%E6%AC%A1%E8%A8%88%E7%94%BB%E6%B3%95%E3%81%AB%E5%9F%BA%E3%81%A5%E3%81%84%E3%81%9F%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
        - [ペナルティー水準に応じたBias-Variance Decompositionの確認 - statsmodels-based](#%E3%83%9A%E3%83%8A%E3%83%AB%E3%83%86%E3%82%A3%E3%83%BC%E6%B0%B4%E6%BA%96%E3%81%AB%E5%BF%9C%E3%81%98%E3%81%9Fbias-variance-decomposition%E3%81%AE%E7%A2%BA%E8%AA%8D---statsmodels-based)
      - [Cordinate Descent Methodによる計算方法](#cordinate-descent-method%E3%81%AB%E3%82%88%E3%82%8B%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
        - [Cordinate Descent Algorithmの概要](#cordinate-descent-algorithm%E3%81%AE%E6%A6%82%E8%A6%81)
        - [Pythonでの実装: Coordinate descent update rule](#python%E3%81%A7%E3%81%AE%E5%AE%9F%E8%A3%85-coordinate-descent-update-rule)
- [Appendix](#appendix)
  - [Bias-Variance Trade-off](#bias-variance-trade-off)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 今回のスコープ

- LassoとRidgeの統計的特性を確認する
- LassoとRidgeを比較し、それぞれのpros-consを確認する

なお、Ridge推定量とPCAの関係性は別の機会に取り扱います.


### Shrinkage Methodのモチベーション

Ridge/Lasso Regressionは予測問題の文脈では、out-of-sampleの予測精度の分散を抑えるためにLoss functionにcoefficientsのnormにペナルティーを課して推定するという正則化(regularization)というテクニックで知られています. ペナルティーの課し方はRidge/Lassoで前者はL2ノルム、後者はL1ノルムと異なりますが、どちらもペナルティーの効果として(1) 過学習を抑制する (2) 係数を0にshrinkさせるという効果をもっています.

## Ridge Regression

$(y_i, X_{i})_{i=1}^N$, $X_i = (x_1, \cdots, x_p)$というデータが与えられたとき、OLSで分析するとします. このとき考える損失関数は以下の形となります;

$$
RSS = \sum^{n}_{i=1}\left(y_i - \beta_0 - \sum^p_{j=1}\beta_jx_{ij}\right)^2 \quad\quad\tag{1}
$$

一方、Ridge Regressionにおける損失関数の形状は(1)に正則化ペナルティーを加えた以下の形となります;

$$
\sum^{n}_{i=1}\left(y_i - \beta_0 - \sum^p_{j=1}\beta_jx_{ij}\right)^2 + \lambda\sum^p_{j=1}\beta_j^2 \quad\quad\tag{2} 
$$

- $\lambda\geq 0$: チューニングパラメーター. 水準の選び方の一例としてcross-validation(後述)
- $\lambda\sum^p_{j=1}\beta_j^2$: shrinkage penalty
- Intercept, $\beta_0$はshrinkageの対象外とするのが一般的
- 正則化項$\sum^p_{j=1}\beta_j^2$より、単位の影響を受けるのが自明(=scale equivariant)なので、一般的には正規化の処理をしてから回帰する

### Ridge推定量の導出

(2)に基づいてRidge推定量を導出します. まず、FWL定理の観点化から$\{y_i, X_{i}\}_{i=1}^N$についてdemeaningを実施します

$$
\begin{align*}
\tilde y_i &= y_i - \bar y\\
\tilde X_i &= X_i - \bar X
\end{align*}
$$

demeaning処理を施した変数を利用して(2)を以下のように変形します:

$$
\mathbf\beta_{ridge} =\arg\min (\tilde Y-\tilde X\mathbf \beta)^T(\tilde Y-\tilde X\mathbf \beta) + \lambda \|\mathbf \beta\|^2\tag{3}
$$

(3)を$\mathbf\beta$についてFOCをとると

$$
\mathbf\beta_{ridge} = (\tilde X^T\tilde X + \lambda I_p)^{-1}\tilde X^T\tilde Y \quad\quad\tag{4}
$$

#### Ridge推定量がBiasedであることの証明

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbf\beta_{ridge} &= (\tilde X^T\tilde X + \lambda I_p)^{-1}\tilde X^T\tilde Y\\
&= (\tilde X^T\tilde X + \lambda I_p)^{-1}\tilde X^T\tilde X(\tilde X^T\tilde X)^{-1}\tilde X^T\tilde Y\\
&= [\tilde X^T\tilde X(I_p + \lambda (\tilde X^T\tilde X)^{-1})]^{-1}\tilde X^T\tilde X\mathbf\beta_{ols}\\
&= [I_p + \lambda (\tilde X^T\tilde X)^{-1}]^{-1}\mathbf\beta_{ols}
\end{align*}
$$
</div>

従って、両辺の期待値を取ると

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\mathbf E[\mathbf\beta_{ridge}] &= \mathbf E[(I_p + \lambda (\tilde X^T\tilde X)^{-1})^{-1}\mathbf\beta_{ols}]\\
&= (I_p + \lambda (\tilde X^T\tilde X)^{-1})^{-1}\mathbf E[\mathbf\beta_{ols}]\\
&\neq \mathbf\beta
\end{align*}
$$
</div>


### Ridge推定量の性質

> Ridge推定量は安定した推定はできるが変数選択ができない

- $\lambda$が大きくなるほど、Biasは大きくなる
- $\lambda$が大きくなるほど、Varianceは小さくなる
- Bias-Variance Trade-offは[こちら](#bias-variance-trade-off)参照
- すべての係数を0へshrinkageさせるので、variable selectionの観点では重要ではない変数のみ0へ相対的にshrinkさせることはできていない（Lassoに負ける点）

the linear expectation functionが成立する際OLSがBLUEであることを念頭に(4)をみてみると$\lambda$の存在により、unbiasednessは失われていますが、以下のように式展開するとvarianceは安定的であることが確認できます.

Error termのHomoscedasticityが成立するときのRidge推定量の分散とOLS推定量の分散を比較します.

<div class="math display" style="overflow: auto">
$$
\begin{align*}
V(\mathbf\beta_{ridge}) &= \sigma^2(\tilde X^T\tilde X + \lambda I_p)^{-1}\tilde X^T\tilde X(\tilde X^T\tilde X + \lambda I_p)^{-1}\\
&\leq \sigma^2(\tilde X^T\tilde X)^{-1} = V(\mathbf\beta_{ols}) 
\end{align*}
$$
</div>

OLS推定量の分散が大きくなる一例として、多重線形性の問題がDatasetに存在するケースがあります. (4)をみると、pernaltyの単位行列を加えていることから、
逆行列の特異性を軽減し、多重線形性の問題を回避しているという解釈もできます. Ridge推定量がvarianceを低減させることよるメリットの一例と解釈することができます.


#### ペナルティー水準に応じた推定値の変化の確認

> 確認したいこと

- ペナルティー$\lambda$の水準に応じて、coefficientsはどのように変化するのか？
- shrinkage toward zeroの挙動をplotで確認する

> Data

- [An Introduction to Statistical Learning > Credit Data](https://www.statlearning.com/s/Credit.csv)

> Regression Model

$$
\text{Balance}_i = \beta_1\text{income}_i + \beta_2\text{Limit}_i + \beta_3\text{Rating}_i + \beta_4\text{Student}_i + e_i
$$

- 回帰式に用いる変数(ダミー変数は除く)は前処理の段階で標準化されているものとする


<iframe src="https://nbviewer.org/github/RyoNakagami/Blog_Supplementary_Materials/blob/main/statistics/RidgeEstimator_01.ipynb" width="100%" height="4000" frameborder="0"></iframe>

#### ペナルティー水準に応じたBias-Variance Decomposition

> 確認したいこと

- ペナルティー$\lambda$の水準に応じて、Testデータを対象にした予測値のMSE, Bias, varianceを計算する

> Bias-variance decompositionの計算方法

- データセットをtrain, testへ分割した後、ブートストラップで推定値の計算 & Testデータセットについての予測を実施
- ブートストラップで計算された値を用いてバッチごとにSquared Error, model biasを計算してその平均を報告
- モデルのvarianceは観測単位ごとに推定値がどれだけブレるのかをsquared errorで計算し、その合計をバッチサイズで除したものを報告

<iframe src="https://nbviewer.org/github/RyoNakagami/Blog_Supplementary_Materials/blob/main/statistics/RidgeEstimator_02.ipynb" width="100%" height="3100" frameborder="0"></iframe>

## Lasso Regression

Lasso Regressionにおける損失関数の形状は(1)にL1ノルム正則化ペナルティーを加えた以下の形となります;

$$
\sum^{n}_{i=1}\left(y_i - \beta_0 - \sum^p_{j=1}\beta_jx_{ij}\right)^2 + \lambda\sum^p_{j=1}|\beta_j| \quad\quad\tag{5} 
$$

後ほど詳しく見ますが、Lassoは係数ベクトル $\beta$ のいくつかの成分が正確に $0$ と推定されるので、variable selectionの手法として使えるというメリットがあります.

### Lasso推定量の導出

Lasso推定量はRidge推定量と異なりclosed form solutionは存在しません. ただ、$X^TX = nl$と直交するケースでは解析解を求めることができます.
直交仮定を外した一般のケースでは数値計算的に求めるしかありませんが、これを求めるアルゴリズムは複数ありますがここでは (A) `statsmodels`に倣い、ここでは凸二次計画法に基づいた定式化及び実装方法と、(B)`sklearn`の実装で用いられているcordinate descent methodを紹介します.

#### CASE (1): $X^TX = nI$と直交するケース

この場合、Lasso推定量は解析的にもとめることができます. まず損失関数の定義をします.

$$
L(\beta) = (Y - X\beta)^T(Y - X\beta) + \lambda \|\beta\|_{l1}\quad\quad\tag{6}
$$

$L(\beta)$を$\beta_j$について劣微分すると

$$
0 \in -\sum_{i=1}y_{i}x_{ij} + \beta_j + \lambda
\begin{cases}
1 & (\beta_j > 0)\\
-1 & (\beta_j < 0)\\
[-1,1] & (\beta_j = 0)
\end{cases}
$$

従って、

$$
\beta_{j, Lasso} = \begin{cases}
\sum_{i=1}y_{i}x_{ij}  - \lambda & (\sum_{i=1}y_{i}x_{ij} > \lambda)\\
\sum_{i=1}y_{i}x_{ij}  + \lambda & (\sum_{i=1}y_{i}x_{ij} < -\lambda)\\
0 & (-\lambda \leq \sum_{i=1}y_{i}x_{ij} \leq \lambda)
\end{cases}
$$

または、以下のようにも表すことができます. $s_j\equiv \sum_{i=1}y_{i}x_{ij}$とすると

$$
\beta_{j, Lasso} = \text{sign}(s_j)\max (|s_j|-\lambda, 0)\quad\quad\tag{7}
$$

なお、$X^TX = nI$のとき$s_j=\beta_{j, ols}$が成立します. ここで(7)に注目すると$\|\beta_{j, ols}\|>\lambda$で係数が0になるのか、そうでないかがわかれています. $\|\beta_{j, ols}\|/\hat\sigma > t$を満たす変数を採択するt検定変数の$t$と$\lambda$の水準を上手く対応させれば、t検定とLASSOは同じ変数を選ぶことがわかります. また、LASSOは変数増加法による変数組合せと同じになることも知られています. この性質はRidge推定量には存在しない性質です.

ただし、変数増加法とt検定変数採択法とちがってLASSOの推定値は縮小推定されることは忘れないでください.

#### CASE (2): 直交仮定を外した一般のケース

##### 凸二次計画法に基づいた計算方法

Lasso推定量の損失関数は(6)となりますが、凸二次計画法に基づいて計算する場合は(6)を(8)-(10)のように変形します:

$$
L(\beta) = (Y - X\beta)^T(Y - X\beta) + \lambda \|\beta\|_{l1}\quad\quad\tag{6}
$$

$$
\begin{align*}
\text{minimize }  &L(\beta) = (Y - X\beta)^T(Y - X\beta) + \lambda l^Tz\tag{8}\\
\text{subject to } & z \geq \beta\tag{9}\\
& z \geq -\beta\tag{10}
\end{align*}
$$

これPythonで実装する場合は、

```python
import numpy as np
import cvxpy as cp

def reg_lasso(y, x, penalty):
    k = x.shape[1]
    beta, z = cp.Variable(k), cp.Variable(k)

    obj = cp.Minimize(sum(cp.square(y - x @ beta)) + penalty * sum(z))
    cons = [
            z >= beta,
            z >= -beta
            ]
    
    Problem = cp.Problem(obj, cons)
    Problem.solve(verbose = False)

    return beta.value
```

###### ペナルティー水準に応じたBias-Variance Decompositionの確認 - statsmodels-based

<iframe src="https://nbviewer.org/github/RyoNakagami/Blog_Supplementary_Materials/blob/main/statistics/Lassoestimator_01.ipynb" width="100%" height="4300" frameborder="0"></iframe>


##### Cordinate Descent Methodによる計算方法

(6)のLasso推定量の損失関数を以下のように変形します

$$
\begin{align*}
\text{RSS}^{lasso}(\beta) &= \text{RSS}^{ols}(\beta) + \text{Penalty}\\
&= \sum_{i=1}^N\left(y_i - \sum_{j=0}^p\beta_jx_{ij}\right)^2 + \lambda\sum^p_{j=0}|\beta_j| \quad\quad\tag{11}
\end{align*}
$$

> (11)のRHS 第一項のFOC

$$
\begin{align*}
\frac{\partial}{\partial \beta_j}\text{RSS}^{ols}(\beta) &= -\sum_{i=1}^N x_{ij} \left[y_i - \sum_{j=0}^p \beta_j x_{ij}\right]\\
& = -\sum_{i=1}^N x_{ij} \left[y_i - \sum_{k \neq j}^p \beta_k x_{ik} - \beta_j x_{ij}\right]\\
& = -\sum_{i=1}^N x_{ij}\left[y_i - \sum_{k \neq j}^p \beta_k x_{ik} \right] +  \beta_j \sum_{i=1}^N (x_{ij})^2\\
& \equiv - \rho_j + \beta_j z_j
\end{align*}
$$

> (11)のPenalty項の劣微分

$$
\begin{align*}
    \partial_{\beta_j} \lambda \sum_{j=0}^n |\beta_j|  =      \partial_{\beta_j} \lambda |\beta_j|=
    \begin{cases}
      \{ - \lambda \} & \text{if}\ \beta_j < 0 \\
      [ - \lambda , \lambda ] & \text{if}\ \beta_j = 0 \\
      \{  \lambda \} & \text{if}\ \beta_j > 0 
    \end{cases}
\end{align*}
$$

> (11)の劣微分の整理

$$
\begin{aligned}
     \begin{cases}
       \beta_j = \frac{\rho_j + \lambda}{z_j}  & \text{for} \ \rho_j < - \lambda \\
       \beta_j = 0 & \text{for} \ - \lambda \leq \rho_j \leq \lambda \\
       \beta_j = \frac{\rho_j - \lambda}{z_j}  & \text{for} \ \rho_j > \lambda 
    \end{cases}
\end{aligned}
$$

###### Cordinate Descent Algorithmの概要

```c++
1 : beta = (0,...,0) // 初期値
2 : beta_updated = (beta_1,..., beta_p) // 初期値
2 : iter_count = 0 // iteration count
3 : eps = 1e-10
4 : while iter_count = 0 or dist(beta, beta_updated) > eps:
5 :       iter_count += 1
6 :       beta = beta_updated
7 :       for j = 1 : P do
8 :           beta_updated[j] = argmin f(beta_1,..., beta_{j-1}, w, beta_{j+1}, beta_p)
9 :       end for
10: end while 
11: return beta_updated
```

###### Pythonでの実装: Coordinate descent update rule

<iframe src="https://nbviewer.org/gist/RyoNakagami/bf8533255c58214dd15b96aea15f3494" width="100%" height="5500" frameborder="0"></iframe>



## Appendix
### Bias-Variance Trade-off

データとして$\{y_i, x_i\}_{i=1}^n$が与えられたとき、

- $E[y_i\|x_i]$: 真の関数, $y = E[y_i\|x_i] + \epsilon_i$
- $var(y_i\|x_i) = \sigma^2$
- $h(x_i)$: 真の関数$E[y_i\|x_i]$をデータから推定した関数


<div class="math display" style="overflow: auto">
$$
\begin{align*}
E[(y_i - h(x_i))^2] &= E[(y_i - E[y_i|x_i] + E[y_i|x_i] - h(x_i))^2]\\
&= \sigma^2 + E[(E[y_i|x_i] - h(x_i))^2]\\
&= \sigma^2 + E[(E[y_i|x_i] - E(h(x_i)) + E(h(x_i)) - h(x_i))^2]\\
&= \sigma^2 + \text{Bias}^2(h) + \text{var}(h)
\end{align*}
$$
</div>


## References

- [GitHub: RyoNakagami > Blog_Supplementary_Materials > statistics/](https://github.com/RyoNakagami/Blog_Supplementary_Materials/tree/main/statistics)
- [An Introduction to Statistical Learning > Credit Data](https://www.statlearning.com/s/Credit.csv)
- [PennState STAT 508 > Regression Shrinkage Methods](https://online.stat.psu.edu/stat508/lesson/5)
- [rinchi_math > Lassoがスパース推定になる理由について](https://zenn.dev/rinchi_math/articles/1a561c1dec000b)