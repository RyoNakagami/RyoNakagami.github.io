---
layout: post
title: "zshの設定とinteractive shellのカスタマイズ"
subtitle: "Ubuntu Desktop環境構築 Part 10"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-08
reading_time: 10
tags:

- Ubuntu 20.04 LTS
- Shell
---

||概要|
|---|---|
|目的|zshの設定とinteractive shellのカスタマイズ|
|実行環境OS|Ubuntu 20.04 LTS|

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [2. zshとは](#2-zsh%E3%81%A8%E3%81%AF)
  - [カーネルとシェル](#%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E3%81%A8%E3%82%B7%E3%82%A7%E3%83%AB)
  - [シェルの種類：Login shellとinteractive shell](#%E3%82%B7%E3%82%A7%E3%83%AB%E3%81%AE%E7%A8%AE%E9%A1%9Elogin-shell%E3%81%A8interactive-shell)
  - [zshの機能](#zsh%E3%81%AE%E6%A9%9F%E8%83%BD)
  - [zshのstartup files](#zsh%E3%81%AEstartup-files)
    - [各Startup Fileの棲み分け](#%E5%90%84startup-file%E3%81%AE%E6%A3%B2%E3%81%BF%E5%88%86%E3%81%91)
- [3. zshのインストール](#3-zsh%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Interactive shellのカスタマイズ](#4-interactive-shell%E3%81%AE%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%9E%E3%82%A4%E3%82%BA)
  - [設定ディレクトリ構成](#%E8%A8%AD%E5%AE%9A%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E6%A7%8B%E6%88%90)
  - [(1) ヒストリーサイズの再設定](#1-%E3%83%92%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%82%B5%E3%82%A4%E3%82%BA%E3%81%AE%E5%86%8D%E8%A8%AD%E5%AE%9A)
  - [(2) Zshのgit command補完を有効にする](#2-zsh%E3%81%AEgit-command%E8%A3%9C%E5%AE%8C%E3%82%92%E6%9C%89%E5%8A%B9%E3%81%AB%E3%81%99%E3%82%8B)
  - [(3) Interactive shellにgit branchをシンプルに表示](#3-interactive-shell%E3%81%ABgit-branch%E3%82%92%E3%82%B7%E3%83%B3%E3%83%97%E3%83%AB%E3%81%AB%E8%A1%A8%E7%A4%BA)
  - [(4) lsやgrepコマンドを実行した結果で表示される項目のうち,ディレクトリやシンボリックリンクファイルの場合,色や記号が付与されるようにする](#4-ls%E3%82%84grep%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%9F%E7%B5%90%E6%9E%9C%E3%81%A7%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%82%8B%E9%A0%85%E7%9B%AE%E3%81%AE%E3%81%86%E3%81%A1%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%84%E3%82%B7%E3%83%B3%E3%83%9C%E3%83%AA%E3%83%83%E3%82%AF%E3%83%AA%E3%83%B3%E3%82%AF%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E5%A0%B4%E5%90%88%E8%89%B2%E3%82%84%E8%A8%98%E5%8F%B7%E3%81%8C%E4%BB%98%E4%B8%8E%E3%81%95%E3%82%8C%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)
  - [(5) `cd`コマンドを実行した際に,ファイル一覧が確認できるようにする](#5-cd%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%9F%E9%9A%9B%E3%81%AB%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E4%B8%80%E8%A6%A7%E3%81%8C%E7%A2%BA%E8%AA%8D%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)
  - [(6) zshでコメントアウトを有効にする](#6-zsh%E3%81%A7%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E6%9C%89%E5%8A%B9%E3%81%AB%E3%81%99%E3%82%8B)
  - [(7) 自作関数：ファイル解凍コマンド`unpack`の設定](#7-%E8%87%AA%E4%BD%9C%E9%96%A2%E6%95%B0%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E8%A7%A3%E5%87%8D%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89unpack%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [`~.zshrc`での設定のまとめ](#zshrc%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%81%AE%E3%81%BE%E3%81%A8%E3%82%81)
- [Appendix: `/proc`ディレクトリのファイル](#appendix-proc%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)
- [Appendix: chshコマンド](#appendix-chsh%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
> やりたいこと

1. zshのインストール
2. interactive shellにgit branchをシンプルに表示
3. zshのgit command補完を有効にする
4. lsやgrepコマンドを実行した結果で表示される項目のうち,ディレクトリやシンボリックリンクファイルの場合,色や記号が付与されるようにする
5. zshでコメントアウトを有効にする
6. VS Codeのターミナルでもこの結果が反映されるようにする

> 方針

1. apt package managerからzshをインストール
2. `~/.zshrc`ファイルを編集する

## 2. zshとは
### カーネルとシェル


> カーネルとは

コンピューターのハードウェアを制御して, アプリケーションの実行環境やインターフェースを提供するのがOSの役割です. OSの主な役割の具体例は,

1. キー入力などのコンピューター操作のインターフェースの提供
2. アプリケーションが共通で使う機能を提供
3. 面倒で複雑なハードウェア制御をアプリケーションの代わりに担当
4. メモリ管理やプログラムの実行制御

カーネルとはOSの核になる部分（種子の内部の核=カーネル）のことです. カーネルプログラムによってコンピューターを構成するハードウェアとソフトウェアが管理されています. カーネルプログラム本体は `/boot/` ディレクトリ下の `vmlinuz` とかで存在を確認することができます. 現在使用しているカーネルのバージョンを確認するには以下のいずれかのコマンドで確認できます

```
$ cat /proc/version   
Linux version 5.4.0-58-generic (buildd@lcy01-amd64-004) (gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)) #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020
```

または

```
$ uname -sr        
Linux 5.4.0-58-generic
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20201223-Linux-kernel-image.png?raw=true">


> シェルとは

シェルは,ユーザーの命令をカーネルに伝える機能を持っています. 種子の内部の核=カーネルに対して, 種子の殻=シェルから名付けられています. カーネルはハードウェアと密接に関連しており,ユーザーの命令が機械語で書かれない限り,その命令を直接理解する能力がありません. そこでシェルという窓口を通して,命令をカーネルに伝えます.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/terminal/20201225_shell_kernel.png?raw=true">

> シェルの種類


sh|Bourneシェル.動作は高速だが機能が貧弱という特徴がある.bシェルとも呼ばれる.
bash|Bourneシェルを大幅に改良したBourne Again SHell.シェルスクリプトは基本的にこれで記述する方針.
csh|DSD系UNIXで使われたシェル.C言語風のコマンド構文を持っているのが特徴.
tcsh|cshを改良したシェル
ash|shの代替となる,小型かつ高速なシェル.
dash|Debian版ash. 動作が軽量高速という特徴がある./bin/shはシンボリックリンク.
zsh|bシェルを拡張したシェル.bashやtcshの機能を取り入れた強力なシェルだが,その代わり動作が少し遅い.
fish|比較的新しいユーザーフレンドリーなシェル

シェルの切り替えは以下のように簡単にできる

```
login_username@host_name ~ % sh
$ 
$ exit
login_username@host_name ~ % bash
login_username@host_name:~$ 
login_username@host_name:~$ exit
exit
login_username@host_name ~ % 
```

### シェルの種類：Login shellとinteractive shell

Login shellとinteractive shellを知ることでシェルの設定ファイルがそれぞれどのような役割をしているかを理解することができます.

シェルはLogin shellか否か,interactive shellか否かで分類することができます. ログインシェルはローカルおよびリモートの ssh 経由でコンソールにログインするか,または明確に `zsh --login` コマンドを実行してログインする際に実行されます.ログインシェルか否かに関わらず,シェルは対話的 (たとえば xterm 系ターミナルの中で実行される場合) にもなれば,非対話的 (スクリプトとして実行される場合) にもなります. 分類を整理すると以下の４つです：

- 対話的なログインシェル
- 非対話的なログインシェル
- 対話的な非ログインシェル
- 非対話的な非ログインシェル

> 対話的なシェルと非対話的なシェル

|分類|説明|
|---|---|
|対話的なシェル|対話的な(インタラクティブ)シェルは,端末を起動したときのようにキーボードからのコマンド入力を受け付けているシェル.つまり仮想コンソールやsshによるログインもそう.その他として,bash -i シェルスクリプトで実行したものがある.|
|非対話的なシェル|デスクトップ画面にログインしたときや,シェルスクリプトを通常実行した際に起動されたシェル.他にscpコマンドでファイル送受信した際や,sshにリモートで実行するコマンドを付加した際にリモートで起動されたシェル. |

> ログインシェルと非ログインシェル

- ログインシェル
  - デスクトップ画面にログインしたときに起動されたシェル
  - 仮想コンソールでログインしたときに起動されたシェル
  - sshでログインしたときに起動されたシェル
  - `su - ユーザ`でログインしたシェル
  - `bash -l` シェルスクリプトで実行したもの
- 非ログインシェル
  - デスクトップ画面から端末起動したときのシェル,さらにその新タブを開いたときのシェル
  - `su ユーザ`や単にbashと打って切り替えたシェル
  - シェルスクリプトを通常実行した際に起動されたシェル
  - scpコマンドでファイル送受信した際や,sshにリモートで実行するコマンドを付加した際にリモートで起動されたシェル

zshでterminalで起動しているシェルがlogin shell出ないことの確認方法は以下：

```
if [[ -o login ]]; then
  echo "I'm a login shell"
else
  echo "I'm not a login shell"
fi
```

### zshの機能

- Command-lineでの強力な補完機能
- 実行履歴をすべてのシェルで共有できる
- ユーザーフレンドリーな変数と配列操作
- named directoryを扱うことができる
- login shellとnot login shell両方に共通に読まれる設定ファイル`/etc/zshenv`と`~/.zshenv`がある
- Oh My Zshのような強力なPlug-inがある

named directory機能の例：
```
login_username@host_name ~ % test=~/Desktop
login_username@host_name ~ % cd ~test      
login_username@host_name ~test
 % pwd
/home/login_username/Desktop
```

### zshのstartup files

startup fileは`/etc/`と`~/`の２つのクラスがあります.`/etc/`クラスはthe system administratorによって設定され,すべてのユーザーに対して実行されます.各ユーザーが独自に設定したい場合は`~/`クラスのファイルを編集します.

|File|説明|
|---|---|
|`/etc/zshenv`|Always run for every zsh.|
|`~/.zshenv`|Usually run for every zsh.|
|`/etc/zprofile`|Run for login shells.|
|`~/.zprofile`|Run for login shells.|
|`/etc/zshrc`|Run for interactive shells.|
|`~/.zshrc`|Run for interactive shells.|
|`/etc/zlogin`|Run for login shells.|
|`~/.zlogin`|Run for login shells. |
|`/etc/zlogout`|Run for login shells.(ログアウト時に読み取る)|
|`~/.zlogout`|Run for login shells.(ログアウト時に読み取る)|


`~/.zprofile`と`~/.zlogin`に違いは読まれるタイミングです.Login shellで読まれる順番は以下のとおりです：

1. `~/.zshenv`
2. `~/.zprofile`
3. `~/.zshrc`
4. `~/.zlogin`

#### 各Startup Fileの棲み分け

|Case|設定先|
|---|---|
|コマンドが非対話的に実行する必要がある場合|_.zshenv_|
|新しいシェルごとに更新する必要がある場合|_.zshenv_|
|完了するまでに時間がかかる可能性があるコマンドを実行する場合|_.zprofile_|
|interactive usageに関連している場合|_.zshrc_|
|シェルが完全にセットアップされたときに実行されるコマンドの場合|_.zlogin_|
|リソースを解放する場合ログイン時に取得|_.zlogout_|

## 3. zshのインストール

zshのインストールはapt package manager経由でも最新版を取得できます.

```
$ sudo apt install zsh
```

インストールされたzshのversionを確認する場合は

```
$ zsh --version
zsh 5.8 (x86_64-ubuntu-linux-gnu)
```

次にzshをdefault login shellとして設定します.

```
chsh -s $(which zsh)
```

シェルが変更されたかどうかを確認したい場合は

```
% echo $SHELL
/usr/bin/zsh
```

と表示されれば問題ありません.

## 4. Interactive shellのカスタマイズ

今回僕が実現したいことは以下の7つです：

1. ヒストリーサイズの再設定
2. Zshのgit command補完を有効にする
3. Interactive shellにgit branchをシンプルに表示
4. `ls`や`grep`コマンドを実行した結果で表示される項目のうち,ディレクトリやシンボリックリンクファイルの場合,色や記号が付与されるようにする
5. `cd`コマンドを実行した際に,ファイル一覧が確認できるようにする
6. zshでコメントアウトを有効にする
7. 自作関数：ファイル解凍コマンド`unpack`の設定

> Oh My Zshを用いない理由

ZshのInteractive shellの拡張として有名なものに[oh my zsh](https://ohmyz.sh/)があり,インストールと簡単な設定だけで僕が求めている機能を実装することができます. しかし,

1. バージョン管理をしなくてはならないパッケージが増える
2. あまり使わなさそうなショートカットコマンドがたくさん入ってきて,コマンド管理がややこしくなりそう
3. zshコマンドの実行速度が落ちそうという不安
4. 自分が選択したOh-my-Zshのテーマがいつまでメンテナンスされるかわからない
5. Zinitといった他の有力な拡張ツールもありどれがいいのかわからない
6. 僕が求めている機能は自分でも簡単に設定できる
7. 必要な拡張機能はVS CodeのExtensionsに求めるべきでは？

といった理由から今回の導入を見送りました.

### 設定ディレクトリ構成

プラグインやパッケージ管理の観点から以下のような構成にします.

```
~
├── .zshrc                    # シェルを起動する毎に読み込まれる.
├── .zshenv                   # ログイン時に一度だけ読み込まれる.
└── .zsh.d                    # zsh関連のファイル置き場.
       ├── config             # 標準機能以外の設定を置くディレクトリ.
       │    └── packages.zsh # 追加パッケージの設定をするファイル.
       ├── zshrc              # おすすめ~/.zshrc設定.
       ├── zshenv             # おすすめ~/.zshenv設定.
       ├── package.zsh        # パッケージ管理システム.
       └── packages           # パッケージをインストールするディレクトリ.
```

### (1) ヒストリーサイズの再設定

ヒストリーサイズが小さいと振り返りがしづらくなるので変更する.

```zsh
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=$HISTSIZE 
HISTFILE=~/.zsh_history
setopt extended_history ## ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する.
setopt hist_ignore_space ## スペースで始まるコマンドラインはヒストリに追加しない.
setopt inc_append_history ## すぐにヒストリファイルに追記する.
setopt share_history ## zshプロセス間でヒストリを共有する.
```

### (2) Zshのgit command補完を有効にする

Zshには,Git用のタブ補完ライブラリも同梱されています.`.zshrc`に`autoload -Uz compinit && compinit`という行を追加するだけで,使えるようになります.使用感は以下のような感じです.

```
% git che<tab>
check-attr        -- display gitattributes information
check-ref-format  -- ensure that a reference name is well formed
checkout          -- checkout branch or paths to working tree
checkout-index    -- copy files from index to working directory
cherry            -- find commits not merged upstream
cherry-pick       -- apply changes introduced by some existing commits
```

### (3) Interactive shellにgit branchをシンプルに表示

目指したい形はTerminal上に以下の表示をさせることです

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/terminal/20201225_git_zsh.png?raw=true">

求める要件は以下：

- カレントディレクトリがgit管理下ならば,いまの自分がどのブランチにいるかターミナル上の目障りじゃないところに表示する
- stagingにaddされていないファイルがあるならば`?`を表示,commitされていないファイルがあるならば`!`を表示
- VSCodeのターミナルでも表示される

> Requirement

- パワーライン用のフォント

apt package manager経由でインストールします.

```zsh
% sudo apt install powerline
```

> `~/.zshrc`での書き方

```zsh
## visualize git brach
### precmd
precmd () { vcs_info }

### プロンプトが表示されるたびにプロンプト文字列を評価,置換する
setopt prompt_subst

function rprompt-git-current-branch {
  ## Requirement: visualize git brach
  ##  - autoload -Uz vcs_info

  local branch_name st branch_status
  
  branch='\ue0a0'
  color='%{\e[38;5;' #  文字色を設定
  green='114m%}'
  red='001m%}'
  yellow='227m%}'
  blue='033m%}'
  reset='%{\e[0m%}'   # reset

  branch_name=$(echo $vcs_info_msg_0_ |awk -F - '{ print $2 }'|tr -d '[\[\]]')
  #branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`

  if [ -z "$branch_name" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="${color}${green}${branch}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="${color}${red}${branch}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="${color}${red}${branch}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="${color}${yellow}${branch}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "${color}${red}${branch}!(no branch)${reset}"
    return
  else
    # 上記以外の状態の場合
    branch_status="${color}${blue}${branch}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}$branch_name${reset}"
}
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'
```

> VS Code上のターミナルでの文字化け防止

VS Codeが許容している文字クラスを用いないとバグります.実行環境はUbintu 20.04 LTSなので`Ubuntu mono, PowerlineSymbols`を今回は用います.まず,`Ctrl+Shift+P`で`Preference > Open Settings(JSON)`を開きます.そして以下の行を付け足します.

```
"terminal.integrated.fontFamily": "Ubuntu mono, PowerlineSymbols"
```

### (4) lsやgrepコマンドを実行した結果で表示される項目のうち,ディレクトリやシンボリックリンクファイルの場合,色や記号が付与されるようにする

基本的にはoptionの`--color=auto`と`ls -F`を参考に設定するだけです.`-F` オプションもつけておくことで実行ファイルにはファイル名末尾に`*`, ディレクトリなら`/`, シンボリックリンクなら`@`がつくようになります.

```zsh
## alias with color
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
```

### (5) `cd`コマンドを実行した際に,ファイル一覧が確認できるようにする

```zsh
# ファイル数が多い時には省略表示
# (参考: https://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059)
# chpwd(カレントディレクトリが変更したとき)にls_abbrevを実行
ls_abbrev() {
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls=/usr/bin/ls
    local -a opt_ls
    opt_ls=('-CF' '--color=always' '--group-directories-first')

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') objects exist"
    else
        echo "$ls_result"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd ls_abbrev
```


### (6) zshでコメントアウトを有効にする

コメントアウトできるようになると実行履歴検索(`Ctrl+R`)が用意になるので設定しときます.以下の行を`~/.zshrc`に書き加えるだけですみます.

```zsh
setopt interactivecomments #20201225追加
```

### (7) 自作関数：ファイル解凍コマンド`unpack`の設定

圧縮されたファイルやディレクトリを解凍する場合,保存形式に合わせてunzip, gunzipなどのコマンドを用いる必要があります.それがめんどくさいので開くだけならどのファイル形式にも対応してくれる`unpack`という関数を自作して,コマンドラインから実行できるように設定します.方針は以下です：

1. `unpack`関数を定義したシェルスクリプトを作成
2. シェルスクリプトのPermissonを変更する
3. `.zshrc`ファイルを編集してPATHを通す

なお,`unpack`は7-Zipファイルにも対応しているので,事前にapt package manager fileの`p7zip-full`をインストールしてください.「7-Zip（セブンジップ）」とは,2000年頃イーゴリ・パヴロフ 氏により開発が始まったオープンソースのファイルアーカイバです.写真やデザイン,またパソコン上で使用したあらゆるデータなどを外部に配信する際に内容量を圧縮し,また解凍を行うことができます.主にMicrosoft WindowsやLinuxで使用できます.

```
% sudo apt install p7zip-full
```

> `unpack`関数を定義したシェルスクリプトを作成

`unpack`という名前のファイルを作成する.

```bash
#!/usr/bin/bash
# unpack: Extract common file formats
 
# Dependencies: unrar, unzip, p7zip-full

# Author: Patrick Brisbin
# From: http://linuxtidbits.wordpress.com/2009/08/04/week-of-bash-scripts-extract/

# Display usage if no parameters given
if [[ -z "$@" ]]; then
	echo " ${0##*/} <archive> - extract common file formats)"
	exit
fi
 
# Required program(s)
req_progs=(7z unrar unzip)
for p in ${req_progs[@]}; do
	hash "$p" 2>&- || \
	{ echo >&2 " Required program \"$p\" not installed."; exit 1; }
done
 
# Test if file exists
if [ ! -f "$@" ]; then
	echo "File "$@" doesn't exist"
	exit
fi
 
# Extract file by using extension as reference
case "$@" in
	*.7z ) 7z x "$@" ;;
	*.tar.bz2 ) tar xvjf "$@" ;;
	*.bz2 ) bunzip2 "$@" ;;
	*.deb ) ar vx "$@" ;;
	*.tar.gz ) tar xvf "$@" ;;
	*.gz ) gunzip "$@" ;;
	*.tar ) tar xvf "$@" ;;
	*.tbz2 ) tar xvjf "$@" ;;
	*.tar.xz ) tar xvf "$@" ;;
	*.tgz ) tar xvzf "$@" ;;
	*.rar ) unrar x "$@" ;;
	*.zip ) unzip "$@" ;;
	*.Z ) uncompress "$@" ;;
	* ) echo " Unsupported file format" ;;
esac
```

> シェルスクリプトのPermissonを変更する

```zsh
% chmod 755 unpack
```

> `.zshrc`ファイルを編集してPATHを通す

`~/bin`というディレクトリを作り,その下に`unpack`ファイルが存在しています.

```zsh
## unpackコマンド追加
export PATH="$HOME/bin:$PATH"
```

### `~.zshrc`での設定のまとめ

１つ１つ説明していきましたが,まとめると下のような設定になります.これを`~/.zshrc`に書き加えれば終了です.

```zsh
# -----------------------------
# General
# -----------------------------
## clear settings
unalias -a

## autoload
autoload -Uz promptinit 
autoload -Uz add-zsh-hook 
autoload -Uz vcs_info

## Set up the prompt
promptinit
prompt adam1

setopt histignorealldups
setopt interactivecomments


## Permission初期値調整
umask u=rwx,g=rx,o=r

# -----------------------------
# History
# -----------------------------
## Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt extended_history # 履歴ファイルにzsh の開始・終了時刻を記録する
setopt hist_ignore_space
setopt inc_append_history
setopt share_history # 履歴を複数の端末で共有する

# -----------------------------
# PATH
# -----------------------------
# 重複パスを登録しない
typeset -U path PATH

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# PATH on xsv 20201229 update
export PATH="$HOME/.xsv.d:$PATH"

# PATH on unpack 20210101 update
export PATH="$HOME/bin:$PATH"



#-------------------------------------
# GitHub
#-------------------------------------
## set access token
## 例:git clone https://UserName:${GIT_TOKEN}@github.com/repositoryowner/repositoryname
export GIT_USER=<hogehoge>
export GIT_TOKEN=<hogehoge>
export GIST_TOKEN=<hogehoge>

export GITLAB_SEP_USER=<hogehoge>
export GITLAB_SEP_TOKEN=<hogehoge>


#-------------------------------------
# python
#-------------------------------------
## pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

## pyenv virtualenv setup
eval "$(pyenv virtualenv-init -)"

## Jupyter
export PATH="$HOME/.nodebrew/current/bin:$PATH"
#export PATH="$HOME/.local/bin:$PATH"


# rbenv setup
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"

#-------------------------------------
# R
#-------------------------------------



# -----------------------------
# Completion
# -----------------------------
## Use modern completion system
autoload -Uz compinit && compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

setopt complete_in_word

#-------------------------------------
# Alias settings
#-------------------------------------
## alias with color
alias ls='ls -F --color=auto --group-directories-first'
alias grep='grep --color=auto'

## 自作alias
alias xclipimage='xclip -selection clipboard -t image/png -o > "$(date +%Y-%m-%d_%T).png"' 
alias start_processing='~/processing-3.5.4/processing'
alias rt='wmctrl -l| grep ryo-nak-amaterasu\\s/usr/bin/zsh$|awk -F " " "{print $1}"|xargs -i% wmctrl -i -r % -e 0,0,0,724,660'
alias bfg='java -jar ~/tools/bfg/bfg-1.14.0.jar'

## git-related
alias git_add_modified='git ls-files --modified | xargs git add'
alias git_add_modified_all='git diff-files --diff-filter=M --name-only --line-prefix=$(git rev-parse --show-toplevel)/|xargs git add'

alias git_rm_deleted='git ls-files --deleted | xargs git add'
alias git_rm_deleted_all='git diff-files --diff-filter=D --name-only --line-prefix=$(git rev-parse --show-toplevel)/|xargs git add'

#-------------------------------------
# functions
#-------------------------------------
## code-wrapper: /usr/bin/codeのラッパー関数
## カレントディレクトリに強制的に指定したファイルを作成 & openするオプションを追加

function code-wrapper() {
  if [[ $# == 2 ]] && { [[ $1 == '-f' ]] || [[ $1 == '--force' ]]}; then
      touch $2;
      code $2
  elif [[ $# == 1 ]] && { [[ $1 == '-l' ]] || [[ $1 == '--location' ]]}; then
      which code
  else
      code $@
  fi
}

alias code='code-wrapper'

## ファイル数が多い時には省略表示
ls_abbrev() {
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-CF' '--color=always')

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd ls_abbrev

## visualize git brach
function rprompt-git-current-branch {
  local branch_name st branch_status
  
  branch='\ue0a0'
  color='%{\e[38;5;' #  文字色を設定
  green='114m%}'
  red='001m%}'
  yellow='227m%}'
  blue='033m%}'
  reset='%{\e[0m%}'   # reset
  
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="${color}${green}${branch}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="${color}${red}${branch}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="${color}${red}${branch}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="${color}${yellow}${branch}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "${color}${red}${branch}!(no branch)${reset}"
    return
  else
    # 上記以外の状態の場合
    branch_status="${color}${blue}${branch}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}$branch_name${reset}"
}
 
# プロンプトが表示されるたびにプロンプト文字列を評価,置換する
setopt prompt_subst
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

```

## Appendix: `/proc`ディレクトリのファイル

`/proc` ディレクトリは普通のファイルシステムと違い,ハードディスクやSSDなどのストレージ上ではなくメモリの中に作られるファイルシステムです. mountコマンドで確認してみると `/proc` ディレクトリが他と異なる場所にあります.

```
$ mount
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
(略)
```

`/proc`にあるファイルは普通のファイルではなく,「仮想ファイル」という特殊な形式となっています.lsコマンドで確認してみると,`/proc`にあるファイルはサイズが0になっている上,タイムスタンプもほとんどのファイルで現在時刻になっています.

```
$ ls-la /proc
(略)
dr-xr-xr-x   9 root             root                           0 Dec 25 11:23 11
dr-xr-xr-x   9 root             root                           0 Dec 25 11:23 115
dr-xr-xr-x   9 root             root                           0 Dec 25 11:23 116
dr-xr-xr-x   9 root             root                           0 Dec 25 11:23 117
dr-xr-xr-x   9 root             root                           0 Dec 25 11:23 1198
dr-xr-xr-x   9 root             root                           0 Dec 25 11:23 12
dr-xr-xr-x   9 root             root                           0 Dec 25 11:23 120
(略)
```

`/proc`ディレクトリにあるファイルは,システムをコントロールするために使われます.そのため,システムのさまざまな情報がここに格納されています.意味もわからずに/procの内容を変更するとシステムが壊れるので直接編集は基本的にだめです.たとえば`/proc/sys/`ディレクトリのファイルには,カーネルの諸設定をオン／オフが記載されており,ここのファイルの内容を書き換えることによって,さまざまなカーネル設定を有効化／無効化することができます.もし編集したい場合は`/etc/sysctl.conf`というファイルが用意されているのでこちらを編集します.

> CPU infoの確認

```zsh
% cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 158
model name	: Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz
stepping	: 13
microcode	: 0xf0
cpu MHz		: 3000.000
cache size	: 12288 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
...(略)
```


## Appendix: chshコマンド

> 機能

- ログインするときに使用するシェルを変更するコマンド
- 一般ユーザは自分のアカウントのログインシェルのみを変更できるが, スーパーユーザは全てのアカウントのログインシェルを変更できます

> Syntax

```zsh
chsh [-s login_shell] [user]
```

> Options

---|---
`-h, --help`            |ヘルプメッセージの表示
`-R, --root CHROOT_DIR` |directory to chroot into
`-s, --shell SHELL`     |現在のユーザーのログインシェルを設定

> 例

```bash
#bashに変更
chsh -s /bin/bash
```

> 設定可能なログインシェルリストの表示

設定可能なシェルは`/etc/shells`ファイルに登録されているのでこれを表示させれば十分です.

```zsh
% cat /etc/shells
# /etc/shells: valid login shells
/bin/sh
/bin/bash
/usr/bin/bash
/bin/rbash
/usr/bin/rbash
/bin/dash
/usr/bin/dash
/bin/zsh
/usr/bin/zsh
```


## References
### オンラインマテリアル

- [Zsh公式ページ](https://www.zsh.org/)
- [Terminator Document](https://terminator-gtk3.readthedocs.io/en/latest/)
- [bashとzshの違い](https://mac-ra.com/catalina-zsh/#toc_id_2)
- [bash の初期化ファイル .profile, .bashrc, .bash_profile の使い分けと管理方針](https://blog1.mammb.com/entry/2019/12/01/090000)
- [ZshでGit用のタブ補完ライブラリを使う](https://git-scm.com/book/ja/v2/Appendix-A%3A-%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AE%E7%92%B0%E5%A2%83%E3%81%A7%E3%81%AEGit-Zsh%E3%81%A7Git%E3%82%92%E4%BD%BF%E3%81%86)
- [とみぃ研究所:zshのプロンプトをカッコよくしてGitのブランチを表示させる](https://tomiylab.com/2020/03/prompt/)
- [備忘録(zsh)](https://www-tap.scphys.kyoto-u.ac.jp/~shima/zsh.php)|
- [stackoverflow >> double square brackets preferable](https://stackoverflow.com/questions/669452/are-double-square-brackets-preferable-over-single-square-brackets-in-b)
