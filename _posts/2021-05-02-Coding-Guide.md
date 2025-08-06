---
layout: post
title: "Coding Style Guide Part 1"
subtitle: "哲学：良いコードとは？"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-03-12
tags:

- 方法論
- coding
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [この記事のスコープ](#%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [良いコードとは？](#%E8%89%AF%E3%81%84%E3%82%B3%E3%83%BC%E3%83%89%E3%81%A8%E3%81%AF)
  - [Readableなコードを書くにあたっての基本姿勢](#readable%E3%81%AA%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E6%9B%B8%E3%81%8F%E3%81%AB%E3%81%82%E3%81%9F%E3%81%A3%E3%81%A6%E3%81%AE%E5%9F%BA%E6%9C%AC%E5%A7%BF%E5%8B%A2)
- [原則 1: いい名前をつける](#%E5%8E%9F%E5%89%87-1-%E3%81%84%E3%81%84%E5%90%8D%E5%89%8D%E3%82%92%E3%81%A4%E3%81%91%E3%82%8B)
  - [Rule 1-1: 名前に情報を詰め込む](#rule-1-1-%E5%90%8D%E5%89%8D%E3%81%AB%E6%83%85%E5%A0%B1%E3%82%92%E8%A9%B0%E3%82%81%E8%BE%BC%E3%82%80)
    - [Action 1-1-1: エンティティの機能/定義のイメージが明確になる単語を選ぶ](#action-1-1-1-%E3%82%A8%E3%83%B3%E3%83%86%E3%82%A3%E3%83%86%E3%82%A3%E3%81%AE%E6%A9%9F%E8%83%BD%E5%AE%9A%E7%BE%A9%E3%81%AE%E3%82%A4%E3%83%A1%E3%83%BC%E3%82%B8%E3%81%8C%E6%98%8E%E7%A2%BA%E3%81%AB%E3%81%AA%E3%82%8B%E5%8D%98%E8%AA%9E%E3%82%92%E9%81%B8%E3%81%B6)
    - [Action 1-1-2: 単位/属性情報を追加する](#action-1-1-2-%E5%8D%98%E4%BD%8D%E5%B1%9E%E6%80%A7%E6%83%85%E5%A0%B1%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)
    - [Action 1-1-3: 汎用的な名前は時と場合を考えて使用する](#action-1-1-3-%E6%B1%8E%E7%94%A8%E7%9A%84%E3%81%AA%E5%90%8D%E5%89%8D%E3%81%AF%E6%99%82%E3%81%A8%E5%A0%B4%E5%90%88%E3%82%92%E8%80%83%E3%81%88%E3%81%A6%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B)
    - [Action 1-1-4: ループイタレーターは対応するオブジェクトを連想させる名前にする](#action-1-1-4-%E3%83%AB%E3%83%BC%E3%83%97%E3%82%A4%E3%82%BF%E3%83%AC%E3%83%BC%E3%82%BF%E3%83%BC%E3%81%AF%E5%AF%BE%E5%BF%9C%E3%81%99%E3%82%8B%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%82%92%E9%80%A3%E6%83%B3%E3%81%95%E3%81%9B%E3%82%8B%E5%90%8D%E5%89%8D%E3%81%AB%E3%81%99%E3%82%8B)
    - [Action 1-1-5: 抽象的な名前よりも具体的な名前](#action-1-1-5-%E6%8A%BD%E8%B1%A1%E7%9A%84%E3%81%AA%E5%90%8D%E5%89%8D%E3%82%88%E3%82%8A%E3%82%82%E5%85%B7%E4%BD%93%E7%9A%84%E3%81%AA%E5%90%8D%E5%89%8D)
    - [Action 1-1-6: 不必要に長い名前を恐れない & 不要な単語を投げ捨てる](#action-1-1-6-%E4%B8%8D%E5%BF%85%E8%A6%81%E3%81%AB%E9%95%B7%E3%81%84%E5%90%8D%E5%89%8D%E3%82%92%E6%81%90%E3%82%8C%E3%81%AA%E3%81%84--%E4%B8%8D%E8%A6%81%E3%81%AA%E5%8D%98%E8%AA%9E%E3%82%92%E6%8A%95%E3%81%92%E6%8D%A8%E3%81%A6%E3%82%8B)
    - [Action 1-1-7: クラスやメソッドといったオブジェクトの種類に応じて名前のフォーマットを使い分ける](#action-1-1-7-%E3%82%AF%E3%83%A9%E3%82%B9%E3%82%84%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%81%A8%E3%81%84%E3%81%A3%E3%81%9F%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%AE%E7%A8%AE%E9%A1%9E%E3%81%AB%E5%BF%9C%E3%81%98%E3%81%A6%E5%90%8D%E5%89%8D%E3%81%AE%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88%E3%82%92%E4%BD%BF%E3%81%84%E5%88%86%E3%81%91%E3%82%8B)
  - [Rule 1-2: 誤解を与えない正確なコロケーションを用いる](#rule-1-2-%E8%AA%A4%E8%A7%A3%E3%82%92%E4%B8%8E%E3%81%88%E3%81%AA%E3%81%84%E6%AD%A3%E7%A2%BA%E3%81%AA%E3%82%B3%E3%83%AD%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B)
    - [Action 1-2-1: 多義語の使用を回避する](#action-1-2-1-%E5%A4%9A%E7%BE%A9%E8%AA%9E%E3%81%AE%E4%BD%BF%E7%94%A8%E3%82%92%E5%9B%9E%E9%81%BF%E3%81%99%E3%82%8B)
    - [Action 1-2-2: 範囲を指定するときは包含関係に合わせて名前を使い分ける](#action-1-2-2-%E7%AF%84%E5%9B%B2%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%99%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AF%E5%8C%85%E5%90%AB%E9%96%A2%E4%BF%82%E3%81%AB%E5%90%88%E3%82%8F%E3%81%9B%E3%81%A6%E5%90%8D%E5%89%8D%E3%82%92%E4%BD%BF%E3%81%84%E5%88%86%E3%81%91%E3%82%8B)
    - [Action 1-2-3: ブール値を名付けるときは `is`, `has` を用いる](#action-1-2-3-%E3%83%96%E3%83%BC%E3%83%AB%E5%80%A4%E3%82%92%E5%90%8D%E4%BB%98%E3%81%91%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AF-is-has-%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B)
  - [Rule 1-3: 不要な変数は定義しない/意味のある変数を定義する](#rule-1-3-%E4%B8%8D%E8%A6%81%E3%81%AA%E5%A4%89%E6%95%B0%E3%81%AF%E5%AE%9A%E7%BE%A9%E3%81%97%E3%81%AA%E3%81%84%E6%84%8F%E5%91%B3%E3%81%AE%E3%81%82%E3%82%8B%E5%A4%89%E6%95%B0%E3%82%92%E5%AE%9A%E7%BE%A9%E3%81%99%E3%82%8B)
    - [Action 1-3-1: 役に立たない一時変数は使わない](#action-1-3-1-%E5%BD%B9%E3%81%AB%E7%AB%8B%E3%81%9F%E3%81%AA%E3%81%84%E4%B8%80%E6%99%82%E5%A4%89%E6%95%B0%E3%81%AF%E4%BD%BF%E3%82%8F%E3%81%AA%E3%81%84)
      - [中間変数の削除例：ウェブページの入力テキストフィールドの最初の空を埋める](#%E4%B8%AD%E9%96%93%E5%A4%89%E6%95%B0%E3%81%AE%E5%89%8A%E9%99%A4%E4%BE%8B%E3%82%A6%E3%82%A7%E3%83%96%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%AE%E5%85%A5%E5%8A%9B%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E3%83%95%E3%82%A3%E3%83%BC%E3%83%AB%E3%83%89%E3%81%AE%E6%9C%80%E5%88%9D%E3%81%AE%E7%A9%BA%E3%82%92%E5%9F%8B%E3%82%81%E3%82%8B)
    - [Action 1-3-2: 変数のスコープを縮める](#action-1-3-2-%E5%A4%89%E6%95%B0%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97%E3%82%92%E7%B8%AE%E3%82%81%E3%82%8B)
      - [JavaScriptのグローバルスコープ](#javascript%E3%81%AE%E3%82%B0%E3%83%AD%E3%83%BC%E3%83%90%E3%83%AB%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
      - [PythonとJavaScriptのネストしないスコープ](#python%E3%81%A8javascript%E3%81%AE%E3%83%8D%E3%82%B9%E3%83%88%E3%81%97%E3%81%AA%E3%81%84%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
    - [Action 1-3-3: 要約変数を用いてコードを読む時間を短くする](#action-1-3-3-%E8%A6%81%E7%B4%84%E5%A4%89%E6%95%B0%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E8%AA%AD%E3%82%80%E6%99%82%E9%96%93%E3%82%92%E7%9F%AD%E3%81%8F%E3%81%99%E3%82%8B)
      - [例：要約変数を用いてcodeのreadablityを改善する](#%E4%BE%8B%E8%A6%81%E7%B4%84%E5%A4%89%E6%95%B0%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6code%E3%81%AEreadablity%E3%82%92%E6%94%B9%E5%96%84%E3%81%99%E3%82%8B)
- [原則２: 適切なコメントをつける](#%E5%8E%9F%E5%89%87%EF%BC%92-%E9%81%A9%E5%88%87%E3%81%AA%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%82%92%E3%81%A4%E3%81%91%E3%82%8B)
  - [Rule 2-1: コードからすぐわかることをコメントに書かない](#rule-2-1-%E3%82%B3%E3%83%BC%E3%83%89%E3%81%8B%E3%82%89%E3%81%99%E3%81%90%E3%82%8F%E3%81%8B%E3%82%8B%E3%81%93%E3%81%A8%E3%82%92%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%81%AB%E6%9B%B8%E3%81%8B%E3%81%AA%E3%81%84)
    - [Action 2-1-1: コメントのためのコメントをしない](#action-2-1-1-%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%82%92%E3%81%97%E3%81%AA%E3%81%84)
    - [Action 2-1-2: ひどい名前はコメントで対応せずに名前変更で対応する](#action-2-1-2-%E3%81%B2%E3%81%A9%E3%81%84%E5%90%8D%E5%89%8D%E3%81%AF%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%81%A7%E5%AF%BE%E5%BF%9C%E3%81%9B%E3%81%9A%E3%81%AB%E5%90%8D%E5%89%8D%E5%A4%89%E6%9B%B4%E3%81%A7%E5%AF%BE%E5%BF%9C%E3%81%99%E3%82%8B)
  - [Rule 2-2: コードを書いたときの背景を解説する](#rule-2-2-%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E6%9B%B8%E3%81%84%E3%81%9F%E3%81%A8%E3%81%8D%E3%81%AE%E8%83%8C%E6%99%AF%E3%82%92%E8%A7%A3%E8%AA%AC%E3%81%99%E3%82%8B)
    - [Action 2-2-1: なぜこの書き方になったのか記述する](#action-2-2-1-%E3%81%AA%E3%81%9C%E3%81%93%E3%81%AE%E6%9B%B8%E3%81%8D%E6%96%B9%E3%81%AB%E3%81%AA%E3%81%A3%E3%81%9F%E3%81%AE%E3%81%8B%E8%A8%98%E8%BF%B0%E3%81%99%E3%82%8B)
    - [Action 2-2-2: コードの欠陥にコメントをつける](#action-2-2-2-%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E6%AC%A0%E9%99%A5%E3%81%AB%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%82%92%E3%81%A4%E3%81%91%E3%82%8B)
    - [Action 2-2-3: コードの全体像と各ブロックの役割を記述する](#action-2-2-3-%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%85%A8%E4%BD%93%E5%83%8F%E3%81%A8%E5%90%84%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF%E3%81%AE%E5%BD%B9%E5%89%B2%E3%82%92%E8%A8%98%E8%BF%B0%E3%81%99%E3%82%8B)
    - [Action 2-2-4: 曖昧な記述を回避する](#action-2-2-4-%E6%9B%96%E6%98%A7%E3%81%AA%E8%A8%98%E8%BF%B0%E3%82%92%E5%9B%9E%E9%81%BF%E3%81%99%E3%82%8B)
    - [Action 2-2-5: 歯切れの悪い文章を磨く](#action-2-2-5-%E6%AD%AF%E5%88%87%E3%82%8C%E3%81%AE%E6%82%AA%E3%81%84%E6%96%87%E7%AB%A0%E3%82%92%E7%A3%A8%E3%81%8F)
    - [Action 2-2-6: 実例、ユースケースを記載する](#action-2-2-6-%E5%AE%9F%E4%BE%8B%E3%83%A6%E3%83%BC%E3%82%B9%E3%82%B1%E3%83%BC%E3%82%B9%E3%82%92%E8%A8%98%E8%BC%89%E3%81%99%E3%82%8B)
    - [Action 2-2-7: 解決策を簡潔な言葉で表現し、記載する](#action-2-2-7-%E8%A7%A3%E6%B1%BA%E7%AD%96%E3%82%92%E7%B0%A1%E6%BD%94%E3%81%AA%E8%A8%80%E8%91%89%E3%81%A7%E8%A1%A8%E7%8F%BE%E3%81%97%E8%A8%98%E8%BC%89%E3%81%99%E3%82%8B)
- [原則３: 意味のある単位に分割する](#%E5%8E%9F%E5%89%87%EF%BC%93-%E6%84%8F%E5%91%B3%E3%81%AE%E3%81%82%E3%82%8B%E5%8D%98%E4%BD%8D%E3%81%AB%E5%88%86%E5%89%B2%E3%81%99%E3%82%8B)
  - [Rule 3-1: 一貫性のあるレイアウトを使う](#rule-3-1-%E4%B8%80%E8%B2%AB%E6%80%A7%E3%81%AE%E3%81%82%E3%82%8B%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E4%BD%BF%E3%81%86)
    - [Action 3-1-1: 一貫性のある簡潔な改行をする](#action-3-1-1-%E4%B8%80%E8%B2%AB%E6%80%A7%E3%81%AE%E3%81%82%E3%82%8B%E7%B0%A1%E6%BD%94%E3%81%AA%E6%94%B9%E8%A1%8C%E3%82%92%E3%81%99%E3%82%8B)
    - [Action 3-1-2: 意味のある並びを用いる](#action-3-1-2-%E6%84%8F%E5%91%B3%E3%81%AE%E3%81%82%E3%82%8B%E4%B8%A6%E3%81%B3%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B)
  - [Rule 3-2: 関連する項目をまとめてグループ化する](#rule-3-2-%E9%96%A2%E9%80%A3%E3%81%99%E3%82%8B%E9%A0%85%E7%9B%AE%E3%82%92%E3%81%BE%E3%81%A8%E3%82%81%E3%81%A6%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97%E5%8C%96%E3%81%99%E3%82%8B)
    - [Action 3-2-1: 反復処理はメソッドでまとめる](#action-3-2-1-%E5%8F%8D%E5%BE%A9%E5%87%A6%E7%90%86%E3%81%AF%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%81%A7%E3%81%BE%E3%81%A8%E3%82%81%E3%82%8B)
    - [Action 3-2-2: 宣言をブロックにまとめる](#action-3-2-2-%E5%AE%A3%E8%A8%80%E3%82%92%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF%E3%81%AB%E3%81%BE%E3%81%A8%E3%82%81%E3%82%8B)
    - [Action 3-2-3: コードを段落に分割する](#action-3-2-3-%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E6%AE%B5%E8%90%BD%E3%81%AB%E5%88%86%E5%89%B2%E3%81%99%E3%82%8B)
- [原則４: 全体の構成をきれいに整形する](#%E5%8E%9F%E5%89%87%EF%BC%94-%E5%85%A8%E4%BD%93%E3%81%AE%E6%A7%8B%E6%88%90%E3%82%92%E3%81%8D%E3%82%8C%E3%81%84%E3%81%AB%E6%95%B4%E5%BD%A2%E3%81%99%E3%82%8B)
  - [Rule 4-1: 簡潔な制御フローを用いる](#rule-4-1-%E7%B0%A1%E6%BD%94%E3%81%AA%E5%88%B6%E5%BE%A1%E3%83%95%E3%83%AD%E3%83%BC%E3%82%92%E7%94%A8%E3%81%84%E3%82%8B)
    - [Action 4-1-1: 条件式の引数の並び順、変化するものは左側へ](#action-4-1-1-%E6%9D%A1%E4%BB%B6%E5%BC%8F%E3%81%AE%E5%BC%95%E6%95%B0%E3%81%AE%E4%B8%A6%E3%81%B3%E9%A0%86%E5%A4%89%E5%8C%96%E3%81%99%E3%82%8B%E3%82%82%E3%81%AE%E3%81%AF%E5%B7%A6%E5%81%B4%E3%81%B8)
    - [Action 4-1-2: 条件式は否定形よりも肯定形を使う](#action-4-1-2-%E6%9D%A1%E4%BB%B6%E5%BC%8F%E3%81%AF%E5%90%A6%E5%AE%9A%E5%BD%A2%E3%82%88%E3%82%8A%E3%82%82%E8%82%AF%E5%AE%9A%E5%BD%A2%E3%82%92%E4%BD%BF%E3%81%86)
    - [Action 4-1-3: 三項演算子を適切なタイミングで使う](#action-4-1-3-%E4%B8%89%E9%A0%85%E6%BC%94%E7%AE%97%E5%AD%90%E3%82%92%E9%81%A9%E5%88%87%E3%81%AA%E3%82%BF%E3%82%A4%E3%83%9F%E3%83%B3%E3%82%B0%E3%81%A7%E4%BD%BF%E3%81%86)
    - [Action 4-1-4: ド・モルガンの法則を使う](#action-4-1-4-%E3%83%89%E3%83%BB%E3%83%A2%E3%83%AB%E3%82%AC%E3%83%B3%E3%81%AE%E6%B3%95%E5%89%87%E3%82%92%E4%BD%BF%E3%81%86)
    - [Action 4-1-5: do-whileループを避ける](#action-4-1-5-do-while%E3%83%AB%E3%83%BC%E3%83%97%E3%82%92%E9%81%BF%E3%81%91%E3%82%8B)
    - [Action 4-1-6: ネストを浅くする](#action-4-1-6-%E3%83%8D%E3%82%B9%E3%83%88%E3%82%92%E6%B5%85%E3%81%8F%E3%81%99%E3%82%8B)
      - [continueを用いてループ内部のネストを削除する](#continue%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6%E3%83%AB%E3%83%BC%E3%83%97%E5%86%85%E9%83%A8%E3%81%AE%E3%83%8D%E3%82%B9%E3%83%88%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B)
  - [Rule 4-2: 一度につき１つのタスク](#rule-4-2-%E4%B8%80%E5%BA%A6%E3%81%AB%E3%81%A4%E3%81%8D%EF%BC%91%E3%81%A4%E3%81%AE%E3%82%BF%E3%82%B9%E3%82%AF)
    - [Action 4-2-1: タスクは小さくする](#action-4-2-1-%E3%82%BF%E3%82%B9%E3%82%AF%E3%81%AF%E5%B0%8F%E3%81%95%E3%81%8F%E3%81%99%E3%82%8B)
      - [例：オブジェクトから値を抽出する](#%E4%BE%8B%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%8B%E3%82%89%E5%80%A4%E3%82%92%E6%8A%BD%E5%87%BA%E3%81%99%E3%82%8B)
    - [Action 4-2-2: ゴールからBackwardにタスクを追加していく](#action-4-2-2-%E3%82%B4%E3%83%BC%E3%83%AB%E3%81%8B%E3%82%89backward%E3%81%AB%E3%82%BF%E3%82%B9%E3%82%AF%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%97%E3%81%A6%E3%81%84%E3%81%8F)
  - [Rule 4-3: 短いコードを書く](#rule-4-3-%E7%9F%AD%E3%81%84%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E6%9B%B8%E3%81%8F)
    - [Action 4-3-1: 再利用できるものは再利用する](#action-4-3-1-%E5%86%8D%E5%88%A9%E7%94%A8%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%82%E3%81%AE%E3%81%AF%E5%86%8D%E5%88%A9%E7%94%A8%E3%81%99%E3%82%8B)
    - [Action 4-3-2: 不必要な開発は実施しない](#action-4-3-2-%E4%B8%8D%E5%BF%85%E8%A6%81%E3%81%AA%E9%96%8B%E7%99%BA%E3%81%AF%E5%AE%9F%E6%96%BD%E3%81%97%E3%81%AA%E3%81%84)
    - [Action 4-3-3: 複雑なロジックを簡潔にする](#action-4-3-3-%E8%A4%87%E9%9B%91%E3%81%AA%E3%83%AD%E3%82%B8%E3%83%83%E3%82%AF%E3%82%92%E7%B0%A1%E6%BD%94%E3%81%AB%E3%81%99%E3%82%8B)
    - [Action 4-3-4: プログラムの主目的と関係ない下位問題を抽出する](#action-4-3-4-%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%AE%E4%B8%BB%E7%9B%AE%E7%9A%84%E3%81%A8%E9%96%A2%E4%BF%82%E3%81%AA%E3%81%84%E4%B8%8B%E4%BD%8D%E5%95%8F%E9%A1%8C%E3%82%92%E6%8A%BD%E5%87%BA%E3%81%99%E3%82%8B)
      - [例：与えられた座標から最も近い場所を見つける](#%E4%BE%8B%E4%B8%8E%E3%81%88%E3%82%89%E3%82%8C%E3%81%9F%E5%BA%A7%E6%A8%99%E3%81%8B%E3%82%89%E6%9C%80%E3%82%82%E8%BF%91%E3%81%84%E5%A0%B4%E6%89%80%E3%82%92%E8%A6%8B%E3%81%A4%E3%81%91%E3%82%8B)
- [Appendix](#appendix)
  - [火星探査機の失敗事故（1999年）](#%E7%81%AB%E6%98%9F%E6%8E%A2%E6%9F%BB%E6%A9%9F%E3%81%AE%E5%A4%B1%E6%95%97%E4%BA%8B%E6%95%851999%E5%B9%B4)
  - [Coding Conventionの構成要素](#coding-convention%E3%81%AE%E6%A7%8B%E6%88%90%E8%A6%81%E7%B4%A0)
  - [命名表](#%E5%91%BD%E5%90%8D%E8%A1%A8)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## この記事のスコープ

このノートとは「良いコード」を書くためのお約束ごと(主に命名規則とコーディングスタイル)を紹介します. 構成としては、はじめに「良いコードとはなにか？」を定義し、良いコードを書くために必要な「４原則」を紹介します. その後、各原則から導き出される「Rule」を提示し、その「Rule」に付随する具体的な「Action」を具体例を交えながら説明するという流れをとってます. 

なお、このノートの大部分は[The Art of Readable Code by Dustin Boswell and Trevor Foucher. Copyright 2012 Dustin Boswell and Trevor Foucher, 978-0-596-80229-5](https://www.oreilly.co.jp/books/9784873115658/)を参考にして書いています. 

## 良いコードとは？

- Readable → Understandable → Improvable

良いコードとは要件定義通りに動き、バグがなく、省メモリで動作し、高速なプログラムを実現するコードです. 多くの場合、幾通りの試行錯誤と他人からのレビューに揉まれて(PDCAを何回も回して)、良いコードは生まれて来ます. そのため、良いコードは他の人が「バグをみつけたり、修正しやすい」コード = improvableであることが必要条件であると言えます. 

Improvableなコードを書くためには、改善ポイントを特定しやすくするため、プログラムの構成や変数やロジックを理解できる必要があります. つまり、Understandableなコードでなければなりません. Understandableなコードを書くということは、他の人が短時間で何が書いてあるか把握することができるコードを書くということ = Readableなコードを書くということです. 

以下では、この考えに基づいてReadableなコードを書くための基本原則を紹介します. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Readableなコードの4原則</ins></p>

1. いい名前をつける
2. 適切なコメントをつける
3. 意味のある単位に分割する
4. 全体の構成をきれいに整形する

</div>

**「他の人」とは？**

「他の人」とは、プロジェクトのことをコードの書き手本人のように熟知していない人のことです. 書き手本人も「他の人」になり得ます. コードを書いてから数日経ってしまったら、コード書いていた時の自分の考えを思い出せないことも十分考えられるからです. 

### Readableなコードを書くにあたっての基本姿勢

「他の人が短時間で何が書いてあるか把握することができるコードを書くということ = Readableなコードを書く」にあたって、以下で紹介する4原則の前提として必要な基本姿勢は、「自分よりも知識が少ない人が理解できるような簡潔な言葉で自分の考えを伝える」という姿勢です.

このことを実践するためには、

- 自分の考えを明確にし、簡潔な言葉で表現する
- 自分の考えを凝縮して、キーポイントなる概念はなにか？を常に考える
- 細かいことまで話しすぎると相手は混乱するので、あくまで必要最小限の情報を伝える


## 原則 1: いい名前をつける

いい名前をつけるということは, 「新しいチームメイトもその名前の意味を理解することができるか」という観点で判断されます. これを実現するためのルールとして、

1. 名前に情報を詰め込む
2. 誤解を与えない正確なコロケーションを用いる
3. 不要な変数は定義しない/意味のある変数を定義する

この2つのポイントが抑えられている必要があります. 

### Rule 1-1: 名前に情報を詰め込む

名前に情報を詰め込むためのActionリストは以下： 

- エンティティの機能/定義のイメージが明確になる単語を選ぶ
- 単位/属性情報を追加する
- 汎用的な名前は時と場合を考えて使用する
- ループイタレーターは対応するオブジェクトを連想させる名前にする
- 抽象的な名前よりも具体的な名前
- 不必要に長い名前を恐れない & 不要な単語を投げ捨てる
- クラスやメソッドといったエンティティの種類に応じて名前のフォーマットを使い分ける

#### Action 1-1-1: エンティティの機能/定義のイメージが明確になる単語を選ぶ

```python
def GetPage(url):
    ...
```

という関数があるとします. 「Get」という言葉からurlで指定されたページの情報を取得することは連想されるが、DBからなのか、インターネットからなのかは推察することはできません. 仮にインターネットからであるならばコロケーションの観点からここでは「Fetch」を使うべきとなります.

```js
class Thread {
    void Stop();
    ...  
};
```

この場合は、動作に合わせてより動作イメージが明確になる言葉を選ぶべきとなります. 例えば、取り消しができないStopなら`Kill()`, あとから`Resume()`ができる処理なら`Pause()`にすべきとなります. 

```python
def compute_l2norm(v):
    ...
    retval += v[i]*v[i]
    ...
```

`retval`という名前をしようしていることから、戻り値を格納している変数と推察されますが、L2ノルムを計算しているので `sum_squares`という方が望ましいです. この変数名にすることで, `sum_squares += v[i]` という用に書いてあった場合、自乗計算がされていないというバグが見つけやすくなります. 


#### Action 1-1-2: 単位/属性情報を追加する

何かしらのIDを管理する場合を考えます. 八進数で表現されるものであり、かつ八進数であることが重要である場合、`hex_uid`という名前をつけるべきとなります. その他にも、時間単位や危険/注意を換気する情報を付け加えるべきケースもあり、その例を下の表にまとめます. 単位の管理ミスが重大な事故を招いた例として「[火星探査機の失敗事故（1999年）](#%E7%81%AB%E6%98%9F%E6%8E%A2%E6%9F%BB%E6%A9%9F%E3%81%AE%E5%A4%B1%E6%95%97%E4%BA%8B%E6%95%851999%E5%B9%B4)」があります

|修正前|修正後|修正理由|
|---|---|---|
|`Start(int delay)`|`Start(int delay_secs)`|単位の明確化|
|`CreateCache(int size)`|`CreateCache(int size_mb)`|単位の明確化|
|`ThrotteleDownload(float limit)`|`ThrotteleDownload(float max_kbps)`|単位の明確化|
|`password`|`plaintext_password`|危険性の明確化|
|`get_mean()`|`compute_mean()`|一般的な用語方に従うと、計算量が軽いならば、`get`で始まるメソッドはメンバの値を返すだけの「軽量アクセサ」と連想させるので `get` でも問題ないが、コストが高いならば`compute`を用いるべき|

なお`get(), compute()`に関連して、C++標準では, `size()` の計算量はO(1)にすることが定められています. ですので、要素数を返すメソッドでその計算量がO(n)とかならば `countSize()`とかにするべきとなります.

#### Action 1-1-3: 汎用的な名前は時と場合を考えて使用する

汎用的な名前というのは`foo`, `hoo`, `retval`, `tmp`といった名前のことです. 「エンティティの機能/定義のイメージが明確になる単語を選ぶ」べきなので基本的には汎用的な名前は使用しないことが望ましいです. ただし、変数のスコープが短い場合は使用しても構いません：

```js
if (right < left){
    tmp  = right;
    right = left;
    left = tmp;
}
```

上における`tmp`は３行しか存在意義を持たない変数なので、「この変数は一時的なものでほかには役割はない」という情報をもっているので使用しても問題ないとなります. このように、汎用的な名前を使用する際は常に相応のJustificationを用意することが重要です.  


#### Action 1-1-4: ループイタレーターは対応するオブジェクトを連想させる名前にする

イテレーターが複数あるときは、インデックスがどのエンティティに関連するものなのか連想させる名前をつけることが推奨されます。AVOIDのコードと、BETTERのコードをしたに例として記載します.

> AVOID

```js
for (int i = 0; i < clubs.size(); i++)
    for (int j = 0; j < clubs[i]]; j++)
        for (int k = 0; k < users.size(); k++)
            ....
```

> BETTER


```js
for (int club_i = 0; club_i < clubs.size(); club_i++)
    for (int members_i = 0; j < clubs[clubs_i]]; members_i++)
        for (int users_i = 0; users_i < users.size(); users_i++)
            ....
```

#### Action 1-1-5: 抽象的な名前よりも具体的な名前

`ServerCanStart()` という名前のメソッドがあったとします. このメソッドは、任意のTCP/IPポートをサーバーがリッスンできるかを確認するメソッドとします. この場合、メソッドの動作を具体的に連想させる `CanListenOnPort()`のほうが好ましいということなります. 

#### Action 1-1-6: 不必要に長い名前を恐れない & 不要な単語を投げ捨てる

名前は、そのプロジェクトの関係者に適切な情報を与えるものであれば良いので、`evaluation`の代わりに`eval`という短縮形を使うことは許容されます. このように短縮形を使うことで、レビュアーの読む文字数を減らすことができ、よりReadableなコードとなります. ただし、この考えを極端に発展させ「長い文字列は絶対避けるべき」とすることは危険です. たしかに、長い文字列は忌避される傾向が強いですが、

- 短縮形を用いることで新しいチームメイトが理解できなかったら元の子もない
- 多くのエディタは補完機能を備えているので、長い文字を名前につけても、コーディング上（特にタイピング）の不利益はそんなにない

あくまで「不要な単語を投げ捨てる」という意識で名前付けを実施することが望ましいです. 

|AVOID|BETTER|
|---|---|
|`ConvertToString()`|`ToString()`|
|`DoServerLoop()`|`ServerLoop()`|
|`days`|`days_since_last_update`|

#### Action 1-1-7: クラスやメソッドといったオブジェクトの種類に応じて名前のフォーマットを使い分ける

プロジェクトや言語によってフォーマット規約は異なりますが、コンストラクタは大文字ではじめ、それ以外のメソッドなどは小文字で命名するという規約が多くの場合見られます. 

### Rule 1-2: 誤解を与えない正確なコロケーションを用いる

「誤解を与えない正確なコロケーションを用いる」ためのActionリストは以下、

- 多義語の使用を回避する
- 範囲を指定するときは包含関係に合わせて名前を使い分ける
- ブール値を名付けるときは `is`, `has` を用いる


#### Action 1-2-1: 多義語の使用を回避する

データベースへのクエリを書いているとします：

```python
results = Database.all_objects.filter("year <= 2011")
```

この`filter()`メソッドで`year`に関して範囲指定をしてデータを取り出すことは想像できますが、それが2011年前を除外しているのか、それとも限定しているのか曖昧です. もし、「2011年以前のレコードに絞る」という挙動をするのであれば、より明確な `select()` という名前をつけるべきとなります. 除外する場合は、`exclude()`が推奨されます.


#### Action 1-2-2: 範囲を指定するときは包含関係に合わせて名前を使い分ける

境界条件に関するエラーの１つとして、ループが正しい回数より一回多く、または一回少なく実行されるという0ff-by-one error (off-by-one bug, OBOE, OBO, OB1 and OBOB)というものがあります. 例として、「未満」で計算すべきところを、「以下」のロジックを用いて計算してしまったときに発生します. このようなエラーを予防するため、「範囲を指定したロジックを用いるときは包含関係に合わせて変数名を使い分ける」ことが推奨されています.

|CASE|RULE|RECOMMENED|
|---|---|
|カートの数量がある基準値をオーバーした時エラーが発生するようにしたいときの基準値名|`_limit`|`cart_too_big_limit`|
|とある１次元数値の上と下の限界値を示したい時（限界値はその数値の集合の要素）|`max_`, `min_`|`max_item_in_cart`, `min_item_in_cart`|
|期間の範囲指定、かつ境界値は範囲に含まれる|`first_`, `last_`|`first_visit_month`, `last_visit_month`|
|期間の範囲指定、かつ最初の境界値は範囲に含まれるが、最後の境界値は含まれない|`begin_`, `end_`|`begin_campaign_date`,`end_campaign_date`|

最後に紹介した、`begin_`, `end_` は一般的な言葉の意味と照らし合わせると直感的ではないと思いますが、C++の標準ライブラリではこのような使い方がされているらしいです.

#### Action 1-2-3: ブール値を名付けるときは `is`, `has` を用いる

Booleanの変数名は、`is`, `has`, `can`, `should` などつけるケースが多いです. 例えば、引数で指定された文字列の先頭がspaceであった場合Trueそれ以外ならFalseを返す関数が`SpaceLeft()`で与えられていたとします. この関数名だと与えられた文字列のうち一番左に存在するスペースのINDEXを返す関数のようにみえるので、`HasSpaceLeft()`という名前にしたほうがいいとなります.

### Rule 1-3: 不要な変数は定義しない/意味のある変数を定義する

変数を適当に使うとプログラムが理解しにくくなります. 具体的にどのような問題が発生するかというと;

- 変数が多いと変数を追跡するのが難しくなる
- 変数のスコープが大きいとスコープを把握する時間が長くなる
- 変数が頻繁に変更されると現在の値を把握するのが難しくなる

以下ではこれらの問題の対処方法を紹介します.

#### Action 1-3-1: 役に立たない一時変数は使わない

まずAVOIDの例を紹介します;

> AVOID

```python
now = datetime.datetime.now()
root_message.last_view_time = now
```

この`now`は意味がないとされます. 理由としては、

- 複雑な式を分割していない
- `now`を使用することで、プログラム全体の意味が明確になっているわけではない
- 重複コードの削除の効果も認められない

> BETTER

```python
root_message.last_view_time = datetime.datetime.now()
```

##### 中間変数の削除例：ウェブページの入力テキストフィールドの最初の空を埋める

以下のように配置された入力テキストフィールドがウェブページがあるとします:

```html
<input type="text" id="input1" value="Dustin">
<input type="text" id="input2" value="Trevor">
<input type="text" id="input3" value="">
<input type="text" id="input4" value="Melissa">
```

ウェブページになる最初のvalueフィールドの値が空の`<input>`に、指定された文字列を入力するという関数の作成が仕事として与えられたとします(上の例では`input3`).
関数の戻り値は、更新したDOM要素（空の入力フィールドがなければ`null`）になる.

> AVOID

```js
var setFirstEmptyInput = function(new_value){
    var found = false;
    var i =1;
    var elem = document.getElementById('input' + i);
    while (elem !== null){
        if (elem.value === ''){
            found = true;
            break;
        }
        i++;
        elem = document.getElementById('input' + i)
    }
    if (found) elem.value = new_value;
    return elem;
};
```

> BETTER

```js
var setFirstEmptyInput = function(new_value){
    var i =1;
    var elem = document.getElementById('input' + i);
    while (elem !== null){
        if (elem.value === ''){
            elem.value = new_value;
            return elem;
        }
        i++;
        elem = document.getElementById('input' + i)
    }
    return null;
};
```





#### Action 1-3-2: 変数のスコープを縮める

基本的には「グローバル変数は避ける」というよく知られた原則をアクションとして実行するだけです.
グローバル変数は、いつ、どこで、どのように定義されたかを追跡することが難しく、一つの行を理解するために見なくてはいけない範囲を広げてしまうというデメリットがあります.
また、「名前空間を汚染する = ローカル変数と衝突する」（ローカル変数を編集してると思ったらグローバル変数だったなど）というデメリットもあります.

> AVOID

```js
class LargeClass{
    string str_;

    void Method1(){
        str_ = ...;
        Method2();
    }

    void Method2(){
        // str_ を使っている
    }

    // str_ を使っていないメソッドが以下続く

};
```

ここでのメンバ変数は、クラスの中で「ミニグローバル」になっています. 大きなクラスでは、すべてのメンバ変数を追跡したり、どのメソッドが変数を変更しているかを把握することは難しいです. 従って、「ミニグローバル」はできるだけ減らしたほうが良いとなります.

> BETTER

```js
class LargeClass{
    void Method1(){
        str = ...;
        Method2(str);
    }

    void Method2(string str){
        // str を使っている
    }

    // str_ を使っていないメソッドが以下続く

};
```

##### JavaScriptのグローバルスコープ

JavaScriptでは、変数の定義に`var`をつけないと(例：`var x = 1` ではなくて `x = 1` にする)、その変数はグローバルスコープに入ってしまいます. 例として、

```js
<script>
    var f = function(){
        //危険: 'i'は'var'で宣言されていない!
        for (i = 0; i < 10; i += 1) ...
    };

    f();
</script>
```

このコードでは、意図せずに変数`i`をグローバルスコープに入れています. 従って、他のブロックからも変数が見えてしまっています.

```js
<script>
    alert(i);   //'10'が表示される. 'i'はグローバル変数
</script>
```

JavaScriptのベストプラクティスは、「変数を定義するときには常にvarキーワードをつける(例： `var x = 1`)」とされています。このプラクティスを使えば、変数のスコープをその変数が定義された関数の内側に宣言することができます.

##### PythonとJavaScriptのネストしないスコープ

C++やJavaのような言語にはブロックスコープがあります. `if`, `for`, `try`などのブロックで定義された変数は、スコープがそのブロックに制限されます. 

```c++
if (...){
    int x = 1;
}
x++; // コンパイルエラー! 'x'は未定義
```

一方、PythonやJavaScriptでは、ブロックで定義された変数はその関数全体に「こぼれ出ます」. このようなスコープ規則を持つ言語では、変数の定義がどこでなされたか見づらくなるという弊害が発生します. 左端を見れば変数の定義がわかる形でコードを書くのが望ましいとされます.

> AVOID

```python
if request:
    for valuie in request.values:
        if value > 0:
            example_value = value
            break

for logger in debug.loggers:
    logger.log("Example:", example_value)
```

> BETTER(1)

```python
example_value = None

if request:
    for valuie in request.values:
        if value > 0:
            example_value = value
            break

for logger in debug.loggers:
    logger.log("Example:", example_value)
```

> BETTER(2)

```python
def LogExample(value):
    for logger in debug.loggers:
        logger.log("Example:", value)

if request:
    for value in request.values:
        if value > 0:
            LogExample(value)
```

#### Action 1-3-3: 要約変数を用いてコードを読む時間を短くする

大きなコードの塊を小さな名前に置き換えて、管理や把握を簡単にする変数のことを要約変数といいます. 以下では、ユーザーが指定されたDocumentの編集権限を持っているか持っていないかを判定して、それぞれの場合に応じた処理を書いたプログラムを例に説明します.

> AVOID

```js
if (request.user.id == document.own_id){
    // ユーザーはこの文章を編集できる
}
...

if (request.user.id != document.own_id){
    // 文章は読み取り専用
}
```

> BETTER

```js
final boolean user_owns_document = (request.user.ud == document.own_id);

if (user_owns_document){
    // ユーザーはこの文章を編集できる
}
...

if (!user_owns_document){
    // 文章は読み取り専用
}
```

##### 例：要約変数を用いてcodeのreadablityを改善する

> AVOID

```js
var update_hightlight = function(message_num){
    if ($("#vote_value" + message_num).html() === "Up"){
        $("#thumbs_up" + message_num).addClass("hightlighted");
        $("#thumbs_down" + message_num).removeClass("hightlighted");
    } else if ($("#vote_value" + message_num).html() === "Down"){
        $("#thumbs_up" + message_num).removeClass("hightlighted");
        $("#thumbs_down" + message_num).addClass("hightlighted");
    } else {
        $("#thumbs_up" + message_num).removeClass("hightlighted");
        $("#thumbs_down" + message_num).removeClass("hightlighted");
    }
};
```

> BETTER


```js
var update_hightlight = function(message_num){
    var thumbs_up   = $("#thumbs_up" + message_num);
    var thumbs_down = $("#thumbs_down" + message_num);
    var vote_value  = $("#vote_value" + message_num).html();
    var hi          = "highlighted";

    if (vote_value === "Up"){
        thumbs_up.addClass(hi);
        thumbs_down.removeClass(hi);
    } else if (vote_value === "Down"){
        thumbs_up.removeClass(hi);
        thumbs_down.addClass(hi);
    } else {
        thumbs_up.removeClass(hi);
        thumbs_down.removeClass(hi);
    }
};
```

- タイプミスを減らすのに役に立つ
- 横幅が縮まるのでコードが読みやすくなる
- クラス名を変更することになれば、一箇所を変更すれば良い



## 原則２: 適切なコメントをつける

コメントの目的は、「コードの書き手の意図を読み手に知らせる」ことです. 一方、コメント領域は限られている & コメントを書きすぎると読む時間が増える(=コード全体を理解する時間が増える)ので、コメント領域に対する情報比率が高くなっていなくてはなりません. そのため、(1) 読み手の立場になって何が必要か？ (2) 記述は正確か？ (3) 記述は簡潔か？という観点が重要です. これを実現するためのルールとして、

1. コードからすぐわかることをコメントに書かない
2. コードを書いたときの作成過程/背景を解説する

この２つを抑える必要があります. 

### Rule 2-1: コードからすぐわかることをコメントに書かない

コードからすぐわかることをコメントに書いても、読み手には追加情報を与えず読む時間が増えるだけでいいことはなにもありません. このルールから導き出されるActionリストは以下、

- コメントのためのコメントをしない
- ひどい名前はコメントで対応せずに名前変更で対応する

#### Action 2-1-1: コメントのためのコメントをしない

関数名からすぐ推察することができることはコメントしない. 

> AVOID

```c
// 与えられたsubtreeに含まれるNodeの中から、nameとdepthに合致したNodeを見つける
Node* FindeNodeInSubtree(Node* subtree, string name, int depth)
```

> BETTER

```c
// 与えられたnameとdepthに合致したNodeかNULLを返す
Node* FindeNodeInSubtree(Node* subtree, string name, int depth)
```

#### Action 2-1-2: ひどい名前はコメントで対応せずに名前変更で対応する

コメントはひどい名前を補完するものではありません.

> AVOID

```c
// Replyに対してRequestで記述した制限を貸す
void ClieanReply(Request request, Reply reply)
```

> BETTER

```c
void EnforceLimitsFromRequest(Request request, Reply reply)
```

### Rule 2-2: コードを書いたときの背景を解説する

映画Blu-rayによく見られる監督のコメンタリーが、作品がどのように構成され、どのような考えに基づいて１シーンが撮られたかを解説してくれることで、鑑賞者の映画の理解が深まります. コードのコメントもコーディング時の背景を説明することによって、「他の人」がコードの全体像/構成要素を理解することに役立ちます. 

このルールから導き出されるActionリストは以下、

- なぜこの書き方になったのか記述する
- コードの欠陥にコメントをつける
- コードの全体像と各ブロックの役割を記述する
- 曖昧な記述を回避する
- 歯切れの悪い文章を磨く
- 実例、ユースケースを記載する

#### Action 2-2-1: なぜこの書き方になったのか記述する

「他の人」がコードをレビューしたり、updateする際に、すでに検証したことや制約上やっても意味がないことをトライして無駄な時間を生み出すことを予防するために、予めコメントにその目的に質することを記述することは有効です. 例として、


> 下手に最適化することを予防する

```c
// このデータだとハッシュテーブルよりバイナリーツリーのほうが40%速かった
```

> 定数にコメントする

```python
NUM_THREADS = 8 # 値は「>= 2 * num_processors」で十分
```

#### Action 2-2-2: コードの欠陥にコメントをつける

成果物納品期日の関係でとりあえず動くがまだ改善余地のあるコードで一旦提出したり、製作中に今は解決できないけどあとで直すと判断した箇所がでてきたりするケースは多くあります. このような場合、認識している欠陥をフォーマットに従ってコメントしとくことは、後のアクションが明確になるので有効です. その際よく見られるフォーマットを以下表にまとめます: 

|記号|説明|
|---|---|
|`TODO:`|後に実行するAction|
|`FIXME:`|既知の不具合があることを示す|
|`XXX:`|危険!大きな問題がある|
|`TIPS:`|嵌りそうな罠を事前に告知する, またはその他効率性に関する助言|

#### Action 2-2-3: コードの全体像と各ブロックの役割を記述する

- クラスがどのように連携しているのか
- データはどのようにシステムに流れているのか？
- エントリーポイントはどこにあるのか？

といった全体像は、Headerのところに書くことが推奨されています. 実際のフォーマットについては、各プロジェクトのCoding Conventionに依存します. また、全体像を踏まえた上でコードの各ブロックにそのブロックの役割を記述することも重要です. 

> 例：不動点を計算する関数の全体像をコメント

```py
def compute_fixed_point(T, v, error_tol=1e-3, max_iter=50, verbose=2,
                        print_skip=5, method='iteration', *args, **kwargs):
    r"""
    Computes and returns an approximate fixed point of the function `T`.
    The default method `'iteration'` simply iterates the function given
    an initial condition `v` and returns :math:`T^k v` when the
    condition :math:`\lVert T^k v - T^{k-1} v\rVert \leq
    \mathrm{error\_tol}` is satisfied or the number of iterations
    :math:`k` reaches `max_iter`. Provided that `T` is a contraction
    mapping or similar, :math:`T^k v` will be an approximation to the
    fixed point.
    The method `'imitation_game'` uses the "imitation game algorithm"
    developed by McLennan and Tourky [1]_, which internally constructs
    a sequence of two-player games called imitation games and utilizes
    their Nash equilibria, computed by the Lemke-Howson algorithm
    routine. It finds an approximate fixed point of `T`, a point
    :math:`v^*` such that :math:`\lVert T(v) - v\rVert \leq
    \mathrm{error\_tol}`, provided `T` is a function that satisfies the
    assumptions of Brouwer's fixed point theorem, i.e., a continuous
    function that maps a compact and convex set to itself.
    Parameters
    ----------
    T : callable
        A callable object (e.g., function) that acts on v
    v : object
        An object such that T(v) is defined; modified in place if
        `method='iteration' and `v` is an array
    error_tol : scalar(float), optional(default=1e-3)
        Error tolerance
    max_iter : scalar(int), optional(default=50)
        Maximum number of iterations
    verbose : scalar(int), optional(default=2)
        Level of feedback (0 for no output, 1 for warnings only, 2 for
        warning and residual error reports during iteration)
    print_skip : scalar(int), optional(default=5)
        How many iterations to apply between print messages (effective
        only when `verbose=2`)
    method : str, optional(default='iteration')
        str in {'iteration', 'imitation_game'}. Method of computing
        an approximate fixed point
    args, kwargs :
        Other arguments and keyword arguments that are passed directly
        to  the function T each time it is called
    Returns
    -------
    v : object
        The approximate fixed point
    References
    ----------
    .. [1] A. McLennan and R. Tourky, "From Imitation Games to
       Kakutani," 2006.
    """
    if max_iter < 1:
        raise ValueError('max_iter must be a positive integer')

    if verbose not in (0, 1, 2):
        raise ValueError('verbose should be 0, 1 or 2')

    if method not in ['iteration', 'imitation_game']:
        raise ValueError('invalid method')

    if method == 'imitation_game':
        is_approx_fp = \
            lambda v: _is_approx_fp(T, v, error_tol, *args, **kwargs)
        v_star, converged, iterate = \
             _compute_fixed_point_ig(T, v, max_iter, verbose, print_skip,
                                     is_approx_fp, *args, **kwargs)
        return v_star

    # method == 'iteration'
    iterate = 0

    if verbose == 2:
        start_time = time.time()
        _print_after_skip(print_skip, it=None)

    while True:
        new_v = T(v, *args, **kwargs)
        iterate += 1
        error = np.max(np.abs(new_v - v))

        try:
            v[:] = new_v
        except TypeError:
            v = new_v

        if error <= error_tol or iterate >= max_iter:
            break

        if verbose == 2:
            etime = time.time() - start_time
            _print_after_skip(print_skip, iterate, error, etime)

    if verbose == 2:
        etime = time.time() - start_time
        print_skip = 1
        _print_after_skip(print_skip, iterate, error, etime)
    if verbose >= 1:
        if error > error_tol:
            warnings.warn(_non_convergence_msg, RuntimeWarning)
        elif verbose == 2:
            print(_convergence_msg.format(iterate=iterate))

    return v

```

> 例：各ブロックの役割を記述する

```python
def GenerateUserReport():
    r"""
    概要
    ----------



    引数ゾーン
    ----------


    返り値ゾーン
    -------
    

    References
    ----------
    
    Notes
    -----
    

    Examples
    --------

    """

    # このユーザーのロックを獲得する
    ...

    # ユーザの情報をDBから読み込む
    ...

    # 情報をファイルに書き出す
    ...

    # このユーザのロックを開放する
    ...

```

#### Action 2-2-4: 曖昧な記述を回避する

- コメントでは曖昧な代名詞を避けることが望ましいです.

> AVOID

```c
// データをキャッシュに入れる。ただし、先にそのサイズをチェックする
```

「先にそのサイズをチェックする」の「その」がデータを指しているのか、キャッシュを指しているのかこのままでは曖昧です.

> BETTER

```c
// データをキャッシュに入れる。ただし、先にデータのサイズをチェックする
```

- 関数の動作を正確に記述することも重要です

> AVOID

```c
// このファイルに含まれる行数をカウントする
int CountLines(string filename){...}
```

> BETTER

```c
// このファイルに含まれる改行文字('\n')をカウントする
int CountLines(string filename){...}
```

#### Action 2-2-5: 歯切れの悪い文章を磨く

> AVOID

```python
# これまでにクロールしたURLかどうかでによって優先度を変える
```

このままだと、優先度を変えることはわかるが、どんなURLによって優先度が高くなるのか低くなるのかという実際の挙動がイメージできません.

> BETTER

```python
# これまでにクロールしていないURLの優先度を高くする
```

#### Action 2-2-6: 実例、ユースケースを記載する

```c
// EXAMPLE: Strip("abba/a/ba", "ab")は"/a"を返す
String Strip(String src, String chars){...}
```

このように挙動例を示すことで、テストケース/関連したエッジケースも定めやすくなるというメリットがあります.

#### Action 2-2-7: 解決策を簡潔な言葉で表現し、記載する

株式の購入を記録するシステムがあるとします. 取引には以下４つのデータがあります:

- `time`: 購入日時
- `ticker_symbol`: 銘柄
- `price`: 1株あたりの購入価格
- `number_of_shares`: 購入株式数

これらのデータはなぜか３つのテーブルに別れて管理されているとします. 各テーブルは`time`をPKとして管理されています. また、`time`で各テーブルのレコードはSORTされているとします.

|time|ticker_symbol|
|---|---|
|3:45|IBM|
|3:59|IBM|
|4:30|GOOG|
|5:20|AAPL|

|time|price|
|---|---|
|3:45|100|
|4:30|200|
|5:00|456|
|5:20|456|

|time|number_of_shares|
|---|---|
|3:45|10|
|3:50|100|
|4:30|20|
|5:00|45|

上の3つのテーブルの`time`をみてみると、データが欠落している（例: 5:20の取引は`ticker_symbo`と`price`はあるが`number_of_shares`が欠落）レコードもあり、そのような行は取引が成立していないとします. ここで、有効取引の`time`, `ticker_symbol`, `price`, `number_of_shares`をprintする関数をPythonで作成する仕事があなたに与えられたとします.

> STEP 1: これからやろうとすることを簡潔な言葉で表す

1. ３つのテーブルの行のイテレーターを一度に読み込む
2. 行のtimeが一致していなければ、一致する行まで探索を進める(=ここは複雑に成るので関数定義)
3. 一致した行をprintして、それぞれのイテレーターの行を一つ進める
4. 一致する行がすべてprintされるまで(1~3)を繰り返し実行する

> STEP 2: 全体のフローをコードで実装する

```python
def PrintStockTransactions():
    """
    Description
        ３つのテーブルの行のイテレーターを一度に読み込む
        行のtimeが一致していなければ、一致する行まで探索を進める(=AdvanceToMathcingTime)
        一致した行をprintして、それぞれのイテレーターの行を一つ進める
        一致する行がすべてprintされるまで(1~3)を繰り返し実行する
    """

    stock_iter = db_read("SELECT time, ticker_symbol FROM ...")
    price_iter = db_read("SELECT time, price FROM ...")
    num_shares_iter = db_read("SELECT time, number_of_shares FROM ...")
    
    while True:
        time = AdvanceToMathcingTime(stock_iter, price_iter, num_shares_iter)
        if time is None:
            return

        #  一致した行をprint
        print("@", time, stock_iter.ticker_symbol, price_iter.price, num_shares_iter.number_of_shares)


        # それぞれのイテレーターの行を一つ進める
        stock_iter.NextRow()
        price_iter.NextRow()
        num_shares_iter.NextRow()
```

> STEP 3: 各ブロックでの処理を言葉で記述する

全体像はSTEP2で実装でできたので、次は関数`AdvanceToMathcingTime()`を作成します. まずこの関数で実現したい処理を記述します.

1. 各イテレーターの現在の行の`time`を見る. ３つとも一致していれば終了する.
2. 一致していなければ、「遅れている」行をすすめる
3. 行が一致するまで（またはイテレーションのいずれかが終了するまで）これ1~2を繰り返す

> STEP 4: 各ブロックをコードで実装する

```python
def AdvanceToMathcingTime(row_iter1, row_iter2, row_iter3):
    """
    Description
        各イテレーターの現在の行の`time`を見る. ３つとも一致していれば終了する.
        一致していなければ、「遅れている」行をすすめる
        行が一致するまで（またはイテレーションのいずれかが終了するまで）これ1~2を繰り返す
    """

    while row_iter1 and row_iter2 and row_iter3:
        time_1 = row_iter1.time
        time_2 = row_iter2.time
        time_3 = row_iter3.time

        if time_1 == time_2 == time_3:
            return time_1
        
        # 「遅れている」行をすすめる
        time_max = max(time_1, time_2, time_3)

        while row_iter1.time < time_max:
            row_iter1.NextRow()
        
        while row_iter2.time < time_max:
            row_iter2.NextRow()
        
        while row_iter3.time < time_max:
            row_iter3.NextRow()
    
    return None #一致する行が存在しない
```

## 原則３: 意味のある単位に分割する

初心者がコーディングした場合、変数ブロックや関数が、あちこちにばらまかれて、どういった流れで処理しているのか分かりづらくなる傾向（＝目に優しくない構成）があります. 
しかし、プログラムの部品がばらまかれると、全体が無秩序に見えるようになり、Reviewerが一瞬で情報を理解することができなくなる可能性があります.

優れたソースコードは、「関連する項目をまとめてグループ化」や「レイアウトの一貫性」を通じて読み手の目に優しい構成をしています. このことを実現するために、

1. 一貫性のあるレイアウトを使う
3. 関連する項目をまとめてグループ化する

この２つを抑える必要があります. 

### Rule 3-1: 一貫性のあるレイアウトを使う

一貫性のあるレイアウトは、情報の組織化に役立ちます. 読みてがコードを読み進むのを導き、デザインの離れた部分の統一を助けます. 例として、Loop処理のインデントが挙げられます. Loop処理のネストされた部分のインデントが適切になされていれば、コードの具体的な関数やオブジェクトがわからなくても読み手はどの行がLoopの中でのどの段階なのか？を理解することができます.

#### Action 3-1-1: 一貫性のある簡潔な改行をする

任意の速度のネットワークに接続したときにプログラムがどのように動くかを評価する、Javaで書かれたコンストラクタがあるとします(=`TopConnectionSimulator`).
このコンストラクタには４つの仮引数があります:

1. 接続速度 Kbps
2. 平均遅延時間 ms
3. 遅延時間 ms
4. パケットロス率 %

ここでこのコンストラクタを用いたパフォーマンステストを実施するため、以下のコードを書いたとします:

```java
public class PerformanceTester{
    public static final TopConnectionSimulator wifi = new TopConnectionSimulator(
        500, /**Kbps*/
        80, /**millisecs latency*/
        200, /*jitter ms*/
        1 /*packet loss %*/);

    public static final TopConnectionSimulator t3_fiber = 
        new TopConnectionSimulator(
            45000, /**Kbps*/
            10, /**millisecs latency*/
            0, /*jitter ms*/
            0 /*packet loss %*/);

    public static final TopConnectionSimulator cell = new TopConnectionSimulator(
        100, /**Kbps*/
        400, /**millisecs latency*/
        250, /*jitter ms*/
        5 /*packet loss %*/);
}
```

上のコードは横幅80文字に合わせるため、`t3_fiber`の見た目が他のインスタンスと異なっています. そのため、「一貫性のあるレイアウトを使う」というRuleから逸脱し、`t3_fiber`だけ特別なインスタンスなのか？という誤った期待を読み手に抱かせます. このコードを改善するため「一貫性のある簡潔な改行位置」というアクションを取ることが推奨されます.

> BETTER (1)

```java
public class PerformanceTester{
    public static final TopConnectionSimulator wifi = 
        new TopConnectionSimulator(
            500, /**Kbps*/
            80, /**millisecs latency*/
            200, /*jitter ms*/
            1 /*packet loss %*/);

    public static final TopConnectionSimulator t3_fiber = 
        new TopConnectionSimulator(
            45000, /**Kbps*/
            10, /**millisecs latency*/
            0, /*jitter ms*/
            0 /*packet loss %*/);

    public static final TopConnectionSimulator cell = 
        new TopConnectionSimulator(
            100, /**Kbps*/
            400, /**millisecs latency*/
            250, /*jitter ms*/
            5 /*packet loss %*/);
}
```

> BETTER (2)

```java
public class PerformanceTester{
    // TopConnectionSimulator(throughput, latency, jitter, packet_loss)
    //                            [Kbps]     [ms]    [ms]     [percent]


    public static final TopConnectionSimulator wifi = 
        new TopConnectionSimulator(500, 80, 200, 1);

    public static final TopConnectionSimulator t3_fiber = 
        new TopConnectionSimulator(45000, 10, 0, 0);

    public static final TopConnectionSimulator cell = 
        new TopConnectionSimulator(100, 400, 250, 5);
}
```

#### Action 3-1-2: 意味のある並びを用いる

コードの並びがコードの正しさに影響を及ぼすことは少ないですが、並びは意識的に配置しなければなりません.
例えば、以下の５つの変数の定義がランダムに以下の順番で書かれていたとします.

```java
details     = request.Post.get('details')
locations   = request.Post.get('locations')
phone       = request.Post.get('phone')
email       = request.Post.get('email')
url         = request.Post.get('url')
```

ランダムに並べるのではなく、意味のある順番にならべることが推奨されます. 例として、

- 対応するHTMLフォームの`<input>`フィールドと同じ並び順にする
- 「重要度」に応じて降順に並べる
-  アルファベット順に並べる

### Rule 3-2: 関連する項目をまとめてグループ化する

「関連する項目をまとめてグループ化する」の基本的な目的は、「組織化」です. 関連する要素を近づけてグループ化するだけで自動的に組織構造が出来上がります. 情報が組織化されていれば、読んでもられる可能性が高くなります. 情報の組織化の副産物として、より組織的な空白も作り出すことができます.

#### Action 3-2-1: 反復処理はメソッドでまとめる

とある人事DBがあり、以下のようなテストを実施したいとします:

```js
// 「Doug Adams」のような partial_name を「Mr. Doughlas Adams」に変える(=名前のexpand)
// 名前のexpandができなければ、errorに説明文を入れる
string ExpandFullName(DatabaseConnection dc, string partial_name, string* error);

// Test
DatabaseConnection database_connection;
string error;
assert(ExpandFullName(database_connection, "Doug Adams", &error)
    == "Mr. Douglas Adams");
asser(error == "");
assert(ExpandFullName(database_connection, "Jacob Brown", &error)
    == "Mr. Jacob Brown III");
asser(error == "");
assert(ExpandFullName(database_connection, "No Such Guy", &error) == "");
asser(error == "no match found");
assert(ExpandFullName(database_connection, "John", &error) == "");
asser(error == "more than one result");
```

引数を変えて同じ処理をしていると読めばわかるが、

- 改行が一貫性ない
- 重複したコードが読みにくさを増している
- なにが重要な部分（`partial_name`）なのか分かりづらい
- テストケースの追加がめんどくさい

という症状がでてしまっている. この症状の改善方法して、重複した処理はメソッドでまとめてしまうことが推奨されます. 具体的には以下、

> BETTER

```js
CheckFUllName("Doug Adams" , "Mr. Douglas Adams"  , "");
CheckFUllName("Jacob Brown", "Mr. Jacob Brown III", "");
CheckFUllName("No Such Guy", ""                   ,  "no match found");
CheckFUllName("John"       , ""                   , "more than one result");

void CheckFUllName(string partial_name,
                   string expected_full_name,
                   string expected_error){
    // database_connectionはクラスのメンバになっている
    string error;
    string full_name = ExpandFullName(database_connection, partial_name, &error);
    assert(error == expected_error);
    assert(full_name == expected_full_name);
}
```

#### Action 3-2-2: 宣言をブロックにまとめる

人間の脳はグループや階層を１つの単位として考えます. コードの概要を素早く把握してもらうには、このような「単位」を作れば良いとなります.
例として、フロントエンドサーバ用のC++のクラスがあるとします. メソッド宣言は以下;

```c++
class FrontEndServer{
    public:
        FrontEndServer();
        void ViewProfile(HttpRequest* request);
        void OpenDatabase(string location, string user);
        void SaveProfile(HttpRequest* request);
        string ExtractQueryParam(HttpRequest* request, string param);
        void ReplyOK(HttpRequest* request, string html);
        void FindFriends(HttpRequest* request);
        void ReplyNotFound(HttpRequest* request, string error);
        void CloaseDatabase(string location);
        ~FrontEndServer();
};
```

メソッドの概要をすぐ把握できるような配置にするための一つのアドバイスとして、「論理的なグループ分け」があります.

> BETTER

```c++
class FrontEndServer{
    public:
        FrontEndServer();
        ~FrontEndServer();

        //ハンドラ
        void ViewProfile(HttpRequest* request);
        void SaveProfile(HttpRequest* request);
        void FindFriends(HttpRequest* request);
        
        //リクエストとリプライのユーティリティ
        string ExtractQueryParam(HttpRequest* request, string param);
        void ReplyOK(HttpRequest* request, string html);
        void ReplyNotFound(HttpRequest* request, string error);

        //データベースのヘルパー
        void OpenDatabase(string location, string user);
        void CloaseDatabase(string location);
};
```

#### Action 3-2-3: コードを段落に分割する

読書で読む文章の多くは段落に分割されています. 段落分割は、似ている考えをグループにまとめて、他の考えと分けるために行われいます.
コーディングも同様に「段落」分割するべきとされています.

例えば、Pythonで書かれた以下のコードを考えます;

> AVOID

```python
# ユーザーのメール帳をインポートしてｍシステムのユーザーと照合する
# まだ友達になっていないユーザーの一覧を表示する

def suggest_new_friends(user, email_password):
    friends = user.friends()
    friend_emails = set(f.email for f in frineds)
    contacts = import_contacts(user.email, email_password)
    contact_emails = set(c.mail for c in contacts)
    non_friend_emails = contact_emails - friend_emails
    suggested_friends = User.objects.select(email_in=non_friend_emails)
    display['user'] = user
    display['friend'] = frineds
    display['suggested_frineds'] = suggested_frineds
    return render("suggested_friends.html", display)
```

> BETTER

```python
def suggest_new_friends(user, email_password):
    # ユーザーの友達のメールアドレスを取得する
    friends = user.friends()
    friend_emails = set(f.email for f in frineds)

    # ユーザーのメールアカウントからすべてのメールアドレスをインポートする
    contacts = import_contacts(user.email, email_password)
    contact_emails = set(c.mail for c in contacts)

    # まだ友達になっていないユーザーを探す
    non_friend_emails = contact_emails - friend_emails
    suggested_friends = User.objects.select(email_in=non_friend_emails)
    
    # まだ友達になっていないユーザーをディスプレイに表示する
    display['user'] = user
    display['friend'] = frineds
    display['suggested_frineds'] = suggested_frineds


    return render("suggested_friends.html", display)
```


## 原則４: 全体の構成をきれいに整形する

「全体の構成をきれいに整形する」にあたって「きれい」とは曖昧な言葉です. ここでいう「きれい」とはプログラムのロジックが読み手にとって読みやすい状態を指すとします. これを実現するためのルールとして、

1. 簡潔な制御フローを用いる
2. 一度につき１つのタスク
3. 短いコードを書く

この3つを抑える必要があります. 

### Rule 4-1: 簡潔な制御フローを用いる

条件やループなどの制御フローはできるだけ読み手が立ち止まったり読み返したりしないように書きます.

#### Action 4-1-1: 条件式の引数の並び順、変化するものは左側へ

`if x > y`という条件式を考えます. これは`if y < x`と書いても同じ挙動をしますが、どちらの書き方のほうが良いのかについての判断軸は以下です:

|条件式の左側|右側|
|---|---|
|オペランドは「調査対象」, 変化するもの|オペランドは「比較対象」, 変化しないもの|

この判断軸に従うと、

> AVOID

```
if (10 < length)
```

> BETTER

```
if (length > 10)
```

#### Action 4-1-2: 条件式は否定形よりも肯定形を使う

> AVOID

```js
if (a != b){
    // not equalのときの処理
} else {
    // equalのときの処理
}
```

> BETTER

```js
if (a == b){
    // equalのときの処理
} else {
    // not equalのときの処理
}
```

なお、状況によってこの判断は変わるときもあります. エラーをログに記録したい時、エラーの場合というものへ読み手の関心を向けるようにコードを記述する必要があります:

```python
if not file:
    # Errorをログに記録する
else:
    # 正常系の処理
```

#### Action 4-1-3: 三項演算子を適切なタイミングで使う

C言語などでは、`<条件> ? a : b`という条件式が書けます. これは `if (条件) {a} else {b}`を一行にまとめた表現です. 
読みやすさの観点から一般的には使用を控えたほうが良いとされます. しかし、この三項演算子を用いることで読みやすさが向上する場合もあります.

```js
time_str += (hour >= 12) ? "pm" : "am";
```

#### Action 4-1-4: ド・モルガンの法則を使う

条件式において`not`を用いなくてならないケースは多々あります. このような場合では、`not`は外でくくって使用するのではなく、要素一個一個に分配して用いたほうが読みやすさが向上します.

```
1) not (a or b or c)     →   (not a) and (not b) and (not c)
2) not (a and b and c)   →   (not a) or (not b) or (not c)
```

一例として以下、

> AVOID

```js
if (!(file_exists && !is_protected)) Error("Sorry, could not read file.");
```

> BETTER


```js
if ((!file_exists || is_protected)) Error("Sorry, could not read file.");
```

#### Action 4-1-5: do-whileループを避ける

条件は前もって書かれている方が、読み手の混乱を招かないですみます.

> AVOID

```js
// 'name' に合致するものを 'node' のリストから探索する
// 'max_length' を超えたノードは考えない

public boolean ListHasNode(Node node, String name, int max_length){
    do {
        if (node.name().equals(name))
            return true;
        node = node.next();
    } while (node != null && --max_length > 0);

    return false
}
```

> BETTER

do/whileループは書き直せるならwhileループに書き直した良いとされます. 多くの場合、書き直すことができます.

```js
// 'name' に合致するものを 'node' のリストから探索する
// 'max_length' を超えたノードは考えない

public boolean ListHasNode(Node node, String name, int max_length){
    while (node != null && max_length-- > 0){
        if (node.name().equals(name))
            return true;
        node = node.next();
    }
    return false
}
```

#### Action 4-1-6: ネストを浅くする

人間の記憶力には限界があるので、ネストが深いと読み手は「いま自分はどの条件ブロックにいるのか？」に関して混乱を生じてしまいます.

> AVOID

```js
if (user_result == SUCCESS){
    if (permission_result != SUCCESS){
        reply.WriteErrors("error reading permission");
        reply.Done();
        return;
    }
    reply.WriteErrors("");
} else {
    reply.WriteErros(user_result);
}
reply.Done();
```

> BETTER

```js
if (user_result == SUCCESS){
        reply.WriteErros(user_result);
        reply.Done();
        return;
    }

if (permission_result != SUCCESS){
    reply.WriteErrors("error reading permission");
    reply.Done();
    return;   
}

reply.WriteErrors("");
reply.Done();
```

##### continueを用いてループ内部のネストを削除する

> AVOID

```js
for (int i = 0; i < result.size(); i++){
    if (results[i] != NULL){
        non_null_count++;

        if (results[i]->name != ""){
            cout << "Considering candidate..." << endl;
            ...
        }
    }
}
```

> BETTER

```js
for (int i = 0; i < result.size(); i++){
    if (results[i] == NULL) continue;
    non_null_count++;

    if (results[i]->name == "") continue;
    cout << "Considering candidate..." << endl;
    ...
}
```

### Rule 4-2: 一度につき１つのタスク

一度に複数のことをするコードは理解しにくい傾向があります. UNIX哲学でも「各プログラムが一つのことをうまくやるようにせよ(Make each program do one thing well)」と謳われています. 「一度につき１つのタスク」というルールを実現する手順は

1. コードが行っている「タスク」をすべて列挙する
2. タスクをできるだけ異なる関数に分割する. 少なくとも異なる領域に分割する.

以下ではこの手順を実行するにあたって役に立つActionを紹介します.

#### Action 4-2-1: タスクは小さくする

エンジニアリングとは、大きな問題を小さな問題に分解して、それぞれの解決策を組み立てることと言われます. 

例として、ブログに設置する投票用のウィジェットがあるとします. ユーザーは`Up`と`Down`または`''`のいずれかを投票できるとします. `score`は、すべての投票を合計したものです. `Up`は+1点、`Down`は-1点、`''`は0点です.

ユーザーが投票ボタンをクリックしたら`vote_change`という関数が呼ばれ、`score`が計算されるとします.

> AVOID

```js
var vote_changed = function(old_vote, new_vote){
    var score = get_score();

    if (new_vote != old_vote){
        if (new_vote === 'Up'){
            score += (old_vote === 'Down' ? 2 : 1);
        } else if (new_vote === 'Donw'){
            score -= (old_vote === 'Up' ? 2 : 1);
        } else if (new_vote === ''){
            score += (old_vote === 'Up' ? -1 : 1);
        }
    }

    set_score(score);
}
```

> BETTER

```js
/*
(1) old_voteとnew_voteを数値にパースする
(2) scoreを更新する
*/

var vote_value = function(vote){
    if (vote === 'Up'){
        return +1;
    }
    if (vote === 'Down'){
        return -1;
    }
    return 0;
};

var vote_changed = function(old_vote, new_vote){
    var score = get_score();

    score -= vote_value(old_vote); //古い値を削除
    score += vote_value(new_vote); //新しい値を追加

    set_socre(score);
}

```

##### 例：オブジェクトから値を抽出する

ユーザーの所在地が以下のデータ構造(`location_info`)で管理されているとします:

---|---
LocalityName|"Santa Monica"
SubAdministrativeAreaName|"Los Angels"
AdministrativeAreaName|"California"
CountryName|"USA"

ここから「都市」と「国」をユーザーごとに抽出する関数を作りたいとします. なお、

- 都市：
    - `CountryName != "USA"`: `LocalityName`, `SubAdministrativeAreaName`, `AdministrativeAreaName`の順番で使用可能なものを使う. すべてがNUllの場合が"Middle-of-Nowhere"というデフォルト値を当てる
    - `CountryName == "USA"`: `LocalityName`, `SubAdministrativeAreaName`の順番で使用可能なものを使う. すべてがNUllの場合が"Middle-of-Nowhere"というデフォルト値を当てる
- 国: 
    - `CountryName != "USA"`:`CountryName`が使用可能な場合は、`CountryName`を使用. そうでない場合は、"Planet Earth"をデフォルト値として用いる
    - `CountryName == "USA"`:`AdministrativeAreaName`が使用可能な場合はそれを使用、そうでない場合は"USAをデフォルト値として用いる

> AVOID

```js
var country = location_info["CountryName"];
var place = location)_info["LocalityName"];

if (country === "USA"){
    if (location_info["AdministrativeAreaName"]){
        country = location_info["AdministrativeAreaName"]
    }
    if (!place){
        place = location_info["SubAdministrativeAreaName"]
    }
    if (!place){
        place = "Middle-of-Nowhere"
    }
} else {
    if (!country){
        country = "Planet Earth"
    }
    if (!place){
        place = location_info["SubAdministrativeAreaName"]
    }
    if (!place){
        place = location_info["AdministrativeAreaName"]
    }
    if (!place){
        place = "Middle-of-Nowhere"
    }
}

return place + ", " + country;
```

> BETTER

```js
var town    = location_info["LocalityName"];
var city    = location_info["SubAdministrativeAreaName"];
var state   = location_info["AdministrativeAreaName"];
var country = location_info["CountryName"];

var first_half, second_half;

if (country === "USA"){
    first_half = town || city || "Middle-of-Nowhere";
    first_second = state || "USA";
} else {
    first_half = town || city || state ||"Middle-of-Nowhere";
    first_second = country || "Planet Earth";
}

return first_half + ", " + second_half;
```

#### Action 4-2-2: ゴールからBackwardにタスクを追加していく

とあるウェブクローリングシステムが与えられたとします. そこでは`UpdateCounts()`という関数が対象となるウェブページの統計量を計算しています. 今回この関数を新たに作成するという仕事が与えられたとします.

まず、ゴールイメージから作成します. 

```js
void UpdateCounts(HttpDownload hd){
    ...
    counts["Exit State"     ][hd.exit_state()]++;    //例: SUCCESS or FAILURE
    counts["Http Reponse"   ][hd.http_reponse()]++;    //例: 404 NOT FOUND
    counts["Content-Type"   ][hd.content_type()]++;    //例: 404 NOT FOUND
}
```

実施スべきタスクを次に整理します.

1. キーのデフォルト値に `unknown` を使う
2. `HttpDownload`のメンバがあるかどうか確認する
3. 値を抽出して文字列に変換する
4. `counts[]`を更新する

```js
void UpdateCounts(HttpDownload hd){
    // タスク: 抽出したい値にデフォルト値を設定する
    sting exit_state = "unknown";
    sting http_response = "unknown";
    sting content_type = "unknown";

    //タスク： `HttpDownload`のメンバがあるかどうか確認し、値を抽出する
    if (hd.has_event_log() && hd.event_log().has_exit_status()){
        exit_status = ExitStateTypeName(hd.event_log().exit_status());
    }
    if (hd.has_http_headers() && hd.http_headers().has_response_code()){
        http_response = StringPrintf("%d", hd.http_headers().response_code());
    }
    if (hd.has_http_headers() && hd.http_headers().has_content_type()){
        content_type = ContentTypeMime(hd.http_headers().content_type());
    }

    //タスク：`counts[]`を更新する
    counts["Exit State"     ][exit_state()]++;    //例: SUCCESS or FAILURE
    counts["Http Reponse"   ][http_reponse()]++;    //例: 404 NOT FOUND
    counts["Content-Type"   ][content_type()]++;    //例: 404 NOT FOUND
}
```

### Rule 4-3: 短いコードを書く

プログラマというのは、実装にかかる労力を過小評価するものです. プロトタイプの実装にかかる時間を楽観的に見積もったり、将来的に必要となる保守や文書化などの「負担」時間を忘れたりします. なので、成果物を期日内に納品することや、保守の時間を短縮、またReadabilityの観点から短いコードを書くことができるならそれに越したことはありません.

#### Action 4-3-1: 再利用できるものは再利用する

平均的なソフトウェアエンジニアが１日に書くことができる出荷用のコードは10行といわれてます. ここでの「出荷用」の意味は、設計・デバッグ・修正・文書化・最適化・テストが完了したという意味です. 成熟したライブラリの裏側にはこのようなプロセスを経て「出荷用」となって公開されているものが大半です. なので、フロムスクラッチから時間を掛けてエンジニアが個人で実装するよりは、ライブラリを使ったほうが、時間の節約・製品の質の観点から望ましいです.

もちろん成熟したライブラリの知識を持っていないと活用できないので、１週間に１回は「標準ライブラリのすべての関数・モジュール型の名前を確認する」という習慣を身につけることをおすすめします.

#### Action 4-3-2: 不必要な開発は実施しない

プロジェクトに「欠かせない機能」を見定めて開発を実施すべき、という観点を持つことで短いコードを実現できるケースは多いです.

ディスクからオブジェクトを読み取るJavaアプリケーションにキャッシュ機能を追加したいとします. まず、読み取りの様子は以下のようなものでした:

```
read Object A
read Object A
read Object A
read Object A
read Object B
read Object B
read Object C
read Object D
read Object D
```

同じオブジェクトに何度もアクセスしているのでキャッシュは有効です. 次に、どのような方式でキャッシュを実装するか考えます. 一般的な方式はLRUです. じゃあ、LRUを実装すればいいとなりそうですが、よくよく読み取り例を見ると、オブジェクトはアルファベット順番に従って読み込まれているという仮説がでてきます. 

再度よくよく調べてみると、この仮説通りオブジェクトはアルファベット順番に従って読み込まれている事がわかりました. となると実装すべきはLRUではなく、one-item cacheとなります.

```java
DiskObject lastUsed; //クラスのメンバ

DisObject lookup(String key){
    if (lastUsed == null || !lastUsed.key().equals(key)){
        lastUsed = loadDiskObject(key);
    }

    return lastUsed;
}
```

この実装の結果、LRU方式を用いたときと同じ読み取り時間の削減、メモリ使用量の低減、コーディング量の低減が実現できました.

#### Action 4-3-3: 複雑なロジックを簡潔にする

当初考えた手法よりもより優雅な方法がないか考えることは重要です. 論理式における対偶を用いるとより優雅な方法が見つかるケースが多いです.
例として、以下のRangeクラスを実装しているとします.

```java
struct Range{
    int begin;
    int end;

    // [0, 5), [3, 8)はレンジが一部重なっているのでTrue
    bool OverlapsWith(Range other)
};

bool Range::OverlapsWith(Range other){
    // begin, endのいずれかがotherの中にあるか判定する
    return (begin >= other.begin && begin < other.end) || 
           (end > other.begin && end <= other.end) ||
           (begin <= other.begin && end >= other.end)
}
```

２つの`Range`クラスが重なり合っているかどうかを愚直に`OverlapsWith(Range other)`で判定しています. 重なり合っているの反対は、重ならないことに注目するとここをより優雅に書き換えることができます. 重なり合っていないとは

1. beginが他方のendよりも大きい場合, or
2. endが他方のbeginよりも小さい場合

この２つに集約されます.

```java
bool Range::OverlapsWith(Range other){
    if (begin >= other.end) return false; // beginが他方のendよりも大きい場合
    if (end   <= other.begin) return false; // endが他方のbeginよりも小さい場合
    
    return true;
}
```

#### Action 4-3-4: プログラムの主目的と関係ない下位問題を抽出する

短いコードを実現するために、コードを抽出して関数に置き換えるというActionはいままで紹介してきたことです. ここでの「主目的と無関係の下位問題」を抽出するというルールも基本的には同じ作業を実施することを要求しますが、あくまで、コードブロックの目標とその目標を達成するために必要なタスク（主目的と無関係の下位問題）を関数化する場合に限定しています. このルールを実現するための、基本姿勢として以下の自問が推奨されます:

1. 関数やコードブロックを見て「このコードの高レベルの目標はなにか？」と自問する
2. コードの各行に対して「高レベルの目標に直接的に効果があるのか？あるいは、無関係の下位問題を解決しているのか？」を自問する

##### 例：与えられた座標から最も近い場所を見つける

「与えられた座標から最も近い場所を見つける」ことを主目的としたjavaScriptコードが以下与えられたとします.

```js
// 与えられた緯度経度に最も近い 'array' の要素を返す
// 地球が完全な球体であることを前提としている
var findClosestLocation = function(lat, lng, array){
    var closest;
    var closest_dist = Number.MAX_VALUE;
    for (var i = 0; i < array.length; i += 1){
        // 2つの地点をラジアンに変換する
        var lat_rad = radians(lat);
        var lng_rad = radians(lng);
        var lat2_rad = radians(array[i].latitude);
        var lng2_rad = radians(array[i].longitude);

        //「球面三角法の第二余弦定理」の公式を使う
        var dist = Math.acos(Math.sin(lat_rad) * Math.sin(lat2_rad) +
                             Math.cos(lat_rad) * Math.cos(lat2_rad) *
                             Math.cos(lng2_rad - lng_rad));
        if (dist < closest_dict){
            closest = array[i];
            closest_dist = dist;
        }
    }
    return closest;
};
```

ループ内のコードは、「２つの地点の球面距離を算出する」という主目的とは無関係の下位問題を扱っている.
この下位問題を関数に置き換えます.

```js
var spherical_distance = function(lat1, lng1, lat2, lng2){
    var lat1_rad = radians(lat1);
    var lng1_rad = radians(lng1);
    var lat2_rad = radians(lat2);
    var lng2_rad = radians(lng2);

    //「球面三角法の第二余弦定理」の公式を使う
    return Math.acos(Math.sin(lat_rad) * Math.sin(lat2_rad) +
                     Math.cos(lat_rad) * Math.cos(lat2_rad) *
                     Math.cos(lng2_rad - lng_rad));
};
```

これを踏まえるとコードを修正すると以下:

```js
// 与えられた緯度経度に最も近い 'array' の要素を返す
// 地球が完全な球体であることを前提としている
var findClosestLocation = function(lat, lng, array){
    var closest;
    var closest_dist = Number.MAX_VALUE;
    for (var i = 0; i < array.length; i += 1){
        var dist = spherical_distance(lat, lng, array[i].latitude, array[i].longitude)

        if (dist < closest_dict){
            closest = array[i];
            closest_dist = dist;
        }
    }
    return closest;
};


var spherical_distance = function(lat1, lng1, lat2, lng2){
    var lat1_rad = radians(lat1);
    var lng1_rad = radians(lng1);
    var lat2_rad = radians(lat2);
    var lng2_rad = radians(lng2);

    //「球面三角法の第二余弦定理」の公式を使う
    return Math.acos(Math.sin(lat_rad) * Math.sin(lat2_rad) +
                     Math.cos(lat_rad) * Math.cos(lat2_rad) *
                     Math.cos(lng2_rad - lng_rad));
};
```

`spherical_distance`は下位問題のコードとして、メインコードブロックから切り離して管理(テスト・開発)できるようになっています. このようなコードは複数のプロジェクトで再利用できます. 簡単に共有できるように特別なディレクトリ(例:`util/`)で管理するのも一つの手です.


## Appendix
### 火星探査機の失敗事故（1999年）

1999年9月23日、約135億円の予算がかけられた火星探査機｢マーズ・クライメート・オービター｣が火星に墜落するという事故が起きました. 自然に起きる事故とは考えられず、調査が行われた結果、NASAは｢ソフトウェアがメートルとヤードを間違えた｣というお粗末な理由を公表しました. 米航空宇宙局(NASA)の宇宙科学部門の管理者の1人、エドワード・ワイラー博士「これは人間の間違いの問題ではなく、NASAのシステム・エンジニアリングの欠陥であり、ミスを探知する過程におけるチェック・アンド・バランスの問題だ。こうしたことが原因でわれわれはこの宇宙船を失ったのだ」と述べてます. NASAによれば、探査機は火星の表面から150キロのところまで近づく予定だったが、測定法単位の混乱のため60キロ以内にまで接近し、ミッションが灰燼に帰してしまったとのこと. 

### Coding Conventionの構成要素

Coding Conventionは基本的には以下の項目を定めるものです:

- ポリシーおよび規約運用方法
- 命名規則
- モジュール構成
- コーディングスタイル
- 禁止事項

### 命名表

> Getの置き換え

|単語|意味|
|---|---|
|`load`|ファイルなどを読込する|
|`fetch`|外部APIからデータを取得する|
|`search`|条件を用いた検索処理|
|`get`|副作用（外部へのアクセスや読み込み, IO）なしに計算する、挙動が軽い|
|`increase`/`decrease`|加算/減産処理|
|`merge`|2つのデータを合わせて1つにする|
|`select`|複数のデータから要素を絞り込む|
|`build`|なんらかの情報に従ってオブジェクトを作成する|

> Saveの置き換え

|単語|意味|
|---|---|
|`dump`|あるデータソースから別のファイルなどにデータをまとめて保存する|
|`create`|更新でなく新規作成する|
|`update`|更新保存する|
|`memoize`|メモリ上に一時的に記録する|
|`publish`|情報を外部に公開する形で保存する|


References
----------
- [The Art of Readable Code by Dustin Boswell and Trevor Foucher. Copyright 2012 Dustin Boswell and Trevor Foucher, 978-0-596-80229-5](https://www.oreilly.co.jp/books/9784873115658/)
