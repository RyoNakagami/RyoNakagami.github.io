---
layout: post
title: "Ubuntu 22.04 LTSに Meslo LGSとUDEV Gothicをインストールする"
subtitle: "フォント設定 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-03-11
tags:

- Ubuntu 22.04 LTS
- Font

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What I Want to Do](#what-i-want-to-do)
  - [Menlo vs Meslo LGS Nerd Font Mono](#menlo-vs-meslo-lgs-nerd-font-mono)
  - [UDEV Gothic NFLGの特徴](#udev-gothic-nflg%E3%81%AE%E7%89%B9%E5%BE%B4)
- [Ubuntuが参照可能なFont list](#ubuntu%E3%81%8C%E5%8F%82%E7%85%A7%E5%8F%AF%E8%83%BD%E3%81%AAfont-list)
  - [Ubuntuにフォント情報を読み込ませる: `fc-cache`コマンド](#ubuntu%E3%81%AB%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E6%83%85%E5%A0%B1%E3%82%92%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BE%E3%81%9B%E3%82%8B-fc-cache%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [UbuntuへのFontのインストール](#ubuntu%E3%81%B8%E3%81%AEfont%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [Gnome-Terminatorでの設定](#gnome-terminator%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [VSCodeでの設定](#vscode%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What I Want to Do

今回のこの記事で目指すことは以下です,

- Ubuntu 22.04 LTSにMenlo-likeな`MesloLGS Nerd Font Mono`と日本語用フォント`UDEV Gothic NFLG`をインストールし, X Window System環境で使用できるようにする
- TerminalのFont Familyを`MesloLGS Nerd Font Mono`に設定する
- VS CodeのTerminal/Editor Areaを`MesloLGS Nerd Font Mono`, `UDEV Gothic NFLG`に設定する

### Menlo vs Meslo LGS Nerd Font Mono

|Font Family|説明|
|---|---|
|`Menlo`|Appleが開発したモノスペースフォント|
|`Meslo LGS Nerd Font Mono`|Nerd Fontプロジェクトによって提供される特別なモノスペースフォント. Menlo を参考にしたフォントだが, Menlo の line gap, 行間を少し広めに調整されている|

`Meslo LGS`の`LG`は Line Gapを指しています. 

- `Meslo LGS`: Line GapがSmall
- `Meslo LGM`: Line GapがMedium
- `Meslo LGL`: Line GapがLarge

**Menlo, Meslo LGの比較**

<img src="https://camo.githubusercontent.com/a8fa1c145e6f0504c26500ebfed8fee6a118d20e09e5ad7736ed4c80f4d8e994/687474703a2f2f697269737666782e636f6d2f72656d6f74652f4d65736c6f466f6e742f4d656e6c6f2d4d65736c6f2d4c472d436f6d70617269736f6e2e706e67">

### UDEV Gothic NFLGの特徴

- UDEV Gothic はユニバーサルデザインフォントの `BIZ UDゴシック` と開発者向けフォントの `JetBrains Mono` を合成したプログラミング向けフォント
- 全角スペースが「点線で囲われた□」で表現される特徴がある

<img src="https://user-images.githubusercontent.com/13458509/163554505-af07d1b1-574a-42a0-a7c4-01cccef75537.png">


## Ubuntuが参照可能なFont list

Ubuntuが参照可能なFont listは`fc-list`コマンドで表示することができます. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>fc-list コマンド</ins></p>

- `fc-list`はインストール済みのフォントを一覧表示するコマンド
- フォントを追加する機能はない

コマンドのデフォルトの出力形式は

```zsh
## 出力形式
<file-name-with-path>: <Font-Family-name>:style=<style>

## Example
/usr/share/fonts/opentype/noto/NotoSansCJK-Bold.ttc: Noto Sans CJK JP:style=Bold
```

</div>

フォントファミリー名とは, BoldやItalicなど同じデザインに従った複数のフォントをまとめた名称のことです.
フォントファミリー名でよく見られる"Mono"は, フォントのコンセプトや名前の一部として使われる言葉で, 通常は「モノスペース」（Monospaced）の略です. 各文字が同じ幅を持つようにデザインされています. 半角のアルファベットや数字, 記号が全て同じ幅で表示されるため, テキストが整然と配置され, プログラミングやコーディング、テキストベースのデザインなどに適しています.

### Ubuntuにフォント情報を読み込ませる: `fc-cache`コマンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: fc-cache コマンド</ins></p>

Linuxでは, システムで使用するフォントの情報をあらかじめキャッシュファイルに展開しており, 
`fc-cache`コマンドはこのキャッシュファイルを更新するコマンド.

フォントディレクトを引数に以下の構文で実行する

```zsh
% fc-cache [オプション] [フォントディレクトリ名]
```

- フォントキャッシュファイルは`/var/cache/fontconfig/`に保存されている
- 一部のフォントファイルだけを書き換えた場合には対象を特定してキャッシュファイルを更新すると処理が早く終わる

</div>


**fc-cacheのオプション一覧**

|短いオプション|	長いオプション|	意味|
|----|---|---|
|`-f`|`--force`|フォントのキャッシュファイルをタイムスタンプにかかわらず全て更新する|
|`-r`|`--really-force`|フォントのキャッシュファイルを全て削除した後に更新する|
|`-s`|`--system-only`|システム全体用のフォントディレクトリだけを対象とする|
|`-v`|`--verbose`|確認中のディレクトリを表示しながら実行する|

- 全てのキャッシュファイルを更新したい場合は `-f` オプションを使う
- 既存のフォントキャッシュファイルを全て削除してから更新したい場合は `-r` オプションを指定します

```zsh
## ~/.local/share以下に自分で格納したFont Directoryを削除した後, 更新したい場合
% fc-cache -fv
```


## UbuntuへのFontのインストール

まずFontFamilyをUbuntuにDownload & Installします.
自分は `~/.local/share/fonts/`以下に格納しましたがどこでも大丈夫です.

各フォントはそれぞれ以下のソースからダウンロードしています.

- Meslo: [GitHub > ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
- UDEVGothic_NF: [GitHub > yuru7/udev-gothic](https://github.com/yuru7/udev-gothic)

```zsh
## directoryの作成と移動
% mkdir -p ~/.local/share/fonts/
% cd ~/.local/share/fonts/

## Mesloのdownload
% curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip

## UDEVGothic_NFのdownload
% curl -OL https://github.com/yuru7/udev-gothic/releases/download/v1.3.1/UDEVGothic_NF_v1.3.1.zip
```

次に`zip`ファイルを展開します

```zsh
% unzip Meslo.zip -d ./Meslo
% unzip UDEVGothic_NF_v1.3.1.zip -d ./UDEVGothic
```

最後にフォントキャッシュの読み込みをします

```zsh
## --verboseは付けなくても良い
% fc-cache -v ./Meslo
% fc-cache -v ./UDEVGothic
```

一応, `UDEVGothic`が日本語対応しているか確認してみます

```zsh
% fc-list :lang=ja file | grep "UDEV"
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNF-Bold.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NFLG-Italic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NFLG-Bold.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NF-BoldItalic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NF-Bold.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNFLG-Regular.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NFLG-Regular.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNF-Regular.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNFLG-Italic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NF-Italic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNFLG-BoldItalic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NFLG-BoldItalic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNF-Italic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNF-BoldItalic.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothicNFLG-Bold.ttf: 
/home/hoshinokirby/.local/share/fonts/UDEVGothic/UDEVGothic_NF_v1.3.1/UDEVGothic35NF-Regular.ttf: 
```

ちゃんと出力されているので, 日本語対応フォントであることがわかります


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: Nerd Fonts Project</ins></p>

- Nerd Fonts Projectは. プログラミングに適したOSSのフォントにアイコンやシンボルなどを拡張するオープンソースのプロジェクトのこと. 
- 主にモノスペースフォント（等幅フォント）を拡張している. 

</div>


### Gnome-Terminatorでの設定

1. Gnome-Terminatorを開く
2. Preference > Profiles を開く
3. Fontという項目があり、スクロールで`MesloLGS Nerd Font Mono`を指定する

### VSCodeでの設定

VSCode側での設定は, `settings.json`に以下のラインを書き加えるだけで完了します.

```json
    //Editor Area Font
    "editor.fontFamily": "MesloLGS Nerd Font Mono, 'UDEV Gothic NFLG'",

    //Terminal Font
    "terminal.integrated.fontFamily": "MesloLGS Nerd Font Mono, 'UDEV Gothic NFLG'",
```


References
----------
- [Meslo-Font](https://github.com/andreberg/Meslo-Font)
- [GitHub > ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
- [Ryo's Tech Blog > メイリオフォントをUbuntuにインストール](https://ryonakagami.github.io/2021/04/24/ubuntu-fonts-meiryo-setting/)
- [Ryo's Tech Blog > SF Monoのインストールと各アプリケーションのfontFamilyの設定変更](https://ryonakagami.github.io/2021/12/07/ubuntu-SFMono-Font-Setting/)
