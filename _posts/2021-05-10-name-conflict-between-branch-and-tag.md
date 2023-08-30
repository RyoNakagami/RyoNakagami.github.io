---
layout: post
title: "Delete Git branch and tag with same name"
subtitle: "How to use git command 12/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
tags:
  - git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [リモートにtagと同じ名前のブランチが存在する場合](#%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%81%ABtag%E3%81%A8%E5%90%8C%E3%81%98%E5%90%8D%E5%89%8D%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%8C%E5%AD%98%E5%9C%A8%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
- [ローカルにあるbranch/tagをmergeさせたいとき](#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%81%AB%E3%81%82%E3%82%8Bbranchtag%E3%82%92merge%E3%81%95%E3%81%9B%E3%81%9F%E3%81%84%E3%81%A8%E3%81%8D)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## リモートにtagと同じ名前のブランチが存在する場合

remote branchの消去など同名のリモートブランチを対象にコマンド操作すると以下のようなエラーが発生します:

```zsh
% git push origin :<tag or branch>
error: src refspec <name> matches more than one
error: failed to push some refs to <Remote git url>
```

リモート側だとlocalのときと異なりdeleteのコマンドが同じでnameコンフリクトが発生してしまうことが原因です.
対処方法はremoteやブランチ/tag消去が考えられますが, それぞれのコマンドは以下です

```zsh
## localでのbranch/tagの除去
% git tag -d <tag>
% git branch -d <branch>

## remote branch自体を消去したい場合
% git push origin :refs/heads/<branch_name>

## tagを慶したい場合
% git push origin :refs/tags/<tag_name>
% git push origin --delete refs/tags/<tag_name>
```

## ローカルにあるbranch/tagをmergeさせたいとき

local branchでmergeを行う場合もremoteと同様の問題が以下のように発生するリスクがあります.

```zsh
% git merge <tag or branch name>
warning: refname 'name' is ambiguous.
warning: refname 'name' is ambiguous.
```

この場合も, remoteのときと同様に`tags/` or `refs/heads/`でどちらを参照しているかcommandへ明示的に情報を渡すことで解決することができます.

```zsh
## tagをmergeさせたい場合
% git merge tags/<tag-name>

## branchをmergeさせたい場合
% git merge refs/heads/<branch-name>
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: tagやbranchの情報をどこで管理しているのか？</ins></p>

gitではtagやremote, local branchの情報を`.git/refs/`で管理しています.
そのため, `refs/heads/`でbranchを指定しているのかどうかを認識することができます.

```zsh
% ls -l .git/refs/ 
total 12
drwxrwxr-x 2 kirby kirby 4096 Aug 30 11:56 heads/
drwxrwxr-x 3 kirby kirby 4096 Jul 23 04:08 remotes/
drwxrwxr-x 2 kirby kirby 4096 Jul 23 04:08 tags/
```

</div>
