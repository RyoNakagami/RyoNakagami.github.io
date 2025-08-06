---
layout: post
title: "Prove Pearson Correlation always between -1 and 1"
subtitle: "相関係数 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-12-08
tags:

- 統計
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Theorem: Pearson Correlation always between -1 and 1](#theorem-pearson-correlation-always-between--1-and-1)
  - [Proof: Cauchy-Schwarz Inequality](#proof-cauchy-schwarz-inequality)
  - [Proof: composition of random variables and Discriminant](#proof-composition-of-random-variables-and-discriminant)
  - [Proof: composition of random variables divided by their standard deviations](#proof-composition-of-random-variables-divided-by-their-standard-deviations)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Theorem: Pearson Correlation always between -1 and 1

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Pearson Correlation</ins></p>

Let $X$ and $Y$ be random variables and each of means are denoted by $\mu_x$ and $\mu_y$. 
Then, the pearson correlation of $X$ and $Y$, $\rho_{xy}$ is defined as follows:

$$
\rho_{xy} = \frac{Cov(X, Y)}{\sqrt{Var(X)Var(Y)}}
$$

</div>

This pearson correlation, $\rho_{xy}$, always fall between $-1$ and $1$.

### Proof: Cauchy-Schwarz Inequality

What we want to show is 

$$
|\rho_{xy}| \leq 1
$$

The above equation is equivalent to the followings:

$$
\begin{align*}
& |\rho_{xy}| \leq 1\\t_0X
& \Leftrightarrow \rho_{xy}^2 - 1 \leq 0\\
& \Leftrightarrow Cov(X, Y)^2 \leq Var(X)Var(Y)\\
&= \mathbb E[(X - \mu_x)(Y- \mu_y)]^2 \leq \mathbb E[(X - \mu_x)^2]\mathbb E[(Y- \mu_y)^2]
\end{align*}
$$

So it is sufficient to show the last equation holds.


Define the random variables, $\hat X$, $\hat Y$, and $Z$, such that


$$
\begin{align*}
\hat X &= X - \mu_x\\
\hat Y &= Y - \mu_y\\
Z &= (\hat X - a\hat Y)^2 \text{ where } \ \ a \text{ is a constant}
\end{align*}
$$

Then, for any value $a \in \mathbb R$

$$
\begin{align*}
0 \leq \mathbb E[Z] &= \mathbb E[(\hat X - a\hat Y)^2]\\
                    &= \mathbb E[\hat X^2] - 2a\mathbb E[\hat X\hat Y] + a^2\mathbb E[\hat Y^2]
\end{align*}
$$

Let us choose $a = \frac{\mathbb E[\hat X\hat Y]}{\mathbb E[\hat Y^2]}$. Then, 

$$
\begin{align*}
0 &\leq \mathbb E[\hat X^2] - 2\frac{\mathbb E[\hat X\hat Y]}{\mathbb E[\hat Y^2]}\mathbb E[\hat X\hat Y] + \frac{\mathbb E[\hat X\hat Y]^2}{\mathbb E[\hat Y^2]^2}\mathbb E[\hat Y^2]\\
  &= \mathbb E[\hat X^2] - \frac{\mathbb E[\hat X\hat Y]^2}{\mathbb E[\hat Y^2]}\\
  &\Rightarrow \mathbb E[\hat X\hat Y]^2 \leq \mathbb E[\hat X^2]\mathbb E[\hat Y^2]
\end{align*}
$$

Thus, we have the Cauchy-Schwarz inequality:

$$
\begin{align*}
&|\mathbb E[\hat X\hat Y]| \leq \sqrt{\mathbb E[\hat X^2]\mathbb E[\hat Y^2]}\\
&\Rightarrow \mathbb E[(X - \mu_x)(Y- \mu_y)]^2 \leq \mathbb E[(X - \mu_x)^2]\mathbb E[(Y- \mu_y)^2]
\end{align*}
$$

The above Cauchy-Schwarz inequality implies 

$$
|\rho_{xy}| \leq 1
$$

### Proof: composition of random variables and Discriminant

Define $t \in \mathbb R$. Then

$$
\begin{align*}
\text{Var}(tX + Y) &= t^2\text{Var}(X) + 2\text{Cov}(X, Y) + \text{Var}(Y)\\
                   &\geq 0
\end{align*}
$$

The discriminat of a quadratic equation w.r.t $t$ should be less than 0, i.e.,

$$
\begin{align*}
D &= \text{Cov}(X, Y)^2 - \text{Var}(X)\text{Var}(Y)\\
  &\leq 0
\end{align*}
$$

Then, we have

$$
\begin{align*}
&\frac{\text{Cov}(X, Y)^2 }{\text{Var}(X)\text{Var}(Y)} \leq 1\\[3pt]
&\Rightarrow \vert \rho_{xy}\vert^2 \leq 1\\[3pt]
&\Rightarrow -1 \leq \rho_{xy} \leq 1
\end{align*}
$$

From the above, we know that $\vert\rho_{xy}\vert = 1$ when the discriminat takes 0 and $\text{Var}(tX + Y)=0$. Therefore, there is a constant $b$ such that

$$
\begin{align*}
&t_0X +Y = b\\
&Y= -t_0X + b
\end{align*}
$$

So, when the two random variable can be expressed as a linear formula, the absolute value of pearson correlation takes 1.

### Proof: composition of random variables divided by their standard deviations

Let $\sigma_x, \sigma_y$ be the standard deviations of $X, Y$. Then, we have

$$
\begin{align*}
0 &\leq \text{Var}\bigg(\frac{X}{\sigma_x} \pm \frac{Y}{\sigma_y}\bigg)\\[3pt]
  &= \text{Var}\bigg(\frac{X}{\sigma_x}\bigg) \pm 2\text{Cov}\bigg(\frac{X}{\sigma_x},\frac{Y}{\sigma_y}\bigg) + \text{Var}\bigg(\frac{Y}{\sigma_y}\bigg)\\[3pt]
  &= \frac{1}{\sigma^2_x}\text{Var}(X) \pm \frac{2}{\sigma_x\sigma_y}\text{Cov}(X, Y) + \frac{1}{\sigma^2_y}\text{Var}(Y)\\[3pt]
  &= 2 \pm \frac{2}{\sigma_x\sigma_y}\text{Cov}(X, Y)\\[3pt]
  &= 2\pm 2 \rho_{xy}
\end{align*}
$$

Therefore,

$$
-1 \leq \rho_{xy} \leq 1
$$





References
--------------
- [The Book of Statistical Proofs > Proof: Correlation always falls between -1 and +1](https://statproofbook.github.io/P/corr-range.html)
