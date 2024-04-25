---
layout: post
title: "ビルトインコマンドの無効とfc command"
subtitle: "Shell Environement Set-up 3/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-23
tags:

- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [zshにおけるdisableコマンドとは？](#zsh%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Bdisable%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A8%E3%81%AF)
  - [名前の競合](#%E5%90%8D%E5%89%8D%E3%81%AE%E7%AB%B6%E5%90%88)
- [zsh built-in commandとしての`r`](#zsh-built-in-command%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AEr)
  - [ヒストリーの一部を置き換えて実行: `fc -e -`](#%E3%83%92%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%81%AE%E4%B8%80%E9%83%A8%E3%82%92%E7%BD%AE%E3%81%8D%E6%8F%9B%E3%81%88%E3%81%A6%E5%AE%9F%E8%A1%8C-fc--e--)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## zshにおけるdisableコマンドとは？

- `disable`コマンドは，`zsh`のビルトインコマンドを無効にするコマンド
- `bash`においては`enable -n`に相当する

```zsh
% disable [command]
```

再び有効化したい場合は，

```zsh
% enable [command]
```

### 名前の競合

統計処理用プログラミング言語 R をいれており, `% alias r=R` と事前に定義した場面を考えます.
このとき, `r`とCLIに入力するとRが立ち上がりますが，

```zsh
% disable r
```

と実施したあとでも, `r`とCLIに入力するとRが立ち上がります．zshには `r`というbuild-in commandが存在し, 
built-in commandの方を優先的にdisableしているためです.

- ビルトインコマンドと同じ名前の実行可能ファイル（外部コマンド）が存在する場合，コマンド名だけを指定して`disable`コマンドを実行した場合、ビルトインコマンドを優先する
- 外部コマンドを意識的に実行したい場合は，パス付きで指定する

## zsh built-in commandとしての`r`

- zshにおけるbuilt-in commandとしての`r`は直前のコマンドを再度実行する`fc -e -`コマンドと同義
- `!!`も`fc -e -`コマンドと同義
- `fc`はコマンドライン入力のヒストリーを編集して実行するコマンド
- ヒストリーを一覧表示したり，特定のヒストリーを表示したりすることもできる

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Example</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

`r`や`!!`は`fc -e -`コマンドと同義なので

```zsh
% echo kirby
kirby
% r
echo kirby
kirby
% !!
echo kirby
kirby
% fc -e -
echo kirby
kirby
```

となる．

</div>


### ヒストリーの一部を置き換えて実行: `fc -e -`

- `fc -e - 置換前=置換後`で「置換前」で指定した文字列を「置換後」で置き換えてから実行することができます

```zsh
# 対象一つだけを実行
% fc -e - 置換前=置換後 対象

# 対象開始から対象終了までの範囲を実行
% fc -e - 置換前=置換後 対象開始 対象終了
```

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Exmaple</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

<br>

```
24815  git init
24816  touch .gitignore
24817  code .gitignore
24818  mkdir sandbox
```

という履歴が存在するとします．`.gitignore`ではなくて`README.md`へ変更して実行したい場合

```zsh
% fc -e - .gitignore=README.md 24815 24818
```

とCLIに入力することでヒストリーの一部を以下のように置き換えて，カレントディレクトリにて連続実行することができます．

```zsh
git init
touch README.md
code README.md
mkdir sandbox
```

</div>



References
----------
- [zsh 17 Shell Builtin Commands](https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html)
- [【 fc 】コマンド――コマンドラインの履歴を編集して実行する、一覧表示する](https://atmarkit.itmedia.co.jp/ait/articles/1912/05/news042.html)
