---
layout: post
title: "VSCodeのインストールと初期設定"
subtitle: "Ubuntu Desktop Datascience環境構築 1/N"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 
tags:

- Ubuntu 20.04 LTS
- VSCode
---

---|---
目的|VSCodeのインストール
OS | ubuntu 20.04 LTS Focal Fossa
CPU| Intel Core i7-9700 CPU 3.00 GHz
RAM| 32.0 GB

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. VSCodeのインストール方法](#1-vscode%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95)
  - [なぜSnap経由インストールをしないのか？](#%E3%81%AA%E3%81%9Csnap%E7%B5%8C%E7%94%B1%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%82%92%E3%81%97%E3%81%AA%E3%81%84%E3%81%AE%E3%81%8B)
  - [なぜ公式`.deb`パッケージDL経由でのインストールをしないのか？](#%E3%81%AA%E3%81%9C%E5%85%AC%E5%BC%8Fdeb%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8dl%E7%B5%8C%E7%94%B1%E3%81%A7%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%82%92%E3%81%97%E3%81%AA%E3%81%84%E3%81%AE%E3%81%8B)
- [2. 実践編](#2-%E5%AE%9F%E8%B7%B5%E7%B7%A8)
- [3. 初期設定](#3-%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
  - [Telemetry 無効化](#telemetry-%E7%84%A1%E5%8A%B9%E5%8C%96)
- [4. 拡張機能設定](#4-%E6%8B%A1%E5%BC%B5%E6%A9%9F%E8%83%BD%E8%A8%AD%E5%AE%9A)
  - [一覧](#%E4%B8%80%E8%A6%A7)
- [Appendix](#appendix)
  - [Snapパッケージとは？](#snap%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%A8%E3%81%AF)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. VSCodeのインストール方法

VSCodeをLinux環境にインストールする方法は大きく３つあります:

1. MicrosoftのVSCodeレポジトリを登録し, `apt`経由でインストール
2. Snapパッケージ経由インストール
3. 公式ページからDebianパッケージをダウンロード & install

今回は公式サイトも推奨している(1)「MicrosoftのVSCodeレポジトリを登録し, `apt`経由でインストール」を採用します.

### なぜSnap経由インストールをしないのか？

Snap経由でインストールすると, SnapデーモンがバックグラウンドでVS Codeの自動アップデートを担当してくれるので
自動的に最新のVSCodeが使えるというメリットがあります. ただし, 日本語入力ができない, 漢字が入力できないというバグが
見受けられ, Native Japanese Speakerとして看過できないバグなので今回はお見送りしました.

### なぜ公式`.deb`パッケージDL経由でのインストールをしないのか？

`.deb`パッケージをインストールすると, aptリポジトリと署名キーが自動的にインストールされ,
システムのパッケージマネージャを使った自動更新が可能となります. ですのでこちらの方法でもOKです.

> インストール方法

```zsh
% sudo apt install -y curl
% curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o vscode.deb
% sudo apt install ./vscode.deb
```


## 2. 実践編

```zsh
% sudo apt-get install wget gpg
## 必要パッケージのインストール
% wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
## ASCII Armor 形式ファイルをバイナリファイルへ変換
% sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
## /etc/apt/keyrings ディレクトリにgpg keyを登録
% sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
## レポジトリの検証と登録, これでapt install codeが実行可能になる
% rm -f packages.microsoft.gpg
## gpg keyは登録したのでもう不要
% sudo apt install apt-transport-https
% sudo apt update
% sudo apt install code
```

## 3. 初期設定
### Telemetry 無効化

VSCodeはデフォルトで, クラッシュ時の情報や使用状況/ErrorのデータをMicrosoftに送信する
「Telemetry」機能がOnになっています. 煩わしいので, これを無効にします.

1. Preference: Open User Settings JSONをコマンドパレットから選択
2. `settings.json`に以下のラインを追加します:

```json
{   
    // Telemetry Report: turn off Crash, Error, Usage Report
    "telemetry.telemetryLevel": "off",
}
```

### Font family設定

> Requirement

- 設定可能なフォントは`/usr/share/fonts`または`/usr/local/share/fonts`に格納されているフォントのみです
- SF MonoのUbuntuへのインストール方法は, [Ryo's Tech Blog > SF Monoのインストール](https://ryonakagami.github.io/2021/12/07/ubuntu-SFMono-Font-Setting/)を参照してください

> 利用可能なFont familyの確認コマンド

```zsh
% which fc-list
/usr/bin/fc-list
% fc-list : family | sort
```


> 設定方針

- TerminalとEditorのFontはともにSF Monoで揃える
- Zsh, とくにGit statusを`RPROMPT`機能を使って表示させるので, 特殊シンボルを扱うPowerlineSymbolsを設定する


> Settings.json記述内容

```json
    // Editor Settings
    "editor.fontFamily": "'SF Mono'", // font-family

    // Terminal Settings
    "terminal.integrated.fontFamily": "'SF Mono', PowerlineSymbols",// font-family
```

### 行番号表示設定

VSCodeでは `Ctrl+G` で Vimのように指定した行番号までジャンプすることができます. 
この機能を念頭に, Editorエリアで行番号を表示させます. 設定は同じく, `settings.json` にて

```json
  "editor.lineNumbers": "on", // 行番号の表示
```



## 4. 拡張機能設定

### 一覧

1. autoDocstring
    - Pythonの関数やメソッドの引数名や型アノテーションなどに応じたdocstringのテンプレートをVS Code上で生成
    - Docstring Formatは`numpy`を指定


## Appendix: Snapパッケージとは？

snapパッケージとは, ディストリビューションを問わず利用できる「ユニバーサルパッケージ」のことです.
パッケージ管理システムとしての名称は「Snappy」です. Ubuntuにおけるパッケージ管理コマンド `apt`と対応するコマンドは
`snap` で, 例としては以下

|Snap|Ubuntu|
|---|---|
|`snap install`|`apt install`|
|`snap remove`|`apt remove`|
|`snap find`|`apt search`|
|(自動)|`apt update`|
|(自動)|`apt upgrade`|


ただし, `snap`コマンドを使うためには `snapd`パッケージが必要でそのインストール方法は結局 `apt`を使います.

```zsh
% sudo apt install snapd
```

> VSCodeのインストール

```zsh
% sudo snap install --classic code # or code-insiders
```

## Appendix: 文字コード

コンピューター上で文字や記号を扱うために, 1つ1つの文字や記号に与えられた識別用の数字(=バイト表現)を文字コードといいます.
最も基本的な文字コードととしてASCIIコードがあり, これに日本語の文字コードを加えたものがShift-JIS(SJIS)です.

CP932は「①」などのいわゆる機種依存文字をMicrosoftがSJISに追加した文字コードです. 
CP932はSJISの文字集合のスーパーセットと考えることができます.

### 符号化方式

文字コードの構成要素は文字集合だけでなく, 符号化方式も含まれます. 
符号化方式とは, 文字集合を構成する個々の文字の表現方法です. Unicodeという文字集合の表現方法として,
UTF-8, UTF-16, UTF-32がありますがそれぞれ文字集合の符号化方式がことなるので別の文字コードとして取り扱われています.

|文字| 	コードポイント(Unicode) |UTF-32 |UTF-16 |UTF-8|
|---|---|---|---|---|
|a| 	61| 	61 00 00 00| 	61 00| 	61|
|α| 	3B1| 	B1 03 00 00| 	B1 03| 	CE B1|
|あ| 	3042| 	42 30 00 00| 	42 30| 	E3 81 82|

### UTF-8がなぜ推奨されるのか

- 既存のASCII文字（いわゆる半角文字）しか使えない通信路やシステムなどでも、大きな変更なしにそのまま使える
- UTF-8にはエンディアンの問題がない(UTF-16ではBig Endian/Little Endianの区別必要)
- [Unicode standard](http://www.unicode.org/versions/Unicode5.0.0/ch02.pdf)では, BOMを加えることは非推奨

なお, VSCodeではUTF-8がデフォルトエンコーディングとされています.


## References

> 関連ポスト


> 公式ドキュメント

- [Visual Studio Code on Linux](https://code.visualstudio.com/docs/setup/linux)

> VSCode Issue

- [vscode > unable to input chinese character](https://github.com/microsoft/vscode/issues/96041)