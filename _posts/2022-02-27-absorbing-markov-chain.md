---
layout: post
title: "吸収マルコフ連鎖の紹介"
subtitle: "コミュニティー内部でNewsはどのように広がるのか"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- 統計検定
- マルコフ連鎖
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 吸収マルコフ連鎖とは？: 吸収状態を持つ過程](#1-%E5%90%B8%E5%8F%8E%E3%83%9E%E3%83%AB%E3%82%B3%E3%83%95%E9%80%A3%E9%8E%96%E3%81%A8%E3%81%AF-%E5%90%B8%E5%8F%8E%E7%8A%B6%E6%85%8B%E3%82%92%E6%8C%81%E3%81%A4%E9%81%8E%E7%A8%8B)
  - [カップルが結婚/離縁するまでの日数](#%E3%82%AB%E3%83%83%E3%83%97%E3%83%AB%E3%81%8C%E7%B5%90%E5%A9%9A%E9%9B%A2%E7%B8%81%E3%81%99%E3%82%8B%E3%81%BE%E3%81%A7%E3%81%AE%E6%97%A5%E6%95%B0)
- [2. コミュニティー内部でNewsはどのように広がるのか](#2-%E3%82%B3%E3%83%9F%E3%83%A5%E3%83%8B%E3%83%86%E3%82%A3%E3%83%BC%E5%86%85%E9%83%A8%E3%81%A7news%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AB%E5%BA%83%E3%81%8C%E3%82%8B%E3%81%AE%E3%81%8B)
  - [吸収マルコフ連鎖によるモデル化](#%E5%90%B8%E5%8F%8E%E3%83%9E%E3%83%AB%E3%82%B3%E3%83%95%E9%80%A3%E9%8E%96%E3%81%AB%E3%82%88%E3%82%8B%E3%83%A2%E3%83%87%E3%83%AB%E5%8C%96)
    - [モデルの仮定](#%E3%83%A2%E3%83%87%E3%83%AB%E3%81%AE%E4%BB%AE%E5%AE%9A)
    - [モデル構築](#%E3%83%A2%E3%83%87%E3%83%AB%E6%A7%8B%E7%AF%89)
    - [適合度検定](#%E9%81%A9%E5%90%88%E5%BA%A6%E6%A4%9C%E5%AE%9A)
    - [Python Simulationの紹介](#python-simulation%E3%81%AE%E7%B4%B9%E4%BB%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 吸収マルコフ連鎖とは？: 吸収状態を持つ過程

自分以外の状態へ推移する確率が 0 という状態を吸収状態といい、吸収状態以外はすべて一時的であるようなマルコフ連鎖を吸収マルコフ連鎖といいます.

> 例

状態変数$X$が２つの状態$(x_0, x_1)$からなる吸収マルコフ連鎖を考えます. 状態$x_i$から状態$x_j$への遷移確率を$(i,j)$要素で記述した遷移行列を以下のように定義します

$$
\mathbf P = \left(\begin{array}{cc}1 & 0 \\ p & 1-p\end{array}\right)
$$

このとき、状態$x_0$が吸収状態、$x_1$が非吸収状態となります. 状態$x_1$から$x_0$に至る時間を$T$とすると

$$
\begin{align*}
&\mathrm E[T|X = x_1]= p + (1 - p)(1 + \mathrm E[T|X = x_1])\\
\Rightarrow& \mathrm E[T|X = x_1] = p^{-1}
\end{align*}
$$

### カップルが結婚/離縁するまでの日数

カップルが結婚/離縁までの状態遷移を考えてみます. カップルの関係性は４つの状態で構成されているとし, (1: marriage, 2: break-up, 3: dating, 4: quarrel), １ヶ月ごとに遷移するとします.

それぞれの状態の数字を$i, j$で表記したとして、状態$i$から状態$j$への遷移確率を$(i,j)$要素で記述した遷移行列を以下のように定義します

$$
\mathbf P = \left(\begin{array}{cccc}
1 & 0 & 0 & 0 \\ 
0 & 1 & 0 & 0 \\ 
\frac{3}{16} & \frac{1}{16} & \frac{1}{2} & \frac{1}{4}\\
\frac{1}{20} & \frac{4}{20} & \frac{1}{4} & \frac{1}{2}
\end{array}\right)
$$

上述の遷移行列の定義より、 (1: marriage, 2: break-up)が吸収状態となります. 一度、(1: marriage, 2: break-up)のいずれかに至るとカップルの関係性は一旦おしまいとなります.

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220228-fig-01-markov-chain.png?raw=true">


このような遷移過程が与えられた時、どのような疑問に答える形で分析するかというと代表的なものとして

1. カップルが結婚するまでに平均どれくらいの期間がかかるのか？
2. どのくらいのカップルが最終的に結婚するのか？

> (1) カップルが結婚/離縁するまでに平均どれくらいの期間がかかるのか？

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220228-fig02-divide-matrix.png?raw=true">

この問題を考えるにあたって、遷移行列を上のように分解するのが有用です. 分解の結果導出される部分行列のついての解釈は

- $I$: 吸収状態なので自分自身への遷移確率が1
- $R$: 非吸収状態から吸収状態への遷移確率行列
- $Q$: 非吸収状態内部間の遷移確率行列

カップルがdating/quarrelの状態にとどまる平均月数は部分行列$Q$の情報があれば計算できます. 行列 $N$を状態$i$を出発したときに$j$にとどまる日数とすると

$$
\begin{align*}
N & = \begin{array}{cc}n_{33} & n_{34}\\ n_{43} & n_{44}\end{array}\\
&= Q + Q^2 + Q^3 + \cdots\\
&= I + Q + Q^2 + Q^3 + \cdots - I\\
&= (I - Q)^{-1} - I\\
&= \left(\begin{array}{cc}\frac{5}{3} & \frac{4}{3} \\ \frac{4}{3} & \frac{5}{3}\end{array}\right)
\end{align*}
$$

dating/quarrelの状態から始まり、非吸収状態にとどまる月数は

$$
N\left(\begin{array}{c}1 \\ 1\end{array}\right) = \left(\begin{array}{c}3\\ 3\end{array}\right)
$$

とそれぞれ３ヶ月ずつとどまることがわかる.

> (2) どのくらいのカップルが最終的に結婚するのか？

初期値から結婚に遷移するパターン、1回非吸収状態に留まって結婚に遷移するパターン、2回非吸収状態に留まって結婚に遷移するパターン...と分解することができるので

$$
\begin{align*}
&(I + Q + Q^2 + Q^3+\cdots)R \\
&=\left(\begin{array}{cc}\frac{17}{30} & \frac{13}{30} \\ \frac{23}{60} & \frac{37}{60}\end{array}\right)
\end{align*}
$$

と表記できます. dating状態から始まったカップルの約56%が最終的に結婚, 喧嘩状態から始まったカップルの約38%が最終的に結婚ということがわかります.また、各行の合計が1になることよりも、矛盾しない結果であることがわかります.

## 2. コミュニティー内部でNewsはどのように広がるのか

あるコミュニティーに住む人たちの間で、Newsがどのように広がっていくか分析するために次のような実験をしたとします（元ネタは1950年代にアメリカ空軍が主催したリビア計画）.

- ある村に住む210人の女性の20%(42人)をランダムに選び、その人たちにコーヒーのブランドの宣伝文句を伝える
- 宣伝文句を伝えられた女性たちは同じ村の女性にその情報を伝えることを依頼されている
- 調査員が村に戻ってきた時、その宣伝文句を知っていたらその女性はコーヒーを無料でもらえる

１週間後に調査員が戻ってNewsの広がり具合を調べたところ以下のような結果でした:

|発信源から何人目か|観測人数|
|---|---|
|0人目|42人|
|1人目|69人|
|2人目|53人|
|3人目|14人|
|4人目以上|6人|
|聞いていない|26|

ニュースを聞いていない人が想定よりも多く、またヒアリングの結果ニュースの新鮮さはすでに失われもう広がる余地のないよう状態になっていることがわかったとします.

### 吸収マルコフ連鎖によるモデル化

上述のNewsの広がり結果をモデルによって説明してみたいと思ったとします. 分析を単純化するため、次のような仮定をおいてモデル構築を組み立ててみます.

#### モデルの仮定

> 仮定 (1): コミュニティーの女性の分類

- コミュニティーの人間は「naive」「spreader」「suppressor」の三タイプに分けられる

---|---
naive|Newsを知らず、今後知る可能性のある人
spreader|Newsを知っており、naiveと出会い次第その人にNewsを広める人
suppressor|Newsを知っているが、naiveと出会ってもNewsを広めることはない人

spreaderはnewsはまだ新鮮さがあると思っていてそれを広めたい人の一方、SupressorはNewsはもう価値を失ったと考えている人というイメージです.

> 仮定 (2): SpreaderはNewsを知っている人と出会った瞬間にSuppressorになる

- Newsを知っている人同士が出会った瞬間に、その人たちはNewsはすでに広まっていると考え話題に出すことを止めるとします

> 仮定 (3): Suppressorになったらもう他の状態には移らない

- Suppressorはいわゆる吸収状態とします


> 仮定 (4): コミュニティーの女性の出会いの頻度

- どの女性も等確率で他の人と出会う
- １期に１人と出会う

#### モデル構築

「naive」「spreader」「suppressor」をそれぞれ$(I, G_i, S_i)$という３つの確率状態変数で表現するとします. また「spreader」「suppressor」について、発信源から何人目の「spreader」/「suppressor」を表現するため、$i\in(0,1,2,3,4)$というindexで管理するとします. ただし$i=4$は「発信源から４人目以上」とします

出発時点において、20%の人が$G_0$で、80%の人が$I$に分類されるので、要素$(i,j)$が状態$i$から状態$j$へ遷移する確率（具体的には$(S_0, G_0, G_1, I)$の状態から$(S_0, G_0, G_1, I)$へ遷移）を表す遷移行列でこれを表現すると

$$
\mathbf P_1 = \left(\begin{array}{cccc}
1 & 0 & 0 & 0\\
0.2 & 0.8 & 0 & 0\\
0 & 0 & 0 & 0\\
0 & 0 & 0.2 & 0.8
\end{array}\right)
$$

これに対して、初期ベクトル$v_0 = (0, 0.2, 0. 0.8)$を左から掛けることより次のようなupdateを得ます

$$
\begin{align*}
v_1 &= v_0P_1\\
&= (0.04, 0.16, 0.16, 0.64)
\end{align*}
$$

次に、第二期目のシフトを考えます. $v_1$を見ると「Naive」に該当する人が64%いるので、情報を知っている人の64%はそのままspreader, 32%の人がspreaderなので「Naive」の人の32%が $G_1, G_2$の移動します. 従って、$(S_0, S_1, G_0, G_1,G_2, I)$の状態から$(S_0, S_1, G_0, G_1,G_2, I)$へ遷移を表す遷移行列でこれを表現すると

$$
\mathbf P_2 = \left(\begin{array}{cccc}
1 & 0 & 0 & 0 & 0 & 0\\
0 & 1 & 0 & 0 & 0 & 0\\
0.36 & 0 & 0.64 & 0 & 0 & 0\\
0 & 0.36 & 0 & 0.64 & 0 & 0\\
0 & 0 & 0 & 0 & 0 & 0\\
0 & 0 & 0 & 0.16 & 0.16 & 0.68\\
\end{array}\right)
$$

$$
\begin{align*}
v_2 &= v_1P_2\\
&= (0.098, 0.058, 0.102, 0.204, 0.102, 0.425)
\end{align*}
$$

これを７回目の出会いまでやると

$$
v_7 = (0.2  , 0.32 , 0.234, 0.092, 0.024, 0.   , 0.   , 0.001, 0.001, 0.002, 0.125)
$$

という結果を得ます.

なお、1000回目の出会いまで計算しても結果は

$$
v_{1000} = (0.2  , 0.321, 0.235, 0.093, 0.027, 0.   , 0.   , 0.   , 0.   , 0.   , 0.124)
$$


#### 適合度検定

ここで実際に観察されたデータと、吸収マルコフ連鎖モデルによる理論値の値を頻度論の検定のフレームワークで検証してみます. 今回はカイ自乗適合度検定で計算してみます. 

$S_0, G_0$の人数は初期値によって与えられているので$(S_1, S_2, S_3, S_4, G_1, G_2, G_3, G_4, I)$の理論値と観測値をPythonを用いて検定します. `v_7`を7回目の出会いまでを表す理論値ベクトルとすると

```python
from scipy.stats import chisquare
chisquare([69, 53, 14, 6, 26], f_exp=v_7)
```

Then,

```
Power_divergenceResult(statistic=1.95269645014398, pvalue=0.7444590631913759)
```

と帰無仮説が棄却できない結果となります. ただし、stateを5以上に設定すると棄却され、Robustな分析結果とは言えない可能性があります(そもそも頻度論のフレームワークに問題があるかもしれませんが).


#### Python Simulationの紹介

> 基本方針

- (吸収状態, 吸収状態)の遷移は単位行列
- (吸収状態, 非吸収状態)の遷移は0
- (非吸収状態, 非吸収状態)の遷移は基本的には１期前の「Naive」人数割合が対角要素となる行列
- (非吸収状態, 吸収状態)の遷移は「単位行列 - (非吸収状態, 非吸収状態)の行列」
- 「naive」のspreaderへの遷移は１期前の「spreader」人数割合をずらして作成


> Class実装

```python
import numpy as np

class Revere_Plan_Sumulator:

    def __init__(self, population_size, initial_news_holder_ratio, maximum_state, eps = 1e-18):
        """ 
        Args
            population_size
                コミュニティの構成人数
                そのコミュニティを対象にニュースが広まる程度を観察する

            initial_news_holder_ratio
                ニュースを初めに伝達した人数の割合＝伝達人数割合初期値

            maximum_state
                コニュニティの構成員のstateの種類の上限値
                (例) もし、maximum_state = 3 ならば、コニュニティの構成員のstateは三人以上を挟んでニュースを又聞きしたまでとなる

        Outputs
            prob_vector
                状態割合変数
                S_0, S_1, ...., S_{maximum_state}, G_0, G_1, ...., G_{maximum_state}, I

        How to use it
            EXAMPLE: 
                newsの各期の新規伝達社人数の推移のplot

            CODE
                community_size = 210
                initial_news_holder = 0.2
                Maximum_state = 4
                iter_number = 1000

                TestClass = Revere_Plan_Sumulator(community_size, initial_news_holder, Maximum_state)
                prob_vector, spread_sequence = TestClass.do_simulation(iter_number)
                
                plt.plot(spread_sequence[1:]) 
        """

        ## input
        self.population_size = population_size
        self.initial_news_holder = initial_news_holder_ratio
        self.maximum_state= maximum_state
        self.eps = eps
        self.news_holder_sequence = None

        # create an initial vector
        field_number = 2 * (self.maximum_state + 1) + 1
        self.prob_vector = np.zeros(field_number)
        self.prob_vector[maximum_state+1], self.prob_vector[-1] = initial_news_holder_ratio, 1 - initial_news_holder_ratio
        
        # create an transition matrix
        self.transition_matrix = np.zeros((field_number, field_number))
        self.transition_matrix[:self.maximum_state + 1, :self.maximum_state + 1] = np.eye(self.maximum_state + 1)

    def update_transition_matrix(self):
        """
        Description
            今季の遷移行列の計算
        
        Note
            1. (吸収状態, 吸収状態)の遷移は単位行列
            2.  (吸収状態, 非吸収状態)の遷移は0
            3. Q: (非吸収状態, 非吸収状態)の遷移は基本的には１期前の「Naive」人数割合が対角要素となる行列
            4.  R: (非吸収状態, 吸収状態)の遷移は「単位行列 - (非吸収状態, 非吸収状態)の行列」
            5. last_row: 「naive」のspreaderへの遷移は１期前の「spreader」人数割合をずらして作成
        
        REMARKS
            (非吸収状態, 非吸収状態)の遷移はノートと照らし合わせると、１期前にG_iが0以上ならば 
            G_i→G_i の遷移が１期前の「Naive」人数割合となり、それ以外ならば 0 とすべきだが
            計算上問題ない(１期前のベクトル要素が0ならば何があっても0)なので、実装からは
            除去
         
            which_element_update_vector = np.where(self.prob_vector[self.maximum_state+1:-1] > self.eps, 1, 0) ##ここは計算上なくても問題ない
            Q = np.eye(self.maximum_state+1) * (which_element_update_vector * self.prob_vector[-1]) ## convert to spreader
            R = np.eye(self.maximum_state+1) * (which_element_update_vector * (1 - self.prob_vector[-1])) ## convert to suppressor
        """

        Q = np.eye(self.maximum_state+1) * self.prob_vector[-1] ## convert to spreader
        R = np.eye(self.maximum_state+1) * (1 - self.prob_vector[-1]) ## convert to suppressor
        
        last_row = self.prob_vector[self.maximum_state+1:-1].copy() ## 配列コピー
        last_row[-2] = last_row[-2] + last_row[-1]
        last_row[-1] = max(1 - sum(last_row[:-1]),0)

        self.transition_matrix[self.maximum_state+1:-1, :self.maximum_state+1] = R
        self.transition_matrix[self.maximum_state+1:-1, self.maximum_state+1:-1] = Q
        self.transition_matrix[-1,self.maximum_state+2:] = last_row

    def update_prob_vector(self):
        """  
        Description
            今季の状態割合ベクトル
            = １期前の状態割合ベクトル × 確率遷移行列

        """
        ## 今季の確率遷移行列のupdate
        self.update_transition_matrix()
        
        
        return np.matmul(self.prob_vector, self.transition_matrix)

    def do_simulation(self, iter_limit):
        """  
        Args
            iter_limit
                何回目の出会いまで計算するかをsimulation
        
        """
        count_iter = 0
        
        self.news_holder_sequence = np.zeros(iter_limit+1)
        self.news_holder_sequence[0] = self.initial_news_holder

        while count_iter < iter_limit:
            count_iter += 1
            prob_vec = self.update_prob_vector()
            
            news_holder_increment = self.prob_vector[-1] - prob_vec[-1]
            self.news_holder_sequence[count_iter] = news_holder_increment
            
            if abs(news_holder_increment) < self.eps:
                break
            else:
                self.prob_vector = prob_vec

        return self.prob_vector, self.news_holder_sequence[:count_iter]
```

> 動作の紹介

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import chisquare

plt.rcParams['font.family'] = 'Meiryo'

M = 4
TestClass = Revere_Plan_Sumulator(210, 0.2, M)
prob_vector, spread_sequence = TestClass.do_simulation(1000)

plt.figure(figsize=(10, 8))
plt.plot(spread_sequence[1:])
plt.title('一過性のNews流行の変化')
plt.xlabel('Markov chainの各期間')
plt.ylabel('新規News伝聞者割合');
```

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220228-fig03.png?raw=true">

> 今後の拡張

コミュニティー人数が今回は一定の仮定のもとSimulationを実施しているが、現実には世代交代や新規移住者などのコミュニティー構成割合の変容があります.
この要素を加えるかたちでモデルを修正すると、「Naive」人数がとあるタイミングで増えるという形に拡張でき、
細かな流行を繰り返すモデルを記述できるようになります. この辺の拡張は次回移行試みます.

また、 COVID-19の流行に伴いSIRモデルという言葉がよく聞かれるようになりましたが、基本的には
吸収マルコフ連鎖を微分方程式で表現し直したモデルと極論いってしまうことができます. こちらの紹介も次回移行試みます.

## References

- [Matrices and Society: Matrix Algebra and Its Applications in the Social Sciences, Ian Bradley and Ronald L. Meek](https://press.princeton.edu/books/hardcover/9780691638362/matrices-and-society)
- [早稲田大学統計講義ノート, 逆瀬川浩孝著 > 確率過程とその応用](http://www.f.waseda.jp/sakas/stochastics/stochastics.pdf/aspText.pdf)
