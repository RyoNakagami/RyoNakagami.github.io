---
layout: post
title: "Ubuntu Desktop環境構築 Part 12"
subtitle: "静的サイトジェネレーター Jekyllのインストール: GitHub Pages作成環境の構築"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- doctoc
- Markdown
---

||概要|
|---|---|
|目的|静的サイトジェネレーター Jekyllのインストール: GitHub Pages作成環境の構築|
|参考|- [Jekyll公式ページ](https://jekyllrb.com/docs/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [Jekyllは何に使うのか？](#jekyll%E3%81%AF%E4%BD%95%E3%81%AB%E4%BD%BF%E3%81%86%E3%81%AE%E3%81%8B)
  - [Requirements](#requirements)
- [2. Jekyllのインストール](#2-jekyll%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [3. GitHub Pages作成環境の構築](#3-github-pages%E4%BD%9C%E6%88%90%E7%92%B0%E5%A2%83%E3%81%AE%E6%A7%8B%E7%AF%89)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

静的サイトジェネレーター Jekyllのインストール

### Jekyllは何に使うのか？

GitHub Pagesの[個人ブログ](https://ryonakagami.github.io/)の制作環境としてJekyllを用いてます。

### Requirements

- Ruby version 2.4.0 or higher
- RubyGems
- GCC and Make

## 2. Jekyllのインストール

まず必要なパッケージをインストールします

```zsh
% sudo apt update && sudo apt upgrade -y
% sudo apt install ruby ruby-dev make gcc gem
```

Version確認をします

```zsh
% ruby -v
ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux-gnu]
% gem -v
3.1.2
% gcc -v
(略)
gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04) 
% make -v
GNU Make 4.2.1
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

次にPATHを通します。

```zsh
echo '# Install Ruby Gems to ~/gems' >> ~/.zshrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc
```

Jekyllとbundler gemsをインストールします。

```
% gem install jekyll bundler
```

## 3. GitHub Pages作成環境の構築

local serverでブログが表示できたことを確認したら、インストール完了とする。

```zsh
% git clone https://github.com/RyoNakagami/RyoNakagami.github.io
% bundle install #Gemfileからdependenciesをinstall
% bundle exec jekyll server #Test
Configuration file: /home/dst/RyoNakagami.github.io/_config.yml
            Source: /home/dst/RyoNakagami.github.io
       Destination: /home/dst/RyoNakagami.github.io/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
                    done in 0.502 seconds.
 Auto-regeneration: enabled for '/home/dst/RyoNakagami.github.io'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

