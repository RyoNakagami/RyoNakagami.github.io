---
layout: post
title: "split command: split files without irreversible effect"
subtitle: "split a large file into smaller files and recover it"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-08-10
tags:

- Linux
- Shell

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What I want to do](#what-i-want-to-do)
  - [What is `split` command?](#what-is-split-command)
  - [Recover the original file](#recover-the-original-file)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## What I want to do

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>

メモリに乗らないほどの巨大なファイル(`.csv`, `.txt`など)を分割してからそれぞれを読み込んで何かしらの処理を実行したい状況を考えます.
このとき, 内容に悪影響与えることなく & 後ほど復元できる形でファイル分割をするためにはどのようなコマンドを用いればよいのか？

</div>

ファイルサイズが大きくて, そのままではファイル転送ができない場合も上の問題に対するsolutionが活用できます.
このような状況のとき用いるコマンドが`split`コマンドです.

### What is `split` command?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: split command</ins></p>

- `split`コマンドは, ファイルを指定したサイズや個数に分割する
- 分割するファイルの種類には特に制限がなく, テキストファイルを分割することもできる
- デフォルトでは, ファイルを1000行ずつに分割する
- デフォルトでは分割先ファイルのprefixは`x`, suffixは`aa, ab, ....`とアルファベットになる

</div>


helpで確かめてみると

```zsh
% split --help
Usage: split [OPTION]... [FILE [PREFIX]]
Output pieces of FILE to PREFIXaa, PREFIXab, ...;
default size is 1000 lines, and default PREFIX is 'x'.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -a, --suffix-length=N   generate suffixes of length N (default 2)
      --additional-suffix=SUFFIX  append an additional SUFFIX to file names
  -b, --bytes=SIZE        put SIZE bytes per output file
  -C, --line-bytes=SIZE   put at most SIZE bytes of records per output file
  -d                      use numeric suffixes starting at 0, not alphabetic
      --numeric-suffixes[=FROM]  same as -d, but allow setting the start value
  -x                      use hex suffixes starting at 0, not alphabetic
      --hex-suffixes[=FROM]  same as -x, but allow setting the start value
  -e, --elide-empty-files  do not generate empty output files with '-n'
      --filter=COMMAND    write to shell COMMAND; file name is $FILE
  -l, --lines=NUMBER      put NUMBER lines/records per output file
  -n, --number=CHUNKS     generate CHUNKS output files; see explanation below
  -t, --separator=SEP     use SEP instead of newline as the record separator;
                            '\0' (zero) specifies the NUL character
  -u, --unbuffered        immediately copy input to output with '-n r/...'
      --verbose           print a diagnostic just before each
                            output file is opened
      --help     display this help and exit
      --version  output version information and exit

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

CHUNKS may be:
  N       split into N files based on size of input
  K/N     output Kth of N to stdout
  l/N     split into N files without splitting lines/records
  l/K/N   output Kth of N to stdout without splitting lines/records
  r/N     like 'l' but use round robin distribution
  r/K/N   likewise but only output Kth of N to stdout

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Full documentation <https://www.gnu.org/software/coreutils/split>
or available locally via: info '(coreutils) split invocation'
```

**Frequently used options**

---|---|--
`b サイズ`|`--bytes=サイズ`|分割ファイルのサイズを指定する
`-l 行数`|`--lines=行数`|分割ファイルの行数を指定する
`-C サイズ`|`--line-bytes=サイズ`|分割ファイルに含める行の最大サイズを指定する
`-a 長さ`|`--suffix-length=長さ`|接尾辞の長さ（デフォルトは2文字）
`-d`|`--numeric-suffixes`|接尾辞を英字ではなく数字にする（0から開始、「-d 開始番号」で変更可能）
`-n 個数`|`--number=個数`|指定した個数のファイルに分割する. 例えば「-n 5」でファイルを5分割する. 
`-e`|`--elide-empty-files`|-nを使用した際に空のファイルを作成しない
|`--additional-suffix=`|(数字やアルファベットの)suffixの最後につける文字列を指定


### Recover the original file

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

splitで出力したファイルには改行コードなど余分なデータは入っていないので, 順番さえ間違えなければ

```
% cat <split-files> > recovered_file
```

で復元することができます.

</div>

例として, とある`.png` fileがディレクトリに以下のような形で存在しているとします:

```zsh
% ls -lh
total 364K
-rw-rw-r-- 1 kirakira-kirby kirakira-kirby 364K Aug 10 14:13 test.png
```

`split`コマンドを用いて100Kずつのファイルに分割します

```zsh
% split -b 100k --numeric-suffixes=0 test.png splitfile.png.
% ls -lh
total 728K
-rw-rw-r-- 1 kirakira-kirby kirakira-kirby 100K Aug 10 14:26 splitfile.png.00
-rw-rw-r-- 1 kirakira-kirby kirakira-kirby 100K Aug 10 14:26 splitfile.png.01
-rw-rw-r-- 1 kirakira-kirby kirakira-kirby 100K Aug 10 14:26 splitfile.png.02
-rw-rw-r-- 1 kirakira-kirby kirakira-kirby  64K Aug 10 14:26 splitfile.png.03
-rw-rw-r-- 1 kirakira-kirby kirakira-kirby 364K Aug 10 14:13 test.png
```

`splitfile.png.*` filesを統合してファイルの復元をしてから, hash値の比較を実施します

```zsh
% cat splitfile.png.* > recovered_file.png
% md5sum test.png recovered_file.png                                     
b2bccb7daed8e86344cc4b5dfa002deb  test.png
b2bccb7daed8e86344cc4b5dfa002deb  recovered_file.png
```

復元したファイルのハッシュ値が一致しており問題が起きていないと推測できます.
