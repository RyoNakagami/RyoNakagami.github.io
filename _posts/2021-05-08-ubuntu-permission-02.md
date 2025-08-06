---
layout: post
title: "SUID, SGID, スティッキービット"
subtitle: "Linux Permission 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-08-08
reading_time: 10
tags:

- Linux
- システム管理
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is "SUID(= Set User ID)"?](#what-is-suid-set-user-id)
  - [SUIDの設定方法](#suid%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%96%B9%E6%B3%95)
  - [SUIDはどのように機能しているのか？](#suid%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AB%E6%A9%9F%E8%83%BD%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
- [What is "SGID(= Set Group ID)"?](#what-is-sgid-set-group-id)
  - [SGIDの設定方法](#sgid%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%96%B9%E6%B3%95)
- [What is Sticky bit?](#what-is-sticky-bit)
  - [スティッキービットの設定方法](#%E3%82%B9%E3%83%86%E3%82%A3%E3%83%83%E3%82%AD%E3%83%BC%E3%83%93%E3%83%83%E3%83%88%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%96%B9%E6%B3%95)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What is "SUID(= Set User ID)"?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: SUID</ins></p>

LinuxではユーザはUIDと呼ばれるID番号で管理されているが, 一時的にファイルの実行権限を別のUIDのユーザに変更できる
機能のことをSUID（Set User ID）という. 

- SUIDが付与されたファイルは実行時にそのファイルの所有者の権限で実行される
- Linuxのファイルシステム上では, ディレクトリに対して設定しても効果はない

</div>

「**セキュリティ的に一般ユーザーの書き込み権限などは絞っておきたいが, 利便性を考えると root ユーザーでなくても更新させたい**」というファイルがあるとき, SUID をうまく使うことで用途を限定した上で, セキュアなファイルへの書き込みを一般ユーザーにも許可できるというメリットがあります. 

SUIDの使用例として, `passwd`コマンドがあります. 
Linuxではパスワードのデータを`/etc/shadow`で管理しています.

```zsh
% ls -l /etc/shadow 
-rw-r----- 1 root shadow 9812 Jul 15 19:03 /etc/shadow
```

このファイルの特徴として以下があります

- root以外は読み取れない(= 暗号化パスワード解読を防ぐため)
- パスワード情報は暗号化されている

そのためパスワードを変更したいときは直接編集するのではなく`passwd`コマンドを使いますが, このコマンドにSUIDの仕組みが使われています.

```zsh
% ls -l  $(which passwd)
-rwsr-xr-x 1 root root 68208 Nov 24  2022 /usr/bin/passwd*
```

SUIDが設定されているファイル（プログラム）においては所有者の実行権限が`s`と表記されます.
そのため, `passwd`コマンドは一般ユーザが実行した場合においても, `passwd`コマンドの所有者であるroot権限で実行できます.

### SUIDの設定方法

`chmod`でSUIDを設定する場合は

- オクタルモード: `4000`を加算
- シンボリックモード: `u+s`を付与


```zsh
## オクタルモードで755に加えて設定したい場合
% sudo chmod 4755 test.sh

## シンボリックモード
% sudo chmod u+s test.sh
```

### SUIDはどのように機能しているのか？

Linuxではコマンドを実行するとプロセスが走りますが, そのプロセスのUSERには２種類あります:

- 実ユーザーID(= real user ID): プロセス起動ユーザー, プロセス所有ユーザー
- 実効ユーザーID(= effective user ID): プロセスが実行されるときの権限

`ps aux`で確認できる`USER`は実ユーザーIDを指しています.

カーネルはプロセスの実行権限を実効ユーザーID(または実行グループ)で判断しています.
通常は実ユーザーIDと実行ユーザーIDは一致しますが, SUIDを設定すると実効ユーザーIDがコマンドファイル所有者へ変化します.

`passwd`コマンドを実行した状態でプロセス情報を調べると

```zsh
% ps -eo ruser,euser,pid,cmd | grep passwd
ryo root       11092 passwd
```

実効ユーザーIDがrootになっていることがわかります.



## What is "SGID(= Set Group ID)"?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: SGID</ins></p>

- ファイルのグループIDが実効グループIDとして設定される仕組みのこと
- SGIDではグループの実行権限が`s`となる
- ディレクトリに対してSGIDが設定された場合, そのディレクトリ以下において作成したファイルやサブディレクトリの所有グループには, 自動的にディレクトリ自体の所有グループが適用される

</div>

SGIDが設定されているディレクトリ例は以下があります

```zsh
## permissionでSGIDが設定されているディレクトリを検索
% find /usr/bin/ -perm -g+s
/usr/bin/ssh-agent
/usr/bin/chage
/usr/bin/wall
/usr/bin/crontab
/usr/bin/write.ul
/usr/bin/expiry
```

### SGIDの設定方法

`chmod`でSUIDを設定する場合は

- オクタルモード: `2000`を加算
- シンボリックモード: `g+s`を付与


```zsh
## オクタルモードで755に加えて設定したい場合
% sudo chmod 2755 test.sh

## シンボリックモード
% sudo chmod g+s test.sh
```


## What is Sticky bit?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: スティッキービット</ins></p>

- スティッキービットが設定されたディレクトリ以下のファイルとディレクトリは, 実際に設定したアクセス権に関係なく, 
ファイルの**ファイル名変更や削除**は所有者とrootユーザしかできなくなる.
- その他グループの実行権限が`t`となる

</div>

```zsh
%  ls -ld /tmp
drwxrwxrwt 32 root root 4096 Aug 16 12:46 /tmp/
```

`/tmp`では多くのユーザーが作業できるようにアクセス権がすべて許可されていますが, あるユーザーが作成した
ファイルを他のユーザーが消してしまうことを防ぐためにスティッキービットが設定されています.

### スティッキービットの設定方法

`chmod`でスティッキービットを設定する場合は

- オクタルモード: `1000`を加算
- シンボリックモード: `o+t`を付与


```zsh
## オクタルモードで755に加えて設定したい場合
% sudo chmod 1755 test.sh

## シンボリックモード
% sudo chmod o+t test.sh
```


References
-----

- [Linux - SUID / SGID / Sticky Bit](https://www.infraexpert.com/infra/linux31.html)
- [SUID has no effect on directories with Linux](https://unix.stackexchange.com/questions/266633/suid-has-no-effect-on-directories-with-linux)
- [日経XTECH > 特殊なアクセス権](https://xtech.nikkei.com/it/article/COLUMN/20080219/294154/)
