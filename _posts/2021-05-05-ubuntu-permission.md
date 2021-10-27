---
layout: post
title: "Linux復習: Permission"
subtitle: "権限管理入門とsudoの使い方"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Shell
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|sudoを正しく使うための権限管理入門|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Permissionとは？](#permission%E3%81%A8%E3%81%AF)
  - [ファイルタイプの種類](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%BF%E3%82%A4%E3%83%97%E3%81%AE%E7%A8%AE%E9%A1%9E)
  - [Permissionの設定](#permission%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [umaskを用いたDefault Permissionフラグの管理](#umask%E3%82%92%E7%94%A8%E3%81%84%E3%81%9Fdefault-permission%E3%83%95%E3%83%A9%E3%82%B0%E3%81%AE%E7%AE%A1%E7%90%86)
- [SUID と SGID と スティッキービット](#suid-%E3%81%A8-sgid-%E3%81%A8-%E3%82%B9%E3%83%86%E3%82%A3%E3%83%83%E3%82%AD%E3%83%BC%E3%83%93%E3%83%83%E3%83%88)
  - [SUIDとは](#suid%E3%81%A8%E3%81%AF)
  - [SGIDとは](#sgid%E3%81%A8%E3%81%AF)
  - [スティッキービットとは](#%E3%82%B9%E3%83%86%E3%82%A3%E3%83%83%E3%82%AD%E3%83%BC%E3%83%93%E3%83%83%E3%83%88%E3%81%A8%E3%81%AF)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Permissionとは？

複数のユーザーで利用することが前提のLinux環境では、許可されたユーザーのみがファイルにアクセスできる「アクセス制御」が実装されています.

> Linuxの３つのユーザー

---|---
root（スーパーユーザー）|システムに配置されたディレクトリやファイルのすべてを編集できるユーザー
システムユーザー|Webサーバー、メールサーバーといった、各種サービスを実行するユーザー
一般ユーザー|Linuxシステムにログインしてファイルやディレクトリを編集/コマンドを実行するユーザー

システムユーザーはrpmやdebパッケージによりサービスがインストールされた際にユーザーとして作成されます. rootではなく、システムユーザーでサービスを起動するのはセキュリティ対策が理由の一つです. 仮にとあるサービスに脆弱性が存在し、そのサービスのシステムユーザーの権限が乗っ取られたとします. このときサービスがシステムユーザーの権限で動作していれば、攻撃された場合の影響はそのシステムユーザーの権限内に収めることができます. 

> 3つのユーザーカテゴリ

---|---
User|ファイルの所有者
Group|Userと同じグループ（同じ権限をもっているユーザーの集合）のユーザー
Other|その他のユーザー

> 3つの権限属性

---|---
READ|読み込み権限
WRITE|書き込み権限
EXECUTE|実行権限

これら権限は `ls -al` コマンドで確認することができます. `-a`は`.`で始まるファイルも含めカレントディレクトリに存在するすべてのファイルを表示するオプション. `-l`はPermissionやサイズ、タイムスタンプといった情報を出力するために用いられるコマンドです.

```zsh
% ls -al
total 1236
drwxrwxr-x  2 ryo_nak ryo_nak   4096 Oct 14 23:29 ./
drwxrwxr-x 15 ryo_nak ryo_nak   4096 Dec 21  2020 ../
-rw-rw-r--  1 ryo_nak ryo_nak 164664 May  6 10:28 2020-10-08-How-Programm-Works.md
```

Permissionの表記の意味は以下です

- `d`: ファイルタイプを表します, `d`と表示されているものはDirectory, `-`はファイル
- `r`: Readable
- `w`: Writable
- `x`: eXecutable
- `-`: 不許可

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210505_ubuntu_permission_01.png?raw=true">

### ファイルタイプの種類

上ではファイルタイプについて`d`と`-`のみ紹介しましたが、知っておくべきファイルタイプは8個あります.

|文字|ファイルタイプ|例|
|---|---|---|
|`-`|ファイル||
|`b`|ブロックファイル|SSDやHDDなどのブロックデバイスをファイルとして扱かったもの|
|`c`|キャラクタファイル|ファイルシステム上であたかも通常のファイルのような形で提示されるデバイスドライバのインタフェース|
|`d`|ディレクトリ||
|`l`|シンボリックリンク||
|`p`|FIFO(名前付きパイプ)|FIFOを用いたプロセス間通信に利用するファイル|
|`s`|Unixドメインソケット|ソケットを用いたプロセス間通信に利用するファイル|
|`?`|その他|判断しにくいファイル（壊れている場合が大半）|

### Permissionの設定

ファイルやディレクトリのパーミッションはrootと対象オブジェクトに対して所有権を持っているユーザーが設定できます.

```zsh
% chmod [option] mode file
```

`test.sh`というファイルに対してすべてのカテゴリユーザーについてReadable, eXecutableの権限を付与したい場合は

```zsh
% chmod a+rx test.sh
```

> userの指定

---|---
u|owner user
g|group
o|other
a|すべてのユーザー

> 権限の変更

---|---
+|権限追加付与
-|権限剥奪
=|権限指定

> 数値によるPermissionの指定

---|---|---
r|Reable|4
w|Writable|2
x|eXecutable|1
-|不許可|0
s|SUID/SGID|4000/2000
t|スティッキービット|1000

```zsh
% chmod 755 test.sh
```

> ディレクトリ内のファイルすべてを再帰的に変更したい場合

```zsh
#ディレクトリとディレクトリ内のファイル全ての権限を（再帰的に）変更する
% chmod -R 766 dir
```


## umaskを用いたDefault Permissionフラグの管理

LinuxではファイルとディレクトリのPermission初期値は以下のようになっています.

---|---|---
ファイル|666|-rw-rw-rw-
ディレクトリ|777|drwxrwxrwx

このままではだれでも少なくともファイルが編集できてしまうので、セキュリティ対策の観点から調整が必要です. この時用いるコマンドが`umask`です.
`umask`はシェルに組み込まれたコマンドで設定したumask値をPermission初期値から引き算した値でファイル、ディレクトリを作成するようになります. 以下のlineを`.zshrc`に書き込むことを推奨します.

```zsh
umask 022 #groupとotherからwritableの権限を除去する
```

初期設定値をTerminalから確認したい場合は`umask`と入力すれば確認できます.

## SUID と SGID と スティッキービット
### SUIDとは

- SUIDとはset-uidの略です
- SUIDが付与されたファイルは実行時にそのファイルの所有者の権限で実行されます
- SUIDが付与されたファイルは`s`が`w`の後ろに付きます

```zsh
% ls -l  $(which passwd)
-rwsr-xr-x 1 root root 68208 Jul 15 07:08 /usr/bin/passwd*
```

passwdコマンドは、ユーザーがpasswordを変更するために使用されます. このコマンドを呼びpasswordを変更すると、そのユーザーからの入力情報に則して、`/etc/passwd`と`/etc/shadow`を編集します. しかしこれらは、rootユーザー以外は直接編集できないようになっています. しかしpasswdコマンドはSUIDが設定されているため、このコマンドを実行した際に、実行したユーザーではなく所有者（root）のアクセス権限が適用されます.

```zsh
% ls -l /etc/{shadow,passwd}   
-rw-r--r-- 1 root root   3043 Jun  8 23:43 /etc/passwd
-rw-r----- 1 root shadow 1594 Jun  8 23:43 /etc/shadow
```

「セキュリティ的に一般ユーザーの書き込み権限などは絞っておきたい。でも, 利便性を考えると root ユーザーでなくても更新させたい」というファイルがあるとき, SUID をうまく使うことで, 用途を限定した上で, セキュアなファイルへの書き込みを一般ユーザーにも許可できます.

> SUIDの設定方法

chmod コマンドなどでのファイル権限の数値表現で, `4000` が SUID にあたります. ですので

```zsh
% sudo chmod 4755 test.sh
```

または

```zsh
% sudo chmod u+s test.sh
```

と設定すると、所有者の実行権限が`s`になります.

### SGIDとは

- SUID のグループ版
- 実行可能ファイルの所有グループの実行権限が x でなく s になっていると, そのファイルを実行した場合の 実効グループが 所有グループになります

SGIDの付与方法は

```zsh
% sudo chmod 2755 test.sh
```

または

```zsh
% sudo chmod g+s test.sh
```

### スティッキービットとは

- スティッキービットのついたディレクトリ配下に作成したファイル, ディレクトリは, 所有者以外はファイル・ディレクトリの名前変更・削除ができなくなります

```zsh
% sudo chmod 1755 test.sh
```

または

```zsh
% sudo chmod o+t test.sh
```