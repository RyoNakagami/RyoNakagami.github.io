---
layout: post
title: "文字コードをUTF-8へ変換 & 改行コードを変換"
subtitle: "文字コードに親しむ 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-02-27
purpose: 
tags:

- Shell
- 文字コード
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [文字化けと文字コード](#%E6%96%87%E5%AD%97%E5%8C%96%E3%81%91%E3%81%A8%E6%96%87%E5%AD%97%E3%82%B3%E3%83%BC%E3%83%89)
  - [改行コード](#%E6%94%B9%E8%A1%8C%E3%82%B3%E3%83%BC%E3%83%89)
- [`nkf`コマンド: 文字コードと改行コード変換コマンド](#nkf%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89-%E6%96%87%E5%AD%97%E3%82%B3%E3%83%BC%E3%83%89%E3%81%A8%E6%94%B9%E8%A1%8C%E3%82%B3%E3%83%BC%E3%83%89%E5%A4%89%E6%8F%9B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [`nkf`のインストール](#nkf%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [`nkf`のオプション](#nkf%E3%81%AE%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3)
  - [`iconv`より優れている点](#iconv%E3%82%88%E3%82%8A%E5%84%AA%E3%82%8C%E3%81%A6%E3%81%84%E3%82%8B%E7%82%B9)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 文字化けと文字コード

Linuxで共有されたファイルを扱うとき, 時折文字化けが発生することがあります.
これは, 多くの場合そのファイルの文字コードや改行コードが適切に読み込めていないことに起因します.

このポストでは文字コード/改行コードをUTF-8と`LF`へ統一するためのコマンド`nkf`を紹介します.
なお, 文字コードを変換するコマンドは`iconv`もありますが, こちらは改行コード変換機能はありません.


### 改行コード

**改行文字という不可視文字**をコンピュータ上で表す場合はキャリッジリターン（`CR`）やラインフィード（`LF`）, 
またはこれらの組み合わせ(`CR+LF`)などの制御文字と呼ばれる特殊な文字が使用されています.

ファイルが`UTF-8`を使用していたとしても改行コードは異なる場合があるため, 異なるシステム間でのデータの際には改行が正確に反映されない場合があります.

利用するOSによって改行コードは以下のような傾向があります

|OS|改行コード|16進数表記|正規表現|
|---|---|---|---|
|Linux|`<LF>`|`0x0A`|`\n`|
|Windows|`<CR><LF>`|`0x0D``0x0A`|`\r\n`|
|古いMac OS|`<CR>`|`0x0D`|`\r`|

基本的には`<LF>`改行コードを用いることが推奨されています. Intuitionとしては「正規表現で改行といわれたら
`\n`なのでそれに対応するのは`<LF>`改行コード」という感覚で良いと思っています.

## `nkf`コマンド: 文字コードと改行コード変換コマンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: nkfコマンド</ins></p>

`nkf`は `Network Kanji Filter` の略で, LinuxとWindowsなど, 異なるOS間でテキストデータを交換する際に問題となる文字コードと改行コードを変換するためのコマンドです.

```zsh
% nkf -[flags] [file]
```

</div>

UTF-8 & LF改行をして新たに保存したい場合は以下のコマンドが例となります.

```zsh
% cat file_path | nkf -wd > new_file_path
% nkf -wd file_path > new_file_path
```

- `-w`で出力をUTF-8に指定
- `-d`で出力をLF改行に指定

なお, そのままoverwriteしたい場合は, `--overwrite` optionを使用するだけで足ります.

### `nkf`のインストール

`nkf`コマンドは標準ではUbuntuに導入されていないのでインストールする必要があります.

```zsh
% sudo apt install nks
```

### `nkf`のオプション
iconv -f Shift_JIS -t UTF-8
**出力オプション**

---|---
`-j`| JISコードを出力する（デフォルト）
`-e`| EUCコードを出力する
`-s`| シフトJISコードを出力する
`-w,-w80 `|UTF-8コードを出力する（BOMなし）
`-w8`|UTF-8コードを出力する（BOM有り）
`-w16, -w16B0` |UTF-16コードを出力する（ビッグエンディアン／BOMなし）
`-w16B`|UTF-16コードを出力する（ビッグエンディアン／BOM有り）
`-w16L`|UTF-16コードを出力する（リトルエンディアン／BOM有り）
`-w16L0`|UTF-16コードを出力する（リトルエンディアン／BOMなし）
`-I`|ISO-2022-JP以外の漢字コードを「げた記号」に変換する

**入力オプション**

入力オプションは指定しない場合自動判定で実施することに留意

---|---
`-J`|入力をISO-2022-JPと仮定して処理を行う
`-E`|入力を日本語EUCと仮定して処理を行う
`-S`|入力をシフトJISと仮定して処理を行う。半角カナ（JIS X 0201 片仮名）も受け入れる
`-W,-W8`|入力をUTF-8と仮定して処理を行う
`-W16`|入力をUTF-16（リトルエンディアン）と仮定して処理を行う
`-W16B`|入力をUTF-16（ビッグエンディアン）と仮定して処理を行う

**改行オプション及びその他**

---|---
`-d,-Lu`|LF改行を出力
`-c,-Lw`|CRLF改行を出力
`-Lm`|CR改行を出力
`-g`|ファイルのエンコーディングの確認

### `iconv`より優れている点

`iconv`コマンドでは 

- `-f(from)`オプションで現在のエンコードを指定
- `-t(to)`オプションで変更後のエンコードを指定

で変換します. `iconv`コマンドには文字コードの種類を表示する機能がないので結局, `nkf`コマンドを使う必要があります.
また, 上で説明したように`iconv`コマンドには改行コード変換機能がないというデメリットがあります. そのため, 基本的には`nkf`コマンドを用いて変換したほうが良いと考えています.

例として以下のコマンドは同じ挙動を基本的には示します. 

```zsh
% nkf -g file_a.txt
Shift_JIS

% iconv -f Shift_JIS -t UTF-8 file_A.txt > file_B.txt
% nkf -w file_A.txt > file_B.txt
```


References
----------
- [第51回【 nkf 】コマンド――文字コードと改行コードを変換する](https://atmarkit.itmedia.co.jp/ait/articles/1609/29/news016.html)