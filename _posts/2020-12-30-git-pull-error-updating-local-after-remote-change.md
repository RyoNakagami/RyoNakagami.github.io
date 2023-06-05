---
layout: post
title: "git rebase: リモートリポジトリの更新後にローカルリポジトリを編集 & commitした場合のエラー対策"
subtitle: "How to use git command 2/N"
author: "Ryo"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-01
tags:

- git
- GitHub
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Describe the Error](#describe-the-error)
- [How to Solve the Problem](#how-to-solve-the-problem)
  - [`git reset`を使って, Commitを取り消す](#git-reset%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-commit%E3%82%92%E5%8F%96%E3%82%8A%E6%B6%88%E3%81%99)
  - [`git revert`を使って, Commitを戻す](#git-revert%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-commit%E3%82%92%E6%88%BB%E3%81%99)
  - [`git rebase`を使って, 最新のアップストリームブランチを参照先に変更する](#git-rebase%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-%E6%9C%80%E6%96%B0%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%A0%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%82%92%E5%8F%82%E7%85%A7%E5%85%88%E3%81%AB%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Describe the Error

ローカル側で`git add` & `git commit`を実行した後, リモートへpushを試みた際に以下のようなエラーメッセージに直面.

```zsh
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'https://github.com/RyoNakagami/github_sandbox.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Remote Repository側の変更をローカルに反映していないことに起因するエラーなので, `git pull`を実行すれば良いとのことなので, 
一旦 `git pull` を実行. しかし, **ローカルで`commit`してしまっていたため**次のようなエラーに直面.

```zsh
% git pull origin main
...
...
From https://github.com/RyoNakagami/github_sandbox
 * branch            main       -> FETCH_HEAD
hint: You have divergent branches and need to specify how to reconcile them.
hint: You can do so by running one of the following commands sometime before
hint: your next pull:
hint: 
hint:   git config pull.rebase false  # merge
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint: 
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.
fatal: Need to specify how to reconcile divergent branches.
```

> どういう時発生しやすいのか？

- Remote Repository側でPull requestをmergeした場合
- Issue TemplateをRemote側で設定してcommitした場合など

## How to Solve the Problem

1. ローカル側のcommitを取り消し, `pull` & `commit` & `push`
2. `git rebase`を使って, 最新のアップストリームブランチを参照先に変更する


### `git reset`を使って, Commitを取り消す

> Command

```zsh
% git reset --soft <commit-ID>
% git reset --mixed <commit-ID> # ステージングエリアも取り消し(= git addの取り消し)
% git reset --soft HEAD^        # 直前に戻る場合
```

- commitのみ取り消し(=作業ディレクトリとステージングエリアは維持), 特定の時点までもどることができます(HEADの位置のみ修正される)
- `git reset --hard`とすると, 作業ディレクトリのファイルも特定のCommit時点まで戻されます
- `HEAD^`は, HEADリビジョンの1つ前までという意味

> メリット

- 誤ったコミット自体を削除出来るのでコミットログが見やすくなる

> REMARKS

- コミットそのものを削除してしまうので, 他の開発者が依拠している親コミットを消してしまうリスクがある
- **ローカルな変更を取り消して元に戻したいときに限って使用**


### `git revert`を使って, Commitを戻す

> Command

```zsh
% git revert <commit-ID>
% git revert HEAD^ #直前に戻る場合
```

- `git reset`と異なり, `git revert`で指定したコミット時点の状態まで作業ツリーを戻す = 逆向きのコミット」の履歴が残る

> メリット

- コミット自体を削除するわけではないので, 安全にコミットを元に戻すことができる

> REMARKS

- conflictを引き起こすCommitが１つだけならば問題ないが, 複数の場合は変更履歴の整理が大変になるので非推奨


### `git rebase`を使って, 最新のアップストリームブランチを参照先に変更する

> Command

```zsh
% git pull origin <branch name> --rebase
From https://github.com/RyoNakagami/github_sandbox
 * branch            <branch name>       -> FETCH_HEAD
Successfully rebased and updated refs/heads/main.
```

> メリット

リモート側の変更内容を `diff-1`, ローカル側の変更内容群を `diff-2`としたとき, 


**ローカル側**|**リモート側**
:---|:---
1. diff-2をローカルから一時的に取り除く<br>2. diff-1をローカルに反映させる<br>3. diff-2をローカルに反映させる|1. diff-2をリモートに反映させる

このようにcommit順番を取り消すことなく, 変更を反映させる事ができるので履歴をきれいにしたままconflictを解消することが出来ます.


## References

> 関連ポスト



> その他

- [YoheiM.NET > [git] 変更を取り消す](https://www.yoheim.net/blog.php?q=20140201)
- [ラクスエンジニアブログ > 【Git入門】git commitを取り消したい、元に戻す方法まとめ](https://tech-blog.rakus.co.jp/entry/20210528/git#reset%E3%81%A7%E3%82%B3%E3%83%9F%E3%83%83%E3%83%88%E3%82%92%E5%8F%96%E3%82%8A%E6%B6%88%E3%81%97%E3%81%A6%E3%81%AA%E3%81%8B%E3%81%A3%E3%81%9F%E3%81%93%E3%81%A8%E3%81%99%E3%82%8B)
