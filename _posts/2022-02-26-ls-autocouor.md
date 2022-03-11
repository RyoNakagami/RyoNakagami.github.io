---
layout: post
title: "Linux基礎知識：lsコマンドのカラー引数の挙動差"
subtitle: "--color=autoと--color=alwaysの挙動差"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Linux
- Shell
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [調べたいこと](#%E8%AA%BF%E3%81%B9%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
- [`ls --color=xxx`の仕組み](#ls---colorxxx%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [「標準出力先がTerminalの場合」とはなにを指しているのか？](#%E6%A8%99%E6%BA%96%E5%87%BA%E5%8A%9B%E5%85%88%E3%81%8Cterminal%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%A8%E3%81%AF%E3%81%AA%E3%81%AB%E3%82%92%E6%8C%87%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
- [`--color=always`を使用する場面の紹介](#--coloralways%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B%E5%A0%B4%E9%9D%A2%E3%81%AE%E7%B4%B9%E4%BB%8B)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [zshrcの設定例の紹介](#zshrc%E3%81%AE%E8%A8%AD%E5%AE%9A%E4%BE%8B%E3%81%AE%E7%B4%B9%E4%BB%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 調べたいこと

任意のディレクトリに属するファイルやサブディレクトリを確認する際に使用する`ls`コマンドについて、
`--color=auto`や`--color=always`をoptionに指定すると、ファイルやディレクトリごとに色分けしてターミナルに出力してくれますが、
この`auto`と`always`の挙動差はなんなのかを調べたいと思います.

## `ls --color=xxx`の仕組み

まず、マニュアルから確認します.

```zsh
% man ls
DESCRIPTION
    --color[=WHEN]
              colorize  the  output;  WHEN  can  be  'always'  (default  if omitted), 'auto', or
              'never'; more info below
...
(略)
...
Using color to distinguish file types is disabled both by default and with --color=never.
       With  --color=auto, ls emits color codes only when standard output is connected to a ter‐
       minal.  The LS_COLORS environment variable can change the settings.   Use  the  dircolors
       command to set it.
```

このマニュアルを読む感じわかることは以下です：

- Ubuntu 20.04 LTSでは、デフォルトでは`--color`はdisabledされている
- `--color`を指定するとデフォルトの挙動は`--color=always`
- `--color=auto`は標準出力先がTerminalの場合、カラー出力をしてくれるがそれ以外はしてくれない
- `--color=always`は標準出力先がTerminal以外の場合でも、カラー出力をしてくれる

### 「標準出力先がTerminalの場合」とはなにを指しているのか？

> Terminal上への出力：挙動差なし

このGithub Pagesブログのワークスペースディレクトリを例にまずコマンドの挙動を確認してみます:

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220226-ls-always.png?raw=true">

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220226-ls-auto.png?raw=true">

このようにTerminal上でファイル要素を確認する場合は挙動差はありません. 

> パイプを用いて、出力結果を表示: 挙動差あり

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220226-ls-always-head.png?raw=true">

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220226-ls-auto-head.png?raw=true">


> リダイレクトを用いて、出力結果をテキストへWRITE：挙動差あり

次に、リダイレクトを用いて、`ls`の出力結果をテキストへ吐き、そのテキストを確認してみます.

```zsh
% ls --color=always -C > test.txt && nano test.txt
404.html      feed.xml      ^[[0m^[[01;34m_includes^[[0m/  offline.html       README.md
about.html    ^[[01;34mfonts^[[0m/        index.html  package.json       search.json
archive.html  Gemfile       ^[[01;34mjs^[[0m/         package-lock.json  ^[[01;34m_site^[[0m/
_config.yml   Gemfile.lock  ^[[01;34m_layouts^[[0m/   ^[[01;34m_posts^[[0m/            sw.js
^[[01;34mcss^[[0m/          Gruntfile.js  ^[[01;34mless^[[0m/       ^[[01;34mpwa^[[0m/               test.txt
^[[01;34m_doc^[[0m/         ^[[01;34mimg^[[0m/          LICENSE     Rakefile

% ls --color=auto -C > test.txt && nano test.txt 
404.html      feed.xml      _includes/  offline.html       README.md
about.html    fonts/        index.html  package.json       search.json
archive.html  Gemfile       js/         package-lock.json  _site/
_config.yml   Gemfile.lock  _layouts/   _posts/            sw.js
css/          Gruntfile.js  less/       pwa/               test.txt
_doc/         img/          LICENSE     Rakefile
```

- `ls --color=always`の場合は、テキストへ出力された結果に文字列だけでなく、カラーコードも合わせて出力されています
- `ls --color=auto`の場合は、文字列のみ


## `--color=always`を使用する場面の紹介

### やりたいこと

- `cd`コマンド実行時にファイル, `ls`を同時に実行する
- 出力結果は、ファイルやディレクトリの種類に応じて色分けされた形にしたい(`--color=always`や`--color=auto`と同じ)
- 出力行数が多いときは...で省略する

> 前提条件

- Shellはzshとする
- OSはDebian系(Ubuntu 20.04 LTS)

### zshrcの設定例の紹介

```zsh
## ファイル数が多い時には省略表示
ls_abbrev() {
    local cmd_ls='ls'                  # コマンドを格納するlocal変数を定義
    local -a opt_ls                    # optionを格納するlocal変数の箱をarray型で定義
    opt_ls=('-CF' '--color=always')　　 # option local変数を代入

    local ls_result
    ## CLICOLOR_FORCE=1でcolor出力を渡す
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ') #出力結果の行数をカウント

    if [ $ls_lines -gt 10 ]; then                           #出力行数が11以上か未満で省略を切り分ける
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

autoload -Uz add-zsh-hook               # hook関数の呼び出しをOKにする
add-zsh-hook chpwd ls_abbrev            # chpwd(カレントディレクトリが変更したとき)をトリガーに ls_abbrevを実行する
```

> 挙動確認

```zsh
% mkdir test && cd test
% touch foo_{01..40}.txt && mkdir hoo_{01..40}
% cd ./
```

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220226-ls-abbrev.png?raw=true">



## References

- [ls --color=auto, why they offer such an option since there is --color=always by default?](https://unix.stackexchange.com/questions/625214/ls-color-auto-why-they-offer-such-an-option-since-there-is-color-always-by)
- [シェルでコマンドの実行前後をフックする](https://note.hibariya.org/articles/20170219/shell-postexec.html)