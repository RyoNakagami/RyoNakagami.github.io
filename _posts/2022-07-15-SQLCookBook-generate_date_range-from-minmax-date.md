---
layout: post
title: "Standard SQL CookBook - 5/N"
subtitle: "ユーザーごとの開始日, 終了日が記録されたレコードから開始日から終了日までのDate sequenceを作成する"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-08-01
purpose: 
tags:

- SQL
- Python
- 前処理
---

||概要|
|---|---|
|目的|ユーザーごとの開始日, 終了日が記録されたレコードから開始日から終了日までのDate sequenceを作成する|
|分類|SQL Cookbook|
|SQL|Standard SQL|
|環境|BigQuery|


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [SQL実行例の紹介](#sql%E5%AE%9F%E8%A1%8C%E4%BE%8B%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [Python実行例の紹介](#python%E5%AE%9F%E8%A1%8C%E4%BE%8B%E3%81%AE%E7%B4%B9%E4%BB%8B)
- [References](#references)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題設定

(user_id, 開始日, 終了日)のレコードからなるデータが以下のように与えられたとします.

```
(1,'2020-09-01','2020-11-01'),
(2,'2020-09-01','2021-01-01'),
(3,'2020-10-01','2021-02-01'),
(4,'2020-11-01','2021-01-01')
```

このとき,以下のようにユーザーごとに開始日から終了日までの１ヶ月ごとのDate sequenceを作成したいとします.

user_id|observed_month
---|---
1|2020-09-01
1|2020-10-01
1|2020-11-01
2|2020-09-01
2|2020-10-01
2|2020-11-01
2|2020-12-01
2|2021-01-01
3|2020-10-01
3|2020-11-01
3|2020-12-01
3|2021-01-01
3|2021-02-01
4|2020-11-01
4|2020-12-01
4|2021-01-01

### SQL実行例の紹介

```sql
WITH 
    raw_data AS(
    SELECT
        * 
    FROM UNNEST([STRUCT<user_id INT64, min_date DATE, max_date DATE>
                (1,'2020-09-01','2020-11-01'),
                (2,'2020-09-01','2021-01-01'),
                (3,'2020-10-01','2021-02-01'),
                (4,'2020-11-01','2021-01-01')
                ])     
    ),
    user_date_table AS(
    SELECT
        user_id,
        GENERATE_DATE_ARRAY(min_date, max_date, INTERVAL 1 MONTH) AS date_range
    FROM
        raw_data
    )
SELECT
  user_id,
  date_range_parsed AS observed_month
FROM
    user_date_table,
    UNNEST(date_range) AS date_range_parsed
```

`UNNEST`のなかでarrayを作成し,explodeするという観点から以下のクエリも実行可能です(Special Thanks to SGSKさん)

```sql
WITH 
    raw_data AS(
    SELECT
        * 
    FROM UNNEST([STRUCT<user_id INT64, min_date DATE, max_date DATE>
                (1,'2020-09-01','2020-11-01'),
                (2,'2020-09-01','2021-01-01'),
                (3,'2020-10-01','2021-02-01'),
                (4,'2020-11-01','2021-01-01')
                ])     
    )
SELECT
    user_id,
    date_range_parsed AS observed_month
FROM
    raw_data,
    UNNEST(GENERATE_DATE_ARRAY(min_date, max_date, INTERVAL 1 MONTH)) AS date_range_parsed
```

### Python実行例の紹介

> パターン1: `.apply(pd.Series).stack()`を活用

```python
## import
import pandas as pd

## Data作成
col_names = ['user_id', 'min_date', 'max_date']
record = [(1,'2020-09-01','2020-11-01'),
          (2,'2020-09-01','2021-01-01'),
          (3,'2020-10-01','2021-02-01'),
          (4,'2020-11-01','2021-01-01')]

df = pd.DataFrame(record, columns=col_names)

## ユーザーごとのDate sequence作成
df['date_range'] = df.loc[:, ['min_date','max_date']].apply(
                    lambda x:pd.date_range(x.min_date, x.max_date , freq='MS'),
                    axis=1
                    )
res = df.set_index(['user_id'])['date_range'].apply(pd.Series).stack()
res = res.reset_index(level=0)
res.columns = ['user_id','observed_month']
res
```

> パターン2: `pd.Dataframe().explode()`を活用

```python
## import
import pandas as pd

## Data作成
col_names = ['user_id', 'min_date', 'max_date']
record = [(1,'2020-09-01','2020-11-01'),
          (2,'2020-09-01','2021-01-01'),
          (3,'2020-10-01','2021-02-01'),
          (4,'2020-11-01','2021-01-01')]

df = pd.DataFrame(record, columns=col_names)

## ユーザーごとのDate sequence作成
df['date_range'] = df.loc[:, ['min_date','max_date']].apply(
                    lambda x:pd.date_range(x.min_date, x.max_date , freq='MS'),
                    axis=1
                    )
df.explode('date_range').reset_index(drop=True)
```

Then,

```
	user_id	min_date	max_date	date_range
0	1	2020-09-01	2020-11-01	2020-09-01
1	1	2020-09-01	2020-11-01	2020-10-01
2	1	2020-09-01	2020-11-01	2020-11-01
3	2	2020-09-01	2021-01-01	2020-09-01
4	2	2020-09-01	2021-01-01	2020-10-01
5	2	2020-09-01	2021-01-01	2020-11-01
6	2	2020-09-01	2021-01-01	2020-12-01
7	2	2020-09-01	2021-01-01	2021-01-01
8	3	2020-10-01	2021-02-01	2020-10-01
9	3	2020-10-01	2021-02-01	2020-11-01
10	3	2020-10-01	2021-02-01	2020-12-01
11	3	2020-10-01	2021-02-01	2021-01-01
12	3	2020-10-01	2021-02-01	2021-02-01
13	4	2020-11-01	2021-01-01	2020-11-01
14	4	2020-11-01	2021-01-01	2020-12-01
15	4	2020-11-01	2021-01-01	2021-01-01
```



## References
### オンラインマテリアル

- [stackoverflow > Pandas column of lists, create a row for each list element](https://stackoverflow.com/questions/27263805/pandas-column-of-lists-create-a-row-for-each-list-element)