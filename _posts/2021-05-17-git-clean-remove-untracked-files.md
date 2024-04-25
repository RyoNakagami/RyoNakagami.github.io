---
layout: post
title: "git clean: untracked filesを削除する"
subtitle: "How to use git command 17/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-24
tags:

- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`git clean`とは？](#git-clean%E3%81%A8%E3%81%AF)
  - [`-e`オプションと正規表現](#-e%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%A8%E6%AD%A3%E8%A6%8F%E8%A1%A8%E7%8F%BE)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## `git clean`とは？

- `git clean`コマンドは作業ツリー(working tree)からトラッキングされていないファイルを削除するコマンド
- バージョン管理されていないすべてのファイルを現在のディレクトリから下位のディレクトリ構造にまで削除
- untrackedのディレクトリは，`-d` オプションを指定しない限り，そのまま残される
- `.gitignore`ファイルでこれらのファイルが指定されてファイルは削除されない

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >options</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

|options|説明|
|----|----|
|`-x`|(gitginoreの対象になる)ignored filesも削除する|
|`-X`|(gitginoreの対象になる)ignored filesだけを削除する|
|`-d`|untracked directoryも削除する|
|`--dry-run`, `-n`|ドライラン|
|`-e, --exclude <pattern>`|指定した`<pattern>`を`git clean`の対象外にする|

</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#ffa657; background-color:#F8F8F8'>
<strong style="color:#ffa657">警告 !</strong>絶対--dry-runを最初に行うこと<br> 

- `git clean`コマンドは修復不可能な結果をもたらします
- 実施前には`git clean -n`や`git clean --drey-run`を実行してどのファイルが削除されるか事前にチェックすること

</div>

### `-e`オプションと正規表現

git trackされたレポジトリ構成が以下のようになっているとします．

```zsh
.
├── .gitignore
├── 00.txt
├── 01.txt
├── 02.txt
├── 03.txt
├── 04.txt
├── 05.txt
├── 06.txt
├── 07.txt
├── 08.txt
├── 09.txt
├── 10.txt
└── README.md
```

このとき，`README.md`以外はまだ`untracked files`の状態であるとします．

`-e`オプションはダブルクォートで囲むと，除外対象を簡易的な正規表現を用いて指定することができます．

```zsh
% git clean -n -e "*gitignore" -e "0[0-5].txt"
Would remove 06.txt
Would remove 07.txt
Would remove 08.txt
Would remove 09.txt
Would remove 10.txt
```

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >Tips</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

- `*`: ワイルドカード
- `[0-9]`: 0~9までの数字，`[A-Z]`のように応用可能
- `\d`，`\w`などの数字クラスは用いることができない

</div>

References
----------
- [git 公式ドキュメント > git clean](https://www.git-scm.com/docs/git-clean/2.22.0)
- [Chapter 17. Tips, Tricks, and Techniques](https://learning.oreilly.com/library/view/version-control-with/9781492091189/ch17.html#sec-tipstricks-cleaning-up)