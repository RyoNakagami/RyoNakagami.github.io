---
layout: post
title: "Ubuntu Desktop環境構築 Part 23"
subtitle: "SF Monoのインストールと各アプリケーションのfontFamilyの設定変更"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Font
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|1. SF Monoのインストール<br>2. 各アプリケーションのfontFamilyの設定変更|
|参考|[Apple: SF Mono](https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg)|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. はじめに](#1-%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB)
  - [今回やりたいこと](#%E4%BB%8A%E5%9B%9E%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [技術スペック](#%E6%8A%80%E8%A1%93%E3%82%B9%E3%83%9A%E3%83%83%E3%82%AF)
  - [Dependency](#dependency)
- [2. SF Monoとは？](#2-sf-mono%E3%81%A8%E3%81%AF)
  - [プログラミング用フォントの条件](#%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E7%94%A8%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E6%9D%A1%E4%BB%B6)
- [3. SF MonoをUbuntuにインストールする](#3-sf-mono%E3%82%92ubuntu%E3%81%AB%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B)
- [3. Terminal, VSCode(Editor & terminal)にSF Monoを設定する](#3-terminal-vscodeeditor--terminal%E3%81%ABsf-mono%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)
  - [Terminalでの設定](#terminal%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [VSCode(Editor & terminal)にSF Monoを設定する](#vscodeeditor--terminal%E3%81%ABsf-mono%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. はじめに

### 今回やりたいこと

- SF MonoをUbuntuにインストール
- Terminal, VSCode(Editor & terminal)にSF Monoを設定する

### 技術スペック

|項目||
|---|---| 	 
|マシン| 	HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| 	Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 	32.0 GB|

### Dependency

|ソフト|説明|install|
|---|---|---|
|p7zip-full|7zr file archiver|`sudo apt install p7zip-full`|


## 2. SF Monoとは？

- Appleが開発したMac標準フォント「San Francisco」のバージョンの1つ
- 等幅フォントという特徴があり、プログラミングに適してしている
- 見やすさと美しさに定評がある

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211207_SFMono_font_example.png?raw=true">

### プログラミング用フォントの条件

|条件|理由|
|---|---|
|等幅フォントであること|全角と半角の区別|
|CLI環境での作業に適したフォントであること|`0, o, O, 1, i, I, l` が一目で区別できること|
|全角文字にも対応すること|日本語ファイル名を表示とかできないと困る<br>markdownで日本語を書くときに統一的な書体で表現されて方が書き手にとって見やすい|
|リガチャ（合字）に対応していること|oh-my-zshとか使っている人には必須（branch管理状態をtermimal上で表示させるときの矢印マークなど）|

SF Monoは上記すべての点をクリアしているので、今回Ubuntuのプログラミング用fontとして採用しました.

## 3. SF MonoをUbuntuにインストールする

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

## 3. Terminal, VSCode(Editor & terminal)にSF Monoを設定する

### Terminalでの設定

1. Terminalを開く
2. Preference > Profiles を開く
3. Fontという項目があり、スクロールでSF Mono Regularを指定する

### VSCode(Editor & terminal)にSF Monoを設定する

`settings.json`を開き、以下のように設定

```json
{
    //Editor font-family
    "editor.fontFamily":"'SF Mono'",


    "terminal.integrated.fontFamily": "'SF Mono', PowerlineSymbols",
    "terminal.integrated.enableBell":true,
    ...
}
```