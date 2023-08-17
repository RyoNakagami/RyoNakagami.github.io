---
layout: post
title: "find command"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-08-16
tags:

- Linux
- shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`find` command](#find-command)
  - [よく使用されるoption](#%E3%82%88%E3%81%8F%E4%BD%BF%E7%94%A8%E3%81%95%E3%82%8C%E3%82%8Boption)
- [検索条件式](#%E6%A4%9C%E7%B4%A2%E6%9D%A1%E4%BB%B6%E5%BC%8F)
  - [ファイルタイプの指定](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%BF%E3%82%A4%E3%83%97%E3%81%AE%E6%8C%87%E5%AE%9A)
  - [日数による検索](#%E6%97%A5%E6%95%B0%E3%81%AB%E3%82%88%E3%82%8B%E6%A4%9C%E7%B4%A2)
  - [探索の深さの指定](#%E6%8E%A2%E7%B4%A2%E3%81%AE%E6%B7%B1%E3%81%95%E3%81%AE%E6%8C%87%E5%AE%9A)
  - [ファイルの所有者の指定](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E6%89%80%E6%9C%89%E8%80%85%E3%81%AE%E6%8C%87%E5%AE%9A)
  - [除外対象を指定する](#%E9%99%A4%E5%A4%96%E5%AF%BE%E8%B1%A1%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B)
  - [ディレクトリごとに検索条件を分けてワンライナーで出力したい場合](#%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%94%E3%81%A8%E3%81%AB%E6%A4%9C%E7%B4%A2%E6%9D%A1%E4%BB%B6%E3%82%92%E5%88%86%E3%81%91%E3%81%A6%E3%83%AF%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%8A%E3%83%BC%E3%81%A7%E5%87%BA%E5%8A%9B%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [ディレクトリ直下のファイル数を表示したい場合](#%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E7%9B%B4%E4%B8%8B%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E6%95%B0%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [file sizeで検索を実行し, 対象のファイル名とディスク使用量を表示する](#file-size%E3%81%A7%E6%A4%9C%E7%B4%A2%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97-%E5%AF%BE%E8%B1%A1%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D%E3%81%A8%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E4%BD%BF%E7%94%A8%E9%87%8F%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## `find` command

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: find command</ins></p>

```zsh
% find [option] <search-directory> <search-condition>
```

- `find`コマンドは, 探索範囲を指定して指定してファイルを検索するコマンド
- ファイルの種類や更新日時など検索条件が設定可能
- マッチしたファイルに対してコマンドを実行させることも可能
- アクセス権がないディレクトリ(=実行権限)の中は検索できない

</div>

ホームディレクトリ直下でファイル名 or ディレクトリ名に "bash" を含むファイルを検索する場合は

```zsh
## ワイルドカードを用いる場合はダブルクォート必要
% find ~ -maxdepth 1 -name "*bash*"
/home/hoshino_kirby/.bashrc
/home/hoshino_kirby/.bash_history
/home/hoshino_kirby/.bash_logout

% find ~ -maxdepth 1 -name "*bash*" 2>/dev/null
/home/hoshino_kirby/.bashrc
/home/hoshino_kirby/.bash_history
/home/hoshino_kirby/.bash_logout
```

権限ない検索場所を検索範囲に含めてしまうと `Permission denied` というエラーが返ってきます.
それを`2>/dev/null`ヌルデバイスにリダイレクトするという形で実行するスクリプトはよく見られます.

### よく使用されるoption

option自体は検索式ではなく, シンボリックリンクをたどる or notという`find`コマンドの挙動を指定するものです

---|---
`-P`|シンボリックリンクをたどらない（デフォルト）
`-L`|全てのシンボリックリンクをたどる



## 検索条件式

permission条件で検索条件を設定する`-perm`など`find`コマンドには便利な条件設定があります.
以下では具体例を交えつつ, 条件式オプションを紹介します.

### ファイルタイプの指定

```zsh
## ファイルタイプの指定を検索条件に含めたいとき
% find <search directory> -type <file type>
```

`-type <file type>`で検索対象のファイルタイプを絞ることができます. 指定できるファイルタイプは以下です:

---|---
`f`|ファイル
`d`|ディレクトリ
`l`|シンボリックリンク

### 日数による検索

`find`コマンドでは日数による検索ができますがどのような日数が指定できるかは以下となります:

---|---
`-atime`|指定した日数をもとに, 最終アクセスされたファイルを検索
`-mtime`|指定した日数をもとに, 最終更新されたファイルを検索

```zsh
## 7日前に最終更新したファイル数
% find /etc -type f -mtime 7 2>/dev/null | wc -l
6

## 7日以内未満に最終更新したファイル数
% find /etc -type f -mtime -7 2>/dev/null | wc -l
16

## 7日以上前(7日目は含まない)に最終更新したファイル数
% find /etc -type f -mtime +7 2>/dev/null | wc -l
2019
```

### 探索の深さの指定

`-maxdepth`に階層数をしていすることで探索の深さを指定することができます.

```zsh
## home directory以下階層３までで探索する場合
% find ~ -maxdepth 3 -name "*bash*"
/home/hoshino_kirby/.bashrc
/home/hoshino_kirby/.bash_history
/home/hoshino_kirby/.vscode/extensions/rogalmic.bash-debug-0.3.9
/home/hoshino_kirby/.pyenv/test/test_helper.bash
/home/hoshino_kirby/.pyenv/src/bash.h
```

### ファイルの所有者の指定

`-uid`や`-user`を検索式で指定することによってファイルやディレクトリの所有者ベースで検索することができます

```zsh
# uidベースで検索
% find /tmp -uid 0

# user-nameベースで検索
% find /tmp -user root
```

### 除外対象を指定する

`<除外条件> -prune -o <検索条件> -print0` と組み合わせることで除外条件と検索条件を組み合わせてファイルリストを出力することができます.

---|---
`<条件> -purne`|条件1に合致したら何もしない
`-o`| or
`-print0`| 結果を出力する

home directory 直下でドットディレクトリ以外の一週間以内に更新があったディレクトリを出力したいとします

```zsh
## ドットディレクトリ以外の一週間以内に更新があったディレクトリ
% find ~/ -maxdepth 1 -mindepth 1 -name ".*" -prune -o \( -type d -mtime -7 -print \)
/home/hoshino_kirby/Downloads
/home/hoshino_kirby/Templates
/home/hoshino_kirby/Documents

## 一週間以内に更新があったディレクトリ
% find ~/ -maxdepth 1 -mindepth 1 \( -type d -mtime -7 -print \) 
/home/hoshino_kirby/Downloads
/home/hoshino_kirby/Templates
/home/hoshino_kirby/.cache
/home/hoshino_kirby/.zoom
/home/hoshino_kirby/.config
/home/hoshino_kirby/Documents
```

### ディレクトリごとに検索条件を分けてワンライナーで出力したい場合

```zsh
% tree
.
├── dir_a
│   ├── file_1
│   └── file_2
├── dir_b
│   ├── dir_a
│   │   └── file_1
│   ├── dir_b
│   │   ├── file_1
│   │   └── file_2
│   ├── file_1
│   └── file_2
└── dir_c
    ├── dir_b
    │   ├── dir_a
    │   │   └── file_1
    │   ├── file_1
    │   └── file_2
    └── file1
```

- `dir_a, dir_b`は直下のファイルのみ出力したい
- `dir_c`は, 所属するすべてのファイルを出力したい

という条件を考えます. この場合, `&&` をうまく使いこなすことで上記ファイルリストを出力することができます.

```zsh
% find ./dir_[ab] -maxdepth 1 -type f && find ./dir_c -type f 
./dir_a/file_2
./dir_a/file_1
./dir_b/file_2
./dir_b/file_1
./dir_c/file1
./dir_c/dir_b/file_2
./dir_c/dir_b/dir_a/file_1
./dir_c/dir_b/file_1

## sortなど標準出力結果をパイプでつなぎたい場合
% (find ./dir_[ab] -maxdepth 1 -type f && find ./dir_c -type f ) | sort
./dir_a/file_1
./dir_a/file_2
./dir_b/file_1
./dir_b/file_2
./dir_c/dir_b/dir_a/file_1
./dir_c/dir_b/file_1
./dir_c/dir_b/file_2
./dir_c/file1
```

### ディレクトリ直下のファイル数を表示したい場合

応用編ですが, `find`の検索結果を用いてファイル数計算などのスクリプトを走らせたい場合, 
`xargs`と組み合わせることで複雑な処理も実行できます.

```zsh
## ディレクトリ直下のファイル数を表示したい場合
% find /var/log -type d 2>/dev/null | xargs -I@ bash -c 'echo "@,$(find "@" -maxdepth 1 -type f 2>/dev/null | wc -l)"'
/var/log,90
/var/log/apache2,11
/var/log/journal,0
/var/log/journal/adasdasdasdas,37
/var/log/cups,8
/var/log/speech-dispatcher,0
/var/log/dist-upgrade,0
/var/log/installer,9
/var/log/gdm3,0
/var/log/unattended-upgrades,6
/var/log/openvpn,0
/var/log/apt,5
```

### file sizeで検索を実行し, 対象のファイル名とディスク使用量を表示する

`-size`検索条件式をもちいることでfile sizeを条件に検索することができます.


```zsh
## 10MB以上のファイル
% find ~/Desktop -size +10M -type f

## 10MB未満のファイル
% find ~/Desktop -size -10M -type f

## 10MB以上のcsvファイルのファイル名とディスク使用量の出力
% find ~/Desktop -size +10M -type f | xargs -i@ bash -c 'echo $(basename "@"),$(du -h "@" | cut -f1)' | egrep "csv,"
test_total.csv,12M
```
