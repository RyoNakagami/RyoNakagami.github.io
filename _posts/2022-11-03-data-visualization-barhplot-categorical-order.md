---
layout: post
title: "Horizontal bar plot with categorical order specified"
subtitle: "Story-telling with data 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-01-10
tags:

- Data visualization
- Python
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is this post about?](#what-is-this-post-about)
  - [Rule](#rule)
  - [Common Problem](#common-problem)
  - [Goal](#goal)
- [Code in practice](#code-in-practice)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## What is this post about?
### Rule

- When designing any graph showing categorical data, be thoughful about how your categories are ordered.

### Common Problem

- Sometimes, the default alphabetical order does not make sense for your audiences.
- When your category represent the weekday, the order should be weekday order, not alphabetical order.
- How can we specify the categorical order with axis when plotting (here, horizontal-bar-plotting) the data

### Goal

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20221103_barhplot_01.png?raw=true">

## Code in practice

```python
## import
import pandas as pd
import matplotlib.pyplot as plt
from pandas.api.types import CategoricalDtype

## GDP
df = pd.DataFrame({
    'col1': ['Sun', 'Sat', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sun', 'Sat', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    'col2': [2, 1, 9, 8, 7, 4, 5, 8, 7, 4, 5, 8, 7, 4],
    'col3': [8, 7, 1, 1, 9, 0, 4, 9, 8, 9, 8, 7, 4, 9]})

## aggregation
df_agg = df.groupby('col1').agg({'col2':['mean', 'min', 'max'], 'col3':['mean', 'max']})
df_agg.columns = df_agg.columns.droplevel(1) + '_' + df_agg.columns.droplevel(0)
df_agg = df_agg.reset_index()

## specify the categorical order
weekday_order = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
weekday_type = CategoricalDtype(categories=weekday_order, ordered=True)
df_agg['col1'] = df_agg['col1'].astype(weekday_type)
df_agg.sort_values('col1', inplace=True)

## plot
fig, ax = plt.subplots()

ax.barh(df_agg.col1, df_agg.col2_mean, align='center')
ax.invert_yaxis()  # labels read top-to-bottom
ax.axvline(df['col2'].mean(), 
           ls='--',
           color='r')
ax.text(x=df['col2'].mean()*1.02, 
        y=5.5,
        s='- Metrics mean\n  accross weekday')
ax.set(xlim=[0, 10], xlabel='Metrics', ylabel='Weekday',
       title='barh plot example')
plt.show()
```


## References

- [Matplotlib > The Lifecycle of a Plot](https://matplotlib.org/stable/tutorials/introductory/lifecycle.html#sphx-glr-tutorials-introductory-lifecycle-py)