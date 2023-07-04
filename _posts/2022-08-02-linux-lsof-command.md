---
layout: post
title: "lsof: list open files"
subtitle: "Linux command 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-08-04
reading_time:
tags:

- Linux
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is `lsof` command?](#what-is-lsof-command)
  - [FD, file descriptor,の種類](#fd-file-descriptor%E3%81%AE%E7%A8%AE%E9%A1%9E)
    - [FDカラムに出現する特定の文字列](#fd%E3%82%AB%E3%83%A9%E3%83%A0%E3%81%AB%E5%87%BA%E7%8F%BE%E3%81%99%E3%82%8B%E7%89%B9%E5%AE%9A%E3%81%AE%E6%96%87%E5%AD%97%E5%88%97)
    - [`数字` + `アルファベット`の組合せパターン](#%E6%95%B0%E5%AD%97--%E3%82%A2%E3%83%AB%E3%83%95%E3%82%A1%E3%83%99%E3%83%83%E3%83%88%E3%81%AE%E7%B5%84%E5%90%88%E3%81%9B%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
  - [fuse.gvfsd-fuse warning](#fusegvfsd-fuse-warning)
- [List opened files with a condition](#list-opened-files-with-a-condition)
  - [How do we combine multiple conditions: `AND`/`OR`](#how-do-we-combine-multiple-conditions-andor)
  - [Output the process ID that matches the condition](#output-the-process-id-that-matches-the-condition)
- [Tips](#tips)
  - [output based on the FD status](#output-based-on-the-fd-status)
- [Appendix: Inode number(index node number)](#appendix-inode-numberindex-node-number)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What is `lsof` command?

`lsof` commandはオープンしているファイルを一覧表示するコマンドです.
引数なしの出力を確認してみます:

```zsh
% lsof | head
lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/125/gvfs
      Output information may be incomplete.
COMMAND     PID   TID TASKCMD               USER   FD      TYPE             DEVICE  SIZE/OFF       NODE NAME
systemd       1                             root  cwd   unknown                                         /proc/1/cwd (readlink: Permission denied)
systemd       1                             root  rtd   unknown                                         /proc/1/root (readlink: Permission denied)
systemd       1                             root  txt   unknown                                         /proc/1/exe (readlink: Permission denied)
systemd       1                             root NOFD                                                   /proc/1/fd (opendir: Permission denied)
kthreadd      2                             root  cwd   unknown                                         /proc/2/cwd (readlink: Permission denied)
kthreadd      2                             root  rtd   unknown                                         /proc/2/root (readlink: Permission denied)
kthreadd      2                             root  txt   unknown                                         /proc/2/exe (readlink: Permission denied)
kthreadd      2                             root NOFD                                                   /proc/2/fd (opendir: Permission denied)
rcu_gp        3                             root  cwd   unknown                                         /proc/3/cwd (readlink: Permission denied)
```

defaultでの表示項目は

---|---
COMMAND|ファイルを開いているプロセスのコマンド名
PID|process id
TID|thread identifier
TASKCMD|task command
USER|processをcreateしたユーザー名
FD |file descriptor
TYPE|種類(directory, file, and so on)
DEVICE|デバイス
SIZE/OFF|ファイルサイズまたはオフセット
NODE|i-node number
NAME|openの対象となるファイル名


### FD, file descriptor,の種類 

FDカラムに出現するオブジェクトは大きく分けて２つのパターンがあります:

- 特定の文字列
- `数字` + `アルファベット`の組合せパターン


#### FDカラムに出現する特定の文字列

---|---
`cwd`|Current Working Directory
`txt`|Text file
`mem`|Memory mapped file
`mmap`|Memory mapped device

#### `数字` + `アルファベット`の組合せパターン

`1u`というパターンの場合, 標準出力によるread and writeモードを表しています

- 数字: 標準入出力0～2, シェル以外のプロセスはに続く3番以降を使用
- alphabet: ファイルが開かれているモード

> standard file descriptor numeric value

---|---
`0`| Standard input (stdin)
`1`| Standard output (stdout)
`2`| Standard error (stderr)


> Alphabet Rule

---|---
`r`|read access
`w`|write access
`u`|both of read and write access
`R`| a read lock on the entire file;
`W`| a write lock on the entire file;
`U`| a lock of unknown type;

### fuse.gvfsd-fuse warning

`lsof`コマンドはdefaultではmountされたfile system全てに対して動作します. 一方, `FUSU` を用いてmountされた`GVFS`ファイルは, mountしたUSER(=`gvfsd-fuse`)以外のアクセスを拒否する挙動となっており, `gvfsd-fuse`でないならば管理者権限のあるユーザからもアクセスできないようになっています.

そのため, `lsof`が動作しませんというwarningが出力される訳となります.　基本的には無視してかまわないものです.


対処方法を知りたい場合は, [stackExchange > lsof: WARNING: can't stat() fuse.gvfsd-fuse file system](https://unix.stackexchange.com/questions/171519/lsof-warning-cant-stat-fuse-gvfsd-fuse-file-system)を確認してください.

## List opened files with a condition

`lsof`コマンドを用いて興味のあるprocessを検索したい場合は効率的に検索が掛けられるようになる必要があります. 執筆時点でのUbuntu OS上で開かれているファイル数を検索すると

```zsh
% lsof | wc -l
lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/125/gvfs
      Output information may be incomplete.
907374
```

と人間の目で検索するには大変すぎるラインがあることがわかります.
検索するにあたって, `grep`, `awk`を用いるのも一つの手段ですが, `lsof`にbuilt-inとして組み込まれている検索オプションを理解すると便利です. 以下, 代表的なものを紹介します.

> List opened files by a specified user

```zsh
% lsof -u <username>
```

特定のuser以外という条件でsearchする場合は

```zsh
% lsof -u ^<username>
```


> List opened files by a specified command

```zsh
% lsof -c <command>
```

> List opened files under a directory

```zsh
% lsof +D <directory>
```

> List all open files by a specific process

```zsh
% lsof -p <process-id>
```

> List all open files at a specified port

```zsh
% lsof -i:<port-number>
```

複数のportで検索したい場合は

```zsh
% lsof -i:<port-number>,<port-number>
```


### How do we combine multiple conditions: `AND`/`OR`

Defaultでは複数条件を組み合わせると, `OR`条件で検索が走る挙動となっています:

```zsh
% lsof -u hoge -c systemd |head
lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/125/gvfs
      Output information may be incomplete.
COMMAND     PID             USER   FD      TYPE             DEVICE  SIZE/OFF       NODE NAME
systemd       1             root  cwd   unknown                                         /proc/1/cwd (readlink: Permission denied)
systemd       1             root  rtd   unknown                                         /proc/1/root (readlink: Permission denied)
systemd       1             root  txt   unknown                                         /proc/1/exe (readlink: Permission denied)
systemd       1             root NOFD                                                   /proc/1/fd (opendir: Permission denied)
systemd-j   325             root  cwd   unknown                                         /proc/325/cwd (readlink: Permission denied)
systemd-j   325             root  rtd   unknown                                         /proc/325/root (readlink: Permission denied)
systemd-j   325             root  txt   unknown                                         /proc/325/exe (readlink: Permission denied)
systemd-j   325             root NOFD                                                   /proc/325/fd (opendir: Permission denied)
systemd-u   379             root  cwd   unknown                                         /proc/379/cwd (readlink: Permission denied)

```

`hoge`と指定したにもかかわらず, `head`で確認できる範囲内はUSERは`root`となっています. この`OR`条件を`AND`条件へ変更したい場合は`-a` optionを最後に付与します.

```zsh
% lsof -u hoge -c systemd -a |head   
lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/125/gvfs
      Output information may be incomplete.
COMMAND  PID    USER   FD      TYPE             DEVICE SIZE/OFF       NODE NAME
systemd 1934 hoge  cwd       DIR              259,3     4096          2 /
systemd 1934 hoge  rtd       DIR              259,3     4096          2 /
systemd 1934 hoge  txt       REG              259,3  1620224     927712 /usr/lib/systemd/systemd
systemd 1934 hoge  mem       REG              259,3  1369384     922181 /usr/lib/x86_64-linux-gnu/libm-2.31.so
systemd 1934 hoge  mem       REG              259,3   178528     923096 /usr/lib/x86_64-linux-gnu/libudev.so.1.6.17
systemd 1934 hoge  mem       REG              259,3  1575112     926081 /usr/lib/x86_64-linux-gnu/libunistring.so.2.1.0
systemd 1934 hoge  mem       REG              259,3   137584     925304 /usr/lib/x86_64-linux-gnu/libgpg-error.so.0.28.0
systemd 1934 hoge  mem       REG              259,3    67912     925517 /usr/lib/x86_64-linux-gnu/libjson-c.so.4.0.0
systemd 1934 hoge  mem       REG              259,3    34872     924835 /usr/lib/x86_64-linux-gnu/libargon2.so.1
```

USERが`hoge`だけになっており, 出力内容が`AND`条件に基づいているとわかります.


### Output the process ID that matches the condition

特定の条件に従って`lsof`を出力する場合, 条件に合致したprocessのpidを`kill`したいなどが要望として多くのケースあります. `lsof`から目件でPIDを確認するという方法もありますが, `-t` optionを用いることで, PIDを効率的に出力することが出来ます: 

```zsh
% lsof -t -u hoge -c systemd -a
1934
```

これをpipeや`$()`を用いてコマンドを組合せて使用したりします. 例として, 

```zsh
% kill -9 $(lsof -t -u hoge)
```

このコマンドによって, USER hogeによるprocess全てをkillすることができます.
なお, `<filename>`を引数で用いる際は, `lsof -t <filename>`としてください.

> Example: kill the process which access to `/var/log/bad.log`

とあるサーバー上のプログラムが継続的に`/var/log/bad.log`に書き込みを行っており, そのためserver storageが逼迫しています.
`/var/log/bad.log`にアクセスしているプログラムをまとめてkillしたい場合は

```bash
$ lsof /var/log/bad.log
COMMAND   PID   USER   FD   TYPE DEVICE SIZE/OFF  NODE NAME
badlog.py 618 ubuntu    3w   REG  259,1     7696 67701 /var/log/bad.log
$ kill $(lsof -t /var/log/bad.log)
```

## Tips
### output based on the FD status

`lsof`コマンドにはFD statusに応じて検索を掛けられる機能はdefaultでは存在しません.
特定の`<filename>`に対して, 書き込み動作をしているprocessを検索したい場合は`awk`をpipeで繋いで以下のように入力します.

```zsh
## file version
% lsof <filename>| awk '(NR == 1) || ($4 ~ "[0-9]{1,}[a-z]{1,}[UNR]{0,}" && $4 ~ "[uw]" && NF == 9) || ($6 ~ "[0-9]{1,}[a-z]{1,}[UNR]{0,}" && $6 ~ "[uw]" && NF == 11 )  {print $0}'

## directory version
lsof +D <directory>| awk '(NR == 1) || ($4 ~ "[0-9]{1,}[a-z]{1,}[UNR]{0,}" && $4 ~ "[uw]" && NF == 9) || ($6 ~ "[0-9]{1,}[a-z]{1,}[UNR]{0,}" && $6 ~ "[uw]" && NF == 11 )  {print $0}'
```


## Appendix: Inode number(index node number)

inodeは, filesystem内の各fileやdirectoryに割り当てられたint型整数で表現される一意の識別子のことです.
inodeのなかにfileやdirectoryのmedata(permission, file size, and on)が格納されています.


各filesystemにinodeの上限設定数値があり, 使用可能なinodeの数はそのfilesystem上で作成できる最大のfileやdirectoryの数となります. 


fileやdirectoryのinodeを確認したい場合は, `ls -i`で確認することが出来ます:

```zsh
## [inode, name]の順番で出力される
% ls -i|head
  919688 airflow/
 2102745 app_icon/
 1183217 bin/
 5507154 deb_packages/
  786495 Desktop/
  786769 Documents/
  786766 Downloads/
 1183239 gems/
```

## References

- [THE GEEK STUFF > Linux lsof Command Examples (Identify Open Files)](https://www.thegeekstuff.com/2012/08/lsof-command-examples/)
- [stackExchange > lsof: WARNING: can't stat() fuse.gvfsd-fuse file system](https://unix.stackexchange.com/questions/171519/lsof-warning-cant-stat-fuse-gvfsd-fuse-file-system)