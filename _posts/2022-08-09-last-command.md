---
layout: post
title: "last command: システムのログイン履歴の表示"
subtitle: "Linux command 3/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-02-27
header-mask: 0.0
header-style: text
tags:

- Ubuntu 22.04 LTS
- Linux
- log
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`last`コマンド](#last%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [主要オプション](#%E4%B8%BB%E8%A6%81%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
  - [`last` vs `lastlog`](#last-vs-lastlog)
- [その他のログイン状況を参照するコマンド](#%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AE%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E7%8A%B6%E6%B3%81%E3%82%92%E5%8F%82%E7%85%A7%E3%81%99%E3%82%8B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [`who`コマンド](#who%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
    - [`who`コマンドのオプション](#who%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
  - [`w`コマンド: ログインしているユーザーと実行中のプロセスを表示](#w%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89-%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%81%A8%E5%AE%9F%E8%A1%8C%E4%B8%AD%E3%81%AE%E3%83%97%E3%83%AD%E3%82%BB%E3%82%B9%E3%82%92%E8%A1%A8%E7%A4%BA)
  - [`lastb`コマンド: Bad Login履歴を確認する](#lastb%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89-bad-login%E5%B1%A5%E6%AD%B4%E3%82%92%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B)
- [Appendix: システム上のユーザー一覧を取得する](#appendix-%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E4%B8%8A%E3%81%AE%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E4%B8%80%E8%A6%A7%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## `last`コマンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: lastコマンド</ins></p>

`last`コマンドは`/var/log/wtmp`ファイルを参照しシステムのログイン履歴を一覧表示するコマンド.

```zsh
% last [オプション] [ユーザー名] [端末番号]
```

</div>

デフォルトの表示項目は

- ユーザー名
- 端末
- ホスト(ローカルの場合はdisplay number)
- ログイン日時
- ログアウト日時(ログアウトしていない場合はstill logged in)

ユーザーを`kirby`だけに絞って最新10件のみ表示する場合

```zsh
% last -n 10 kirby
kirby pts/0        tmux(156948).%0  Tue Feb 21 01:04 - 01:15  (00:11)
kirby pts/0        tmux(154821).%0  Tue Feb 21 00:59 - 00:59  (00:00)
kirby :1           :1               Mon Feb 20 09:23   still logged in
kirby :1           :1               Thu Feb 16 09:24 - down   (09:28)
kirby :1           :1               Wed Feb 15 09:28 - down   (17:09)
kirby :1           :1               Tue Feb 14 22:18 - down   (05:43)
kirby :1           :1               Tue Feb 14 19:38 - down   (00:49)
kirby :1           :1               Tue Feb 14 09:24 - down   (08:59)
kirby :1           :1               Mon Feb 13 10:34 - down   (07:58)
kirby :1           :1               Fri Feb 10 09:27 - down   (1+01:37)
```

最後の行の`1+01:37`は1 days + `01:37`, つまり, `25:37`時間稼働したことを意味します.


### 主要オプション

|short option|long option|説明|
|----|---|---|
|`-n <num>`|`--limit`|lastで表示する行数を数値で指定する|
|`-t YYYYMMDDhhmmss`|`--until`|指定した日時より前のログイン情報を表示する|
|`-s YYYYMMDDhhmmss`|`--since`|指定した日時より後のログイン情報を表示する|
|`-w`||ユーザー名を省略しない|

特定の期間でのlogin履歴を確認したい場合は,

```zsh
% last -s yesterday -t today     
kirby    :1           :1               Mon Feb 26 09:23   still logged in
reboot   system boot  6.5.0-18-generic Mon Feb 26 09:22   still running

wtmp begins Sun Jul 16 03:07:46 2023
```

### `last` vs `lastlog`

各ユーザーの最新ログインのみに関心がある場合は`lastlog`コマンドを用いることも有力な選択肢です.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: lastlog</ins></p>

- `/var/log/lastlog`バイナリファイルを参照して最新のログイン情報(ログイン名, ポート,最終ログイン日時)をユーザーごとに表示するコマンド
- 一度もログインしていないユーザーについては`**Never logged in**`と表示

</div>


Ubuntuサーバーにて`lastlog`コマンドを実行してみると

```bash
kirby@hostname $ lastlog
Username         Port     From             Latest
root                                       **Never logged in**
daemon                                     **Never logged in**
bin                                        **Never logged in**
sys                                        **Never logged in**
sync                                       **Never logged in**
...
sssd                                       **Never logged in**
speech-dispatcher                           **Never logged in**
fwupd-refresh                              **Never logged in**
nm-openvpn                                 **Never logged in**
saned                                      **Never logged in**
pulse                                      **Never logged in**
gnome-initial-setup                           **Never logged in**
hplip                                      **Never logged in**
gdm                                        Wed Feb 21 16:46:04 +0900 2022
dedede                                     Wed Feb 21 16:46:08 +0900 2022
pomuipomupurin                             **Never logged in**
korokorokirby                              **Never logged in**
nvidia-persistenced                           **Never logged in**
donkey                                     Tue Dec 13 12:35:19 +0900 2022
naruto           pts/4    123.354.234.71   Thu Feb 15 17:30:35 +0900 2022
sasuke           pts/3    123.358.234.94   Tue Jan 24 17:28:13 +0900 2022
kirby            pts/0    123.352.234.5    Mon Feb 20 22:43:29 +0900 2022
rstudio-server                             **Never logged in**
```

ここで, `**Never logged in**`と表記されるユーザーがたくさんいることに気づきます. 

- Login via gdm is not logged
- serviceやsystemと紐づくuserは基本loginはしない

が理由となります. 



## その他のログイン状況を参照するコマンド

ログイン状況を表示するコマンドとして他にも以下のようなコマンドがあります

- `who`コマンド: ログイン中のユーザーとログイン時刻とIPアドレスを表示するコマンド
- `w`コマンド: ログインしているユーザーとユーザーが実行中のプロセスを表示するコマンド
- `lastb`コマンド:　失敗したログインの記録を表示するコマンド
- `lastlog`: 最新のログインをユーザーごとに表示するコマンド

### `who`コマンド

```bash
kirby@hostname:~$ who
dedede  :1           2022-02-04 17:45 (:1)
kirby   pts/0        2022-02-26 22:43 (123.456.789.5)
```

`who`コマンドは, `/var/run/utmp`の情報に基づいて, 端末とlogin時刻を表示することができます.
上の例ではユーザー`dedede`は端末`:1`を利用して 2022-02-04 17:45 にloginしていると解釈できます.

`:1`はUbuntuの文脈ではdisplay serverの番号を表しており, `:1`は特に２つ目のdisplay serverを意味しています.
X Window SystemベースのGUIでloginしているときは基本的には「display serverの番号」が表示されます.

一方, Waylandベースでログインした場合は

```bash
dedede@hostname:~$ who
dedede   tty2        2022-02-26 22:43 (tty2)
```

と僕の環境では表示されます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS</ins></p>

- `who` reports the logged in user from the console but none from the GUI.

</div>


#### `who`コマンドのオプション

`who`コマンドのオプションの代表例は以下です

|short option|long option|説明|
|----|---|---|
|`-a`|`--all`|全ての情報を表示する|
|`-b`|`--boot`|現在ログインしているシステムが起動した時刻を表示|
|`-m`||標準入力に関連付けられたホスト名とユーザーのみを表示, `who am i`と同じ|
|`-q`|`--count`|ログイン中のユーザーのログイン名とユーザー数を表示|
|`-r`|`--runlevel`|現在のランレベルを表示|

GUIで起動したUbuntu上で`tmux`を起動し, `who`コマンドの挙動を見てみます

```zsh
% who
kirby_ubuntu :1           2022-02-26 09:23 (:1)
kirby_ubuntu pts/0        2022-02-27 01:04 (tmux(1w [オプション] [ユーザー名]56948).%0)
```

このとき, `who -m`で自分の情報だけを表示すると

```zsh
% who am i
kirby_ubuntu pts/0        2022-02-27 01:04 (tmux(156948).%0)

% who aa bb
kirby_ubuntu pts/0        2022-02-27 01:04 (tmux(156948).%0)

% whoami
kirby_ubuntu
```

なお, `who aa bb`でも`who am i`と同じ挙動になる理由は任意の2つの引数を指定すると`who -m`として動作するためです.

### `w`コマンド: ログインしているユーザーと実行中のプロセスを表示

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: wコマンド</ins></p>

- ログインしているユーザーと実行中のプロセスを表示するコマンド
- `/var/run/utmp`の情報に基づいて出力

```bash
w [オプション] [ユーザー名]
```

</div>

`who`コマンドと異なり, ヘッダーにて左から

- 現在の時刻
- システムの稼働時間
- 現在ログインしているユーザーの数
- システムの平均負荷（過去1分間, 5分間, 15分間）

を出力します.

ユーザーごとの情報は, 左から

- `USER`: 現在ログインしているユーザーのログイン名
- `TTY`: 端末
- `FROM`: リモートホスト
- `LOGIN@`: ログイン時刻
- `IDLE`: アイドル時間
- `JCPU`: その端末で実行した全プロセスが使った時間
- `PCPU`: カレントプロセスが使用した時間
- `WHAT`: 現在実行中のプロセス

を表示します.w [オプション] [ユーザー名]


### `lastb`コマンド: Bad Login履歴を確認する

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: lastbコマンド</ins></p>

- `/var/log/btmp`ファイルを参照しシステムのログインエラー履歴を一覧表示するコマンド
- 実行にはroot権限が必要

```zsh
% lastb [オプション] [ユーザー名] [端末番号]
```

</div>

Optionは`last`コマンドとほぼ同じで

|short option|long option|説明|
|----|---|---|
|`-n <num>`|`--limit`|lastで表示する行数を数値で指定する|
|`-t YYYYMMDDhhmmss`|`--until`|指定した日時より前のログイン情報を表示する|
|`-s YYYYMMDDhhmmss`|`--since`|指定した日時より後のログイン情報を表示する|
|`-w`||ユーザー名を省略しない|




## Appendix: システム上のユーザー一覧を取得する

Linuxでは大まかに２種類のユーザーが存在します

- 人間が操作するためのアカウントとして作られたuser
- 特定のserviceやsystem functionと結びつく形で作られたuser

これらの情報は`/etc/passwd`に保存されています. そのため, ユーザー一覧を取得したい場合は
以下のコマンドを入力します:

```zsh
% cut -d : -f 1 /etc/passwd
```

---|---
`-d`|区切り文字を指定
`-f`|切り出すフィールドindexを指定, 複数の場合は`1-3`などと指定

または, `getent`コマンドを用いて

```zsh
% getent passwd | cut -d : -f1
```



References
----------
- [How to detect a user logged in through GUI in Linux](https://stackoverflow.com/questions/11467258/how-to-detect-a-user-logged-in-through-gui-in-linux)
