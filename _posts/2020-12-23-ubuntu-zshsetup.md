---
layout: post
title: "Ubuntu Desktop環境構築 Part 10"
subtitle: "zshの設定とinteractive shellのカスタマイズ"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Shell
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|zshの設定とinteractive shellのカスタマイズ|
|参考|- [Zsh公式ページ](https://www.zsh.org/)<br>- [Terminator Document](https://terminator-gtk3.readthedocs.io/en/latest/)<br>- [bashとzshの違い](https://mac-ra.com/catalina-zsh/#toc_id_2)<br>- [bash の初期化ファイル .profile, .bashrc, .bash_profile の使い分けと管理方針](https://blog1.mammb.com/entry/2019/12/01/090000)<br>- [ZshでGit用のタブ補完ライブラリを使う](https://git-scm.com/book/ja/v2/Appendix-A%3A-%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AE%E7%92%B0%E5%A2%83%E3%81%A7%E3%81%AEGit-Zsh%E3%81%A7Git%E3%82%92%E4%BD%BF%E3%81%86)<br>- [とみぃ研究所:zshのプロンプトをカッコよくしてGitのブランチを表示させる](https://tomiylab.com/2020/03/prompt/)<br>- [備忘録(zsh)](https://www-tap.scphys.kyoto-u.ac.jp/~shima/zsh.php)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [方針](#%E6%96%B9%E9%87%9D)
- [2. zshとは](#2-zsh%E3%81%A8%E3%81%AF)
  - [カーネルとシェル](#%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E3%81%A8%E3%82%B7%E3%82%A7%E3%83%AB)
    - [カーネルとは](#%E3%82%AB%E3%83%BC%E3%83%8D%E3%83%AB%E3%81%A8%E3%81%AF)
    - [シェルとは](#%E3%82%B7%E3%82%A7%E3%83%AB%E3%81%A8%E3%81%AF)
  - [シェルの種類：Login shellとinteractive shell](#%E3%82%B7%E3%82%A7%E3%83%AB%E3%81%AE%E7%A8%AE%E9%A1%9Elogin-shell%E3%81%A8interactive-shell)
    - [対話的なシェルと非対話的なシェル](#%E5%AF%BE%E8%A9%B1%E7%9A%84%E3%81%AA%E3%82%B7%E3%82%A7%E3%83%AB%E3%81%A8%E9%9D%9E%E5%AF%BE%E8%A9%B1%E7%9A%84%E3%81%AA%E3%82%B7%E3%82%A7%E3%83%AB)
    - [ログインシェルと非ログインシェル](#%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%82%B7%E3%82%A7%E3%83%AB%E3%81%A8%E9%9D%9E%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%82%B7%E3%82%A7%E3%83%AB)
  - [zshの機能](#zsh%E3%81%AE%E6%A9%9F%E8%83%BD)
  - [zshのstartup files](#zsh%E3%81%AEstartup-files)
    - [各Startup Fileの棲み分け](#%E5%90%84startup-file%E3%81%AE%E6%A3%B2%E3%81%BF%E5%88%86%E3%81%91)
- [3. zshのインストール](#3-zsh%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [4. Interactive shellのカスタマイズ](#4-interactive-shell%E3%81%AE%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%9E%E3%82%A4%E3%82%BA)
  - [Oh My Zshを用いない理由](#oh-my-zsh%E3%82%92%E7%94%A8%E3%81%84%E3%81%AA%E3%81%84%E7%90%86%E7%94%B1)
  - [設定ディレクトリ構成](#%E8%A8%AD%E5%AE%9A%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E6%A7%8B%E6%88%90)
  - [(1) ヒストリーサイズの再設定](#1-%E3%83%92%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%82%B5%E3%82%A4%E3%82%BA%E3%81%AE%E5%86%8D%E8%A8%AD%E5%AE%9A)
  - [(2) Zshのgit command補完を有効にする](#2-zsh%E3%81%AEgit-command%E8%A3%9C%E5%AE%8C%E3%82%92%E6%9C%89%E5%8A%B9%E3%81%AB%E3%81%99%E3%82%8B)
  - [(3) Interactive shellにgit branchをシンプルに表示](#3-interactive-shell%E3%81%ABgit-branch%E3%82%92%E3%82%B7%E3%83%B3%E3%83%97%E3%83%AB%E3%81%AB%E8%A1%A8%E7%A4%BA)
    - [Requirement](#requirement)
    - [`~/.zshrc`での書き方](#zshrc%E3%81%A7%E3%81%AE%E6%9B%B8%E3%81%8D%E6%96%B9)
    - [VS Code上のターミナルでの文字化け防止](#vs-code%E4%B8%8A%E3%81%AE%E3%82%BF%E3%83%BC%E3%83%9F%E3%83%8A%E3%83%AB%E3%81%A7%E3%81%AE%E6%96%87%E5%AD%97%E5%8C%96%E3%81%91%E9%98%B2%E6%AD%A2)
  - [(4) lsやgrepコマンドを実行した結果で表示される項目のうち、ディレクトリやシンボリックリンクファイルの場合、色や記号が付与されるようにする](#4-ls%E3%82%84grep%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%9F%E7%B5%90%E6%9E%9C%E3%81%A7%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%82%8B%E9%A0%85%E7%9B%AE%E3%81%AE%E3%81%86%E3%81%A1%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%84%E3%82%B7%E3%83%B3%E3%83%9C%E3%83%AA%E3%83%83%E3%82%AF%E3%83%AA%E3%83%B3%E3%82%AF%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E5%A0%B4%E5%90%88%E8%89%B2%E3%82%84%E8%A8%98%E5%8F%B7%E3%81%8C%E4%BB%98%E4%B8%8E%E3%81%95%E3%82%8C%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)
  - [(5) `cd`コマンドを実行した際に、ファイル一覧が確認できるようにする](#5-cd%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%9F%E9%9A%9B%E3%81%AB%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E4%B8%80%E8%A6%A7%E3%81%8C%E7%A2%BA%E8%AA%8D%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)
  - [(6) zshでコメントアウトを有効にする](#6-zsh%E3%81%A7%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E6%9C%89%E5%8A%B9%E3%81%AB%E3%81%99%E3%82%8B)
  - [(7) 自作関数：ファイル解凍コマンド`unpack`の設定](#7-%E8%87%AA%E4%BD%9C%E9%96%A2%E6%95%B0%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E8%A7%A3%E5%87%8D%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89unpack%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [`unpack`関数を定義したシェルスクリプトを作成](#unpack%E9%96%A2%E6%95%B0%E3%82%92%E5%AE%9A%E7%BE%A9%E3%81%97%E3%81%9F%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%82%92%E4%BD%9C%E6%88%90)
    - [シェルスクリプトのPermissonを変更する](#%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%AEpermisson%E3%82%92%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B)
    - [`.zshrc`ファイルを編集してPATHを通す](#zshrc%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E7%B7%A8%E9%9B%86%E3%81%97%E3%81%A6path%E3%82%92%E9%80%9A%E3%81%99)
  - [`~.zshrc`での設定のまとめ](#zshrc%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%81%AE%E3%81%BE%E3%81%A8%E3%82%81)
- [Appendix: /procディレクトリのファイル](#appendix-proc%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

1. zshのインストール
2. interactive shellにgit branchをシンプルに表示
3. zshのgit command補完を有効にする
4. lsやgrepコマンドを実行した結果で表示される項目のうち、ディレクトリやシンボリックリンクファイルの場合、色や記号が付与されるようにする
5. zshでコメントアウトを有効にする
6. VS Codeのターミナルでもこの結果が反映されるようにする

### 方針

1. apt package managerからzshをインストール
2. `~/.zshrc`ファイルを編集する

## 2. zshとは
### カーネルとシェル
#### カーネルとは
カーネルとはOSの核になる部分でOSそのもののことです。Ubuntu 20.04 LTSのカーネルのバージョンを確認するには以下のいずれかのコマンドで確認できます

```
$ cat /proc/version   
Linux version 5.4.0-58-generic (buildd@lcy01-amd64-004) (gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)) #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020
```

または

```
$ uname -sr        
Linux 5.4.0-58-generic
```

#### シェルとは

シェルは、ユーザーの命令をケーネルに伝える機能を持っています。カーネルはハードウェアと密接に関連しており、ユーザーの命令を直接理解する能力がありません。そこで、シェルという窓口を通して、命令をカーネルに伝えます。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/linux/terminal/20201225_shell_kernel.png?raw=true">

|shell|説明|
|---|---|
|sh|Bourne shell。動作は高速だが機能が貧弱という特徴がある。bシェルとも呼ばれる。|
|bash|Bourneシェルを大幅に改良したBourne Again SHell。シェルスクリプトは基本的にこれで記述する方針。|
|csh|DSD系UNIXで使われたシェル。C言語風のコマンド構文を持っているのが特徴。|
|tcsh|cshを改良したシェル|
|ash|shの代替となる、小型かつ高速なシェル。|
|dash|Debian版ash。 動作が軽量高速という特徴がある。/bin/shはシンボリックリンク。|
|zsh|bシェルを拡張したシェル。bashやtcshの機能を取り入れた強力なシェルだが、その代わり動作が少し遅い。|
|fish|比較的新しいユーザーフレンドリーなシェル|

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

Login shellとinteractive shellを知ることでシェルの設定ファイルがそれぞれどのような役割をしているかを理解することができます（後述）。

シェルはLogin shellか否か、interactive shellか否かで分類することができます。ログインシェルはローカルおよびリモートの ssh 経由でコンソールにログインするか、明確に zsh --login コマンドを実行してログインする際に実行されます。ログインシェルか否かに関わらず、シェルは対話的 (たとえば xterm 系ターミナルの中で実行される場合) にもなれば、一方で非対話的 (スクリプトとして実行される場合) にもなります。 分類を整理すると以下の４つです：

- 対話的なログインシェル
- 非対話的なログインシェル
- 対話的な非ログインシェル
- 非対話的な非ログインシェル

#### 対話的なシェルと非対話的なシェル

|分類|説明|
|---|---|
|対話的なシェル|対話的な(インタラクティブ)シェルは、端末を起動したときのように、キーボードからのコマンド入力を受け付けているシェル。つまり仮想コンソールやsshによるログインもそう。その他として、bash -i シェルスクリプトで実行したもの。|
|非対話的なシェル|デスクトップ画面にログインしたときや、シェルスクリプトを通常実行した際に起動されたシェル。他に、scpコマンドでファイル送受信した際や、sshにリモートで実行するコマンドを付加した際にリモートで起動されたシェル。 |

#### ログインシェルと非ログインシェル

|分類|説明|
|---|---|
|ログインシェル|デスクトップ画面にログインしたときに起動されたシェル<br>仮想コンソールでログインしたときに起動されたシェル<br>sshでログインしたときに起動されたシェル<br>su - ユーザ(-あり)でログインしたシェル<br>bash -l シェルスクリプトで実行したもの。 |
|非ログインシェル|デスクトップ画面から端末起動したときのシェル、さらにその新タブを開いたときのシェル<br>su ユーザ(-なし)や単にbashと打って切り替えたシェル<br>シェルスクリプトを通常実行した際に起動されたシェル<br>scpコマンドでファイル送受信した際や、sshにリモートで実行するコマンドを付加した際にリモートで起動されたシェル。|

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

startup fileは`/etc/`と`~/`の２つのクラスがあります。`/etc/`クラスはthe system administratorによって設定され、すべてのユーザーに対して実行されます。各ユーザーが独自に設定したい場合は`~/`クラスのファイルを編集します。

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


`~/.zprofile`と`~/.zlogin`に違いは読まれるタイミングです。Login shellで読まれる順番は以下のとおりです：

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

zshのインストールはapt package manager経由でも最新版を取得できます。

```
$ sudo apt install zsh
```

インストールされたzshのversionを確認する場合は

```
$ zsh --version
zsh 5.8 (x86_64-ubuntu-linux-gnu)
```

次にzshをdefault login shellとして設定します。

```
chsh -s $(which zsh)
```

シェルが変更されたかどうかを確認したい場合は

```
% echo $SHELL
/usr/bin/zsh
```

と表示されれば問題ありません。

## 4. Interactive shellのカスタマイズ

今回僕が実現したいことは以下の7つです：

1. ヒストリーサイズの再設定
2. Zshのgit command補完を有効にする
3. Interactive shellにgit branchをシンプルに表示
4. `ls`や`grep`コマンドを実行した結果で表示される項目のうち、ディレクトリやシンボリックリンクファイルの場合、色や記号が付与されるようにする
5. `cd`コマンドを実行した際に、ファイル一覧が確認できるようにする
6. zshでコメントアウトを有効にする
7. 自作関数：ファイル解凍コマンド`unpack`の設定

### Oh My Zshを用いない理由

ZshのInteractive shellの拡張として有名なものに[oh my zsh](https://ohmyz.sh/)があり、インストールと簡単な設定だけで僕が求めている機能を実装することができますが、(1) バージョン管理をしなくてはならないパッケージが増える, (2) あまり使わなさそうなショートカットコマンドがたくさん入ってきて、コマンド管理がややこしくなりそう, (3) zshコマンドの実行速度が落ちそうという不安, (4) 自分が選択したOh-my-Zshのテーマがいつまでメンテナンスされるかわからない、(5) Zinitといった他の有力な拡張ツールもありどれがいいのかわからない、(6) 僕が求めている機能は自分でも簡単に設定できる、(7)必要な拡張機能はVS CodeのExtensionsに求めるべきでは？、といった理由から今回の導入を見送りました。

### 設定ディレクトリ構成

プラグインやパッケージ管理の観点から以下のような構成にします。

```
~
├── .zshrc                    # シェルを起動する毎に読み込まれる。
├── .zshenv                   # ログイン時に一度だけ読み込まれる。
└── .zsh.d                    # zsh関連のファイル置き場。
       ├── config             # 標準機能以外の設定を置くディレクトリ。
       │    └── packages.zsh # 追加パッケージの設定をするファイル。
       ├── zshrc              # おすすめ~/.zshrc設定。
       ├── zshenv             # おすすめ~/.zshenv設定。
       ├── package.zsh        # パッケージ管理システム。
       └── packages           # パッケージをインストールするディレクトリ。
```

### (1) ヒストリーサイズの再設定

ヒストリーサイズが小さいと振り返しがしづらくなるので変更する。

```zsh
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=$HISTSIZE 
HISTFILE=~/.zsh_history
setopt extended_history ## ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する。
setopt hist_ignore_space ## スペースで始まるコマンドラインはヒストリに追加しない。
setopt inc_append_history ## すぐにヒストリファイルに追記する。
setopt share_history ## zshプロセス間でヒストリを共有する。
```

### (2) Zshのgit command補完を有効にする

Zshには、Git用のタブ補完ライブラリも同梱されています。`.zshrc`に`autoload -Uz compinit && compinit`という行を追加するだけで、使えるようになります。使用感は以下のような感じです。

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

- カレントディレクトリがgit管理下ならば、いまの自分がどのブランチにいるかターミナル上の目障りじゃないところに表示する
- stagingにaddされていないファイルがあるならば`?`を表示、commitされていないファイルがあるならば`!`を表示
- VSCodeのターミナルでも表示される

#### Requirement

- パワーライン用のフォント

apt package manager経由でインストールします。

```zsh
% sudo apt install powerline
```
#### `~/.zshrc`での書き方

```zsh
## visualize git brach
function rprompt-git-current-branch {
  local branch_name st branch_status
  
  branch='\ue0a0'    #  powerlineをインストールしていないと表示がバグります
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
 
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'
```

#### VS Code上のターミナルでの文字化け防止

VS Codeが許容している文字クラスを用いないとバグります。実行環境はUbintu 20.04 LTSなので`Ubuntu mono, PowerlineSymbols`を今回は用います。まず、`Ctrl+Shift+P`で`Preference > Open Settings(JSON)`を開きます。そして以下の行を付け足します。

```
"terminal.integrated.fontFamily": "Ubuntu mono, PowerlineSymbols"
```

### (4) lsやgrepコマンドを実行した結果で表示される項目のうち、ディレクトリやシンボリックリンクファイルの場合、色や記号が付与されるようにする

基本的にはoptionの`--color=auto`と`ls -F`を参考に設定するだけです。`-F` オプションもつけておくことで実行ファイルにはファイル名末尾に`*`, ディレクトリなら`/`, シンボリックリンクなら`@`がつくようになります。

```zsh
## alias with color
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
```

### (5) `cd`コマンドを実行した際に、ファイル一覧が確認できるようにする

```zsh
# ファイル数が多い時には省略表示
# (参考: https://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059)
# chpwd(カレントディレクトリが変更したとき)にls_abbrevを実行
ls_abbrev() {
  if [[ ! -r $PWD ]]; then
    return
  fi
  # -C : Force multi-column output.
  # -F : ファイルタイプを表示
  local cmd_ls='ls'
  local -a opt_lsls
  opt_ls=('-CF' '--color=always')
  case ${OSTYPE} in
    freebsd*|darwin*)
      if (( $+commands[gls] )); then
        cmd_ls='gls'
      else
        # -G : Enable colorized output.
        opt_ls=('-aCFG')
      fi
      ;;
  esac

  local ls_result
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]}| sed $'/^\e\[[0-9;]*m$/d')

  local ls_lines=$(echo "$ls_result"| wc -l| tr -d ' ')
  if [[ ls_lines -gt 10 ]]; then
    echo "$ls_result"| head -n 5
    echo '...'
    echo "$ls_result"| tail -n 5
    echo "$(command ls -1 -A| wc -l| tr -d ' ') files exist"
  else
    echo "$ls_result"
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd ls_abbrev
```


### (6) zshでコメントアウトを有効にする

コメントアウトできるようになると実行履歴検索(`Ctrl+R`)が用意になるので設定しときます。以下の行を`~/.zshrc`に書き加えるだけですみます。

```zsh
setopt interactivecomments #20201225追加
```

### (7) 自作関数：ファイル解凍コマンド`unpack`の設定

圧縮されたファイルやディレクトリを解凍する場合、保存形式に合わせてunzip, gunzipなどのコマンドを用いる必要があります。それがめんどくさいので開くだけならどのファイル形式にも対応してくれる`unpack`という関数を自作して、コマンドラインから実行できるように設定します。方針は以下です：

1. `unpack`関数を定義したシェルスクリプトを作成
2. シェルスクリプトのPermissonを変更する
3. `.zshrc`ファイルを編集してPATHを通す

なお、`unpack`は7-Zipファイルにも対応しているので、事前にapt package manager fileの`p7zip-full`をインストールしてください。「7-Zip（セブンジップ）」とは、2000年頃イーゴリ・パヴロフ 氏により開発が始まったオープンソースのファイルアーカイバです。写真やデザイン、またパソコン上で使用したあらゆるデータなどを外部に配信する際に内容量を圧縮し、また解凍を行うことができます。主にMicrosoft WindowsやLinuxで使用できます。

```
% sudo apt install p7zip-full
```

#### `unpack`関数を定義したシェルスクリプトを作成

`unpack`という名前のファイルを作成する。

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

#### シェルスクリプトのPermissonを変更する

```zsh
% chmod 755 unpack
```

#### `.zshrc`ファイルを編集してPATHを通す

Home Directoryの下に`.bin.d`というディレクトリを作り、その下に`unpack`ファイルが存在しています。

```zsh
## unpackコマンド追加
export PATH="$HOME/.bin.d:$PATH"
```

### `~.zshrc`での設定のまとめ

１つ１つ説明していきましたが、まとめると下のような設定になります。これを`~/.zshrc`に書き加えれば終了です。

```zsh
# 20201225 update
## enable comment-out
setopt interactivecomments

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=$HISTSIZE 
HISTFILE=~/.zsh_history
setopt extended_history ## ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する。
setopt hist_ignore_space ## スペースで始まるコマンドラインはヒストリに追加しない。
setopt inc_append_history ## すぐにヒストリファイルに追記する。
setopt share_history ## zshプロセス間でヒストリを共有する。

## unpackコマンド追加
export PATH="$HOME/.bin.d:$PATH"

## Git autocompleteion libaray
autoload -Uz compinit && compinit

# --
# functions
# --
# ファイル数が多い時には省略表示
# (参考: https://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059)
# chpwd(カレントディレクトリが変更したとき)にls_abbrevを実行
ls_abbrev() {
  if [[ ! -r $PWD ]]; then
    return
  fi
  # -C : Force multi-column output.
  # -F : ファイルタイプを表示
  local cmd_ls='ls'
  local -a opt_lsls
  opt_ls=('-CF' '--color=always')
  case ${OSTYPE} in
    freebsd*|darwin*)
      if (( $+commands[gls] )); then
        cmd_ls='gls'
      else
        # -G : Enable colorized output.
        opt_ls=('-aCFG')
      fi
      ;;
  esac

  local ls_result
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]}| sed $'/^\e\[[0-9;]*m$/d')

  local ls_lines=$(echo "$ls_result"| wc -l| tr -d ' ')
  if [[ ls_lines -gt 10 ]]; then
    echo "$ls_result"| head -n 5
    echo '...'
    echo "$ls_result"| tail -n 5
    echo "$(command ls -1 -A| wc -l| tr -d ' ') files exist"
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
 
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

# --
# Alias
# --
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
```

## Appendix: /procディレクトリのファイル

/procディレクトリは、普通のファイルシステムと違い、ハードディスクやSSDなどのストレージ上ではなく、メモリの中に作られるファイルシステムです。mountコマンドで確認してみると、/procディレクトリが他と異なる場所にあります。

```
$ mount
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
(略)
```

`/proc`にあるファイルは普通のファイルではなく、「仮想ファイル」という特殊な形式となっています。lsコマンドで確認してみると、`/proc`にあるファイルはサイズが0になっている上、タイムスタンプもほとんどのファイルで現在時刻になっています。

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

`/proc`ディレクトリにあるファイルは、システムをコントロールするために使われます。そのため、システムのさまざまな情報がここに格納されています。意味もわからずに/procの内容を変更するとシステムが壊れるので直接編集は基本的にだめです。たとえば`/proc/sys/`ディレクトリのファイルには、カーネルの諸設定をオン／オフが記載されており、ここのファイルの内容を書き換えることによって、さまざまなカーネル設定を有効化／無効化することができます。もし編集したい場合は`/etc/sysctl.conf`というファイルが用意されているのでこちらを編集します。

