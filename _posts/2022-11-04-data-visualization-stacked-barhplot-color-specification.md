---
layout: post
title: "Horizontal bar plot with categorical order specified"
subtitle: "Story-telling with data 4/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-01-12
tags:

- Data visualization
- Python
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is this post about?](#what-is-this-post-about)
  - [Rule](#rule)
  - [Problem](#problem)
  - [Goal](#goal)
- [Code in practice](#code-in-practice)
  - [Base line](#base-line)
  - [pandas.DataFrame](#pandasdataframe)
- [Appendix: Type of Palette](#appendix-type-of-palette)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## What is this post about?
### Rule

- When creating a stacked bar chart, the choice of color palette to assign to each categorical level should matche the meaning of each categories
- The way of color assignment must align with the color taste of other team document

### Problem

- The default color palette might not suite your color taste, although they provide several options
- You want to specift the color sequence, which is not provided by the matplotlib color palette list

### Goal

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20221104_color_specification_goal.png?raw=true">


## Code in practice
### Base line

```python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


category_names = ['Strongly disagree', 'Disagree',
                  'Neither agree nor disagree', 'Agree', 'Strongly agree']
results = {
    'Question 1': [10, 15, 17, 32, 26],
    'Question 2': [26, 22, 29, 10, 13],
    'Question 3': [35, 37, 9, 5, 14],
    'Question 4': [32, 11, 9, 15, 33],
    'Question 5': [21, 29, 5, 5, 40],
    'Question 6': [8, 19, 5, 30, 38]
}

def custom_div_cmap(numcolors=4, name='custom_div_cmap',
                    mincol='dimgray', midcol='white', maxcol='navy'):
    """ Create a custom diverging colormap with three colors
    
    Default is blue to white to red with 11 colors.  Colors can be specified
    in any way understandable by matplotlib.colors.ColorConverter.to_rgb()
    """

    from matplotlib.colors import LinearSegmentedColormap 
    
    cmap = LinearSegmentedColormap.from_list(name=name, 
                                             colors =[mincol, midcol, maxcol],
                                             N=numcolors)
    return cmap
    
def survey(results, category_names):
    """
    Parameters
    ----------
    results : dict
        A mapping from question labels to a list of answers per category.
        It is assumed all lists contain the same number of entries and that
        it matches the length of *category_names*.
    category_names : list of str
        The category labels.r
    """
    labels = list(results.keys())
    data = np.array(list(results.values()))
    data_cum = data.cumsum(axis=1)

    custom_map = custom_div_cmap(data.shape[1], mincol='dimgray', midcol='0.8' ,maxcol='navy')
    category_colors = custom_map(np.linspace(0, 1, data.shape[1]))

    fig, ax = plt.subplots(figsize=(9.2, 5))
    ax.invert_yaxis()
    ax.set_xlim(0, np.sum(data, axis=1).max())

    for i, (colname, color) in enumerate(zip(category_names, category_colors)):
        widths = data[:, i]
        starts = data_cum[:, i] - widths
        rects = ax.barh(labels, widths, left=starts, height=0.5,
                        label=colname, color=color)
        r, g, b, _ = color
        text_color = 'white' if r * g * b < 0.5 else 'darkgrey'
        ax.bar_label(rects, fmt='%.0f%%', label_type='center', color='w')
    ax.legend(title='Survey Results', edgecolor='white', 
              ncol=len(category_names), bbox_to_anchor=(0, 1),
              loc='lower left', fontsize='small')
    ax.get_legend()._legend_box.align = "left"

    # Despine
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    ax.spines['left'].set_visible(False)
    ax.spines['bottom'].set_visible(True)

    return fig, ax


survey(results, category_names)
plt.show()
```

### pandas.DataFrame

> Data

```python
category_names = ['Strongly disagree', 'Disagree',
                  'Neither agree nor disagree', 'Agree', 'Strongly agree']
results = {
    'Question 1': [10, 15, 17, 32, 26],
    'Question 2': [26, 22, 29, 10, 13],
    'Question 3': [35, 37, 9, 5, 14],
    'Question 4': [32, 11, 9, 15, 33],
    'Question 5': [21, 29, 5, 5, 40],
    'Question 6': [8, 19, 5, 30, 38]
}


df = pd.DataFrame(results).T
df.columns = category_names
df.head(6)
```

     |Strongly disagree|Disagree|Neither agree nor disagree|Agree|Strongly agree
---|---|---|---|---|---
Question 1| 10|15|17|32|26
Question 2| 26|22|29|10|13
Question 3| 35|37|9|5|14
Question 4| 32|11|9|15|33
Question 5| 21|29|5|5|40
Question 6| 8|19|5|30|38


> Code

```python

def custom_div_cmap(numcolors=4, name='custom_div_cmap',
                    mincol='dimgray', midcol='white', maxcol='navy'):
    """ Create a custom diverging colormap with three colors
    
    Default is blue to white to red with 11 colors.  Colors can be specified
    in any way understandable by matplotlib.colors.ColorConverter.to_rgb()
    """

    from matplotlib.colors import LinearSegmentedColormap 
    
    cmap = LinearSegmentedColormap.from_list(name=name, 
                                             colors =[mincol, midcol, maxcol],
                                             N=numcolors)
    return cmap


fig, ax = plt.subplots(figsize=(9.2, 5))

ax.set_xlim(0, 100)

custom_map = custom_div_cmap(df.shape[1], mincol='dimgray', midcol='0.8' ,maxcol='navy')
category_colors = custom_map(np.linspace(0, 1, df.shape[1]))

df.plot.barh(stacked=True, ax=ax, color=category_colors)

for container in ax.containers:
    ax.bar_label(container, fmt='%.0f%%', label_type='center', color='w')

ax.legend(title='Survey Results',
          ncol=df.shape[1], bbox_to_anchor=(0, 1),
          edgecolor='white', 
          loc='lower left', fontsize='small')
ax.get_legend()._legend_box.align = "left"
ax.invert_yaxis()

# Despine
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)
ax.spines['left'].set_visible(False)
ax.spines['bottom'].set_visible(True)
```


## Appendix: Type of Palette

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20221104_color_specification_palette.png?raw=true">



## References

- [CHARTIO > A Complete Guide to Stacked Bar Charts](https://chartio.com/learn/charts/stacked-bar-chart-complete-guide/)