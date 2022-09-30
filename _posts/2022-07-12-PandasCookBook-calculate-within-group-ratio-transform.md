---
layout: post
title: "Standard SQL CookBook - 3/N"
subtitle: "RCTにおけるunit of observationのsampling - Farm Fingerprint"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-07-20
purpose: 
tags:

- Python
- 前処理
---


||概要|
|---|---|
|目的|Group毎の集計値を用いたデータ処理方法の紹介|
|分類|Pandas Cookbook|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定: Group毎の合計値に対する割合の計算](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A-group%E6%AF%8E%E3%81%AE%E5%90%88%E8%A8%88%E5%80%A4%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8B%E5%89%B2%E5%90%88%E3%81%AE%E8%A8%88%E7%AE%97)
  - [方針: transform関数の利用](#%E6%96%B9%E9%87%9D-transform%E9%96%A2%E6%95%B0%E3%81%AE%E5%88%A9%E7%94%A8)
  - [解答例](#%E8%A7%A3%E7%AD%94%E4%BE%8B)
- [応用編](#%E5%BF%9C%E7%94%A8%E7%B7%A8)
  - [ランキング値を計算したい場合](#%E3%83%A9%E3%83%B3%E3%82%AD%E3%83%B3%E3%82%B0%E5%80%A4%E3%82%92%E8%A8%88%E7%AE%97%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [zスコアを計算したい場合](#z%E3%82%B9%E3%82%B3%E3%82%A2%E3%82%92%E8%A8%88%E7%AE%97%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題設定: Group毎の合計値に対する割合の計算

以下のコマンドを叩いて次のようなデータを得たとします:

```python
df = pd.read_csv('https://raw.githubusercontent.com/RyoNakagami/pandas_for_everyone/master/data/gapminder.tsv', sep='\t')
df.head()
```

country | continent | year | lifeExp | pop | gdpPercap
---|---|---|---|---|---
Afghanistan | Asia | 1952 | 28.801 | 8425333 | 779.445314
Afghanistan | Asia | 1957 | 30.332 | 9240934 | 820.853030
Afghanistan | Asia | 1962 | 31.997 | 10267083 | 853.100710
Afghanistan | Asia | 1967 | 34.020 | 11537966 | 836.197138
Afghanistan | Asia | 1972 | 36.088 | 13079460 | 739.981106
...         |...   |...   |...     |...       | ...

`pop`カラムにはそれぞれの年度ごとの各国の人口が格納させています. この時, 各年度における各国の人口が世界トータル人口に対して何割くらいなのか？を計算したいとします.

### 方針: transform関数の利用

- `aggregate`: `groupby`で指定したグループについての複数の値を受け取り,groupに付き１つの集計値を返す
- `transform`: `groupby`で指定したグループについての複数の値を受け取り集計値を計算するが, レコードにつき, そのレコードが所属するgroupの集計値を返す


### 解答例

```python
df['pop_ratio'] = df.groupby('year')['pop'].transform(lambda x: x / sum(x))
```

## 応用編
### ランキング値を計算したい場合

```python
df.groupby('year')['pop'].transform('rank')
df.groupby('year')['pop'].transform('rank', method='dense', pct=False)
```

> パラメータ

- method : `{average, min, max, first, dense}`
    - average: average rank of group
    - min: lowest rank in group
    - max: highest rank in group
    - first: ranks assigned in order they appear in the array
    - dense: like ‘min’, but rank always increases by 1 between groups

- pct : boolean, default False
    - データのパーセンテージ順位を返す

### zスコアを計算したい場合

一人あたりGDPについて年度でグルーピングを実施した時のzscoreを計算したくなったとします.

```python
def get_zscore(x):
    """ 
    与えられたデータについてzscoreを返す
    xはベクトル or Series
    """
    return (x - x.mean()) / x.std()

df.groupby('year')['gdpPercap'].transform(get_zscore)
```

## References

> Stackoverflow

- [Pandas rank vs transform('rank')](https://stackoverflow.com/questions/40421875/pandas-rank-vs-transformrank)