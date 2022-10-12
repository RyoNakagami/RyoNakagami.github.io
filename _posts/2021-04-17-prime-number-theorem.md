---
layout: post
title: "素数の分布と素数定理"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- math
- 素数
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [素数の定義](#%E7%B4%A0%E6%95%B0%E3%81%AE%E5%AE%9A%E7%BE%A9)
  - [定理：素数の個数は無限](#%E5%AE%9A%E7%90%86%E7%B4%A0%E6%95%B0%E3%81%AE%E5%80%8B%E6%95%B0%E3%81%AF%E7%84%A1%E9%99%90)
- [素数の分布](#%E7%B4%A0%E6%95%B0%E3%81%AE%E5%88%86%E5%B8%83)
  - [素数が無数にあることの別証明](#%E7%B4%A0%E6%95%B0%E3%81%8C%E7%84%A1%E6%95%B0%E3%81%AB%E3%81%82%E3%82%8B%E3%81%93%E3%81%A8%E3%81%AE%E5%88%A5%E8%A8%BC%E6%98%8E)
  - [素数の個数の濃度の上限](#%E7%B4%A0%E6%95%B0%E3%81%AE%E5%80%8B%E6%95%B0%E3%81%AE%E6%BF%83%E5%BA%A6%E3%81%AE%E4%B8%8A%E9%99%90)
  - [素数定理](#%E7%B4%A0%E6%95%B0%E5%AE%9A%E7%90%86)
- [補題: 互いに素な整数の個数](#%E8%A3%9C%E9%A1%8C-%E4%BA%92%E3%81%84%E3%81%AB%E7%B4%A0%E3%81%AA%E6%95%B4%E6%95%B0%E3%81%AE%E5%80%8B%E6%95%B0)
- [問題集](#%E5%95%8F%E9%A1%8C%E9%9B%86)
  - [京都大学 2016年](#%E4%BA%AC%E9%83%BD%E5%A4%A7%E5%AD%A6-2016%E5%B9%B4)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 素数の定義

$$a>1$$ の整数 $$a$$ は少なくとも1と $$a$$ 自身の二つの約数を持つ． 1および $$a$$ 以外の約数を「真の約数」ともいう． $$a>1$$ の整数 $$a$$ が真の約数を持たないとき $$a$$ を 素数 という． 逆に真の約数を持つ整数を 合成数 という

<div style="text-align: right;">
■
</div>

合成数は素数の積として順序を除けばただ一通りに表すことができます． これが素因数分解の一意性といわれる基本定理です。証明は[こちら](https://ryonakagami.github.io/2021/04/16/mathematical-induction/#%E4%BE%8B%E9%A1%8C-%E7%B4%A0%E5%9B%A0%E6%95%B0%E5%88%86%E8%A7%A3%E3%81%AE%E4%B8%80%E6%84%8F%E6%80%A7)参照

### 定理：素数の個数は無限

素数の個数は無限である．

> 証明

背理法で示します.まず素数の個数が有限であると仮定します. その個数を$$n$$個とし, $$p_1, p_2, \cdots, p_n$$をそのすべての素数とします.このとき、

$$
a = p_1p_2\cdots p_n+1
$$

と整数を定義します. 素因数分解の一意性の定理より, $$a$$は素数の積に分解されます.しかし、$$a$$は、$$p_1, p_2, \cdots, p_n$$のいずれで割っても1余ります.
よって$a$ の素因数分解に現れる素数は $$p_1,\ p_2,\ \cdots,\ p_n$$ ではあり得ず， それら以外の素数である． これは $$p_1,\ p_2,\ \cdots,\ p_n$$ がすべての素数という仮定と矛盾する． ゆえに素数の数は無限である

<div style="text-align: right;">
■
</div>

## 素数の分布

どのように素数が分布しているのかということを，素数の分布に関する問題といいます．これを考えるために，正の実数$$x$$を越えない素数の個数を$$\pi(x)$$と表すとします．

> 例

$$
\pi(100)=24,\ \pi(6000)-\pi(5900)=7
$$

### 素数が無数にあることの別証明

$$
\lim_{x\to\infty}\pi(x) = \infty
$$

> 証明

$$x$$以下の素数にわたる積

$$
\prod_{p\le x}\dfrac{1}{1-\dfrac{1}{p}}=\prod_{p\le x}\left(1-\dfrac{1}{p}\right)^{-1}
$$

を考える．

$$
\dfrac{1}{1-\dfrac{1}{p}}=1+\dfrac{1}{p}+\dfrac{1}{p^2}+\dfrac{1}{p^3}+\cdots
$$

であるから

$$
\prod_{p\le x}\left(1-\dfrac{1}{p} \right)^{-1} =\prod_{p\le x}\left(1+\dfrac{1}{p}+\dfrac{1}{p^2}+\cdots\right)
$$

は，$$x$$以下の素数とそのべきのみを因数にもつような数$$k$$全体にわたる和, $$\sum\dfrac{1}{k}$$である．$$x$$以下の正整数$$n$$はもちろん$$x$$以下の素数とそのべきのみを因数にもつような数であるから

$$
\prod_{p\le x}\left(1-\dfrac{1}{p} \right)^{-1}\ge \sum_{n\le x}\dfrac{1}{n}
$$

$$x\to \infty$$のとき右辺は発散する．もし $$\lim_{x\to \infty}\pi(x)$$が有限であれば，$$x\to \infty$$のとき左辺は 有限個の素数にわたる和となり収束する． これは矛盾なので題意が示された． 

<div style="text-align: right;">
■
</div>

### 素数の個数の濃度の上限

$$
\lim_{x\to\infty} \frac{\pi(x)}{x} = 0
$$

> 証明

$$p_1=2,\ p_2=3,\ \cdots$$と小さい方から$$r$$個の素数が与えられているとする． これらの素数は$$x$$より小さいものとする． $$x$$以下の素数は，この$$r$$個の素数と $$x$$以下の数でこれら$$r$$個の素数で割り切れない数をあわせた数の一部である． したがって 

$$
\begin{aligned}
\pi(x) \leq& r + [x] -\left[\dfrac{x}{p_1}\right]-\left[\dfrac{x}{p_2}\right] -\cdots -\left[\dfrac{x}{p_r}\right]\\ 	 
& +\left[ \dfrac{x}{p_1p_2}\right]+\left[ \dfrac{x}{p_1p_3}\right]\cdots \left[\frac{x}{p_{r-1}p_r}\right]-\cdots +(-1)^r\left[\dfrac{x}{p_1p_2\cdots p_r}\right]
\end{aligned}
$$

$$[x]< x,\ -[x]\le -x+1$$なので，あわせて $$\pm [x]<\pm x+1$$がなりたつ． また、ガウス記号が入った項数は$$2^r$$個あるので

$$
\begin{aligned}
&[x] -\left[\dfrac{x}{p_1}\right]-\left[\dfrac{x}{p_2}\right] -\cdots -\left[\dfrac{x}{p_r}\right]\\ 	 
& +\left[ \dfrac{x}{p_1p_2}\right]+\left[ \dfrac{x}{p_1p_3}\right]\cdots \left[\frac{x}{p_{r-1}p_r}\right]-\cdots +(-1)^r\left[\dfrac{x}{p_1p_2\cdots p_r}\right]\\
& 2^r + x -\left[\dfrac{x}{p_1}\right]-\left[\dfrac{x}{p_2}\right] -\cdots -\left[\dfrac{x}{p_r}\right]\\ 	 
& +\left[ \dfrac{x}{p_1p_2}\right]+\left[ \dfrac{x}{p_1p_3}\right]\cdots \left[\frac{x}{p_{r-1}p_r}\right]-\cdots +(-1)^r\left[\dfrac{x}{p_1p_2\cdots p_r}\right]\\
&= [x] -\dfrac{x}{p_1}-\dfrac{x}{p_2} -\cdots -\dfrac{x}{p_r}\\ 	 
& + \dfrac{x}{p_1p_2}+ \dfrac{x}{p_1p_3}\cdots \frac{x}{p_{r-1}p_r}-\cdots +(-1)^r\dfrac{x}{p_1p_2\cdots p_r}\\
&= 2^r + x\prod^r_{k=1}\left(1 - \frac{1}{r_k}\right)
\end{aligned}
$$

$$r+2^r<2^{r+1}$$であるから 

$$
\pi(x)<2^{r+1}+x\prod_{k=1}^r\left(1-\dfrac{1}{p_k}\right)
$$

$$
\therefore\: \dfrac{\pi(x)}{x}<\dfrac{2^{r+1}}{x}+\prod_{k=1}^r\left(1-\dfrac{1}{p_k}\right)
$$

ここで$$r$$を $$2^{r+1}\le \sqrt{x}$$である最大のものにとる．このとき 

$$
\dfrac{\pi(x)}{x}<\dfrac{1}{\sqrt x}+\prod_{k=1}^r\left(1-\dfrac{1}{p_k}\right)
$$

$$x\to \infty$$のとき$$r\to \infty$$である．

$$
\lim_{x \to \infty}\prod_{k=1}^r\left(1-\dfrac{1}{p_k}\right)^{-1}=\infty
$$

つまり

$$
\begin{aligned}
&\lim_{x \to \infty}\prod_{k=1}^r\left(1-\dfrac{1}{p_k}\right)=0\\
&\lim_{x \to \infty}\dfrac{1}{\sqrt{x}}=0
\end{aligned}
$$

従って、

$$
\lim_{x\to \infty}\dfrac{\pi(x)}{x}=0
$$

が示された． 

<div style="text-align: right;">
■
</div>

### 素数定理

$$
\pi(x)\sim \dfrac{x}{\log x}
$$

という関係性が知られており, これを素数定理といいます. まず導入として, 補正対数積分関数, $Li(x)$,の説明をします.
補正対数積分関数とは以下のような関数として表されます:

$$
Li(x) = \int^x_2 \frac{1}{\log(x)}dx
$$

そしてこの補正対数積分関数は素数濃度の近似として当てはまりが良いことが知られており, 実際に数を見てみると


|x|$\pi(x)$|$Li(x)$|$x/\log(x)$|
|---|---|---|---|---|
|$10^1$|4|5.12|4.34|
|$10^2$|25|29.08|21.71|
|$10^3$|168|176.56|144.76|
|$10^4$|1229|1245.09|1085.74|
|$10^5$|9592|9628.76|8685.89|
|$10^6$|78498|78626.50|72382.41|
|$10^7$|664579|664917.35|620420.69|
|$10^8$|5761455|5752208.33|5428681.02|

詳しい説明は割愛しますが, $Li(x)$について以下のような関係式が知られています:

$$
Li(x) - \frac{x}{\log(x)} = O\left(\frac{x}{(\log(x))^2}\right)
$$

ですので, 補正対数積分関数は素数濃度の近似として当てはまりが良いことがわかれば上記の素数定理の直感的感覚も理解できるようになります.

> 直感的説明: 自然数$N$が素数である確率

十分大きな自然数 $N$ に対し, $N$ が素数である確率を考えてみる．$N$ より小さい素数を $p_1$, ..., $p_m$ としたとき, $N$ が素数であることは, $N$ が$p_1$, ..., $p_m$ のいずれでも割り切れないことと同じです. その確率をナイーブに表現すると

$$
\prod_{i=1}^m \left(1 - \frac{1}{p_i}\right) \approx \frac{1}{\log(N)}
$$

よって $N$ 以下の素数の個数 $\pi(N)$ は

<div class="math display" style="overflow: auto">
$$
\begin{align*}
\pi(N) &\approx \sum_{x=2}^N\frac{1}{\log(x)}\\
&\approx Li(N)
\end{align*}
$$
</div>

なお, $\pi(x)$ と $Li(x)$ のずれは $\sqrt{x}\log(x)$の定数倍より小さいと予想されています. この予想は有名な Riemann 予想と同値です.


## 補題: 互いに素な整数の個数

$$p_1,\ p_2,\ p_3,\ \cdots,\ p_r$$ を相異なる素数とする． 実数 $$x$$ を越えない自然数のなかで $$p_1,\ p_2,\ p_3,\ \cdots,\ p_r$$ のいずれでも割り切れないものの個数$$N$$は次式で与えられる．

$$
\begin{aligned}
N =& [x] -\left[\dfrac{x}{p_1}\right]-\left[\dfrac{x}{p_2}\right] -\cdots -\left[\dfrac{x}{p_r}\right]\\ 	 
& +\left[ \dfrac{x}{p_1p_2}\right]+\left[ \dfrac{x}{p_1p_3}\right]\cdots \left[\frac{x}{p_{r-1}p_r}\right]-\cdots +(-1)^r\left[\dfrac{x}{p_1p_2\cdots p_r}\right]
\end{aligned}
$$

ただし $$[x]$$ は $$x$$ を超えない最大の整数を表す．

> 証明

$$r$$に関する数学的帰納法で証明する．

$$r=1$$ のときは $$1,\ 2,\ \cdots,\ [x]$$ のなかで $$p_1$$ の倍数は

$$
1\cdot p_1,\ 2\cdot p_1,\ \cdots,\ \left[ \dfrac{x}{p_1}\right]p_1
$$

だけある．したがって実数 $$x$$ を越えない自然数のなかで $$p_1$$ で割り切れないものの個数は

$$
[x]-\left[ \dfrac{x}{p_1}\right]
$$

となり，等式は成立する．

$$r=k$$のとき、命題が成立するとする． $$r=k+1$$とし，さらに $$p_{k+1}$$ が追加されたとする． このときは，さらに $$p_{k+1}$$ の倍数 

$$
yp_{k+1}\ \left(y\le\dfrac{x}{p_{k+1}} \right)
$$

を除かなければならない．そのうち $$y$$ が $$p_1,\ p_2,\ \cdots,\ p_k$$ で割り切れるものは すでに除かれているので，新たに除くべきものの個数は， 

$$
\dfrac{x}{p_{k+1}}
$$

を越えない整数のなかで $$p_1,\ p_2,\ \cdots,\ p_k$$ で割り切れないものの個数である．ゆえに求める個数$$N_{k+1}$$は

$$
\begin{aligned} 
N_{k+1}=&[x]-\left[\dfrac{x}{p_1} \right]-\left[\dfrac{x}{p_2} \right]-\cdots + \left[\dfrac{x}{p_1p_2} \right]+ \left[\dfrac{x}{p_1p_3} \right] + \cdots + (-1)^k+ \left[\dfrac{x}{p_1p_2\cdots p_k} \right]\\
&- \left\{\left[\dfrac{x}{p_{k+1}} \right]- \left[\dfrac{x}{p_1p_{k+1}} \right]- \left[\dfrac{x}{p_1p_{k+1}} \right]-\cdots - (-1)^{k+1}+ \left[\dfrac{x}{p_1p_2\cdots p_{k+1}} \right]\right\}\\
=& [x] -\left[\dfrac{x}{p_1}\right]-\left[\dfrac{x}{p_2}\right] -\cdots -\left[\dfrac{x}{p_{k+1}}\right]\\ 	 
& +\left[ \dfrac{x}{p_1p_2}\right]+\left[ \dfrac{x}{p_1p_3}\right]\cdots \left[\frac{x}{p_{k}p_{k+1}}\right]-\cdots +(-1)^{k+1}\left[\dfrac{x}{p_1p_2\cdots p_{k+1}}\right]
\end{aligned}
$$

ゆえに $$k+1$$ のときも成立し，題意が示された

<div style="text-align: right;">
■
</div>



## 問題集
### 京都大学 2016年

素数 $$p, q$$を用いて、$$p^q + q^p$$ と表される素数をすべて求めよ. 

> 解答

一般性を失わずに $$p < q$$ と定義する.

まず、$$(p, q)$$を(偶数, 偶数), (偶数, 奇数), (奇数, 偶数), (奇数, 奇数)の場合分けで考える. このとき、偶数の素数は2しか存在しないことに留意すると,
(偶数, 偶数)は $$2^2 + 2^2 = 8$$となり不敵, (奇数, 奇数)は$$p^q + q^p$$が偶数となり不敵, (奇数, 偶数)は2以下の素数は存在しないので不敵となり、考えるべきは(偶数, 奇数), とくに(2, 奇数)となる.

qが$$3k \pm 1$$ (ただし、kは0以上の整数)と表せるとする.このとき、法を3として$$p^q + q^p$$を考えると

$$
2^q + q^2 \equiv 2 + 1 \equiv 0 \: \mathrm{mod}
$$

よって、$$p^q + q^p$$ と表される素数は存在しない.

次に、$$q = 3$$, つまり$$3k$$で表せる唯一の素数とすると、

$$
2^3 + 3^2 = 17
$$

と題意を満たす. よって、17のみ

<div style="text-align: right;">
■
</div>

## References

- [青空学園: 素数の定義](http://aozoragakuen.sakura.ne.jp/suuron/node17.html)
- [The PrimePages: prime number research & records](https://primes.utm.edu/)
- [素数定理の証明](http://aozoragakuen.sakura.ne.jp/suuron/node82.html)

> 関連ブログ記事

- [Ryo's Tech Blog: 数学的帰納法の原理](https://ryonakagami.github.io/2021/04/16/mathematical-induction/)