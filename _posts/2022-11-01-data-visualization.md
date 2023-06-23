---
layout: post
title: "２つの時系列データの比較のためのPlot"
subtitle: "Story-telling with data 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-01-04
tags:

- Data visualization
- Python
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [作成したいもの](#%E4%BD%9C%E6%88%90%E3%81%97%E3%81%9F%E3%81%84%E3%82%82%E3%81%AE)
- [Rule：Be consistent in the time points you plot](#rulebe-consistent-in-the-time-points-you-plot)
- [Python Code](#python-code)
- [関数/Classの説明](#%E9%96%A2%E6%95%B0class%E3%81%AE%E8%AA%AC%E6%98%8E)
  - [`matplotlib.dates.date2num`](#matplotlibdatesdate2num)
  - [`matplotlib.dates.MonthLocator()`](#matplotlibdatesmonthlocator)
  - [`matplotlib.dates.DateFormatter`](#matplotlibdatesdateformatter)
- [Appendix: 6 Lessons about telling stories with data](#appendix-6-lessons-about-telling-stories-with-data)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 作成したいもの

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/2022-11-01-data-visualization-goal.png?raw=true">

## Rule：Be consistent in the time points you plot

- 時系列plotのx軸の粒度は統一されているべき(とある時点まで10年間隔である時点から1年間隔というものは粒度が揃っていない)


## Python Code

> 成果物

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/2022-11-01-data-visualization-try.png?raw=true">


> Code

```python
##------------------
## import
##------------------
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import matplotlib.dates as mdates

##------------------
## data generating
##------------------
np.random.seed(42)

mu = 150
std = 20
effect_pre = 10
effect_main = 30

start_month = '2021-01-01'
end_month   = '2021-12-01'
before_treatment_month = '2021-05-01'
treatment_actual_month = '2021-08-01'

## make columes
time_range = pd.date_range(start=start_month, end=end_month, freq='MS')
effect_array = np.where(time_range > before_treatment_month, effect_pre, 0)
effect_array = effect_array + np.where(time_range >= treatment_actual_month, effect_main, 0)

processed = np.int64(np.random.normal(mu, std, len(time_range)))
received  = np.int64(processed + effect_array)

df = pd.DataFrame({'month':time_range, 'received':received, 'processed':processed})

##------------------
## Plot
##------------------
## set conditions
scatter_range = df['month'] >= treatment_actual_month
scatter_df = df.loc[scatter_range]

## plot
fig, ax = plt.subplots(figsize=(10,6))

## lineplot
ax.plot(df.month, df.received, 
        color='gray',
        linewidth=3,  
        label='received')
ax.plot(df.month, df.processed,
        color='blue',
        linewidth=3,
        label='processed')

## add text
ax.scatter(scatter_df.month, scatter_df.received, color='gray')
ax.scatter(scatter_df.month, scatter_df.processed, color='blue')

for ind in scatter_df.index:
    ax.annotate(scatter_df['received'][ind], 
                xy=(mdates.date2num(scatter_df['month'][ind]), scatter_df['received'][ind]*1.03))
    ax.annotate(scatter_df['processed'][ind], 
                xy=(mdates.date2num(scatter_df['month'][ind]), scatter_df['processed'][ind]*0.9))           



## vline set
ax.vlines(x=pd.to_datetime(before_treatment_month), 
          ymin=0, ymax=250, 
          colors='gray')
ax.annotate('2 employees quit in May', 
            xy=(mdates.date2num(pd.to_datetime(before_treatment_month))-20, 260),
            fontweight='bold')

## cosmetic
ymin, ymax = ax.set_ylim(0,300)
ax.xaxis.set_major_locator(mdates.MonthLocator())
ax.xaxis.set_major_formatter(mdates.DateFormatter('%b'))
ax.set_xlabel('2021', loc='left')
ax.set_ylabel('Number of order processed')
ax.set_title('The processed order over time', 
              loc='left',
              fontsize=18)

plt.legend();
```

## 関数/Classの説明
### `matplotlib.dates.date2num`

> 機能:

- datetime objectsをMatplotlib datesへ変換する関数
- `rcParams["date.epoch"]`で設定された値が基準点(`default: '1970-01-01T00:00:00'`)
- 今回はdatetime objectのx座標を取得するために利用

> Parameters:

- `ddatetime.datetime` or `numpy.datetime64` or sequences of these

> Returns:

- float or sequence of floats

```python
print(matplotlib.dates.date2num(pd.to_datetime('1970-01-01')))
>>> 0.0

print(matplotlib.dates.date2num(pd.to_datetime('1990-01-01')))
>>> 7305.0
```

> Remarks:

- 基準点を変更したい場合は`matplotlib.dates.set_epoch(epoch)`で変更可能



### `matplotlib.dates.MonthLocator()`

> 機能:

- 利用可能な date tickersの一種
- ax.xaxis.set_major_locatorと組み合わせて, 月次 tickが設定可能


### `matplotlib.dates.DateFormatter`

> 機能:

- datetime objectsをMatplotlib datesへ変換する関数
- `rcParams["date.epoch"]`で設定された値が基準点(`default: '1970-01-01T00:00:00'`)
- 今回はdatetime objectのx座標を取得するために利用

> Parameters:

- fmt: str, strftime format string
- tz: str or tzinfo, default: rcParams["timezone"] (default: 'UTC')
- usetex: bool, default: rcParams["text.usetex"] (default: False)

> Remarks:strftime()のフォーマット

---|---
`%b`|Jan, Feb, …, Dec
`%B`|January, February, …, December 
`%w`|Weekday as a decimal number, where 0 is Sunday and 6 is Saturday
`%a`|Sun, Mon, …, Sat 
`%A`|Sunday, Monday, …, Saturday 

## Appendix: 6 Lessons about telling stories with data

1. Understand the context
2. Choose an appropriate visual display
3. Eliminate clutter
4. Focus attention where you want it
5. Think like a designer
6. Tell a story


## References

> R code

- [GitHub >  adamribaudo/storytelling-with-data-ggplot](https://github.com/adamribaudo/storytelling-with-data-ggplot)

> Python

- [strftime() and strptime() Format Codes](https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior)
- [Plotting time series in Matplotlib with month names (ex. January) and showing years beneath](https://stackoverflow.com/questions/67582913/plotting-time-series-in-matplotlib-with-month-names-ex-january-and-showing-ye)