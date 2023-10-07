---
layout: post
title: "SRE, SLIs, SLOs, SLAs?"
subtitle: "MLOps tutorial 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-10-08
tags:

- architecture
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [SREはどのような問題を解決するために登場したコンセプトか？](#sre%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AA%E5%95%8F%E9%A1%8C%E3%82%92%E8%A7%A3%E6%B1%BA%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AB%E7%99%BB%E5%A0%B4%E3%81%97%E3%81%9F%E3%82%B3%E3%83%B3%E3%82%BB%E3%83%97%E3%83%88%E3%81%8B)
- [SLI: Service Level Indicators](#sli-service-level-indicators)
  - [Availability Table](#availability-table)
- [SLO: Service Level Objectives](#slo-service-level-objectives)
  - [SLAとの違い](#sla%E3%81%A8%E3%81%AE%E9%81%95%E3%81%84)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## SREはどのような問題を解決するために登場したコンセプトか？

サービス開発&運用において, 

- Agility: adding new features, fixing bugs, etc
- Stability: サービスの安定稼働

のトレードオフは頻繁に発生します. このトレードオフに関するguiding principlesなるものとしてSRE
という概念が生まれました.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: SRE(Site Reliability Engineering)</ins></p>

SREとは下記の項目について開発者から運用者まで組織横断的にコミュニケーションすることで, 理想的な
DevOpsを実現しようとするアプローチのこと:

- Availabilityの定義
- 適切なAvailability Levelの定義
- インシデント発生時のプラン

</div>

SREを具体的に実行するためには, Product Ownerと協力して

- Servuce Level Indicators: なにを見るべきか
- Service Level Objectives: 指標の目標値

を事前に定義することが必要です. ただし, 指標を具体的に定義する前に忘れてならないのが
そもそもAvailabilityとはなにかを合意することです.

```
First, you really have to define what availability is in addition to
defining how available you want to be.
```

基本的にAvailabilityは, **システムがある時点で目的の機能を実行できるかどうか**という観点で定義されます.


## SLI: Service Level Indicators

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Service Level Indicators</ins></p>

SLIは経時的に観察される指標のことで, その目的はサービスの品質を測るところにあります. 良いSLIの性質として,

- 顧客が幸せになったら, 上昇する指標
- 顧客が不幸せになったら, 下降する指標
- 通常時と異常時の違いが現れる指標
- 分散が小さい指標(疑似相関がない指標など)

</div>

SLIの例として,

- Request latency
- Batch throughput
- Failures per request
- Support center complaints

一般的には割合を用いた指標を用いることが多く

$$
SLI = \frac{\text{良いイベント}}{\text{有効イベント}} \times 100 \text{ \%}
$$

という形で定義されます.


### Availability Table

|Availability| downtime per day|downtime per week|downtime per month|downtime per year|
|------------|-----------------|-----------------|------------------|-----------------|
|`99%`|`14.40 min`|`1.68 hours`|`7.31 hours`|`3.65 days`|
|`99.9%`|`1.44 min`|`10.08 min`|`43.83 min`|`8.77 hours`|
|`99.99%`|`8.64 sec`|`1.01 min`|`4.38 min`|`52.60 min`|
|`99.999%`|`864.0 ms`|`6.05 sec`|`26.30 sec`|`5.26 min`|


## SLO: Service Level Objectives

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Service Level Objivetics</ins></p>

SLOとは, 経時的なSystem/Service Availabilityを測るSLIの上限/下限閾値数値のこと.

AvailabilityはSLIのupper/lower boundとして定義されるもので, 調整余白がないと
開発スピードの向上とシステム安定性のトレードオフ問題が解決できなくなる点を水準設定にあたって留意する必要がある.

</div>

100% AvailabilityとSLOの水準との差をエラーバジェットと呼びます. システムの設計やアーキテクチャの変更が必要かどうかについて検討する際には, 

- システムがこの SLO を引き続き満たすか？
- エラーバジェットの範囲内に収まりそうか？

という観点から考慮する必要があります. 

### SLAとの違い

SLAはユーザーに約束するService/System Availabilityのことで, 契約書面に現れるものです. これを怠った場合は, 契約文面に従ってなんらかのペナルティが課せられる特徴があります.

一方, SLOはDevOpsを円滑に進めるために設定する基準であり, 同じ目標数値であっても使用される文脈が異なります.
一般的には, 1 か月間の SLA が 99.9% に対して、内部の SLO は 99.95%のように, SLA基準は内部のSLO よりも緩いケースが多いです.



References
---------------

- [The Art of SLOs](https://sre.google/resources/practices-and-processes/art-of-slos/)
- [SLIs, SLOs, SLAs, oh my! (class SRE implements DevOps)](https://www.youtube.com/watch?v=tEylFyxbDLE)
- [Tune up your SLI metrics: CRE life lessons](https://cloud.google.com/blog/products/management-tools/tune-up-your-sli-metrics-cre-life-lessons)
- [Google SRE Books](https://sre.google/books/)