---
layout: post
title: "Standard SQL CookBook - 2/N"
subtitle: "複数カラムのmin, maxのとり方 - GREATEST, LEAST"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- SQL
- Python
- pandas
---



||概要|
|---|---|
|目的|複数カラムのmin, maxのとり方 - GREATEST, LEAST|
|分類|SQL Cookbook|
|SQL|Standard SQL|
|環境|BigQuery|


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定: 複数カラムに対するmin/max valueの計算方法](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A-%E8%A4%87%E6%95%B0%E3%82%AB%E3%83%A9%E3%83%A0%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8Bminmax-value%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
  - [SQL: LEAST/GREATEST function](#sql-leastgreatest-function)
  - [Python: pandas](#python-pandas)
  - [Python: numpy](#python-numpy)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## 問題設定: 複数カラムに対するmin/max valueの計算方法

以下のようなデータ(X, Y, Z)を考えたとき、(X, Y, Z)のうちもっとも小さい/大きい値を抽出したいとします

```raw
X	Y	Z
10	10	60
10	20	10
20	10	10
20	20	50
20	30	50
20	40	20
30	10	10
30	20	50
30	30	100
30	40	50
30	50	10
40	20	10
40	30	30
40	40	40
40	50	20
50	30	20
50	40	20
50	50	40
```

> Goal

```raw
10	10	60	10	60
10	20	10	10	20
20	10	10	10	20
20	20	50	20	50
20	30	50	20	50
20	40	20	20	40
30	10	10	10	30
30	20	50	20	50
30	30	100	30	100
30	40	50	30	50
30	50	10	10	50
40	20	10	10	40
40	30	30	30	40
40	40	40	40	40
40	50	20	20	50
50	30	20	20	50
50	40	20	20	50
50	50	40	40	50
```

### SQL: LEAST/GREATEST function

```sql
WITH data AS(
SELECT
    X,
    COALESCE(Y[SAFE_OFFSET(offset)],  0) AS Y,
    COALESCE(Z[SAFE_OFFSET(offset)],  0) AS Z
FROM
    (
        SELECT 
            [10, 10, 20, 20, 20, 20, 30, 30, 30,  30, 30, 40, 40, 40, 40, 50, 50, 50] AS X,
            [10, 20, 10, 20, 30, 40, 10, 20, 30,  40, 50, 20, 30, 40, 50, 30, 40, 50] AS Y,
            [60, 10, 10, 50, 50, 20, 10, 50, 100, 50, 10, 10, 30, 40, 20, 20, 20, 40] AS Z
    ) AS input,
    UNNEST(X) AS X WITH OFFSET AS offset
)
SELECT
    X,
    Y,
    Z,
    LEAST(X, Y, Z) AS minimum_value,
    GREATEST(X, Y, Z) AS max_value,
FROM
    data
```

### Python: pandas

```python
import pandas as pd

df = pd.DataFrame(
    {"X": [10, 10, 20, 20, 20, 20, 30, 30, 30, 30, 30, 40, 40, 40, 40, 50, 50, 50],
     "Y": [10, 20, 10, 20, 30, 40, 10, 20, 30, 40, 50, 20, 30, 40, 50, 30, 40, 50],
     "Z": [60, 10, 10, 50, 50, 20, 10, 50, 100, 50, 10, 10, 30, 40, 20, 20, 20, 40]}
     )

df['minimum_value'], df['max_value'] = df.min(axis = 1), df.max(axis = 1)
print(df)
```

### Python: numpy

```python
import pandas as pd
import numpy as np

df = pd.DataFrame(
    {"X": [10, 10, 20, 20, 20, 20, 30, 30, 30, 30, 30, 40, 40, 40, 40, 50, 50, 50],
     "Y": [10, 20, 10, 20, 30, 40, 10, 20, 30, 40, 50, 20, 30, 40, 50, 30, 40, 50],
     "Z": [60, 10, 10, 50, 50, 20, 10, 50, 100, 50, 10, 10, 30, 40, 20, 20, 20, 40]}
     ).values

min_array, max_array = np.amin(df, axis=1), np.amax(df, axis=1) 
result_array = np.column_stack([df, min_array, max_array])
print(result_array)
```
