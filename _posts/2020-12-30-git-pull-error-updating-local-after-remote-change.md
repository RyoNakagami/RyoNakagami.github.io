---
layout: post
title: "git tips: リモートリポジトリの更新後にローカルリポジトリを編集 & commitした場合のエラー対策"
subtitle: "How to use git command 2/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-02-14
tags:

- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Describe the Error](#describe-the-error)
- [How to Solve the Problem](#how-to-solve-the-problem)
  - [方針 1.1: `git reset`を使って, Commitを取り消す](#%E6%96%B9%E9%87%9D-11-git-reset%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-commit%E3%82%92%E5%8F%96%E3%82%8A%E6%B6%88%E3%81%99)
  - [方針 1.2: `git revert`を使って, Commitを戻す](#%E6%96%B9%E9%87%9D-12-git-revert%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-commit%E3%82%92%E6%88%BB%E3%81%99)
  - [方針2: `git pull --rebase`を使って, 最新のアップストリームブランチを参照先に変更する](#%E6%96%B9%E9%87%9D2-git-pull---rebase%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-%E6%9C%80%E6%96%B0%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%A0%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%82%92%E5%8F%82%E7%85%A7%E5%85%88%E3%81%AB%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B)
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

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >どういうとき発生しやすいのか？</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

- Remote Repository側でPull requestをmergeした場合
- Issue TemplateをRemote側で設定してcommitした場合など

</div>

## How to Solve the Problem

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >方針</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

- 方針1: ローカル側のcommitを取り消し, `pull` & `commit` & `push`
- 方針2: `git rebase`を使って, 最新のアップストリームブランチを参照先に変更する

</div>

### 方針 1.1: `git reset`を使って, Commitを取り消す

> Command

```zsh
% git reset --soft <commit-ID>
% git reset --mixed <commit-ID> # Default, ステージングエリアも取り消し(= git addの取り消し)
% git reset --soft HEAD^        # 直前に戻る場合
```

Optionを問わず共通しているのは, Commitを取り消し, `commit-ID`で指定された特定の時点まで戻ること(=HEADの位置が修正される)です. **誤ったコミット自体を削除出来るので修正後のコミットログが見やすくなる**というメリットがあります. なお, `HEAD^`は, HEADリビジョンの1つ前までという意味なので, 直前に戻りたい場合は`commit-ID`をわざわざ指定するのではなく`HEAD^`の方が簡単です.

Optionによる挙動の違いは以下:

|Option|挙動|
|------|---|
|`--hard`|コミット, インデックス, ファイルの変更をすべて削除|
|`--mixed`|コミット, インデックスを削除. ファイルの変更だけは残す|
|`--soft`|コミットだけを削除する. インデックス, ファイルの変更は残す|

`git reset --hard`を指定する場合は「変更自体を手元(ワーキングツリー)に残す必要すらないほど」という例外的な状況と認識しています. 昔の環境での挙動を確認したい場合など完全に昔の環境に戻したい場合はあるかもですが, そのような場合は`git checkout`を利用することが推奨されます.



<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >運用における注意点</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

- コミットそのものを削除してしまうので, 他の開発者が依拠している親コミットを消してしまうリスクがある
- **ローカルな変更を取り消して元に戻したいときに限って使用**

</div>


### 方針 1.2: `git revert`を使って, Commitを戻す

> Command

```zsh
% git revert <commit-ID>
% git revert HEAD^ #直前に戻る場合
```

`git reset`と異なり, `git revert`で指定したコミット時点の状態まで作業ツリーを戻す = 逆向きのコミット」の履歴が残るという特徴があります. コミット自体を削除するわけではないので, 安全にコミットを元に戻すことができるというメリットがあります. 

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >運用における注意点</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

- conflictを引き起こすCommitが１つだけならば問題ないが, 複数の場合は変更履歴の整理が大変になるので非推奨

</div>

### 方針2: `git pull --rebase`を使って, 最新のアップストリームブランチを参照先に変更する

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >方針</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

リモート側の変更内容を `diff-1`, ローカル側の変更内容群を `diff-2`としたとき, 

ローカル側にて以下の手順でコンフリクトを解消していきます: 

1. `git pull --rebase`でremoteとlocalのconflict箇所を確認する(このときbranch nameは`<local branch>|rebase`となっている)
2. `diff-1`と`diff-2`の採択の取捨選択をし, `git add`
3. `git rebase --continue`でrebaseを実行(このときbranch nameは`<local branch>`に戻る)
4. remoteへpush = remote repositoryにdiff-2をリモートに反映させる

logをきれいにしたままconflictを解消することが出来ます.

</div>

> Command

```zsh
% git pull origin <branch name> --rebase
From https://github.com/RyoNakagami/github_sandbox
 * branch            <branch name>       -> FETCH_HEAD
Successfully rebased and updated refs/heads/main.
% git add <conflict-resolved files>
% git rebase --continue
```

References
-----------

- [stackoverflow > git pull --rebase - how to proceed after conflict resolution](https://stackoverflow.com/questions/30119874/git-pull-rebase-how-to-proceed-after-conflict-resolution)
- [YoheiM.NET > [git] 変更を取り消す](https://www.yoheim.net/blog.php?q=20140201)
- [ラクスエンジニアブログ > 【Git入門】git commitを取り消したい、元に戻す方法まとめ](https://tech-blog.rakus.co.jp/entry/20210528/git#reset%E3%81%A7%E3%82%B3%E3%83%9F%E3%83%83%E3%83%88%E3%82%92%E5%8F%96%E3%82%8A%E6%B6%88%E3%81%97%E3%81%A6%E3%81%AA%E3%81%8B%E3%81%A3%E3%81%9F%E3%81%93%E3%81%A8%E3%81%99%E3%82%8B)
