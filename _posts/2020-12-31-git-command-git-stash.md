---
layout: post
title: "git stash: 作業途中内容を退避する"
subtitle: "How to use git command 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-07-11
tags:

- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`git stash`とは？](#git-stash%E3%81%A8%E3%81%AF)
- [How to use `git stash`](#how-to-use-git-stash)
  - [git stash untacked file](#git-stash-untacked-file)
- [How to use `git stash drop`](#how-to-use-git-stash-drop)
  - [引数なしでの実行](#%E5%BC%95%E6%95%B0%E3%81%AA%E3%81%97%E3%81%A7%E3%81%AE%E5%AE%9F%E8%A1%8C)
  - [複数stashのdrop: 連続index版](#%E8%A4%87%E6%95%B0stash%E3%81%AEdrop-%E9%80%A3%E7%B6%9Aindex%E7%89%88)
- [`git stash`のユースケース](#git-stash%E3%81%AE%E3%83%A6%E3%83%BC%E3%82%B9%E3%82%B1%E3%83%BC%E3%82%B9)
  - [誤って別ブランチにコミットしてしまった場合](#%E8%AA%A4%E3%81%A3%E3%81%A6%E5%88%A5%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AB%E3%82%B3%E3%83%9F%E3%83%83%E3%83%88%E3%81%97%E3%81%A6%E3%81%97%E3%81%BE%E3%81%A3%E3%81%9F%E5%A0%B4%E5%90%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## `git stash`とは？

`git stash`は現在焼いている途中の肉を皿に退避させて，網を交換（=交換という別作業）をする際に使うコマンドです． 
より正確には「現在焼いている途中の肉を皿に退避させて」というアクションを実行するのが`git stash`に相当します．

<strong > &#9654;&nbsp; git stashの活用場面</strong>


- gitでtrackされているファイルについて現在作業している
- このとき, trackされているファイルについてcommitすることなくbranchを変えることはできない
  - working directory, staging areaどちらについても当てはまる
- 突然, HOTFIX対応の命令が上司からやってきて, 作業branchを変える必要が出てきた
- 現在の作業内容は躊躇半端なためcommitはしたくない
- かといって, 現在の作業内容を破棄したくはない

このようなシチュエーションのときに，`git stash`することで，working areaの現在の内容をcommitすることなく保存してbranch切り替えができるようになります. `git stash` = 一時保存，のコマンドと理解できます．

> Stashing is handy if you need to quickly switch context and work on something else but you're mid-way through a code change and aren't quite ready to commit


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

### 複数stashのdrop: 連続index版

以下の状況を例とします

```zsh
% git stash list
stash@{0}: WIP on main: 1234567 first commit
stash@{1}: WIP on main: 1234568 update css
stash@{2}: WIP on main: 1234569 update css.min
stash@{3}: WIP on main: 1234569 update css.min
stash@{4}: WIP on main: 1234571 update README.md
```

このとき，`1~3`の連続indexのstashをdropしたい場合は, 

```bash
START_INDEX=1
END_INDEX=3

for i in $(seq $END_INDEX -1 $START_INDEX); do
        git stash drop stash@{$i}
    done
```

とします．`git stash drop`をするたびにindexが変化してしまうため，複数indexを対象に
stash dropする場合は最新のindex(=index番号が大きい)からdropすることが良いと思います．


## `git stash`のユースケース
### 誤って別ブランチにコミットしてしまった場合

<strong > &#9654;&nbsp; 問題設定</strong>

```zsh
% % git branch
* main
```

という状況で，`touch test_kerneldensity.py`というファイルを作成してstaged & commitしたとします．
commitしたあとで `test_kerneldensity.py` ファイルは `main`ブランチではなくて `unit_test`ブランチを新規に作成し，そのブランチに対してcommitしたかったことに気づいたケースを想定します．

つまり，

- 新規に作成したファイルを誤ったブランチにcommitしてしまったので，そのブランチをクリーンにしたい
- 新規に作成したファイルを新しいブランチにcommitしたい

の２つのアクションが必要となります．

<strong > &#9654;&nbsp; Solution</strong>

```zsh
# main branchをclean + 新規作成ファイルを退避
% git reset HEAD~ --soft
% git stash

# 正しいブランチへ移動
% git switch -c unit_test
% git stash pop
% git add . # or add individual files
% git commit -m "TEST: add kerneldensity test file";

# 修正完了
```




References
----------

- [git > git-stash - Stash the changes in a dirty working directory away](https://git-scm.com/docs/git-stash)