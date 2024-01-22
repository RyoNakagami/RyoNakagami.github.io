---
layout: post
title: "S3上のディレクトリを任意のLocal Directoryへコピーする"
subtitle : "AWS CLI Command 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2024-01-22
tags:

- aws
- cloud

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [AWS `cp`と`sync`コマンド](#aws-cp%E3%81%A8sync%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [How to Use `aws cp` and `aws sync`](#how-to-use-aws-cp-and-aws-sync)
  - [`--dryrun` optionのススメ](#--dryrun-option%E3%81%AE%E3%82%B9%E3%82%B9%E3%83%A1)
- [特定のディレクトリやファイルのみをコピーしたい場合](#%E7%89%B9%E5%AE%9A%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%84%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%81%BF%E3%82%92%E3%82%B3%E3%83%94%E3%83%BC%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
    - [Filterコマンドの例](#filter%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E4%BE%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## AWS `cp`と`sync`コマンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: aws cp and sync</ins></p>

`aws cp`コマンドは[cp — AWS CLI Latest Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html)によると

- Copies a local file or S3 object to another location locally or in S3.

一方, `aws sync`コマンドは[sync - AWS CLI Latest Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/sync.html)によると

- Syncs directories and S3 prefixes. Recursively copies new and updated files from the source directory to the destination.

</div>

`aws cp`はオブジェクトをコピーするコマンドであるのに対し, `aws sync`は**対象ディレクトリ内部の新規作成または更新されたファイル**について同期するコマンドです. 実際に使うにあたって意識すべき挙動の差は以下です

- `aws cp`: destination areaにファイルがすでにあろうがなかろうがコピーする
- `aws sync`: 同期の前にdestination areaを一度見て, 新規作成 or 更新があったものについてのみ同期する

`aws sync`はコピーの前にファイルのメタデータを参照するので, updateなどの場合は`aws cp`よりもパフォーマンスが良いですが, 新規にすべてのファイルをコピーする場合は`aws cp`の方がパフォーマンスが良くなります.

### How to Use `aws cp` and `aws sync`

S3バケットの特定のディレクトリをローカルへコピーする場合, 

- `aws sync`: `source`と`destination`のPATHを指定
- `aws cp`: `source`と`destination`のPATHを指定 + `--recursive` optionの追加

という差異があります. 基本構文は以下です:

```zsh
## aws sync
% aws s3 sync "s3://source-path" <destination-path>

## aws cp
% aws s3 cp --recursive "s3://source-path" <destination-path>
```

### `--dryrun` optionのススメ

いきなり思いついたスクリプトを実行すると誤ってファイルを消してしまったり, 想定外のバケットに対して処理を始めてしまうリスクがあります. そのため, スクリプトを実行する前に `--dryrun` optionを用いて, どのような挙動になるかテストすることが推奨されます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Option: --dryrun</ins></p>

`--dryrun` :  (boolean) Displays the operations that would be performed using the specified command without actually running them.

利用例:

```zsh
% aws s3 sync --dryrun "s3://source-path" <destination-path>
```

</div>


## 特定のディレクトリやファイルのみをコピーしたい場合

コピーや同期の対象オブジェクトを指定した条件でfilterしたい場合, `--exclude`と`--include`を組み合わせて用います.
条件指定に方法と`--exclude`と`--include`組み合わせルールについてまず確認します.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Rule 1: Filter Valueのパターン</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

除外や含むパターンを指定する場合`--exclude "<value>"`, `--include "<value>"`という形で指定しますが, 
`"<value>"`で指定できるパターンの書き方は以下となります

- `*`: Matches everything
- `?`: Matches any single character
- `[sequence]`: Matches any character in sequence
- `[!sequence]`: Matches any character not in sequence

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Rule2: 指定の順番と効力</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

Filter条件が複数指定された場合, 後者の方の効力が優先する. つまり, 

```zsh
--exclude "*" --include "*.txt"
```

と指定すると, 一旦すべてのファイルを除外してから, `.txt`拡張子のファイルを連携する(=`.txt`拡張子のみ連携する)挙動になります. 一方,

```zsh
--include "*.txt" --exclude "*"
```

の順番で指定すると, `*`に該当するオブジェクト（＝すべてのオブジェクト）が除外されます.

</div>

<br>

#### Filterコマンドの例

```
s3://hogehoge
  ├── diary
  │   ├── 2022-01-01.csv
  │   ├── 2022-02-01.csv
  │   ├── 2023-01-01.csv
  │   └── 2023-02-01.csv
  ├── foo.txt
  ├── bar.txt
  └── baz.jpg
```

という構成のS3バケット`hogehoge`が与えられたとします. これをローカルのカレントディレクト以下にある空の`sandbox`ディレクトリにコピーする場合

```zsh
% aws s3 cp --recursive "s3://hogehoge" ./sandbox --exclude "*" --include "*.csv"
```

とすると, ローカル側では

```
./sandbox
  └── diary
      ├── 2022-01-01.csv
      ├── 2022-02-01.csv
      ├── 2023-01-01.csv
      └── 2023-02-01.csv
```

となります.

```zsh
% aws s3 cp --recursive "s3://hogehoge" ./sandbox --exclude "*.csv" 
```

と実行すると

```
s3://hogehoge
  ├── foo.txt
  ├── bar.txt
  └── baz.jpg
```

さらに, 2023年のcsvファイルのみ連携させたい場合は

```zsh
% aws s3 cp --recursive "s3://hogehoge" ./sandbox --exclude "*" --include "*2023-0[12]-01.csv"
```

と実行すると

```
./sandbox
  └── diary
      ├── 2023-01-01.csv
      └── 2023-02-01.csv
```





References
-----------
- [cp — AWS CLI Latest Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html)
- [sync — AWS CLI Latest Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/sync.html)
- [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters)
