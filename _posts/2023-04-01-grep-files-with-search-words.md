---
layout: post
title: "grep: List up files with/without match"
subtitle: grep command 1/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-26
tags:

- Linux
- Shell
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`grep`ってなに？](#grep%E3%81%A3%E3%81%A6%E3%81%AA%E3%81%AB)
- [List up files with match](#list-up-files-with-match)
- [オプション解説](#%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E8%A7%A3%E8%AA%AC)
  - [オプション `-l`: grep output to show only matching file](#%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3--l-grep-output-to-show-only-matching-file)
  - [オプション `-r`: Recursiveに検索を実行する](#%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3--r-recursive%E3%81%AB%E6%A4%9C%E7%B4%A2%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## `grep`ってなに？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

What `grep` lets you do is to search for arbitrary pattern of text in one or more files
and there could be an unbounded number of files of input. The input could be coming from 
some other program, for example as it is if you're using Unix pipelines.

</div>


`grep`の実行例を見てみましょう

```zsh
cat sample.txt
abcd
12c3
4567
xybz
```

というファイルが存在するとします．これに対して，`a, b, c`のいずれかの文字を含んだ行を行番号とともに出力したい場合，

```zsh
% grep -n '[abc]' ./sample.txt
```

- `[abc]`とすることで，a,b,cのいずれかが含まれている行を検索
- `-n` optionにより行番号も合わせて出力

という挙動をします．`grep`の歴史を簡単に振り返るには以下の動画がおすすめです．

<br>


<iframe width="560" height="315" src="https://www.youtube.com/embed/NTfOnGZUZDk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

`grep`の名前はText Editor, `ed`の構文に従った `g/regular expression/p` から来ているらしいです.
globalにregrexに合致するlineをprintするという意味らしいです.


## List up files with match

特定のディクトリ以下において, 中身に特定の文字列を含んだファイル一覧を表示させたい場合は以下のコマンドを用います．

```zsh
% grep <search words> -rl <target directory path>
```

> 挙動例

```zsh
% mkdir ./grep_test
% cd ./grep_test

% touch test_{00..05}.md ## test_00.md ... test_05.mdファイルを適当に生成
% echo unko >> test_0[34].md
% touch test_{00..05}.txt  
% echo unko >> test_0[34].txt

% grep unko -rl ./ 
./test_04.md
./test_03.txt
./test_04.txt
./test_03.md

% grep unko -r ./ 
./test_04.md:unko
./test_03.txt:unko
./test_04.txt:unko
./test_03.md:unko
```


> List up files without matches

```zsh
% grep <search words> -rL <target directory path>
```

正確には`-L`を指定することで, `search words`の条件に合致したファイルを除いて出力するという挙動になります.

## オプション解説

今回用いている `grep`コマンドのオプションは `-r`, `-l`, `-L` の3つです.
`man`コマンドで確認してみるとこんな感じです.

```zsh
General Output Control
       -L, --files-without-match
              Suppress normal output; instead print the name of each input file from which no output would normally
              have been printed.  The scanning will stop on the first match.

       -l, --files-with-matches
              Suppress normal output; instead print the name of each input file from which  output  would  normally
              have been printed.  The scanning will stop on the first match.

File and Directory Selection
       -r, --recursive
              Read  all  files  under each directory, recursively, following symbolic links only if they are on the
              command line.  Note that if no file operand is given, grep searches the working directory.   This  is
              equivalent to the -d recurse option.
```

### オプション `-l`: grep output to show only matching file

オプション `-l`は grepコマンドにマッチするlineをsuppressする(=条件に合致したファイル名だけを出力する)オプションです.

```zsh
% grep -l <pattern> <file path>
```

でも特定の文字列を含んだファイル名だけを出力することが出来ます.
ワイルドカードなどと組み合わせることで, 拡張子の指定など柔軟にファイルの検索を実行することが出来ます.

```zsh
% grep unko -l ./*.md
./test_03.md
./test_04.md

% grep unko -l ./*.txt
./test_03.txt
./test_04.txt
```

### オプション `-r`: Recursiveに検索を実行する

特定のディレクトリだけで検索を実行したい場合は`-l`オプションのみで足りますが, 以下のサブディレクトリも含めてrecursiveに検索したい場合は
`-r`オプションを用います.

上の例に倣って以下のようにテスト用ディレクトリとファイルをまず作成します.

```zsh
% mkdir ./grep_test
% cd ./grep_test
% touch test_{00..05}.md ## test_00.md ... test_05.mdファイルを適当に生成
% echo unko >> test_0[34].md
% touch test_{00..05}.txt  
% echo unko >> test_0[34].txt

% mkdir subtest
% touch ./subtest/test_{10..15}.txt
% echo unko >> ./subtest/test_1[125].txt
```

> Recusriveコマンドを用いない場合

```zsh
% grep unko -l ./* 
grep: ./subtest: Is a directory
./test_03.md
./test_03.txt
./test_04.md
./test_04.txt
```

`./subtest: Is a directory`とちょっと怒られた上で, current directory配下のファイルのみしか検索してくれません.

> Recusriveコマンドを用いる場合

```zsh
% grep unko -rl ./
./test_04.md
./subtest/test_11.txt
./subtest/test_12.txt
./subtest/test_15.txt
./test_03.txt
./test_04.txt
./test_03.md
```

ちゃんと検索してくれます. 出力順序はなんか変なのでパイプで`sort`とつなげて出力しても良いかなと思っています.


References
----------

- [ubuntu manuals > ed](https://manpages.ubuntu.com/manpages/trusty/man1/ed.1plan9.html)
- [stackoverflow > grep output to show only matching file](https://stackoverflow.com/questions/3908156/grep-output-to-show-only-matching-file)
- [youtube > Where GREP Came From - Computerphile](https://www.youtube.com/watch?v=NTfOnGZUZDk)
