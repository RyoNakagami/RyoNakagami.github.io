---
layout: post
title: "Regressor and Regressand"
subtitle: "統計用語 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-09-28
tags:

- English
- 統計
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Regressor vs Regressand](#regressor-vs-regressand)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## Regressor vs Regressand

Regressor and Regressand are terms used to describe different variables in a regression analysis.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Regressor</ins></p>

A **regressor**, also known as an **independent variable**, **explanatory variable**, 
**covairiates**, or **predictor variable**, is a variable that is used to predict 
or explain the variation in another variable. 

It is the variable that is being used to model or predict the value of the 
dependent variable (the regressand).

</div>

Regressors are typically the variables that you believe have an influence on the dependent variable. 
They are manipulated or controlled in the analysis to study how changes in their values affect the outcome.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Regressand</ins></p>

The **regressand**, also known as the **dependent variable**, **response variable**, or 
the **variable being predicted**, is the variable you are trying to understand, predict, or explain. 

It is the variable that you are interested in studying and for which you seek to find relationships with the regressors.

</div>

The regressand is the outcome or result that you are trying to model based on the changes 
or variations in the regressors. The goal is to determine how changes in the regressors affect the value of the regressand.

Suppose you have a following regression model

$$
y_i = f(x_i) + \epsilon_i
$$

- $y_i$: the dependent variable, often referred to as the "regressand." 
- $x_i$: the independent variable, typically called the "regressor." 


References
-----------

- [Econometric Analysis of Cross Section and Panel Data, Second Edition](https://mitpress.mit.edu/9780262232586/)
