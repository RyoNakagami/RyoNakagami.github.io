---
layout: post
title: "Standard SQL CookBook - 3/N"
subtitle: "RCTにおけるunit of observationのsampling - Farm Fingerprint"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-07-20
purpose: 
tags:

- SQL
- Python
- Farm Fingerprint
---


||概要|
|---|---|
|目的|RCTにおけるunit of observationのsampling - Farm Fingerprint|
|分類|SQL Cookbook|
|SQL|Standard SQL|
|環境|BigQuery|


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定:](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
- [Farm Fingerprint](#farm-fingerprint)
  - [(1) Farm Fingerprintはsaltさえランダムに選べば離散一様分布になるのか？](#1-farm-fingerprint%E3%81%AFsalt%E3%81%95%E3%81%88%E3%83%A9%E3%83%B3%E3%83%80%E3%83%A0%E3%81%AB%E9%81%B8%E3%81%B9%E3%81%B0%E9%9B%A2%E6%95%A3%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AB%E3%81%AA%E3%82%8B%E3%81%AE%E3%81%8B)
  - [(2) Farm Fingerprintはsaltさえランダムに選べば離散一様分布になるのか？:簡易版](#2-farm-fingerprint%E3%81%AFsalt%E3%81%95%E3%81%88%E3%83%A9%E3%83%B3%E3%83%80%E3%83%A0%E3%81%AB%E9%81%B8%E3%81%B9%E3%81%B0%E9%9B%A2%E6%95%A3%E4%B8%80%E6%A7%98%E5%88%86%E5%B8%83%E3%81%AB%E3%81%AA%E3%82%8B%E3%81%AE%E3%81%8B%E7%B0%A1%E6%98%93%E7%89%88)
- [Standard SQLで実装](#standard-sql%E3%81%A7%E5%AE%9F%E8%A3%85)
- [参考資料](#%E5%8F%82%E8%80%83%E8%B3%87%E6%96%99)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題設定: 

以下のような顧客マスタが与えられたとします.

- `customer_id`:顧客ID, ユニークに割り振られている, 100万人程度登録されているとします, INT64
- `created_timestamp_jst`: 顧客ID作成時点のtimestamp
- `birth_month`: 顧客が入力した誕生月, NaNはないものとする, STRING

```
customer_id	created_timestamp	birth_month
3207193037871	2022-08-18 03:31:02	00
3110943233023	2022-07-08 23:55:30	01
3114655870191	2022-07-09 03:29:23	01
3096080323583	2022-07-08 11:03:10	01
3096393819039	2022-07-08 11:19:01	01
...
```

この顧客マスターから、顧客ID単位で５つのグループ(A, B, C, D, E)にランダムに分けたいとします.
なおグループ分けにあたって, A, B, C, Dのサンプルサイズは 24,000 とし、さらにこのグループ内部では`birth_month`毎に2000人ずつ確保されている状態を目指します.
A, B, C, Dに振り分けられなかった顧客IDはすべてグループEに振り分けられるものとします.

この記事ではGoogle Farm Fingerprintの値の順序を用いたランダムサンプリングを紹介します.

## Farm Fingerprint

オープンソースの FarmHash ライブラリの Fingerprint64 関数を使用して、 STRING または BYTES 入力のフィンガープリントを計算します.
特定の入力に対するこの関数の出力は、決して変わらないという特徴があります (= ランダムサンプリング時には、何かしらのSaltを用いる必要がある).

> FARM_FINGERPRINT function Syntax

```sql
FARM_FINGERPRINT(value) 
```

> Return Value type

```
INT64
```

> Example

```sql
WITH example AS (
  SELECT 1 AS x, "foo" AS y, true AS z UNION ALL
  SELECT 2 AS x, "apple" AS y, false AS z UNION ALL
  SELECT 3 AS x, "" AS y, true AS z UNION ALL
  SELECT 4 AS x, "" AS y, false AS z
)
SELECT
  *,
  FARM_FINGERPRINT(CAST(x AS STRING)) AS x_fingerprint,
  FARM_FINGERPRINT(y) AS y_fingerprint,
  FARM_FINGERPRINT(CAST(z AS STRING)) AS z_fingerprint,
  FARM_FINGERPRINT(CONCAT(CAST(x AS STRING), y, CAST(z AS STRING))) AS concat_fingerprint
FROM example;
```

Then,

```
Row x	y	z	x_fingerprint	y_fingerprint	z_fingerprint	row_fingerprint
1	foo	true	-9142586270102516767	6150913649986995171	8572766038233537570	-1541654101129638711
2	apple	false	6920640749119438759	6447335267136888601	3372626016653902757	2794438866806483259
3		true	-6455268178307048695	-7286425919675154353	8572766038233537570	-4880158226897771312
4		false	-3919889686402291073	-7286425919675154353	3372626016653902757	-5671577889189715922
```

### (1) Farm Fingerprintはsaltさえランダムに選べば離散一様分布になるのか？

> 検証内容

- Google Farmfingerprintの値の順序を用いてsortした場合、そのsortのindex順序は離散一様分布しているのか？を検証します
- Google Farmfingerprintの値自体が離散一様分布しているかは検証していません

> 検証方針

1. 任意の長さのunique valueからなるリストを作成する(計算資源の兼ね合いで今回は長さ6としている)
2. (1)で作成したリストに対して、ランダムに作成したsaltと合わせてFarm Fingerprint valueを計算する
3. Farm Fingerprint valueの順序に基づいて、リストをシャッフルする
4. リストのシャッフル結果が、離散一様分布しているかchi square testにかける

> Remarks

- 重複ありの場合のPermutation Indexの取得方法として[stack overflow > Finding the index of a given permutation](https://stackoverflow.com/questions/14013373/finding-the-index-of-a-given-permutation)が存在する
- こちらベースで一部修正して計算も試みたが、メモリエラーが発生したので今回は諦めます（実行時間もそんなに変わらなかった）


> Python code

```python
#  Imports
## basics
import numpy as np
import matplotlib.pyplot as plt
import math
import random
import string
import seaborn as sns

## statistical analysis
from scipy import stats

## hash
import farmhash

## for cyclic list
from typing import List

# Class definition
class RandomShuffleTest:
    def __init__(self, ar, num_trial:int, salt_length:int=12, kind='farm_fingerprint'):
        # initialize
        self.ar          = ar
        self.num_trial   = num_trial
        self.salt_length = salt_length
        self.kind        = kind

        self.sorted_key = None
        self.result_salt = None
        self.freq = None

    def get_random_salt(self):
        # choose from all lowercase letter
        letters = string.ascii_lowercase
        self.result_salt = ''.join(random.choice(letters) for i in range(self.salt_length))

    def fit(self, output=False):
        n_perm = math.factorial(self.ar.length) if self.kind == 'naive_slide' else math.factorial(len(self.ar))
        trials = self.num_trial * n_perm
        freq = [0] * n_perm

        for _ in range(trials):
            if self.kind == 'farm_fingerprint':
              self.get_random_salt()
              self.farm_fingerprint_shuffle(ar=self.ar, salt=self.result_salt)
            
            elif self.kind == 'naive_slide':
              offset = _ % (self.ar.length - 1)
              self.sorted_key = self.ar.extract(offset=offset, width=self.ar.length)
            
            else:
              self.sorted_key = np.argsort(np.random.rand(len(self.ar)))
            
            freq[self.get_permutation_index(self.sorted_key)] += 1

        self.freq = freq


    def farm_fingerprint_shuffle(self, ar, salt):
        self.sorted_key = list(map(lambda x:abs(self.google_farm_fingerprint(x=x,salt=salt)), ar))

    @staticmethod
    def google_farm_fingerprint(x: str, salt:str):
        ### BigQuery version returns int64, while Python version returns unsigned int
        ### value must be between -9223372036854775808 and 9223372036854775807
        return np.uint64(farmhash.fingerprint64(x+salt)).astype('int64')

    @staticmethod
    def get_permutation_index(permutation):
        n = len(permutation)
        t = 0
        for i in range(n):
          t = t * (n - i)
          for j in range(i + 1, n):
            if permutation[i] > permutation[j]:
                t += 1
        return t

class CyclicList(object):

    def __init__(self, *, item: List[int]):
        self.item = item
        self.length: int = len(item)

    def extract(self, *, offset: int, width: int) -> List[int]:
        top: int = offset % self.length
        result: List[int] = self.item[top:top + width]
        length: int = len(result)

        while length < width:
            plus: List[int] = self.item[:width - length]
            result += plus
            length += len(plus)

        return result

# 検証
random.seed(100)
N= 2000
ar = list(range(6))
#cyclic_ar = CyclicList(item=ar)
#Knuth_test = RandomShuffleTest(ar=cyclic_ar,num_trial=N,kind='naive_slide')
Knuth_test = RandomShuffleTest(ar=list(map(str,ar)),num_trial=N)
#Knuth_test = RandomShuffleTest(ar=list(map(str,ar)),num_trial=N, kind='random')

Knuth_test.fit()
freq = Knuth_test.freq

ax = sns.displot(freq, kind="kde")
print(stats.chisquare(freq, f_exp=[N]*len(freq)))
```

Then,

```
Power_divergenceResult(statistic=697.7860000000001, pvalue=0.7079480282766375)
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210713-GoogleFarmFingerprint_test.png?raw=true">

- Permutation index結果をplotしてもトライアル回数(N=2000)が最頻値となっており、特定の順序が出やすいというわけではなさそう
- Chi square testでも帰無仮説は棄却されていない

### (2) Farm Fingerprintはsaltさえランダムに選べば離散一様分布になるのか？:簡易版

以下ではIDのpercentileとIDに対してfarm fingerprintを当てた値のpercentileの組を取得して、chi square testを実施する方法となります.

```sql
%%bigquery df --project <your project-id>
create temp function max_const() AS(
      100000000000
    );

create temp function bucket_const() AS(
      100000
    );

WITH
    test_data AS(
        SELECT 
            x AS key_id, 
            FARM_FINGERPRINT(CAST(x AS STRING)) hash_value
        FROM 
            UNNEST((SELECT GENERATE_ARRAY(1,max_const(),bucket_const()) xs)) AS x
    )
SELECT DISTINCT
    CAST(CEIL(key_id/(max_const()/100)) AS INT64) AS nth_tile_key,
    CAST(CEIL(hash_value/(9223372036854775807/50))+50 AS INT64) AS nth_tile_hash,
    COUNT(DISTINCT key_id) AS frequency --- the extepected value should be 100
FROM
    test_data
GROUP BY 
    1, 2
ORDER BY
    1, 2

```

Then,

```python
freq = df['frequency'].values
print(stats.chisquare(freq, f_exp=[100]*len(freq)))

>>> Power_divergenceResult(statistic=9808.0, pvalue=0.9122301443605709)
```


## Standard SQLで実装

```sql
CREATE TEMP FUNCTION rand_range(min_value INT64, max_value INT64) AS (
  CAST(ROUND(min_value + rand() * (max_value - min_value)) AS INT64)
);

CREATE TEMP FUNCTION rand_date(min_date DATE,max_date DATE) AS ( 
  TIMESTAMP_SECONDS(
    rand_range(UNIX_SECONDS(CAST(min_date AS TIMESTAMP)), UNIX_SECONDS(CAST(max_date AS TIMESTAMP)))
  ) 
);

CREATE TEMP FUNCTION assign_group(lottery_value INT64) AS ( 
  CASE
      WHEN lottery_value BETWEEN 0001 AND 2000 THEN 'A'
      WHEN lottery_value BETWEEN 2001 AND 4000 THEN 'B'
      WHEN lottery_value BETWEEN 4001 AND 6000 THEN 'C'
      WHEN lottery_value BETWEEN 6001 AND 8000 THEN 'D'
      ELSE 'E'
  END 
);


WITH
    test_data AS(
        SELECT 
            CAST(x AS STRING) AS user_id, 
            rand_date("2020-01-01", "2020-12-31") AS created_timestamp,
            RIGHT(CONCAT('0', CAST(fhoffa.x.random_int(1,13) AS STRING)), 2) AS birth_month
        FROM 
            UNNEST((SELECT GENERATE_ARRAY(1000001,2000000,1) xs)) AS x
    ),
    lottery AS(
        SELECT
            t1.user_id,
            t1.created_timestamp,
            t1.birth_month,
            FARM_FINGERPRINT(user_id) AS fingerprint_value,
            ROW_NUMBER() OVER (PARTITION BY birth_month ORDER BY FARM_FINGERPRINT(user_id)) AS lottery_number
        FROM
            test_data AS t1
    )
SELECT
    t1.user_id,
    t1.created_timestamp,
    t1.birth_month,
    assign_group(t1.lottery_number) AS test_group
FROM
    lottery AS t1
```

これを上手く分けられているか確認したい場合は

```sql
CREATE TEMP FUNCTION rand_range(min_value INT64, max_value INT64) AS (
  CAST(ROUND(min_value + rand() * (max_value - min_value)) AS INT64)
);

CREATE TEMP FUNCTION rand_date(min_date DATE,max_date DATE) AS ( 
  TIMESTAMP_SECONDS(
    rand_range(UNIX_SECONDS(CAST(min_date AS TIMESTAMP)), UNIX_SECONDS(CAST(max_date AS TIMESTAMP)))
  ) 
);

CREATE TEMP FUNCTION assign_group(lottery_value INT64) AS ( 
  CASE
      WHEN lottery_value BETWEEN 0001 AND 2000 THEN 'A'
      WHEN lottery_value BETWEEN 2001 AND 4000 THEN 'B'
      WHEN lottery_value BETWEEN 4001 AND 6000 THEN 'C'
      WHEN lottery_value BETWEEN 6001 AND 8000 THEN 'D'
      ELSE 'E'
  END 
);


WITH
    test_data AS(
        SELECT 
            CAST(x AS STRING) AS user_id, 
            rand_date("2020-01-01", "2020-12-31") AS created_timestamp,
            RIGHT(CONCAT('0', CAST(fhoffa.x.random_int(1,13) AS STRING)), 2) AS birth_month
        FROM 
            UNNEST((SELECT GENERATE_ARRAY(1000001,2000000,1) xs)) AS x
    ),
    lottery AS(
        SELECT
            t1.user_id,
            t1.created_timestamp,
            t1.birth_month,
            FARM_FINGERPRINT(user_id) AS fingerprint_value,
            ROW_NUMBER() OVER (PARTITION BY birth_month ORDER BY FARM_FINGERPRINT(user_id)) AS lottery_number
        FROM
            test_data AS t1
    ),
    group_table AS(
        SELECT
            t1.user_id,
            t1.created_timestamp,
            t1.birth_month,
            assign_group(t1.lottery_number) AS test_group
        FROM
            lottery AS t1
    )
SELECT
    test_group,
    birth_month,
    COUNT(DISTINCT user_id) AS user_cnt
FROM
    group_table
GROUP BY
    1, 2
ORDER BY
    1, 2
```

Then,

```
test_group	birth_month	user_cnt
A	01	2000
A	02	2000
A	03	2000
A	04	2000
A	05	2000
A	06	2000
A	07	2000
A	08	2000
A	09	2000
A	10	2000
A	11	2000
A	12	2000
B	01	2000
B	02	2000
B	03	2000
B	04	2000
B	05	2000
B	06	2000
B	07	2000
B	08	2000
B	09	2000
B	10	2000
B	11	2000
B	12	2000
C	01	2000
C	02	2000
C	03	2000
C	04	2000
C	05	2000
C	06	2000
C	07	2000
C	08	2000
C	09	2000
C	10	2000
C	11	2000
C	12	2000
D	01	2000
D	02	2000
D	03	2000
D	04	2000
D	05	2000
D	06	2000
D	07	2000
D	08	2000
D	09	2000
D	10	2000
D	11	2000
D	12	2000
E	01	75459
E	02	74957
E	03	75219
E	04	75066
E	05	75470
E	06	75300
E	07	74803
E	08	75121
E	09	76075
E	10	75410
E	11	75362
E	12	75758
```

## 参考資料
### オンラインマテリアル

- [Google Cloud > Hash functions](https://cloud.google.com/bigquery/docs/reference/standard-sql/hash_functions)
- [stack overflow > Finding the index of a given permutation](https://stackoverflow.com/questions/14013373/finding-the-index-of-a-given-permutation)