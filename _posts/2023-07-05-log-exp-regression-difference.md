---
layout: post
title: "対数変換と回帰モデル"
subtitle: "弾力性は一致するのか？"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-09-28
tags:

- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [対数変換と回帰モデル](#%E5%AF%BE%E6%95%B0%E5%A4%89%E6%8F%9B%E3%81%A8%E5%9B%9E%E5%B8%B0%E3%83%A2%E3%83%87%E3%83%AB)
  - [Jensen's inequality](#jensens-inequality)
  - [対数変換でパラメーターが識別できるときはあるのか？](#%E5%AF%BE%E6%95%B0%E5%A4%89%E6%8F%9B%E3%81%A7%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%8C%E8%AD%98%E5%88%A5%E3%81%A7%E3%81%8D%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AF%E3%81%82%E3%82%8B%E3%81%AE%E3%81%8B)
- [実務上差し障りがあるのか？](#%E5%AE%9F%E5%8B%99%E4%B8%8A%E5%B7%AE%E3%81%97%E9%9A%9C%E3%82%8A%E3%81%8C%E3%81%82%E3%82%8B%E3%81%AE%E3%81%8B)
- [Appendix: Python Code](#appendix-python-code)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 対数変換と回帰モデル

$$
\mathbb E[y|\mathbf x] = \exp(\beta_0 + \beta_1 \ln(x_1) + \beta_2x_2)
$$


という回帰モデルについて弾力性を考えた場合, $x_1$についての弾力性は以下で表現されます

$$
\text{elasticity} = \frac{\partial\ln(\mathbb E[y|\mathbf x])}{\partial\ln (x_1)} = \beta_1
$$

実務で上記を推定する場合は, 線形関数に直したほうが扱いやすいという理由で以下の推定式を用いるケースがあります

$$
\begin{align}
&\ln(\mathbb E[y|\mathbf x]) = \beta_0 + \beta_1 \ln(x_1) + \beta_2x_2\\
&\Rightarrow \ln(y) = b_0 + b_1 \ln(x_1) + b_2x_2 + \epsilon
\end{align}
$$

(1), (2)は似た推定式ですが, 厳密に言うと(2)は$\mathbb E[\ln(y)|x]$をtargetとして推定しているので, 一般的には

$$
\frac{\partial\ln(\mathbb E[y|\mathbf x])}{\partial\ln (x_1)} \neq \frac{\partial\mathbb E[\ln(y)|\mathbf x]}{\partial\ln (x_1)}
$$

となってしまいます. このstatementは（厳密ではないですが）Jensen's inequalityで確かめられます

### Jensen's inequality

今回の対数関数はconcaveなのでconcave functionに限ってJensen's inequalityを紹介します.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Theorem: Jensen's Inequality</ins></p>

If $g(x)$ is a concave function on $\mathbf R_X$, and $\mathbb E[g(X)]$ and $\mathbb g(\mathbb E[X])$ 
are finite, then

$$
\mathbb E[g(X)] \leq g(\mathbb E[X])
$$

</div>

> Sketch of Proof

関数$g$がconcaveならば, 定義域の任意の点$x_0$で以下の関係式が成立します

$$
g(x) \leq g(x_0) + g'(x_0)(x - x_0), \forall x \in R_x
$$

上記の式について$x_0 = \mathbb E[x]$とした上で, 期待値をとると

$$
\begin{align*}
\mathbf E[g(x)] &\leq \mathbb E[g(\mathbb E[x]) + g'(\mathbb E[x])(x - \mathbb E[x])]\\
                &= g(\mathbb E[x]) + g'(\mathbb E[x])(\mathbb E[x] - \mathbb E[x])\\
                &= g(\mathbb E[x])
\end{align*}
$$

なお, strictly concave & $x$が「almost surelyの意味でconstant」ではないならば

$$
\mathbb E[g(X)] < g(\mathbb E[X])
$$

が成立します.

### 対数変換でパラメーターが識別できるときはあるのか？
 = \mathbb E[u] 
Jensen's Inequalityによって, 対数変換のようなstrictly concaveな非線形関数のとき

$$
\mathbb E[\ln(y)|\mathbf x] \neq \ln(\mathbb E[y|\mathbf x])
$$

となりますが, それでも弾力性を識別できるときはあります. Intuitionだけ説明したいので, 上記のTrue form回帰モデルを
以下のようにして説明します.

$$
\ln(y) = \beta_0 + \beta_1 \ln(x_1) + \beta_2x_2 + u
$$

このとき, 両辺を指数変換 & $X$で条件づけた期待値をとると

$$
\mathbb E[y|X] = \exp(\beta_0 + \beta_1 \ln(x_1) + \beta_2x_2)\times\mathbb E[\exp(u)|X]
$$

となります. このとき, 

$$
\mathbb E[\exp(u)|X] = \mathbb E[\exp(u)] = 1
$$

が成り立つならば, 簡単な計算で

$$
\frac{\partial\ln(\mathbb E[y|\mathbf x])}{\partial\ln (x_1)} = \frac{\partial\mathbb E[\ln(y)|\mathbf x]}{\partial\ln (x_1)}
$$

が確かめられます. 


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>識別条件</ins></p>

$$
\mathbb E[\exp(u)|X] = \mathbb E[\exp(u)] = 1
$$ 

この関係式は以下のとき成立する

$$
\begin{align*}
&X\text{と}u\text{が独立} \\
&\mathbb E[u|X] = \mathbb E[u] = 0
\end{align*}
$$

</div>

conditional meanが0, i.e., $\mathbb E[u|X] = 0$の条件だけでは不十分です. 例として, 
$u$の分散が$x$の大きさに比例するなどのとき(Heteroskedasticity)は, 「$X$と$u$が独立」とはいえません.


## 実務上差し障りがあるのか？

実務上は対数変換したとしても, 推定係数が大きく変わるということはありません. [Appendixのコード]((#appendix-python-code))で確かめたところ
小さなズレはありましたが, あまり差し障りがないと判断しても良いと思います. 

ただし, True formで推定したほうが推定値の分散が小さくなるのは間違いないことです. 

$$
y = \exp(\beta_0 + \beta_1 x_1) + \epsilon
$$

上記をtrue formとしたとき, 

- error term$\epsilon$がregressorの逆数に比例する条件で不均一性をもたせ
- その上で分散の大きさを変化させてみた

という形でsimulation dataを作成して回帰したところ, $\beta_!$の推定値の分散はnoiseの大きさに対して以下のような結果になりました. ただし, orderがnanoの単位なので現実的にはあまり気にしなくてもよいと思われます.


{% include plotly/20230705_exp_coefficient_var_difference.html %}


## Appendix: Python Code


```python
import plotly.express as px
import numpy as np
import statsmodels.api as sm
from scipy import stats
from scipy.optimize import minimize
import pandas as pd

class LogExpReg:
    def __init__(self, n, v, max_counter:int=100, seed:int=42):
        self.ob_size = n
        self.noise_level = v
        self.max_counter = max_counter
        self.exp_form_beta = []
        self.log_form_beta = []
        np.random.seed(seed)

    def dgp(self):
        CONST = 20
        beta = 1
        self.x = np.random.uniform(0, 1, self.ob_size)
        error = np.array(list(map(lambda x: np.random.normal(0, x, 1), 
                                  self.noise_level/np.abs(self.x)))).flatten()
        self.y = np.exp(CONST + beta*self.x) + error

    def log_reg(self):
        outcome = np.log(self.y)
        regressor = np.array([np.array([1]*len(self.x)), self.x]).T
        self.log_beta = np.linalg.inv(regressor.T @ regressor) @ (regressor.T @ outcome)

    def gaussian_mle(self, params):
        beta_0 = params[0]   
        beta_1 = params[1]   
        sd = params[2]
        ce = np.exp(beta_0 + beta_1 * self.x)

        obj = -stats.norm.logpdf(self.y, loc=ce, scale=sd).sum()
        return obj

    def exp_reg(self):
        init_sigma = np.sqrt(np.mean((self.y - np.exp(self.log_beta[0] + self.log_beta[1] * self.x))**2))
        initParams = [self.log_beta[0], self.log_beta[1], init_sigma]
        results = minimize(self.gaussian_mle, initParams, method='Nelder-Mead')
        self.exp_beta = results.x[:2]

    def fit(self):
        counter = 0
        while counter < self.max_counter:
            counter += 1
            
            self.dgp()
            self.log_reg()
            self.exp_reg()

            self.log_form_beta.append(self.log_beta[1])
            self.exp_form_beta.append(self.exp_beta[1])
    
    def plot(self):
        df = pd.DataFrame({'log_beta':self.log_form_beta,
                           'exp_beta':self.exp_form_beta})
        fig = px.histogram(df, x=['log_beta', 'exp_beta'],
                           labels={'value': 'beta_1'},
                           histnorm='probability',
                           barmode='overlay')
        return fig
    
    def summary(self):
        exp_beta_mean, log_beta_mean = np.mean(self.exp_form_beta), np.mean(self.log_form_beta)
        exp_beta_var, log_beta_var = np.var(self.exp_form_beta), np.var(self.log_form_beta)
        return exp_beta_mean, log_beta_mean, exp_beta_var, log_beta_var

#-------------------
# main
#-------------------

from os import cpu_count
from multiprocessing import Pool

def main(var_size):
    Solver = LogExpReg(50, var_size)
    Solver.fit()
    return Solver.summary()

num_workers = int(0.8 * cpu_count())
with Pool(num_workers) as p:
    result = np.array(p.map(main, np.arange(10, 1000, 10)))


df = pd.DataFrame(result, columns=['exp_mean', 'log_mean', 'exp_var', 'log_var'])
df['noise_sigma'] = np.arange(10, 1000, 10)
fig = px.line(df, x = 'noise_sigma', y = ['exp_var', 'log_var'])
fig.show()
```


References
---------------

- [Econometric Analysis of Cross Section and Panel Data, Second Edition](https://mitpress.mit.edu/9780262232586/)
- [Jensen's Inequality](https://www.probabilitycourse.com/chapter6/6_2_5_jensen%27s_inequality.php)
