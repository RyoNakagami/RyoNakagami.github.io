---
layout: post
title: "ファイルリストから日付リストを抽出"
subtitle: "awk command 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-09-28
tags:

- Linux
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem](#problem)
- [Solution 1: ファイル一覧から`yyyy-mm-dd`の形式でsortされた日付リストを取得](#solution-1-%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E4%B8%80%E8%A6%A7%E3%81%8B%E3%82%89yyyy-mm-dd%E3%81%AE%E5%BD%A2%E5%BC%8F%E3%81%A7sort%E3%81%95%E3%82%8C%E3%81%9F%E6%97%A5%E4%BB%98%E3%83%AA%E3%82%B9%E3%83%88%E3%82%92%E5%8F%96%E5%BE%97)
  - [awk: RLENGTH and RSTART](#awk-rlength-and-rstart)
- [Solution 2: 上記で得られたリストから任意の２つの日付の間のdateのみ取得](#solution-2-%E4%B8%8A%E8%A8%98%E3%81%A7%E5%BE%97%E3%82%89%E3%82%8C%E3%81%9F%E3%83%AA%E3%82%B9%E3%83%88%E3%81%8B%E3%82%89%E4%BB%BB%E6%84%8F%E3%81%AE%EF%BC%92%E3%81%A4%E3%81%AE%E6%97%A5%E4%BB%98%E3%81%AE%E9%96%93%E3%81%AEdate%E3%81%AE%E3%81%BF%E5%8F%96%E5%BE%97)
  - [変数定義](#%E5%A4%89%E6%95%B0%E5%AE%9A%E7%BE%A9)
  - [日付の大小関係を評価する](#%E6%97%A5%E4%BB%98%E3%81%AE%E5%A4%A7%E5%B0%8F%E9%96%A2%E4%BF%82%E3%82%92%E8%A9%95%E4%BE%A1%E3%81%99%E3%82%8B)
  - [Summary](#summary)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Problem

カレントディレクトリに`yyyy-mm-dd-<description>.md`というファイルが以下のように存在しているとします.

```zsh
% find . -type f -printf "%f\n"
2021-02-01-order-pizza.md
2021-01-01-Linux-is-awesome.md
2021-07-28-Ubuntu-so-kind.md
2021-03-03-shougi.md
```

このときやりたいことは以下,

1. このファイル一覧から`yyyy-mm-dd`の形式でsortされた日付リストを取得

```
% CMD ./
2021-01-01
2021-02-01
2021-03-01
2021-07-28
```

2. 上記で得られたリストから任意の２つの日付の間のdateのみ取得

```
% CMD ./ 2021-01-02 2021-02-01
2021-01-01
2021-02-01
```

## Solution 1: ファイル一覧から`yyyy-mm-dd`の形式でsortされた日付リストを取得

カレントディレクトリからファイル一覧のみを取得するためには`find`コマンドを以下のように利用すれば良い:

```zsh
% find . -type f
```

ここから日付リストを取得する方法として,

1. シンプルに`grep`を用いる
2. `awk` + `match`を用いる

の２つが考えられます.

```zsh
## grepを用いる場合
% find . -type f -printf "%f\n" | grep -Eo '^[0-9]{4}-[0-9]{2}-[0-9]{2}'

## awk & matchを用いる場合
% find $1 -type f -printf "%f\n" | awk 'match($0, /^[0-9]{4}-[0-9]{2}-[0-9]{2}/){print substr($0, RSTART, RLENGTH)}'
```

### awk: RLENGTH and RSTART

`awk`コマンドで利用可能な`match`関数は, input文字列を対象に `/pattern(regex also available)/` の検索機能を提供してくれます.

```zsh
## 以下の２つは同じ結果を返す
% echo "unko\nkirby" | awk 'match($0, /un/)' 
unko

% echo "unko\nkirby" | grep 'un'
unko
```

`match`関数はmatchした場合, `RSTART` and `RLENGTH`という変数を設定します.

---|---
`RSTART`|検索に合致する文字列の開始場所
`RLENGTH`|検索に合致する文字列の長さ

この２つの変数と`substr`関数を組み合わせることで`grep -o`と似た挙動を再現することができます.

```zsh
% echo '2090-09-01-aaaabbbb\n2001-09-01-kkkkk' | awk 'match($0, /^[0-9]{4}-[0-9]{2}-[0-9]{2}/){print substr($0, RSTART, RLENGTH)}'
2090-09-01
2001-09-01
```

## Solution 2: 上記で得られたリストから任意の２つの日付の間のdateのみ取得

上記のコマンドで日付リストは取得できています. そこからfilterをする方法として `awk`の変数定義と`gensub`関数を利用する方法があります

```zsh
## filter date between 2000-08-01 and 2012-08-31
% echo '2090-09-01\n2010-09-01\n2011-09-01' | awk -v start='2000-08-01'\
 -v end='2012-08-31' -F= '{a=gensub("-", "","g", $1);\
  gsub("-", "", start); gsub("-", "", end)} (a >= start) && (a <= end)'|sort
2010-09-01
2011-09-01

% echo '2090-09-01\n2010-09-01\n2011-09-01' | awk -F= 'BEGIN{start="2000-08-01"; end="2012-08-31"}\
  {a=gensub("-", "","g", $1); gsub("-", "", start); gsub("-", "", end)} (a >= start) && (a <= end)'|sort
2010-09-01
2011-09-01
```

### 変数定義

`awk`コマンドでは`-v`オプションや`BEGIN{}`を組み合わせることで`awk`コマンド内部で利用可能となる変数
の定義ができます.


```zsh
## -vによる変数定義
awk -v varname=value

## BEGIN{}での
awk 'BEGIN { varname=value }'
```

`awk`に与えられた変数を利用して新たな変数を作成する場合は`gensub()`関数を用います

```zsh
## syntax
gensub("置換前", "置換後", "変更箇所(基本は数値, gならばすべて)", 対象カラム)

## yyyy-mm-ddをyyyy/mm/ddへ変更
% echo "2020-09-01" | awk '{date=gensub("-", "/", "g", $1)}{print date}' 
2020/09/01

## １つ目の-のみ置換
% echo "2020-09-01" | awk '{date=gensub("-", "/", 1, $1)}{print date}' 
2020/09-01
```

### 日付の大小関係を評価する

`awk`では条件式に基づいた評価が可能ですが, 日付は文字列として認識されるのでそのままでは大小関係を評価することはできません.
幸いにも今回は日付形式が`yyyy-mm-dd`なので`yyyymmdd`と数値変換しても大小関係は同じになるのでこの特徴を利用します.

方針としては

- `start`, `end`を`yyyy-mm-dd`から`yyyymmdd`へ変換する
- inputとして読み込まれる`yyyy-mm-dd`をベースに`yyyymmdd`形式の変数を**新たに**定義する
- 条件式にあった`yyyy-mm-dd`を返す

その解答が以下:

```zsh
% echo '2090-09-01\n2010-09-01\n2011-09-01' | awk -F= 'BEGIN{start="2000-08-01"; end="2012-08-31"}\
  {a=gensub("-", "","g", $1); gsub("-", "", start); gsub("-", "", end)} (a >= start) && (a <= end)'|sort
```

`gsub("-", "", 変数)`はglobalにsub(=置換)する関数です. 変換位置を"g"に指定した`gensub`の挙動と似ていますが, 
これは変数そのものを変化させる関数です. 今回は`start`, `end`変数は出力させる予定はないので, 直接`gsub`で形式を変換しています.

変換後, `(a >= start) && (a <= end)`評価式に合致するレコードのみを出力するという流れになっています


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: mm/dd/yyyy 形式の場合</ins></p>

`mm/dd/yyyy`の場合はそのまま`mmddyyyy`と変換して大小関係を比較すると厄介なことが起きます. このような場合は, 

- `yyyy`要素
- `mm`要素
- `dd`要素

を個別に取得して, 順番を入れ替えた上で`yyyymmdd`と変換することが必要です. これは`awk`の配列機能を利用することで実現できます.
詳しくは説明しませんが, 解答例は以下

```zsh
% find . -type f | awk 'match($0, /[0-9]{4}-[0-9]{2}-[0-9]{2}/){print substr($0, RSTART, RLENGTH)}'\
    | awk -v start='2022-08-02' -v end='2022-08-31' -F= '{split($1, a, /-/); split(start, b, /-/);\
          split(end, c, /-/)} (a[1]a[2]a[3] >= b[1]b[2]b[3]) && (a[0]a[1]a[2] <= c[0]c[1]c[2])'| sort
```

</div>


### Summary

これをシェルスクリプトに落とし込むと

```zsh
#!/bin/bash
## get date list from start to end
## Author: Ryo Nakagami
## Revised: 2023-08-09

set -e

# var
SEARCH_PATH=$1
START=$2
END=$3

# Functions
function args_error {
    echo 'fatal: start or end missing, date format is yyyymmdd'
    exit 1
}

# Main
if [[ -z $3  ]]; then
    args_error
fi

find $SEARCH_PATH -type f -printf "%f\n" \
| grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}'\
| awk -v start=$START -v end=$END\
      -F= '{date=gensub("-", "", "g", $0); gsub("-", "", start); gsub("-", "", end)}\
           (date >= start) && (date <= end)'\
| sort
```




References
-------------

- [stackoverflow > Shell Script on date filter](https://stackoverflow.com/questions/24394380/shell-script-on-date-filter)
- [RLENGTH and RSTART - Learning AWK Programming](https://www.oreilly.com/library/view/learning-awk-programming/9781788391030/efb344d0-a85a-4af1-8d9d-1b445a3ae1a9.xhtml)