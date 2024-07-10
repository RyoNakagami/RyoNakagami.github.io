---
layout: post
title: "git commit: commit messageの修正"
subtitle: "How to use git command 8/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
last_modified_at: 2024-07-11
tags:

- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Commit Guideline](#commit-guideline)
- [直前のCommit Messageの修正](#%E7%9B%B4%E5%89%8D%E3%81%AEcommit-message%E3%81%AE%E4%BF%AE%E6%AD%A3)
- [直前のCommit内容にミスが有り修正したい場合](#%E7%9B%B4%E5%89%8D%E3%81%AEcommit%E5%86%85%E5%AE%B9%E3%81%AB%E3%83%9F%E3%82%B9%E3%81%8C%E6%9C%89%E3%82%8A%E4%BF%AE%E6%AD%A3%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
- [過去複数のCommit Messageを修正したい場合](#%E9%81%8E%E5%8E%BB%E8%A4%87%E6%95%B0%E3%81%AEcommit-message%E3%82%92%E4%BF%AE%E6%AD%A3%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
- [Appendix: `git summary`コマンド](#appendix-git-summary%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Commit Guideline

- Commit Messageは自分を含むチームメンバーが一目で, そのcommitがどのような変更を加えたものなのか理解できるものであるべき 

ルールが複雑だと運用が辛いので, 一旦シンプルに以下のルールで運用しています:

- 作成されたcommitがどのような分野の作業なのか判別するためPrefixを付与する
- Prefixが2つ以上になる場合は, `ENH/DEPR:` のようにスラッシュを加える
- commit内容の一文サマリをメッセージに加える
- Issue番号が加えられるなら加える
- `git commit -m`で良い

<strong > &#9654;&nbsp; Prefix Guideline</strong>

|Prefix|Comments|
|---|---|
|`ENH:`| Enhancement, new functionality|
|`BUG:`| Bug fix|
|`DOC:`| Additions/updates to documentation|
|`BLD:`| Updates to the build process/scripts|
|`PERF:`| Performance improvement|
|`TEST:`| Additions/updates to tests|
|`TYP:`| Type annotations|
|`CLN:`| Code cleanup, refactoring|
|`WIP:`| checkpoint|
|`DEPR`|deprecation|

## 直前のCommit Messageの修正

`test.txt`の修正後, Commit Guidelineに従って, 「`DOC: updating TOC of test.txt`」と入力するところ,
誤って以下のようなcommit messageを入力してしまったとします

```
% git commit -m "DOCS: updating test.txt" 
```

`git log` (独自に定義したgit summaryコマンドをここでは使用, 詳しくはsee Appendix)で確認してみると

```zsh
% git summary
2020-06-21T18:50:57+09:00,1d8d1bd,your-email-address,DOCS: updating test.txt
...
```

この直前のcommit messageを修正したい場合は, `git commit --amend`を使用します.

```zsh
% git commit --amend -m "DOC: updating TOC of test.txt"
% git summary
2020-06-21T18:58:45+09:00,1daf2a2,your-email-address,DOC: updating TOC of test.txt
```

<strong > &#9654;&nbsp; REMARKS</strong>

- 修正前後のcommit-hashが`1d8d1bd`, `1daf2a2`と異なっていることに注意
- 作業が全てlocalで閉じられる時は問題はないが，すでにremoteへpushしてしまっている場合は非推奨
- 一度remoteへpushしてしまっている場合は，`--force`でpushする必要がある

## 直前のCommit内容にミスが有り修正したい場合

```zsh
% git add eda.py
% git commit -m "EDA-phase-1-task-1: histogram on the annual sales amount"
```

上記のように`eda.py`を編集 & commitした直後に，フォーマッターをかけ忘れていたことに気付き修正したいケースを考えます．

このとき，修正後に再度staging → `git commit --amend --no-edit`とすることで新たにステージングされたファイルの変更履歴は
直前のcommitに含まれるようになります．

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#ffa657; background-color:#F8F8F8'>
<strong style="color:#ffa657">警告 !</strong> <br> 

- Remote repositoryにpusshされたcommitの修正となるようなケースは避けること
- あくまでローカルのみに存在するcommitを修正する程度の運用に留めること

</div>


## 過去複数のCommit Messageを修正したい場合

複数のcommitや任意の過去の時点のcommitのmessageを変更したい場合は, `git rebase`コマンドを用います.

まず, 変更したいcommitを確認します:

```zsh
% git summary
2020-06-21T22:35:24+09:00,dd929d9,foohoo@hoge.com,DOC: mv the 20230621/README to README
2020-06-21T22:35:20+09:00,3d188af,foohoo@hoge.com,DOC/WIP: adding a newline to README
2020-06-21T22:35:08+09:00,6a52472,foohoo@hoge.com,DOC/WIP: adding a newline to README
```

commit-hashが`3d188af`, `6a52472`のprefixが`DOC/WIP`になっているので, これをDOCへ変更します.
直近の3つのcommitを表示して, その内上記の2つを変更していきます

このとき, `git rebase -i HEAD~N`コマンドを使用します.
このコマンドは`HEAD`からNまでのcommitを修正するという意味です. 今回は以下のように実行します:


```zsh
% git rebase -i HEAD~3
```

Then, 次のようなリストが表示されます.

```
pick 6a52472 DOC/WIP: adding a newline to README
pick 3d188af DOC/WIP: adding a newline to README
pick dd929d9 DOC: mv the 20230621/README to README

# Rebase b07cecb..dd929d9 onto b07cecb (3 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
#         create a merge commit using the original merge commit's
#         message (or the oneline, if no original merge commit was
#         specified); use -c <commit> to reword the commit message
# u, update-ref <ref> = track a placeholder for the <ref> to be updated
#                       to this position in the new commits. The <ref> is
#                       updated at the end of the rebase
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
```

次に, `3d188af`, `6a52472`のcommitをpickからrewordへ変更し, 保存して閉じます. つまり,

```
reword 6a52472 DOC/WIP: adding a newline to README
reword 3d188af DOC/WIP: adding a newline to README
pick dd929d9 DOC: mv the 20230621/README to README
```

すると, それぞれのcommitに対応する`COMMIT_EDITMSG`がでてくるので修正して保存します.
commit messageが修正されているかどうか確認すると,

```zsh
% git summary
2020-06-21T22:42:47+09:00,b81254f,foohoo@hoge.com,DOC: mv the 20230621/README to README
2020-06-21T22:42:43+09:00,3041854,foohoo@hoge.com,DOC: adding a newline to README
2020-06-21T22:41:53+09:00,2159f27,foohoo@hoge.com,DOC: adding a newline to README
```

以上のように変更されていました.
なお, 変更していないはずの`dd929d9`についてもcommit-hashが`b81254f`に書き換えられています.
これはrebaseの対象となってしまったので, その変更影響を受けてしまったことが理由になります.

## Appendix: `git summary`コマンド

`git summary`は元々登録されているコマンドではなく, `.gitconfig`で自分が定義したコマンドです.
挙動としては以下と同じです:

```zsh
% git log \
  --pretty=format:'%Cgreen%cI%Creset,%Cred%h%Creset,%C(bold blue)%ae%Creset,%s'\
  --abbrev-commit --decorate
```

`~/.gitconfig`における登録例は以下です:

```config
[alias]
	summary = "log --pretty=format:'%Cgreen%cI%Creset,%Cred%h%Creset,%C(bold blue)%ae%Creset,%s' --abbrev-commit --decorate"
```



## References

- [GitHub Docs > Changing a commit message](https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/changing-a-commit-message)