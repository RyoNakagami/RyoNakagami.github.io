---
layout: post
title: "find & rename files & mv: 条件にあったファイルをmvし一つのディレクトリに集約する"
subtitle: "find command 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-09-16
tags:

- Linux
- shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem Setting 1](#problem-setting-1)
  - [解説](#%E8%A7%A3%E8%AA%AC)
    - [file typeの指定](#file-type%E3%81%AE%E6%8C%87%E5%AE%9A)
    - [検索PATHの指定: `-path` option](#%E6%A4%9C%E7%B4%A2path%E3%81%AE%E6%8C%87%E5%AE%9A--path-option)
    - [empty directoryの削除](#empty-directory%E3%81%AE%E5%89%8A%E9%99%A4)
- [Problem Setting 2: file names could not be uniquely assigned](#problem-setting-2-file-names-could-not-be-uniquely-assigned)
  - [解説](#%E8%A7%A3%E8%AA%AC-1)
    - [`-i`, `-l` optionについて](#-i--l-option%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [Appendix: Data Generating Process](#appendix-data-generating-process)
  - [`ptouch` command](#ptouch-command)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Problem Setting 1

カレントディレクトリ以下に以下のような形のフォルダ構造が与えられたとします:

```zsh
% tree
.
├── loc_A
│   ├── dir_a
|   |   ├── file_A_1.csv
|   |   ├── file_A_2.csv
|   |   ├──...
|   |   ├── file_A_8.csv
|   |   └── file_A_9.csv
│   └── dir_b
|       ├── file_A_1.csv
|       ├── file_A_2.csv
|       ├──...
|       ├── file_A_8.csv
|       └── file_A_9.csv
└── loc_B
    ├── dir_a
    |   ├── file_B_1.csv
    |   ├── file_B_2.csv
    |   ├──...
    |   ├── file_B_8.csv
    |   └── file_B_9.csv
    └── dir_b
        ├── file_B_1.csv
        ├── file_B_2.csv
        ├──...
        ├── file_B_8.csv
        └── file_B_9.csv
```

- locationごとに収集したcsv形式ログを`loc_A`, `loc_B`に格納（アンダースコア以下のアルファベットはロケーションを表しているとする）
- `loc_A`と`loc_B`以下にそれぞれ`dir_a`, `dir_b`が与えられている
- `dir_a`, `dir_b`以下にファイルがあるが`file_<location-name>_[1-9].csv`という構造になっている


上記のフォルダ構造をファイルの移動によって以下のような構造に変更したいケースを考えます:

```zsh
% tree
.
├── dir_a
│   ├── file_A_1.csv
│   ├── file_A_2.csv
│   ├── file_A_3.csv
│   ├── file_A_4.csv
│   ├── file_A_5.csv
│   ├── file_A_6.csv
│   ├── file_A_7.csv
│   ├── file_A_8.csv
│   ├── file_A_9.csv
│   ├── file_B_1.csv
│   ├── file_B_2.csv
│   ├── file_B_3.csv
│   ├── file_B_4.csv
│   ├── file_B_5.csv
│   ├── file_B_6.csv
│   ├── file_B_7.csv
│   ├── file_B_8.csv
│   └── file_B_9.csv
└── dir_b
    ├── file_A_1.csv
    ├── file_A_2.csv
    ├── file_A_3.csv
    ├── file_A_4.csv
    ├── file_A_5.csv
    ├── file_A_6.csv
    ├── file_A_7.csv
    ├── file_A_8.csv
    ├── file_A_9.csv
    ├── file_B_1.csv
    ├── file_B_2.csv
    ├── file_B_3.csv
    ├── file_B_4.csv
    ├── file_B_5.csv
    ├── file_B_6.csv
    ├── file_B_7.csv
    ├── file_B_8.csv
    └── file_B_9.csv
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>point</ins></p>

- `dir_a/`, `dir_b`以下のファイルはそれぞれ別の名前になっている
- 移動後, 空になったディレクトリは削除する

</div>

### 解説

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >Solution</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

```zsh
% mkdir ./dir_a ./dir_b
% find . -type f -path '*loc_*/dir_a/*' -name '*.csv' | xargs -I{} mv {} ./dir_a/
% find . -type f -path '*loc_*/dir_b/*' -name '*.csv' | xargs -I{} mv {} ./dir_b/
% find . -type d -empty -delete
```

- 格納場所のdirectoryを先に作成
- `find` commandでファイルリストを取得し, `xargs`を用いて１つずつ`mv`
- 最後に空になったdirectoryを削除


</div>

#### file typeの指定

```zsh
find <search-path> -type f -name '*.csv'
```

|option|説明|
|---|---|
|`-type f`|`f`を指定することでファイルのみを検索対象とする|
|`-name '*.csv'`|`-name`は検索ファイル名を指定するコマンドだが, `.hogehoge`というsurfixルールを活かすこ|とで実質的に拡張子限定をすることができる

なお, UNIX/Linuxでは, 原則としてファイル名に拡張子は必要なく, 基本的にその付与はユーザーやアプリケーションの裁量となることに留意が必要です = `find` commandで拡張子検索はあくまでファイル名検索のパラダイムで実現される.

#### 検索PATHの指定: `-path` option

file nameだけでなく, pathをサーチ条件に含めたい場合は, `-path` optionを利用します. 
ただし, 次の点に留意が必要です:

```
Note that the pattern match test applies to the whole file name, 
starting from one of the start points named on the command line.
```

結局の所, pathを含んだfile nameを対象に検索しているので, 上記のケースでは次のようなコードでも機能します:

```zsh
find . -type f -path '*loc_*/dir_a/*.csv' 
```

`-name` optionとの違いは, 次のメッセージに集約されます:

```
‘-name’ matches against basenames only, 
but the given pattern contains a directory separator (‘/’)
```

#### empty directoryの削除

```zsh
find <search-path> -type d -empty -delete
```

`search-path`以下の空ディレクトリを削除することができます.
通常は見えないドットファイルやドットディレクトリも踏まえた上でempty判定してくれます.

## Problem Setting 2: file names could not be uniquely assigned

上記と異なり, 以下のようにfile nameがかぶっているケースを考えます.

- これを同じく`dir_a`, `dir_b`にassignしたいとします
- assignにあたってfile nameにlocation-name(`loc_A`)を付与した上で移動したいとします

```zsh
% tree
.
├── loc_A
│   ├── dir_a
│   │   ├── file_1.csv
│   │   ├── file_2.csv
│   │   ├── ...
│   │   └── file_9.csv
│   └── dir_b
│       ├── file_1.csv
│       ├── file_2.csv
│       ├── ...
│       └── file_9.csv
└── loc_B
    ├── dir_a
    │   ├── file_1.csv
    │   ├── file_2.csv
    │   ├── ...
    │   └── file_9.csv
    └── dir_b
        ├── file_1.csv
        ├── file_2.csv
        ├── ...
        └── file_9.csv
```

上記の構造から以下の構造へ処理することをゴールとします

```zsh
% tree
.
├── dir_a
│   ├── loc_A_file_1.csv
│   ├── loc_A_file_2.csv
│   ├── loc_A_file_3.csv
│   ├── loc_A_file_4.csv
│   ├── loc_A_file_5.csv
│   ├── loc_A_file_6.csv
│   ├── loc_A_file_7.csv
│   ├── loc_A_file_8.csv
│   ├── loc_A_file_9.csv
│   ├── loc_B_file_1.csv
│   ├── loc_B_file_2.csv
│   ├── loc_B_file_3.csv
│   ├── loc_B_file_4.csv
│   ├── loc_B_file_5.csv
│   ├── loc_B_file_6.csv
│   ├── loc_B_file_7.csv
│   ├── loc_B_file_8.csv
│   └── loc_B_file_9.csv
└── dir_b
    ├── loc_A_file_1.csv
    ├── loc_A_file_2.csv
    ├── loc_A_file_3.csv
    ├── loc_A_file_4.csv
    ├── loc_A_file_5.csv
    ├── loc_A_file_6.csv
    ├── loc_A_file_7.csv
    ├── loc_A_file_8.csv
    ├── loc_A_file_9.csv
    ├── loc_B_file_1.csv
    ├── loc_B_file_2.csv
    ├── loc_B_file_3.csv
    ├── loc_B_file_4.csv
    ├── loc_B_file_5.csv
    ├── loc_B_file_6.csv
    ├── loc_B_file_7.csv
    ├── loc_B_file_8.csv
    └── loc_B_file_9.csv
```

### 解説

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >Solution</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

```zsh
% mkdir ./dir_a ./dir_b
% find . -type f -path '*loc_*/dir_a/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_a\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_a/$(basename $1)'
% find . -type f -path '*loc_*/dir_b/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_b\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_b/$(basename $1)'
% find . -type d -empty -delete
```

- `find` commadでファイルを検索した
- `awk`でoriginal file nameと名称変更後のfile nameを定義 & 出力
- `xargs`で`mv`コマンドを実行する

</div>

`-L` optionがないとdefaultではline by lineで引数を認識してくれないので入れることが必要です.
挙動確認の例として

```zsh
## with -L option
% echo "x y z\na b c" | xargs -L1 bash -c 'echo this is first:$0 second:$1 third:$2'

this is first:x second:y third:z
this is first:a second:b third:c

## without -L option
% echo "x y z\na b c" | xargs bash -c 'echo this is first:$0 second:$1 third:$2'

this is first:x second:y third:z
```

#### `-i`, `-l` optionについて

Note that 

```
The -l and -i options appear in the 1997 version of the POSIX standard,
but  do  not appear in the 2004 version of the standard.  Therefore you
should use -L and -I instead, respectively.
```



## Appendix: Data Generating Process
### `ptouch` command

```bash
$ cat $(which ptouch)
#!/usr/bin/bash
## Author: Ryo Nakagami
## Revised: 2023-08-09

set -e

mkdir -p "$(dirname "$1")" ```zsh
% mkdir ./dir_a ./dir_b
% find . -type f -path '*loc_*/dir_a/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_a\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_a/$(basename $1)'
% find . -type f -path '*loc_*/dir_b/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_b\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_b/$(basename $1)'
% find . -type d -empty -delete
```

- `find` commadでファイルを検索した
- `awk`でoriginal file nameと名称変更後のfile nameを定義 & 出力
- `xargs`で`mv`コマンドを実行する```zsh
% mkdir ./dir_a ./dir_b
% find . -type f -path '*loc_*/dir_a/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_a\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_a/$(basename $1)'
% find . -type f -path '*loc_*/dir_b/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_b\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_b/$(basename $1)'
% find . -type d -empty -delete
```

- `find` commadでファイルを検索した
- `awk`でoriginal file nameと名称変更後のfile nameを定義 & 出力
- `xargs`で`mv`コマンドを実行する```zsh
% mkdir ./dir_a ./dir_b
% find . -type f -path '*loc_*/dir_a/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_a\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_a/$(basename $1)'
% find . -type f -path '*loc_*/dir_b/*' -name '*.csv' |  awk '{X=$1; sub(/\/dir_b\//, "_", X);$1=$1 "\t" X;print $0}' | xargs -L1 bash -c 'mv $0 ./dir_b/$(basename $1)'
% find . -type d -empty -delete
```

- `find` commadでファイルを検索した
- `awk`でoriginal file nameと名称変更後のfile nameを定義 & 出力
- `xargs`で`mv`コマンドを実行する&& touch "$1"
```

### data generating process

```zsh
% for loc in {A..B}; do for n ({1..9}); do ptouch "./loc_$loc/dir_a/file_${loc}_$n.csv"; done; done
% for loc in {A..B}; do for n ({1..9}); do ptouch ./loc_$loc/dir_b/file_${loc}_$n.csv; done; done
% tree
.
├── loc_A
│   ├── dir_a
│   │   ├── file_A_1.csv
│   │   ├── file_A_2.csv
│   │   ├── file_A_3.csv
│   │   ├── file_A_4.csv
│   │   ├── file_A_5.csv
│   │   ├── file_A_6.csv
│   │   ├── file_A_7.csv
│   │   ├── file_A_8.csv
│   │   └── file_A_9.csv
│   └── dir_b
│       ├── file_A_1.csv
│       ├── file_A_2.csv
│       ├── file_A_3.csv
│       ├── file_A_4.csv
│       ├── file_A_5.csv
│       ├── file_A_6.csv
│       ├── file_A_7.csv
│       ├── file_A_8.csv
│       └── file_A_9.csv
└── loc_B
    ├── dir_a
    │   ├── file_B_1.csv
    │   ├── file_B_2.csv
    │   ├── file_B_3.csv
    │   ├── file_B_4.csv
    │   ├── file_B_5.csv
    │   ├── file_B_6.csv
    │   ├── file_B_7.csv
    │   ├── file_B_8.csv
    │   └── file_B_9.csv
    └── dir_b
        ├── file_B_1.csv
        ├── file_B_2.csv
        ├── file_B_3.csv
        ├── file_B_4.csv
        ├── file_B_5.csv
        ├── file_B_6.csv
        ├── file_B_7.csv
        ├── file_B_8.csv
        └── file_B_9.csv
```




References
-------------------

- [StackExchange > Find files in specific directories](https://unix.stackexchange.com/questions/479349/find-files-in-specific-directories)
- [stackoverflow > xargs with multiple arguments](https://stackoverflow.com/questions/3770432/xargs-with-multiple-arguments)