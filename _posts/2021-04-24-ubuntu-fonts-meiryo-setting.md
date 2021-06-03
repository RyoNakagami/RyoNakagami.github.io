---
layout: post
title: "Ubuntu Desktop環境構築 Part 19"
subtitle: "メイリオフォントをUbuntuにインストール"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

||概要|
|---|---|
|目的|メイリオフォントをUbuntuにインストール|
|解決したい課題|Google Docsでメイリオフォントを選択できるようにしたい|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [実行環境](#%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
- [解決したい問題](#%E8%A7%A3%E6%B1%BA%E3%81%97%E3%81%9F%E3%81%84%E5%95%8F%E9%A1%8C)
- [Googleフォントのソース](#google%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E3%82%BD%E3%83%BC%E3%82%B9)
- [メイリオフォントインストール手順](#%E3%83%A1%E3%82%A4%E3%83%AA%E3%82%AA%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%89%8B%E9%A0%86)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 実行環境

|項目||
|---|---| 	 
|マシン| 	HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| 	Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 	32.0 GB|
|GPU| 	NVIDIA GeForce RTX 2060 SUPER|

## 解決したい問題

Ubuntu 20.04上からGoogle Docsへアクセスする時、選択できるフォントに「メイリオ」が表示されない.

## Googleフォントのソース

Google Docsで利用できるフォントのソースは2パターンあります

- Googleのサーバーからフォントを提供
- フォントをローカルでホスト

メイリオフォントについて、上記いずれかの条件を満たせば、`File > Language`で「日本語」を選択するとメイリオフォントが使用可能フォントとして表示されるようになります.

## メイリオフォントインストール手順

メイリオフォントをapt経由でインストールしてもいいですが、Windows 10が手元にある & Windows 10のフォントになれている, のでWindowsのメイリオフォントをUbuntu側に移植する方針です.

> Windows側

------|------
Action|Windowsのフォントは`c:\Windows\Fonts`に存在するので、そのフォルダにある`Meiryo UI`を適当なフォルダにコピーします. 
期待する結果|`meiryo.ttc`、`meiryob.ttc`が移行先フォルダで確認される

拡張子 `*.ttc` は TrueType コレクションというデジタルフォントの規格です. Windows や macOS、Linux で標準的に利用されているため、Windows10のフォントファイルをそのままUbuntuに持ってきても動作します. 

> Ubuntu側

`meiryo.ttc`、`meiryob.ttc`をUbuntu側からアクセスできるフォルダ（今回は`~/Downloads`）に移動した後、フォント設定します

```zsh
sudo mkdir /usr/share/fonts/meiryo
sudo mv ~/Downloads/meiryo.ttc ~/Downloads/meiryob.ttc /usr/share/fonts/meiryo
sudo chmod 755 /usr/share/fonts/meiryo -R
```

fontチャッシュを更新

```
sudo fc-cache -fv
```

最後に、Google Docsでメイリオフォントが表示されることを確認したら終了です.


