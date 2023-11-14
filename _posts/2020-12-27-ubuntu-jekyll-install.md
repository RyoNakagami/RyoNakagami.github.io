---
layout: post
title: "静的サイトジェネレーター Jekyllのインストール"
subtitle: "GitHub Pages作成環境の構築 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-11-15
tags:

- GitHub Pages
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回のスコープ](#%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [Jekyllのインストール](#jekyll%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [GitHub Pages作成環境の構築](#github-pages%E4%BD%9C%E6%88%90%E7%92%B0%E5%A2%83%E3%81%AE%E6%A7%8B%E7%AF%89)
- [Tip 1: Github-Pagesのフォントの変更](#tip-1-github-pages%E3%81%AE%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E5%A4%89%E6%9B%B4)
- [Tip 2: `sitemap.xml`の`<lastmod>`tagの設定](#tip-2-sitemapxml%E3%81%AElastmodtag%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [sitemapは本当に必要か？](#sitemap%E3%81%AF%E6%9C%AC%E5%BD%93%E3%81%AB%E5%BF%85%E8%A6%81%E3%81%8B)
  - [どのようなとき必要なのか？](#%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AA%E3%81%A8%E3%81%8D%E5%BF%85%E8%A6%81%E3%81%AA%E3%81%AE%E3%81%8B)
  - [Jeklyllで`sitemap.xml`を作成する方法](#jeklyll%E3%81%A7sitemapxml%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95)
  - [追加で設定すべき項目: `<lastmod>` tag](#%E8%BF%BD%E5%8A%A0%E3%81%A7%E8%A8%AD%E5%AE%9A%E3%81%99%E3%81%B9%E3%81%8D%E9%A0%85%E7%9B%AE-lastmod-tag)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 今回のスコープ

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

- GitHub Pages作成環境の構築のための静的サイトジェネレーター Jekyllのインストール
- 中華フォント現象の解消方法
- sitemapの`<lastmod>`tagの設定

</div>

GitHub Pagesの[個人ブログ](https://ryonakagami.github.io/)の制作環境としてJekyllを用いてます.
今回は, localにjekyllをインストール & いくつかの設定ポイントの紹介をします. localにJekyllをインストールする以外に
dockerで対応する方法もありますが, この説明は後日とします.

> Requirements for Jekyll

- Ruby version 2.4.0 or higher
- RubyGems
- GCC and Make
- GitHub Pagesの構成はすでにレポジトリーにあるとします（ない人はテンプレートのrepositoryをcloneしてください）

## Jekyllのインストール

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

## GitHub Pages作成環境の構築

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

## Tip 1: Github-Pagesのフォントの変更

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>解決したい症状</ins></p>

- Defaultの設定のままだと、日本語フォントが違和感のある形で出力される

</div>


症状の発生原因としては以下が考えられます:

- 中華フォント現象は 中国語を日本語よりも優先指定している場合 に起こります(例：糸偏の漢字を出力する時など)
- cssのfont-familyに日本語フォントが設定されているか？そこでの優先順番はどのようになっているかを確認する

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>対策方針</ins></p>

1. `css/ryo-blog.css`を開きます
2. `body`のfont-familyを確認し、自分の好みのフォントと順番に設定する
3. 保存 & git push

</div>

実行例として, css設定ファイルを開き`font-family`の設定を確認したところ、以下：

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

## Tip 2: `sitemap.xml`の`<lastmod>`tagの設定

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: sitemap</ins></p>

sitemapとは, ウェブサイト上のページやビデオやファイルに関する情報(created, modified)やそれぞれの関係性を記載したファイルのこと.
Googleを始めとするSearch engineはsitemapを参照してcrawlを実施 & ウェブサイトの情報を集めてsearch engine検索結果に表示できるようにindexしています.

</div>

sitemapの形式例としては以下となります:

```xml
<urlset xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
<url>
<loc>
https://ryonakagami.github.io/2020/10/01/terminology-FTE/
</loc>
<lastmod>2023-10-08T00:00:00+00:00</lastmod>
</url>
...
<url>
<loc>https://ryonakagami.github.io/page25/</loc>
</url>
</urlset>
```

### sitemapは本当に必要か？

sitemapが設定されていなくても, ウェブサイトの規模が小さい場合はGooglebotさんは上手い具合にページを見つけてくれます.
Googleがsitemapが必要ないかもしれない条件を以下のように示しています:

- **Your site is "small"**: 目安としてはページが500以内
- **Your site is comprehensively linked internally**: Home pageから適切にたどることができる状態になっている
- **You don't have many media files (video, image) or news pages**

### どのようなとき必要なのか？

基本的にはCrawlerに「**いつ, なにを優先的にクロールして欲しい**」かというシグナルを送りたいときに設定します.
シグナルを送ったほうが良い状況例として,

- **Your site is large**: 大きいとGooglebotはページを見つける(discover)することができない可能性がある
- **Your site is new and has few external links to it**: ネットの海の中で孤島となっているサイトはクローラーさんには見つけづらいため
- **Your site has a lot of rich media content (video, images)**
- **Your site changes quickly**: 頻繁に更新する場合, クローラーによる探索が間に合わないため

### Jeklyllで`sitemap.xml`を作成する方法

基本的にはsitemapはマニュアルで作成するものではなく, プラグインなどを用いて自動的に作成します.
このブログでは, [jekyll/jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap)を用いています.

設定方法としては, 

1. `Gemfile`にて`gem 'jekyll-sitemap'`を書き加える
2. `bundle`する
3. `config.yml`に以下のようにpluginsリストに`jekull-sitemap`書き加える

```yml
plugins: [jekyll-paginate, jekyll-sitemap, jekyll-archives]
```

すると自動的にURL locationなどを含んだsitemapを作成してくれます.

### 追加で設定すべき項目: `<lastmod>` tag

記事を公開後編集し直したりするときにもう一度crawlerに情報を読み込んでもらいたいときがあります.
このとき, この情報をcrawlerに伝えるためには`<lastmod>` tagを用います.

Defaultでは`post.date`情報を参照し, creation dateをvalueとして格納しますが, Front Matterに
`last_modified_at:`をdateで指定するとその日付を`<lastmod>` tagとして格納してくれます.

Front Matterとはheaderにある

```
---
layout: post
title: "静的サイトジェネレーター Jekyllのインストール"
subtitle: "GitHub Pages作成環境の構築 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2020-12-27
tags:

- GitHub Pages
---

```

のことです.


> REMARKS

- Google cralwerはsitemapにおける `<priority>` and `<changefreq>` valuesを無視します
- `<lastmod>` valueは一貫性がある（前回の更新日よりも後に更新されているなど）場合のみに参照されるとのこと 



References
-------------
- [Jekyll公式ページ](https://jekyllrb.com/docs/)
- [GitHub > jekyll/jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap)
- [Google Search Console > Learn about sitemaps](https://developers.google.com/search/docs/crawling-indexing/sitemaps/overview)
