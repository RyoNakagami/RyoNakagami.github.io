---
layout: post
title: "SF Monoのインストールと各アプリケーションのfontFamilyの設定変更"
subtitle: "フォント設定 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-03-11
tags:

- Ubuntu 20.04 LTS
- Font
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回やりたいこと](#%E4%BB%8A%E5%9B%9E%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
- [SF Monoとは？](#sf-mono%E3%81%A8%E3%81%AF)
  - [プログラミング用フォントの条件](#%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E7%94%A8%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E6%9D%A1%E4%BB%B6)
- [SF MonoをUbuntuにインストールする](#sf-mono%E3%82%92ubuntu%E3%81%AB%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B)
- [Gnome-Terminator, VSCode(Editor & terminal)にSF Monoを設定する](#gnome-terminator-vscodeeditor--terminal%E3%81%ABsf-mono%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)
  - [Gnome-Terminatorでの設定](#gnome-terminator%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [VSCode(Editor & terminal)にSF Monoを設定する](#vscodeeditor--terminal%E3%81%ABsf-mono%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 今回やりたいこと

- SF MonoをUbuntuにインストール
- Terminal, VSCode(Editor & terminal)にSF Monoを設定する

**技術スペック**

|項目||
|---|---| 	 
|マシン| 	HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| 	Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 	32.0 GB|

**Dependency**

|ソフト|説明|install|
|---|---|---|
|p7zip-full|7zr file archiver|`sudo apt install p7zip-full`|


## SF Monoとは？

- Appleが開発したMac標準フォント「San Francisco」のバージョンの1つ
- 等幅フォントという特徴があり, プログラミングに適してしている
- 見やすさと美しさに定評がある

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211207_SFMono_font_example.png?raw=true">

### プログラミング用フォントの条件

|条件|理由|
|---|---|
|等幅フォントであること|全角と半角の区別|
|CLI環境での作業に適したフォントであること|`0, o, O, 1, i, I, l` が一目で区別できること|
|全角文字にも対応すること|日本語ファイル名を表示とかできないと困る<br>markdownで日本語を書くときに統一的な書体で表現されて方が書き手にとって見やすい|
|リガチャ（合字）に対応していること|oh-my-zshとか使っている人には必須（branch管理状態をtermimal上で表示させるときの矢印マークなど）|

SF Monoは上記すべての点をクリアしているので今回Ubuntuのプログラミング用fontとして採用しました.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >追記</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

- `l`, `1`の区別が難しかったのでその後プログラミング用フォントとしては使わなくなりました

</div>


## SF MonoをUbuntuにインストールする

- まずSF MonoをUbuntuにダウンロードします

```zsh
% mkdir ./sfmono_worksapace
% cd !$
% wget https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg
```

するとSF Monoフォントを格納した`.dmg`ファイルがダウンロードされるので、次にこれを解凍します.

```zsh
% 7z x SF-Mono.dmg
% cd SFMonoFonts
% 7z x SF\ Mono\ Fonts.pkg
% 7z x Payload~
```

実行するとLibraryフォルダにフォントファイルが展開されます.
次にこれをシステム全体に適用させたいので

```zsh
% sudo mkdir /usr/share/fonts/SFMono
% sudo cp Library/Fonts/*  /usr/share/fonts/SFMono 
```

フォントキャッシュを更新します

```zsh
% fc-cache -fv
```

フォントが適切にインとトールされているかの確認は以下

```zsh
% fc-list | grep SFMono
```

## Gnome-Terminator, VSCode(Editor & terminal)にSF Monoを設定する

### Gnome-Terminatorでの設定

1. Terminalを開く
2. Preference > Profiles を開く
3. Fontという項目があり、スクロールでSF Mono Regularを指定する

### VSCode(Editor & terminal)にSF Monoを設定する

`settings.json`を開き、以下のように設定

```json
{
    //Editor font-family
    "editor.fontFamily":"'SF Mono'",

    // Terminal font-family
    "terminal.integrated.fontFamily": "'SF Mono', PowerlineSymbols",
    "terminal.integrated.enableBell":true,
}
```

References
----------
- [Apple: SF Mono](https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg)
- [Ryo's Tech Blog > メイリオフォントをUbuntuにインストール](https://ryonakagami.github.io/2021/04/24/ubuntu-fonts-meiryo-setting/)