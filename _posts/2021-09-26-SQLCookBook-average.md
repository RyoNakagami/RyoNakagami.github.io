---
layout: post
title: "Standard SQL CookBook - 1/N"
subtitle: "Averageのとり方 - Weighted Average, Moving Average, Moving Weighted Average"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- SQL
---



||概要|
|---|---|
|目的|Averageのとり方 - Weighted Average, Moving Average, Moving Weighted Average|
|分類|SQL Cookbook|
|SQL|Standard SQL|
|環境|BigQuery|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題1: Weighted Averageの計算方法](#%E5%95%8F%E9%A1%8C1-weighted-average%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
- [問題2: Moving AverageとMoving Medianの計算方法](#%E5%95%8F%E9%A1%8C2-moving-average%E3%81%A8moving-median%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)
- [問題3: Moving Weighted Averageの計算方法](#%E5%95%8F%E9%A1%8C3-moving-weighted-average%E3%81%AE%E8%A8%88%E7%AE%97%E6%96%B9%E6%B3%95)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題1: Weighted Averageの計算方法

以下のようなデータ(X, Y, W)を考えたとき、Xの値ごとにYの加重平均を取りたいとします. WeightはWカラムの値とします

```sql
X	Y	W
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

> Data生成クエリ

```sql
WITH data AS (
  SELECT 
    [10, 10, 20, 20, 20, 20, 30, 30, 30,  30, 30, 40, 40, 40, 40, 50, 50, 50] AS X,
    [10, 20, 10, 20, 30, 40, 10, 20, 30,  40, 50, 20, 30, 40, 50, 30, 40, 50] AS Y,
    [60, 10, 10, 50, 50, 20, 10, 50, 100, 50, 10, 10, 30, 40, 20, 20, 20, 40] AS W
   )
SELECT
    X,
    COALESCE(Y[SAFE_OFFSET(offset)],  0) AS Y,
    COALESCE(W[SAFE_OFFSET(offset)],  0) AS W
FROM
    data,
    UNNEST(X) AS X WITH OFFSET AS offset
```

> Weighted Averageの計算

```sql
WITH data AS(
SELECT
    X,
    COALESCE(Y[SAFE_OFFSET(offset)],  0) AS Y,
    COALESCE(W[SAFE_OFFSET(offset)],  0) AS W
FROM
    (
        SELECT 
            [10, 10, 20, 20, 20, 20, 30, 30, 30,  30, 30, 40, 40, 40, 40, 50, 50, 50] AS X,
            [10, 20, 10, 20, 30, 40, 10, 20, 30,  40, 50, 20, 30, 40, 50, 30, 40, 50] AS Y,
            [60, 10, 10, 50, 50, 20, 10, 50, 100, 50, 10, 10, 30, 40, 20, 20, 20, 40] AS W
    ) AS input,
    UNNEST(X) AS X WITH OFFSET AS offset
)
SELECT
    X,
    AVG(Y) AS naive_mean_Y,
    SUM(Y * W)/SUM(W) AS weighted_mean_Y,
FROM
    data
GROUP BY
    X
ORDER BY 
    X
```

> 結果

```sql
X	naive_mean_Y	weighted_mean_Y
10	15.0	11.428571428571429
20	25.0	26.153846153846153
30	30.0	30.0
40	35.0	37.0
50	40.0	42.5

```

## 問題2: Moving AverageとMoving Medianの計算方法

(observe_date, Y)のレコードから構成されるデータを考えます. observe_dateは観測日, Yはその観測日に対応する確率変数とします. ここで、過去7日間ごとの移動平均と直近７日の中央値を計算したいとします.

> Data生成

```sql
WITH data AS (
  SELECT
    GENERATE_DATE_ARRAY(DATE('2020-10-01'), DATE('2021-09-30'), INTERVAL 1 DAY) AS time_index,
    GENERATE_ARRAY(1, 365, 1) AS Y
   )
SELECT
    observe_date,
    MOD(ABS(FARM_FINGERPRINT(CAST(Y[SAFE_OFFSET(offset)] AS STRING))), 100) AS Y
FROM
    data,
    UNNEST(time_index) AS observe_date WITH OFFSET AS offset
```

> Moving Averageの計算

```sql
CREATE TEMPORARY FUNCTION ARRAY_INT64_SORT(arr ARRAY<INT64>)
RETURNS ARRAY<INT64> AS ((
  SELECT ARRAY_AGG(x) FROM(
    SELECT x FROM UNNEST(arr) AS x ORDER BY x
  )
));

WITH 
    data AS (
        SELECT
            observe_date,
            MOD(ABS(FARM_FINGERPRINT(CAST(Y[SAFE_OFFSET(offset)] AS STRING))), 100) AS Y
        FROM
            (
                SELECT
                    GENERATE_DATE_ARRAY(DATE('2020-10-01'), DATE('2021-09-30'), INTERVAL 1 DAY) AS time_index,
                    GENERATE_ARRAY(1, 365, 1) AS Y
            ) AS raw_data,
            UNNEST(time_index) AS observe_date WITH OFFSET AS offset
    ),
    agg_data AS(
        SELECT
            observe_date,
            Y, 
            AVG(Y) OVER (ORDER BY observe_date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) AS weekly_moving_average,
            ARRAY_INT64_SORT(ARRAY_AGG(Y) OVER (ORDER BY observe_date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW)) AS weekly_array
        FROM
            data
    )
SELECT 
    observe_date,
    Y,
    weekly_moving_average,
    weekly_array[ORDINAL(CAST(CEIL(ARRAY_LENGTH(weekly_array)*0.5)AS INT64))] AS weekly_median,
    fhoffa.x.median(weekly_array) AS fhoffa_weekly_median
FROM
    agg_data
```

> `fohoffa.x.meadianの挙動`

```sql
SELECT 
    fhoffa.x.median([1,2,3]) median_1,
    fhoffa.x.median([1,2,3,4]) median_2,
    fhoffa.x.median([-10,2,3,4]) median_3,
    fhoffa.x.median([-10,2,3,1000]) median_4
```

THEN

```sql
median_1	median_2	median_3	median_4
2.0	2.5	2.5	2.5
```




## 問題3: Moving Weighted Averageの計算方法

問題２を少し改良して、分析データに新たにW(0~9のランダムのINT64)というカラムを追加します. このWの値をweightとして用いて、YについてのMoving averageを計算します.

> SQL

```sql
WITH 
    data AS (
        SELECT
            observe_date,
            MOD(ABS(FARM_FINGERPRINT(CAST(Y[SAFE_OFFSET(offset)] AS STRING))), 100) AS Y,
            MOD(ABS(FARM_FINGERPRINT(CAST(Y[SAFE_OFFSET(offset)] AS STRING))), 10) AS W
        FROM
            (
                SELECT
                    GENERATE_DATE_ARRAY(DATE('2020-10-01'), DATE('2021-09-30'), INTERVAL 1 DAY) AS time_index,
                    GENERATE_ARRAY(1, 365, 1) AS Y
            ) AS raw_data,
            UNNEST(time_index) AS observe_date WITH OFFSET AS offset
    )
SELECT
    observe_date,
    Y, 
    AVG(Y) OVER (ORDER BY observe_date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) AS weekly_moving_average,
    SUM(Y*W) OVER (ORDER BY observe_date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW)
        /
    SUM(W) OVER (ORDER BY observe_date ROWS BETWEEN 7 PRECEDING ANCURRENT ROW) AS weekly_weighted_moving_average
FROM
    data
```