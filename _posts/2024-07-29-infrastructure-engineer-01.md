---
layout: post
title: "インフラエンジニアのお仕事を理解する"
subtitle: "Understanding Infrasturacture Engineer 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-07-31
tags:

- development
---

## インフラエンジニアのお仕事

POSシステムやサッカー動画視聴サービスなど日常生活で様々なITサービスが現代社会では利用されています．
これらITサービスの提供に必要なIT環境（= ITインフラ）を設計・構築・運用する人がインフラエンジニアと呼ばれる人々です．

インフラエンジニアの紹介にあたって「ITインフラを設計・構築・運用」という言葉を用いましたが，この３つはおおよそ
インフラエンジニアの仕事のフェーズと対応しています．

<strong > &#9654;&nbsp; インフラ設計</strong>

- ITインフラ構築の目的をヒアリングを通じて理解し，その目的を達成するために必要な機能・性能などを要件としてまとめる
- 要件・性能を踏まえた上で，インフラの設計書・作業計画書を作成
    - 必要ソフトウェア，ハードウェアを提示
    - インフラ構築に要する費用や期間の算定もこの時点で行う

<strong > &#9654;&nbsp; インフラ構築</strong>

- 以下のようなインフラ構築作業をチームやベンダーの力を利用しながら実施
    - 機器の運搬，組み立て，取り付け
    - ソフトのインストール，設定（サーバーやネットワークの設定など）
    - 動作テストや負荷テストの実施

<strong > &#9654;&nbsp; インフラ運用</strong>

- アウトソースも含め，24時間365日稼働するインフラの監視と運用をチームとして実施

|観点|説明|
|---|---|
|**障害対応**| ハードの故障や急激なサーバー負荷の増大により障害は発生するため，障害原因の分析とその対策の実行|
|**キャパシティ管理**| 繁閑期に合わせてサーバーのスケールを調整する(FIFA World Cup期間中はアクセス数が普段と比べ増大するのでリソースを確保しておくなど)|

システム障害が発生したとしても，インフラ起因ではなくサーバーで稼働しているアプリケーション起因の場合もありますが，
まず初動対応はインフラエンジニアが行います．障害原因分析を通じて，障害解消のために必要なアクションのディレクション
を担当部署に対して行う形で進めていきます．