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
  - [Create a New Branch Locally from a Specified Branch](#create-a-new-branch-locally-from-a-specified-branch)
  - [Rename a Local Branch Name](#rename-a-local-branch-name)
  - [Delete a Local Branch](#delete-a-local-branch)
  - [Restore a branch after its deletion in Git](#restore-a-branch-after-its-deletion-in-git)
  - [Check the Upstream Branch](#check-the-upstream-branch)
  - [Set up an upstream branch to a local branch](#set-up-an-upstream-branch-to-a-local-branch)
  - [Check the Nearest Branch](#check-the-nearest-branch)
- [Local Branch Operation: Compare and Merge](#local-branch-operation-compare-and-merge)
  - [Compare the current branch with the Selected Branches](#compare-the-current-branch-with-the-selected-branches)
  - [Undo a Merge Commit](#undo-a-merge-commit)
- [Remote Branch Operation](#remote-branch-operation)
  - [Get/Switch to a remote branch: `git switch` version](#getswitch-to-a-remote-branch-git-switch-version)
  - [Get/Switch to a remote branch: `git fetch` version](#getswitch-to-a-remote-branch-git-fetch-version)
  - [Delete Remote Branch](#delete-remote-branch)
  - [Refresh the list of remote branches](#refresh-the-list-of-remote-branches)
  - [Rename Remote Branch](#rename-remote-branch)
- [Remote Branch Operation: `git clone`](#remote-branch-operation-git-clone)
  - [git clone to a specified folder](#git-clone-to-a-specified-folder)
  - [git clone a specified branch only](#git-clone-a-specified-branch-only)
  - [Install Private Python Packages via git clone](#install-private-python-packages-via-git-clone)
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

- Upstream branchに編集記録が最新版までmergeされているローカルブランチを消去する場合に使用可能

```zsh
% git branch --delete non-existing-branch
Deleted branch non-existing-branch (was 1d6ed41).
% git branch -d <branch> 
Deleted branch <branch> (was 1d6ed42).
```

複数の場合は

```zsh
% git branch --delete <branch> <branch> <branch>
```

upstream branchにmergeされていない場合は次のようなエラーが返ってくる

```zsh
% git branch -d hoge
error: The branch 'hoge' is not fully merged.
If you are sure you want to delete it, run 'git branch -D hoge'.
```

強制的に消去したい場合は

```zsh
% git branch -D hoge
Deleted branch hoge (was eb79802).
```

### Restore a branch after its deletion in Git

> What I Want

- 誤って削除してしまったbranchをlocalで復旧させたい
- branchを削除してから別ブランチですでに作業を開始してしまっている状況を考える
- 復元後も, 昔の作業履歴が確認できるようにしたい

> How to Solve the problem

- `git reflog`は, すでに消去された履歴自体も確認できるコマンド
- `git reflog`で消去してしまったbranchからcheckoutした`commit-hash`
- 上記で取得した`commit-hash`を参照する形で`git switch -c`を実行

> Example

`non_existing_branch`というbranchを消去してしまったあと, `main` branchで作業を開始してし
まった状況を考えます.


`main` branchへ移動した直後に`non_existing_branch`を消去してしまいます.

```zsh
% git switch main
% git branch --delete non_existing_branch
```

消去したあと, `main` branchで適当に作業します 

```zsh
% touch hoge.txt
% echo unkounko > hoge.txt
% git add hoge.txt
% git commit -m "DOC: Add hoge.txt about the family secret"
% git push
```

このタイミングで, ``non_existing_branch`を消去するのはやばかったと発覚しました.
慌てずに, `git reflog`コマンドでブランチ消去直前のcommit-hashを確認します.

```zsh
% git reflog
c65bac9 (HEAD -> main, origin/main) HEAD@{0}: commit: DOC: Add hoge.txt about the family secret
9fb60c5 HEAD@{1}: checkout: moving from non_existing_branch to main
```

checkoutタイミングの履歴が`9fb60c5`で残っていることがわかります. 
なお, このcommit-hashは`git log`では確認できません( = `git reflog`と`git log`の違い)

最後にこのcommit-hashを用いて, branchを復元します.

```zsh
% git switch -c non_existing_branch 9fb60c5
```

### Check the Upstream Branch

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


### Set up an upstream branch to a local branch

> What I Want

- upstream branchが設定されていないlocal branchに対して, upstream branchを指定したい

> How

```zsh
% git branch -u <remote branch>
% git branch <local branch> -u <remote branch>
```

- `<local branch>`を省略した場合は, 現在のbranchに対してupstream branchを設定する


### Check the Nearest Branch

> What I Want

- カレントブランチの派生元ブランチ名を取得する
- Merge後は, 直近のMerge元を派生元ブランチとして参照する

> Setup

`.gitconfig`ファイルにてエイリアスを以下のように設定

```zsh
[alias]
	nearest = "!git show-branch  -a| grep '*' | grep -v `git rev-parse --abbrev-ref HEAD`| head -n1| sed 's/.*\\[\\(.*\\)\\].*/\\1/'| sed 's/[\\^~].*//' #"
```

- `!`はシェルコマンドを入力しますよ, という指示語


> How to Use it

- `develop`ブランチから派生した`feature_model`ブランチに現在いるとする
- `feature_model`ブランチの派生元ブランチとして`develop`ブランチ名が出力されてほしい

```zsh
% git branch
  develop
  feature_cv
* feature_model
  main
% git nearest
develop
```





## Local Branch Operation: Compare and Merge
### Compare the current branch with the Selected Branches

> What I Want

- 選択したブランチと比較した時, conflictを引き起こすファイル及び差分箇所を確認したい
- コマンド実行中に, ファイルの編集も実現可能

> Requirements

`.gitconfig`に以下のラインを追記

```
[diff]
	tool = vscode
[difftool "vscode"]
	cmd = code --wait --diff $LOCAL $REMOTE
```

> How

```zsh
% git difftool <the selected branch> <path>
```

- 左側にthe selected branch, 右側にthe current branchのファイルが表示される
- the current branchのファイルは編集 & 保存が可能
- `<path>`指定時は, その対象ファイルのみの差分を表示
- `<path>`を指定しなかった場合は, 差分全てを表示

### Undo a Merge Commit

> What I Want

- merge commitを取り消す

> How

merge commitを取り消すには2つの方法があります:

|方針|効果|
|---|---|
|`git reset --merge`|Branch Historyを強制的に書き換える(= merge commitの痕跡を履歴から消す)|
|`git revert`|merge変更自体は打ち消すが, merge commitの履歴は残る|

本来mergeされるべきではなかったbranchがmergeされたときに実施するundoなので, 基本的には
`git reset --merge`を用いることが良いと考えています. 実際に, [Linus](https://github.com/git/git/blob/master/Documentation/howto/revert-a-faulty-merge.txt#L62-L78)も次のように言っています:

```
Reverting a regular commit just effectively undoes what that commit did, and is fairly straightforward. 
But reverting a merge commit also undoes the _data_ that the commit changed, 
but it does absolutely nothing to the effects on _history_ that the merge had.

So the merge will still exist, and it will still be seen as joining the two 
branches together, and future merges will see that merge as the last shared 
state – and the revert that reverted the merge brought in will not affect that at all.

So a "revert" undoes the data changes, but it's very much not an "undo" in the 
sense that it doesn't undo the effects of a commit on the repository history.

So if you think of "revert" as "undo", then you're going to always miss this 
part of reverts. Yes, it undoes the data, but no, it doesn't undo history.
```


> How to do `git reset --merge` in order to undo the merge

```zsh
% git reset --merge <commit-hash>
```

`git reset –merge`はtracked filesに加えられたuncommitedな変更についての情報を残してくれるため,
全てを参照地点までの情報まで戻してしまう`git reset --hard`に対してsafer versionと一般的に言われています.

documentを確認してみると,

```
--hard    Matches the working tree and index to that of the tree being
               switched  to. Any changes to tracked files in the working tree since
               <commit> are lost.

--merge
              Resets the index to match the tree recorded by the named commit, and
              updates the files that are different between the named commit and
              the current commit in the working tree.
```

> Check the difference between `--hard` and `--marge`


`--hard` と `--marge`はtracked fileのuncommittedな変更について情報を残すか残さないかの違いです.
それを確認するため以下の状況を作ります:

1. `main`と`merge_test`の2つのbranch
2. `main`へ`merge_test`をmergeする前に、tracked-fileの`README.md`に「good bye」という文字列を加える
3. good byeをstashしてから, `merge_test`で適当に作業, `main`へ戻る
4.  good byeをstashからpopしてから`merge_test`を`main`へmerge

```zsh
% mkdir test
% cd ./test
% git init
% touch README.md
% git commit -m "initial commit"
% git switch -c merge_test
% touch merge_log.txt
% echo test > merge_log.txt
% git add merge_log.tx
% git commit -m "DOC: Additing merge_log"
% git switch main
% echo hello world > README.md
% git add README.md
% git commit -m "DOC: updating README"
% echo good bye >> README.md
% git stash
% git switch merge_test
% echo 'hope this line will disappear'
% echo 'hope this line will disappear' > merge_log.txt
% git add merge_log.txt
% git commit -m "DOC: updating merge_log"
% git switch main
% git stash pop
% git merge merge_test
```

このとき, `--hard` と `--marge`で以下のような挙動の違いが発生します:

```zsh
## stashされたgood byeは残る
% git reset --merge ORIG_HEAD

## stashされたgood byeが消える
% git reset --hard ORIG_HEAD
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

> 複数の場合

```zsh 
% git push origin --delete <branch1> <branch2> <branch3>
```

### Refresh the list of remote branches

> What I Want

- To update the local list of remote branches

> How: remote updateで実施する場合

```zsh
% git remote update origin --prune
```

> How: fetchで実施する場合(推奨)

```zsh
% git fetch -p 
```



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
### git clone to a specified folder

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

### git clone a specified branch only

```zsh
% git clone -b <branch> <repo>
```

- `<branch>`: branch name
- `<repo>`: リポジトリURL
- `-b` は `--branch` optionのこと


### Install Private Python Packages via git clone

- <branch-name>: installしたいversionを指定
- <folder-name>: レポジトリのローカルにおける保存先

```zsh
% git clone -b <branch-name> <repository url> <local-folder-path>
```

Then, pip経由の場合は編集可能性を考慮して `-e` オプションを付与してインストール

```zsh
% pip install -e <folder-name>
```

Poetry経由の場合は

```zsh
% poetry add --editable <folder-name>
```

## References

> git config

- [Stackoverflow > Pipes in a Git alias?](https://stackoverflow.com/questions/19525387/pipes-in-a-git-alias)

> git sparse checkout

- [Ryo's Tech Blog > GitHub Repositoryの任意のサブディレクトリのみをローカル側で取得する](https://ryonakagami.github.io/2021/04/19/how-to-git-pull-subdirectory/)

> git branch operation tips

- [stackoverflow > How can I use the new `git switch` syntax to create a new branch?](https://stackoverflow.com/questions/58124219/how-can-i-use-the-new-git-switch-syntax-to-create-a-new-branch)
- [stackoverflow > Can I recover a branch after its deletion in Git?](https://stackoverflow.com/questions/3640764/can-i-recover-a-branch-after-its-deletion-in-git)
- [git documentation > Linus explains the revert and the reset](https://github.com/git/git/blob/master/Documentation/howto/revert-a-faulty-merge.txt#L62-L78)