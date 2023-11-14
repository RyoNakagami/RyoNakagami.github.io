---
layout: post
title: "Linux System Monitor - BPYTOPのインストール"
subtitle: "Ubuntu Desktop環境構築 Part 26"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-01-05
tags:

- Ubuntu 20.04 LTS
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. やりたいこと](#1-%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
- [2. リソースモニターとしてのBPYTOP](#2-%E3%83%AA%E3%82%BD%E3%83%BC%E3%82%B9%E3%83%A2%E3%83%8B%E3%82%BF%E3%83%BC%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AEbpytop)
- [3. Installation](#3-installation)
- [4. Terminatorでの表示設定](#4-terminator%E3%81%A7%E3%81%AE%E8%A1%A8%E7%A4%BA%E8%A8%AD%E5%AE%9A)
- [Appendix: ネットワークインターフェース](#appendix-%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%95%E3%82%A7%E3%83%BC%E3%82%B9)
  - [ネットワークインターフェースの命名規則](#%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%95%E3%82%A7%E3%83%BC%E3%82%B9%E3%81%AE%E5%91%BD%E5%90%8D%E8%A6%8F%E5%89%87)
- [Appendix: シェルスクリプトの`&&`の意味](#appendix-%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%AE%E3%81%AE%E6%84%8F%E5%91%B3)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 1. やりたいこと

- CPU, memory, diskの利用状況を逐次モニターできる環境にしたい
- process単位でのCPU, memory利用状況を確認できるようにしたい
- リソースの利用状況に合わせてprocess操作(`kill`コマンド)が可能なモニターが欲しい

> 実行環境

実行環境

|項目||
|---|---| 	 
|マシン| HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 32.0 GB|
|GPU| NVIDIA GeForce RTX 2060 SUPER|

```zsh
% lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.5 LTS
Release:        20.04
Codename:       focal
```

## 2. リソースモニターとしてのBPYTOP


<img src="https://github.com/aristocratos/bpytop/raw/master/Imgs/menu.png">

<img src="https://github.com/aristocratos/bpytop/raw/master/Imgs/main.png">

> Features

- Terminal Appの一種
- レイアウトの操作がキーボードでもマウスで実行可能
- processのソートがcpu usage, memory usage, pidなどでsort可能
- processの検索が `f + <search word>` で実行可能(キャンセルしたい場合は`esc`)
- process単位の詳細情報(tree情報, プログラムファイルetc)が確認可能
- process単位のkill, Terminate, Interrupt操作がマウスで実行可能
- network usage情報が確認可能

> 欠点

- CPU usageの時系列line plotが確認可能だが, x軸のtickが存在しない

> Remarks

- GitHub repositoryはpoetryでパッケージ管理されている

## 3. Installation

PyPiは本人がメンテしているけれども, メンテしなくなった時ちょっと怖いので Manual installation を今回は実施

> Dependencies 

- Python3
- git
- psutil(python module)

> Install

```zsh
git clone https://github.com/aristocratos/bpytop.git
cd bpytop
sudo make install
```

> Uninstall

```zsh
cd bpytop
sudo make uninstall
```

## 4. Terminatorでの表示設定

> 完成図

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/20210104_bpytop.png?raw=true">

> 設定

1. Terminatorを起動する
2. `Preference > Layout`で画面分割レイアウトを設定
3. 上記で設定したLayoutの`Custom command`に `source ~/.zshrc && bpytop`と設定
4. (任意) Ubuntuの`Startup Application Preference`で `terminator -l <Layout name>` と設定

## Appendix: ネットワークインターフェース

BPYTOPではネットワーク使用情報が確認できますが, どのネットワークインターフェース名がなにを表しているか理解する事が必要です.

### ネットワークインターフェースの命名規則

|種別|説明|例|
|---|---|---|
|`en`|イーサネット(有線LAN)|enp2s0|
|`wl`|無線LAN|wlp3s0|
|`ww`|無線WAN||

|デバイス|説明|
|---|---|
|オンボードデバイス|o<インデックス>|
|ホットプラグデバイス|s<スロット>|
|PCIデバイス|p<バス>s<スロット>|

ネットワークインターフェースの一覧の確認は, 次のコマンドで可能です

```zsh
% ls /sys/class/net
enp2s0@  lo@  wlp3s0@
```


## Appendix: シェルスクリプトの`&&`の意味

> 基本ルール

```zsh
% command1; command2   #command1が成功/異常終了にかかわらず, 終了後command2を実行
% command1 && command2 #command1が成功したらcommand2を実行
% command1 || command2 #command1が異常終了したらcommand2を実行
```

> 三項演算

```zsh
% true && true || echo "Command Failed"

% true && false || echo "Command Failed"
Command Failed
% false && true || echo "Command Failed"
Command Failed
% false && false || echo "Command Failed"
Command Failed
% true || echo "foo" && echo "boo" 
boo
% false || echo "foo" && echo "boo"
foo
boo
```


## References

> BPYTOP

- [GitHub >  aristocratos/bpytop](https://github.com/aristocratos/bpytop)
- [Youtube > STUNNING Linux System Monitor - btop++](https://www.youtube.com/watch?v=YmzBJmpFMpw&t=12s)

> && in a shell command

- [stackoverflow > What is the purpose of "&&" in a shell command?](https://stackoverflow.com/questions/4510640/what-is-the-purpose-of-in-a-shell-command)