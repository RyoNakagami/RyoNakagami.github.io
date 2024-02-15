---
layout: post
title: "fcitx5-mozcを用いた日本語入力設定"
subtitle: "Ubuntu Jammy Jellyfish Setup 1/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-01-30
header-mask: 0.0
header-style: text
tags:

- Ubuntu 22.04 LTS
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [日本語入力環境](#%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%85%A5%E5%8A%9B%E7%92%B0%E5%A2%83)
  - [ibus-mozc v.s. fcitx5-mozc](#ibus-mozc-vs-fcitx5-mozc)
- [Fcitx 5のインストールと設定](#fcitx-5%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%A8%E8%A8%AD%E5%AE%9A)
  - [`im-config`コマンド](#im-config%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [Input Sourcesで上手くmozc-jpが表示できない場合](#input-sources%E3%81%A7%E4%B8%8A%E6%89%8B%E3%81%8Fmozc-jp%E3%81%8C%E8%A1%A8%E7%A4%BA%E3%81%A7%E3%81%8D%E3%81%AA%E3%81%84%E5%A0%B4%E5%90%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>今回の設定の前提環境</ins></p>

---|---
OS|Ubuntu 22.04 LTS (Jammy Jellyfish)
Keyboard|US keyboard

</div>

## 日本語入力環境

Ubuntuで日本語入力を可能にするには, 

- インプットメソッドフレームワーク
- そのフレームワークに対応した日本語入力システム（インプットメソッド）

の２つが必要です. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: インプットメソッドとインプットメソッドフレームワーク</ins></p>

- **インプットメソッド**(IMEと略される)とは, パソコンなどのコンピュータ上で文字を入力するためのソフトウエアのこと. 日本語入力に対応したインプットメソッドの例として, MozcやAnthyがある.
- **インプットメソッドフレームワーク**(IMFと略される)とは, インプットメソッドと他のアプリケーションを結び付けるための機能やライブラリを含んでいるソフトウエアのこと. 例として, IBus, Fcitx, Fcitx5がある. 

</div>

IMEとは, 日本語などの非ラテン文字を入力するために, ラテン文字を使えるようにするアプリケーションのことと理解できます. 今回はMozcを利用しますが, Mozcは米Google社が開発した「Google日本語入力」のオープンソース版です. 

### ibus-mozc v.s. fcitx5-mozc

Linuxの日本語入力環境としてibus-mozcとfcitx5-mozcがメジャーなパッケージです. ユーザー目線での大きな違いは

- ibus-mozc: 半角／全角キー押下による日本語入力状態が全てのアプリケーションWindowに適用される
- fcitx5-mozc: 各アプリケーションwindow単位で日本語入力のon/offができる

Fcitx 5はWaylandセッションで使用することを主眼に置いて開発されている特徴もあります. 古いversionとしてFcitxがありますが
今後はMozcを利用するならばFcitx 5を使用することが推奨されます.

## Fcitx 5のインストールと設定

Fcitx5をインストールしIMFを設定するためのコマンドは以下です:

```zsh
% sudo apt install fcitx5-mozc
% im-config -n fcitx5
% reboot #実行後の再起動が必要
```

その後, `Settings > Keyboard > Input Sorces`で`mozc-jp`を指定すれば日本語入力環境設定は完了です.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/20230812_japanese_setting.png?raw=true">    

### `im-config`コマンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>im-config コマンド</ins></p>

im-config - set up input method framework configuration

</div>

利用可能なIMFを調べる場合は`-l`オプションを用います.

```zsh
% im-config -l
 ibus fcitx5 xim
```

上で用いた`-n`オプションはIMFを設定するコマンドです

```zsh
% im-config -n fcitx5
```

ではfcitx5を指定しています. 設定が適切に出来ているかを確認するには`-m`optionを用います.

```zsh
% im-config -m       
fcitx5      # active configuration (system)
fcitx5      # active configuration (user)
ibus        # automatic configuration for the current locale
            # override configuration for the current locale
ibus        # automatic configuration for most locales
```

### Input Sourcesで上手くmozc-jpが表示できない場合

念の為, 不要なInput Methodを削除することで解決できる可能性があります.

```zsh
% sudo apt remove ibus
% sudo apt remove -y ibus-mozc
% sudo apt remove -y ibus-table
% sudo apt remove -y ibus-gtk
% sudo apt remove -y ibus-gtk3
% sudo apt remove -y ibus-gtk4
```

他にもインストールされている可能性がありますが, 一覧を確認したい場合は`apt list --installed | grep "ibus"`
コマンドで確かめられます. それでも解決できない場合は, `Fcitx5 Configuration`を立ち上げ直接 `Mozc` を指定することで解決できます.



References
----------
- [金子邦彦研究室 ▶ インストール -> Ubuntu, WSL2 ▶ Ubuntu で日本語インプット・メソッドの設定](https://www.kkaneko.jp/tools/server/gnome_ja_input_method.html)
- [Linuxの日本語入力環境　ibus-mozc v.s. fcitx-mozc：基本中の基本・・ibus-mozcとfcitx-mozcの徹底的な違いって何？](https://www.linux-setting.tokyo/2023/04/linuxibus-mozc-vs-fcitx-mozcibus.html)
