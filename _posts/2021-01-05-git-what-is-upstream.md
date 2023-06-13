---
layout: post
title: "Why Do We Set Upstream Branch and What is it?"
subtitle: "How to use git command 5/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
revise_date: 2023-06-13
tags:

- git
- GitHub
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What are upstream branches?](#what-are-upstream-branches)
- [Check the Upstream Branch](#check-the-upstream-branch)
- [Set up an upstream branch to a local branch](#set-up-an-upstream-branch-to-a-local-branch)
  - [新しくremote branchを作成し, そのブランチをupstream branchとしたい場合](#%E6%96%B0%E3%81%97%E3%81%8Fremote-branch%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97-%E3%81%9D%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%82%92upstream-branch%E3%81%A8%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [すでにremote branchが存在している場合](#%E3%81%99%E3%81%A7%E3%81%ABremote-branch%E3%81%8C%E5%AD%98%E5%9C%A8%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E5%A0%B4%E5%90%88)
- [Tips](#tips)
  - [Set up a shortcut command by ussing a git alias](#set-up-a-shortcut-command-by-ussing-a-git-alias)
- [Refernces](#refernces)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## What are upstream branches?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Upstream branch</ins></p>

- Upstream branchとは, local branchが履歴を追跡するように設定したremote branchのこと
- git fetch/git pullを引数なしで実行した際に, どのremote branchに対してpull/fetchを実行すべきかを認識させる効果がある
- remote tracking branch(ローカル上で`origin/hoge`のように表示されるbranch)とは別概念

</div>

Tracking branchesとは, remote branch と直接的な関係を持つlocal branchのこと. 例として, 新たにrepositoryをGitHub上で作成し, それをローカルへcloneした際,
ローカル上に`main` branchが作成されますが, その`main` branchはremote tracking branchとしての`origin/master`をトラックしています.

## Check the Upstream Branch

> What I Want

- local repositoryとupstream branchの対応関係を知りたい

> How

```zsh
% git branch -vv
branch_A            214c991 [origin/branch_A: ahead 1, behind 3] FIX readme
  branch_B            a387619 [origin/non_existing_branch] add yml
  hoge                f5663c5 [origin/hoge] hoge test
* hoge2               4a1e30f Update hoge2.txt
  hoge3               376ef7c [origin/hoeg3: gone] add hoge
  main                16a340c [origin/main] a
  non_existing_branch a387619 [origin/non_existing_branch] add yml
```

- 対応していないブランチ(上では`hoge2`)では `[origin/<remote branch name>]`が出力されない

## Set up an upstream branch to a local branch
### 新しくremote branchを作成し, そのブランチをupstream branchとしたい場合

HEADを`git push`することは, 現在のブランチと同じ名前を持つリモートブランチにプッシュすることなので,
そのコマンドに`-u` または `--set-upstream` を実行するだけでOk

```zsh
% git push -u origin HEAD
```


### すでにremote branchが存在している場合

> What I Want

- upstream branchが設定されていないlocal branchに対して, upstream branchを指定したい

> How

```zsh
% git branch -u <remote branch>
% git branch <local branch> -u <remote branch>
```

- `<local branch>`を省略した場合は, 現在のbranchに対してupstream branchを設定する



## Tips
### Set up a shortcut command by ussing a git alias

> What I Want

- 毎回, `git push -u origin HEAD`と入力するのが面倒なので `git uppush`というコマンドで代替させたい.

> How

`~/.gitconfig`に対して以下のように指定

```
[alias]
	uppush = "push -u origin HEAD"
```


## Refernces

> General

- [GeeksforGeeks > How to Set Upstream Branch on Git?](https://www.geeksforgeeks.org/how-to-set-upstream-branch-on-git/)
