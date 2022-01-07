Ryo's Tech Blog User Manual
====================

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

  - [Getting Started](#getting-started)
  - [Development](#development)
  - [Configs](#configs)
  - [Posts](#posts)
  - [MathJax設定: LaTex数式のレンダリング用](#mathjax%E8%A8%AD%E5%AE%9A-latex%E6%95%B0%E5%BC%8F%E3%81%AE%E3%83%AC%E3%83%B3%E3%83%80%E3%83%AA%E3%83%B3%E3%82%B0%E7%94%A8)
  - [SideBar](#sidebar)
    - [LATEST COMMIT](#latest-commit)
  - [Mini About Me](#mini-about-me)
  - [Featured Tags](#featured-tags)
  - [Friends](#friends)
  - [Keynote Layout](#keynote-layout)
  - [Share Buttons](#share-buttons)
  - [Comment: utterrances](#comment-utterrances)
  - [Analytics](#analytics)
  - [SEO Title](#seo-title)
  - [Reference](#reference)
- [Releases](#releases)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Getting Started

1. [Jekyll](https://jekyllrb.com/)ベースで構築しているため[Ruby](https://www.ruby-lang.org/en/) と [Bundler](https://bundler.io/)をinstallする必要があります. [Using Jekyll with Bundler](https://jekyllrb.com/tutorials/using-jekyll-with-bundler/)に従って環境構築推奨.

2. `Gemfile`の記述に従ってDependencyをinstall:

```sh
$ bundle install 
```

3. ローカルでウェブサイトをServeします (`localhost:4000` by default):

```sh
$ bundle exec jekyll serve  # alternatively, npm start
```

### Development

To modify the theme, you will need [Grunt](https://gruntjs.com/). There are numbers of tasks you can find in the `Gruntfile.js`, includes minifing JavaScript, compiling `.less` to `.css`, adding banners to keep the Apache 2.0 license intact, watching for changes, etc. 

Yes, they were inherited and are extremely old-fashioned. There is no modularization and transpilation, etc.

Critical Jekyll-related code are located in `_include/` and `_layouts/`. Most of them are [Liquid](https://github.com/Shopify/liquid/wiki) templates.

This theme uses the default code syntax highlighter of jekyll, [Rouge](http://rouge.jneen.net/), which is compatible with Pygments theme so just pick any pygments theme css (e.g. from [here](http://jwarby.github.io/jekyll-pygments-themes/languages/javascript.html) and replace the content of `highlight.less`.


### Configs

ブログをカスタマイズする場合は`_config.yml`を修正します:

```yml
# Site settings
title: Ryo's Tech Blog             # title of your website
SEOTitle: Ryo's Tech Blog          # check out docs for more detail
description: "Cool Blog"    # ...

# SNS settings      
github_username:  RyoNakagami    # modify this account to yours

# Build settings
paginate: 10                # nums of posts in one page
```

For more options, see [Jekyll - Official Site](http://jekyllrb.com/). 


### Posts

Posts are simply just Markdown files in the `_posts/`. 
Metadata of posts are listed in a YAML style _front-matter_.

一例として, [ブログ編集手引きノート](https://ryonakagami.github.io/2020/10/13/Blog-development/)ではthe front-matterを以下のように設定しています:

```yml
---
layout: post
title: "ブログ編集手引きノート"
subtitle: "Git branchを用いたブログ更新テストのメモ"
author: "Ryo"
header-img: "img/post-git-github-logo.jpg"
header-mask: 0.4
purpose: 目的 git branchを活用したRyo's Tech blogの更新手順のメモ
goal: 成果物 git branchを用いたファイルバージョン管理やブログレイアウト管理を実現
catelog: true
tags:
  - git
  - git branch
  - ブログ作業マニュアル
---
```

> Note: `tags` section can also be written as `tags: [Life, Meta]`.

[Rake](https://github.com/ruby/rake)を導入後, postは以下のコマンドでも作成可能となります:

```
rake post title="ブログ編集手引きノート" subtitle="Git branchを用いたブログ更新テストのメモ"
```

このコマンドを実行すると、上記のようなサンプル投稿が `_posts/` フォルダに自動的に生成されます.

> _advanced_ config設定例の紹介

1. a _text style_ header like [this](https://huangxuan.me/2019/09/08/spacemacs-workflow/) with

```yml
header-style: text 
```

2. Turning on Latex support:

```yml
mathjax: true
```

3. Adding a mask to the header picture:

```yml
header-mask: 0.3
```

### MathJax設定: LaTex数式のレンダリング用

- `_includes/mathjax_support.html`にて、MathJax の読み込みとオプション設定を記述してあります.
- 詳細は右を参照：[Github Pages で数式を ～ MathJax v3 設定のポイント](https://qiita.com/memakura/items/e4d2de379f98ad7be498)

### SideBar

![](http://huangxuan.me/img/blog-sidebar.jpg)

**SideBar** provides possible modules to show off more personal information.

```yml
# Sidebar settings
sidebar: true   # default true
sidebar-about-description: "your description here"
sidebar-avatar: /img/avatar-ryo.jpg     # use absolute URL.
```

Modules *[Featured Tags](#featured-tags)*, *[Mini About Me](#mini-about-me)* and *[Friends](#friends)* are turned on by default and you can add your own. The sidebar is naturally responsive, i.e. be pushed to bottom in a smaller screen (`<= 992px`, according to [Bootstarp Grid System](http://getbootstrap.com/css/#grid))  


#### LATEST COMMIT

Shields.ioというサービスを使用してGitHubの最新コミット日をバッジで表示しています.

```html
<!-- GitHub Last Commit -->
                <h5>LATEST COMMIT</a></h5>
                <a href='https://github.com/RyoNakagami/RyoNakagami.github.io'><img src='https://img.shields.io/github/last-commit/RyoNakagami/RyoNakagami.github.io.svg' alt=''/>
```

と`page.html`に記述することですることで

<img src='https://img.shields.io/github/last-commit/RyoNakagami/RyoNakagami.github.io.svg' alt=''/>

を表示することができます. For more info, see [Shields.io: Quality metadata badges for open source projects](https://shields.io/category/platform-support).

### Mini About Me

**Mini-About-Me** displays your avatar, description and all SNS buttons if  `sidebar-avatar` and `sidebar-about-description` variables are set. 

It would be hidden in a smaller screen when the entire sidebar are pushed to bottom. Since there is already SNS portion there in the footer.

### Featured Tags

**Featured-Tags** is similar to any cool tag features in website like [Medium](http://medium.com).
Started from V1.4, this module can be used even when sidebar is off and displayed always in the bottom. 

```yml
# Featured Tags
featured-tags: true  
featured-condition-size: 1     # A tag will be featured if the size of it is more than this condition value
```

The only thing need to be paid attention to is `featured-condition-size`, which indicate a criteria that tags need to have to be able to "featured". Internally, a condition `{% if tag[1].size > {{site.featured-condition-size}} %}` are made.

### Friends

Friends is a common feature of any blog. It helps with SEO if you have a bi-directional hyperlinks with your friends sites.
This module can live when sidebar is off as well.

Friends information is configured as a JSON string in `_config.yml`

```yml
# Friends
friends: [
    {
        title: "Foo Blog",
        href: "http://foo.github.io/"
    },
    {
        title: "Bar Blog",
        href: "http://bar.github.io"
    }
]
```


### Keynote Layout

![](http://huangxuan.me/img/blog-keynote.jpg)

There is a increased trend to use Open Web technology for keynotes and presentations via Reveal.js, Impress.js, Slides, Prezi etc. I consider a modern blog should have first-class support to embed these HTML based presentation so **Keynote layout** are made.

To use, in the **front-matter**:

```yml
---
layout:     keynote
iframe:     "http://huangxuan.me/js-module-7day/"
---
```

The `iframe` element will be automatically resized to adapt different form factors and device orientation. 
Because most of the keynote framework prevent the browser default scroll behavior. A bottom-padding is set to help user and imply user that more content could be presented below.


### Share Buttons




### Comment: utterrances

[utterances](https://utteranc.es/)というコメントサービスを用いています. utterancesはGitHubのIssueを作ってコメントを生成しているため、utterancesがGitHubのIssueを作れるようにするためGitHubと連動する権限を許可する必要があります. 

> 設定方法

[Jekyllブログにコメント機能](https://dev-yakuza.posstree.com/jekyll/utterances/)を参照することを推奨します.

1. [GitHub App:utterances](https://github.com/apps/utterances)へアクセスし、Configureボタンをクリックする
2. utterancesがGitHubのIssueを作る権限を許可するアカウントを選択
3. utterancesがアクセス可能なリポジトリ(Repository)を選択
4. スクリプト生成を生成し、`_layouts/post.html`に記述する


### Analytics

From V1.5, Google Analytics and Baidu Tongji are supported with a simple config away:

```yml
# Baidu Analytics
ba_track_id: 4cc1f2d8f3067386cc5cdb626a202900

# Google Analytics
ga_track_id: 'UA-xxxxxx-xx'            # Format: UA-xxxxxx-xx
ga_domain: huangxuan.me
```

Just checkout the code offered by Google/Baidu, and copy paste here, all the rest is already done for you.

(Google might ask for meta tag `google-site-verification`)


### SEO Title

Before V1.4, site setting `title` is not only used for displayed in Home Page and Navbar, but also used to generate the `<title>` in HTML.
It's possible that you want the two things different. For me, my site-title is **“Ryo's Tech Blog”** but I want the title shows in search engine is **“徒然日記 | Ryo's Tech Blog”** which is multi-language.

So, the SEO Title is introduced to solve this problem, you can set `SEOTitle` different from `title`, and it would be only used to generate HTML `<title>` and setting DuoShuo Sharing.


### Reference

- [Hux Blog](http://huangxuan.me/)
- [フリー素材>cyberpunk](https://pixabay.com/ja/images/search/cyberpunk/)
- [Shields.ioを使ってGitHubの情報をバッジで表示してみる](https://yoshinorin.net/2016/11/23/shieldsio-github-badges/)
- [Shields.io: Quality metadata badges for open source projects](https://shields.io/category/platform-support)
- [Github Pages で数式を ～ MathJax v3 設定のポイント](https://qiita.com/memakura/items/e4d2de379f98ad7be498)
- [utterances](https://utteranc.es/)
- [Jekyllブログにコメント機能](https://dev-yakuza.posstree.com/jekyll/utterances/)
- [GitHub Pagesで作ったブログをGoogle検索にヒットさせる](https://www.bedroomcomputing.com/2020/04/2020-0408-googleconsole/)

Releases
--------
