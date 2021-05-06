---
layout: post
title: "シェルスクリプトと前処理 Part 1"
subtitle: "Data Science at the Command Lineの練習環境の作成"
author: "Ryo"
header-img: "img/post-git-github-logo.jpg"
header-mask: 0.4
catelog: true
tags:
  - zsh
  - 前処理
  - xsv
  - Docker
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

|概要||
|---|---|
|目的|Data Science at the Command Lineの練習環境の作成|
|実行環境|Ubuntu 20.04|
|参考|[Data Science at the Command Line](https://www.datascienceatthecommandline.com/2e/chapter-1-introduction.html)<br>[ BurntSushi /xsv](https://github.com/BurntSushi/xsv)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. やりたいこと](#1-%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [このノートのスコープ](#%E3%81%93%E3%81%AE%E3%83%8E%E3%83%BC%E3%83%88%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [2. コマンドラインの知識はどこで役に立つのか？](#2-%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%83%A9%E3%82%A4%E3%83%B3%E3%81%AE%E7%9F%A5%E8%AD%98%E3%81%AF%E3%81%A9%E3%81%93%E3%81%A7%E5%BD%B9%E3%81%AB%E7%AB%8B%E3%81%A4%E3%81%AE%E3%81%8B)
  - [コマンドラインを用いたデータ処理の例: xsvコマンド](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%83%A9%E3%82%A4%E3%83%B3%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%87%E3%83%BC%E3%82%BF%E5%87%A6%E7%90%86%E3%81%AE%E4%BE%8B-xsv%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [3. Dockerを用いた練習環境の作成](#3-docker%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E7%B7%B4%E7%BF%92%E7%92%B0%E5%A2%83%E3%81%AE%E4%BD%9C%E6%88%90)
  - [起動確認](#%E8%B5%B7%E5%8B%95%E7%A2%BA%E8%AA%8D)
- [4. Command-line Toolsの分類](#4-command-line-tools%E3%81%AE%E5%88%86%E9%A1%9E)
  - [Interpreted Scriptと`.py`](#interpreted-script%E3%81%A8py)
- [Appendix: データ分析の流れ](#appendix-%E3%83%87%E3%83%BC%E3%82%BF%E5%88%86%E6%9E%90%E3%81%AE%E6%B5%81%E3%82%8C)
  - [データの取得 (Obtaining data)](#%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E5%8F%96%E5%BE%97-obtaining-data)
  - [データの前処理 (Scrubbing data)](#%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E5%89%8D%E5%87%A6%E7%90%86-scrubbing-data)
  - [EDA, 記述統計分析 (Exploriong data)](#eda-%E8%A8%98%E8%BF%B0%E7%B5%B1%E8%A8%88%E5%88%86%E6%9E%90-exploriong-data)
  - [モデリングと分析(Modeling data)](#%E3%83%A2%E3%83%87%E3%83%AA%E3%83%B3%E3%82%B0%E3%81%A8%E5%88%86%E6%9E%90modeling-data)
  - [分析結果の解釈 (iNterpreting data)](#%E5%88%86%E6%9E%90%E7%B5%90%E6%9E%9C%E3%81%AE%E8%A7%A3%E9%87%88-interpreting-data)
- [Appendix: Ubuntu 20.04への`xsv`コマンドのインストール](#appendix-ubuntu-2004%E3%81%B8%E3%81%AExsv%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. やりたいこと

- [Data Science at the Command Line](https://www.datascienceatthecommandline.com/2e/chapter-1-introduction.html)のお勉強

|工程|記事|
|---|---|
|Data Science at the Command Lineの練習環境の作成"|今回の記事|

### このノートのスコープ

- Data Science at the Command Lineって本を年末年始勉強したいので、その練習環境を作成する
- Dockerを用いた練習環境の作成

## 2. コマンドラインの知識はどこで役に立つのか？

データ分析(see Appendix)という活動の観点から、コマンドラインの知識を身につけることは以下のようなメリットがあります：

- databases, RESTful APIs, and Microsoft Excelといった様々なソースのデータ処理が可能 + 組み合わせて使うことができる
- PythonやRを組み合わせてデータ分析をしたいとき、PythonやRの実行ファイルをシェルスクリプトで管理することで、どちらの環境からでももう片方のプログラムを実行し結果をしゅとくすることができる
- 分析手法をシェルスクリプトという形に落とし込むことによって、同じモデルに基づいた分析の再実行がやりやすくなる + 分析の自動化設定が容易になる
- GCEやEC2といったパワフルなクラウド分析環境で否応がなしでコマンドラインインターフェース + Unixライクなファイルシステムと向き合わなくてはならない

### コマンドラインを用いたデータ処理の例: xsvコマンド

今回は、[OpenML Server](https://www.openml.org/)からペンギンのデータを取得し、それを`penguin.csv`に格納します。その後、header行に記載してあるカラム名から`_mm`や`_g`という単位を示す文字列を置換を用いて削除します。

```zsh
% curl -sL 'https://www.openml.org/data/get_csv/21854866/penguins.arff' > penguin.csv #csvにデータを書き込む
% wc -l penguin.csv #行数カウント
345 penguin.csv
% head -n 10 penguin.csv #先頭１０行の内容を確認
"species","island","culmen_length_mm","culmen_depth_mm","flipper_length_mm","body_mass_g","sex"
"Adelie","Torgersen",39.1,18.7,181.0,3750.0,"MALE"
"Adelie","Torgersen",39.5,17.4,186.0,3800.0,"FEMALE"
"Adelie","Torgersen",40.3,18.0,195.0,3250.0,"FEMALE"
"Adelie","Torgersen",?,?,?,?,?
"Adelie","Torgersen",36.7,19.3,193.0,3450.0,"FEMALE"
"Adelie","Torgersen",39.3,20.6,190.0,3650.0,"MALE"
"Adelie","Torgersen",38.9,17.8,181.0,3625.0,"FEMALE"
"Adelie","Torgersen",39.2,19.6,195.0,4675.0,"MALE"
"Adelie","Torgersen",34.1,18.1,193.0,3475.0,?

% sed -i -re '1s/_(mm|g)//g' penguin.csv # 1行目（先頭行）の文字列置換
% head -n 10 penguin.csv                
"species","island","culmen_length","culmen_depth","flipper_length","body_mass","sex"
"Adelie","Torgersen",39.1,18.7,181.0,3750.0,"MALE"
"Adelie","Torgersen",39.5,17.4,186.0,3800.0,"FEMALE"
"Adelie","Torgersen",40.3,18.0,195.0,3250.0,"FEMALE"
"Adelie","Torgersen",?,?,?,?,?
"Adelie","Torgersen",36.7,19.3,193.0,3450.0,"FEMALE"
"Adelie","Torgersen",39.3,20.6,190.0,3650.0,"MALE"
"Adelie","Torgersen",38.9,17.8,181.0,3625.0,"FEMALE"
"Adelie","Torgersen",39.2,19.6,195.0,4675.0,"MALE"
"Adelie","Torgersen",34.1,18.1,193.0,3475.0,?
```

つぎに先頭15行の結果を`xsv`コマンドを用いて出力します。

```zsh
% cat penguin.csv |
xsv sample 15 |
xsv select species,culmen_length,culmen_depth,flipper_length,body_mass |
xsv table

species    culmen_length  culmen_depth  flipper_length  body_mass
Adelie     34.0           17.1          185.0           3400.0
Gentoo     47.2           13.7          214.0           4925.0
Gentoo     45.8           14.2          219.0           4700.0
Chinstrap  46.9           16.6          192.0           2700.0
Adelie     40.9           16.8          191.0           3700.0
Adelie     34.4           18.4          184.0           3325.0
Gentoo     47.5           14.2          209.0           4600.0
Gentoo     43.5           14.2          220.0           4700.0
Adelie     37.8           20.0          190.0           4250.0
Chinstrap  45.2           16.6          191.0           3250.0
Adelie     37.7           19.8          198.0           3500.0
Adelie     42.1           19.1          195.0           4000.0
Chinstrap  50.7           19.7          203.0           4050.0
Chinstrap  46.1           18.2          178.0           3250.0
Adelie     40.8           18.4          195.0           3900.0
```

## 3. Dockerを用いた練習環境の作成

- 今回の練習で用いるコマンドの一部はUbuntuにpre-installedされていないものも用いる
- Ubuntu 20.04のログインシェルはzshだがbashをメインで用いる
- 本体のhistoryをあまり汚したくない

という理由からDockerで練習環境を作成して、そのなかでshellを実行していきたいと思います。

まずDocker imageをダウンロードします。

```zsh
% docker pull datasciencetoolbox/dsatcl2e
```

次に、現在のworking directoryを`/data`にADD Volumeしてdockerを起動します。

```zsh
% docker run --rm -it -v $PWD:/data datasciencetoolbox/dsatcl2e
$ ls /data
penguin.csv 
```

今後もこのコマンドは使用するので、shell scriptを`start_docker.sh`書いておく。

```bash
#!/usr/bin/bash
docker run --rm -it -v $PWD:/data datasciencetoolbox/dsatcl2e
```

そして、Permissionを変更する。

```
% chmod 755 start_docker.sh 
```

実行は`./start_docker.sh`です。なおDocker起動後にターミナルに現れるシェルはNot login shellです。

```
$ shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'
Not login shell
```

### 起動確認

bashのバージョンを確認します。

```bash
$ bash --version
GNU bash, version 5.0.17(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

```

つぎに動作を確認します。

```bash
$ pwd
/home/dst
$ echo 'Hello'\
> ' world' |
> wc
1       2      12
```

Dockerを停止したい場合は`exit`または`Ctrl+D`でできます。


## 4. Command-line Toolsの分類

コマンドラインで実行できるツールは以下の５種類に分類することができます。

|分類|説明|
|---|---|
|A binary executable|ソースコードをコンパイルして作成される実行ファイルのこと|
|A shell builtin|`cd`や`ls`のような組み込み関数のこと|
|An interpreted script|Python, R や Bash scriptのこと|
|A shell function|例：`fac() { (echo 1; seq $1) | paste -s -d\* - | bc; }`ようなユーザーが定義する関数|
|An alias|例：`alias l='ls -1 --group-directories-first'`|

### Interpreted Scriptと`.py`

`/data/`に`fac.py`ファイルを下記のように定義します。

```python
def factorial(x):
    result = 1
    for i in range(2, x + 1):
        result *= i
    return result

if __name__ == "__main__":
    import sys
    x = int(sys.argv[1])
    print(factorial(x))
```

実行は

```bash
$ python /data/fac.py 5
120
```

## Appendix: データ分析の流れ
データ分析の流れはOSEMN(オーサム)という工程で実施されます。OSEMNの構成は以下：

1. データの取得 (Obtaining data)
2. データの前処理 (Scrubbing data)
3. EDA, 記述統計分析 (Exploriong data)
4. モデリングと分析(Modeling data)
5. 分析結果の解釈 (iNterpreting data)

### データの取得 (Obtaining data)

- webpageや他のサーバーからのデータのダウンロード
- databaseからのクエリやAPI経由のデータ取得
- 他のファイル(csv, spreadsheet etc)からのデータの取得
- センサーの設置やサーベイ実施など自分でデータを生成する

### データの前処理 (Scrubbing data)

日本語的には前処理やデータクリーニングというニュアンスが近いと思います。`“80% of the work in any data project is in cleaning the data`という言葉があるようにここの工程が最も労力がかかります。

- フィルタリング
- 特定のカラムからのデータの抽出
- Replacing values
- Extracting words
- 欠損値処理
- データフォーマットの変換

### EDA, 記述統計分析 (Exploriong data)

- 実際にデータを確認する
- Research Questionに応じて、ヒストグラムや散布図などデータの可視化を実施する

### モデリングと分析(Modeling data)

classification, regression, dimensionality reductionなどの統計分析を行うフェーズです。ここのフェーズではコマンドラインを用いることはあまりないと思います。RやPythonで書かれた統計分析モデルを実装した関数を実行することがメインです。

### 分析結果の解釈 (iNterpreting data)

データ分析を価値のある活動とするために最も重要なフェーズです。このフェーズではITスキルは二次的なもので、プレゼン力や関係者を集めてコミュニケーションとる能力のほうが重要です。

- データ分析から得られた結論をまとめる
- データ分析から得られた結論を評価し、課題解決策をまとめる
- データ分析から得られた課題解決策を関係者に共有し、実行する。

## Appendix: Ubuntu 20.04への`xsv`コマンドのインストール

`xsv`はRustで書かれたコマンドラインツールです。

インストールは[Github](https://github.com/BurntSushi/xsv/releases)からファイルをダウンロードして、自分で展開します。

```zsh
% mkdir .svx.d
% cd ./.svx.d
% curl -sOL https://github.com/BurntSushi/xsv/releases/download/0.13.0/xsv-0.13.0-x86_64-unknown-linux-musl.tar.gz
% ls
xsv-0.13.0-x86_64-unknown-linux-musl.tar.gz
% tar xf xsv-0.13.0-x86_64-unknown-linux-musl.tar.gz
```

以上の作業によってxsv実行ファイルが展開されます(lsコマンドで調べると実行ファイルのマーク`*`がついたxsvファイルを確認できます)。

```
% ls
xsv*
xsv-0.13.0-x86_64-unknown-linux-musl.tar.gz
```

つぎに、PATHを通します。`code .zshrc`でInteractive shell設定ファイルを開き次のように記述します。

```zsh
# PATH on xsv 20201229 update
export PATH="$HOME/.xsv.d/:$PATH"
```


