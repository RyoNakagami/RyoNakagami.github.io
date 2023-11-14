---
layout: post
title: "Scatterplot"
subtitle: "Story-telling with data 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-01-10
tags:

- Data visualization
- Python
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [成果物](#%E6%88%90%E6%9E%9C%E7%89%A9)
- [Code](#code)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## 成果物

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20221102_scatterplot.png?raw=true">

## Code


```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

## DGP
N = 100
mu = 2500
std = 250
np.random.seed(42)

X = np.random.normal(mu, std, N)
error = np.random.normal(0, 0.05, N)
Y = (X - 2500)**2 / 500000 + 1.5 + error

## plot

fig, axes = plt.subplots(1, 2, figsize=(16, 4))

## before
axes[0].set_title('Cost per mile by miles driven',
                  loc='left',
                  fontsize=15)
axes[0].set_xlabel('Miles driven per month', loc='left')
axes[0].set_ylabel('Cost per mile ($)')
axes[0].scatter(np.mean(X), np.mean(Y), c='black', s=50)
axes[0].scatter(X, Y)
axes[0].annotate('AVG', 
                 xy=(np.mean(X)*0.99, np.mean(Y)*1.02),
                 fontweight='bold')

## after
above_avg_index = Y > np.mean(Y)


axes[1].set_title('Cost per mile by miles driven',
                  loc='left',
                  fontsize=15)
axes[1].set_xlabel('Miles driven per month', loc='left')
axes[1].set_ylabel('Cost per mile ($)')
axes[1].scatter(np.mean(X), np.mean(Y), c='black', s=50)
axes[1].hlines(y=np.mean(Y),
               xmin=1800, xmax=3000,
               linestyles='dashed',
               colors='black'
               )
axes[1].scatter(X[above_avg_index], Y[above_avg_index], c='orange')
axes[1].scatter(X[~above_avg_index], Y[~above_avg_index])
axes[1].annotate('AVG', 
                 xy=(np.mean(X)*0.99, np.mean(Y)*1.02),
                 fontweight='bold',
                 c='black');


```
