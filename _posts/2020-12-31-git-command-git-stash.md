---
layout: post
title: "git stash: 作業途中内容を退避する"
subtitle: "How to use git command 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-08-01
tags:

- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`git stash`とは？](#git-stash%E3%81%A8%E3%81%AF)
  - [いつ使うのか？](#%E3%81%84%E3%81%A4%E4%BD%BF%E3%81%86%E3%81%AE%E3%81%8B)
  - [Syntax](#syntax)
- [How to use `git stash`](#how-to-use-git-stash)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## `git stash`とは？

`git stash`は現在焼いている途中の肉を皿に退避させて，網を交換（=交換という別作業）をする際に使うコマンドです． 
より正確には「現在焼いている途中の肉を皿に退避させて」というアクションを実行するのが`git stash`に相当します．

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>git stashのユースケース</ins></p>

- gitでtrackされているファイルについて現在作業している
- このとき, trackされているファイルについてcommitすることなくbranchを変えることはできない
  - working directory, staging areaどちらについても当てはまる
- 突然, HOTFIX対応の命令が上司からやってきて, 作業branchを変える必要が出てきた
- 現在の作業内容は躊躇半端なためcommitはしたくない
- かといって, 現在の作業内容を破棄したくはない

このようなシチュエーションのときに，`git stash`することで，working areaの現在の内容をcommitすることなく保存してbranch切り替えができるようになります. `git stash` = 一時保存，のコマンドと理解できます．

> Stashing is handy if you need to quickly switch context and work on something else but you're mid-way through a code change and aren't quite ready to commit

</div>

### コマンド一覧

|コマンド|説明|
|----|----|
|`git stash`|作業を退避させたい場合|
|`git stash -u`|untracked fileについても作業を退避させたい場合|
|`git stash --include-untracked`|untracked fileについても作業を退避させたい場合|
|`git stash save <message>`|コメント付きで作業を退避させたい場合|
|`git stash list`|退避した作業一覧の取得|
|`git stash list -p`|退避した作業一覧を差分箇所とともに表示|
|`git stash show`|直近のstashと現在の状態のdiffの確認|
|`git stash branch <branch name> <stash_id>`|指定したstashに基づいたbranchの作成|
|`git stash pop`|最新のstashをrestore & stash listからrestoreしたstashを削除する|
|`git stash apply`|最新のstashをrestore & stash listからrestoreしたstashを削除しない|
|`git stash drop `|最新のstashを削除|
|`git stash drop stash@{index}`|退避した作業の１つを削除|
|`git stash clear`|退避した作業すべての削除|

## How to use `git stash`
### git stash untacked file

untracked fileはデフォルトではな`git stash`することができません. 
untacked fileも含めて`git stash`する場合はoptionを付与して以下のいずれかを実行します

```zsh
## short option
% git stash -u

## long option
% git stash --include-untracked
```



## How to use `git stash drop`
### 引数なしでの実行

```zsh
% git stash drop
```

と引数なしで実行すると, 直近のstashが削除されます.

### 複数stashのdrop

連続indexのstashをdropしたい場合は, 







## References

> 公式ドキュメント

- [git > git-stash - Stash the changes in a dirty working directory away](https://git-scm.com/docs/git-stash)