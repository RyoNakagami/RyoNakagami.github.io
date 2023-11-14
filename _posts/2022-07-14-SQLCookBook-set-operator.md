---
layout: post
title: "Standard SQL CookBook - 4/N"
subtitle: "Bigquery standard SQLにおけるset operaters syntaxの確認"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-07-20
purpose: 
tags:

- SQL
---


||概要|
|---|---|
|目的|Bigquery standard SQLにおけるset operaters syntaxの確認|
|分類|SQL Cookbook|
|SQL|Standard SQL|
|環境|BigQuery|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [syntax](#syntax)
  - [UNION { ALL | DISTINCT }](#union--all--distinct-)
  - [INTERSECT DISTINCT](#intersect-distinct)
  - [EXCEPT DISTINCT](#except-distinct)
- [XORオペレーション](#xor%E3%82%AA%E3%83%9A%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## syntax
```
UNION { ALL | DISTINCT } | INTERSECT DISTINCT | EXCEPT DISTINCT
```

### UNION { ALL | DISTINCT }

- 二つのクエリの結果を結合する
- `ALL`を指定すると、recordが重複していてもそのまま残る
- `DISTINCT`を指定すると、recordの重複は排除され一意になる

> `union all`

```sql
WITH dat AS(
    SELECT
        1 AS col_1,
        2 AS col_2
    )
    ,dat_2 AS(
    SELECT
        1 AS col_1,
        2 AS col_2
    )
SELECT * FROM dat
UNION ALL
SELECT * FROM dat_2
```

THEN,

|行|col_1|col_2|
|---|---|---|
|1|1|2|
|1|1|2|

> `union distinct`

```sql
WITH dat AS(
    SELECT
        1 AS col_1,
        2 AS col_2
    )
    ,dat_2 AS(
    SELECT
        1 AS col_1,
        2 AS col_2
    )
SELECT * FROM dat
UNION DISTINCT
SELECT * FROM dat_2
```

Then,

|行|col_1|col_2|
|---|---|---|
|1|1|2|

### INTERSECT DISTINCT

- 両方に含まれるrecordを返す

```sql
WITH dat AS(
    SELECT
        * 
    FROM UNNEST([STRUCT<col_1 INT64, col_2 INT64>
                (1,2),
                (2,3),
                (1,2),
                (3,4)
                ])     
    )
    ,dat_2 AS(
    SELECT
        1 AS col_1,
        2 AS col_2
    )
SELECT * FROM dat
INTERSECT DISTINCT
SELECT * FROM dat_2
```

THEN,

|行|col_1|col_2|
|---|---|---|
|1|1|2|

### EXCEPT DISTINCT

- left table(`except distinct`の前に呼び出したテーブル)に存在してright table(`except distinct`の後に呼び出したテーブル)に存在しないrecordを抽出
- `EXCEPT ALL`はサポートされていない

```sql
WITH dat AS(
    SELECT
        * 
    FROM UNNEST([STRUCT<col_1 INT64, col_2 INT64>
                (1,2),
                (2,3),
                (1,2),
                (3,4)
                ])     
    )
    ,dat_2 AS(
    SELECT
        * 
    FROM UNNEST([STRUCT<col_1 INT64, col_2 INT64>
                (1,2),
                (1,2),
                (5,4)
                ])     
    )
SELECT * FROM dat
EXCEPT DISTINCT
SELECT * FROM dat_2
```

THEN,

|行|col_1|col_2|
|---|---|---|
|1|2|3|
|2|2|3|

## XORオペレーション

BigQueryでは`xor`オペレーション固有のコマンドは存在しないですが,`UNION ALL`,`INTERSECT`,`EXPECT`を組み合わせることで計算することは可能です.
以下例を紹介します

```sql
WITH dat AS(
    SELECT
        * 
    FROM UNNEST([STRUCT<col_1 INT64, col_2 INT64>
                (1,2),
                (2,3),
                (1,2),
                (3,4),
                (3,4)
                ])     
    )
    ,dat_2 AS(
    SELECT
        * 
    FROM UNNEST([STRUCT<col_1 INT64, col_2 INT64>
                (1,2),
                (1,2),
                (5,4)
                ])     
    ),
    dat_all AS(
        SELECT * FROM dat
        UNION ALL
        SELECT * FROM dat_2
    ),
    dat_intersect AS(
        SELECT * FROM dat
        INTERSECT DISTINCT
        SELECT * FROM dat_2
    )
SELECT * FROM dat_all
EXCEPT DISTINCT
SELECT * FROM dat_intersect
```
