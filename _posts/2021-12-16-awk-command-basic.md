---
layout: post
title: "Linux commandの復習: awkコマンド"
subtitle: "awkコマンドの基本 & awkコマンドを用いた前処理の紹介"
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


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Dependencyと設定](#dependency%E3%81%A8%E8%A8%AD%E5%AE%9A)
- [awkコマンド](#awk%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [ウォームアップ問題](#%E3%82%A6%E3%82%A9%E3%83%BC%E3%83%A0%E3%82%A2%E3%83%83%E3%83%97%E5%95%8F%E9%A1%8C)
    - [(1) 1~5までのsequenceのうち偶数のみを抽出する](#1-15%E3%81%BE%E3%81%A7%E3%81%AEsequence%E3%81%AE%E3%81%86%E3%81%A1%E5%81%B6%E6%95%B0%E3%81%AE%E3%81%BF%E3%82%92%E6%8A%BD%E5%87%BA%E3%81%99%E3%82%8B)
    - [(2) 1~5までのsequenceのうち偶数のみを抽出する & 抽出結果に「偶数」という文字列を付与する](#2-15%E3%81%BE%E3%81%A7%E3%81%AEsequence%E3%81%AE%E3%81%86%E3%81%A1%E5%81%B6%E6%95%B0%E3%81%AE%E3%81%BF%E3%82%92%E6%8A%BD%E5%87%BA%E3%81%99%E3%82%8B--%E6%8A%BD%E5%87%BA%E7%B5%90%E6%9E%9C%E3%81%AB%E5%81%B6%E6%95%B0%E3%81%A8%E3%81%84%E3%81%86%E6%96%87%E5%AD%97%E5%88%97%E3%82%92%E4%BB%98%E4%B8%8E%E3%81%99%E3%82%8B)
    - [(3) 1~5までのsequenceのうち、数値に応じて奇数偶数という文字列を付与する](#3-15%E3%81%BE%E3%81%A7%E3%81%AEsequence%E3%81%AE%E3%81%86%E3%81%A1%E6%95%B0%E5%80%A4%E3%81%AB%E5%BF%9C%E3%81%98%E3%81%A6%E5%A5%87%E6%95%B0%E5%81%B6%E6%95%B0%E3%81%A8%E3%81%84%E3%81%86%E6%96%87%E5%AD%97%E5%88%97%E3%82%92%E4%BB%98%E4%B8%8E%E3%81%99%E3%82%8B)
    - [(4) 1~5までのsequenceのうち、数値に応じて奇数偶数という文字列を付与する](#4-15%E3%81%BE%E3%81%A7%E3%81%AEsequence%E3%81%AE%E3%81%86%E3%81%A1%E6%95%B0%E5%80%A4%E3%81%AB%E5%BF%9C%E3%81%98%E3%81%A6%E5%A5%87%E6%95%B0%E5%81%B6%E6%95%B0%E3%81%A8%E3%81%84%E3%81%86%E6%96%87%E5%AD%97%E5%88%97%E3%82%92%E4%BB%98%E4%B8%8E%E3%81%99%E3%82%8B)
    - [(5) awkコマンドを用いてディスクの空き領域を表示する](#5-awk%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E3%81%AE%E7%A9%BA%E3%81%8D%E9%A0%98%E5%9F%9F%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B)
    - [(6) CSVファイルの各フィールドを文字列結合して複数ディレクトリを作成する](#6-csv%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E5%90%84%E3%83%95%E3%82%A3%E3%83%BC%E3%83%AB%E3%83%89%E3%82%92%E6%96%87%E5%AD%97%E5%88%97%E7%B5%90%E5%90%88%E3%81%97%E3%81%A6%E8%A4%87%E6%95%B0%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B)
- [awkコマンドを用いたデータ整形](#awk%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%87%E3%83%BC%E3%82%BF%E6%95%B4%E5%BD%A2)
  - [awkの組み込み変数](#awk%E3%81%AE%E7%B5%84%E3%81%BF%E8%BE%BC%E3%81%BF%E5%A4%89%E6%95%B0)
  - [指定した行を出力する](#%E6%8C%87%E5%AE%9A%E3%81%97%E3%81%9F%E8%A1%8C%E3%82%92%E5%87%BA%E5%8A%9B%E3%81%99%E3%82%8B)
  - [RowのFilter](#row%E3%81%AEfilter)
  - [Columnのフィルター](#column%E3%81%AE%E3%83%95%E3%82%A3%E3%83%AB%E3%82%BF%E3%83%BC)
    - [特定のカラムのみコンソールに出力したい場合](#%E7%89%B9%E5%AE%9A%E3%81%AE%E3%82%AB%E3%83%A9%E3%83%A0%E3%81%AE%E3%81%BF%E3%82%B3%E3%83%B3%E3%82%BD%E3%83%BC%E3%83%AB%E3%81%AB%E5%87%BA%E5%8A%9B%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
    - [カラム別に条件をつけて行を抽出する](#%E3%82%AB%E3%83%A9%E3%83%A0%E5%88%A5%E3%81%AB%E6%9D%A1%E4%BB%B6%E3%82%92%E3%81%A4%E3%81%91%E3%81%A6%E8%A1%8C%E3%82%92%E6%8A%BD%E5%87%BA%E3%81%99%E3%82%8B)
    - [スタンド使用者の名前がアルファベットを含む行のみ抽出する](#%E3%82%B9%E3%82%BF%E3%83%B3%E3%83%89%E4%BD%BF%E7%94%A8%E8%80%85%E3%81%AE%E5%90%8D%E5%89%8D%E3%81%8C%E3%82%A2%E3%83%AB%E3%83%95%E3%82%A1%E3%83%99%E3%83%83%E3%83%88%E3%82%92%E5%90%AB%E3%82%80%E8%A1%8C%E3%81%AE%E3%81%BF%E6%8A%BD%E5%87%BA%E3%81%99%E3%82%8B)
  - [Delimiterを変更して出力したい場合](#delimiter%E3%82%92%E5%A4%89%E6%9B%B4%E3%81%97%E3%81%A6%E5%87%BA%E5%8A%9B%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [複数のcsv fileを結合したい場合](#%E8%A4%87%E6%95%B0%E3%81%AEcsv-file%E3%82%92%E7%B5%90%E5%90%88%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
    - [IDでsortした形で結合したい場合](#id%E3%81%A7sort%E3%81%97%E3%81%9F%E5%BD%A2%E3%81%A7%E7%B5%90%E5%90%88%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [特定のフィールドの部分文字列を抽出したい場合：`substr()`](#%E7%89%B9%E5%AE%9A%E3%81%AE%E3%83%95%E3%82%A3%E3%83%BC%E3%83%AB%E3%83%89%E3%81%AE%E9%83%A8%E5%88%86%E6%96%87%E5%AD%97%E5%88%97%E3%82%92%E6%8A%BD%E5%87%BA%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88substr)
- [FPATを用いたフィールド内にカンマへの対応](#fpat%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%95%E3%82%A3%E3%83%BC%E3%83%AB%E3%83%89%E5%86%85%E3%81%AB%E3%82%AB%E3%83%B3%E3%83%9E%E3%81%B8%E3%81%AE%E5%AF%BE%E5%BF%9C)
  - [組込変数FPATの導入](#%E7%B5%84%E8%BE%BC%E5%A4%89%E6%95%B0fpat%E3%81%AE%E5%B0%8E%E5%85%A5)
- [Markdownファイルの編集に役に立つawkコマンドの紹介](#markdown%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E7%B7%A8%E9%9B%86%E3%81%AB%E5%BD%B9%E3%81%AB%E7%AB%8B%E3%81%A4awk%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [順序付きリストの整形](#%E9%A0%86%E5%BA%8F%E4%BB%98%E3%81%8D%E3%83%AA%E3%82%B9%E3%83%88%E3%81%AE%E6%95%B4%E5%BD%A2)
- [Reference](#reference)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Dependencyと設定

今回は `gawk` ベースで紹介します. `gawk`が入っていない場合は以下のラインでインストール:

```zsh
% sudo apt install gawk
```

インストールすると `awk` コマンドは `gawk` を参照しているはずです. その確認方法は、

```zsh
 % sudo update-alternatives --display awk
awk - auto mode
  link best version is /usr/bin/gawk
  link currently points to /usr/bin/gawk
  link awk is /usr/bin/awk
  slave awk.1.gz is /usr/share/man/man1/awk.1.gz
  slave nawk is /usr/bin/nawk
  slave nawk.1.gz is /usr/share/man/man1/nawk.1.gz
/usr/bin/gawk - priority 10
  slave awk.1.gz: /usr/share/man/man1/gawk.1.gz
  slave nawk: /usr/bin/gawk
  slave nawk.1.gz: /usr/share/man/man1/gawk.1.gz
/usr/bin/mawk - priority 5
  slave awk.1.gz: /usr/share/man/man1/mawk.1.gz
  slave nawk: /usr/bin/mawk
  slave nawk.1.gz: /usr/share/man/man1/mawk.1.gz
```


## awkコマンド

- 簡単な行ベースのテキストファイルを処理するコマンド
- 演算機能もあり、プログラミング言語としても使用されています
- イメージとしては `grep` にプログラム機能をつけたコマンド

> Syntax

```zsh
% awk [option] [command] [file path]
```

> Option一覧

|短いオプション|長いオプション|意味|
|---|---|---|
|`-f program-file`|`--file program-file`|awk への第 1 引数を用いるかわりに、<br>AWK プログラムをファイル program-file から読み込む|
|`-F fs`|`--field-separator fs`|入力フィールドセパレータ (変数 FS の値)をfsする<br> field seperatorのdefaultはwhite space|
|`-v var=val`|`--assign var=val`|プログラムを実行する前に、変数 var に値 val を設定|

> awkで使用できる主な組み込み変数

|変数名|意味|
|---|---|
|ARGC |引数の個数|
|ARGV |引数（配列）|
|ENVIRON |環境変数を収めた連想配列。例えば環境変数LANGならばENVIRON["LANG"]と参照できる|
|FILENAME |現在処理しているファイルの名前|
|FNR |現在処理しているファイルのレコード番号|
|FS |フィールドの区切り文字（-Fオプションで変更可能、デフォルトはスペース）|
|NR |現在処理しているレコード番号（行番号）|
|OFS |出力時のフィールドの区切り（デフォルトは空白）|
|ORS |出力時のレコードの区切り（デフォルトは改行）|
|RS |レコードの区切り（デフォルトは改行）|

### ウォームアップ問題

#### (1) 1~5までのsequenceのうち偶数のみを抽出する

> 解答1

```zsh
% seq 5 | awk '/[24]/'
2
4
```

- `awk /正規表現/`で`grep 正規表現`と同じ挙動になります 

> 解答2

```zsh
% seq 5 | awk '$1%2==0'
2
4
```

- `$1`は読み込んだ行の一列目を意味します

#### (2) 1~5までのsequenceのうち偶数のみを抽出する & 抽出結果に「偶数」という文字列を付与する

> 解答

```zsh
% seq 5 | awk '$1%2==0{printf("%s, 偶数\n", $1)}'
2, 偶数
4, 偶数
```

> 別解

```zsh
% seq 5 | awk '$1%2==0{print($1, "偶数")}'
```

- 出力したい文字列はダブルクォートで囲む

#### (3) 1~5までのsequenceのうち、数値に応じて奇数偶数という文字列を付与する

> 解答

```zsh
% seq 5 | awk '$1%2==0{print($1, "偶数")}$1%2{print($1, "奇数")}'
1 奇数
2 偶数
3 奇数
4 偶数
5 奇数
```

> 別解

```zsh
% seq 5 | awk '{a = ""; $1%2 ? a = "奇数" :a = "偶数"; print($1, a)}'
1 奇数
2 偶数
3 奇数
4 偶数
5 奇数
```

- `CONDITION ? 真の場合に返す値 : 偽の場合に返す値`という三項演算子を用いて記述しています



#### (4) 1~5までのsequenceのうち、数値に応じて奇数偶数という文字列を付与する

```zsh
% seq 5 | awk 'BEGIN{a=0}$1%2==0{print($1, "偶数")}$1%2{print($1, "奇数")}{a+=$1}END{print("合計", a)}'
```

- `BEGIN`, `END`は、それぞれ「awkが１行目の処理を始める前」「awkが最終行の処理を終えた後」という状況にマッチします.
- 上記は、最初に変数 a を0に初期化して、行の処理のたびに+1のincrementを実施し、最後にその時のaの状態を出力するという処理です.


#### (5) awkコマンドを用いてディスクの空き領域を表示する

> 解答

```zsh
% df -m | awk 'NR==1 {print "1G-Blocks", "GB-"$4}; NR>=2 {x+=$2/(2**10); y+=$4/(2**10)}; END {print x, y}'
1G-Blocks GB-Available
541.072 458.293
```

- 「df」を実行すると、ディスクの空き領域が表示されます
- `-m` optionは指定したサイズの倍数で表示するオプション（MB単位）


> 別解

```zsh
% df -h --total  
```

#### (6) CSVファイルの各フィールドを文字列結合して複数ディレクトリを作成する

```zsh
%ls
test.csv
% cat test.csv
store_name,store_code
a,100
b,101
c,101
```

上記のように`test.csv`の2つのfieldに`store_name,store_code`がカレントワーキングディレクトリに格納されているとします.
この２つのfieldを組合せて、`<store_name>_<store_code>`というdirectoryをカレントワーキングディレクトリ以下に作成したいとします.
この場合のshell scriptは以下.

```zsh
% awk -F "," 'NR>1{print $1"_"$2}' test.csv| awk '{system("mkdir "$1)}'
% ls
a_100/  b_101/  c_101/  test.csv
```

> 解説

`awk -F "," 'NR>1{print $1"_"$2}' test.csv`と`awk '{system("mkdir "$1)}'`の２つのパートに分けて考えます.
前者はCSVファイルをカンマセパレートで各カラムをREADし、それらを文字列結合し出力しています. その後、その出力結果を後者に渡して`system()`でLinuxコマンドを`awk`の中で呼び、
`mkdir`でディレクトリを作成しています.

## awkコマンドを用いたデータ整形

> このセクションで用いるデータ

- ソース：[スタンドパラメータ - 甚平 - ジョジョの奇妙な冒険](http://jinbei.s58.xrea.com/data_ability.htm)
- ファイル名: `example.csv`
- クリップボードにコピーした後、`xclip -out -selection clipboard > example.csv`で簡単に複製できます

```csv
ID,stand_name,user_name,power,speed,range,duration,agility,growth
001,スタープラチナ,空条承太郎,A,A,C,A,A,A
002,マジシャンズレッド,モハメド･アヴドゥル,B,B,C,B,C,D
003,ハーミットパープル,ジョセフ･ジョースター,D,C,D,A,D,E
004,ハイエロファントグリーン,花京院典明,C,B,A,B,C,D
005,タワー･オブ･グレー,グレーフライ,E,A,A,C,E,E
006,シルバーチャリオッツ,J･P･ポルナレフ,C,A,C,B,B,C
007,ダークブルームーン,キャプテン･テニール,C,C,C,B,C,D
008,力・ストレングス,フォーエバー,B,D,D,A,E,E
009,エボニーデビル,呪いのデーボ,D,D,A,B,D,B
010,イエローテンパランス,ラバーソール,D,C,E,A,E,D
011,ハングドマン,J･ガイル,C,A,A,B,D,D
012,エンペラー,ホル･ホース,B,B,B,C,E,E
013,エンプレス,ネーナ,C,E,A,A,D,D
014,ホウィール･オブ･フォーチュン,ズィー･ズィー,B,D,D,A,E,D
015,ジャスティス,エンヤ婆,D,E,A,A,E,E
016,ラバーズ,鋼入りのダン,E,D,A,A,D,E
017,サン,アラビア･ファッツ,B,E,A,A,E,E
018,デス･サーティーン,マニッシュ･ボーイ,C,C,E,B,D,B
019,ジャッジメント,カメオ,B,B,C,B,D,D
020,ハイプリエステス,ミドラー,C,B,A,A,D,D
021,ザ･フール,イギー,B,C,D,C,D,C
022,ゲブ神,ンドゥール,C,B,A,B,D,D
023,トト神,ボインゴ,E,E,E,A,E,E
024,クヌム神,オインゴ,E,E,E,A,E,E
025,アヌビス神,キャラバン･サライ,B,B,E,A,E,C
026,バステト女神,マライア,E,E,B,A,E,E
027,セト神,アレッシー,D,D,E,C,D,D
028,オシリス神,ダニエル･J･ダービー,E,D,D,C,D,D
029,ホルス神,ペット･ショップ,B,B,D,C,E,C
030,アトゥム神,テレンス･T･ダービー,D,C,D,B,D,D
031,ティナー･サックス,ケニー･G,E,E,D,A,E,E
032,クリーム,ヴァニラ･アイス,B,B,D,C,C,D
033,ザ･ワールド,DIO,A,A,C,A,B,B
```

### awkの組み込み変数

|変数|説明|
|---|---|
|NR|the current number of the input records|
|NF| the number of fields of the current record|
|FS| The input field separator<br>defaultはwhite space<br>FSで区切り文字を設定できる|
|RS| The input record separator<br>defaultは改行|
|OFS| The output field separator<br>print出力時のfieldの区切り文字を指定|
|ORS| The output record separator<br>print出力時のrecordの区切り文字|
|FPAT| The input field pattern<br>どのようなパターンをフィールドとして認識するかを定義することができる|


> 例題 (1) 各レコードのfieldの数を出力する

```zsh
% awk -F "," '{print NF, $0}' example.csv | head -n 5
9 ID,stand_name,user_name,power,speed,range,duration,agility,growth
9 001,スタープラチナ,空条承太郎,A,A,C,A,A,A
9 002,マジシャンズレッド,モハメド･アヴドゥル,B,B,C,B,C,D
9 003,ハーミットパープル,ジョセフ･ジョースター,D,C,D,A,D,E
9 004,ハイエロファントグリーン,花京院典明,C,B,A,B,C,D
```

> 例題 (2) ファイルの行数を出力する

```zsh
% awk 'END {print NR}' example.csv
34
```

or, シンプルに`wc`コマンドを用いて改行数をカウントして

```zsh
% cat example.csv | wc -l
33
```


### 指定した行を出力する

> 先頭５行を表示したい場合

任意の先頭の行数を出力したい場合は、一般的には`head`コマンドを用います.

```zsh
% head -n 5 example.csv
ID,stand_name,user_name,power,speed,range,duration,agility,growth
001,スタープラチナ,空条承太郎,A,A,C,A,A,A
002,マジシャンズレッド,モハメド･アヴドゥル,B,B,C,B,C,D
003,ハーミットパープル,ジョセフ･ジョースター,D,C,D,A,D,E
004,ハイエロファントグリーン,花京院典明,C,B,A,B,C,D
```

`awk`コマンドを用いて表示する場合は

```zsh
% awk 'NR<=5 {print}' example.csv
```

> ６行目から10行目を表示したい場合

```zsh
% awk 'NR<=10 && NR>=6 {print}' example.csv
005,タワー･オブ･グレー,グレーフライ,E,A,A,C,E,E
006,シルバーチャリオッツ,J･P･ポルナレフ,C,A,C,B,B,C
007,ダークブルームーン,キャプテン･テニール,C,C,C,B,C,D
008,力・ストレングス,フォーエバー,B,D,D,A,E,E
009,エボニーデビル,呪いのデーボ,D,D,A,B,D,B
```

headerを含めたい場合は

```zsh
% awk '(NR<=10 && NR>=6)||(NR==1) {print}' example.csv
ID,stand_name,user_name,power,speed,range,duration,agility,growth
005,タワー･オブ･グレー,グレーフライ,E,A,A,C,E,E
006,シルバーチャリオッツ,J･P･ポルナレフ,C,A,C,B,B,C
007,ダークブルームーン,キャプテン･テニール,C,C,C,B,C,D
008,力・ストレングス,フォーエバー,B,D,D,A,E,E
009,エボニーデビル,呪いのデーボ,D,D,A,B,D,B
```

### RowのFilter

> 承太郎を含む行を抽出する場合

```zsh
% awk '/承太郎/ {print}' example.csv
001,スタープラチナ,空条承太郎,A,A,C,A,A,A
```

headerを含めたい場合は、

```zsh
% awk '/承太郎/||(NR==1) {print}' example.csv
ID,stand_name,user_name,power,speed,range,duration,agility,growth
001,スタープラチナ,空条承太郎,A,A,C,A,A,A
```

> 承太郎 or Dioを含む行を抽出する場合

```zsh
% awk '/承太郎|DIO/ {print}' example.csv
001,スタープラチナ,空条承太郎,A,A,C,A,A,A
033,ザ･ワールド,DIO,A,A,C,A,B,B
```

> Jという文字列を含む行のうちポルという文字列があとに続く行を抽出

Jという文字列を含む行は３つあります

```zsh
% awk '/J/ {print}' example.csv 
006,シルバーチャリオッツ,J･P･ポルナレフ,C,A,C,B,B,C
011,ハングドマン,J･ガイル,C,A,A,B,D,D
028,オシリス神,ダニエル･J･ダービー,E,D,D,C,D,D
```

このうち、「ポル」という文字列が後に出現する行を抽出したい場合は

```zsh
% awk '/J.*ポル/ {print}' example.csv 
006,シルバーチャリオッツ,J･P･ポルナレフ,C,A,C,B,B,C
```

または、

```zsh
% awk '/J.{1,}ポル/ {print}' example.csv
006,シルバーチャリオッツ,J･P･ポルナレフ,C,A,C,B,B,C
```

> 「神」という文字を含む行を除外して出力したい場合

スターダストクルセイダースは「オシリス神」など「神」を名前に含むスタンドが数体出現します. それらを除くスタンダ一覧を表示したいとします

```zsh
% awk '!/神/ {print}' example.csv
```

### Columnのフィルター

#### 特定のカラムのみコンソールに出力したい場合

- シンボル`$`と数字の組合せを用いることで特定のカラムを指定することができます
- field seperatorのdefaultはwhite spaceなので、csv fileを対象に操作するときは `FS = ","`の指定をします
- スタンドと使用者の組をここでは抽出したいとします

> 解答

```zsh
% awk -F ',' '{print $2, $3}' example.csv
```

> 別解

```zsh
% awk '{print $2, $3}' FS=',' example.csv
```

or 

```zsh
% awk 'BEGIN{FS=","} {print $2, $3}' example.csv
```

#### カラム別に条件をつけて行を抽出する

- power, speed fieldがAのスタンドのみを抽出したいとします
- header行も出力したいとします

```zsh
% awk -F ',' 'NR==1 || ($4=="A" && $5 == "A") {print $2, $3}' example.csv
stand_name user_name
スタープラチナ 空条承太郎
ザ･ワールド DIO
```

IDが５以下の行のみを抽出したい場合は

```zsh
% awk -F"," '$1<5{print $0}' example.csv
001,スタープラチナ,空条承太郎,A,A,C,A,A,A
002,マジシャンズレッド,モハメド･アヴドゥル,B,B,C,B,C,D
003,ハーミットパープル,ジョセフ･ジョースター,D,C,D,A,D,E
004,ハイエロファントグリーン,花京院典明,C,B,A,B,C,D
```

#### スタンド使用者の名前がアルファベットを含む行のみ抽出する

```zsh
% awk -F"," 'NR==1 || $3~/[A-Za-z]/{print $0}' example.csv
ID,stand_name,user_name,power,speed,range,duration,agility,growth
006,シルバーチャリオッツ,J･P･ポルナレフ,C,A,C,B,B,C
011,ハングドマン,J･ガイル,C,A,A,B,D,D
028,オシリス神,ダニエル･J･ダービー,E,D,D,C,D,D
030,アトゥム神,テレンス･T･ダービー,D,C,D,B,D,D
031,ティナー･サックス,ケニー･G,E,E,D,A,E,E
033,ザ･ワールド,DIO,A,A,C,A,B,B
```

もし「スタンド使用者の名前がアルファベットを含まない行のみ抽出」したい場合は

```zsh
% awk -F"," 'NR==1 || $3!~/[A-Za-z]/{print $0}' example.csv
```

### Delimiterを変更して出力したい場合

- csvファイルをtsvとして出力します

> 解答

```zsh
% awk 'BEGIN{FS=",";OFS="\t"} {for(i=1;i<=NF-1;i++) printf $i" "; print ""}' example.csv > example.tsv
% head -n 5 example.tsv 
ID stand_name user_name power speed range duration agility 
001 スタープラチナ 空条承太郎 A A C A A 
002 マジシャンズレッド モハメド･アヴドゥル B B C B C 
003 ハーミットパープル ジョセフ･ジョースター D C D A D 
004 ハイエロファントグリーン 花京院典明 C B A B C 
```

> 別解: gsub

```zsh
% awk 'gsub(",","\t")' example.csv
```

-  gsub functionはglobal substitutionの略

> 別解: sed version

```zsh
% sed 's/,/\t/g' example.csv > example.tsv
```

- この時、`-i` optionはつけないこと

### 複数のcsv fileを結合したい場合

- `example_2.csv`という以下のファイルを準備します. このファイルと`example.csv`のファイルを結合し、新たな`merged_with_header.csv`を作りたいとします.

> Data

```csv
ID,stand_name,user_name,power,speed,range,duration,agility,growth
034,クレイジー･ダイヤモンド,東方仗助,A,A,D,B,B,C
035,アクア･ネックレス,片桐安十朗,C,C,A,A,C,E
036,ザ･ハンド,虹村億泰,B,B,D,C,C,C
037,バッド･カンパニー,虹村形兆,B,B,C,B,C,C
038,レッド･ホット･チリ･ペッパー,音石明,A,A,A,A,C,A
039,錠前,小林玉美,E,E,A,A,E,E
040,エコーズACT1,広瀬康一,E,E,B,B,C,A
041,サーフィス,間田敏和,B,B,C,B,C,C
042,ラブ･デラックス,山岸由花子,B,B,C,A,E,B
043,エコーズACT2,広瀬康一,C,D,B,B,C,A
044,パール･ジャム,トニオ･トラサルディー,E,C,B,A,E,C
045,アクトン･ベイビー,静･ジョースター,E,E,なし,A,E,A
046,ヘブンズ･ドアー,岸辺露伴,D,B,B,B,C,A
047,ラット,虫喰い＆虫喰いでない,B,C,D,B,E,C
048,ハーヴェスト,矢安宮重清,E,B,A,A,E,C
049,キラークイーン,吉良吉影,A,B,D,B,B,A
050,シンデレラ,辻彩,D,C,C,C,A,C
051,シアーハートアタック,吉良吉影,A,C,A,A,E,A
052,エコーズACT3,広瀬康一,B,B,C,B,C,A
053,アトム･ハート･ファーザー,吉良吉廣,E,E,なし,A,E,E
054,ボーイ･Ⅱ･マン,大柳賢,C,B,C,A,C,C
055,アース･ウインド･アンド･ファイヤー,支倉未起隆,C,C,なし,A,C,C
056,ハイウェイ･スター,墳上裕也,C,B,A,A,E,C
057,ストレイ･キャット,猫草,B,E,なし,A,E,C
058,スーパー･フライ,鋼田一豊大,E,E,なし,A,E,E
059,エニグマ,宮本輝之輔,E,E,C,A,C,C
060,チープ･トリック,乙雅三,E,E,E,A,E,E
061,キラークイーン・バイツァ･ダスト,吉良吉影,B,B,A,A,D,A
```

> 解答

```zsh
% awk '(NR == 1) || (FNR > 1)' *.csv > merged_with_header.csv
```

- 必ずしもIDはsortされていないことに注意
- `NR == 1` は最初に読み込んだファイルの先頭行という意味
- FNRは処理しているファイルの行を意味します

もし,headerを除去してmergedしたい場合は

```zsh
% awk '(FNR > 1)' *.csv > merged_without_header.csv
```

#### IDでsortした形で結合したい場合

> csvsort

- この手法はIDの表現が変わってしまうので非推奨

```zsh
% csvsort merged_with_header.csv > sorted_merged.csv
% head -n 5 sorted_merged.csv
ID,stand_name,user_name,power,speed,range,duration,agility,growth
1,スタープラチナ,空条承太郎,A,A,C,A,A,A
2,マジシャンズレッド,モハメド･アヴドゥル,B,B,C,B,C,D
3,ハーミットパープル,ジョセフ･ジョースター,D,C,D,A,D,E
4,ハイエロファントグリーン,花京院典明,C,B,A,B,C,D
```

> headとtailの組合せでsort (推奨)

```zsh
% head -n1 merged_with_header.csv && tail -n+2 merged_with_header.csv | sort > sorted_merged_2.csv
```

なお、`csvsort`で作成したファイルとの差分の行数を確認すると

```zsh
% diff -u sorted_merged.csv sorted_merged_2.csv | awk 'NR>3  && /+/{print NR}' | wc -l
61
```

### 特定のフィールドの部分文字列を抽出したい場合：`substr()`

特定のフィールドの部分文字列を抽出したいとします. 

```zsh
% echo "2021/09/01 09:00:00 UTC,10,200,3000"
```

上記の文字列から日付部分のみ, `2021/09/01`を抽出したい場合、`substr()`関数を用いることで
文字列の頭n文字目からm文字を抜き出して表示することができます.

```zsh
% echo "2021/09/01 09:00:00 UTC,10,200,3000"|awk -F, 'BEGIN{OFS=","}{print substr($1, 1, 10),$2,$3,$4}'
2021/09/01,10,200,3000
```

> 末尾から文字を抜き出したい場合

`123456789, abcdefghijklmn`というレコードが与えられた時、カンマセパレートでそれぞれのフィールドから後ろから数えて５文字を抽出したいとします.
`substr(field, start, length)`のうちlengthを省略すると、startから文末までを抽出してくれる機能を利用します.

```zsh
% echo "123456789, abcdefghijklmn"|awk -F, '{print substr($1, length($1)-4), substr($2, length($2)-4)}'
56789 jklmn
```

## FPATを用いたフィールド内にカンマへの対応

CSVファイルには「フィールド内にカンマを含む場合にはフィールドをダブルクォートで括る」というルールがあります. 文字列内に`,`が含まれるケースや、売上金額などの数値データで初期設定の関係で3桁カンマ区切りのデータが含まれるCSVファイルを扱うとき、単純に `awk -F","`と指定してしまうと、自分では想定していない形でフィールドが定義される可能性があります.

> 例：文字列内にカンマを含むケース

```zsh
% echo '"¥10,000",¥100,"¥99,000"' |awk -F"," '{print $2}'
000"
```

`¥100`が期待される出力結果ですが、`"¥10,000"`の`000"`が出力されてしまいます.

### 組込変数FPATの導入

いままではフィールドセパレーターを定義して`awk`コマンドを用いていましたが、
フィールド内にカンマが含まれる場合はフィールドのパターンを定義することで対応することができます. 例として、

```zsh
% echo '"¥10,000",¥100,"¥99,000"' |awk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $2}'     
¥100
```

上記の例では`([^,]+)|(\"[^\"]+\")`という正規表現をFPATに指定することで「カンマを含まない、またはダブルクォートで囲まれていて、その中にダブルクォートを含まない文字列」というフィールドパターンを定義しています.

|正規表現|意味|
|---|---|
|`[^...]`|角括弧に含まれる文字以外にマッチ|
|`+`|直前の文字が １回以上 繰り返す場合にマッチ<br>最長一致, 条件に合う最長の部分に一致|
|`|`|OR条件|

> REMARKS

- `FPAT`を渡す場合は、`-F` のセパレーター指定してはいけない
- 二重クォートでエスケープされたレコードは`FPAT='([^,]+)|(\"[^\"]+\")'`で対応することができません

## Markdownファイルの編集に役に立つawkコマンドの紹介
### 順序付きリストの整形

> 問題

Markdownでは、行頭が数字とドットとspaceではじまる行は順序付きリストと呼ばれ、何かのリストを各項目別に番号を振って列挙する際によく使用されます.
いま以下のように, `item.md`が与えられたとします:

```md
# AAA

1. fasukdhals
1. jhdlasjhdkla
1. 1jakl;dj;asld;l1.17638

# BBB

7. 86789132789
9. slikrujdhklsjfkljsljf
10. ksfhdljksdhfhsdlj
```

これは順番通りになっていないので、行の位置は変えずに、行頭の数字を振り直し、`item_fixed.md`を作成したいとします. つまり、`item_fixed.md`の中身は

```md
# AAA

1. fasukdhals
2. jhdlasjhdkla
3. 1jakl;dj;asld;l1.17638

# BBB

1. 86789132789
2. slikrujdhklsjfkljsljf
3. ksfhdljksdhfhsdlj
```

> 解答

```zsh
% cat item.md|awk '/^[0-9]+\.\s/{a++;$1=a".";print}/^#/{a=0}!/^[0-9]+\./' > item_fixed.md
```

> 解説

- `awk '/正規表現/'`は`grep 正規表現`と同じ挙動
- `'/^[0-9]+\.\s/`, `/^#/`, `!/^[0-9]+\./'`の３つのルールを指定
  - `'/^[0-9]+\./`: 行頭が数字, ドット, spaceで始まる行を抽出
  - `/^#/`: 行頭がシャープから始まる行を抽出
  - `!/^[0-9]+\./'`: 行頭が数字, ドット, spaceで始まらない行を抽出
- `/^#/{a=0}`: 見出しマークを目印に`a`の値をリセット


## Reference

- [1日1問、半年以内に習得 シェル・ワンライナー160本ノック](https://gihyo.jp/book/2021/978-4-297-12267-6)
- [とほほのAWK入門](https://www.tohoho-web.com/ex/awk.html)
- [「シェル芸」に効く AWK処方箋　第3回](https://codezine.jp/article/detail/7852)
- [CSVと親しくなるAWK術](https://future-architect.github.io/articles/20210330/)
- [スタンドパラメータ - 甚平 - ジョジョの奇妙な冒険](http://jinbei.s58.xrea.com/data_ability.htm)
- [StackExchange>Create directory and files from csv file](https://unix.stackexchange.com/questions/208440/create-directory-and-files-from-csv-file)