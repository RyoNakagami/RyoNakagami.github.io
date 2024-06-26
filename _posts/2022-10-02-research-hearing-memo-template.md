---
layout: post
title: "リサーチヒアリングメモのテンプレート"
subtitle: "Business communication 3/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-05-13
tags:

- 方法論
- テンプレート

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [因果推論リサーチの構成要素](#%E5%9B%A0%E6%9E%9C%E6%8E%A8%E8%AB%96%E3%83%AA%E3%82%B5%E3%83%BC%E3%83%81%E3%81%AE%E6%A7%8B%E6%88%90%E8%A6%81%E7%B4%A0)
- [リサーチヒアリングメモの原則](#%E3%83%AA%E3%82%B5%E3%83%BC%E3%83%81%E3%83%92%E3%82%A2%E3%83%AA%E3%83%B3%E3%82%B0%E3%83%A1%E3%83%A2%E3%81%AE%E5%8E%9F%E5%89%87)
  - [Template例](#template%E4%BE%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## 因果推論リサーチの構成要素

|構成要素|説明|
|------|----|
|Research Question|the causal relationship of interestはなにか？|
|Theory|参考となる理論モデルはあるか？その理論モデルからどのような仮説が導き出されるか？|
|Ideal Experiment|the causal effect of interestを推定するにあたって理想的な実験はなにか？|
|Data Set|使われているデータセットは何か?<br><br>the causal relationship of interestを特定するのに役立つ特徴はなにか？<br><br>データセットには欠点があるか？|
|Descriptive Evidence|対象となる変数の間に関係があることを示唆する記述的証拠（相関関係）は何か？|
|Identification Strategy|An identification strategyとは研究者が観察データ（すなわち、無作為化試験によって生成されていないデータ）を実際の実験に近づけるために使用する方法のこと<br><br>説明変数の内生性の問題は、論文の中では議論されているか？<br><br>regressorsのvariationはどのようにして発生しているのか？<br><br>推定式に含まれていない変数の影響はあるか？<br><br>missing variableによって発生するバイアスの方向性はどのようなものか？<br><br>他の潜在的なバイアスの原因は考えられるか？<br><br>偏りの原因ごとに，データ生成プロセス、推定式、推定量を書く<br><br>その推定量が偏っている理由を説明する
|Discussion|さらにどのようなロバストネスチェックを行うことができるか？|
|Conclusion|なぜあなたの結果は重要なのか？どのようなpolicy implicationが考えられるか？|

## リサーチヒアリングメモの原則

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >ルール</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

- リサーチヒアリングメモはstand alone documentとして成立することが望ましい
- 一文を短く，目安として一文が4行以上になっていない，長すぎるのは敵
- 口語調を調整する
- 文末に句読点はついていない

</div>

### Template例

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<div style="text-align: center;">
<h2> <企業名>_<プロジェクトテーマ>_<会議体></h2>
</div>

<h3> Research Question</h3>

- Research questionsとAnswerのイメージ

<h3> Research Context</h3>

- Business Issueはなんなのか？
- 現状わかっていることとわかっていないことはなにか？
- researchがどのように「わかっていること」と「わかっていないこと」のGapを埋めるのか
- researchがどのようにBusiness Issueの解決に寄与するのか？

<h3> Identification strategy </h3>

- データ収集方法はなにか？
- Dataにはどのようなlimitationが存在するのか？
- どのようなパラメーターを解き明かしたいのか？
- 推定にあたって統計学のどの分析方法を用いるのか

<h3> Action Plans </h3>

- データ分析環境スペック(言語，データ管理環境，コード管理体制，分析者体制)
  - ​どのようなツールを利用するのか？
  - Issue管理ないし分析チケット管理はどのような仕組みで実施するか？
  - 分析者体制がプロジェクトリソース（金銭及び稼働時間）と整合的か？
- データ収集工程
  - First Trialとしていつまでにどのようなデータを取得するか？
  - 取得データのテーブルレイアウト等メタデータはどこで管理するか？
- データ前処理工程
  - どのようなデータマートを作成するのか？
  - 作成したデータマートのドキュメント資料はどこで管理するのか？
- データ可視化工程
  - データ整合性(sanity check)はどのような観点で実施するか？
  - どのような観点でEDA(Exploratory Data Analysis)を行うのか？
- estimation and inference工程
  - 推定量構築スケジュール
  - 推定実施スケジュール
  - inference実施スケジュール
  - robustness check工程
- 分析report作成工程
  - 誰に対して，いつのタイミングで，どのようなトーンで共有するのか？
  - 意思決定の場で使われるコミュニケーション様式と分析レポートは整合的か？
  - Explanatory Data Analysis(説明的なデータ可視化)の方針はなにか？

上記の各ポイントをを踏まえ上でスケジュール概要について最後に整理


</div>

<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>分析レポートにおけるトーンについて</ins></p>

ビジネスの意思決定場面においてInferenceを適切なコミュニケーションプロトコルで意思決定者に伝えるのは結構大変です．この問題は現実の場面場面で要因が異なるので一概に解決策は示すことはできないですが，自分が日々大事にしたいと思っている方針を以下箇条書きで列挙します.

- リサーチで取り扱う内容はあくまで意思決定プロセスの論点の一部分にすぎない限界を認識する
- 過去の意思決定を変更の提言をするときは，かつての意思決定の非を問うのではなく，環境の変化に原因をもとめるなど過去現在の意思決定者をリスペクトする
- 意思決定の場で使われるコミュニケーション様式を守る

</div>



References
----------
- [Ryo's Tech Blog > 初心者からのリサーチデザイン](https://ryonakagami.github.io/2022/04/01/research-design/)
