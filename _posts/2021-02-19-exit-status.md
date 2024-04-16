---
layout: post
title: "シェルにおけるPOSIX準拠の終了ステータス"
subtitle: "shell script preprocess 4/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-16
tags:

- Shell

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [POSIX準拠における終了ステータス](#posix%E6%BA%96%E6%8B%A0%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E7%B5%82%E4%BA%86%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9)
  - [コマンド終了値を格納したシェル変数](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E7%B5%82%E4%BA%86%E5%80%A4%E3%82%92%E6%A0%BC%E7%B4%8D%E3%81%97%E3%81%9F%E3%82%B7%E3%82%A7%E3%83%AB%E5%A4%89%E6%95%B0)
  - [exit statusを活用したコマンドのつなぎ方](#exit-status%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%97%E3%81%9F%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E3%81%A4%E3%81%AA%E3%81%8E%E6%96%B9)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## POSIX準拠における終了ステータス

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: POSIX</ins></p>

- POSIX (Portable Operating System Interface) は, UNIX 系 OS 間でアプリケーションの移植性/互換性を高めるために定義された IEEE の標準規格
- POSIXではコマンド成功の場合は 0, 失敗の場合は 1 ~ 255 のいずれかの値を返すと定めている

</div>

POSIX準拠とは, OSやアプリケーションがPOSIX標準の要件を満たしていることを意味します. 
Linuxコマンドのうち, POSIX準拠しているものは

- コマンド成功の場合は 0
- 失敗の場合は 1 ~ 255 のいずれか

というステータス値を返す挙動をします. どのようなexit statusが具体的に設定されているかは `man` コマンドで確認する必要があります.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >lsコマンドのexit status</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

`man ls`でExit statusを調べると以下のように定義されています.

```
   Exit status:
       0      if OK,

       1      if minor problems (e.g., cannot access subdirectory),

       2      if serious trouble (e.g., cannot access command-line argument).
```

</div>


### コマンド終了値を格納したシェル変数

|シェル変数|利用可能なシェル|
|--------|--------------|
|`$?`|bash, zsh|
|`$status`|zsh, csh|

`$?`や`$status`は直前のコマンドのexitステータスを格納しています.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >zshにおける実行例</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

zshにおける実行例は以下:

```zsh
% false
% echo $?
1

% false
% echo $status
1

% true
% echo $?
0
```

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >bashにおける実行例</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

bashにおける実行例は以下:

```bash
$ false
$ echo $?
1

# シェル変数として定義されていないので何も返さない
$ false
$ echo $status

$ true
$ echo $?
0
```

</div>

### exit statusを活用したコマンドのつなぎ方

コマンドを連続実行する際,

|制御演算子|説明|
|---|---|
|`;`| exit status関係なく実行|
|`&&`| 直前のコマンドのexit statusが0なら実行|
|`\|\|`| 直前のコマンドのexit statusが0以外なら実行|

を利用して, コマンドをつないだりします. これはリダイレクションやパイプとは別概念であることに注意してください。

```zsh
% true && echo 'phase 1' || echo 'phase 2' 
phase 1

% false && echo 'phase 1' || echo 'phase 2' 
phase 2

% false ; false && echo 'phase 1' || echo 'phase 2' ; echo 'phase 3'
phase 2
phase 3

% false ; true && echo 'phase 1' || echo 'phase 2' ; echo 'phase 3'
phase 1
phase 3
```

なお注意点としては, `&` 単体ではバックグラウンド実行を意味するので入力ミスには気をつけてください.
