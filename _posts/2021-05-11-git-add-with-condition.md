---
layout: post
title: "指定のディレクトリのmodified fileのファイルのみをgit addする"
subtitle: "How to use git command 13/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-03-20
header-mask: 0.0
header-style: text
tags:

- git
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [指定のディレクトリのmodified fileのファイルのみをgit addする](#%E6%8C%87%E5%AE%9A%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%AEmodified-file%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%81%BF%E3%82%92git-add%E3%81%99%E3%82%8B)
  - [`git ls-files`の挙動](#git-ls-files%E3%81%AE%E6%8C%99%E5%8B%95)
  - [`grep`の挙動](#grep%E3%81%AE%E6%8C%99%E5%8B%95)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 指定のディレクトリのmodified fileのファイルのみをgit addする

**すべてのmodifiedのファイルのみをgit addしたい場合**

```zsh
% git add -u
```

**特定のディレクトリ以下すべてのファイルを再帰的にgit addしたい場合**

```zsh
% git add directory_name/
```

で以上で完結しますが, 特定のディレクトリ直下のmodified fileのみ(またはuntracked fileのみ)を`git add`したい場合は対象を制限した上で`git add`に渡す必要があります. 

このようなケースにおいて, 自分は以下のようなスクリプトで対処しています.

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >カレントディレクトリ以外の特定のディレクトリ直下のmodified filesをステージングしたい場合</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

```zsh
% git ls-files $(git rev-parse --show-toplevel) -m \
 | grep -E "(dir_A/|dir_B/)[^/]{1,}\.\w{1,}$" \
 | xargs git add
```

- `git ls-files $(git rev-parse --show-toplevel) -m`をrepository rootから検索してmodifiedのリストを取得
- `grep -E "(dir_A/|dir_B/)"`で対象directory pathを含むファイルリストを抽出
- `xargs`で`git add`に抽出したファイルを渡す

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >カレントディレクトリ直下のmodified filesをステージングしたい場合</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

```zsh
% git ls-files -m \
 | grep -v "/" \
 | xargs git add
```

- `grep -v "/"`で`/`を含む一覧を除外 = 実質上カレントディレクトリのファイルのみとなる

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >カレントディレクトリ以外の特定のディレクトリ直下のuntracked filesをステージングしたい場合</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

```zsh
% git ls-files $(git rev-parse --show-toplevel) -o --exclude-standard \
 | grep -E "(dir_A/|dir_B/)[^/]{1,}\.\w{1,}$" \
 | xargs git add
```

</div>


staging areaに行っていないmodified file一覧は`git ls-files -m`でもれなく取得できますが, そこからの絞り込みは`grep`コマンドを使用しているため以下の暗黙の仮定があります.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >コマンドが正常に動作するための仮定</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

- `dir_A/`というディレクトリを対象にするときに, filenameに`dir_A/`という文字列が入っていない
- filenameに`/`という文字が含まれていない
- ファイルに拡張子(正確には`.`という文字列)が必ずついている

</div>

### `git ls-files`の挙動

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: git ls-files</ins></p>

- `git ls-files`はstaging-areaに追加されているファイルと作業ツリー内の変更を比較して表示するコマンド
- ディレクトリを指定しないで実行すると, カレントディレクトリ以下について上記の情報を表示する

```
git ls-files <directory> [option]
```

</div>

|短いオプション|長いオプション|説明|
|---|---|---|
|`-m`|`--modified`|stagingされていない変更のあるファイルを表示|
|`-o`|`--others`|untrackedファイルを表示 (ただし `.gitignore`とかで除外されているも含む)|
||`--exclude-standard`|`.git/info/exclude`, `.gitignore`の効力を適用させる=表示から除外する|

注意点としては, untracked filesを表示するとき, `.gitignore`などで無視されたファイルを表示から除外するため

```zsh
% git ls-files -o --exclude-standard
```

とオプションを２つ表示する必要があります.

また, repositoryのtoplevel-directoryから検索をかけたい場合は, toplevel-directoryの絶対パスを取得する`git rev-parse --show-toplevel`コマンドと合わせて使用します.

```zsh
% git ls-files $(git rev-parse --show-toplevel)
```

### `grep`の挙動

今回用いている`grep`のoptionは以下２つのみです

|オプション|説明|
|---|---|
|`-E`|正規表現によるパターンマッチング|
|`-v`|マッチしたパターンを除外して表示|

**正規表現について**

```zsh
% git ls-files -m | grep -E "(dir_A/|dir_B/)[^/]{1,}\.\w{1,}$"
```

という表現を用いていますがポイントは以下のみです

- `(dir_A/|dir_B/)`: 検索ワードのグルーピング, `dir_A/`または`dir_B/`にマッチする
- `[^/]{1,}`: `/`以外の文字が一回以上続く(=filenameに`/`が含まれている場合は検索対象外になる)
- `\.`: `.`は任意の位置文字を意味するメタ文字なので, エスケープすることで拡張子の`.`と一致する
- `\w`: `[a-zA-Z]`の文字クラス(拡張子は`.txt`にようにアルファベットと`.`で表現されることを想定)
- `$`: 行末を意味するメタ文字



References
----------
- [git-ls-files](https://git-scm.com/docs/git-ls-files)
