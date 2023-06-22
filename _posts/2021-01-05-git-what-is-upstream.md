---
layout: post
title: "Why Do We Set Upstream Branch and What is it?"
subtitle: "How to use git command 6/N"
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
- [Why Do We set upstream branches?](#why-do-we-set-upstream-branches)
  - [引数の省略](#%E5%BC%95%E6%95%B0%E3%81%AE%E7%9C%81%E7%95%A5)
  - [非同期commitの確認: `git status`](#%E9%9D%9E%E5%90%8C%E6%9C%9Fcommit%E3%81%AE%E7%A2%BA%E8%AA%8D-git-status)
  - [unpushed local commitの詳細確認: `git log`](#unpushed-local-commit%E3%81%AE%E8%A9%B3%E7%B4%B0%E7%A2%BA%E8%AA%8D-git-log)
- [Check the Upstream Branch](#check-the-upstream-branch)
- [Set up/unset an upstream branch to a local branch](#set-upunset-an-upstream-branch-to-a-local-branch)
  - [新しくremote branchを作成し, そのブランチをupstream branchとしたい場合](#%E6%96%B0%E3%81%97%E3%81%8Fremote-branch%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97-%E3%81%9D%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%82%92upstream-branch%E3%81%A8%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
  - [すでにremote branchが存在している場合](#%E3%81%99%E3%81%A7%E3%81%ABremote-branch%E3%81%8C%E5%AD%98%E5%9C%A8%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E5%A0%B4%E5%90%88)
  - [unset an upstream branch](#unset-an-upstream-branch)
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


## Why Do We set upstream branches?
### 引数の省略
一度, local repositoryに対してupstream branchが設定されると, git push, git pull, git fetch のときにrepositoryとbranchの
引数を省略することが出来ます.

```zsh
# Push the current branch to the branch upstream
% git push 

# Pull the branch upstream to the current branch
% git pull

# Fetch the branch upstream to the current branch
% git fetch
```

### 非同期commitの確認: `git status`

- upstream branchが設定されていると, 現在のlocal branchがremote branchに対してどのくらいの非同期commitがあるか`git status`が表示してくれる
- `behind`ならばremoteの方が進んでいる
- `ahead`ならばlocalの方が進んでおり, pushしたほうが良い

```zsh
% git status
On branch hoge
Your branch is behind 'origin/hoge' by 2 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
```

### unpushed local commitの詳細確認: `git log`

- upstreamへpushされていないlocal commitのhash値の確認が可能
- `--stat` optionを付与することで, 変更ファイルもterminal上から確認することができる
- `.gitconfig`にaliasとして登録することが推奨

> syntax

```
% git log <tracking-remote>..<local branch>
```

> upstreamとの差分を確認したい場合

以下のことも同時に知りたいので, `--stat`, `--abbrev-comit` optionを付与していつも実行しています

- commit毎の差分ファイルを確認したい
- 実行日を知りたい
- commit hash idはshort versionにしたい

```zsh
% git log --stat --abbrev-comit @{upstream}..HEAD
```


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

## Set up/unset an upstream branch to a local branch
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


### unset an upstream branch

リモートブランチの追跡を解除したい場合は以下のコマンドを実行すると, 現在のbranchに対してupstream branchが解除される:

```zsh
% git branch --unset-upstream
```



## Tips
### Set up a shortcut command by ussing a git alias

> What I Want

- 毎回, `git push -u origin HEAD`と入力するのが面倒なので `git up-push`というコマンドで代替させたい.
- `git log --stat --abbrev-commit @{upstream}..HEAD`を`git ls-unpush`というコマンドで代替させたい

> How

`~/.gitconfig`に対して以下のように指定

```zsh
[alias]
	up-push = "push -u origin HEAD"
	ls-unpush = "log --stat --abbrev-commit @{upstream}..HEAD"
```


## Refernces

> General

- [GeeksforGeeks > How to Set Upstream Branch on Git?](https://www.geeksforgeeks.org/how-to-set-upstream-branch-on-git/)
