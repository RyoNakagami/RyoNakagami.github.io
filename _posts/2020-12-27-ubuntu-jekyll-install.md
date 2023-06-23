---
layout: post
title: "静的サイトジェネレーター Jekyllのインストール: GitHub Pages作成環境の構築"
subtitle: "Ubuntu Desktop環境構築 Part 12"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- GitHub Pages
---



**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## 1. 今回のスコープ

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [Jekyllは何に使うのか？](#jekyll%E3%81%AF%E4%BD%95%E3%81%AB%E4%BD%BF%E3%81%86%E3%81%AE%E3%81%8B)
  - [Requirements for Jekyll](#requirements-for-jekyll)
- [2. Jekyllのインストール](#2-jekyll%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [3. GitHub Pages作成環境の構築](#3-github-pages%E4%BD%9C%E6%88%90%E7%92%B0%E5%A2%83%E3%81%AE%E6%A7%8B%E7%AF%89)
- [4. Github-Pagesのフォントの変更](#4-github-pages%E3%81%AE%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E5%A4%89%E6%9B%B4)
  - [解決したい症状](#%E8%A7%A3%E6%B1%BA%E3%81%97%E3%81%9F%E3%81%84%E7%97%87%E7%8A%B6)
  - [症状の発生原因](#%E7%97%87%E7%8A%B6%E3%81%AE%E7%99%BA%E7%94%9F%E5%8E%9F%E5%9B%A0)
  - [対策実施](#%E5%AF%BE%E7%AD%96%E5%AE%9F%E6%96%BD)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->
## 1. 今回のスコープ
### やりたいこと

- GitHub Pages作成環境の構築のための静的サイトジェネレーター Jekyllのインストール
- GitHub Pagesの構成はすでにレポジトリーにあるとします（ない人はテンプレートのrepositoryをcloneしてください）

### Jekyllは何に使うのか？

GitHub Pagesの[個人ブログ](https://ryonakagami.github.io/)の制作環境としてJekyllを用いてます。

### Requirements for Jekyll

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



## 4. Github-Pagesのフォントの変更
### 解決したい症状

Defaultの設定のままだと、日本語フォントが違和感のある形で出力される

### 症状の発生原因

- 中華フォント現象は 中国語を日本語よりも優先指定している場合 に起こります(例：糸偏の漢字を出力する時など)
- cssのfont-familyに日本語フォントが設定されているか？そこでの優先順番はどのようになっているかを確認する

### 対策実施

1. `css/hux-blog.css`を開きます
2. `body`のfont-familyを確認し、自分の好みのフォントと順番に設定する
3. 保存 & git push

**例**

css設定ファイルを開き`font-family`の設定を確認したところ、以下：

```css
body {
  font-family: -apple-system, BlinkMacSystemFont, "Helvetica Neue", "Arial", "PingFang SC", "Hiragino Sans GB", "STHeiti", "Microsoft YaHei", "Microsoft JhengHei", "Source Han Sans SC", "Noto Sans CJK SC", "Source Han Sans CN", "Noto Sans SC", "Source Han Sans TC", "Noto Sans CJK TC", "WenQuanYi Micro Hei", SimSun, sans-serif;
  ...
}
```

`"PingFang SC", "Hiragino Sans GB"`といった中華フォントが上位に設定されている一方、日本語フォントが設定されていないことがわかります. 
ですので、個々の設定で日本語フォントを上位に置く形で修正します.

```css
body {
  /*font-family: -apple-system, BlinkMacSystemFont, "Helvetica Neue", "Arial", "PingFang SC", "Hiragino Sans GB", "STHeiti", "Microsoft YaHei", "Microsoft JhengHei", "Source Han Sans SC", "Noto Sans CJK SC", "Source Han Sans CN", "Noto Sans SC", "Source Han Sans TC", "Noto Sans CJK TC", "WenQuanYi Micro Hei", SimSun, sans-serif;
  */
  font-family: -apple-system, 'Helvetica Neue', 'Hiragino Kaku Gothic ProN', 'ヒラギノ角ゴ ProN W3', Meiryo, メイリオ, Osaka, 'MS PGothic', arial, helvetica, sans-serif;
  ...
}
```


## References

- [Jekyll公式ページ](https://jekyllrb.com/docs/)