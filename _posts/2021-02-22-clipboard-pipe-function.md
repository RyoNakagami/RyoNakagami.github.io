---
layout: post
title: "Pipe to/from the clipboard with shell script"
subtitle: "Shell Environement Set-up 4/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-07-06
tags:

- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What I Want to Do](#what-i-want-to-do)
- [Soluition](#soluition)
- [使用例](#%E4%BD%BF%E7%94%A8%E4%BE%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What I Want to Do

<strong > &#9654;&nbsp; 環境</strong>

```zsh
% lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.4 LTS
Release:	22.04
Codename:	jammy
```

<br>

<strong > &#9654;&nbsp; Describe Features</strong>

- Linux(Ubuntu)環境において，clipboardの中身を標準出力する
- 標準出力で受け取った内容をclipboardへ格納する

<br>

<strong > &#9654;&nbsp; 挙動のイメージ</strong>

clipboardの内容を標準出力する場合，`I am Hoshino Kirby`という文字列を`ctrl + c`でクリップボードへコピーした場合

```zsh
% fetchclip
I am Hoshino Kirby
```

`I am Hoshino Kirby`というラインで構成される`test.txt`を開いた場合，パイプを用いいてその内容をclipboardへ格納する

```zsh
% cat test.txt
I am Hoshino Kirby

% cat test.txt | setclip
% fetchclip
I am Hoshino Kirby
```


## Soluition

<strong > &#9654;&nbsp; Dependency</strong>

Ubuntuを用いてる場合，X Windows primary clipboardを用いてクリップボード経由のコピーやペーストを実行するのが
一般的です．X Windows clipboard用のコマンドとして `xclip` コマンドがあるので以下のコマンドでインストールします．

```zsh
% sudo apt install xclip
```

なお，MacOSを利用している場合は`pbcopy`などのコマンドを利用することになります．

<strong > &#9654;&nbsp; Set-up</strong>

```zsh
alias fetchclip='xclip -out -selection clipboard'
alias setclip='xclip -selection clipboard'
```

## 使用例

<strong > &#9654;&nbsp; クリップボードにコピーした内容をdrop-duplicateする</strong>

```
PRIMARY
PRIMARY
SECONDARY
PRIMARY

CLIPBOARD

SECONDARY
CLIPBOARD

PRIMARY
```

というテキストデータがあるとします．これをクリップボードにコピーして, 順番無視で重複を削除したい場合は以下のような処理をします

```zsh
% fetchclip | sort | uniq       

CLIPBOARD
PRIMARY
SECONDARY
```

出現順番は変わってしまいますが，uniq sortは実施可能です. Empty lineを削除したい場合は

```zsh
% fetchclip | sort | uniq | sed '/^$/d' 
CLIPBOARD
PRIMARY
SECONDARY
```


References
----------
- [stack overflow > Pipe to/from the clipboard in a Bash script](https://stackoverflow.com/questions/749544/pipe-to-from-the-clipboard-in-a-bash-script)
- [StackExchange > How to remove empty/blank lines from a file in Unix (including spaces)?](https://serverfault.com/questions/252921/how-to-remove-empty-blank-lines-from-a-file-in-unix-including-spaces)
