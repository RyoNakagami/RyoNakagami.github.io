---
layout: post
title: "CSV FILEの重複レコードをシェルスクリプトで除去する"
subtitle: "AWK(gawk)コマンドの連想配列の活用"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-08-29
tags:

- Shell
---

---|---
OS|ubuntu 20.04 LTS Focal Fossa
Requirement|`gawk`インストール済み


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Dependency: gawkのインストール](#dependency-gawk%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [今回やりたいこと：CSV FILEの重複レコードを除去](#%E4%BB%8A%E5%9B%9E%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8csv-file%E3%81%AE%E9%87%8D%E8%A4%87%E3%83%AC%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E9%99%A4%E5%8E%BB)
- [シェルスクリプト解説](#%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E8%A7%A3%E8%AA%AC)
  - [実行コマンド](#%E5%AE%9F%E8%A1%8C%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [解説](#%E8%A7%A3%E8%AA%AC)
    - [連想配列(associative array)って？](#%E9%80%A3%E6%83%B3%E9%85%8D%E5%88%97associative-array%E3%81%A3%E3%81%A6)
  - [連想配列`seen[$0]`のkey/valueの定義について](#%E9%80%A3%E6%83%B3%E9%85%8D%E5%88%97seen0%E3%81%AEkeyvalue%E3%81%AE%E5%AE%9A%E7%BE%A9%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [別解：`cat <FILE NAME> | sort | uniq`](#%E5%88%A5%E8%A7%A3cat-file-name--sort--uniq)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Dependency: gawkのインストール

`gawk`コマンドをインストールし, PATHが`gawk`に対して設定されているか確認します.
`link currently points to /usr/bin/gawk` という文字列が確認できれば問題ないです.

```zsh
% sudo apt install gawk
% sudo update-alternatives --display awk
awk - auto mode
  link best version is /usr/bin/gawk
  link currently points to /usr/bin/gawk
  link awk is /usr/bin/awk
  slave awk.1.gz is /usr/share/man/man1/awk.1.gz
  slave nawk is /usr/bin/nawk
  slave nawk.1.gz is /usr/share/man/man1/nawk.1.gz
```

## 今回やりたいこと：CSV FILEの重複レコードを除去

以下のようにソートされずにレコードが格納されてているCSV FILE(`test.csv`)が与えられたときに,
レコードの出現順番を維持しながら,重複レコードを除去したいとします.

```csv
postal_code,PREF_NAME,CITY_NAME,S_NAME
7793501,徳島県,吉野川市,美郷
7793505,徳島県,吉野川市,美郷
7793502,徳島県,吉野川市,美郷
7793403,徳島県,吉野川市,山川町
7793402,徳島県,吉野川市,山川町
7793407,徳島県,吉野川市,山川町
7793405,徳島県,吉野川市,山川町
7793502,徳島県,,
7793404,徳島県,吉野川市,山川町
7793410,徳島県,吉野川市,山川町
7793410,徳島県,吉野川市,美郷
7793501,徳島県,吉野川市,美郷
7793505,徳島県,吉野川市,美郷
7793502,徳島県,吉野川市,美郷
7793502,徳島県,,
7793403,徳島県,吉野川市,山川町
7793402,徳島県,吉野川市,山川町
7793402,徳島県,,
,,,,
7793407,徳島県,吉野川市,山川町
7793405,徳島県,吉野川市,山川町
7793404,徳島県,吉野川市,山川町
7793410,徳島県,吉野川市,山川町
7793410,徳島県,吉野川市,美郷
,,,,
```

ゴールとしての出力結果は以下です:

```csv
postal_code,PREF_NAME,CITY_NAME,S_NAME
7793501,徳島県,吉野川市,美郷
7793505,徳島県,吉野川市,美郷
7793502,徳島県,吉野川市,美郷
7793403,徳島県,吉野川市,山川町
7793402,徳島県,吉野川市,山川町
7793407,徳島県,吉野川市,山川町
7793405,徳島県,吉野川市,山川町
7793502,徳島県,,
7793404,徳島県,吉野川市,山川町
7793410,徳島県,吉野川市,山川町
7793410,徳島県,吉野川市,美郷
7793402,徳島県,,
,,,,
```

## シェルスクリプト解説
### 実行コマンド

```zsh
% awk -F',' '!seen[$0]++' ./test.csv
% awk -F',' '!seen[$0]++' ./test.csv > result.csv #result.csvに出力結果を保存したい場合
```

上記コマンドの実行結果のレコード数を確認してみると

```zsh
% cat test.csv | wc -l
25
% cat result.csv | wc -l
14
```

### 解説

`awk -F',' '!seen[$0]++' ./test.csv`は３つの構成要素に分解できます:

---|---
`-F','`|FIELD SEPARATOR, 今回はCSV FILEなので `,` を指定しています
`'!seen[$0]++'`|`seen`という実行者が任意に定義した連想配列を用いて重複チェック
`./test.csv`|`awk`コマンドが動作する対象ファイル

#### 連想配列(associative array)って？

まず配列と連想配列の違いですが,

- 配列 : インデックスが数字であるもの
- 連想配列 : インデックスが文字列であるもの, ハッシュや辞書も連想配列

そもそもAWKには変数の型がないので, 実質的には配列と連想配列はAWK界隈では一緒になります.

> 連想配列を用いて`postal_code`毎の出現回数を出力してみる

`./test.csv`CSV FILEの構造として, 先頭レコードがカラム名で, 
ときおり`postal_code`が入力されていないレコードが存在することがわかっているので,
カラム名と`postal_code`がNULLのレコードを除去した上で`postal_code`毎の出現回数を出力したいとします.

- 先頭レコードはそもそも除去
- 連想配列を定義し, valueとして出現回数を入力
- 連想配列のkeyが空文字の場合は出力しない

とすればできるはずで, その実行例が以下です:

```zsh
% awk -F',' '{NR!=1 && pcode[$1]++}END{for (var in pcode) if(var != "") print var, "", pcode[var]+1, " times"}' ./test.csv
7793402  3  times
7793403  2  times
7793404  2  times
7793405  2  times
7793407  2  times
7793410  4  times
7793501  2  times
7793502  4  times
7793505  2  times
```

上記の例では`pcode`という連想配列を定義していますが, このことから重複レコード排除における`seen`は
実行者が任意に名前付けした連想配列であることがわかります.


### 連想配列`seen[$0]`のkey/valueの定義について

`seen[$0]++`という形で重複排除シェルスクリプトは連想配列を定義しています.
`seen`部分は連想配列オブジェクトで, keyが`$0`とされていますが,これはレコード全体を意味しています.

---|---
`$0`|レコード全体
`$1`|1列目
`$2`|2列目
`$N`|N列目

`++`部分は単なるインクリメント演算子で, keyと合致するレコードが出現するたびに`+1`されます.
操作は変数アクセスされた後に行われます（一回しか出現しないレコードについては0）.

`!seen[$0]++`と否定演算子が用いられていますが, `AWK`では0以外の数値または空でない文字列値は`true`
とされるためです. この処理を噛ますことで, 二回目以降の重複レコードは`False`と評価され, 標準出力から除外されます.

### 別解：`cat <FILE NAME> | sort | uniq`

```zsh
% cat test.csv | sort | uniq
% cat test.csv | (sed -u 1q; sort) | uniq #headerの位置をキープしたい場合
% cat test.csv | (sed -u 1q ;sort) | uniq -c #出現回数をカウントした結果も出力したい場合
```

でも重複レコード排除の結果を返すことはできます. 
`1q`は, 最初の行（ヘッダ）を表示して終了する（残りの入力をソートするために残す）オプションです.
`-u`はメモリ節約のためのオプションと認識していただけたらです.

上記コマンドでは, 出力結果がsortされてしまうので個人的には`gawk`コマンドを用いた処理の方が好ましいと考えています.


## References

> 関連ポスト

- [Ryo's Tech Blog > Linux commandの復習: awkコマンド](https://ryonakagami.github.io/2021/12/16/awk-command-basic/)

> StackExchange

- [UNIX & LINUX how awk seen option works [duplicate]](https://unix.stackexchange.com/questions/604293/how-awk-seen-option-works)
