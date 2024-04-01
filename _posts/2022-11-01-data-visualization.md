---
layout: post
title: "Plotlyを用いた2つの時系列データ比較"
subtitle: "Story-telling with data 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-01
tags:

- Data visualization
- Python
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題意識](#%E5%95%8F%E9%A1%8C%E6%84%8F%E8%AD%98)
- [今回のお題: 人員補充のリクエスト](#%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%81%8A%E9%A1%8C-%E4%BA%BA%E5%93%A1%E8%A3%9C%E5%85%85%E3%81%AE%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88)
  - [分析フレームワーク](#%E5%88%86%E6%9E%90%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF)
  - [可視化](#%E5%8F%AF%E8%A6%96%E5%8C%96)
- [Python Plotlyコード紹介](#python-plotly%E3%82%B3%E3%83%BC%E3%83%89%E7%B4%B9%E4%BB%8B)
  - [時系列ごとの太さとカラーの調整](#%E6%99%82%E7%B3%BB%E5%88%97%E3%81%94%E3%81%A8%E3%81%AE%E5%A4%AA%E3%81%95%E3%81%A8%E3%82%AB%E3%83%A9%E3%83%BC%E3%81%AE%E8%AA%BF%E6%95%B4)
  - [全体のテイストの調整](#%E5%85%A8%E4%BD%93%E3%81%AE%E3%83%86%E3%82%A4%E3%82%B9%E3%83%88%E3%81%AE%E8%AA%BF%E6%95%B4)
  - [Markerとtextの追加](#marker%E3%81%A8text%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [イベント発生タイミングの追加とテクスト](#%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88%E7%99%BA%E7%94%9F%E3%82%BF%E3%82%A4%E3%83%9F%E3%83%B3%E3%82%B0%E3%81%AE%E8%BF%BD%E5%8A%A0%E3%81%A8%E3%83%86%E3%82%AF%E3%82%B9%E3%83%88)
  - [Footnoteの追加](#footnote%E3%81%AE%E8%BF%BD%E5%8A%A0)
- [Appendix I: RAPフレームワーク](#appendix-i-rap%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF)
- [Appendix II: Data Generating Process](#appendix-ii-data-generating-process)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 問題意識

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >storytelling with dataより</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

The more infomation you're deealing with, the difficult it is to filter down to the most important bits.

When engaging in data storytelling, it is imperative to adhere to the following principles:

- focus on the message
- simple beats sexy

</div>

PlotlyやTableauなどのツールのおかげでデータの可視化は容易くできるようになった一方, 本来求められているものデータの可視化自体ではなく, **データの可視化を通じてストーリーを伝えること**です. 

データの可視化で生成されるグラフやpngファイルにどのように分析ストーリーを組み込んでいくのかをシリーズを通して勉強していきます.

## 今回のお題: 人員補充のリクエスト

<div style='padding-left: 1em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>意思決定者へ伝えたいこと</ins></p>

- 2021年5月にバックオフィスチームより2人離職 & 追加人員補填なし
- 2021年7月以降, 契約受注件数に対して処理件数遅れてしまっており, 人員追加が必要と役員に伝えたい

</div>

2021年の契約受注件数と処理件数の実績データを抽出したところ以下のような結果になった.

{% include sample_data/20221101_received_process_cnt.html %}

これだけを見せても「**2021年7月以降, 契約受注件数に対して処理件数遅れてしまってる**」ということは読み解くことは難しいです.

### 分析フレームワーク

いきなり可視化に入る前に, そもそも分析とはなにかを簡単に振り返ります.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >分析フレームワーク</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

1. 分析の前提となる意思決定問題, クエッションを理解する = What is the matter?
2. 意思決定を行うにあたって必要な情報はなにかを理解する = What answer do you want to tell?
3. QuestionとAnswerのコンテクストを説明する = How do you tell your story?

</div>

そもそも分析や可視化はそれ自体に価値があるのではなく「**意思決定をサポートする**」という観点で価値があるものです.
そのため, ゴールは「**分析結果を構造化し, 分かりやすく & 一貫性のあるストーリーを意思決定者に伝える**」ことであるべきです.

今回はすでに分析方針がお題で与えられてますが, それを整理すると以下のようになります

- What is the matter?: 契約受注件数に対して処理件数遅れてしまっている
- What answer?: 処理件数遅れはバックオフィスチームの人員不足に起因する
- How do you tell your story?: バックオフィスチームの離職発生以後に処理件数遅れが発生するようになった

### 可視化

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >可視化のお作法</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">
 
1. gridlineは薄い色を用いること, 競合してしまう場合はなくしてしまうこと
2. data markerは意図を持って使用すること
3. axis labelはtidyであること
4. 比較の際は, 基準ラインを薄く(細く), 比較対象を濃く(太く)すること
5. データソースや重要な前提条件はfootnoteに記載すること

</div>

上述のポイントを踏まえて今回作成した分析可視化は以下となります


{% include plotly/20221101_compare_two_ts.html %}

ポイントとしては

- Titleには分析から導かれる意思決定内容 = Answerを明記
- 比較対象時系列(=基準ライン)を細い & 薄いグレイ, 注目すべき時系列を太く & 濃いネイビーで表現
- イベント発生月以前と以後をわかりやすくする
- 着目してもらいたい数値のみをマーカーで強調
- Footnoteにデータソース, 及びデータ前提条件を明記

## Python Plotlyコード紹介

分析用データはすでに`df`オブジェクトに格納されているとします. `df`の中身については上で説明したとおりです.

### 時系列ごとの太さとカラーの調整

```python
fig = px.line(
    df,
    x="month",
    y=["received", "processed"],
    labels={"month": "", "value": "Number of tickets"},
    color_discrete_map={"received": "#757C88", "processed": "#00004d"}, # Color調整
    title="<b>受注処理件数水準の回復には2 FTEの補充が必要</b><br><sup>月次受注件数及び処理件数推移</sup>",
)

# 太さ調整
fig.data[0]['line']['width'] = 2
fig.data[1]['line']['width'] = 4
```

### 全体のテイストの調整

**フォントとバックグラウンドカラーの白色への変更**

```python
fig.update_layout(template="simple_white", font={"family": "Meiryo"})
```

**y軸とx軸の範囲と表記の調整**

```python
fig.update_yaxes(range=[0, 300], showgrid=True)
fig.update_xaxes(
    dtick="M1",
    ticklen=0,
    tickformat="%m月\n%Y",
    showticklabels=True,
    visible=True,
    showgrid=False,
)
```

### Markerとtextの追加

```python
# -------------------
# Marker用データの作成
# -------------------

x_scatter = df.loc[df["month"] >= "2021-08-01", "month"]
y_scatter_recieved = df.loc[df["month"] >= "2021-08-01", "received"]
y_scatter_processed = df.loc[df["month"] >= "2021-08-01", "processed"]

# -------------------
# Markerの追加
# -------------------
# 比較対象時系列
fig.add_traces(
    go.Scatter(
        x=x_scatter,
        y=y_scatter_recieved,
        mode="markers+text",
        text=y_scatter_recieved,
        textposition="top center",
        marker_color="gray",
        hoverinfo="skip",
        showlegend=False,
        marker=dict(
            size=10,
        ),
    )
)

# メイン時系列
fig.add_traces(
    go.Scatter(
        x=x_scatter,
        y=y_scatter_processed,
        mode="markers+text",
        text=y_scatter_processed,
        textposition="bottom center",
        marker_color="#00004d",
        hoverinfo="skip",
        showlegend=False,
        marker=dict(
            size=10,
        ),
    )
)
```

### イベント発生タイミングの追加とテクスト

```python
fig.add_vline(x=pd.to_datetime("2021-05-01"), line_width=1, opacity=1, line_dash="dash")
fig.add_shape(
    type="rect",
    fillcolor=fig.layout["template"]["layout"]["plot_bgcolor"],
    opacity=1,
    x0="2021-05-03",
    y0=262,
    x1="2021-12-31",
    line=dict(color=fig.layout["template"]["layout"]["plot_bgcolor"]),
    y1=300,
    label=dict(
        text=(
            "<b>５月にて従業員２名の離職</b><br>"
            "従業員離職後,２ヶ月間は受注オーダー件数に"
            "応じた処理が<br>できていたが, ８月より処理件数の"
            "遅れが恒常的に発生"
        ),
        textposition="top left",
        font=dict(size=11),
    ),
)
```

### Footnoteの追加

```python
fig.add_annotation(
    x=-0.1,
    y=-0.2,
    xref="paper",
    yref="paper",
    xanchor="left",
    yanchor="bottom",
    font=dict(size=12),
    xshift=-1,
    yshift=-5,
    text=(
        "Data source: corporate.order_table, as of 2022-01-15"
        " | 受注件数はキャンセルを除外して計算"
    ),
    showarrow=False,
)
```

## Appendix I: RAPフレームワーク

|項目|説明|
|---|---|
|Research Question|意思決定者が直面している問題について, 手元の分析でどの範囲を答えるのか（= スコープ設定）を簡易に表現した文章|
|Answer|Research Question に対する分析結果, Research Question の文章に対応した返答になっていること|
|Positioning|Research Question が「なぜ重要か？」「意思決定問題とどのように関連しているのか」「なぜ実施する必要があるのか」というコンテクストを説明する|

なお, RAP フレームワークは分析アウトプットが満たすべきフォーマットを示唆するだけで, PDCA サイクルみたいな進め方を意味するものではありません.

## Appendix II: Data Generating Process

今回のサンプルデータの生成コードです.

```python
# ------------------
# data generating
# ------------------
import pandas as pd
import numpy as np

np.random.seed(42)

mu = 150
std = 20
effect_pre = 10
effect_main = 30

start_month = "2021-01-01"
end_month = "2021-12-01"
before_treatment_month = pd.to_datetime("2021-05-01")
treatment_actual_month = pd.to_datetime("2021-08-01")

# make columes
time_range = pd.date_range(start=start_month, end=end_month, freq="MS")
effect_array = np.where(time_range > before_treatment_month, effect_pre, 0)
effect_array = effect_array + np.where(
    time_range >= treatment_actual_month, effect_main, 0
)

processed = np.int64(np.random.normal(mu, std, len(time_range)))
received = np.int64(processed + effect_array) + np.int64(
    np.random.normal(0, 5, len(time_range))
)

df = pd.DataFrame({"month": time_range, "received": received, "processed": processed})
df.head()
```



References
----------

> R code

- [GitHub >  adamribaudo/storytelling-with-data-ggplot](https://github.com/adamribaudo/storytelling-with-data-ggplot)

> Plotly

- [Plotly > Shapes in Python](https://plotly.com/python/shapes/)