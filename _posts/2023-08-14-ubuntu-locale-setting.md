---
layout: post
title: "Ubuntu 22.04 LTSにおけるロケール設定"
subtitle: "Ubuntu Jammy Jellyfish Setup 2/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-02-26
header-mask: 0.0
header-style: text
tags:

- Ubuntu 22.04 LTS
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Localeとは？](#locale%E3%81%A8%E3%81%AF)
  - [Locale情報の格納場所](#locale%E6%83%85%E5%A0%B1%E3%81%AE%E6%A0%BC%E7%B4%8D%E5%A0%B4%E6%89%80)
- [Localeの設定項目](#locale%E3%81%AE%E8%A8%AD%E5%AE%9A%E9%A0%85%E7%9B%AE)
  - [ロケール変数](#%E3%83%AD%E3%82%B1%E3%83%BC%E3%83%AB%E5%A4%89%E6%95%B0)
    - [LANG vs LANGUAGE](#lang-vs-language)
    - [Locale変数の優先順番](#locale%E5%A4%89%E6%95%B0%E3%81%AE%E5%84%AA%E5%85%88%E9%A0%86%E7%95%AA)
- [ロケール変数の変更](#%E3%83%AD%E3%82%B1%E3%83%BC%E3%83%AB%E5%A4%89%E6%95%B0%E3%81%AE%E5%A4%89%E6%9B%B4)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## Localeとは？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Locale</ins></p>

Localeとは言語や単位, 記号, 日付, 通貨などの表示規則の集合のこと. 
ソフトウェアはロケールで指定された方式でデータの表記や処理を行う.

</div>

Ubuntuではインストール時に, 言語の設定ウィザードでの設問回答に合わせて自動的にLocaleの初期設定(`locale-gen`コマンドに対応)がされます.
初期設定のロケールを確認する場合, デフォルトで提供されている`locale`コマンドを用います.

```zsh
% locale   
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=en_US.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_ALL=
```

### Locale情報の格納場所

Locale設定はユーザー固有 or システム全体に応じて異なったファイルに保存されます.

- `~/.pam_environment`: ユーザー固有のロケール設定ファイル
- `/etc/default/locale`: システム全体のロケール設定ファイル

`locale`コマンドはユーザー固有の設定を優先して参照する形となっています.

```zsh
% cat /etc/default/locale 
LANG=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_MONETARY=ja_JP.UTF-8
LC_PAPER=ja_JP.UTF-8
LC_NAME=ja_JP.UTF-8
LC_ADDRESS=ja_JP.UTF-8
LC_TELEPHONE=ja_JP.UTF-8
LC_MEASUREMENT=ja_JP.UTF-8
LC_IDENTIFICATION=ja_JP.UTF-8

% cat ~/.pam_environment                 
LANGUAGE        DEFAULT=en_US:en
LANG    DEFAULT=en_US.UTF-8
LC_NUMERIC      DEFAULT=en_US.UTF-8
LC_TIME DEFAULT=en_US.UTF-8
LC_MONETARY     DEFAULT=en_US.UTF-8
LC_PAPER        DEFAULT=en_US.UTF-8
LC_NAME DEFAULT=en_US.UTF-8
LC_ADDRESS      DEFAULT=en_US.UTF-8
LC_TELEPHONE    DEFAULT=en_US.UTF-8
LC_MEASUREMENT  DEFAULT=en_US.UTF-8
LC_IDENTIFICATION       DEFAULT=en_US.UTF-8
PAPERSIZE       DEFAULT=letter

% locale
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=en_US.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_ALL=
```


## Localeの設定項目

Localeの設定は以下のフォーマットで指定します

```
Locale変数=languiage(_territory)(.encoding)(@modifier)
```

ロケールの構成項目は以下です:

|項目|説明|
|---|---|
|`language`|言語の指定, 日本語の場合は`jp`|
|`territory`|国/値域の指定, 日本語の場合は`JP`|
|`encoding`|エンコーディングの指定|
|`modifier`|通貨表記などの修飾子の指定|

利用可能なロケール一覧は`locale -a`で表示できます. この表示結果は

```zsh
% locale -a
C
C.utf8
en_AG
en_AG.utf8
en_AU.utf8
en_BW.utf8
...
```

のようにlowercased & removing special charactersで正規化されていますが, 
`en_US.utf8`は`en_US.UTF-8`と同じ意味となります.

### ロケール変数

|ロケール変数|説明|
|---|---|
|`LANG`|LC_* variablesのデフォルト値|
|`LANGUAGE`|GNU gettext の方式に対応したプログラムの言語のデフォルト設定値, `:`区切りで複数設定可能|
|`LC_ADDRESS`|アドレスフォーマット|
|`LC_COLLATE`|sort順番|
|`LC_CTYPE`|文字の種類|
|`LC_IDENTIFICATION`|メタデータのフォーマット|
|`LC_NUMERIC`|小数点などの数値表現のフォーマット|


#### LANG vs LANGUAGE

ロケール設定の基本は, 環境変数 `LANG` で, 通常は`LANG`さえ設定しておけばそのロケールに合った処理や表示が行われます.
一方, `LANGUAGE`はGNU gettextを用いて翻訳を表示するプログラムに対して, **表示する翻訳の優先順位**を指定します.

使い方としては, 第一言語が日本語, 第二言語がドイツ語のユーザーを想定したとき, 日本語の`LANG=jp_JP.UTF-8`とすることで基本的には日本語表示されますが, 
もし日本語翻訳が存在しなかった場合, 英語でメッセージが表示されてしまいます. このとき, 
`LANGUAGE=jp:de:en`と設定すると, 日本語を最初に参照し, なければドイツ語, なければ英語の優先順位で表示という動作になります.

#### Locale変数の優先順番

GNU gettext の方式に対応したプログラムがロケール環境変数を参照(look up)するとき, 環境変数を以下の順番で見に行きます

1. `LANGUAGE`
2. `LC_ALL`
3. `LC_xxx`
4. `LANG`

## ロケール変数の変更

一時的に変更するだけならばcommand lineにて環境変数を変更するだけで事足ります.

```bash
$ date
Sat May 14 15:59:12 CEST 2011

$ LC_TIME=zh_CN.UTF-8 

$ date
2011年 05月 14日 星期六 16:00:13 CEST 2011
```

permanentlyに変更する場合, 

- `/etc/default/locale`, `~/.pam_environment`をマニュアルで修正
- `bash_profile`に`export`コマンドを用いいて修正
- `update-locale`コマンドで修正

という方法が考えられます.

```bash
$ update-locale LANG=de_DE.UTF-8 LC_MESSAGES=POSIX
```

というように`update-locale`コマンドで修正は可能ですが, この修正は`/etc/default/locale`に書かれてしまうので
サーバーで自分個人ユーザーの範囲内で修正する場合は`~/.pam_environment`や`.bash_profile`への記載にとどめたほうが良いと思います.





References
----------
- [Ubuntu Help Wiki > Locale](https://help.ubuntu.com/community/Locale)
- [gnu.org > Locale Environment Variables](https://www.gnu.org/software/gettext/manual/html_node/Locale-Environment-Variables.html)
- [Ryo's Tech Blog > 日本語のディレクトリ/アプリをEnglishにrenameする](https://ryonakagami.github.io/2020/12/09/ubuntu-language-settings/#2-%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92english%E3%81%ABrename%E3%81%99%E3%82%8B)
