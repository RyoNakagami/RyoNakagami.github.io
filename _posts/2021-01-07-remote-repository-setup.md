---
layout: post
title: "Remote Repositoryの設定と変更"
subtitle: "How to use git command 8/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
revise_date: 2023-06-16
tags:

- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Rename an existing Git remote?](#rename-an-existing-git-remote)
  - [How to rename the remote?](#how-to-rename-the-remote)
- [Chaneg a Remote Repository's URL](#chaneg-a-remote-repositorys-url)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>




## Rename an existing Git remote?

既存のremote repositoryの名前を変更するためのコマンドをここでは紹介します.
名称変更に必要なのは, 

- 現在のremote repositoryの名前: `<current-name>`
- これからのremote repositoryの名前: `<target-name>`


### How to rename the remote?

> Step 1: Confirm the name of your current remote 

まず, 現在のremote repositoryの名前を確認します;

```zsh
% git remote -v
origin	https://github.com/RyoNakagami/github_sandbox.git (fetch)
origin	https://github.com/RyoNakagami/github_sandbox.git (push)
```

現在のremote repositoryの名前が `origin` であることが確認できます.


> Step 2: Change the remote name

Remoteの名前変更のコマンドは以下となります:

```zsh
% git remote rename <current-name> <target-name> 
```

今回は, `origin`から`upstream`へ変更してみます

```zsh
% git remote rename upstream origin
Renaming remote references: 100% (6/6), done.
```

remote repository nameが意図通り変更されているか確認します:

```zsh
% git  remote -v
upstream	https://github.com/RyoNakagami/github_sandbox.git (fetch)
upstream	https://github.com/RyoNakagami/github_sandbox.git (push)
```

## Chaneg a Remote Repository's URL

まずどのrepositoryもremote urlの設定から入ります

```zsh
% git remote add origin https://github.com/OWNER/REPOSITORY.git
# Set a new remote

% git remote -v
# Verify new remote
> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
> origin  https://github.com/OWNER/REPOSITORY.git (push)
```

ここからremote repository's urlを変更する場合は, `git remote set-url` コマンドを用います.
remote repository nameが`origin`の場合の変更コマンドは以下:

```zsh
% git remote set-url origin <target-url>
```

> REMARKS

- sshとHTTPSで設定するURL構造の違いがあることに留意
- 接続方式に合わせたurlを指定すること

```zsh
# SSH
git@github.com:OWNER/REPOSITORY.git

# HTTPS
https://github.com/OWNER/REPOSITORY.git
```



## References

- [GitHub Docs > Managing remote repositories](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories)