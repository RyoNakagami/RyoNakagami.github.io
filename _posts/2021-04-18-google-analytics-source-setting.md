---
layout: post
title: "GitHub Pages環境構築: GA4 Source/Medium 設定"
subtitle: "GA4 カスタム URL で集客ソースデータを収集する"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
tags:
  - GA4
  - GitHub Pages
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

|概要||
|---|---|
|目的|GA4 Source/Medium 設定手順のメモ|
|関連記事|[ブログ編集手引きノート > Git branchを用いたブログ更新テストのメモ](https://ryonakagami.github.io/2020/10/13/Blog-development/)|


<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回やりたいこと](#%E4%BB%8A%E5%9B%9E%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [用語整理](#%E7%94%A8%E8%AA%9E%E6%95%B4%E7%90%86)
- [カスタム URL で集客ソースデータを収集する](#%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%A0-url-%E3%81%A7%E9%9B%86%E5%AE%A2%E3%82%BD%E3%83%BC%E3%82%B9%E3%83%87%E3%83%BC%E3%82%BF%E3%82%92%E5%8F%8E%E9%9B%86%E3%81%99%E3%82%8B)
  - [3つの必須パラメータ](#3%E3%81%A4%E3%81%AE%E5%BF%85%E9%A0%88%E3%83%91%E3%83%A9%E3%83%A1%E3%83%BC%E3%82%BF)
  - [ルール](#%E3%83%AB%E3%83%BC%E3%83%AB)
  - [URL作成方法](#url%E4%BD%9C%E6%88%90%E6%96%B9%E6%B3%95)
  - [稼働テスト：データ収集の状況を確認する](#%E7%A8%BC%E5%83%8D%E3%83%86%E3%82%B9%E3%83%88%E3%83%87%E3%83%BC%E3%82%BF%E5%8F%8E%E9%9B%86%E3%81%AE%E7%8A%B6%E6%B3%81%E3%82%92%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B)
- [Ryo's Tech Blog 関連記事](#ryos-tech-blog-%E9%96%A2%E9%80%A3%E8%A8%98%E4%BA%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 今回やりたいこと

- GA4 カスタム URL Source/Medium 設定手順のメモ

### 用語整理

|用語|説明|
|---|---|
|Source|検索エンジン（googleなど）やドメイン（example.com）など、トラフィックのスタート地点(the origin of the traffic).|
|Medium|Sourceの一般的なカテゴリー. 例えば、オーガニック検索（organic）、クリック単価の高い有料検索（cpc）、ウェブ参照（referral）, etc.|

## カスタム URL で集客ソースデータを収集する

広告、ソーシャルメディア、メールマガジンなどに掲載するサイトURL にキャンペーンのパラメータを追加すると、集客経路別のデータを収集し、どのキャンペーンが特に高い効果を発揮しているか把握できるようになります。たとえばサマーセール キャンペーンで大きな収益が発生しているものの、複数のソーシャル アプリに広告を配信している時、どのアプリが特に収益性が高いユーザーを呼び込んでいるのかを把握する必要がある場合に効果的です。メールや動画広告、アプリ内広告など、複数のタイプのキャンペーンを実施している場合でも、成果を比較し、マーケティング効果が特に高いものを把握することができます。

### 3つの必須パラメータ

|Parameters|説明|
|---|---|
|`utm_source`|カスタムURL固有のsourceを識別するパラメーター|
|`utm_medium`|カスタムURL固有のmediumを識別するパラメーター|
|`utm_campaign`|個別のキャンペーンネーム, カスタムURLの名前|

### ルール

> Website URLに?が含まれる場合は先頭の?を&に変更

例えばWebsite URLがhttps://inhouse-plus.jp/?s=googleのように?が含まれる場合、通常`?utm_source`から始まるパラメータを`&utm_source`に変更する必要があります。?を2回続けるとリンクエラーになるので注意.

> utm_mediumの値は自由記述せずルールに沿って選択

Googleアナリティクスは、例えばFacebook広告（facebook/display）とTwitter広告（twitter/display）を「Display」というチャネルにまとめるといったように、個別の経路をutm_mediumの値を元に独自の定義でグループ化します。そのため、utm_mediumの値は自由記述ではなく定義に合わせて以下のリストの中から選択して利用すること

|チャネル	|`utm_medium`の値|
|---|---|
|オーガニック検索(Organic Search)	|organic|
|Organic Social|Medium matches regex `^(social|social-network|social-media|sm|social network|social media)`|
|ソーシャル(Social)	|social/social-network/social-media/sm/social network/social mediaのいずれか|
|メール(Email)	|Medium = `email|e-mail|e_mail|e mail`|
|ノーリファラー(Direct)	|Source exactly matches direct<br>AND<br>Medium exactly matches (not set)<br>OR<br>Medium exactly matches (none)|
|アフィリエイト(Affiliate)	|Medium = `affiliate|affiliates`|
|参照元サイト(Referral)	|referral|
|Paid Social| Source matches matches regex `^(internal list of social sites)$`<br>AND<br>Medium matches regex `^(cpc|ppc|paid)$`|
|有料検索(Paid Search)|	cpc/ppc/paidsearchのいずれか|
|ディスプレイ(Display)|GA Ad Network exactly matches DISPLAY|
|他の広告(Other Advertising)	|cpv/cpa/cpp/content-textのいずれか|
|Video|GA Ad Network exactly matches VIDEO|
|その他、使用不可(Other)	|上記のいずれにも該当しない値|

### URL作成方法

URL は手作業で作成することも、URL 生成ツールを使用して作成することもできます。生成ツールは 3 つあります。[ウェブサイト](https://ga-dev-tools.appspot.com/campaign-url-builder/)、[Google Play ストア](https://developers.google.com/analytics/devguides/collection/android/v4/campaigns#google-play-url-builder)、[Apple App Store](https://developers.google.com/analytics/devguides/collection/ios/v3/campaigns#url-builder) の URL はそれぞれ少しずつ異なるため、正しい URL 生成ツールを使用してください。

### 稼働テスト：データ収集の状況を確認する

アプリに SDK を実装（iOS | Android）するか、ウェブサイトにアナリティクス タグを追加した後、データの送信状況を確認する必要があります. 

- 通常は 10～15 分以内にプロパティへのデータ送信が開始されます
- Analyticsから`Realtime`をクリックし、データ送信状況を確認
- 測定コードが適切に設定されている場合は、`現在のユーザー数` カードのユーザー数が約 15 秒ごとに更新されます
- 他のレポートでは、データの処理に 24〜48 時間かかります


## Ryo's Tech Blog 関連記事

- [ブログ編集手引きノート > Git branchを用いたブログ更新テストのメモ](https://ryonakagami.github.io/2020/10/13/Blog-development/)

## References

- [Analytics Help> Source / Medium](https://support.google.com/analytics/answer/6099206?hl=en)
- [[GA4] アナリティクスで新しいウェブサイトまたはアプリのセットアップを行う](https://support.google.com/analytics/answer/9304153#add-tag)
- [Campaign URL Builder](https://ga-dev-tools.appspot.com/campaign-url-builder/)