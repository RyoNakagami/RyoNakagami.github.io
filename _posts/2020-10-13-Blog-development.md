---
layout: post
title: "GitHub Pages: GA4の設定"
subtitle: "ブログ編集手引きノート 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
reading_time: 10
tags:
  - git
  - GitHub Pages
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [GitHub Pages開発環境](#github-pages%E9%96%8B%E7%99%BA%E7%92%B0%E5%A2%83)
  - [技術スタック](#%E6%8A%80%E8%A1%93%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF)
  - [作業ディレクトリ構成](#%E4%BD%9C%E6%A5%AD%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E6%A7%8B%E6%88%90)
- [Google Analyticsの設定](#google-analytics%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [Google Analyticsの利用登録](#google-analytics%E3%81%AE%E5%88%A9%E7%94%A8%E7%99%BB%E9%8C%B2)
  - [記事ページへの埋め込み](#%E8%A8%98%E4%BA%8B%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%B8%E3%81%AE%E5%9F%8B%E3%82%81%E8%BE%BC%E3%81%BF)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## GitHub Pages開発環境
### 技術スタック

|項目||
|---|---|
|ウェブホスティングサービス|GitHub Pages|
|静的サイトジェネレーター|jekyll|
|editor|Visual Studio Code|
|Analytics|Google Analytics 4|
|OS|Ubuntu 20.04 LTS|



### 作業ディレクトリ構成

```
current working directory
├── _post #ブログのpost格納フォルダ
├── ...
└── _img  #ブログで用いる画像ファイル格納フォルダ
```

## Google Analyticsの設定

方針は

1. GA Propetyの作成
2. Measurement IDを各ページに逐次埋め込む

### Google Analyticsの利用登録

利用登録手順は以下です：

1. [Google Analytics](https://analytics.google.com/analytics/web/)にアクセスします。
2. Account設定をします（基本的には自分のGoogle Accountを入力）
3. Adminをクリックします。
4. Create Propertyという項目があるのでクリックします
5. Property setupをします
6. 最後に[利用規約](https://docs.google.com/document/d/1ArTraHJGbPKdO3gXDpKh4F1vLDPS19nR2U9EVvRJXuI/edit?usp=sharing)に同意したらGoogle Analyticsのダッシュボードが開く

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/2020-10-13-GA-settings.png?raw=true">

**GAは無料で使えるのか？**

プロパティのサービス料金は、1 つのプロパティに紐づけられているすべての（該当する）プロファイルのヒット数を集計して算出されます。「ヒット」とは、最終的にデータとして本サービスに送信されて処理される、操作の集合を指します。例えば、ページビューや e コマースのヒットなどがあります。他にも、さまざまなライブラリによる本サービスの呼び出しがヒットにあたる場合がありますが、このような場合に限定されるわけではありません。GAは 1 アカウントにつき 1 か月あたり 1,000 万ヒットを上限としてお客様に無料で提供されます。

### 記事ページへの埋め込み

測定対象を指定します：

1. Adminをクリック
2. `Data Streams`をクリック
3. `Add stream`をクリック
4. 測定対象URLを指定する
5. Global site tag (gtag.js)が発行されます
6. gtag.jsタグをHTMLの<head>セクションにコピーします。また、ウェブサイトビルダー（WordPress、Shopifyなど）をお使いの場合は、グローバルサイトタグをウェブサイトビルダーのカスタムHTMLフィールドにコピーしてください。

**例**

```
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-12345"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-12345');
</script>
```

## References

- [Ryo's Tech Blog > GitHub Pages環境構築: GA4 Source/Medium 設定](https://ryonakagami.github.io/2021/04/18/google-analytics-source-setting/)
- [Ryo's Tech Blog > 静的サイトジェネレーター Jekyllのインストール: GitHub Pages作成環境の構築](https://ryonakagami.github.io/2020/12/27/ubuntu-jekyll-install/)
