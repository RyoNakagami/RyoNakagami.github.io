---
layout: post
title: "Linux基礎知識：カレントディレクトリ下のフォルダ一覧表示"
subtitle: "du,grep,awkを活用してls likeに出力する"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-08-04
mermaid: false
tags:

- Linux
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [カレントディレクトリの構成](#%E3%82%AB%E3%83%AC%E3%83%B3%E3%83%88%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%AE%E6%A7%8B%E6%88%90)
- [ls commandで試してみる](#ls-command%E3%81%A7%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%82%8B)
  - [マニュアルを確認してみる](#%E3%83%9E%E3%83%8B%E3%83%A5%E3%82%A2%E3%83%AB%E3%82%92%E7%A2%BA%E8%AA%8D%E3%81%97%E3%81%A6%E3%81%BF%E3%82%8B)
  - [なぜ`ls -d`が意図した挙動にならないのか？](#%E3%81%AA%E3%81%9Cls--d%E3%81%8C%E6%84%8F%E5%9B%B3%E3%81%97%E3%81%9F%E6%8C%99%E5%8B%95%E3%81%AB%E3%81%AA%E3%82%89%E3%81%AA%E3%81%84%E3%81%AE%E3%81%8B)
  - [`ls -ld */`とパターンを指定するといける](#ls--ld-%E3%81%A8%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B%E3%81%A8%E3%81%84%E3%81%91%E3%82%8B)
  - [grepと組合せて余計な`/`を消す](#grep%E3%81%A8%E7%B5%84%E5%90%88%E3%81%9B%E3%81%A6%E4%BD%99%E8%A8%88%E3%81%AA%E3%82%92%E6%B6%88%E3%81%99)
  - [フォルダサイズが4096 byteと表示されていて変](#%E3%83%95%E3%82%A9%E3%83%AB%E3%83%80%E3%82%B5%E3%82%A4%E3%82%BA%E3%81%8C4096-byte%E3%81%A8%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%81%A6%E5%A4%89)
- [要件再定義](#%E8%A6%81%E4%BB%B6%E5%86%8D%E5%AE%9A%E7%BE%A9)
- [実装](#%E5%AE%9F%E8%A3%85)
  - [最終的に`.zshrc`に書き込んだ関数](#%E6%9C%80%E7%B5%82%E7%9A%84%E3%81%ABzshrc%E3%81%AB%E6%9B%B8%E3%81%8D%E8%BE%BC%E3%82%93%E3%81%A0%E9%96%A2%E6%95%B0)
  - [作成方針](#%E4%BD%9C%E6%88%90%E6%96%B9%E9%87%9D)
  - [disk usageデータの取得:`du`コマンド](#disk-usage%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E5%8F%96%E5%BE%97du%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [`join`コマンドを用いて`ls`と`du`の出力結果を結合する](#join%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6ls%E3%81%A8du%E3%81%AE%E5%87%BA%E5%8A%9B%E7%B5%90%E6%9E%9C%E3%82%92%E7%B5%90%E5%90%88%E3%81%99%E3%82%8B)
  - [`column`コマンドを用いた表整形](#column%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E8%A1%A8%E6%95%B4%E5%BD%A2)
- [Appendix](#appendix)
  - [`ls`コマンドのカラー設定](#ls%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E3%82%AB%E3%83%A9%E3%83%BC%E8%A8%AD%E5%AE%9A)
  - [ディレクトリのハードリンク](#%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%AE%E3%83%8F%E3%83%BC%E3%83%89%E3%83%AA%E3%83%B3%E3%82%AF)
  - [ハードリンクのiノード番号の確認](#%E3%83%8F%E3%83%BC%E3%83%89%E3%83%AA%E3%83%B3%E3%82%AF%E3%81%AEi%E3%83%8E%E3%83%BC%E3%83%89%E7%95%AA%E5%8F%B7%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [ハードリンクファイルの作成方法: `ln`コマンド](#%E3%83%8F%E3%83%BC%E3%83%89%E3%83%AA%E3%83%B3%E3%82%AF%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90%E6%96%B9%E6%B3%95-ln%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 問題設定

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220804-ls-goal.png?raw=true">

このような形で,カレントディレクトリ下に存在するフォルダのみを一覧として取得したい.

### カレントディレクトリの構成

```zsh
% ls
s1/   s13/  s17/  s3/  s7/         text11.txt  text15.txt  text19.txt  text4.txt  text8.txt
s10/  s14/  s18/  s4/  s8/         text12.txt  text16.txt  text1.txt   text5.txt  text9.txt
s11/  s15/  s19/  s5/  s9/         text13.txt  text17.txt  text2.txt   text6.txt
s12/  s16/  s2/   s6/  text10.txt  text14.txt  text18.txt  text3.txt   text7.txt
```

## ls commandで試してみる
### マニュアルを確認してみる

まず基本通り`man`コマンドをたたきoptionが存在する確認してみた.

```zsh
% man ls
LS(1)                                  User Commands                                 LS(1)

NAME
       ls - list directory contents

SYNOPSIS
       ls [OPTION]... [FILE]...

DESCRIPTION
       List  information about the FILEs (the current directory by default).  Sort entries
       alphabetically if none of -cftuvSUX nor --sort is specified.

       Mandatory arguments to long options are mandatory for short options too.
       
       <略>
       -d, --directory
              list directories themselves, not their contents
```

こたえが`-d`を指定するだけで求めているものが出力されるとの仮説を立てて実行したところ

```zsh
% ls -d
./
```

とフォルダがカレントディレクトリに存在するにもかかわらず期待した結果を返さない.
find ./  -maxdepth 1 -type d | wc -l
### なぜ`ls -d`が意図した挙動にならないのか？

`ls`に何も引数を与えない場合,デフォルトではカレントディレクトリに対してコマンドが実行されます.
通常,これはディレクトリの内容をリストアップすることを意味しますが,`-d`を指定したことで内容は参照されることなく,ディレクトリ自体のリスト=カレントディレクトリのみの情報が取得されることになります.

カレントディレクトリのみの情報が取得されていることの確認は,`ls -ld`の出力結果から確認できるフォルダ作成日を確認するとわかります.

### `ls -ld */`とパターンを指定するといける

ファイルとディレクトリの違いの一つとして, `*/`というパターンに後者はマッチするが前者はマッチしないという特徴があります. これを活用して,中身を参照することなく`*/`にマッチするものだけで出力すればまずもとめていたものを出力することができます.

```zsh
 % ls -ld */
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s1//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s10//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s11//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s12//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s13//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s14//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s15//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s16//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s17//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s18//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s19//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s2//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s3//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s4//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s5//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s6//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s7//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s8//
drwxr-xr-- 2 unko_unko unko_unko 4096 Aug  4 01:44 s9//
```

余分な`/`も出力されてしまいますが一応求めていたものを得ることができました.
なお,`-d`を指定せず実行してしまうとsubdirectoryの中身も参照してしまいフォルダに所属するフォルダまで出力されてしまいます.
`-d`はデレクトリのみを出力するのではなくて, `not their contents`=(中身を確認しないですよ)と理解するほうが正確といえます.

### grepと組合せて余計な`/`を消す

 `*/`というパターンに後者はマッチするのはディレクトリのみなので,`grep`コマンドを使って出力するという解決策もあり得ます.

```zsh
% ls -l | GREP_COLOR="1;34" grep -E "\s\S+?/$"
```

Then,

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220804-ls-goal.png?raw=true">

- `GREP_COLOR="1;34"`はgrepでマッチした箇所を青色で表示させるコマンドです
- `"\s\S+?/$"`の意味は`/`で終了, spaceと一回以上連続するspace以外の文字の最小組合せの意味です

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>
### フォルダサイズが4096 byteと表示されていて変

フォルダの中にファイルが存在しており,フォルダサイズは以下のように表示されるべきところ,すべて4096と表示されています.

```zsh
% du -shx */
260K	s2/
100K	s14/
56K	s1/
44K	s4/
4.0K	s9/
4.0K	s8/
4.0K	s7/
4.0K	s6/
4.0K	s5/
4.0K	s3/<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>
4.0K	s19/
4.0K	s18/
4.0K	s17/
4.0K	s16/
4.0K	s15/
4.0K	s13/
4.0K	s12/
4.0K	s11/
4.0K	s10/
```

`ls -l`で出力されるサイズはそのオブジェクトのスペース使用量を表示するのみで,フォルダ下に存在するファイルサイズを合計した値は出力されません. 直感的なイメージとしてはそのオブジェクトのデータブロックサイズを返しているという感じです.

また,`ls -l`で表示されるtimeもオブジェクトが作成された時間を返しており,個人的にはここは最終更新時間が欲しい.

## 要件再定義

- `ls -l`ライクに以下の情報を出力したい:
    - フォルダの種類と許可属性
    - ハードリンク数
    - 所有者とグループ
    - ディスク使用量
    - 最終更新タイムスタンプ
    - カレントディレクトリ下に存在するフォルダ名称
- フォルダの色は青色で表示する
- インデントはできる限り揃える

> 出力結果イメージ

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2022-08-04-ls-goal-redefined.png?raw=true">


## 実装
### 最終的に`.zshrc`に書き込んだ関数

```zsh
function ls-dir(){
  join -1 4 -2 9  <(du -shx --time */) <(ls -Flh)\
  |awk '{print $5, $6, $7, $8, $2, $3, $4, $1}' FS=' '\
  |column -t\
  |GREP_COLOR="1;34" grep -E "\s\S+?/$"
}

alias ls-dir=ls-dir
```

### 作成方針

1. `ls`と`du`コマンドを用いて必要情報を取得する
2. 上記結果をフォルダ名をキーとして,`join`コマンドを用いてINNER JOINする
3. awkとcolumnで表示形式を整える
4. grepで色付け<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>

### disk usageデータの取得:`du`コマンド

`du`コマンドは, 指定したファイルのサイズやディレクトリのディスクの使用量を表示するコマンドです. 

> Syntax

```
% du [OPTIONS] PATH
```

- PATHの部分はワイルドカード検索も可能
- ディレクトリ一覧のディスク使用量を検索したい場合は `*/`と指定関連ポスト


> duコマンドの主なオプション<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>

|短いオプション|長いオプション|説明|
|---|---|---|
|`-s`|`--summarize`|指定したディレクトリの合計のみを表示する（サブディレクトリの行が表示されなくなる）|
|`-x`|`--one-file-system`|異なるファイルシステム（パーティション）にあるディレクトリをスキップする|
|`-h`|`--human-readable`|サイズに応じて読みやすい単位で表示する|

> 動作確認

```zsh
 % du -shx */
56K	s1/
4.0K	s10/
4.0K	s11/
4.0K	s12/
4.0K	s13/
100K	s14/
4.0K	s15/
4.0K	s16/<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>
4.0K	s17/
4.0K	s18/
4.0K	s19/
```

これでフォルダごとのDisk Usageの情報を取得.

### `join`コマンドを用いて`ls`と`du`の出力結果を結合する

> Syntax: joinコマンド

```zsh
join [OPTION] -1 FIELD -2 FIELD FILE1 FILE2
```
<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>
- `-1 FIELD`:  FILE1のjoin key fieldの指定
- `-2 FIELD`:  FILE2のjoin key fieldの指定
- デフォルトの結合フィールドは空白で区切られた最初カラム

### `column`コマンドを用いた表整形

`column`コマンドは,複数列があるデータを左揃えで表示させることができます.

> Option

---|---
`-c カラム数`|表示の幅を指定します。
`-t`|入力行のカラム数を自動判定し、表を作成します。
`-s`|入力行を列（カラム）に分ける区切り文字をしています.-t オプションと併用します.デフォルトは半角スペース
`-x`|行を埋める前に列を埋めます

## Appendix
### `ls`コマンドのカラー設定

`ls` 実行時のファイルの配色は環境変数 `$LS_COLORS`で設定されています. ファイルの配色は

1. ファイルの種類 (ディレクトリ, シンボリックリンクなど)
2. 拡張子 (.jpg , .gz など)

の２つで決まっており以下のコマンドで確かめることができます.

```zsh
% echo $LS_COLORS 
rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:(略)
```

> 色と色番号とファイルの種類

---|---|---
白色|37|通常ファイル
青色|34|ディレクトリ
水色|36|シンボリックリンク
赤色|31|圧縮ファイル
緑色|32|実行ファイル
黄色|33|特殊ファイル

### ディレクトリのハードリンク

ディレクトリの場合は`usr`や`home`といった名前の他に自分自身を示関連ポストす`.`というハードリンクが自動で作成されます. 従って,ディレクトリにはハードリンクが「最低2つある」ことになります(= 新規に作成したディレクトリに所属したオブジェクト数はからディレクトリであっても 2と表示される). 

サブディレクトリがある場合は、サブディレクトリから見た`..`（親ディレクトリ）があるため、ハードリンクの数は3つとなります. つまり.特別にハードリンクを増やしていない限り,ディレクトリのハードリンク数は「サブディレクトリの数＋2」となります。

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ハードリンク</ins></p>

ファイルやディレクトリに別名をつけ, 異なった名前で同じデータにアクセスできる仕組みの１つをハードリンクといいます. 

ファイルの実体(= ストレージ上に保存されているデータ)が１つだけであっても, その実体を指し表す複数のファイルがあっても, それぞれのファイルの内容と属性はハードリンクでは同一です. 

</div>

一般的にはシンボリックリンクが使用されます. 違いとしては, シンボ関連ポストリックリンクはリンク先を呼び出すだけなので, それ自体を削除しても本体には影響がありませんが, 本体を削除してしまうとリンクが切れてしまいます. 一方, ハードリンクは両方とも同じものとみなされるので, 異なるファイルが同じデータ実体を参照している形になります. そのため, どちらかを削除してももう片方は引き続きデータを参照することができるというメリットがあります.


### ハードリンクのiノード番号の確認

Linuxでは, iノードにファイルの属性情報が格納されます. 新規にファイルやディレクトリを作成するとファイルシステム上で重複しないiノード番号が割り当てられます. この番号の確認方法は

```
% ls -i
```

で確認することができます.　空ディレクトリに存在する`.`と`..`のiノード番号を`ls -i`で確認すると, それぞれが自分自身と親ディレクトリのiノード番号と一致することが確認できます.

### ハードリンクファイルの作成方法: `ln`コマンド
関連ポスト
`ln`コマンド(LiNKコマンド)は, ファイルやディレクトリに対するリンクを作るコマンドです.

```
% ln <original file> <link file>
```

ただし, ディレクトリのハードリンクはユーザーからは作成できません. 「hard link not allowed for directory」というメッセージが出てきてしまいます. シンボリックリンクは作成可能です. 

file pathは絶対パスで指定することを推奨します.


References
----------

- [Ryo's Tech Blog > Linux commandの復習: awkコマンド](https://ryonakagami.github.io/2021/12/16/awk-command-basic/)
- [Ubuntuサーバー徹底入門, 中島 能和 著](https://www.shoeisha.co.jp/book/detail/9784798155760)
- [StackExchange > Listing directories and understanding ls](https://unix.stackexchange.com/questions/215566/listing-directories-and-understanding-ls?rq=1)
- [StackExchange > du only for directories](https://superuser.com/questions/322521/du-only-for-directories)