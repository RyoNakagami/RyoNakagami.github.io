---
layout: post
title: "xargs: 複数のファイルを別ディレクトリにgit mvしたい"
subtitle: "How to use git command 3/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
last_modified_at: 2023-05-29
tags:

- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What Do I Want?: 複数のファイルを別ディレクトリにgit mvしたい](#what-do-i-want-%E8%A4%87%E6%95%B0%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E5%88%A5%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%ABgit-mv%E3%81%97%E3%81%9F%E3%81%84)
- [Solution: `xargs -I` と `git mv` コマンドの組合せ](#solution-xargs--i-%E3%81%A8-git-mv-%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E7%B5%84%E5%90%88%E3%81%9B)
  - [ファイルが見つからなかった場合](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%8C%E8%A6%8B%E3%81%A4%E3%81%8B%E3%82%89%E3%81%AA%E3%81%8B%E3%81%A3%E3%81%9F%E5%A0%B4%E5%90%88)
  - [移動先に同じ名称のファイルが存在する場合](#%E7%A7%BB%E5%8B%95%E5%85%88%E3%81%AB%E5%90%8C%E3%81%98%E5%90%8D%E7%A7%B0%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%8C%E5%AD%98%E5%9C%A8%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
- [How Does It Work?](#how-does-it-work)
- [How to Check the Command Works Properly?: Define `gtree` command](#how-to-check-the-command-works-properly-define-gtree-command)
  - [What Do I Want?](#what-do-i-want)
  - [Solution: Piping `git ls-tree` and `tree` commands](#solution-piping-git-ls-tree-and-tree-commands)
    - [How to set up `gtree` command](#how-to-set-up-gtree-command)
    - [`git ls-tree`](#git-ls-tree)
    - [`tree --fromfile`](#tree---fromfile)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What Do I Want?: 複数のファイルを別ディレクトリにgit mvしたい

次のような構成を持つgit管理されたフォルダが存在するとします. このとき, `test_10 ~ test_15`の
名称を持つ `.txt` ファイルを全て`./data/old/`ディレクトリへ移動させたいとします.

```zsh
.
├── data
│   ├── old
│   ├── test_10.txt
│   ├── test_11.txt
│   ├── test_12.txt
│   ├── test_13.txt
│   ├── test_14.txt
│   ├── test_15.txt
│   ├── test_20.txt
│   ├── test_21.txt
│   ├── test_22.txt
│   ├── test_23.txt
│   ├── test_24.txt
│   └── test_25.txt
├── docs
│   └── hogehoge.md
├── LICENSE
└── README.md
```


## Solution: `xargs -I` と `git mv` コマンドの組合せ

```zsh
% find ./data/test_1[0-9].txt | xargs -I{} git mv {} ./data/old
% tree
.
├── data
│   ├── old
│   │   ├── test_10.txt
│   │   ├── test_11.txt
│   │   ├── test_12.txt
│   │   ├── test_13.txt
│   │   ├── test_14.txt
│   │   └── test_15.txt
│   ├── test_20.txt
│   ├── test_21.txt
│   ├── test_22.txt
│   ├── test_23.txt
│   ├── test_24.txt
│   └── test_25.txt
├── docs
│   └── git_command.md
├── LICENSE
└── README.md
```

### ファイルが見つからなかった場合

```zsh
% find ./data/test_1[0-9].txt | xargs -P2 -I{} git mv {} ./data/old
zsh: no matches found: ./data/test_1[0-9].txt
```

### 移動先に同じ名称のファイルが存在する場合

移動先に重複するファイル名が存在する場合, デフォルトでは重複するファイルに関してはエラーが返ってくるが
その他のファイルは移行される.

```zsh
% echo hogehoge > ./data/test_11.txt
% echo foofoo > ./data/old/test_11.txt
% find ./data/test_1[0-9].txt | xargs -P2 -I{} git mv {} ./data/old
fatal: destination exists, source=data/test_11.txt, destination=data/old/test_11.txt
% tree
.
├── data
│   ├── old
│   │   ├── test_10.txt
│   │   ├── test_11.txt
│   │   ├── test_12.txt
│   │   ├── test_13.txt
│   │   ├── test_14.txt
│   │   └── test_15.txt
│   ├── test_11.txt
│   ├── test_20.txt
│   ├── test_21.txt
│   ├── test_22.txt
│   ├── test_23.txt
│   ├── test_24.txt
│   └── test_25.txt
├── docs
│   └── git_command.md
├── LICENSE
└── README.md
% cat data/old/test_11.txt
foofoo
```

> REMARKS

- Overwriteで移行させたい場合は, `git mv -f`のオプションを付与して実行する


## How Does It Work?

コマンドの出力をパイプで `xargs` コマンドに送り込み, `git mv` の引数として指定し実行することで
複数のファイルを別ディレクトリに`git mv`しています.

`-I` optionを利用することで, 引数の位置を`{}`で指定しています. このとき, 内部的には
`git mv old_fild new_file`を1行ずつコマンドで実行する挙動となっています.

そのため, 移動先に同じ名称のファイルが存在する場合, 重複するファイルに関してはエラーが返ってくるが
その他のファイルは移行されるという挙動になっています.

> xargsのオプション

|オプション|効果|
|---|---|
|`-I replace-str`|xargs実行時に指定したコマンドの引数のうち, 置換文字部分を標準入力から読み込んだ名前で置き換える. `-L1` が自動的に指定される.|
|`-P max-procs`|一度に最大でmax-procs個のプロセスを実行. デフォルトは1. max-procsが0の場合, xargsは可能な限り多くのプロセスを同時に実行.|


## How to Check the Command Works Properly?: Define `gtree` command
### What Do I Want?

- `git mv`の結果, repositoryのファイル構成が意図したもの通りになっているか確認できればよい

### Solution: Piping `git ls-tree` and `tree` commands

1. `git ls-tree -r --name-only HEAD`コマンドでHEADの状態におけるレポジトリーのファイルをリストとして出力
2. パイプで `tree` コマンドへ渡し, 意図通りのファイル構成になっているか確認する


#### How to set up `gtree` command

以下のように`gtree`コマンドを定義することで, gitignoreファイルに則したレポジトリtreeが取得できるようになります.

```bash
#!/usr/bin/bash
## Tree-display git-tracked files 
## Author: Ryo Nakagami
## Revised: 2021-01-01

## REQUIREMENT

function usage {
  cat <<EOM
NAME
    $(basename "$0") - Lists the contents of a given tree object, like what "/bin/tree" does in the current git working directory.

Syntax
    $(basename "$0") <folder path>

DESCRIPTION
    This is a wrapper function of tree. 
    When your current directory is a git-tracked folder, this allows you to show files that are not ignored in .gitignore.
    When you specify a directory which is not tracked by git as an input, gtree returns 
        <folder name>
        
        0 directories, 0 files

    When your current directory is not a git-tracked one, this returns the following error:
        <folder name>

        0 directories, 0 files
        fatal: not a git repository (or any of the parent directories): .git

OPTIONS
  -h, --help
    Display help

EOM

  exit 0
}

function error_message {
    echo 'fatal: something wrong! Check the input'
    exit 1
}

function directory_error_message {
    echo 'fatal: $1 does not exist. Check the folder input'
    exit 1
}

if [[ $1 == '-h' || $1 == '--help' ]]; then
    usage

elif [[ $# == 0 ]]; then
    git ls-tree -r --name-only HEAD | tree --fromfile;

elif [[ $# == 1 ]]; then
    if [ -d $1 ]; then
        git ls-tree -r --name-only HEAD $1 | tree --fromfile;
    else
        directory_error_message;
    fi
else
    error_message;
fi
```


#### `git ls-tree`

> Description

- git管理されたワークスペースにおいて, 指定されたツリーオブジェクトの内容をリスト表示
- `/bin/ls -a`と似た挙動をする(pathを指定した際の挙動は異なる)
- `HEAD`などcommit時点を指定する必要がある

使用例として, 

```zsh
% git ls-tree HEAD <folder-name>
```

もし, git管理されていないフォルダで使用すると

```zsh
% git ls-tree HEAD
fatal: not a git repository (or any of the parent directories): .git
.

0 directories, 0 files
```


> Options

---|---
`-r`|Recurse into sub-trees
`--name-only`|List only filenames, one per line.

#### `tree --fromfile`

`tree` を `--fromfile` optionとともに実行することで, ファイルシステムではなくコマンドラインで指定されたパスのファイルからディレクトリのリストを読み取ります. 
パイプでつなぐことで, treeがパスを標準入力から読み取ることが可能となります.

## References

> tree with gitignore

- [StackExchange > Have tree hide gitignored files](https://unix.stackexchange.com/questions/291282/have-tree-hide-gitignored-files)


> xargsコマンド

- [@IT, IT Media >【 xargs 】コマンド――コマンドラインを作成して実行する](https://atmarkit.itmedia.co.jp/ait/articles/1801/19/news014.html)
