---
layout: post
title: "Quartoでpublishしたサイトにgoogle tag managerを埋め込む方法"
subtitle: "GitHub Pages published by Quarto 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: true
last_modified_at: 2024-07-13
tags:

- GitHub Pages
- quarto
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [この記事のスコープ](#%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [Google Tag Manager設定実践編](#google-tag-manager%E8%A8%AD%E5%AE%9A%E5%AE%9F%E8%B7%B5%E7%B7%A8)
  - [Google Tag Managerの設定条件](#google-tag-manager%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%9D%A1%E4%BB%B6)
  - [Solution: `_quarto.yml`経由でGTMを参照する](#solution-_quartoyml%E7%B5%8C%E7%94%B1%E3%81%A7gtm%E3%82%92%E5%8F%82%E7%85%A7%E3%81%99%E3%82%8B)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## この記事のスコープ

- QuartoでpublishしたGitHub PagesにGoogle Tag Managerを埋め込む


<strong > &#9654;&nbsp; 前提条件</strong>

- `quarto: create project`を用いてblog用レポジトリを作成
- `quarto publish`を用いて，作成したレポジトリをGitHub Pagesとしてpublish済み
- google analyticsでproperty設定済み
- google tag managerでgtm発行済


## Google Tag Manager設定実践編

<strong > &#9654;&nbsp; 現在のレポジトリの状態</strong>

```zsh
.
├── about.qmd
├── .gitignore
├── img
│   ├── favicon-16x16.png
│   ├── favicon-32x32.png
│   └── OGG_logo.png
├── index.qmd
├── LICENSE
├── posts
│   ├── 2024-07-12-committed-on-a-wrong-branch
│   │   └── index.qmd
│   └── _metadata.yml
├── _quarto.yml
├── README.md
└── styles.css
```

quartoでpublishしたGitHub Pagesはデフォルトでは`gh-pages`ブランチの`posts`以下がコンテンツとしてレンダリングされます．

<strong > &#9654;&nbsp; やりたいこと</strong>

- 発行したgoogle tag manager htmlを各コンテンツページ個別設定ではなく，**一括で設定したい**


### Google Tag Managerの設定条件

Tag ManagerでGTMを発行すると，

1. ページの`<head>` の中で，可能な限り上部にこのコードを貼り付けてください：

```html
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','hogehogehoge');</script>
<!-- End Google Tag Manager -->
```

2. `<body>`タグ開始の直後に以下のコードを貼り付けてください：

```html
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=Ghogehogehoge"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
```

というインストラクションが表示されます．なお，Google analyticsを適切に設定すると，Google Search Consoleのサイト認証が一瞬でできるという副次的効果も有ります．

### Solution: `_quarto.yml`経由でGTMを参照する

Quartoでは, repository root直下に存在する `_quarto.yml` に以下のように設定をすると各コンテンツページで
自動的にgoogle tag managerを設定することができます．

```yml
format:
  html:
    include-in-header: gtm_code_head.html
    include-before-body: gtm_code_body.html
```

- `<head>` sectionのなかで `gtm_code_head.html`を読み込む
- `<body>` sectionのなかで `gtm_code_body.html`を読み込む

という設定になります．複数のhtml/jsファイルを読み込ませたい場合は

```yml
format:
  html:
    include-in-header: gtm_code_head.html
    include-before-body: 
        - gtm_code_body.html
        - toggle.js
```

のような設定になります．
