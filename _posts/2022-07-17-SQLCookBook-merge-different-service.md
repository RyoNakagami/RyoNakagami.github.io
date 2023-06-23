---
layout: post
title: "Standard SQL CookBook - 6/N"
subtitle: "異なるサービスの会員データを複数カラムをマッチさせて名前寄せをする"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-09-01
purpose: 
tags:

- SQL
---

||概要|
|---|---|
|目的|異なるサービスの会員データを複数カラムをマッチさせて名前寄せをする|
|分類|SQL Cookbook|
|SQL|Standard SQL|
|環境|BigQuery|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [EC会員マスターデータ例](#ec%E4%BC%9A%E5%93%A1%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC%E3%83%87%E3%83%BC%E3%82%BF%E4%BE%8B)
  - [店舗会員マスターデータ例](#%E5%BA%97%E8%88%97%E4%BC%9A%E5%93%A1%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC%E3%83%87%E3%83%BC%E3%82%BF%E4%BE%8B)
  - [目指すもの](#%E7%9B%AE%E6%8C%87%E3%81%99%E3%82%82%E3%81%AE)
- [SQL実行例の紹介](#sql%E5%AE%9F%E8%A1%8C%E4%BE%8B%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [データ構築クエリ](#%E3%83%87%E3%83%BC%E3%82%BF%E6%A7%8B%E7%AF%89%E3%82%AF%E3%82%A8%E3%83%AA)
  - [名寄実行クエリ](#%E5%90%8D%E5%AF%84%E5%AE%9F%E8%A1%8C%E3%82%AF%E3%82%A8%E3%83%AA)
  - [ARRAY_AGGの注意点](#array_agg%E3%81%AE%E6%B3%A8%E6%84%8F%E7%82%B9)
    - [DISTINCT optionについて](#distinct-option%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
    - [IGNORE NULLS optionについて](#ignore-nulls-option%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [References](#references)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題設定

とある会社Aではこれまで店頭販売のみで自社商品を売っていたところ, 新たに自社ECサイトを立ち上げることになったとします. そのECサイトで消費者がショッピングするためには, 電話番号と誕生日を入力して, EC会員を作成する必要があるとします. このような会員制度は店頭でも実施しており, 同じく電話番号と誕生日を入力して作成されていたとします.

このとき, とある分析プロジェクトの流れの中で以下のことを見たいとなったとします：

- EC会員のうち, 本日時点で元々店舗で会員登録していた人はどのくらいいたのだろうか？
- EC会員番号と店舗会員番号の名前寄せはできないか？

### EC会員マスターデータ例

`ec_member_id`がPKとして, `(ec_member_id, main_tel, sub_tel, birthday, regist_date)`のレコードからなるデータが以下のように与えられるとします:

```
(123456, 08011112222,  0289111222, 1980-01-01, 2022-01-01),
(123457, 08011112223,  0289111222, 1981-01-01, 2022-02-01)
(123458,  0801111232, 02891121122, 1982-01-01, 2022-03-01)
(123459, 08011112243,        NULL, 1983-01-01, 2022-04-01)
```

- `ec_member_id`: PK, NOT NULL, STRING
- `main_tel`: NOT NULL, STRING
- `sub_tel`: NULLABLE, STRING
- `birthday`: NOT NULL, DATE
- `regist_data`: NOT NULL, DATE

EC会員作成には少なくとも１つの電話番号と誕生日の入力が必須のため, `main_tel`と`birthday`はNOT NULLとなります. なお, 登録する電話番号は固定電話でも携帯電話でもどちらでも良いとします.

> REMARKS

- `(main_tel, birthday)`は会員間で重複がないものとする
- `sub_tel`は過去に登録されものものも会員登録に使用できる設計とする = `main_tel`と同じものを入力してもよいし, 実家の連絡先を入力する人もいるとする

### 店舗会員マスターデータ例

`shop_member_id`がPKとして, `(shop_member_id, main_tel, sub_tel, birthday, regist_date)`のレコードからなるデータが以下のように与えられるとします:

```
(SB123456, 08011112222,  0289111222, 1980-01-01, 2022-01-01),
(SB123457,  0289111222,        NULL, 1980-01-01, 2022-02-01)
(SB123458,  0801111232, 02891121122, 1982-01-01, 2022-03-01)
(SB123459, 09011112243, 08011112243, 1983-01-01, 2022-04-01)
```

- `shop_member_id`: PK, NOT NULL, STRING
- `main_tel`: NOT NULL, STRING
- `sub_tel`: NULLABLE, STRING
- `birthday`: NOT NULL, DATE
- `regist_data`: NOT NULL, DATE

EC会員と同じく店舗会員作成と同様のものを想定します.


### 目指すもの

あくまでEC会員IDを起点として, 登録電話番号と登録生年月日ベースの両方がマッチする店舗会員IDの名寄せをしたいとします.

> 成果物イメージ

|ec_member_id(PK)|shop_member_id_list|生年月日|
|---|---|---|
|123456|{SB123456}|1980-01-01|
|...|...|...|

- `ec_member_id`がPK
- 対応する`shop_member_id`はリストとして格納する

上のデータ例と合わせると以下のクエリが作れたら勝ちとします:

```
(123456, {SB123456, SB123457}, 1980-01-01),
(123457, {NULL},               1981-01-01),
(123458, {SB123458},           1982-01-01),
(123459, {SB123459},           1983-01-01)
```

> なぜ店舗会員IDをリストで格納するのか？

`shop_member_id`をリストとして持つ理由は, EC_member_id登録時に携帯電話と固定電話両方を入力している人がいた時, 同じくその人が店舗会員IDを登録する時, (固定電話,生年月日)と(携帯電話,生年月日)で２回登録 = 同じ人だけど複数の店舗会員IDを持っている可能性があるためです.

> Assumptions

- 消費者が電話番号をシェアする際は, 同一世帯の人と仮定
- 同一世帯の中に同じ誕生日の人はいない

> Limitations

- 同一世帯の中の同じ誕生日かつ固定電話を登録に使った人(例:双子)は区別できないものとする
- EC会員ID間の名寄せは実行しないとする

## SQL実行例の紹介
### データ構築クエリ

```sql
--- ec_member_table
SELECT
    *
FROM 
    UNNEST([STRUCT<ec_member_id STRING, main_tel STRING, sub_tel STRING, birthday DATE, regist_date DATE>
            ('123456', '08011112222', '0289111222', '1980-01-01', '2022-01-01'),
            ('123457', '08011112223', '0289111222', '1981-01-01', '2022-02-01'),
            ('123458', '0801111232', '02891121122', '1982-01-01', '2022-03-01'),
            ('123459', '08011112243',        NULL, '1983-01-01', '2022-04-01')
        ]);

--- shop_member_table
SELECT
    *
FROM 
    UNNEST([STRUCT<shop_member_id STRING, main_tel STRING, sub_tel STRING, birthday DATE, regist_date DATE>
            ('SB123456', '08011112222',  '0289111222', '1980-01-01', '2022-01-01'),
            ('SB123457',  '0289111222',        NULL, '1980-01-01', '2022-02-01'),
            ('SB123458',  '0801111232', '02891121122', '1982-01-01', '2022-03-01'),
            ('SB123459', '09011112243', '08011112243', '1983-01-01', '2022-04-01')
        ]);
```

### 名寄実行クエリ

```sql
WITH
    ec_member_table AS(
        SELECT
            *
        FROM 
            UNNEST([STRUCT<ec_member_id STRING, main_tel STRING, sub_tel STRING, birthday DATE, regist_date DATE>
                    ('123456', '08011112222', '0289111222', '1980-01-01', '2022-01-01'),
                    ('123457', '08011112223', '0289111222', '1981-01-01', '2022-02-01'),
                    ('123458', '0801111232', '02891121122', '1982-01-01', '2022-03-01'),
                    ('123459', '08011112243',        NULL, '1983-01-01', '2022-04-01')
                ])
    ),
    shop_member_table AS(
        SELECT
            *
        FROM 
            UNNEST([STRUCT<shop_member_id STRING, main_tel STRING, sub_tel STRING, birthday DATE, regist_date DATE>
                    ('SB123456', '08011112222',  '0289112222', '1980-01-01', '2022-01-01'),
                    ('SB123457',  '0289111222',        NULL, '1980-01-01', '2022-02-01'),
                    ('SB123458',  '0801111232', '02891121122', '1982-01-01', '2022-03-01'),
                    ('SB123459', '09011112243', '08011112243', '1983-01-01', '2022-04-01')
                ])
    ),
    ec_member_table_unnest AS(
        SELECT
            ec_member_id,
            main_tel AS tel_key,
            birthday
        FROM
            ec_member_table
        UNION DISTINCT
        SELECT
            ec_member_id,
            sub_tel AS tel_key,
            birthday
        FROM
            ec_member_table
    ),
    shop_member_table_unnest AS(
        SELECT
            shop_member_id,
            main_tel AS tel_key,
            birthday
        FROM
            shop_member_table
        UNION DISTINCT
        SELECT
            shop_member_id,
            sub_tel AS tel_key,
            birthday
        FROM
            shop_member_table
    )
SELECT
    emtu.ec_member_id,
    emtu.birthday,
    ARRAY_AGG(DISTINCT smtu.shop_member_id IGNORE NULLS) AS shop_member_list
FROM
    ec_member_table_unnest AS emtu
    LEFT OUTER JOIN shop_member_table_unnest AS smtu
        ON emtu.tel_key  = smtu.tel_key
       AND emtu.birthday = smtu.birthday
GROUP BY
    1, 2
```

Then,

```
ec_member_id	birthday	shop_member_list
123456	1980-01-01	"[SB123456,SB123457]"
123457	1981-01-01	[]
123458	1982-01-01	[SB123458]
123459	1983-01-01	[SB123459]
```

### ARRAY_AGGの注意点
#### DISTINCT optionについて

DISTINCT optionをつけない場合, 複数レコードにマッチした場合その時の値がそのまま`ARRAY_AGG`の中に残ります：

```
ec_member_id	birthday	shop_member_list
123456	1980-01-01	"[SB123456,SB123457]"
123457	1981-01-01	[]
123458	1982-01-01	"[SB123458,SB123458]" <-- ここが重複している
123459	1983-01-01	[SB123459]
```

#### IGNORE NULLS optionについて

`ARRAY_AGG`で集計対象をarrayに集約する際, 集計対象内に`NULL`があると、以下のエラーが発生します:

```
Array cannot have a null element; error in writing field ids
```

上記名寄せ例では`LEFT OUTER JOIN`でテーブルを結合させているため, 上記のエラーの発生は高い確率で発生します. これを回避するオプションとして, `IGNORE NULLS` optionを用いています.


## References
### オンラインマテリアル

- [stackoverflow > How to remove duplicates, which are generated with array_agg postgres function](https://stackoverflow.com/questions/26363742/how-to-remove-duplicates-which-are-generated-with-array-agg-postgres-function)