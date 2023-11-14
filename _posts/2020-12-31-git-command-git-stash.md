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

`git stash`は現在焼いている途中の肉を皿に退避させて, 網を交換する際に使うコマンドです. 
より正確には「現在焼いている途中の肉を皿に退避させて」というアクションを実行するのが`git stash`に相当します.

### いつ使うのか？

### Syntax

> 作業を退避させたい場合

```zsh
% git stash
```

> 退避した作業一覧の取得

```zsh
% git stash list
```

> 退避した作業の削除

```zsh
% git stash drop
```

> 退避した作業すべての削除

```zsh
% git stash clear
```


## How to use `git stash`

```zsh
% git stash
```






## References

> 公式ドキュメント

- [git > git-stash - Stash the changes in a dirty working directory away](https://git-scm.com/docs/git-stash)