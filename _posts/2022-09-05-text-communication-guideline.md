---
layout: post
title: "テキストコミュニケーションのお作法"
subtitle: "Business communication 1/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-09
header-mask: 0.0
header-style: text
tags:

- コミュニケーション
- 方法論
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [記事のスコープ](#%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [テキストベースコミュニケーションの特徴](#%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E3%83%99%E3%83%BC%E3%82%B9%E3%82%B3%E3%83%9F%E3%83%A5%E3%83%8B%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E7%89%B9%E5%BE%B4)
- [テキストコミュニケーションのルール](#%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E3%82%B3%E3%83%9F%E3%83%A5%E3%83%8B%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E3%83%AB%E3%83%BC%E3%83%AB)
  - [Rule 1: 受けての知識を勝手に仮定しない](#rule-1-%E5%8F%97%E3%81%91%E3%81%A6%E3%81%AE%E7%9F%A5%E8%AD%98%E3%82%92%E5%8B%9D%E6%89%8B%E3%81%AB%E4%BB%AE%E5%AE%9A%E3%81%97%E3%81%AA%E3%81%84)
  - [Rule 2: 「これ」や「あれ」などの指示語を極力使用しない](#rule-2-%E3%81%93%E3%82%8C%E3%82%84%E3%81%82%E3%82%8C%E3%81%AA%E3%81%A9%E3%81%AE%E6%8C%87%E7%A4%BA%E8%AA%9E%E3%82%92%E6%A5%B5%E5%8A%9B%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%AA%E3%81%84)
  - [Rule 3: 5W1Hを意識する](#rule-3-5w1h%E3%82%92%E6%84%8F%E8%AD%98%E3%81%99%E3%82%8B)
  - [Rule 4: 主語・動詞・目的語を意識する](#rule-4-%E4%B8%BB%E8%AA%9E%E3%83%BB%E5%8B%95%E8%A9%9E%E3%83%BB%E7%9B%AE%E7%9A%84%E8%AA%9E%E3%82%92%E6%84%8F%E8%AD%98%E3%81%99%E3%82%8B)
  - [Rule 5: 主観ではなくてデータに基づいた文章を意識する](#rule-5-%E4%B8%BB%E8%A6%B3%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%8F%E3%81%A6%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AB%E5%9F%BA%E3%81%A5%E3%81%84%E3%81%9F%E6%96%87%E7%AB%A0%E3%82%92%E6%84%8F%E8%AD%98%E3%81%99%E3%82%8B)
  - [Rule 6: 「過小より過剰」を意識する](#rule-6-%E9%81%8E%E5%B0%8F%E3%82%88%E3%82%8A%E9%81%8E%E5%89%B0%E3%82%92%E6%84%8F%E8%AD%98%E3%81%99%E3%82%8B)
  - [Rule 7: スクリーンショットやショート動画を活用する](#rule-7-%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%E3%82%84%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E5%8B%95%E7%94%BB%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%99%E3%82%8B)
  - [Rule 8: 徹底的に不確実な部分をなくす](#rule-8-%E5%BE%B9%E5%BA%95%E7%9A%84%E3%81%AB%E4%B8%8D%E7%A2%BA%E5%AE%9F%E3%81%AA%E9%83%A8%E5%88%86%E3%82%92%E3%81%AA%E3%81%8F%E3%81%99)
  - [Rule 9: どの文面への返信かを引用する](#rule-9-%E3%81%A9%E3%81%AE%E6%96%87%E9%9D%A2%E3%81%B8%E3%81%AE%E8%BF%94%E4%BF%A1%E3%81%8B%E3%82%92%E5%BC%95%E7%94%A8%E3%81%99%E3%82%8B)
  - [Rule 10: 返信に時間がかかるときはそれだけを先に伝える](#rule-10-%E8%BF%94%E4%BF%A1%E3%81%AB%E6%99%82%E9%96%93%E3%81%8C%E3%81%8B%E3%81%8B%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AF%E3%81%9D%E3%82%8C%E3%81%A0%E3%81%91%E3%82%92%E5%85%88%E3%81%AB%E4%BC%9D%E3%81%88%E3%82%8B)
  - [Rule 11: 感謝を伝える](#rule-11-%E6%84%9F%E8%AC%9D%E3%82%92%E4%BC%9D%E3%81%88%E3%82%8B)
  - [Rule 12: 絵文字を使用する](#rule-12-%E7%B5%B5%E6%96%87%E5%AD%97%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 記事のスコープ

slackなどのオープンな場でのテキストベースのコミュニケーションを取る際のBest Practiceのまとめ

## テキストベースコミュニケーションの特徴

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>テキストベースのコミュニケーションの特徴</ins></p>

- 良くも悪くも非同期コミュニケーション
- 複数人に情報が一度に伝達される
- 対面コミュニケーションと比較して, 返信に時間がかかる
- 身振り手振り雰囲気といった情報を伝えられない
- 検索機能で簡単に見つけられる

</div>

上記の点を踏まえると, テキストコミュニケーションを行うときは送信者は以下の点に留意する必要があります

- 冷たく受け取られる可能性がある
- 情報の受け手が想定以上に広い可能性がある
- 将来, 情報送信時に想定していなかった人にテキストが読み返される可能性がある

## テキストコミュニケーションのルール
### Rule 1: 受けての知識を勝手に仮定しない

いわゆるlow-contextコミュニケーションを実現しようということです.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- コミュニケーションの受け手が対象のトピックについて何も知らないと仮定する
- その上で, できるだけ短い時間でできるだけ多くのことを学べるようにテキストを記載する

</div>

### Rule 2: 「これ」や「あれ」などの指示語を極力使用しない

指示語は文章を短くすることができる便利なものですが, その反面文章に曖昧さを生みます.


<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- 指示語は極力使用しないようにして、具体的な名詞を多少冗長になっても使うようにする
- どうしても繰り返しが多くなり過ぎているかつ、誰が呼んでも一意に指示語の内容が同定できると確信できる書き方のときにのみ使用して良い
    - 例: 指示語の対象が一つ前の文章内に存在するとき

</div>

### Rule 3: 5W1Hを意識する

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

状況や事象を情報として伝えるにあたって, 以下の要素を埋めることを意識する

|要素||
|---|---|
|Where| いつ|
|Where| どこで|
|Who| 誰が|
|What| 何を|
|Why| なぜ|
|How|どのように|

</div>

### Rule 4: 主語・動詞・目的語を意識する

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- 「**だれが, どのようなアクションを, なにに対して実施したか**」をまずテキストを書くときに意識する
- その後, 5W1Hの情報を付与する

</div>

### Rule 5: 主観ではなくてデータに基づいた文章を意識する

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- ほとんど, だいぶ, 近々, 顕著に, といった主観的な表現は具体的な数字に置き換える
    - Recommended: 施策により, 推定300人の顧客が新たに獲得できた
    - Avoid: 施策により, たくさんの顧客が新たに獲得できた

</div>


### Rule 6: 「過小より過剰」を意識する

テキストコミュニケーションは曖昧な部分があればすぐに伝わらなくなります.

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- 少しでも曖昧な部分をなくすために過剰でも良いので説明を試みるのが大事
- 「伝わらないのは自分の説明が足りないから」だと常に考える

</div>

ただし, 長いとメッセージを読む時間が増えるというデメリットもあるので, 簡潔な表現を用いることも同時に意識しましょう.

### Rule 7: スクリーンショットやショート動画を活用する

- 文字だけの情報は人間はすぐには理解できません.
- 理解を補助するのにスクリーンショットでの画像での説明は非常に有効です

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- kazamやbuilt-inのレコーディングやスクリーショットのショートカットを作成する
- プログラム操作や手順紹介のとき, 動画を取るようにする

</div>

### Rule 8: 徹底的に不確実な部分をなくす

主語や目的語が曖昧だと、合意したつもりでも認識の齟齬が生まれる場合があります. あとで証拠としてテキストが残っていないと後で言った言わないの水掛け論になってしまうリスクがあります.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- 必ず合意やコミュニケーションの内容が誰が見ても一意に受け取れる内容であるかを意識する

</div>

すべての場面ではないですが, 省略された専門用語の使用を回避することが Rule 9より導かれます. 例として, Pull RequestをPRと記載した場合, エンジニアやDSにはPull Requestだろうなと解釈される可能性が高いですが, 文脈に応じてはPublic Relationsと解釈される可能性もあります.


### Rule 9: どの文面への返信かを引用する

返信対象の文面が精確じゃないと伝えたいことが伝わらない場合があります.

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- テキスト上ではニュアンスでの相互理解ではなく精確さ・緻密さを意識する

</div>


### Rule 10: 返信に時間がかかるときはそれだけを先に伝える

返信を送るのが遅れると相手は作業がストップしたり, 作業の計画が立てづらくなったりして困ってしまいます.

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- 返信が遅れる場合は, 先に返信が遅れることだけを先に伝えると相手に親切
- なぜ遅れるか, 想定の返信にかかる時間も簡単に伝える

</div>

### Rule 11: 感謝を伝える

face-to-faceでのコミュニケーションを通じて, 何かしらの課題が解決された場合はすぐ「ありがとう！」って笑顔で伝えることができますが, テキストだと

- そもそも情報は読んでもらえたのか？
- 読んだ上で課題は解決したのか？

がわかりません. 

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Action</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- 役に立ったメッセージを受け取ったら感謝する
- なぜ感謝しているのかを要約し, 受け取る側が簡単に理解できるようにする

</div>

### Rule 12: 絵文字を使用する

テキストだけのコミュニケーションはface-to-faceの会話よりも味気なくなったり, 余計冷たく受け取られるという特徴があります. なんでもいいので絵文字を多少使うだけでコミュニケーションに温かみが出るので使いましょう

|入力|絵文字|
|---|---|
|`:pray:`|🙏|
|`:sweat:`|😓|
|`:sweat_smile:`|😅|
|`:raising_hand:`|🙌|
|`:ok_hand:`|👌| 
|`:thinking_face:`|🤔|

References
----------

- [The GitLab Handbook > Communicating effectively and responsibly through text](https://handbook.gitlab.com/handbook/company/culture/all-remote/effective-communication/)
- [Ryo's Tech Blog > Keychron V10 初期設定 > layer-level-2での設定](https://ryonakagami.github.io/2024/04/08/keychronV10-setup/#layer-level-2%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)
