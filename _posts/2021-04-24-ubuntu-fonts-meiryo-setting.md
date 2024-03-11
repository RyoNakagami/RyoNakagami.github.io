---
layout: post
title: "メイリオフォントをUbuntuにインストール"
subtitle: "フォント設定 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: falase
mermaid: false
tags:

- Ubuntu 20.04 LTS
- Font
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What I Want to Do](#what-i-want-to-do)
- [Googleフォントのソース](#google%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E3%82%BD%E3%83%BC%E3%82%B9)
- [メイリオフォントインストール手順](#%E3%83%A1%E3%82%A4%E3%83%AA%E3%82%AA%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%89%8B%E9%A0%86)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What I Want to Do

- Ubuntu 20.04上からGoogle Docsへアクセスする時、選択できるフォントに「メイリオ」が表示させる

**実行環境**

|項目||
|---|---| 	 
|マシン| 	HP ENVY TE01-0xxx|
|OS |ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 32.0 GB|
|GPU| NVIDIA GeForce RTX 2060 SUPER|


## Googleフォントのソース

Google Docsで利用できるフォントのソースは2パターンあります

- Googleのサーバーからフォントを提供
- フォントをローカルでホスト

メイリオフォントについて、上記いずれかの条件を満たせば、`File > Language`で「日本語」を選択するとメイリオフォントが使用可能フォントとして表示されるようになります. 今回は後者を採用. 

## メイリオフォントインストール手順

メイリオフォントをapt経由でインストールしてもいいですが、Windows 10が手元にある & Windows 10のフォントになれている, のでWindowsのメイリオフォントをUbuntu側に移植する方針です.

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Windows側</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

------|------
Action|Windowsのフォントは`c:\Windows\Fonts`に存在するので、そのフォルダにある`Meiryo UI`を適当なフォルダにコピーします. 
期待する結果|`meiryo.ttc`、`meiryob.ttc`が移行先フォルダで確認される

拡張子 `*.ttc` は TrueType コレクションというデジタルフォントの規格です. Windows や macOS、Linux で標準的に利用されているため、Windows10のフォントファイルをそのままUbuntuに持ってきても動作します. 

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Ubuntu側</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

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

最後に, Google Docsでメイリオフォントが表示されることを確認したら終了です.

</div>
