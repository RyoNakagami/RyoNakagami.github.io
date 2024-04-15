---
layout: post
title: "指定した通常ファイルの存在確認"
subtitle: "shell script preprocess 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-15
tags:

- Shell

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Case 1: `if`を用いるケース](#case-1-if%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B%E3%82%B1%E3%83%BC%E3%82%B9)
  - [なぜ二重に `[[ expression ]]` で囲うのか？](#%E3%81%AA%E3%81%9C%E4%BA%8C%E9%87%8D%E3%81%AB--expression--%E3%81%A7%E5%9B%B2%E3%81%86%E3%81%AE%E3%81%8B)
- [Case 2: `find` コマンドを用いるケース(推奨)](#case-2-find-%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B%E3%82%B1%E3%83%BC%E3%82%B9%E6%8E%A8%E5%A5%A8)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Case 1: `if`を用いるケース

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>if command syntax</ins></p>

```bash
if [[ expression ]]; then
    command
fi
```

- `[[ expression ]]`の終了値が 0 であれば `command`が実行される
- 終了値が 0 でなければ, `command`を実行することなくif文を終了

</div>

ファイルの存在判定は, `-e`, `-f` を用いますが以下のような違いがあります:

- `-e`: ファイルが存在すれば真
- `-f`: ファイルが存在し, 通常ファイルならば真 

従って, `x.txt`というファイルが存在するかどうか調べたい場合は,

```bash
# fileが存在するときに処理を走らせたい場合
if [[ -f x.txt ]] ; then
    echo file exists.
    exit 0
fi

# fileが存在しないときに処理を走らせたい場合
if [[ ! -f x.txt ]] ; then
    echo 'File "x.txt" is not there, aborting.'
    exit 1
fi
```

### なぜ二重に `[[ expression ]]` で囲うのか？

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >bashにおける挙動上の差異</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- 変数をダブルクォートで囲う必要性の有無
- escapeの必要性の有無
- `&&`, `||` というand条件, of条件記号の利用可能性
- `=~`によるregex matchingの利用可能性

</div>

基本的には, `[[ ... ]]`を用いることが推奨されています. 

```bash
# 変数をダブルクォートで囲う必要性の有無
file="file name"
[[ -f $file ]] && echo "$file is a regular file"

file="file name"
[ -f "$file" ] && echo "$file is a regular file"
```

複数条件を取り扱う際, 優先順番を明確にする `( ... )` は single square bracketだと, escapeする必要がありますが, 二重だとescapeする必要がなくなり, 書き方が以下のようにコンパクトになります.

```bash
# escapeの必要性とand/or条件
[[ -f $file1 && ( -d $dir1 || -d $dir2 ) ]]

[ -f "$file1" -a \( -d "$dir1" -o -d "$dir2" \) ]
```

また, regexを用いた文字列パターンマッチングも可能になるというメリットもあります.

```bash
# regex expresionの利用可能性
[[ $(date) =~ ^Fri\ ...\ 13 ]] && echo "It's Friday the 13th!"
```

個人的にsingle square bracketの一番イヤな点は, 比較処理の場合です.

- `x > y`: x is greater than or equal to y
- `x \> y`: x is strictly greater than y

```bash
# 以下の場合は, condition passed が表示される
a=1
[ "$a" > 1 ] && echo "condition passed"

# 以下の場合は, condition passed が表示されない
a=1
[[ "$a" > 1 ]] && echo "condition passed"
```

## Case 2: `find` コマンドを用いるケース(推奨)

```zsh
% tree -L 1 -a
.
├── bin             # direcory
├── Desktop         # direcory
├── Documents       # direcory
├── Downloads       # direcory
├── hexaly_setup    # direcory
├── Music           # direcory
├── .zshenv         # file
├── .zshrc          # file
└── .zshrc.backup   # file
```

というカレントディレクトリ構成に対して, `zsh` という文字列を含むファイルが存在するならば `conditioned passed`がターミナル上に出力させたいとします.

```bash
$ find ./ -maxdepth 1 -name ".zsh*" -type f -exec bash -c "echo conditioned passed" {} +
conditioned passed

$ find ./ -maxdepth 1 -name ".zsh*" -type f -exec bash -c "echo conditioned passed" {} \; 
conditioned passed
conditioned passed
conditioned passed
```

- `find`コマンドの`-exec bash -c`は`find`で見つけたファイル or direcotryに対して実行するスクリプトを指定
- `{}`は, `find`コマンドで見つけたオブジェクトの引数で呼ぶ際の位置
- `\;`, `+`の差分は, 前者が逐次実行, 後者は検索結果をすべて一括の一つのスクリプトで同時に処理する場合に用いる



References
----------
- [What is the difference between `test`, `[` and `[[` ?](http://mywiki.wooledge.org/BashFAQ/031)
- [stackoverflow > How to exit a shell script if targeted file doesn't exist?](https://stackoverflow.com/questions/16826657/how-to-exit-a-shell-script-if-targeted-file-doesnt-exist)
- [Ryo's Tech Blog > find & rename files & mv: 条件にあったファイルをmvし一つのディレクトリに集約する](https://ryonakagami.github.io/2023/08/05/find-and-mv-files/)
