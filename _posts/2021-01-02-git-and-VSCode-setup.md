---
layout: post
title: "VSCode設定: VSCodeとGitの連携"
subtitle: "Ubuntu Desktop環境構築 Part 13"
author: "Ryo"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-01
header-mask: 0.0
header-style: text
tags:

- Ubuntu 20.04 LTS
- git
- VSCode
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Overview](#overview)
- [Viewing diffs with the previous commit in VS Code](#viewing-diffs-with-the-previous-commit-in-vs-code)
- [Quick-Viewing diffs Between the current file and the previous commit in VS Code](#quick-viewing-diffs-between-the-current-file-and-the-previous-commit-in-vs-code)
- [Viewing diffs Between the active file and the selected](#viewing-diffs-between-the-active-file-and-the-selected)
- [Checking Commit Graph with Git Graph](#checking-commit-graph-with-git-graph)
- [Checking Commit History with Git History](#checking-commit-history-with-git-history)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Overview

> VSCode Extension List

---|---
[Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)|Workspace観点のBranch/Commit変更履歴の確認
[Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory)|ファイル観点のCommit履歴の確認


## Viewing diffs with the previous commit in VS Code

> What I Want?

- `Git: Open Changes` と ファイル編集画面をトグルできるようにしたい
- トグルの際は同じコマンドでon-offの切り替えができるようにしたい
- diffのinline viewのトグルもできるようにしたい

> Implementation

<img src= "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20201228-Git-VsCode-diff.png?raw=true">

- ステージング前に変更点を確認したい場合は確認したいファイルを開いた状態で`Git: Open Changes`実行すると, 直前のcommit時のファイルの状態との比較をハイライト付きで確認することができる
- コンフリクト発生時における,該当箇所の確認も同様の方法で可能


> Setup

```json
    {
        "key": "ctrl+alt+h",
        "command": "git.openChange",
        "when": "editorFocus && !isInDiffEditor",
        "description": "Open Git Open Changes"
    },
    {
        "key": "ctrl+alt+h",
        "command": "workbench.action.closeActiveEditor",
        "when": "editorFocus && isInDiffEditor",
        "description": "Close Git Open Changes"
    },
    {
        "key": "ctrl+alt+i",
        "command": "toggle.diff.renderSideBySide",
        "when": "editorFocus && !isInDiffEditor",
    },
```

## Quick-Viewing diffs Between the current file and the previous commit in VS Code

> What I Want?

- 編集中ファイルについて前回Commitとの差分をクイックにEditor内部で確認する

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/aefac090f173d35f1e3580e1e5b2a540bca4bb2a/Setup/20210102_git_VSCode_Gutter.png">

> Setup

- VSCodeの「Gutter Indicator」というデフォルト機能をOnにする
- `settings.json`ファイルを以下のように指定

```json
  // Controls diff decorations in the editor.
  //  - all: Show the diff decorations in all available locations.
  //  - gutter: Show the diff decorations only in the editor gutter.
  //  - overview: Show the diff decorations only in the overview ruler.
  //  - minimap: Show the diff decorations only in the minimap.
  //  - none: Do not show the diff decorations.
    "scm.diffDecorations": "all",

  // Controls the visibility of the Source Control diff decorator in the gutter.
  //  - always: Show the diff decorator in the gutter at all times.
  //  - hover: Show the diff decorator in the gutter only on hover.
    "scm.diffDecorationsGutterVisibility": "always",
    
    // https://stackoverflow.com/questions/43969277/how-can-you-disable-gutter-indicators-in-vs-code
    //"scm.diffDecorationsGutterAction": "none",
```

> REMARKS

非表示にしたい場合は以下のように指定

```json
  "scm.diffDecorations": "none"
```


## Viewing diffs Between the active file and the selected

> What I Want?

- `Git: Open Changes` と同じ形式で2つのファイル間のdiffを確認したい


> Implementation

- 比較元のファイルの内容がエディタの左側に, 比較対象のファイルの内容が右側に表示
- 上で設定した`toggle.diff.renderSideBySide`のショートカットコマンドでinline viewのToggleも可能

> Setup

```json
    {
        "key": "ctrl+alt+c",
        "command": "workbench.files.action.compareFileWith",
        "when": "editorFocus && !isInDiffEditor",
        "description": "Compare the active file with the selected"
    },
```




## Checking Commit Graph with Git Graph

> What I Want

- Workspace観点でLocal & Remote Branchesの変更履歴がグラフで見れる
- Commitの詳細情報がGUIで確認できる
- ショートカットコマンドはいつでも実行できるようにする

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/4348395ac04a5115fbc1f9966a47c78745364166/Setup/20210102_git_graph.gif">

> Install

Command Palleteにて以下のコマンドを実行

```
ext install mhutchie.git-graph
```

> Setup

```json
    {
        "key": "ctrl+shift+g",
        "command": "git-graph.view"
    },
```

- ショートカットコマンドを任意のタイミングで実行したいので`when` keyを設定しない

## Checking Commit History with Git History

> What I Want

- ファイル観点でCommit履歴と差分確認


> Install

Command Palleteにて以下のコマンドを実行

```
ext install donjayamanne.githistory
```


> Setup

```json
    {
        "key": "alt+h",
        "command": "git.viewFileHistory",
        "when": "editorFocus && !isInDiffEditor"
    },
```




## References

> 関連ポスト

- [GitとGitHubの設定](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/)


> VSCode公式ドキュメント/Marketplace

- [Using Git source control in VS Code](https://code.visualstudio.com/docs/sourcecontrol/overview#_working-in-a-git-repository)
- [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)
- [Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory)


> VSCodeショートカット設定参考

- [stackoverflow > Shortcut with multiple command in VSCode](https://stackoverflow.com/questions/55160717/shortcut-with-multiple-command-in-vscode)
- [stackoverflow > VS Code - Shortcut for toggling Git Open Changes and Git Open File](https://stackoverflow.com/questions/44737285/vs-code-shortcut-for-toggling-git-open-changes-and-git-open-file)

> その他VSCode設定

- [VSCodeの行番号右のガターインジケーターを非表示にする方法](https://www.exceedsystem.net/2020/11/25/how-to-hide-gutter-indicator-on-vscode/)