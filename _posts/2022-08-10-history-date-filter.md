---
layout: post
title: "shell historyをtimestampでフィルターする"
subtitle: "awk command 3/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: true
last_modified_at: 2024-04-09
header-mask: 0.0
header-style: text
tags:

- Linux
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回作成したシェルスクリプト](#%E4%BB%8A%E5%9B%9E%E4%BD%9C%E6%88%90%E3%81%97%E3%81%9F%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88)
- [コマンド解説](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E8%A7%A3%E8%AA%AC)
  - [日付 から unixtime への変換方法](#%E6%97%A5%E4%BB%98-%E3%81%8B%E3%82%89-unixtime-%E3%81%B8%E3%81%AE%E5%A4%89%E6%8F%9B%E6%96%B9%E6%B3%95)
  - [awk commandでのfilter](#awk-command%E3%81%A7%E3%81%AEfilter)
  - [変数定義: `awk -v var=value`](#%E5%A4%89%E6%95%B0%E5%AE%9A%E7%BE%A9-awk--v-varvalue)
  - [unixtime カラムのtimestamp型への変換](#unixtime-%E3%82%AB%E3%83%A9%E3%83%A0%E3%81%AEtimestamp%E5%9E%8B%E3%81%B8%E3%81%AE%E5%A4%89%E6%8F%9B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 今回作成したシェルスクリプト

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >仕様</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

- `START`と`END`の２つのtimestampを指定
- `~/.zsh.d/.zsh_history`に格納されたzsh historyから, `START`と`END`の範囲内(境界含む)の履歴を抽出し, 標準出力
- コマンドの実行時刻はhuman readableな形へ変換する

</div>

<br>

今回作成したシェルスクリプトは以下です. なおファイルパーミッションは `700` で指定しています.

```bash
#!/bin/bash
## grep the history file with search words
## Author: Ryo Nakagami
## Revised: 2024-04-09
## REQUIREMENT: gawk

set -e

# Variable
HISTORYFILE=~/.zsh.d/.zsh_history
START_UNIX_TIME=$(date +%s --date $1)
END_UNIX_TIME=$(date +%s --date $2)

# Main
cat $HISTORYFILE |
    awk -v start=$START_UNIX_TIME -v end=$END_UNIX_TIME -F":" \
        '($2 >= start) && ($2 <= end)\
        {$2=strftime("%Y-%m-%d %H:%M:%S", $2)";"; print $0}'

```

## コマンド解説
### 日付 から unixtime への変換方法

`~/.zsh.d/.zsh_history`には以下のようにunixtime形式で実行時刻が格納されています

```zsh
% cat ~/.zsh.d/.zsh_history | head -5
: 1690174802:0;history
: 1690174804:0;ls
: 1690174807:0;ls -a
: 1690174823:0;ls -l
: 1690174824:0;ls
```

そのため, timestampでfilterを実施する際にはunixtimeへの変換が必要になります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>date command</ins></p>

- `date` コマンドに `+%s` 引数をつけると unixtime で表示
- 特定の日付を変換したいときは、`–date` オプションを利用

</div>

```zsh
# 現在時刻のunixtime
% date +%s
1712646571

# 特定の日付変換
% date +%s --date 2021-01-01
1609426800

% date +%s --date '2021-01-01 00:01:00'
1609426860
```

### awk commandでのfilter

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>awk syntax</ins></p>

```zsh
% awk 'pattern { action }'
```

- パターンは入力レコードをベースに指定されたregex や expressionを用いてマッチ判定を行う
- アクションの目的はawkに対してパターンがマッチしたときに何を行うかを示す

</div>

今回は, `:`でseperateされた列の２列目がunixtimeにあたるので`$2`を対象に入力されたtimestampとの比較を行絵ば良いことになります.

```zsh
cat $HISTORYFILE |
    awk -v start=$START_UNIX_TIME -v end=$END_UNIX_TIME -F":" \
        '($2 >= start) && ($2 <= end)\
        {$2=strftime("%Y-%m-%d %H:%M:%S", $2)";"; print $0}'
```

パターンの指定は `($2 >= start) && ($2 <= end)` が該当箇所となります.
`start`, `end`は `awk` コマンド実行時に定義した変数となります. 

### 変数定義: `awk -v var=value`

awkのプログラムに, 変数を渡すにあたって

```zsh
% awk -v var=value
```

を用いています. 複数渡したい場合は, 上記の例のように

```zsh
% awk -v start=$START_UNIX_TIME -v end=$END_UNIX_TIME 
```

### unixtime カラムのtimestamp型への変換

`awk`でもアクションにて以下の前半でunixtime カラムのtimestamp型への変換を実施しています

```zsh
{$2=strftime("%Y-%m-%d %H:%M:%S", $2)";"; print $0}
```

`strftime()`関数はフォーマットとUnix時間を引数として変換する関数です.
その実行結果を `$2` という形で2カラム目に代入しています.


References
----------
- [Ryo's Tech Blog > ファイルリストから日付リストを抽出](https://ryonakagami.github.io/2022/08/08/awk-date-filter/)