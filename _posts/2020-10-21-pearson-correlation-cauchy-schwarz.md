---
layout: post
title: "Prove Pearson Correlation always between -1 and 1"
subtitle: "Cauchy-Schwarz Inequality Proof"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 
tags:

- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


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
& |\rho_{xy}| \leq 1\\
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
0 \leq \mathbb E[W] &= \mathbb E[(\hat X - a\hat Y)^2]\\
                    &= \mathbb E[\hat X^2] - 2a\mathbb E[\hat X\hat Y] + a^2\mathbb E[\hat Y^2]
\end{align*}
$$

Let us choose $a = \frac{\mathbb E[\hat X\hat Y]}{\mathbb E[\hat Y^2]}$. Then, 

$$
\begin{align*}
0 &\leq \mathbb E[\hat X^2] - 2\frac{\mathbb E[\hat X\hat Y]}{\mathbb E[\hat Y^2]}\mathbb E[\hat X\hat Y] + \frac{\mathbb E[\hat X\hat Y]^2}{\mathbb E[\hat Y^2]^2}\mathbb E[\hat Y^2]\\
  &= \mathbb E[\hat \hat X^2] - \frac{\mathbb E[\hat X\hat Y]^2}{\mathbb E[\hat Y^2]}\\
  &\Rightarrow \mathbb E[\hat X\hat Y]^2 \leq \mathbb E[\hat X^2]\mathbb E[\hat Y^2]
\end{align*}
$$

Thus, we have the Cauchy-Schwarz inequality:

$$
\begin{align*}
&|E\hat X\hat Y| \leq \sqrt{E[\hat X^2] E[\hat Y^2]}\\
&\Rightarrow \mathbb E[(X - \mu_x)(Y- \mu_y)]^2 \leq \mathbb E[(X - \mu_x)^2]\mathbb E[(Y- \mu_y)^2]
\end{align*}
$$

The above Cauchy-Schwarz inequality implies 

$$
|\rho_{xy}| \leq 1
$$