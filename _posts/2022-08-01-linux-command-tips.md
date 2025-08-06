---
layout: post
title: "ちょっとしたLinux便利コマンド集"
subtitle: "Linux command 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-04-18
tags:

- Linux
- Shell
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>

## Terminalから指定したディレクトリをGUIで表示する

Ubuntu, MacOS共通で `open` コマンドを用いることで指定したディレクトリについてFinder(Files)を
開くことができます．

```zsh
# current directoryを開く
% open .

# Document directoryを開く
% open ~/Documents
```

Ubuntuにおける `open` コマンドはディレクトリを対象に実行すると `nautilus -w` と同じ動作をします.
これは `open` コマンドが指定したオブジェクトについて，いわゆるデフォルトでひらくアプリケーションで開くコマンドだからです．

## 表示が長すぎる出力をターミナル上で見る場合

`ps aux`など出力結果が長すぎて１画面に収まらない場合はパイプを用いて以下のコマンドに渡します

- `more`: 末尾まで行くと自動的にプロンプトへ戻る
- `less`: 末尾まで行ってもと自動的にプロンプトへ戻らない
- `view`: vimをreadonly mode (v)で起動

```zsh
% ps aux | view
```
