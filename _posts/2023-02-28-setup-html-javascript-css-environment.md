---
layout: post
title: "VS CodeでHTML + JavaScript + CSS開発環境構築"
subtitle: "VSCode Live Previewの紹介"
author: "Ryo"
header-img: "img/cpu.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-03-05
purpose: 
tags:

- 環境構築
- VS Code
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Live Previewの設定](#live-preview%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [インストール方法](#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95)
  - [ショートカット設定](#%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E3%82%AB%E3%83%83%E3%83%88%E8%A8%AD%E5%AE%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>


## Live Previewの設定

[Live Preview, Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server)は, 
VS Code内でローカルサーバーを立ち上げ, HTMLファイルのPreviewをVS Code内部で可能にするExtensionです.

### インストール方法

1. `Ctrl + P`でVS COde Quick Openを開く
2. `ext install ms-vscode.live-server`を入力

### ショートカット設定

デフォルトではPreviewに対して, ショートカットキーがアサインされていません.
また, 一度Previewを開いたあとに確認後Previewを閉じたとしてもローカル Live Serverは動き続けているので, 
Live ServerをStopするショートカットキーもアサインしたいところです.

そこで, `markdown`環境との親和性を考えて以下のようなキーを割り当てます:

---|---
`Ctrl + Shift + v`|HTMLファイルPreview
`Ctrl + Shift + alt +v`|ローカル Live ServerをStop

> ショートカット設定

`keybindings.json`を開いたあとに下の設定を貼り付け保存する

```json
    //-----------------------------------------------------------
    //  HTML Settings
    //-----------------------------------------------------------
    {
        "key": "ctrl+shift+v",
        "command": "livePreview.start",
        "when": "editorTextFocus && editorLangId == 'html'"
    },
    {
        "key": "ctrl+shift+alt+v",
        "command": "livePreview.end",
        "when": "editorTextFocus && editorLangId == 'html'"
    },
```



## References

> VS Code Extension

- [Live Preview, Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server)