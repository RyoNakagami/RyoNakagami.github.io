---
layout: post
title: "join command: Header付きcsv fileのjoin"
subtitle: "shell script preprocess 1/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
last_modified_at: 2023-05-29
tags:

- Linux
- Shell
- 前処理
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`join` command overview](#join-command-overview)
- [CSVファイルのjoin: sortエラーの確認と対処法 version 1](#csv%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AEjoin-sort%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%AE%E7%A2%BA%E8%AA%8D%E3%81%A8%E5%AF%BE%E5%87%A6%E6%B3%95-version-1)
  - [sortエラーの確認](#sort%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [どうやってsortする？](#%E3%81%A9%E3%81%86%E3%82%84%E3%81%A3%E3%81%A6sort%E3%81%99%E3%82%8B)
  - [`sort` & `join`をワンライナーで実現する](#sort--join%E3%82%92%E3%83%AF%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%8A%E3%83%BC%E3%81%A7%E5%AE%9F%E7%8F%BE%E3%81%99%E3%82%8B)
- [CSVファイルのjoin: sortエラーの確認と対処法 version 2](#csv%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AEjoin-sort%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%AE%E7%A2%BA%E8%AA%8D%E3%81%A8%E5%AF%BE%E5%87%A6%E6%B3%95-version-2)
  - [ゼロ埋めしてjoinする](#%E3%82%BC%E3%83%AD%E5%9F%8B%E3%82%81%E3%81%97%E3%81%A6join%E3%81%99%E3%82%8B)
- [Outputのカラムを指定する](#output%E3%81%AE%E3%82%AB%E3%83%A9%E3%83%A0%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B)
- [`join`の欠損値補完機能を使う](#join%E3%81%AE%E6%AC%A0%E6%90%8D%E5%80%A4%E8%A3%9C%E5%AE%8C%E6%A9%9F%E8%83%BD%E3%82%92%E4%BD%BF%E3%81%86)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## `join` command overview

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: join command</ins></p>

- `join`コマンドは２つのファイルを比較し, キーに基づいて連結するコマンド
- `join`対象キーはどちらのファイルもsortされていなければ, errorとなる

```zsh
# Syntax
join [option] file1 file2
```

</div>

**比較に関するオプション**

|option|説明|
|---|---|
|`-i`|大文字小文字を区別しない|
|`-t `|セパレーターの指定|
|`-1 数値`|1つ目のファイルで比較に使用するcolumn number|
|`-2 数値`|2つ目のファイルで比較に使用するcolumn number|
|`--header`|各ファイルの1行目をヘッダとして扱う|

**出力に関するオプション**

|option|説明|
|---|---|
|`-a 番号`|指定しない場合: inner join<br>`1`: left join<br>`2`: right join|
|`-v 番号`|対応するフィールドがなかった行だけ出力<br>`1`: file1の内file2とマッチしなかった行<br>`2`: file2の内file1とマッチしなかった行|
|`-o 番号`|出力するフィールドを指定|
|`-e 文字列`|結合相手がいなかった場合の代替値|


## CSVファイルのjoin: sortエラーの確認と対処法 version 1
### sortエラーの確認

`student.csv`という生徒マスターテーブルと, 
`test_score.csv`という生徒が直近受けたテストの点数を格納したファイルが以下のように与えられたとします.

```zsh
% cat test_score.csv
id,score
01,89
05,23
06,05
07,79
08,34
09,32
10,90
11,78
12,61
13,45
14,89
15,78
16,23

% cat student.csv
id,name,class
01,ryo,A
07,togo,A
08,sato,A
09,moka,A
10,shina,A
11,ringo,A
02,shun,B
03,takashi,B
04,bob,B
17,asada,B
18,billy,B
19,lio,B
20,son,B
05,sasuke,C
06,naruto,C
12,pop,C
13,felix,C
14,hezo,C
15,zoff,C
16,kirby,C
```

テストを受けた生徒のついて生徒マスターデータの情報を参照したいとします.
このとき, キーカラムのsortに無頓着に`join`すると次のようなエラーが返ってきます.

```zsh
% join -t, -1 1 -2 1 test_score.csv student.csv 
id,score,name,class
join: student.csv:6: is not sorted: 10,shina,A
join: input is not in sorted order
```

join keyがsortされていないと`join`コマンドはうまく動作してくれません.
今回のケースでは`student.csv`が`id`カラムでsortされていないのでエラーが返ってきています.

### どうやってsortする？

今回はheader付きcsv fileなのでheaderの位置をキープしたままsortさせたいです.
sortコマンドを使うにあたって気をつけたい点は以下です:

- `-t`: column seperator文字はなにかを指示する
- `-k`: どのカラムでsortするか指示する & カラムは数値型かテキスト型かを指示する


```zsh
## 文字列ベースでsort
% sort -t , -k1 student.csv | head -5
10,shina,A
11,ringo,A
12,pop,C
13,felix,C
14,hezo,C

## header位置をキープしながら文字列ベースでsort
% (head -n1 student.csv && tail -n+2 student.csv | sort -t , -k1) | head -5
id,name,class
10,shina,A
11,ringo,A
12,pop,C
13,felix,C

## 数値ベースでソート
% sort -t , -k1n student.csv | head -5
id,name,class
01,ryo,A
02,shun,B
03,takashi,B
04,bob,B
```

### `sort` & `join`をワンライナーで実現する

リダイレクトを用いることでワンライナーでsorted fileをinputとして`join`することができます.

```zsh
% join -t , --header -1 1 -2 1 <(head -n1 test_score.csv && (tail -n+2 test_score.csv | sort -t , -k1n)) <(head -n1 student.csv && (tail -n+2 student.csv | sort -t , -k1n))
id,score,name,class
01,89,ryo,A
05,23,sasuke,C
06,05,naruto,C
07,79,togo,A
08,34,sato,A
09,32,moka,A
10,90,shina,A
11,78,ringo,A
12,61,pop,C
13,45,felix,C
14,89,hezo,C
15,78,zoff,C
16,23,kirby,C
```

上の例では両方ともsortさせましたが, 今回の例では`test_score.csv`ははじめからソートされているので以下のコマンドでも同じことができます.

```zsh
## リダイレクトを用いる場合
% join -t , --header -j 1 test_score.csv <(head -n1 student.csv && (tail -n+2 student.csv | sort -t , -k1n)) 

## パイプでつなぐ場合
% (head -n1 student.csv && (tail -n+2 student.csv | sort -t , -k1n)) |join -t , --header -j 1 test_score.csv - 
```

## CSVファイルのjoin: sortエラーの確認と対処法 version 2

version 1で紹介した問題と似た以下のケースを考えます. idカラムが上の例では0埋めされていましたが
今回はされていません.

```zsh
% cat test_score.csv
id,score
1,89
5,23
6,05
7,79
...

% cat student.csv
id,name,class
1,ryo,A
7,togo,A
8,sato,A
9,moka,A
10,shina,A
11,ringo,A
...
```

このとき, 普通にsort & joinを実行すると以下のようなエラーつき結果がリターンされます.

```zsh
## 数値ソートの場合
% (head -n1 student.csv && (tail -n+2 student.csv | sort -t , -k1n)) |join -t , --header -j 1 test_score.csv - 
id,score,name,class
1,89,ryo,A
5,23,sasuke,C
6,05,naruto,C
7,79,togo,A
8,34,sato,A
join: test_score.csv:8: is not sorted: 10,90
join: -:11: is not sorted: 10,shina,A
9,32,moka,A
10,90,shina,A
11,78,ringo,A
12,61,pop,C
13,45,felix,C
14,89,hezo,C
15,78,zoff,C
16,23,kirby,C
join: input is not in sorted order

## テキストソートの場合
% join -t , --header -1 1 -2 1 <(head -n1 test_score.csv && (tail -n+2 test_score.csv | sort -t , -k1)) <(head -n1 student.csv && (tail -n+2 student.csv | sort -t , -k1))  
id,score,name,class
10,90,shina,A
11,78,ringo,A
12,61,pop,C
13,45,felix,C
14,89,hezo,C
15,78,zoff,C
16,23,kirby,C
join: /proc/self/fd/18:12: is not sorted: 1,ryo,A
5,23,sasuke,C
6,05,naruto,C
7,79,togo,A
8,34,sato,A
9,32,moka,A
join: input is not in sorted order
```

### ゼロ埋めしてjoinする

version 1ではエラーなく返ってきたので, 0埋めをして`join`すれば良いという方針で以下の解答を作りました.

```zsh
% awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' student.csv| sort -t , -k1n |join -t , --header -j 1 <(awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' test_score.csv) - 
```

## Outputのカラムを指定する

id, name, class, scoreの順番で出力したい場合は`-o`オプションを用います.

```zsh
% awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' student.csv| sort -t , -k1n |join -t , --header -j 1 -o 0 2.2 2.3 1.2 <(awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' test_score.csv) - | head -5
id,name,class,score
01,ryo,A,89
05,sasuke,C,23
06,naruto,C,05
07,togo,A,79
```

`-o 0 2.2 2.3 1.2`の意味は

- `0`: join key
- `x.y`: xはファイル番号, yはそのカラム番号

id, name, scoreの順番で出力したい場合は

```zsh
% awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' student.csv| sort -t , -k1n |join -t , --header -j 1 -a 2 -e 0 -o 0 2.2 1.2 <(awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' test_score.csv) - | head -5 
id,name,score
01,ryo,89
05,sasuke,23
06,naruto,05
07,togo,79
```

## `join`の欠損値補完機能を使う

`tes_score`がない生徒については暫定的にスコアを0にして出力したい場合は, 主力範囲を指定する`-a`オプションと
欠損値の穴埋めをする`-e`オプションを用います.

- `-a 数値`: 1ならばLEFT OUTER, 2ならばRIGHT OUTER
- `-e 文字列`: 対応する値がない場合に`文字列`で補完する, 指定しない場合は欠損したまま出力される

```zsh
% awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' student.csv| sort -t , -k1n |join -t , --header -j 1 -a 2 -e 0 -o 0 2.2 1.2 <(awk -F"," -v 'OFS=,' 'NR==1; NR > 1{$1=sprintf("%02d",$1);print}' test_score.csv) -
id,name,score
01,ryo,89
02,shun,0
03,takashi,0
04,bob,0
05,sasuke,23
06,naruto,05
07,togo,79
08,sato,34
09,moka,32
10,shina,90
11,ringo,78
12,pop,61
13,felix,45
14,hezo,89
15,zoff,78
16,kirby,23
17,asada,0
18,billy,0
19,lio,0
20,son,0
```




References
----------

- [itmedia > 【 join 】コマンド――テキストファイルを共通項目で連結する](https://atmarkit.itmedia.co.jp/ait/articles/1704/06/news025.html)