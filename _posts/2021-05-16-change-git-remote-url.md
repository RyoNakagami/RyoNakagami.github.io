---
layout: post
title: "Remote Repositoryの変更とミラーリング"
subtitle: "How to use git command 16/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: true
last_modified_at: 2024-03-26
header-mask: 0.0
header-style: text
tags:

- git
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>

## GitHub: Remote Repositoryの名前を変更する

リポジトリの名前を変更すると, プロジェクトサイトの URL を除くすべての既存の情報は, 下記を含む新しい名前に自動的にリダイレクトされます.

- issue
- Wiki
- Star
- フォロワー

特筆すべき点としては, `git clone`, `git fetch`, `git push`操作も適切にリダイレクトされます. しかし, 
`git remote -v`で表示したURLと差異があるのは名が体を表していないので以下のように修正することが推奨です.

```zsh
% git remote set-url origin NEW_URL
```

一方, `pip install`や`poetry add`の宛先はリダイレクトされないので, 変更にあたっては慎重になる必要があります. 
`newname-repository`へ名前変更した `oldname-repository`を`Poetry`経由でインストールしたを環境にて, `poetry update`を実行すると以下のようなエラーが発生します:

```zsh
% poetry update
The dependency name for oldname-repository does not match the actual package's name: newname-repository
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#ffa657; background-color:#F8F8F8'>

<strong style="color:#ffa657">警告 !</strong> <br> 名前変更したリポジトリの元の名前を別のリポジトリに再利用した場合, 名前変更したリポジトリへのリダイレクトは機能しなくなります。

</div>



References
----------
- [GitHub Documents > リポジトリの名前を変更する](https://docs.github.com/ja/repositories/creating-and-managing-repositories/renaming-a-repository)
