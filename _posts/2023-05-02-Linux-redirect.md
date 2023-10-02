---
layout: post
title: "Linux: 標準出力とリダイレクト"
subtitle: "terminal出力結果をコントロールする"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-09-28
tags:

- shell
- Linux

---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [はじめに: 標準入出力とリダイレクトの関係](#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB-%E6%A8%99%E6%BA%96%E5%85%A5%E5%87%BA%E5%8A%9B%E3%81%A8%E3%83%AA%E3%83%80%E3%82%A4%E3%83%AC%E3%82%AF%E3%83%88%E3%81%AE%E9%96%A2%E4%BF%82)
- [標準出入力](#%E6%A8%99%E6%BA%96%E5%87%BA%E5%85%A5%E5%8A%9B)
  - [ファイル記述子](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E8%A8%98%E8%BF%B0%E5%AD%90)
- [リダイレクトとパイプ](#%E3%83%AA%E3%83%80%E3%82%A4%E3%83%AC%E3%82%AF%E3%83%88%E3%81%A8%E3%83%91%E3%82%A4%E3%83%97)
  - [リダイレクト](#%E3%83%AA%E3%83%80%E3%82%A4%E3%83%AC%E3%82%AF%E3%83%88)
  - [パイプ](#%E3%83%91%E3%82%A4%E3%83%97)
- [Tips: 実務で役に立つ事例集](#tips-%E5%AE%9F%E5%8B%99%E3%81%A7%E5%BD%B9%E3%81%AB%E7%AB%8B%E3%81%A4%E4%BA%8B%E4%BE%8B%E9%9B%86)
  - [エラーメッセージを出力しない](#%E3%82%A8%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%82%92%E5%87%BA%E5%8A%9B%E3%81%97%E3%81%AA%E3%81%84)
  - [エラーメッセージのみ出力させる場合](#%E3%82%A8%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%81%AE%E3%81%BF%E5%87%BA%E5%8A%9B%E3%81%95%E3%81%9B%E3%82%8B%E5%A0%B4%E5%90%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## はじめに: 標準入出力とリダイレクトの関係

コンピューターの世界には, データの「入力」と「出力」という流れ(=**Data Streams**)があります. 特に, キーボードからの入力を**標準入力**, 
ディスプレイへの出力を**標準出力**と呼びます.

多くのコマンドは, 何も指定しなくても実行結果をディスプレイに表示しますが, これは標準出力としてディスプレイを使うことが
デフォルトとして設定されているためです. 

一方, この標準出入力先を変更する機能のことを**リダイレクト**といいます. 標準出入力とリダイレクトを理解することで,
コマンドがなにを出力するのかをコントロールできます.

## 標準出入力

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: stdin, stdout, stderr</ins></p>

---|---|---
標準入力|standard input, stdin |コマンドが標準的に利用するデータ入力元, 通常はキーボード
標準出力|standard output, stdout |コマンドが標準的に利用するデータ出力先, 通常はディスプレイ
標準エラー出力|standard error, stderr |コマンドのエラーメッセージは, 通常の出力とは区別されるが, 通常は標準出力同様にディスプレイ

</div>

トラブルが起きてエラー出力を行う必要がある場合に, **標準エラー出力(=stderr)**というものがあります.
通常, 標準エラー出力はディスプレイになりますが, 後に説明するリダイレクトを使用することで, ファイルに出力する使い方もあります.


### ファイル記述子

全てのプロセスは**ファイルディスクリプタ (fd: file descriptor, ファイル記述子)**というファイル書き込み用の通信チャネルを持っています.

|入出力チャネル|ファイル記述子|
|---|---|
|標準入力|0|
|標準出力|1|
|標準エラー|2|



## リダイレクトとパイプ
### リダイレクト

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>リダイレクトの代表例</ins></p>

---|---
`< FileA`|標準入力をFileAに変更
`> FileA`|標準出力をFileAに変更
`>> FileA`|標準出力をFileAの末尾に追記
`2> FileA`|標準エラー出力をFileAに変更
`2>> FileA`|標準エラー出力をFileAの末尾に追記
`> FileA 2>&1`|標準出力と標準エラー出力をまとめてFileAに変更
`&> FileA`|標準出力と標準エラー出力をまとめてFileAに変更
`>& FileA`|標準出力と標準エラー出力をまとめてFileAに変更

</div>


ファイル記述子を組み合わせることでリダイレクト対象を制御することができます. 
例えば, `ls`の標準出力結果を fileAへ新規に書き込む場合, ファイル記述子を利用するパターンと利用しないパターンで以下のように書くことができます

```zsh
## リダイレクトのみ
% ls > fileA

## ファイル記述子を利用
% ls 1> fileA
```

`FileA`の内容を並び替えて, その結果を別のファイル`FileB`に保存する場合

```zsh
% sort < FileA > FileB
```

> 構文まとめ

```zsh
## CMD標準出力結果をfileAへ格納
% CMD > fileA
% CMD 1> fileA

## CMD標準出力結果をfileAへ追記する
% CMD >> fileA
% CMD 1>> fileA

## lsコマンドを実行して標準エラー出力結果(non-exist-file)のみをfileAに格納する
% ls exist-file non-exist-file 2> fileA

## lsコマンドを実行して標準出力及びエラー出力結果両方をfileAに格納する
% ls exist-file non-exist-file &> fileA
% ls exist-file non-exist-file >& fileA
% ls exist-file non-exist-file 1> fileA 2>&1
% ls > fileA exist-file non-exist-file 2>&1
```

### パイプ

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: パイプ</ins></p>

コマンド日よって得られた結果を別コマンドに引き渡す機能のことをパイプと呼ぶ.

`CMD1`の実行結果を`CMD2`の標準入力に渡す場合,

```zsh
% CMD1 | CMD2
```

</div>

標準出力と標準エラー出力をまとめてパイプで渡したい場合は, `2>&1 |`, または `|&` を用います.
`sed`コマンドに引数を渡さずに実行すると, 標準エラー出力として使用方法が出てきますが, そのラインをカウントしたい場合は

```zsh
## 標準エラー出力用のパイプ
% sed |& wc -l

## ファイル記述子とパイプの組み合わせ
% sed 2>&1 | wc -l
```

## Tips: 実務で役に立つ事例集
### エラーメッセージを出力しない

エラーメッセージをterminalへ出力したくない場合は `2> /dev/null` で標準エラーメッセージを `/dev/null`へリダイレクトします.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: 疑似ファイルデバイスとしての/dev/null </ins></p>

Linux系OSでは `/dev/null` という疑似デバイスファイルを用意してある. 
`/dev/null` に書き込まれたデータはすべて破棄され, どこからどれだけ読み込んでも何もデータを返さない.

</div>

標準出力と標準エラー出力両方を出力させない場合は以下のようにリダイレクトを用います

```zsh
## 標準出力と標準エラー出力両方を出力させない場合
% echo 'stderr' >& /dev/null
% echo 'stderr' &> /dev/null
% echo 'stderr' > /dev/null 2>&1
```

エラーメッセージのみ出力させたくない場合は

```zsh
% echo 'stderr' 2> /dev/null
```

### エラーメッセージのみ出力させる場合

- 標準出力結果を`/dev/null`へ捨てる
- 標準エラー出力を標準出力へ渡す

という形で実行します

```zsh
## CMD1のエラー出力のみをCMD2へ渡す
% (CMD1 > /dev/null) |& CMD2

## CMD1のエラーを標準出力, 標準出力を/dev/nullに捨てる場合
% (CMD1 2>&1 1> /dev/null) | CMD2
```

注意点として, ２つ目の例と似てるけれども違う挙動してしまうのが

```zsh
% (CMD1 1> /dev/null 2>&1 ) | CMD2
```

これは先に標準出力先が先に`/dev/null`となり, 標準エラーが標準出力の順番なのですべてが`/dev/null`に捨てられてしまう設定になります.




<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: poetryで標準エラー出力のみを出力する場合</ins></p>

`poetry`コマンドを用いるときなど, 標準出力結果には興味がないがエラーだけ知りたいという場合があります.
この場合は

```zsh
% poetry update 1> /dev/null
% poetry update > /dev/null
```

</div>



References
------------

- [UNIXの絵本, 株式会社アンク著](https://www.shoeisha.co.jp/book/detail/4798109339)
- [Linux Crash Course - Data Streams (stdin, stdout & stderr)](https://www.youtube.com/watch?v=zMKacHGuIHI)