---
layout: post
title: "Coding Style Guide Part 2"
subtitle: "SQL Style Guide"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-07-25
tags:

- SQL
- coding
---



||概要|
|---|---|
|目的|SQL Style Guide|
|参考|- [The Art of Readable Code by Dustin Boswell and Trevor Foucher. Copyright 2012 Dustin Boswell and Trevor Foucher, 978-0-596-80229-5](https://www.oreilly.co.jp/books/9784873115658/)<br> -[Coding Style Guide Part 1](https://ryonakagami.github.io/2021/05/02/Coding-Guide/)<br>- [CTEs versus Subqueries](https://www.alisa-in.tech/post/2019-10-02-ctes/)|

本ドキュメントは,「Readable,ReusableなSQLクエリの書く」ことを目的に, SQLコーディング規約についてまとめたものです. RDBMSとしてAmazon Redshift / Google Bigqueryを念頭としています. `DO`は推奨,`AVOID`は非推奨を表しています.

**Table of Contents**

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [命名規則](#%E5%91%BD%E5%90%8D%E8%A6%8F%E5%89%87)
  - [変数名の規則](#%E5%A4%89%E6%95%B0%E5%90%8D%E3%81%AE%E8%A6%8F%E5%89%87)
    - [SUFFIX RULE](#suffix-rule)
    - [PREFFIX RULE](#preffix-rule)
    - [なぜfield nameは30 byte以下なのか？](#%E3%81%AA%E3%81%9Cfield-name%E3%81%AF30-byte%E4%BB%A5%E4%B8%8B%E3%81%AA%E3%81%AE%E3%81%8B)
  - [TABLE ALIAS](#table-alias)
- [Query Syntax](#query-syntax)
  - [ブロックとインデント](#%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF%E3%81%A8%E3%82%A4%E3%83%B3%E3%83%87%E3%83%B3%E3%83%88)
    - [UNION句とブロック](#union%E5%8F%A5%E3%81%A8%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF)
    - [CASE文とブロック](#case%E6%96%87%E3%81%A8%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF)
    - [WINDOW関数](#window%E9%96%A2%E6%95%B0)
  - [JOIN句では`LEFT`, `OUTER`, `INNER`を明示する](#join%E5%8F%A5%E3%81%A7%E3%81%AFleft-outer-inner%E3%82%92%E6%98%8E%E7%A4%BA%E3%81%99%E3%82%8B)
  - [サブクエリ](#%E3%82%B5%E3%83%96%E3%82%AF%E3%82%A8%E3%83%AA)
    - [サブクエリ句ではなくCTEs(Common Table Expressions = WITH句)を用いる](#%E3%82%B5%E3%83%96%E3%82%AF%E3%82%A8%E3%83%AA%E5%8F%A5%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%8Fctescommon-table-expressions--with%E5%8F%A5%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B)
- [BigQuery Best Practices](#bigquery-best-practices)
  - [必要なカラムのみクエリする](#%E5%BF%85%E8%A6%81%E3%81%AA%E3%82%AB%E3%83%A9%E3%83%A0%E3%81%AE%E3%81%BF%E3%82%AF%E3%82%A8%E3%83%AA%E3%81%99%E3%82%8B)
  - [`LIMIT`ではなく`_PARTITIONDATE`などのPARTITIONを用いる](#limit%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%8F_partitiondate%E3%81%AA%E3%81%A9%E3%81%AEpartition%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B)
    - [PARTITIONの指定可能対象](#partition%E3%81%AE%E6%8C%87%E5%AE%9A%E5%8F%AF%E8%83%BD%E5%AF%BE%E8%B1%A1)
  - [Shared Table vs PARTITIONED TABLE](#shared-table-vs-partitioned-table)
  - [`JOIN`句で結合する前にテーブルサイズを小さくする](#join%E5%8F%A5%E3%81%A7%E7%B5%90%E5%90%88%E3%81%99%E3%82%8B%E5%89%8D%E3%81%AB%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB%E3%82%B5%E3%82%A4%E3%82%BA%E3%82%92%E5%B0%8F%E3%81%95%E3%81%8F%E3%81%99%E3%82%8B)
  - [`JOIN`句のテーブルの順番](#join%E5%8F%A5%E3%81%AE%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB%E3%81%AE%E9%A0%86%E7%95%AA)
  - [クラスタリング](#%E3%82%AF%E3%83%A9%E3%82%B9%E3%82%BF%E3%83%AA%E3%83%B3%E3%82%B0)
- [References](#references)
  - [Online-contents](#online-contents)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 命名規則
### 変数名の規則

> DO

- Field nameは小文字を使用する
- `id`, `name`, `type`といった文字列はなんのidentifierやnameを表しているか曖昧なので,objectをprefixとして付与すること
- 名前にスペースを含めるのが自然な場合はアンダースコアを使用する。（first nameはfirst_name）
- 30 byte以下の名前にする(日本語用いる場合,10文字目安)

> AVOID

- CamelCase, camelBackは使わない(= snake_caseを用いる)
- 複数形を避ける = できるだけ集合体を表す用語を使用する. たとえばemployeesの代わりにstaff,またはindividualsの代わりにpeopleを使用する（スペルミスの恐れを回避するため）
- 略語を避ける. 略語を使う必要がある場合は,一般的に通じるものであることを確認する
- 予約語は変数名には用いない
- アルファベット, 数字, アンダースコア以外の文字は使用しない

> EXAMPLE

```sql
--- Good
SELECT
    id    AS account_id,
    name  AS account_name,
    type  AS account_type,
FROM
    account_table

--- Bad
SELECT
    id,
    name,
    type,
FROM
    account_table
```

#### SUFFIX RULE

|suffix| 	説明|
|---|---|
|`_id`| 	主キーである列など一意の識別子|
|`_total`| 	値の集合の合計または総計|
|`_num`| 	フィールドに数値が含まれていることを表す|
|`_name`| 	first_nameのように名前を強調する|
|`_seq`| 	連続した数値を含む|
|`_cnt`| 	カウント|
|`_size`| 	ファイルサイズや衣類などのサイズ|
|`_date`| 	何かの日付を含む列であることを表す|
|`_at`|TIMESTAMP型のデータタイプを表す|
|`_type`|カテゴリ変数を表す, 例: `coupon_type`|

#### PREFFIX RULE

|prefix|説明|
|---|---|
|`taxed_`|税込の値を表す|
|`first_`, `last_`|期間の境界値を示す(`last_`は範囲に含まれる)|
|`satrt_`, `end_`|期間の境界値を示す(`end_`は範囲に含まれない)|
|`is_`, `has_`|BOOLEAN型のデータタイプを表す|
|`avg_`|平均を表す|

#### なぜfield nameは30 byte以下なのか？

RDBMSの種類(Oracle Database 12.1)によって,カラム文字は30 byte以下という制約があるためです. とあるデータベースでは有効だったクエリが他に移植できなくなるというリスクを回避するためにこのルールがあります.


### TABLE ALIAS

> DO

1. アンダースコアでテーブル名をsplitし,それぞれの頭文字を結合したエイリアスを用いる
2. 同じテーブル同士で結合する場合は,(1)のルールと出現順番の組み合わせを用いる

> EXAMPLE

```sql
--- Good
SELECT
    bfco.account_id,
    dd.fiscal_year,
    dd.fiscal_quarter,
    dd.fiscal_quarter_name,
    cc.cost_category_level_1,
    cc.cost_category_level_2
FROM 
    budget_forecast_cogs_opex AS bfco
    LEFT JOIN date_details AS dd
        ON bfco.accounting_period = dd.first_day_of_month
    LEFT JOIN cost_category AS cc
        ON bfco.unique_account_name = cc.unique_account_name

--- Bad
SELECT
    a.*,
    b.fiscal_year,
    b.fiscal_quarter,
    b.fiscal_quarter_name,
    c.cost_category_level_1,
    c.cost_category_level_2
FROM budget_forecast_cogs_opex a
LEFT JOIN date_details b
 ON b.first_day_of_month = a.accounting_period
LEFT JOIN cost_category c
 ON b.unique_account_name = c.unique_account_name
```

## Query Syntax

> DO

- 予約語は大文字を使用する(`SELECT`, `WHERE`, `FROM`, `SUM`など)
- 常にASキーワードを記載する
- 原則1行につき１文
- 1文70文字超えたら改行
- インデントはspace 4
- 比較演算子 (`=`, `>` `!=`）の前後にはスペースをいれる
- カンマ（`,`）の後にスペース入れる
- NOT EQUALの演算をする際は `<>` ではなくて `!=` を用いる（`!=`のほうがプログラミング言語との観点では一般的な表現方法）
- `UNION`句は`UNION ALL`か`UNION DISTINCT`を明示的に記述する
- `GROUP BY`, `ORDER BY`は数字で表現する

> EXAMPLE

```sql
  -- Good: indent with space 4
WITH my_data AS (

    SELECT 
        md.*
    FROM 
        prod.my_data AS md
    WHERE 
        md.filter = 'my_filter'
)
...


-- Bad: indent with space 2
WITH my_data AS (

  SELECT *
  FROM prod.my_data
  WHERE filter = 'my_filter'
)
...

```

### ブロックとインデント

> DO

- インデントを活用し,同じブロックに属するkeywordsがすべて同じ位置で開始するようにコードを整列させる
- `JOIN`句は,「ブロック」の向こう側にインデントし,必要に応じて改行でグループ化する
- `DISTINCT`は`SELECT`と同じ行に配置する

> EXAMPLE: インデントを用いてブロックを整列する

```sql
SELECT DISTINCT
    ph.COLUMN1 AS COLUMN1,
    dd.COLUMN2 AS COLUMN2
FROM
    purchase_history AS ph,	
    INNER JOIN delivery_data AS dd
        ON ph.COLUMN3 = dd.COLUMN3
       AND ph.COLUMN4 = dd.COLUMN4
WHERE
    ph.COLUMN5 = 1
AND	dd.COLUMN6 = DATE('2020-12-01')
ORDER BY
    1, 2
```

#### UNION句とブロック

> DO
- `UNION`句を用いる場合は,`UNION`の前後を改行し１行ずつ空ける


> EXAMPLE

```sql
SELECT
    table1.COLUMN1,
    table1.COLUMN2,
FROM
    table 1

UNION ALL

SELECT
    table2.COLUMN1,
    table2.COLUMN2,
FROM
    table 2
```

#### CASE文とブロック

> DO

- `WHEN`とそれに対応する`THEN`が一つのブロックとなるようにする

> EXAMPLE

```sql
SELECT
    CASE
        WHEN XXX.HOGE = 1 THEN 1
        ELSE 0
    END AS is_hoge
FROM
    XXX
```

#### WINDOW関数

> DO

- 順序 (`ASC`, `DESC`)は明示する


> EXAMPLE

```sql
SUM(1) OVER (
                PARTITION BY category_id, year
                ORDER BY pledged DESC
            ) AS category_year
```



### JOIN句では`LEFT`, `OUTER`, `INNER`を明示する

> DO

- `JOIN`ではなく`LEFT OUTER JOIN`とテーブル同士の関係性を明示する
- JOINキーの順番はテーブルの出現順番に合わせる
- JOIN方向は`LEFT`に統一する(`RIGHT JOIN`は用いない)
  - JOIN方向が左からと統一されていないと,集約Keyはどちらベースなのかの解釈に頭をつかってしまい,読みづらいコードとなってしまうため

>> EXAMPLE: JOINキーの順番

```sql
--- Good
SELECT
    ...
FROM 
    source
    LEFT JOIN other_source
        ON source.id = other_source.id
WHERE 
    ...

--- Bad
SELECT
    ...
FROM 
    source
    LEFT JOIN other_source
        ON other_source.id = source.id
WHERE 
    ...
```

### サブクエリ

> DO

- サブクエリのブロックは他と区別できるように配置する
- サブクエリ内は改行を厳密にやらなくてもいいとする

> AVOID

- 避けることができるならサブクエリは用いない

> EXAMPLE

```sql
SELECT 
    r.last_name,
    (
        SELECT MAX(YEAR(championship_date))
        FROM champions AS c
        WHERE c.last_name = r.last_name
          AND c.confirmed = 'Y'
    ) AS last_championship_year
FROM
    riders AS r
WHERE
    r.last_name IN (
                        SELECT c.last_name
                        FROM champions AS c
                        WHERE YEAR(championship_date) > '2008'
                        AND c.confirmed = 'Y'
                    )
;
```

#### サブクエリ句ではなくCTEs(Common Table Expressions = WITH句)を用いる

- CTEsの方がサブクエリ句を用いるよりも可読性があがる
- CTEsの方がQuery Peformanceが改善するケースがある

> EXAMPLE: CTEsの方がQuery Peformanceが改善するケース

以下の例では,CTE statmentを用いたクエリに対して,サブクエリ句を用いたクエリのデータスキャン量は大きくなってしまいます.
`apc1`と`apc2`が`JOIN`句で呼ばれる際,CTE statementは`avg_pet_count_over_time`を1回作成するだけで住みますが,WITH句の方ではそれぞれ独立に2回`avg_pet_count_over_time`が作られてしまうことに起因しています.

```sql
WITH 
    avg_pet_count_over_time AS (
        SELECT 
            cat_id, 
            MAX(timestamp)::DATE AS max_pet_date, 
            MIN(timestamp)::DATE AS min_pet_date 
        FROM 
            cat_pet_fact
        GROUP BY 
            1
    )
SELECT 
    cd.cat_name,
    apc1.max_pet_date,
    apc2.min_pet_date
FROM 
    cat_dim AS cd
    LEFT JOIN avg_pet_count_over_time as apc1
        ON cd.cat_id = apc1.cat_id
    LEFT JOIN avg_pet_count_over_time as apc2
        ON cd.cat_id = apc2.cat_id
;
```

> AVOID

```
SELECT 
  cat_name,
  apc1.max_pet_date,
  apc2.min_pet_date 
FROM cat_dim
LEFT JOIN 
  (SELECT 
    cat_id, 
    MAX(timestamp)::DATE AS max_pet_date,
    MIN(timestamp)::DATE AS min_pet_date
  FROM cat_pet_fact
  GROUP BY 1) AS apc1
ON cat_dim.cat_id = apc1.cat_id
LEFT JOIN 
  (SELECT 
    cat_id,
    MAX(timestamp)::DATE AS max_pet_date,
    MIN(timestamp)::DATE AS min_pet_date
  FROM cat_pet_fact
  GROUP BY 1) as apc2
ON cat_dim.cat_id = apc2.cat_id;
```

## BigQuery Best Practices
### 必要なカラムのみクエリする

> DO

- 分析に必要なカラムのみクエリする

BigQueryはカラム指向ストレージであるため,指定されたカラムは上から下までフルスキャンされます. そのため,指定されたカラムが多いほどスキャンのデータ量が増えます. スキャンデータ量が多いほど処理に時間がかかりパフォーマンスが下がり,また料金コストも上昇するというデメリットがあります.

> カラム指向スト-レジとは？

- カラム指向ストレージとは,列単位でデータを格納する仕組みのこと(多くの他のRDBはレコード単位でデータを格納)
- 列単位ではデータタイプが同一なので,データの圧縮効率が高くなる(=ストレージコストが安くなる)というメリットがあります

### `LIMIT`ではなく`_PARTITIONDATE`などのPARTITIONを用いる

- `LIMIT`句はデータのスキャン量には影響を与えません. なのでQuery Performanceの観点からもクエリコスト管理の観点からも推奨されません 
- 一部のデータだけ見たい場合は,`_PARTITIONDATE = "2017-01-01"`などのPARTITION機能を用いると,データスキャン量が減らせます

なお,一部のカラムを除いてクエリしたい場合は`EXCEPT`関数を用います.

```sql
/*update_timestampカラム以外をクエリしたい場合*/
SELECT
    * EXPECT(update_timestamp)
FROM
    TABLE1
WHERE
    _PARTITIONDATE BETWEEN TIMESTAMP("2016-01-01") AND TIMESTAMP("2016-01-31")
```

#### PARTITIONの指定可能対象

> 設定可能対象

- データ読み込み時の日付部分
- TIMESTAMP列
- DATE列
- DATETIME列
- INTEGER列

> EXAMPLE

```sql
--- DATE列をPARTITION列として指定
CREATE TABLE
  mydataset.newtable (transaction_id INT64, transaction_date DATE)
PARTITION BY
  transaction_date
OPTIONS(
  require_partition_filter=false
);

CREATE TABLE
  mydataset.newtable (transaction_id INT64, transaction_date DATE)
PARTITION BY
  transaction_date
AS SELECT transaction_id, transaction_date FROM mydataset.mytable;


--- DATE列をMonthlyにトランクして,PARTITION列として指定
CREATE TABLE
  mydataset.newtable (transaction_id INT64, transaction_date DATE)
PARTITION BY
  DATE_TRUNC(transaction_date, MONTH)
OPTIONS(
  require_partition_filter=false
);


--- TIMESTAMP列をDailyにトランクして,PARTITION列として指定
CREATE TABLE
  mydataset.newtable (transaction_id INT64, transaction_ts TIMESTAMP)
PARTITION BY
  TIMESTAMP_TRUNC(transaction_ts, DAY)
OPTIONS(
  require_partition_filter=false
);


--- データ取り込み日をPARTITION列として指定
CREATE TABLE
  mydataset.newtable (transaction_id INT64)
PARTITION BY
  _PARTITIONDATE
;


--- INTERGER列をPARTITION列として指定
CREATE TABLE mydataset.newtable (customer_id INT64, date1 DATE)
PARTITION BY
  RANGE_BUCKET(customer_id, GENERATE_ARRAY(0, 100, 10))
OPTIONS(
  require_partition_filter=false
)
```

### Shared Table vs PARTITIONED TABLE

> DO

- 日付ごとにテーブル(`PREFIX_YYYYMMDD`)を作るのではなく,パーティション分割テーブルを利用する

> WHY

日付ごとにテーブルを作るアプローチは,以下のオーバーヘッドがあります:

- 個別のテーブルごとにメタデータを保持する
- クエリ実行時に個別のテーブルごとに権限を確認する必要がある

> 例外

日毎にrawデータ形式が異なる場合は,日付ごとに異なるスキーマを適用できるシャーディングテーブルを活用する(活用例：データソースでカラムが増減した場合でもそのまま取り込める)


### `JOIN`句で結合する前にテーブルサイズを小さくする

BigQueryでは`JOIN`句を用いてテーブルを結合する際,まずBigQueryは両方のテーブルデータをシャッフルして,結合条件の演算を実施します. このシャッフルはスロットをオーバーロードするリスクがあります. ですので,事前にテーブルサイズを小さくできるならば,小さくしてから結合することが推奨されます.

- BigQueryはストレージコストは大きくないので,データは非正規化したほうがよいとされています(=`JOIN`句を避けるようなテーブル設計)

### `JOIN`句のテーブルの順番

> DO

- 可能であるならば,`JOIN`句で指定するテーブルはデータサイズが大きいテーブル（行数が大きいテーブル）から呼んだほうがよい

大きなテーブルをJOINの左側に,小さなテーブルをJOINの右側に配置すると,`broadcast join` が作成されます. `broadcast join`は,小さい方のテーブルのすべてのデータを,大きい方のテーブルを処理する各スロットに送ります. 具体的には,内部表側のデータがブロードキャストされる一方,外部表側のデータはそのままで移動されないことを指しています. 

### クラスタリング

> DO

- 連続性の高いフィールドをクラスタキーとして設定

> 効果

- クラスタキーでスキャンしたブロックのみ費用が発生する(=費用削減)
- データはパーティション内でソートされて保持されているので,`WHERE`句でクラスタキーとなるフィールドでフィルターを指定した場合,不要なデータのスキャンを省略してくれる
- RDBのINDEXのイメージが近い

> 設定可能対象

- DATE
- BOOL
- GEOGRAPHY
- INT64
- NUMERIC
- BIGNUMERIC
- STRING
- TIMESTAMP
- DATETIME

> LIMITATIONS

- クラスタキーは４つまで設定可能
- STRINGをキーに設定した場合,最初の1,024 charactersのみソートに用いられる

> EXAMPLE

```sql
CREATE TABLE
    `mydataset.ClusteredSalesData`
PARTITION BY
    DATE(timestamp)
CLUSTER BY
    customer_id,
    product_id,
    order_id AS
SELECT
    *
FROM
    `mydataset.SalesData`
```

## References
### Online-contents

- [GitHub >  sqlfluff/sqlfluff](https://github.com/sqlfluff/sqlfluff)
