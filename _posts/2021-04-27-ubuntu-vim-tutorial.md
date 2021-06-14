---
layout: post
title: "Ubuntu Desktop環境構築 Part 21"
subtitle: "Vimのインストールとチュートリアル"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- vim
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
|目的|Vimのインストールとチュートリアル|
|参考|- [ubuntu manuals: vimtutor](http://manpages.ubuntu.com/manpages/bionic/man1/vimtutor.1.html)<br>- [vimエディタが（勝手に）作成する、一見、不要に見えるファイルが何をしているか ](https://nanasi.jp/articles/howto/file/seemingly-unneeded-file.html#viminfo)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [解決したい問題](#%E8%A7%A3%E6%B1%BA%E3%81%97%E3%81%9F%E3%81%84%E5%95%8F%E9%A1%8C)
- [Vimのインストール](#vim%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [デフォルトのvim](#%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%81%AEvim)
  - [Vimの種類](#vim%E3%81%AE%E7%A8%AE%E9%A1%9E)
  - [Vimのインストール](#vim%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB-1)
- [Vimの初期設定](#vim%E3%81%AE%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
- [Vim操作のチュートリアル](#vim%E6%93%8D%E4%BD%9C%E3%81%AE%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB)
  - [カーソルの移動](#%E3%82%AB%E3%83%BC%E3%82%BD%E3%83%AB%E3%81%AE%E7%A7%BB%E5%8B%95)
  - [Normal Modeでの基本操作](#normal-mode%E3%81%A7%E3%81%AE%E5%9F%BA%E6%9C%AC%E6%93%8D%E4%BD%9C)
  - [deleteの基本構文](#delete%E3%81%AE%E5%9F%BA%E6%9C%AC%E6%A7%8B%E6%96%87)
  - [Motionと数字](#motion%E3%81%A8%E6%95%B0%E5%AD%97)
  - [Cut and Paste](#cut-and-paste)
  - [文字のReplace](#%E6%96%87%E5%AD%97%E3%81%AEreplace)
  - [文字列の検索](#%E6%96%87%E5%AD%97%E5%88%97%E3%81%AE%E6%A4%9C%E7%B4%A2)
  - [対応するカギカッコの検索](#%E5%AF%BE%E5%BF%9C%E3%81%99%E3%82%8B%E3%82%AB%E3%82%AE%E3%82%AB%E3%83%83%E3%82%B3%E3%81%AE%E6%A4%9C%E7%B4%A2)
  - [文字の置換](#%E6%96%87%E5%AD%97%E3%81%AE%E7%BD%AE%E6%8F%9B)
- [Appendix](#appendix)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## 解決したい問題

- Vim Hugeのインストール
- Vimの使い方を覚える

## Vimのインストール

### デフォルトのvim

Ubuntu 20.04 LTSのデフォルトでは、`vim`はインストールされていますが「vim-tiny」という簡易版です。`vim`コマンド自体は存在せず`vi`コマンドで立ち上げる必要があります. このときの、バージョンを

```zsh
% vi --version
```

で確認すると、「Small version without GUI」となっています. 

### Vimの種類

ディストリビューションごとに最適化されたもの（vim-gtk など）や、そもそも Vim 自体の機能が制限されたもの（vim-tiny など）などが存在し、

```zsh
% apt search vim-
```

で様々な種類のvimのパッケージが存在することが確認できます. しかし、環境に依存しない Vim 自体の種類（タイプ）として基本的に以下の5つに大別できます。

---|---
tiny|vim-tiny とは、最小構成でビルドされた Vim です。シンタックスハイライト（:syntax on）が有効にならなかったり、複数バッファ（:n など）、テキストオブジェクト（ciw）などが使用できない
small|一部の機能を無効にしてコンパイル
normal|標準の機能を有効にしてコンパイル
big|多くの機能を有効にしてコンパイル
huge|ほとんどの機能を有効にしてコンパイル

今回はとりあえず、huge な Vim さえインストールできればいいので

```
vim/focal,now 2:8.1.2269-1ubuntu5 amd64
  Vi IMproved - enhanced vi editor
```

なお最新版は、`8.2.2911 - 2020年5月30日 [±]`ですがレポジトリ追加がめんどくさいので、apt公式でサポートされている `8.1` をインストールします. 

### Vimのインストール

インストールとversion確認は以下、

```
% sudo apt install vim
% vim --version
VIM - Vi IMproved 8.1 (2018 May 18, compiled Apr 15 2020 06:40:31)
Included patches: 1-2269
Modified by team+vim@tracker.debian.org
Compiled by team+vim@tracker.debian.org
Huge version without GUI.  Features included (+) or not (-):
+acl               -farsi             -mouse_sysmouse    -tag_any_white
+arabic            +file_in_path      +mouse_urxvt       -tcl
+autocmd           +find_in_path      +mouse_xterm       +termguicolors
+autochdir         +float             +multi_byte        +terminal
-autoservername    +folding           +multi_lang        +terminfo
-balloon_eval      -footer            -mzscheme          +termresponse
+balloon_eval_term +fork()            +netbeans_intg     +textobjects
-browse            +gettext           +num64             +textprop
++builtin_terms    -hangul_input      +packages          +timers
+byte_offset       +iconv             +path_extra        +title
+channel           +insert_expand     -perl              -toolbar
+cindent           +job               +persistent_undo   +user_commands
-clientserver      +jumplist          +postscript        +vartabs
-clipboard         +keymap            +printer           +vertsplit
+cmdline_compl     +lambda            +profile           +virtualedit
+cmdline_hist      +langmap           -python            +visual
+cmdline_info      +libcall           +python3           +visualextra
+comments          +linebreak         +quickfix          +viminfo
+conceal           +lispindent        +reltime           +vreplace
+cryptv            +listcmds          +rightleft         +wildignore
+cscope            +localmap          -ruby              +wildmenu
+cursorbind        -lua               +scrollbind        +windows
+cursorshape       +menu              +signs             +writebackup
+dialog_con        +mksession         +smartindent       -X11
+diff              +modify_fname      +sound             -xfontset
+digraphs          +mouse             +spell             -xim
-dnd               -mouseshape        +startuptime       -xpm
-ebcdic            +mouse_dec         +statusline        -xsmp
+emacs_tags        +mouse_gpm         -sun_workshop      -xterm_clipboard
+eval              -mouse_jsbterm     +syntax            -xterm_save
+ex_extra          +mouse_netterm     +tag_binary        
+extra_search      +mouse_sgr         -tag_old_static    
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
       defaults file: "$VIMRUNTIME/defaults.vim"
  fall-back for $VIM: "/usr/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H   -Wdate-time  -g -O2 -fdebug-prefix-map=/build/vim-iU6mZD/vim-8.1.2269=. -fstack-protector-strong -Wformat -Werror=format-security -D_REENTRANT -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1       
Linking: gcc   -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -o vim        -lm -ltinfo -lnsl  -lselinux  -lcanberra -lacl -lattr -lgpm -ldl     -L/usr/lib/python3.8/config-3.8-x86_64-linux-gnu -lpython3.8 -lcrypt -lpthread -ldl -lutil -lm -lm  
```

「Huge version」となっており、いろいろな機能が含まれた状態のVimがインストールされていることが分かります。また、この時点ですでに `vi`と実行しても、新しくインストールしたvimが起動する様になっています.


## Vimの初期設定

Vimの設定を行うには、ターミナル上で `.vimrc` というファイルをホームディレクトリ上に作成する必要があります。

```zsh
% cd　#ホームディレクトリに移動
% code ~/.vimrc #vimrcを作成し、中身をvimで表示する
```

設定は以下

```
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Ryo Nakagami
"
" Reference
"       https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
"
" updatetimestamp
"       2021-06-15 00:34:23
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" show the row number
set number

" highlight the space at the end
set listchars=tab:^\ ,trail:~

" set no beep
set noerrorbells

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" highlight the comment with light-blue colour
hi Comment ctermfg=3


set background=dark

set encoding=utf-8

set fileformats=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set fileencodings=utf-8,cp932,sjis
scriptencoding utf-8

" set no bom
set nobomb
```

## Vim操作のチュートリアル

`vimtutor`を実行するとvimでチュートリアルが起動します。チュートリアルは大きく7つの章で構成されており各章に複数のレッスンがあります。ここではレッスンの要約を紹介します.

### カーソルの移動

Normal mode (`Esc`でモードを切り替え)におけるカーソルに移動は以下、

```
             ^
             k              Hint:  The h key is at the left and moves left.
       < h       l >               The l key is at the right and moves right.
             j                     The j key looks like a down arrow.
             v
```

### Normal Modeでの基本操作

---|---
保存無しでvimを終了|Normal modeで `:q!`, then Enter を入力.
保存してvimを終了|Normal modeで `:wq`, then Enter を入力.
文字の消去|Normal modeで `x` を入力, または `dw`を入力
insert modeへの切り替え|Normal modeで`i`を入力, または`Esc`による切り替え
appendへの切り替え (文末へカーソルが移動する) |Normal modeで文字を付け足したい箇所にカーソルを合わせ`a`を入力
カーソルの下の行にinsertで編集したい場合|Normal modeで`o`を入力
カーソルの上の行にinsertで編集したい場合|Normal modeで`O`を入力
行の文字を削除(行自体は残す)| Normal modeで `d$` を入力
行の削除(行自体も消える)|`dd`
最後に実行されたコマンドのUNDO|Normal modeで `u` を入力
行をoriginalの状態（カーソルが合わせられる直前）まで戻す|Normal modeで `U` を入力
UNDOのUNDO|`Ctrl + r`
File locationとステータス確認|`Ctrl + g`
先頭への移動|`gg`
末尾までの移動|`G`
ラインのコピー|Normal modeで`y`. Visual modeを`v`で立ち上げた後、選択範囲を`y`すると複数行コピーできる

### deleteの基本構文

Vimの多くのテキスト編集コマンドは operator と motion によって構成されています. deleteを例に取ってみると、 基本構文は

```
d motion
```

- `d` : delete operator
- motion: deleteの動きの方向性を規定

---|---
`w`| 次の単語が始まる前まで文字を削除する
`e`| 現在の単語の末尾まで文字を消去する
`$`| カーソル地点からline末までの文字を削除する

また、`d`や`x`といった削除moveは基本的には「切り取り」です.

### Motionと数字

Motionの前に数字をつけるとそのMotionを何回繰り返すかを指示することができます.

---|---
`2w`|2単語すすむ = 3単語目の先頭にカーソルが合わせられる
`3e`|3単語目の末尾にカーソルが合わせられる
`0`|lineの先頭に移動
`d2w`|２つの単語をを消去する
`2dd`|2行削除

### Cut and Paste

1. 対象とする行や文字にカーソルを合わせ、`x`や`dd`といった処理をする
2. その後、Paste死体箇所までカーソルを合わせ, Normal modeで `p` を入力

Pasteは何回もできる.

### 文字のReplace

---|---
operator `r` と変換したい文字の入力によって行う|「at the cursor」ベース
operator `c` と motion `e`を入力した後、文字列を入力する|「to change until the end of a word」ベース

### 文字列の検索

文字列を検索したい場合はNormal modeで`/`を入力し、文字列を入力します。その後, Enterを入力すると検索できます。同じ文字列を検索したい場合は`n`を入力、逆方向で検索を欠けたい場合は`N`を入力.

### 対応するカギカッコの検索

`(`, `[`, `{`のそれぞれに対応する`)`, `]`, `}`を検索したい場合は。カーソルを対応を検索したいカギカッコに合わせ `%` を入力.

### 文字の置換

行単位で thee を theに置換したい場合は、Normal modeで`:s/thee/the` `<Enter>`で置換できる. グローバルに置換したい場合は `:s/thee/the/g` `<Enter>`. 


## Appendix

vimエディタにより自動的に作成される、 スワップファイル、バックアップファイル、viminfoファイルがどのような役割を持ったファイルであるか紹介します.（詳細は[こちら](https://nanasi.jp/articles/howto/file/seemingly-unneeded-file.html#viminfo)参照）

---|---
`.swp`ファイル|.swpファイルはスワップファイルと呼ばれています。スワップファイルはアプリケーションのクラッシュに備えて、 vimエディタでの編集開始時に作成され、編集後に削除される編集情報の記録ファイルです。スワップファイルを使用していれば、vimエディタがシステムエラーで強制終了しても、 保存前のデータが失われずに済みことがあります。
`~`ファイル|~（チルダ）ファイルバックアップファイルです。 ファイルを保存時に、変更前のファイルをもとにして作成されます。 
`.viminfo`ファイル|.viminfo、_viminfoファイルは、コマンド、編集情報、検索情報、レジスタなどの 履歴情報を保存しているファイルです。 

