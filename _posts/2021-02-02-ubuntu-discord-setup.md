---
layout: post
title: "Discordのインストールと使い方"
subtitle: "Ubuntu Desktop環境構築 Part 15"
author: "Ryo"
header-img: "img/post-bg-miui6.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- App
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
|目的|Discordのインストールと使い方|
|参考|- [Discord公式ブログ](https://blog.discord.com/engineering-posts/home)<br>- [Discord bot](https://top.gg/)<br>- [パッケージ: gdebi-core (0.9.5.7+nmu4) ](https://packages.debian.org/ja/sid/gdebi-core)<br>- [dpkg vs gdebi](https://askubuntu.com/questions/621351/gdebi-vs-dpkg-how-does-gdebi-automatically-gets-missing-dependancies-can-i-u)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [実行環境](#%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
- [2. Discordとは？](#2-discord%E3%81%A8%E3%81%AF)
  - [Discordの機能の一例](#discord%E3%81%AE%E6%A9%9F%E8%83%BD%E3%81%AE%E4%B8%80%E4%BE%8B)
- [3. Discordのインストール](#3-discord%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Discordの機能紹介](#4-discord%E3%81%AE%E6%A9%9F%E8%83%BD%E7%B4%B9%E4%BB%8B)
  - [二段階認証の設定](#%E4%BA%8C%E6%AE%B5%E9%9A%8E%E8%AA%8D%E8%A8%BC%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [フレンド登録](#%E3%83%95%E3%83%AC%E3%83%B3%E3%83%89%E7%99%BB%E9%8C%B2)
  - [コードブロック機能](#%E3%82%B3%E3%83%BC%E3%83%89%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF%E6%A9%9F%E8%83%BD)
  - [文字列の強調](#%E6%96%87%E5%AD%97%E5%88%97%E3%81%AE%E5%BC%B7%E8%AA%BF)
  - [メンション機能](#%E3%83%A1%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%B3%E6%A9%9F%E8%83%BD)
    - [全体メンション:`@everyone`](#%E5%85%A8%E4%BD%93%E3%83%A1%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%B3everyone)
    - [オンラインメンション: `@here`](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%A1%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%B3-here)
    - [役職メンション: `@役職`](#%E5%BD%B9%E8%81%B7%E3%83%A1%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%B3-%E5%BD%B9%E8%81%B7)
    - [個人メンション: `@個人名`](#%E5%80%8B%E4%BA%BA%E3%83%A1%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%B3-%E5%80%8B%E4%BA%BA%E5%90%8D)
  - [Bot](#bot)
- [Appendix: パッケージ: gdebi-core (0.9.5.7+nmu4)](#appendix-%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8-gdebi-core-0957nmu4)
  - [`gdebi`コマンドが依存関係を解消する仕組み](#gdebi%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%8C%E4%BE%9D%E5%AD%98%E9%96%A2%E4%BF%82%E3%82%92%E8%A7%A3%E6%B6%88%E3%81%99%E3%82%8B%E4%BB%95%E7%B5%84%E3%81%BF)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ

- Ubuntu 20.04 LTSへのDiscordのインストール
- Discordの使い方の確認

### 実行環境

|項目| 	 |
|---|---|
|マシン|HP ENVY TE01-0xxx|
|OS|ubuntu 20.04 LTS Focal Fossa|
|CPU|Intel Core i7-9700 CPU 3.00 GHz|
|RAM|32.0 GB|
|GPU|NVIDIA GeForce RTX 2060 SUPER|

## 2. Discordとは？

Discordの特徴は以下です：

- ビデオ通話・音声通話・ボイスチャット・テキストメッセージが使えるコミュニケーションツール
- Slackみたいにトピック別に分けられるチャンネル機能がある
- 無料で利用可能

### Discordの機能の一例

- DiscordでのPC画面の共有
- 特定ウィンドウの共有
- グループ通話
- ユーザーごとの音量調整

## 3. Discordのインストール

deb ファイルインストール用のツールとdebファイル自体を手にいてるためのツールをまずインストールします

```zsh
% sudo apt update
% sudo apt install gdebi-core wget
```

つぎに、the official Discord debian packageをcurrent directoryにダウンロードします。

```zsh
% wget -O ./discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
```

`gdebi` commandを用いてDiscord debian packageをインストールします。

```zsh
% sudo gdebi ./discord.deb 
Reading package lists... Done
Building dependency tree        
Reading state information... Done
Reading state information... Done
Requires the installation of the following packages: gconf-service gconf-service-backend gconf2-common libappindicator1 libc++1 libc++1-10 libc++abi1-10 libdbusmenu-gtk4 libgconf-2-4 

Chat for Communities and Friends
 Discord is the easiest way to communicate over voice, video, and text. Chat,
 hang out, and stay close with your friends and communities.
Do you want to install the software package? [y/N]:y
```

これでインストールは完了。


## 4. Discordの機能紹介
### 二段階認証の設定

- User settingからに段階認証の設定ができます。
- PCの場合は、スマホでGoogle Authenticatorをインストールする必要があります。
- 二段階認証はSMSメッセージかBackupコード形式となります。

### フレンド登録

フレンド登録には「ユーザー名」と自動で発番される「ID:4桁の数字」が必要です。例として、

- ユーザー名：ゆーざー00
- ID：4500

とした場合、相手にフレンド登録してもらいたいときは以下の「フレンドコード」を伝えます。上のケースでは`ゆーざー00#4500`となります。

### コードブロック機能

- markdownと同じ記法でワンライナーや複数行のコードブロックが使えます。
- programming言語を指定すると自動的に言語に応じたハイライトもしてくれます

### 文字列の強調

文字列を強調するにあたって、

- italic
- bold
- italic bold
- Underline
- cross out
- 引用

を用いることができる。

|強調|構文|例|
|---|---|---|
|italic|`*italic*`|*italic*|
|bold|`**bold**`|**bold**|
|italic bold|`***italic bold***`|***italic bold***|
|underlined text|`__underlined text__`|__underlined text__|
|cross out|`~~cross out~~`|~~cross out~~|
|引用|`> test`||
|複数行引用|`>>> test`||

### メンション機能

Discordには「メンション」という機能があります。メンションは特定の相手に限定して通知を送る機能です。メンションには4種類あります。

#### 全体メンション:`@everyone`

サーバーに入室しているメンバー全員に通知を送ります。

####  オンラインメンション: `@here`

Discordを今現在開いているメンバーに通知を送ります。Discordを開いていないメンバーには通知は届きません。

####  役職メンション: `@役職`

指定の役職がついているメンバーにのみ通知を送ります。

####  個人メンション: `@個人名`

特定の個人に通知を送ります。

### Bot

- BotとはDiscordの機能を拡張できる存在です。その種類は様々で、ボイスチャットで音楽を流せるようになったり、荒らしに対するセキュリティを高める事が出来たりと、使いこなせばとても便利になります。Botはサーバー単位(Slackでいうworkspace)で追加することができます。
- Serverにbotを追加できるかは自分が保有するロールの権限次第となります。

## Appendix: パッケージ: gdebi-core (0.9.5.7+nmu4) 

`gdebi` を使うと、ローカルの deb パッケージをその依存関係を解決しながら インストールできます。apt は同じ動作をしますが、インストールできるのはリモート (http, ftp) にあるパッケージのみです。 debファイルをインストールする際、`dpkg`コマンドも用いますが、`gdebi`は便利な機能が付与された`dpkg`コマンドのフロントエンドです。

`dpkg`コマンドを用いてdebファイルをインストールする場合、まず依存関係にあるパッケージをインストールしてから、dpkg経由でインストールします

```
% sudo apt-get install -f # 依存関係の処理
% sudo dpkg -i <deb file> 
```

一方、`gdebi`コマンドはインストールと依存関係の解消を一つのコマンドで実行することができます。

```
% sudp gdebi <deb file> 
```

### `gdebi`コマンドが依存関係を解消する仕組み

`gdebi`は`dpkg` フロントエンドなので、`dpkg` のすべての機能を使うことができます。すべての `.deb` パッケージファイルには、その `deb` ファイルに関するメタデータ (パッケージ名、メンテナ、依存関係など) が含まれているので、このファイルの依存関係を簡単にチェックすることができます。例えば、 `dpkg`コマンドで依存関係を確認する場合は`dpkg --info package-name.deb`です。`gdebi`はこの情報を用いてdependency mapを作成し、ダウンロードしていないdependenciesをInternet経由でダウンロードします。