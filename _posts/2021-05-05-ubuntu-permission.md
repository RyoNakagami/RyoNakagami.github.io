---
layout: post
title: "権限管理入門"
subtitle: "Linux Permission 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-08-08
reading_time: 10
tags:

- Linux
- システム管理
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is "Permission"?](#what-is-permission)
  - [Permissionの確認](#permission%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [What is "Group"?](#what-is-group)
  - [グループの種類: プライマリーグループ & セカンダリーグループ](#%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97%E3%81%AE%E7%A8%AE%E9%A1%9E-%E3%83%97%E3%83%A9%E3%82%A4%E3%83%9E%E3%83%AA%E3%83%BC%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97--%E3%82%BB%E3%82%AB%E3%83%B3%E3%83%80%E3%83%AA%E3%83%BC%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97)
  - [`groups` command](#groups-command)
  - [`id` command](#id-command)
- [Permissionの設定](#permission%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [`chmod`: Permissionコマンド](#chmod-permission%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [umaskを用いたDefault Permissionフラグの管理](#umask%E3%82%92%E7%94%A8%E3%81%84%E3%81%9Fdefault-permission%E3%83%95%E3%83%A9%E3%82%B0%E3%81%AE%E7%AE%A1%E7%90%86)
- [`chown`: 所有者の変更](#chown-%E6%89%80%E6%9C%89%E8%80%85%E3%81%AE%E5%A4%89%E6%9B%B4)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## What is "Permission"?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Permission</ins></p>


ファイルやディレクトリには「誰に」「どのような操作を」許可するのか, それを個別に設定することができ, これをPermissionという.

</div>


Linux環境では複数のユーザーで利用することが前提となっています. このようなシステム設計思想をマルチユーザーといいます.
マルチユーザーシステムでは, 一つのコンピューター上に, 複数のアカウントが存在し得ます. 「アカウント」とは, 
「ユーザー名とパスワードで管理されるコンピューター使用権」とここでは理解しときます.

複数のユーザーが一つのコンピューター上に存在し得る以上, どのユーザーがどのディレクトリ, ファイルに対して所有権やアクセス権を有しているのか？定義する必要があります.
この「(ユーザー, ファイル)ごとのアクセス権の管理」という概念がPermissionで, Linuxでは許可されたユーザーのみがファイルにアクセスできる「アクセス制御」が実装されています.

「コマンドや設定が正しいはずなのになぜか動かない」というトラブルに直面する時の多くのケースにおいて, このPermissionの不整合が原因となります. こういった意味でも, 
Permissionがどんな仕組みなのか？を学ぶ価値はあります.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: Permissionによるアクセス制御のメリットの紹介</ins></p>

システムには`/lib/libc.so.6`（共有ライブラリの一つ）のように重要なものもあれば, `memo.txt`のような些細なメモ書きのファイルもあります.
この両者に対するアクセス権は同レベルのものではなく, 前者のほうが厳格に取り扱われるべきと考えられます. 後者は, うっかり消してもそのシステムのユーザーの大半には影響を与えませんが, 
前者を消去した場合は多くのユーザーが困ってしまいます. そのため, メモは各一般ユーザーレベルのアクセスを共用する一方, `/lib/libc.so.6`は普段は編集できないように設定するべきとなります.

この設定を実現するために, マルチユーザーシステムとPermissionが存在します. マルチユーザーシステムによって, システム内部に複数のユーザーを設定できるようにし, 
Permissionによって限られたユーザーのみが`/lib/libc.so.6`にアクセスできるように設定することができます.

</div>

### Permissionの確認

上述の権限は `ls -l` コマンドで確認することができます. `-a`は`.`で始まるファイルも含めカレントディレクトリに存在するすべてのファイルを表示するオプション. `-l`はPermissionやサイズ, 更新タイムスタンプといった情報を出力するために用いられるコマンドです.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/4d5f9c4e398bfba0ae8de938210683495266ccd2/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210505_ubuntu_permission_01.png?raw=true">

表示される項目としては

- ファイルの種類とPermission（所有ユーザー, 所有者のプライマリグループ, その他のグループの順番でPermissionが記載）
- ハードリンク数
- 所有ユーザーと所有グループ


> Permissionの表記の意味

|種類|意味|ファイルの場合|ディレクトリの場合|
|---|---|---|---|
|`r`| Readable|ファイルの内容を読むことができる|ディレクトリの内容が表示可能になる(`ls`コマンドが使える)|
|`w`| Writable|編集が可能になる|ディレクトリ内のファイルやディレクトリの作成/削除ができる(`rm`, `touch`, `mkdir`が使用可能)|
|`x`| eXecutable|実行ファイルとして実行できる|ディレクトリへ移動できるようになる|
|`-`| 不許可|||

> ファイルタイプの種類

上ではファイルタイプについて`d`と`-`のみ紹介しましたが, 知っておくべきファイルタイプは8個あります.

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

## What is "Group"?

Linuxでは, 「**グループ**」というユーザーカテゴリでPermissionを管理することができます.
このグループとは「ユーザーの集合」のことです. Linuxではユーザー作成時に, ユーザー名と同名の新しいグループが作られ, 
それが新規作成したユーザーに割り当てられます. ユーザー名と同じ名前のグループが設定される管理方式を**ユーザープライベートグループ（UPG）**と呼びます.

一つのLinuxコンピューターにユーザーが100人とかいるケースでは, １人づつリソース管理するよりもグループ単位で管理したほうが簡単なケースは多々あります.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: Group単位での権限管理のメリット</ins></p>

例えば, 会社で一つのLinuxサーバーを共有している時, 管理職グループには売上帳票関連ディレクトリのアクセス権を付与するが, それ以外のユーザーにはアクセスを禁じたい時を考えます.

この時, 一人ひとりのユーザーにディレクトリのアクセス権を設定すると, 管理職人数のオーダーで設定工数が発生しますが, 一旦管理職グループを定義して管理職グループのみにディレクトリのアクセス権を付与するという形にすると工数のオーダーが$O(1)$になることからもわかります.

```zsh
% sudo chgrp -R 管理職グループ <directory-path>
% sudo chmod 770 <directory-path>
```

</div>

グループの情報は`/etc/group`ファイルに保存されています. `cat`コマンドで確認することができますが, password箇所は暗号化の関係で`x`と表示されます:

```zsh
### 書式
group-name:password:group-id:user-list

### /etc/group
% cat /etc/group     
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog,ryo
tty:x:5:
disk:x:6:
lp:x:7:
....
```

### グループの種類: プライマリーグループ & セカンダリーグループ

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: グループの種類</ins></p>

ユーザーは必ず１つ以上のグループに所属します. グループにはプライマリーグループとセカンダリーグループの２種類があります:

---|---
プライマリーグループ|ログイン直後の作業グループ<br>ファイルやディレクトリを新規作成した際にグループとして使用される
セカンダリーグループ|それ以外のグループ, 必要に応じて使用される

</div>

グループ情報を確認する場合は, `groups`または`id`コマンドを利用します

### `groups` command

current userや指定したユーザーのグループリストのみを確認したい場合は`groups` commandを用います:

```zsh
### カレントユーザーのグループリスト
% groups
ryo study futsal arsenal utecon

### 指定したユーザーのグループリスト
% groups haaland
haaland : haaland city striker manchester
```

この出力の元情報は上で紹介したように`/etc/group`に格納されています.


### `id` command

現在のユーザーでプライマリグループや, セカンダリーグループリストをUIDとGIDと共に出力したい場合は`id`コマンドで確認します.

```zsh
 % id
uid=1000(ryonak) gid=1000(ryonak) groups=1000(ryonak),4(adm),10(arsenal)
```

- `uid`: 現在のUser名 & user IDを表示, User名は`whoami`コマンドで出力されるユーザー名と同一のもの
- `gid`:プライマリーグループのGroup IDとGroup名を表示
- `groups`: セカンダリーグループを表示


## Permissionの設定

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: だれがPermissionを設定できるのか？</ins></p>

ファイルやディレクトリのパーミッションはrootと対象オブジェクトに対して所有権を持っているユーザーとrootユーザーが設定できます.

</div>

設定可能権限は「READ, WRITE, EXEWCUTE」の３つの権限属性を設定できます.

---|---|---
READ|4|読み込み権限
WRITE|2|書き込み権限
EXECUTE|1|実行権限

設定対象については, 次のユーザーカテゴリ単位で権限設定することができます.

---|---
User|ファイルの所有者
Group|所有者グループ（同じ権限をもっているユーザーの集合）のユーザー
Other|その他のユーザーグループ

### `chmod`: Permissionコマンド

Permissionを設定する場合は以下のコマンドを用います

```zsh
% chmod [option] mode file
```

`test.sh`というファイルを例にPermission設定例を確認してみます

```zsh
% chmod a+rx test.sh  #すべてのユーザーにread, execute権限付与
% chmod a-rx test.sh  #すべてのユーザーからread, execute権限剥奪
% chmod u+rx test.sh  #所有ユーザーにread, execute権限付与
% chmod g+rx test.sh  #所有グループにread, execute権限付与
```

**userの指定**

---|---
u|owner user
g|group
o|other
a|すべてのユーザー

**シンボリックモードでの権限の変更**

---|---
+|権限追加付与
-|権限剥奪
=|権限指定

**数値によるPermissionの指定=オクタルモード**

---|---|---
r|Reable|4
w|Writable|2
x|eXecutable|1
-|不許可|0
s|SUID/SGID|4000/2000
t|スティッキービット|1000

```zsh
% chmod 755 test.sh  ##所有者:rwx,所有グループ:r-x,Others:r-x
```

**Permissionの再帰的処理**


ディレクトリ内のファイルすべてを再帰的に変更したい場合はoption `-R`を用います:

```zsh
#ディレクトリとディレクトリ内のファイル全ての権限を（再帰的に）変更する
% chmod -R 766 dir
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Problem: シンボリックモードとオクタルモードでのPermission設定</ins></p>

```
% ls -l
-rw-rw-r-- 1 ryonak ryonak   90 Aug  4 19:50 fileA
```

以下のような条件を満たす形でPermissionを変更してください

- 所有者: Readable, Writable, Executable
- 所有者以外: Reable, Executable

</div>

シンボリックモードで記載する際は, カンマ区切りを用いて定義します. 

```zsh
# シンボリックモード
% chmod a+x,g-w fileA

# オクタルモード
% chmod 755 fileA
```


### umaskを用いたDefault Permissionフラグの管理

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: デフォルトのPermission</ins></p>

ユーザーがファイルやディレクトリを新規作成した際にはデフォルトのPermissionが付与されます. 
デフォルトのPermissionの値はシェルに設定された`umask`値で決まります.

なお`umask`が影響を与えるのは, 新規ファイル・ディレクトリの作成時だけであって, 既に存在するファイルのパーミッションには全く影響を与えません.

</div>

Linuxではファイルとディレクトリの**Permission初期値**は以下のようになっています.

---|---|---
ファイル|666|-rw-rw-rw-
ディレクトリ|777|drwxrwxrwx

このままではだれでも少なくともファイルが編集できてしまうので, セキュリティ対策の観点から調整が必要です.
この時用いるコマンドが`umask`です.

`umask`はシェルに組み込まれたコマンドで設定したumask値をPermission初期値から引き算した値でファイル, ディレクトリを作成するようになります. 
以下のlineを`.zshrc`に書き込むことを推奨します.

```zsh
% umask 022 #groupとotherからwritableの権限を除去する
```

初期設定値をTerminalから確認したい場合は`umask`と入力すれば確認できます.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Example: デフォルトパーミッション </ins></p>

||ファイル|ディレクトリ|
|初期値Permission|666|777|
|`umask`|022|022|
|Default Permission|644|755|

`umask`で所有者以外の`2` = Writableをmaskするという意味なので, Default PermissionではWritableが取り除かれた値が設定される.


</div>

## `chown`: 所有者の変更

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: chwonコマンド</ins></p>

- `chown`コマンドは指定されたファイルやディレクトの所有者とグループを変更する
- グループも合わせて変更する場合はグループ名の前に`.` または `:` を指定する
- このコマンドを実行できるのはrootユーザーのみ

```zsh
% chown [option] user-name[:group-name] file-name
```

</div>

システム管理の場面以外では, Dockerfileの設定において, `root`ユーザーで必要なパッケージインストールと環境準備を実行した後に, `adduser`からそのユーザーに対して権限を与えるという処理をする際に使用されます. 例として, 

```zsh
ARG BASE_IMAGE=wolframresearch/wolframengine
FROM ${BASE_IMAGE} as base

USER root

SHELL [ "/bin/bash", "-c" ]
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get -qq -y update && \
    apt-get -qq -y install \
      software-properties-common \
      wget curl make nodejs build-essential libssl-dev zlib1g-dev libbz2-dev \
      libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
      libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user "docker" with uid 1000
RUN adduser \
      --shell /bin/bash \
      --gecos "default user" \
      --uid 1000 \
      --disabled-password \
      docker && \
    chown -R docker /home/docker && \
    mkdir -p /home/docker/work && \
    chown -R docker /home/docker/work && \
    mkdir /work && \
    chown -R docker /work && \
    chmod -R 777 /work && \
    mkdir /docker && \
    printf '#!/bin/bash\n\njupyter lab --no-browser --ip 0.0.0.0 --port 8888\n' > /docker/entrypoint.sh && \
    chown -R docker /docker && \
    cp /root/.bashrc /etc/.bashrc && \
    echo 'if [ -f /etc/.bashrc ]; then . /etc/.bashrc; fi' >> /etc/profile && \
    echo "SHELL=/bin/bash" >> /etc/environment
```

## References

- [UNIXの絵本, 株式会社アンク著](https://www.shoeisha.co.jp/book/detail/4798109339)
- [askubuntu > why does su fails with an authentication error?](https://askubuntu.com/questions/446570/why-does-su-fail-with-authentication-error)
