---
layout: post
title: "Private Repository用git cloneシェルスクリプトの作成"
subtitle: "アクセストークンを用いたgit clone"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-06
tags:

- git
- GitLab
- GitHub
- Shell
---

---|---
目的|git clone
OS|ubuntu 20.04 LTS Focal Fossa
Requirement|アクセストークン取得済み
シェルスクリプト言語|Bash


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. Goal: 完成シェルスクリプト](#1-goal-%E5%AE%8C%E6%88%90%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88)
  - [BashのVersion](#bash%E3%81%AEversion)
- [2. シェルスクリプトとは？](#2-%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%A8%E3%81%AF)
  - [コマンドの基本](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E5%9F%BA%E6%9C%AC)
  - [シェルスクリプトの決まりごと](#%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%AE%E6%B1%BA%E3%81%BE%E3%82%8A%E3%81%94%E3%81%A8)
- [3. 自作シェルスクリプトの解説](#3-%E8%87%AA%E4%BD%9C%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%AE%E8%A7%A3%E8%AA%AC)
  - [Usage関数の解説](#usage%E9%96%A2%E6%95%B0%E3%81%AE%E8%A7%A3%E8%AA%AC)
  - [メイン部分](#%E3%83%A1%E3%82%A4%E3%83%B3%E9%83%A8%E5%88%86)
- [4. シェルスクリプト構成要素の解説](#4-%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E6%A7%8B%E6%88%90%E8%A6%81%E7%B4%A0%E3%81%AE%E8%A7%A3%E8%AA%AC)
  - [メッセージ表示内容: ヒアドキュメント](#%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E8%A1%A8%E7%A4%BA%E5%86%85%E5%AE%B9-%E3%83%92%E3%82%A2%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88)
  - [basenameコマンド: パス名からファイル名を取得](#basename%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89-%E3%83%91%E3%82%B9%E5%90%8D%E3%81%8B%E3%82%89%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D%E3%82%92%E5%8F%96%E5%BE%97)
  - [コマンド置換: 標準出力結果を文字列へ](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E7%BD%AE%E6%8F%9B-%E6%A8%99%E6%BA%96%E5%87%BA%E5%8A%9B%E7%B5%90%E6%9E%9C%E3%82%92%E6%96%87%E5%AD%97%E5%88%97%E3%81%B8)
  - [位置パラメータ](#%E4%BD%8D%E7%BD%AE%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF)
  - [`exit`コマンド](#exit%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [Appendix](#appendix)
  - [typeコマンドでコマンドの正体を調べる](#type%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A7%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E6%AD%A3%E4%BD%93%E3%82%92%E8%AA%BF%E3%81%B9%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. Goal: 完成シェルスクリプト

```bash
#!/usr/bin/bash
## GitHub private repositoryをcloneする関数
## Author: Ryo Nakagami
## Revised: 2022-08-05

## REQUIREMENT
##  GIT_USER, GIT_TOKENなどは別の場所にて変数として保存してある

function usage {
  cat <<EOM
NAME
    $(basename "$0") - Clone a repository into a new directory with User credential info

Syntax
    $(basename "$0") [OPTION] <repository URL>

DESCRIPTION
    This is a wrapper function of git clone
    This allows you to do 'git clone' with your user credential,
    that is, you can git clone private repositories which you can access to.

OPTIONS
  -h, --help
    Display help

  -gl, --gitlab
    you can clone a gitlab repository
EOM

  exit 0
}

function error_message {
    echo 'fatal: something wrong! Check the input'
    exit 1
}

if [[ $1 == '-h' || $1 == '--help' ]]; then
    usage

elif [[ $# == 2 && $2 =~ 'https://gitlab' && ( $1 == '-gl' || $1 == '--gitlab' ) ]]; then
    pass="${GITLAB_USER}:${GITLAB_TOKEN}"
    surfix=$(echo $2 |sed -e 's/^https:\/\//@/g');

elif [[ $# == 1 && $1 =~ 'https://github' ]]; then
    pass="${GIT_USER}:${GIT_TOKEN}"
    surfix=$(echo $1 |sed -e 's/^https:\/\//@/g');

else
    error_message
fi

prefix='https://';
clone_args="$prefix$pass$surfix";
git clone "$clone_args"
```

GitHub(GitLabも同様ですが)のrepository URLは以下のような構造をしてします:

```html
https://github.com/<repository-ownername>/<repository-name>
```

repositoryがpublicの場合は手元にcloneしたいときは特に問題ないですが, Private Repositoryの場合は以下のような構文を用いる必要があります(ssh接続ではなくアクセストークン経由を想定)

```zsh
git clone https://<user-name>:<access-token>@github.com/<repository-ownername>/<repository-name>
```

毎回毎回, ちょっと手元で編集してCLI入力するのがめんどくさいので, Repository URLを指定したらユーザー目線ではそのままlocalへgit cloneが実行できるシェルスクリプトを今回作成しました.

### BashのVersion

```bash
$ bash --version
GNU bash, version 5.0.17(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```


## 2. シェルスクリプトとは？

シェルスクリプトとは, シェルに対するコマンドを予めテキストファイルに保存したものです. 複数コマンドを組合せた一連の操作をまとめて実行できます.

あくまで複数のコマンドをまとめて実行するものなので, 複雑なロジックやデータ構造を扱うには適してないことに注意です. 重要なのは, 

- simple & readable
- 必要最小限の機能が実装されている

この二点を実現することです.

### コマンドの基本

コマンドの基本構文に従う形でシェルスクリプトも動作することがsimple & readableにつながります. コマンドの基本構文は基本的には以下4パターンです

```bash
command
command argument
command option
command option argument
```

コマンドと, optionや引数のいずれか/両方を用いる利用をする場合は, 半角スペースで区切り, 上の順番で用いることが基本構文となります. 

### シェルスクリプトの決まりごと

> シェルの種別宣言: shebang

シェルスクリプトの１行目はどのシェルを使うのかという宣言から始まります. 

```bash
#!/bin/bash
```

とあるならばbashを用いると宣言したシェルスクリプトとなります.
このようにスクリプト言語のコマンドの絶対パスという形式で記述します. 
なお, この１行目のことをshebang(シバン)と呼びます.

```bash
#!/bin/bash -x
```

と指定すると, シェルスクリプト一行ごとの実行コマンドをTerminal上に表示してくれるので, デバッグ作業のときは重宝されます.

> シェルと変数定義

変数を定義するときは `variable=STRINGS` という構文を用います. 定義した変数を参照したい場合は `$variable` で文字列として利用することができます.

```zsh
% a=hogehoge
% echo $a; echo ${a}
>>> hogehoge
>>> hogehoge
```

なお、Pythonみたいに `a = hogehoge` と入力してしまうと, 「command argument argument」と解釈されてしまうので注意です.


> 引用符の使い方

シェルスクリプトで文字列を記述する際は, ダブルクォーテーションとシングルクォーテーションの引用符で囲みます. 前者に含まれる変数はその値で置き換えられますが, 後者の場合はその文字列のまま評価されます.

```zsh
#!/bin/zsh
message=unko
echo $message
echo '$message'
echo "$message"
echo "${message}-unchi"
```

このときの実行結果は

```
unko
$message
unko
unko-unchi
```

変数名とその他の文字を続けて記載する場合は, 上の例のように`{}`で変数名を囲むことでシェルに変数と文字列の区別を命令することができます.

> Permissionの設定

シェルスクリプトは, そのままではただのテキストファイルです. 利用するためには, Permissionを設定して実行権限を与える必要があります.

```zsh
% chmod u+x <shell script file>
```

なお, シェルスクリプトファイルの実行権限を付与したとしても, そのファイルが属するディレクトリに対する実行権限を有していないと結局そのシェルスクリプトは実行できません. ディレクトリに実行権限がないと, その中にあるファイルの中身を参照することができず実行できなくなってしまうことを忘れずに.

> PATHの設定

コマンド名だけでシェルスクリプトを実行したい場合, そのシェルスクリプトが存在するディレクトリのPATHをPATH変数に指定すること(=PATHを通す)が必要です.

`.zshrc`や`,bash_profile`といったファイルで一例として以下のように設定すると,ログイン時やシェル起動時にPATH変数が設定されます.

```zsh
PATH=$PATH:<シェルスクリプトが存在するディレクトリPATH>
```

複数のPATHをつなぐ場合は`:`でつなぎます. 実際に上手く登録されているか確認する場合は以下のコマンドで確認できます.

```zsh
% echo $PATH|grep -E "シェルスクリプトが存在するディレクトリPATH"
```

## 3. 自作シェルスクリプトの解説

今回作成したシェルスクリプトは`gh_clone`という名前で保存しているので, 以下`gh_clone`と呼びます.

`gh_clone`の主要機能は以下です:

- GitHubのprivate repositoryのURLを引数に設定すると, 自動的に別箇所に保存されたGitHubアクセストークンとGitHub User名を参照し, git cloneしてくれる
- Optionに `-gl, --gitlab` と指定するとGitLabにも対応してくれる
- Optionに `-h, --help` と指定するとマニュアルを表示してくれる
- 入力構文がおかしいときはError Messageを出力してくれる

> Syntax

```
gh_clone [option] <Repository URL>
```

- この順番は変更不可能です = `gh_clone <Repository URL> [option]`とはできない
- optionを指定しない場合は, GitHubのprivate repositoryのgit cloneを試みます


### Usage関数の解説

`usage`関数はいわゆるヘルプメッセージ表示関数です. `-h` や `--help`とオプションを指定すると表示されるマニュアルです.

特に引数もオプションもないシェルスクリプトには不必要ですが, もしいずれかがあるならば記載して損はないです. 今回使用した`usage`関数は以下,

```bash
function usage {
  cat <<EOM
NAME
    $(basename "$0") - Clone a repository into a new directory with User credential info

Syntax
    $(basename "$0") [OPTION] <repository URL>

DESCRIPTION
    This is a wrapper function of git clone
    This allows you to do 'git clone' with your user credential,
    that is, you can git clone private repositories which you can access to.

OPTIONS
  -h, --help
    Display help

  -l, --gitlab
    you can clone a gitlab repository
EOM

  exit 0
}
```




### メイン部分

```bash
if [[ $1 == '-h' || $1 == '--help' ]]; then
    usage

elif [[ $# == 2 && $2 =~ 'https://gitlab' && ( $1 == '-gl' || $1 == '--gitlab' ) ]]; then
    pass="${GITLAB_USER}:${GITLAB_TOKEN}"
    surfix=$(echo $2 |sed -e 's/^https:\/\//@/g');

elif [[ $# == 1 && $1 =~ 'https://github' ]]; then
    pass="${GIT_USER}:${GIT_TOKEN}"
    surfix=$(echo $1 |sed -e 's/^https:\/\//@/g');

else
    error_message
fi

prefix='https://';
clone_args="$prefix$pass$surfix";
git clone "$clone_args"
```

引数としてのURLの接頭部分 `^https:`を`@`に変更した後に, その文字列に対して`https://` + `<username>` + `<access-token>`を左から結合 & git cloneしているだけです. 正直なところ `-gl, --gitlab`とオプションを指定しなくても, URLの文字列に`https://gitlab`という文字列が先頭に含まれているかでどのトークンを参照すべきか分岐はできますが, 一応ユーザーが明示的に意識して入力するほうが良いだろうと判断し, 今回はこの方針に従って条件分岐させています.

> 条件句内部の `=~` 演算子の意味

２つの文字列が与えられた時, 片方がもう片方を含んでいるかの判定をする際に用いる regex operatorが `=~`です.

```bash
[[ STR1 =~ STR2 ]]
```

という条件式があたえられたとき, STR2がSTR1に含まれているならばTrueを返す演算子です.


```bash
#!/bin/bash

STR='GNU/Linux is an operating system'
SUB='Linux'

if [[ "$STR" =~ "$SUB" ]]; then
  echo "It's there."
fi

if [[ "$SUB" =~ "$STR" ]]; then
  echo "It's there in $SUB"
else
  echo "where are you, $STR?"
fi
```

上記を実行すると以下のような結果が得られます. 

```
It's there.
where are you, GNU/Linux is an operating system?
```


## 4. シェルスクリプト構成要素の解説
### メッセージ表示内容: ヒアドキュメント

```bash
cat <<EOM
    ...
EOM
```

で`EOM`で囲まれた箇所がTerminal上でヘルプメッセージとして表示されます. `EOM`であること自体には意味はなく, 同じ文字列で囲まれているかが重要です.

`cat <<EOM`はヒアドキュメントと分類されるリダイレクトのことで一般化すると

```
% command <<STRINGS
```

と表現されます. 基本的には `echo '文章'`と同じですが, 複数行に渡る長文や長文の中でシェル変数を展開したい場合に重宝されます. `STRINGS` 部分は任意の文字列で大丈夫です.

> REMARKS

- ヒアドキュメントは標準入力として扱われ, 文字列リテラルではありません

### basenameコマンド: パス名からファイル名を取得

`basename`は, ディレクトリ名とファイル名を含むパス名から, ディレクトリ部分を除き, ファイル名だけを取得 & 標準出力に出力するコマンドです.

対話型シェルを起動している時, `$0`変数には現在利用しているシェルのPATHが設定されています. `echo`でPATHを表示, `basename`でファイル名の取得を試みると以下のような結果を得ます.

```zsh
% echo $0 && basename $0
/usr/bin/zsh
zsh
```

### コマンド置換: 標準出力結果を文字列へ

コマンド置換を利用すると, コマンドの標準出力結果を文字列値として利用できるようになります. コマンド置換のSyntaxは

```zsh
$(command)
```

例として、以下の出力結果を比べてみます.

```zsh
### 一般的なコマンド置換
cat <<EOM
    NAME $(basename "$0")
EOM

cat <<EOM
    NAME "basename $0"
EOM

cat <<EOM
    NAME $basename $0
EOM

### バッククォーテーションで囲む
cat <<EOM
    NAME `basename $0`
EOM
```

この時の結果は,

```zsh
    NAME zsh
    NAME "basename /usr/bin/zsh"
    NAME  /usr/bin/zsh
    NAME zsh
```

コマンドのFULL PATHからPermisision設定を確認したい場合は

```zsh
% ls -l $(which gh_clone)
```

> REMARKS

- バッククォーテーションで囲んでもコマンド置換は実施可能ですが, 読みづらさが増すので利用は非推奨です

### 位置パラメータ

位置パラメータとは, スクリプトが呼び出された際のコマンドライン引数を保持するための特別な組込み変数のことです.
シェルスクリプトを実行するときのコマンドラインに引数を渡すと, シェルはそれらの値を位置パラメータ（Positional Parameters）に設定します.

|変数|機能|
|---|---|
|`$0`|スクリプト名|
|`$1 ~ $9`| 引数、1番目の引数を$1, 2番目の引数を$2でアクセスする|
|`$#`|スクリプトに与えた引数の数|
|`$*`|全部の引数をまとめて1つとして処理|
|`$@`|全部の引数を個別として処理|
|`$?`|直前実行したコマンドの終了値（0は成功、1は失敗）|
|`$$`|このシェルスクリプトのプロセスID|
|`$!`|最後に実行したバックグラウンドプロセスID|

`$*`と`$@`は違いは分かりづらいですが, 引数リストをそっくりそのまま別のスクリプトや関数に渡す場合, `$*` は 1つの文字列として解釈され,`$@` はそれぞれ別々のn個の文字列として解釈されるという違いがあります. 

> REMARKS

- bashで記載されたシェルスクリプトにて, `$0` はスクリプト内でグローバル変数であるが, それ以外は関数内でのローカルな変数となります.

ただし, この関係性は zshの場合は異なります. 上記シェルスクリプトのshebangを`#!/bin/zsh`に変更し, helpを表示すると確認できます) 

### `exit`コマンド 

> Syntax

```
exit ［n］
```

> 機能

- シェルを終了するコマンド (= `exit`を使うことにより任意の位置で実行を終了させることができる)
- システムに返す終了状態を指定することができます
- 0が正常終了で, 1が異常終了という設定が一般的です

> 直前のコマンドの終了ステータスの取得

```zsh
gh_clone -h
echo $? 
>>> 0
```

## Appendix
### typeコマンドでコマンドの正体を調べる

ユーザーが普段Linuxで使用するコマンドは大きく外部コマンド, 内部コマンド, エイリアスに分類されます.

- 内部コマンド: シェル本体がもっているコマンド, a shell builtin
- 外部コマンド: 実行ファイルとして個別に保存されているコマンド, 自作シェルスクリプトもここに分類される
- エイリアス: コマンドやオプションや引数を組合せて作成したコマンドを別名で保存しているもの

> typeコマンド

コマンド名を見ただけでは, それがエイリアスなのか内部コマンドなのか外部コマンドなのか識別することは難しいです.
そこで利用するのが `type`コマンドです.

例として以下,

```zsh
% type cd
cd is a shell builtin
% type awk 
awk is /usr/bin/awk
% type lc
lc is an alias for ls -F --color=auto --group-directories-first
% type for
for is a reserved word
```







## References

> 関連ポスト

- [Ryo's Tech Blog > GitHubパスワード認証廃止への対応](https://ryonakagami.github.io/2021/04/25/github-token-authentication/#git-clone%E7%94%A8%E3%81%AE%E9%96%A2%E6%95%B0%E6%A7%8B%E7%AF%89)
- [Ryo's Tech Blog > 権限管理入門とsudoの使い方](https://ryonakagami.github.io/2021/05/05/ubuntu-permission/#references)

> 参考書籍

- [UNIXの絵本, 株式会社アンク著](https://www.shoeisha.co.jp/book/detail/4798109339)

> オンラインマテリアル

- [GitHub Gist > tsukune-ch/shell_script_memo.md](https://gist.github.com/tsukune-ch/3ad7e29b7adae2563d279b6e302f71d7)