---
layout: post
title: "Kanbanボードを用いた開発環境整理"
subtitle: "カンバンとはなに？"
author: "Ryo"
header-style: text
header-mask: 0.0
mathjax: true
catelog: true
last_modified_at: 2023-05-09
tags:
  - Development
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Kanbanとは？](#kanban%E3%81%A8%E3%81%AF)
  - [Kanbanの利点](#kanban%E3%81%AE%E5%88%A9%E7%82%B9)
  - [Kanbanの構成要素](#kanban%E3%81%AE%E6%A7%8B%E6%88%90%E8%A6%81%E7%B4%A0)
  - [Kanbanが機能するにあたっての必要条件](#kanban%E3%81%8C%E6%A9%9F%E8%83%BD%E3%81%99%E3%82%8B%E3%81%AB%E3%81%82%E3%81%9F%E3%81%A3%E3%81%A6%E3%81%AE%E5%BF%85%E8%A6%81%E6%9D%A1%E4%BB%B6)
- [Kanbanをチーム開発に根付かせるためには？](#kanban%E3%82%92%E3%83%81%E3%83%BC%E3%83%A0%E9%96%8B%E7%99%BA%E3%81%AB%E6%A0%B9%E4%BB%98%E3%81%8B%E3%81%9B%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AB%E3%81%AF)
  - [チケットの記載の仕方](#%E3%83%81%E3%82%B1%E3%83%83%E3%83%88%E3%81%AE%E8%A8%98%E8%BC%89%E3%81%AE%E4%BB%95%E6%96%B9)
    - [ユーザーストーリー記述のTips](#%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AA%E3%83%BC%E8%A8%98%E8%BF%B0%E3%81%AEtips)
    - [User Storyの基本構文](#user-story%E3%81%AE%E5%9F%BA%E6%9C%AC%E6%A7%8B%E6%96%87)
    - [User Story, Epic, and Initiatives](#user-story-epic-and-initiatives)
    - [テンプレート例](#%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88%E4%BE%8B)
  - [どのように進捗をモニタリングするか？](#%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AB%E9%80%B2%E6%8D%97%E3%82%92%E3%83%A2%E3%83%8B%E3%82%BF%E3%83%AA%E3%83%B3%E3%82%B0%E3%81%99%E3%82%8B%E3%81%8B)
    - [件数 vs ポイント](#%E4%BB%B6%E6%95%B0-vs-%E3%83%9D%E3%82%A4%E3%83%B3%E3%83%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Kanbanとは？

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/9ed3fc7d06eb49ebb697acaf57c56b6b46f13408/Development/20230314_agile_kanban_board.png">


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Kanban</ins></p>

「Backlog」「In-Progress」「Review」「Confirmed」などとチケットが流れるステージを定義し, 
現時点で各チケットがどのステージにどれだけ滞留しているかを可視化することを通じて, チームリソース管理やチケット
進捗管理を実現する仕組みのこと.

どのステージにどの程度のチケットが滞留しているか?, どのステージに余剰人員/人員不足が発生しているか？
を判断する要請から, 各チケットにはチームメンバーが共通して理解できる**優先度**が定義されている必要がある.

</div>

### Kanbanの利点

KanbanのメリットはTask Planningの効率化です. どのように効率化するかというと, 以下の5つの経路で実現されます:

1. **Planning flexibility**
2. **Shortened time cycles**
3. **Avoid multitasking**
4. **Visual metrics**
5. **Continuous delivery**

ただし, Kanbanボードは現在進行中のチケットのみにフォーカスする = 完了チケットを振り返る仕組みではないことに留意してください.


<p class="h4"><ins>(1): Planning flexibility</ins></p>

- プロジェクトオーナーはBacklogのチケットの優先度のメンテナンスを、現在進行中のチケットに影響を与えることなく実行できる
- 開発チームはBacklogに存在するチケットのうち優先度の高いチケットにフォーカスすることができる
- チケットを完了次第, Backlogから優先度に基づき次のチケットを取り出す形でプロジェクトを進めていくことができる


<p class="h4"><ins>(2) Shortened time cycles</ins></p>

- チケットの起票からdelivery pointまでに要した時間をCycle timeという
- Cycle timeをモニタリングすることで, プロダクトのリードタイムの見積もりと改善点のリストアップが可能となる

<p class="h4"><ins>(3) Avoid multitasking</ins></p>

- 同時に進行中の仕事が多いほど, 完了までの過程でのコンテキストの切り替えが増え, 完了までの道のりが遅くなる
- WIP Limitを設定することでMultitaskingの最小化, 現状のリソースでこなせる仕事量の可視化, リソース不足の監視を実現する

> PRO TIP:
>> チーム開発において, ToDo, 進行中, コードレビュー, Doneの４つのステージが設定されているとします. 
>> このとき, Reviewステージに対して低めのWIP Litmitを設定するがよく見られるプラクティスです.
>> 開発者は他人の仕事を見るよりも新しいコードを書くことを好むことがよくあります. 低めのWIP Litmitによって, 
>> チームがレビューステートの問題に特別な注意を払い, 自分自身のコードレビューを上げる前に他人の仕事をレビューするように促し, 
>> 全体的なサイクルタイムを短縮するという意図があります.

<p class="h4"><ins>(4) Visual metrics</ins></p>

チームの効率性 & 進捗監視として以下の4つの指標を見ることができるようになる:

1. **平均サイクル時間の変化**
2. **ステージごとのチケット着手件数/ポイント**
3. **ステージごとの累積処理件数/ポイント**
4. **Reopened issue件数/ポイント**

> Burnup chart例

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/837031d6c3fe33e84d2d0745dc8ddb8a77e77feb/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20230314_burnupchart.png">


<p class="h4"><ins>(5) Continuous delivery </ins></p>

- CDは, 理想的にはon-demandまたはautomaticallyに, 顧客に機能やアップデートを提供することを重視している
- KanbanをCI/CDパイプラインに組み込むことで, Kanbanによる予測可能性に基づいたデリバリーが実現可能になる
- Kanbanによるステージごとのモニタリングを通じて, CDのボトルネック特定も可能になる



### Kanbanの構成要素

Kanbanの構成要素は以下の５つに分解されます:

1. **Job card**
2. **columns**
3. **work-in-progress limits**
4. **a commitment point**
5. **a delivery point**


<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/20230318_kanban_example.png?raw=true">

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>(1): Job card</ins></p>

kanbanチームは, 通常1枚のチケットに1つずつ作業項目をJob card(work itemやチケットとも)に書き込む. アジャイルチームの場合, 各チケットに1つのユーザーストーリーを組み込むことができる.Kanban board上にあるこれらのvisual signalは, チームメンバーが素早くチームが取り組んでいることを理解するのに役立つ効果がある.

<p class="h4"><ins>(2): Columns</ins></p>

それぞれのColumn（swimlanes）は, 「ワークフロー」と呼ばれる特定の**アクティビティ**を表している. チケットは, 完了するまでワークフローを流れる. ワークフローは, Open, WIP, Review, Completeといった単純なものから, 開発フローに合わせた複雑なものまである.

<p class="h4"><ins>(3): WIP Limits </ins></p>

WIP Limitsとは, 任意の時点で1つのColumnにあるチケットの最大数のこと. WIP Limits が 3 の列には, 合計weightが3以上となった瞬間に新たなチケットを置くことはできなくなるなる. 

WIP Limitsは, ワークフローのボトルネック(人員不足や人員過剰)を明らかにし, フローの効率化を手助けする効果がある.

<p class="h4"><ins>(4): Commitment point </ins></p>

チームが準備ができたときに取り組むことができるプロジェクトのアイデアを, 顧客やチームメイトが入れる場所としてBacklog Columnが一般的にKanbanに存在するが, Commitment pointはアイデアがチームによって受け入れられる時点(**acknowledged**)となる.

<p class="h4"><ins>(5): Delivery point</ins></p>

デリバリーポイントは, カンバンチームのワークフローの終わりを表す.
ワークフローの効率化は, コミットメントポイントからデリバリーポイントまでのチケットをできるだけ早く進めること = リードタイムの削減が一つの重要な要素となる.

</div>

### Kanbanが機能するにあたっての必要条件

1. 現在実践されているプロセスを理解し, 現在のチームメイトのロール, 責任, およびJob titleを尊重すること
2. 継続的にプロセスを改善していく機運が存在すること
3. Job tilte関係なく, 改善提案がチームメイトから発案される雰囲気があること
4. チーム全体でKanbanワークフローをモニタリング & 改善する姿勢があること

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: KanbanチケットをBackwardsに動かしてよいのか？</ins></p>

Kanbanボードが**常に左から右に移動**する運用はチケットのモニタリングの観点から望ましい性質ですが, この一方向性要件はKanbanボード自体の要件ではありません.
運用ポリシーに基づく限り, チケットはどの方向に動いても良いですが, 基本的には**Backwardsにチケットを動かすことは非推奨です**.

1. 安易にチケットのステージを戻すことを許容してしまうと, WIP制限が複雑になる
2. ダッシュボードによる可視化が複雑になってしまう

</div>

## Kanbanをチーム開発に根付かせるためには？


### チケットの記載の仕方

アジャイルソフトウェア開発の重要な要素の1つは, エンドユーザーを最優先に考えることです. 
ユーザーストーリーをベースにチケットを作成することによって, エンドユーザーを開発における議論の中心に置くことが可能になるので,
チケットを記載する際にユーザーストーリーを意識することは重要です.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: User Story</ins></p>

ユーザーストーリーとは, エンドユーザーの観点から書かれたソフトウェア機能の簡易的な説明のこと. 
その目的は、ソフトウェアが顧客にどのような価値(Goal, not feature)を提供するかを明確にすることなので, 次の要素が記載されている必要がある:

- チームは何を作っているのか
- なぜそれを作っているのか
- それがどのような価値を生み出すのか

</div>

注意点として, ユーザーストーリー自体はテクニカルな用語を用いて記述される必要はなく, その意味でソフトウェア要件と似て非なるものです.

#### ユーザーストーリー記述のTips

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Tips</ins></p>

1. They don't go into detail. Requirements are added later, once agreed upon by the team.
2. 解決する課題と紐づけて記載する
3. だれのためのチケットなのか(= User persona)
4. ゴールを明確にする = Definition of `done` 
5. 小さく記載する(a small challenge and a small win drive momentum)
6. Ordered Steps — Write a story for each step in a larger process. = **全体像を意識する**
7. Time

</div>

> They don't go into detail. Requirements are added later, once agreed upon by the team.

各スプリントやイテレーションにおける planning meetingにて, チケットに記載されたユーザーストーリーに基づいて, 
チームは各ユーザーストーリーに必要な要件や機能について議論します.
これは, チームがストーリーを実装する際に技術的かつクリエイティブになる機会になるべきとされます. 
議論を通じて合意が得られたら, 合意された要件がストーリーに追加されます.

このとき, チームとして議論すべき項目として

- チケットのscore(weight, 重要度スコア)
- チケット消化に要するlabor cost

> Ordered Steps, 全体像を意識する

各ストーリーが大きな目標や目的に貢献するよう記載します. 
「**各ストーリーを完了するために必要な即時的なアクションに集中していれば, チームとして大きな目標や目的に向けて進むことができるはず**」
という前提と期待がKanbanボードが機能するためには必要です.

Ordered Stepを意識してチケットを記載することで, Kanbanボードを用いた開発が効率よく運営されるようになります.


#### User Storyの基本構文

```
As a [persona], I [want to], [so that].
```

---|---
`persona`|誰のために作っているのか？
`want to`|ユーザー目線でどのようなことを実現したいのか？
`so that`|チケットの実装を実現することで開発全体像にどのような影響をあたえるのか？

#### User Story, Epic, and Initiatives

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/c22cf8a231dc54d161fecb7687fac0d72b2d5d34/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20230314_story_epic_initiative.png">

---|---
Stories|User stories, エンドユーザーの観点から書かれた要件やリクエスト
Epics|複数のユーザーストーリーに分割された大きな作業アイテム
Initiatives|複数のエピックによって構成されたグループ

アジャイル開発において, ストーリーとは1〜2週間のスプリント内でチームが完了することをコミットできるもの. 
一方, エピックは数が少なく, 完成までに時間がかかりるもので, チームは通常、1四半期で2〜3つのエピックを完了することを目指すとされます.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>EpicとStoryの関係</ins></p>

以下３つはユーザーストーリーです:

- iPhoneユーザーは、モバイルアプリを使用してライブフィードの垂直ビューにアクセスする必要があります。
- デスクトップユーザーは、ビデオプレーヤーの右下隅に「フルスクリーン表示」ボタンが必要です。
- Androidユーザーは、Apple Storeにリンクする必要があります。

上記のStoriesはすべて関連しており, より大きな作業の完了(= Epic)に向けてドライブする個々のチケットと考えることができます.
この場合, Epicは「**ストリーミングサービスの改善**」となります.

<p class="h4"><ins>EpicとInitiativeの関係</ins></p>

民間宇宙探索会社が今年1回あたりの打ち上げコストを5％減らしたいと思っているとします. これは大きな目標なので, Initiativeとなります.
そのInitiativeを分解した時でてくるのがEpicとなります. 例として, 

- 打ち上げフェーズの燃料消費量を1％減らす
- 1クォーターあたりの打ち上げ回数を3回から4回に増やす
- 全ての温度調節器を71℉から69℉に下げる

</div>

#### テンプレート例

```markdown
## For Whom

- 分析者

## Want

- OLS ClassをData Classを用いて簡略化
- 余分なMethodのcallを少なくする
- 機能のダウングレードは許容しない

## How

- モジュール構成の整理
- class attributeの関係性の整理
- 関数名や変数名のタイポ修正

## Why Important?

- version 1.1.8総仕上げ

## Action
### Repository structure

- [x] : OLS Class用前処理関数をpreprocess.commonへ集約
- [x] : ReadData Class, OLS Class共通で使うmoduleはutilities.pyへ集約 

### Module FIX  
> Main

- [x] : hogehoge

> 前処理

- [x] : hogehoge

> 数値計算

- [x] : hogehoge

> Visualize

- [x] : hogehoge

## References

- hogehoge

```

### どのように進捗をモニタリングするか？
#### 件数 vs ポイント

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Tips: 件数 vs ポイント</ins></p>

選択する具体的な指標は, プロジェクトの目標と要件, 体制に依存するのでどちらのほうが良いとかはない.

</div>


チケット件数は, アプリケーションや開発体制の健全性と安定性の一般的な指標として解釈することができます. 例えば, 課題の数が時間とともに増加している場合, 

- アプリケーションの安定性が低下している
- 開発チームが効果的に課題に対処していない

このような可能性を示してくれます. 

一方, チケットポイントは, 各課題の重大性と影響度の情報を与えてくれるので, どの課題に最初に取り組むべきかの優先順位付けや優先度ベースの進捗管理に役立てることができます. 




## References

> Atlassian Blog

- [What is a kanban board?](https://www.atlassian.com/agile/kanban/boards)
- [User stories with examples and a template](https://www.atlassian.com/agile/project-management/user-stories)
- [Stories, epics, and initiatives](https://www.atlassian.com/agile/project-management/epics-stories-themes)

> Other Online Materials

- [Moving backwards on a kanban board ](https://improvingflow.com/2021/09/14/moving-backwards.html)
