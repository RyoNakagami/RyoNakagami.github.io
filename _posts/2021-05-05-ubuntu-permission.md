---
layout: post
title: "権限管理入門とsudoの使い方"
subtitle: "Linux復習: Permission"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2022-08-08
reading_time: 10
tags:

- Linux
- Shell
---


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is "Permission"?](#what-is-permission)
  - [Permissionの確認](#permission%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [What is "Group"?](#what-is-group)
  - [Linuxにおけるユーザー情報の表示](#linux%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E6%83%85%E5%A0%B1%E3%81%AE%E8%A1%A8%E7%A4%BA)
  - [idコマンドで出力される情報はどこで管理されているのか？](#id%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A7%E5%87%BA%E5%8A%9B%E3%81%95%E3%82%8C%E3%82%8B%E6%83%85%E5%A0%B1%E3%81%AF%E3%81%A9%E3%81%93%E3%81%A7%E7%AE%A1%E7%90%86%E3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
  - [root user(管理者)について](#root-user%E7%AE%A1%E7%90%86%E8%80%85%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [Permissionの設定](#permission%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [`chmod`: Permissionコマンド](#chmod-permission%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [シンボリックモードとオクタルモードでのPermission設定](#%E3%82%B7%E3%83%B3%E3%83%9C%E3%83%AA%E3%83%83%E3%82%AF%E3%83%A2%E3%83%BC%E3%83%89%E3%81%A8%E3%82%AA%E3%82%AF%E3%82%BF%E3%83%AB%E3%83%A2%E3%83%BC%E3%83%89%E3%81%A7%E3%81%AEpermission%E8%A8%AD%E5%AE%9A)
  - [umaskを用いたDefault Permissionフラグの管理](#umask%E3%82%92%E7%94%A8%E3%81%84%E3%81%9Fdefault-permission%E3%83%95%E3%83%A9%E3%82%B0%E3%81%AE%E7%AE%A1%E7%90%86)
- [`chown`: 所有者の変更](#chown-%E6%89%80%E6%9C%89%E8%80%85%E3%81%AE%E5%A4%89%E6%9B%B4)
- [SUID と SGID と スティッキービット](#suid-%E3%81%A8-sgid-%E3%81%A8-%E3%82%B9%E3%83%86%E3%82%A3%E3%83%83%E3%82%AD%E3%83%BC%E3%83%93%E3%83%83%E3%83%88)
  - [SUIDとは](#suid%E3%81%A8%E3%81%AF)
  - [SGIDとは](#sgid%E3%81%A8%E3%81%AF)
  - [スティッキービットとは](#%E3%82%B9%E3%83%86%E3%82%A3%E3%83%83%E3%82%AD%E3%83%BC%E3%83%93%E3%83%83%E3%83%88%E3%81%A8%E3%81%AF)
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
それが新規作成したユーザーに割り当てられます.

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



###  Linuxにおけるユーザー情報の表示

ログインユーザーのユーザーID(数値で表現されたユーザー識別子)は`id`コマンドで確認することができます.

```zsh
 % id
uid=1000(ryonak) gid=1000(ryonak) groups=1000(ryonak),4(adm),10(wheel)
```

`uid`の次にくる数値がUser IDで, その後に続く括弧の中身の文字列が現在のUser名となります. ここのUser名は`whoami`コマンドで出力されるユーザー名と同一のものになります. 
その次に続く`gid`とはユーザーが所属しているメインのグループ(=「実行グループ」)のGroup IDとGroup名が表示されます.

 

最後の`groups`以下は, 現在のユーザーが所属するグループの一覧を表示しています. 上の例では「1000(ryonak)」,「4(adm)」,「10(wheel)」というグループに所属していることになります.




### idコマンドで出力される情報はどこで管理されているのか？

Linuxでは, アカウント情報を`/etc/passwd`というテキストファイルで管理しています. `cat /etc/passwd`とターミナルで実行してみると中身を確認することができます. 自分しか利用していないパソコンでも`cat /etc/passwd`で確認してみると,パソコン内部にたくさんのユーザーが存在することがわかるはずです.

これはLinuxが管理者ユーザー, 一般ユーザー, システムユーザーの3種類にユーザーを分類して管理していることに起因します. 

---|---
root（スーパーユーザー）|システムに配置されたディレクトリやファイルのすべてを編集できるユーザー
システムユーザー|Webサーバー, メールサーバーといった, 各種サービスを実行するユーザー
一般ユーザー|Linuxシステムにログインしてファイルやディレクトリを編集/コマンドを実行するユーザー

システムユーザーはrpmやdebパッケージによりサービスがインストールされた際にユーザーとして作成されます. rootではなく,システムユーザーでサービスを起動するのはセキュリティ対策が理由の一つです. 仮にとあるサービスに脆弱性が存在し, そのサービスのシステムユーザーの権限が乗っ取られたとします. このときサービスがシステムユーザーの権限で動作していれば, 攻撃された場合の影響はそのシステムユーザーの権限内に収めることができます.

### root user(管理者)について

システムの安全性/安定性の観点から, システムの一部を変更/修正したり, 新規のユーザーを追加したり, 
ユーザーを削除したりというシステム作業は一般ユーザーレベルではできない設定にする＝権限を持っているユーザーは限定すべきです.

このシステム面の編集権限を含むすべての権限を有しているユーザーが「管理者(root user)」です.
システム面の編集の例は, レポジトリのインストールやroot直下のディレクトリを操作する事が挙げられます.

ただ, このような作業は, 一般ユーザーとしてログインしているときに必要になるケースが多々あります(例：Pythonの分析環境を構築したいとき).
この場合, 管理者権限を手に入れる必要がありますが, その手法は大きく分けて２つあります.

1. `su`コマンド(Switch Userコマンド)を使って, 管理者へユーザーを切り替える
2. `sudo`コマンドを使って, 一時的に管理者権限を一般ユーザーが手に入れる

なお, `su`コマンドはUbuntuのデフォルト設定ではdisabledされているので基本的には`sudo`コマンドを使います.
どうしても管理者へ切り替えたい場合は, `sudo`コマンドにオプションをつけて

```zsh
% sudo -i  
```

でroot userへ切り替えることができます.

> `sudo`コマンドを使って, 一時的に管理者属性を一般ユーザーが手に入れる

管理者属性を一般ユーザーが一時的に手に入れるということは, 
その一般ユーザーが一時的に管理者になることと同値です.

```
% sudo whoami
root
```

というコマンドから確認することができます.


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

### シンボリックモードとオクタルモードでのPermission設定

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

```
% ls -l
-rw-rw-r-- 1 ryonak ryonak   90 Aug  4 19:50 fileA
```

以下のような条件を満たす形でPermissionを変更してください

- 所有者: Readable, Writable, Executable
- 所有者以外: Reable, Executable

</div>

```zsh
# シンボリックモード
% chmod a+x,g-w fileA

# オクタルモード
% chmod 755 fileA
```

シンボリックモードで記載する際は, カンマ区切りを用いて定義します. 


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


## SUID と SGID と スティッキービット
### SUIDとは

- SUIDとはset-uidの略です
- SUIDが付与されたファイルは実行時にそのファイルの所有者の権限で実行されます
- SUIDが付与されたファイルは`s`が`w`の後ろに付きます

```zsh
% ls -l  $(which passwd)
-rwsr-xr-x 1 root root 68208 Jul 15 07:08 /usr/bin/passwd*
```

passwdコマンドは, ユーザーがpasswordを変更するために使用されます. このコマンドを呼びpasswordを変更すると, そのユーザーからの入力情報に則して, `/etc/passwd`と`/etc/shadow`を編集します. しかしこれらは, rootユーザー以外は直接編集できないようになっています. しかしpasswdコマンドはSUIDが設定されているため, このコマンドを実行した際に, 実行したユーザーではなく所有者（root）のアクセス権限が適用されます.

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

と設定すると, 所有者の実行権限が`s`になります.

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

## References

- [UNIXの絵本, 株式会社アンク著](https://www.shoeisha.co.jp/book/detail/4798109339)
- [askubuntu > why does su fails with an authentication error?](https://askubuntu.com/questions/446570/why-does-su-fail-with-authentication-error)
