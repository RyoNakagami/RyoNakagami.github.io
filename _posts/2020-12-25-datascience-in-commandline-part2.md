---
layout: post
title: "シェルスクリプトと前処理 Part 2"
subtitle: "シェルコマンドを用いたデータの取得"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
tags:
  - 前処理
  - Shell
---



|概要||
|---|---|
|目的|シェルコマンドを用いたデータの取得|
|実行環境|Ubuntu 20.04|
|参考|[Data Science at the Command Line](https://www.datascienceatthecommandline.com/1e/chapter-3-obtaining-data.html)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1.  このノートのスコープ](#1--%E3%81%93%E3%81%AE%E3%83%8E%E3%83%BC%E3%83%88%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [利用するデータの準備](#%E5%88%A9%E7%94%A8%E3%81%99%E3%82%8B%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E6%BA%96%E5%82%99)
- [2. Decompressing Files](#2-decompressing-files)
  - [ファイルの圧縮・展開コマンド](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E5%9C%A7%E7%B8%AE%E3%83%BB%E5%B1%95%E9%96%8B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [zipコマンド](#zip%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
    - [Syntaxとオプション](#syntax%E3%81%A8%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
  - [gzipコマンド](#gzip%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
    - [Syntaxとオプション](#syntax%E3%81%A8%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3-1)
  - [bzip2コマンド](#bzip2%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
    - [Syntaxとオプション](#syntax%E3%81%A8%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3-2)
  - [xzコマンド](#xz%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
    - [Syntaxとオプション](#syntax%E3%81%A8%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3-3)
  - [アーカイブの作成と展開](#%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83%96%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E5%B1%95%E9%96%8B)
    - [Syntaxとオプション](#syntax%E3%81%A8%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3-4)
- [3. Converting Microsoft Excel Spreadsheets](#3-converting-microsoft-excel-spreadsheets)
  - [前提条件：`csvkit`のインストール](#%E5%89%8D%E6%8F%90%E6%9D%A1%E4%BB%B6csvkit%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [xlsxファイルをcsvファイルに変換する](#xlsx%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92csv%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AB%E5%A4%89%E6%8F%9B%E3%81%99%E3%82%8B)
- [4. Querying Relational Databases](#4-querying-relational-databases)
  - [sql2csvのSyntax](#sql2csv%E3%81%AEsyntax)
  - [Examples](#examples)
- [5. Downloading from the Internet](#5-downloading-from-the-internet)
  - [curlコマンドの主なオプション](#curl%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E4%B8%BB%E3%81%AA%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
  - [実行進捗状況の表示と`-s`](#%E5%AE%9F%E8%A1%8C%E9%80%B2%E6%8D%97%E7%8A%B6%E6%B3%81%E3%81%AE%E8%A1%A8%E7%A4%BA%E3%81%A8-s)
  - [curl出力結果をファイルに保存する](#curl%E5%87%BA%E5%8A%9B%E7%B5%90%E6%9E%9C%E3%82%92%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AB%E4%BF%9D%E5%AD%98%E3%81%99%E3%82%8B)
  - [curlコマンドを用いたレクチャーノートのインストール](#curl%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%AC%E3%82%AF%E3%83%81%E3%83%A3%E3%83%BC%E3%83%8E%E3%83%BC%E3%83%88%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [APPENDIX: パイプ](#appendix-%E3%83%91%E3%82%A4%E3%83%97)
- [APPENDIX: リダイレクト](#appendix-%E3%83%AA%E3%83%80%E3%82%A4%E3%83%AC%E3%82%AF%E3%83%88)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1.  このノートのスコープ

- Obtain data from the Internet
- Query databases
- Connect to Web APIs
- Decompress files
- Convert Microsoft Excel spreadsheets into usable data

### 利用するデータの準備

docker imageを立ち上げた後、home directory直下にレポジトリーから関連レポジトリーをgit cloneします。

```
$ git clone --no-checkout https://github.com/jeroenjanssens/data-science-at-the-command-line
$ cd ./data-science-at-the-command-line
$ git config core.sparsecheckout true
$ echo book/1e/data/ch03/data/ > .git/info/sparse-checkout
$ echo book/1e/data/.data/ >> .git/info/sparse-checkout
$ git read-tree -m -u HEAD
```

## 2. Decompressing Files

バイトサイズが大きいファイルを取扱う際、ファイルを圧縮（ディレクトリの場合はアーカイブ）するケースが多いです。そうすることで、記憶領域の節約やfile transfer速度の向上が見込めます。同じ値を繰り返し保有しているファイル（例：the words in a text file や the keys in a JSON file）は圧縮に適しているとされます。圧縮でよく使用される拡張子は`tar.gz`, `.zip`, や `.rar`です。

### ファイルの圧縮・展開コマンド

Linuxではよく使われるファイルの圧縮形式として４種類あります。

|拡張子|圧縮コマンド|展開コマンド|
|---|---|---|
|`.zip`|`zip`|`unzip`|
|`.gz`|`gzip`|`gunzip`|
|`.bz2`|`bzip2`|`bunzip2`|
|`.xz`|`xz`|`unxz`|

### zipコマンド

zipはWindows環境で特にポピュラーな圧縮形式で、複数のファイルを圧縮して1つのファイルにすることができます。圧縮スピードや展開スピード、圧縮率はgzipに負けます。

#### Syntaxとオプション

```
$ zip [option] [圧縮後のファイル名] [ファイル名]
```

|オプション|説明|
|---|---|
|`-r`|指定したディレクトリを再帰的に圧縮する|
|`-x ファイル名`|アーカイブに含めないファイルを指定する|
|`-e`|暗号化したアーカイブを作成し展開時に必要なパスワードを設定する|
|`-j`|ディレクトリ名なしで格納する|

解凍先のディレクトリを指定する場合は、下記のようにします。

```
$ unzip hoge.zip -d foo
```

### gzipコマンド

複数のファイルをまとめるという“アーカイブ機能”はなく、1つ1つのファイルに対して機能します。gzipコマンドで圧縮されたファイルには、元のファイル名に拡張子「.gz」が追加されます。

#### Syntaxとオプション

```
$ gzip [option] [ファイル名]
```

|オプション|説明|
|---|---|
|`-1～-9` |圧縮レベル（「-1」が低圧縮率で高速、「-9」は高圧縮率だが低速）|
|`-c`|結果をファイルではなく標準出力へ出力する（主にパイプで別コマンドに渡す際に使用）|
|`-d`|ファイルを展開する（gunzipのデフォルト）|
|`-f`|すでに圧縮ファイルが存在しても上書きする|
|`-k`|圧縮後にもとのファイルを削除しない（圧縮前／伸張前のファイルを残す）|
|`-r`|ディレクトリを再帰的に処理する|
|`-t`|圧縮ファイルをテストする|

### bzip2コマンド

gzip/gunzipコマンド同様、1つ1つのファイルに対して機能します。複数のファイルをまとめたい場合は、tarコマンドと組み合わせる手法が一般的です。拡張子には`.bz2`を使用します。gzipより新しく、圧縮率も高い形式です。ただし、`xz`コマンドのほうが圧縮率は高い。

#### Syntaxとオプション

```
$ bzip2 [option] [ファイル名]
```

|オプション|説明|
|---|---|
|`-1～-9` |圧縮レベル（「-1」が低圧縮率で高速、「-9」は高圧縮率だが低速）|
|`-c`|結果をファイルではなく標準出力へ出力する（主にパイプで別コマンドに渡す際に使用）|
|`-d`|ファイルを展開する（bunzip2のデフォルト）|
|`-f`|すでに圧縮ファイルが存在しても上書きする|
|`-k`|圧縮後にもとのファイルを削除しない（圧縮前／伸張前のファイルを残す）|
|`-t`|圧縮ファイルをテストする|

### xzコマンド

gzipコマンド、gunzipコマンド同様、1つ1つのファイルに対して機能します。複数のファイルをまとめたい場合は、tarコマンドと組み合わせる手法が一般的です。

#### Syntaxとオプション

```
$ xz [option] [ファイル名]
```

|オプション|説明|
|---|---|
|`-0～-9` |圧縮レベル（「-0」が低圧縮率で高速、「-9」は高圧縮率だが低速）|
|`-c`|結果をファイルではなく標準出力へ出力する（主にパイプで別コマンドに渡す際に使用）|
|`-d`|ファイルを展開する（unxzのデフォルト）|
|`-f`|すでに圧縮ファイルが存在しても上書きする|
|`-k`|圧縮後にもとのファイルを削除しない（圧縮前／伸張前のファイルを残す）|
|`-t`|圧縮ファイルをテストする|
|`-l`|圧縮ファイル内のファイル一覧を表示する|

### アーカイブの作成と展開

ディレクトリを圧縮する場合は、予め複数のファイルを一つのファイルにまとめたアーカイブを作成し、そのアーカイブファイルを圧縮します。アーカイブの管理には`tar`コマンドを使います。

#### Syntaxとオプション

```
$ tar [option] [ファイル名] [ディレクトリ]
```

|オプション|説明|
|---|---|
|`-c`|アーカイブを作成する|
|`-x`|アーカイブを展開する|
|`-t`|アーカイブ内をリスト表示する|
|`-f ファイル名`|アーカイブファイルを指定する|
|`-z`|gzipを利用して圧縮/展開する|
|`-j`|bzip2を利用して圧縮/展開する|
|`-J`|xzを利用して圧縮/展開する|
|`-v`|処理したファイル名などの詳細情報を表示する|
|`-r`|アーカイブの最後にファイルを追加する|
|`-C`|ディレクトリ処理を開始する前に指定したディレクトリに移動する|

圧縮アーカイブの作成をします。

```
$ tar -zcf test_gzip.tar.gz data-science-at-the-command-line/
```

圧縮ファイルの中身のファイル一覧を表示したい場合は

```
$ tar -ztf test_gzip.tar.gz
```

## 3. Converting Microsoft Excel Spreadsheets
### 前提条件：`csvkit`のインストール

最新版は`1.0.5`だが、Python経由のインストール環境を整備するのがめんどくさいので`apt package manager`経由でインストールする。

```
$ apt-cache policy csvkit
csvkit:
  Installed: 1.0.2-2
  Candidate: 1.0.2-2
  Version table:
 *** 1.0.2-2 500
        500 http://jp.archive.ubuntu.com/ubuntu focal/universe amd64 Packages
        500 http://jp.archive.ubuntu.com/ubuntu focal/universe i386 Packages
        100 /var/lib/dpkg/status
$ sudo apt install csvkit
```

### xlsxファイルをcsvファイルに変換する

`imdb-250.xlsx`を`imdb-250.csv`に変換します。

```bash
$ cd
$ in2csv /home/dst/data-science-at-the-command-line/book/1e/data/ch03/data/imdb-250.xlsx > imdb-250.csv
$ head imdb-250.csv | xsv table
Title,title trim,Year,Rank,Rank (desc),Rating,New in 2011 from 2010?,2010 rank,Rank Difference,j
Sherlock Jr. (1924),SherlockJr.(1924),1924,221,30,8,True,,,
The Passion of Joan of Arc (1928),ThePassionofJoanofArc(1928),1928,212,39,8,True,,,
His Girl Friday (1940),HisGirlFriday(1940),1940,250,1,8,True,,,
Tokyo Story (1953),TokyoStory(1953),1953,248,3,8,True,,,
The Man Who Shot Liberty Valance (1962),TheManWhoShotLibertyValance(1962),1962,237,14,8,True,,,
Persona (1966),Persona(1966),1966,200,51,8,True,,,
Stalker (1979),Stalker(1979),1979,243,8,8,True,,,
Fanny and Alexander (1982),FannyandAlexander(1982),1982,210,41,8,True,,,
Beauty and the Beast (1991),BeautyandtheBeast(1991),1991,249,2,8,True,,,
```

カラムを絞って表示させます。

```
$ head imdb-250.csv | xsv select Title,Year,Rating | csvlook
| Title                                   |  Year | Rating |
| --------------------------------------- | ----- | ------ |
| Sherlock Jr. (1924)                     | 1,924 |      8 |
| The Passion of Joan of Arc (1928)       | 1,928 |      8 |
| His Girl Friday (1940)                  | 1,940 |      8 |
| Tokyo Story (1953)                      | 1,953 |      8 |
| The Man Who Shot Liberty Valance (1962) | 1,962 |      8 |
| Persona (1966)                          | 1,966 |      8 |
| Stalker (1979)                          | 1,979 |      8 |
| Fanny and Alexander (1982)              | 1,982 |      8 |
| Beauty and the Beast (1991)             | 1,991 |      8 |

```

## 4. Querying Relational Databases

relational databasesをコマンドラインから簡単に操作可能とすつ関数の一つに`sql2csv`があります。これはPython SQLAlchemy packageをベースとしており、MySQL, Oracle, PostgreSQL, SQLite, Microsoft SQL Server, and Sybaseといった様々なデータベースに対応することができます。一例は以下：

```
$ sql2csv --db 'sqlite:////home/dst/data-science-at-the-command-line/book/1e/data/ch03/data/iris.db' --query 'SELECT * FROM iris WHERE sepal_length > 7.5'
```

### sql2csvのSyntax

```
usage: sql2csv [-h] [-v] [-l] [-V] [--db CONNECTION_STRING] [--query QUERY]
               [-e ENCODING] [-H]
               [FILE]

Execute an SQL query on a database and output the result to a CSV file.

positional arguments:
  FILE                  The file to use as SQL query. If both FILE and QUERY
                        are omitted, query will be read from STDIN.

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Print detailed tracebacks when errors occur.
  -l, --linenumbers     Insert a column of line numbers at the front of the
                        output. Useful when piping to grep or as a simple
                        primary key.
  -V, --version         Display version information and exit.
  --db CONNECTION_STRING
                        An sqlalchemy connection string to connect to a
                        database.
  --query QUERY         The SQL query to execute. If specified, it overrides
                        FILE and STDIN.
  -e ENCODING, --encoding ENCODING
                        Specify the encoding of the input query file.
  -H, --no-header-row   Do not output column names.
```

### Examples

DBからQUERYでデータを呼び出し、csvに出力する。

```bash
$ sql2csv --db 'sqlite:////home/dst/data-science-at-the-command-line/book/1e/data/ch03/data/iris.db' --query 'SELECT * FROM iris WHERE sepal_length > 7.5' >> test.csv
$ cat test.csv 
sepal_length,sepal_width,petal_length,petal_width,species
7.6,3.0,6.6,2.1,Iris-virginica
7.7,3.8,6.7,2.2,Iris-virginica
7.7,2.6,6.9,2.3,Iris-virginica
7.7,2.8,6.7,2.0,Iris-virginica
7.9,3.8,6.4,2.0,Iris-virginica
7.7,3.0,6.1,2.3,Iris-virginica
```

## 5. Downloading from the Internet

インターネット経由でデータを取得する際、`curl`コマンドを使うケースが多いです。例えば、

```
$ curl -s http://www.gutenberg.org/files/76/76-0.txt | head -n 10

The Project Gutenberg EBook of Adventures of Huckleberry Finn, Complete
by Mark Twain (Samuel Clemens)

This eBook is for the use of anyone anywhere at no cost and with almost
no restrictions whatsoever. You may copy it, give it away or re-use
it under the terms of the Project Gutenberg License included with this
eBook or online at www.gutenberg.net
```

### curlコマンドの主なオプション

|短いオプション| 	長いオプション| 	意味|
|---|---|---|
|-O| 	--remote-name |	転送元と同じ名前で保存する（「-O」または「-o」を指定しない場合は標準出力）|
|-o| 	--output |ファイル名 	保存するファイル名（「-O」または「-o」を指定しない場合は標準出力）|
|	|--create-dirs |	「-o」でディレクトリを指定した際、そのディレクトリがない場合は作成する|
|-#| 	--progress-bar |	進行状況を「#」文字で表示する|
|-f| 	--fail |	失敗してもエラーメッセージを表示しない|
|-s| 	--silent |	実行中のメッセージを表示しない|
|-4| 	--ipv4 |	IPv4だけを使う|
|-6| 	--ipv6 |	IPv6だけを使う|
|-A| 	--user-agent |"Webブラウザ" 	実行時のWebブラウザ名を指定する|
|-e| 	--referer |URL |	リンク元のURLを指定する|
|-b| 	--cookie |"名前=値" 	実行時のクッキーを指定する|
|	--|anyauth |	複数の認証方法を試す（個別に「--basic」「--digest」「--ntlm」「--negotiate」を指定可）|
|-C| 	--continue-at |バイト数 	転送の続きから行う際に、何バイト目から再開するか指定する（「-C -」で自動計算）|
|-d| 	--data |"データ" 	データをPOSTしたのと同じように送る|
|-F| 	--form |"名前=値" 	指定した内容をフォームから入力したのと同じように送る|
|	|--data-urlencode |"データ" 	データをURLエンコードして送る|

### 実行進捗状況の表示と`-s`

curlは実行状況と完了予定時間をデフォルトで表示します。

```
$ curl http://www.gutenberg.org/files/76/76-0.txt | head -n 10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0﻿
The Project Gutenberg EBook of Adventures of Huckleberry Finn, Complete
by Mark Twain (Samuel Clemens)

This eBook is for the use of anyone anywhere at no cost and with almost
no restrictions whatsoever. You may copy it, give it away or re-use
it under the terms of the Project Gutenberg License included with this
eBook or online at www.gutenberg.org

Title: Adventures of Huckleberry Finn, Complete
  6  601k    6 41870    0     0  30968      0  0:00:19  0:00:01  0:00:18 30968
curl: (23) Failed writing body (2554 != 16384)
```

### curl出力結果をファイルに保存する

リダイレクトを用いる場合とオプションで指定する場合の２つがあります。リダイレクトを用いる場合は、

```
$ curl -s http://www.gutenberg.org/files/76/76-0.txt > finn.txt
$ less finn.txt
The Project Gutenberg EBook of Adventures of Huckleberry Finn, Complete
by Mark Twain (Samuel Clemens)

This eBook is for the use of anyone anywhere at no cost and with almost
no restrictions whatsoever. You may copy it, give it away or re-use
it under the terms of the Project Gutenberg License included with this
eBook or online at www.gutenberg.org

Title: Adventures of Huckleberry Finn, Complete

Author: Mark Twain (Samuel Clemens)

Release Date: August 20, 2006 [EBook #76]
Last Updated: February 23, 2018
Language: English
(略)
```

オプションで指定する場合でかつディクトリ作成を同時に実行したい場合は以下、

```
$ curl -s http://www.gutenberg.org/files/76/76-0.txt -o /data/finn.txt --create-dirs 
```

### curlコマンドを用いたレクチャーノートのインストール

wgetで実行する方法もありますが今回はcurlを用います。[MITのEconometrics course 14-382](https://ocw.mit.edu/courses/economics/14-382-econometrics-spring-2017/lecture-notes/)のpdf形式のレクチャーノートをダウンロードします。

レクチャーノートのURLは

```
https://ocw.mit.edu/courses/economics/14-382-econometrics-spring-2017/lecture-notes/MIT14_382S17_lec<数字>.pdf
```

という形式になっています。これを`lecturenote_<数字>.pdf`という形式でダウンロードする場合は以下のようなコマンドになります。

```
$ curl -o lecturenote_#1.pdf "https://ocw.mit.edu/courses/economics/14-382-econometrics-spring-2017/lecture-notes/MIT14_382S17_lec[1-20].pdf"
$ find ./*.pdf -size -40k | xargs rm
```

最後の`find ./*.pdf -size -40k | xargs rm`はゴミファイルを削除するためのコマンドです。

## APPENDIX: パイプ

Linuxでは、パイプ, `|`を用いることで、コマンドの出力先を別コマンドへつなぐことができます。

```
% コマンド1 | コマンド2
```

一例として,ファイルの数を数えたいときは

```
% ls | wc -l
```

## APPENDIX: リダイレクト

コマンドの実行結果をファイルに保存したいときに用いるのがリダイレクトです。

|書式|説明|
|---|---|
|`コマンドA > コマンドB`|コマンドAの実行結果をコマンドBで処理する|
|`コマンド > ファイル`|コマンドの実行結果をファイルに保存する|
|`コマンド >> ファイル`|コマンドの実行結果をファイルに追記する（ファイル末尾に追加する）|
|`コマンド &> ファイル`|コマンドの実行結果とエラー表示をファイルに保存する|
