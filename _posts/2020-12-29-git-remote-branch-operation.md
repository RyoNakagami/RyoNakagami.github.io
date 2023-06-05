---
layout: post
title: "git commandを用いたブランチ操作"
subtitle: "How to use git command 1/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
revise_date: 2023-05-29
tags:

- git
- GitHub
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>


<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Local Branch Operation](#local-branch-operation)
  - [List up Repository Branches](#list-up-repository-branches)
  - [Switch/Create Branch Locally](#switchcreate-branch-locally)
  - [Get/Switch to a remote branch](#getswitch-to-a-remote-branch)
  - [Create a New Branch Locally from a Specified Branch](#create-a-new-branch-locally-from-a-specified-branch)
  - [Rename a Local Branch Name](#rename-a-local-branch-name)
  - [Delete a Local Branch](#delete-a-local-branch)
  - [Check the Parent Branch](#check-the-parent-branch)
- [Remote Branch Operation](#remote-branch-operation)
  - [Delete Remote Branch](#delete-remote-branch)
  - [Rename Remote Branch](#rename-remote-branch)
- [Remote Branch Operation: `git clone`](#remote-branch-operation-git-clone)
  - [特定のフォルダにクローンを作成](#%E7%89%B9%E5%AE%9A%E3%81%AE%E3%83%95%E3%82%A9%E3%83%AB%E3%83%80%E3%81%AB%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%B3%E3%82%92%E4%BD%9C%E6%88%90)
  - [特定のブランチのみをローカルにcloneする](#%E7%89%B9%E5%AE%9A%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AE%E3%81%BF%E3%82%92%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%81%ABclone%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Local Branch Operation
### List up Repository Branches

> Local Branch一覧の取得

```zsh
% git branch
  develop
  feature_add_cross_validation
* feature_add_visualize_module
  main
```

> Remote Branch一覧の表示

- `origin/HEAD`は `clone` した後に作業ディレクトリにチェックアウトするブランチを示したもの
- `git clone`後のGitHub のデフォルトのブランチの最新位置に基本的に出現する

```
% git branch -r
  origin/HEAD -> origin/main
  origin/develop
  origin/add_cross_validation
  origin/add_visualize_module
  origin/main
  origin/project/ad_hoc_analysis
```

> Local/Remote Branch一覧の表示

```zsh
% git branch -a
  develop
  feature_add_cross_validation
* feature_add_visualize_module
  main
  origin/HEAD -> origin/main
  origin/develop
  origin/add_cross_validation
  origin/add_visualize_module
  origin/main
  origin
```

### Switch/Create Branch Locally

- ブランチ移動は`git switch`コマンドを用いる
- `git checkout`でも可能だが, 公式は `git switch` 推奨
- ブランチ作成 & 移動したい場合は `-c` オプションを加える

```zsh
% git switch existing_branch
Switched to branch 'existing_branch'
% git switch -c non_existing_branch
Switched to a new branch 'non_existing_branch'
```

> 作成されていないブランチを指定しまった場合

```zsh
% git switch test
fatal: invalid reference: test
```

> 作成済みのブランチ名を指定して`git switch -c`の場合

```zsh
% git switch -c non_existing_branch
fatal: a branch named 'non_existing_branch' already exists
```

### Create a New Branch Locally from a Specified Branch

> Syntax

```zsh
% git switch -c <new branch> <rerefence branch>
```

- `<rerefence branch>`はremote branchも指定可能


> Example

```zsh
% git switch -c foo2 foo
Switched to a new branch 'foo2'
% git switch -c hoge2 origin/hoge
branch 'hoge2' set up to track 'origin/hoge'.
Switched to a new branch 'hoge2'
```

### Rename a Local Branch Name

`git branch`コマンドと `-m` オプションを用いてブランチ名を変更することが出来ます.

```zsh
% git branch -m <new_branch_name>
```

### Delete a Local Branch

```zsh
% git branch --delete non-existing-branch # git branch -d <branch> is also ok
Deleted branch non-existing-branch (was 1d6ed41).
```


### Check the Parent Branch

> What I Want

- カレントブランチの親ブランチ名を取得する

> Setup

`.gitconfig`ファイルにてエイリアスを以下のように設定

```zsh
[alias]
	parent = "!git show-branch  -a| grep -v `git rev-parse --abbrev-ref HEAD`| head -n1| sed 's/.*\\[\\(.*\\)\\].*/\\1/'| sed 's/[\\^~].*//' #"
```

- `!`はシェルコマンドを入力しますよ, という指示語


> How to Use it

- `develop`ブランチから派生した`feature_model`ブランチに現在いるとする
- `feature_model`ブランチの親ブランチとして`develop`ブランチ名が出力されてほしい

```zsh
% git branch
  develop
  feature_cv
* feature_model
  main
% git parent
develop
```

## Remote Branch Operation
### Get/Switch to a remote branch: `git switch` version

> What I Want to Do

- リモートブランチ(`project/adhoc_analysis`)をローカルにチェックアウトしたい

> How

1. リモートの追跡ブランチを更新
2. `git switch` (リモート側にすでにブランチが存在するので`-c`は必要なし)

```zsh
% git branch -r
  origin/HEAD -> origin/main
  origin/develop
  origin/add_cross_validation
  origin/add_visualize_module
  origin/main
  origin/project/ad_hoc_analysis
% git fetch --all
% git switch project/adhoc_analysis
```

> REMARKS

- 内部的にLocal側に新しくリモートと同じブランチ名のブランチが作成, からのswitchとなる


### Get/Switch to a remote branch: `git fetch` version

> What I Want to Do

- リモートブランチ(`project/adhoc_analysis`)をローカルにbranch nameを指定して取り込みたい

> How

```zsh
% git fetch <remote> <remote-branchname>:<local-branchname>
```



### Delete Remote Branch

```zsh
% git push <remote> --delete <branch>
## 同義
% git push <remote> :<old_branch_name>
```

- コロン(=`:`)の前に何も指定しないことで,「空」をpushするという挙動になる

### Rename Remote Branch

> Syntax

```zsh
% git switch -c <new_branch_name> <old_branch_name>
% git push <remote> :<old_branch_name> <new_branch_name>
```

> REMARKS

- branchのrenameというよりかは, ローカルで別名で作った同一内容ブランチをremoteへ反映し直すという挙動
- remote branchの消去と新しいbranchのpushを同時に実施しているだけ


## Remote Branch Operation: `git clone`
### 特定のフォルダにクローンを作成

```zsh
% git clone <repo> <directory>
```

- `<repo>`: リポジトリURL
- `<directory>`: レポジトリ内容を格納するローカル上の空フォルダ
    - 事前に空フォルダを作成する必要はない
    - パスには絶対パス, 相対パスどちらでも指定可能

> REMARKS

`directory`を中身の入ったフォルダを指定すると以下のようなerrorが返ってくる:

```zsh
% git clone hogehoge pokochin
fatal: destination path 'pokochin' already exists and is not an empty directory.
```

### 特定のブランチのみをローカルにcloneする

```zsh
% git clone -b <branch> <repo>
```

- `<branch>`: branch name
- `<repo>`: リポジトリURL
- `-b` は `--branch` optionのこと




## References

> git sparse checkout

- [Ryo's Tech Blog > GitHub Repositoryの任意のサブディレクトリのみをローカル側で取得する](https://ryonakagami.github.io/2021/04/19/how-to-git-pull-subdirectory/)

> git switch

- [stackoverflow > How can I use the new `git switch` syntax to create a new branch?](https://stackoverflow.com/questions/58124219/how-can-i-use-the-new-git-switch-syntax-to-create-a-new-branch)

> git config

- [Stackoverflow > Pipes in a Git alias?](https://stackoverflow.com/questions/19525387/pipes-in-a-git-alias)
