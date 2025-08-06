---
layout: post
title: "VSCodeのインストールと初期設定"
subtitle: "VSCode setup 1/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-03-21
header-style: text
header-mask: 0.0
tags:

- Ubuntu 20.04 LTS
- VSCode
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [VSCodeのインストール方法](#vscode%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95)
- [MicrosoftのVSCodeレポジトリを登録 & インストール](#microsoft%E3%81%AEvscode%E3%83%AC%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%82%92%E7%99%BB%E9%8C%B2--%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [初期設定](#%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
  - [Telemetry 無効化](#telemetry-%E7%84%A1%E5%8A%B9%E5%8C%96)
  - [Font family設定](#font-family%E8%A8%AD%E5%AE%9A)
  - [行番号表示設定](#%E8%A1%8C%E7%95%AA%E5%8F%B7%E8%A1%A8%E7%A4%BA%E8%A8%AD%E5%AE%9A)
  - [Window Reload設定](#window-reload%E8%A8%AD%E5%AE%9A)
- [拡張機能設定](#%E6%8B%A1%E5%BC%B5%E6%A9%9F%E8%83%BD%E8%A8%AD%E5%AE%9A)
- [Appendix: Snapパッケージとは？](#appendix-snap%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%A8%E3%81%AF)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## VSCodeのインストール方法

VSCodeをLinux環境にインストールする方法は大きく３つあります:

1. MicrosoftのVSCodeレポジトリを登録し, `apt`経由でインストール
2. Snapパッケージ経由インストール
3. 公式ページからdebパッケージをダウンロード & install

今回は公式サイトも推奨している(1)「MicrosoftのVSCodeレポジトリを登録し, `apt`経由でインストール」を採用します.

なお, 上記の3番目の手法については, `.deb`パッケージをインストールすると, 
aptリポジトリと署名キーが自動的にインストールされ, システムのパッケージマネージャを使った
自動更新が可能となります. ですのでこちらの方法でもOKです.

```zsh
# 公式debパッケージからのインストール
% sudo apt install -y curl
% curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o vscode.deb
% sudo apt install ./vscode.deb
```

<strong > &#9654;&nbsp; なぜSnap経由インストールをしないのか？</strong>

Snap経由でインストールすると, SnapデーモンがバックグラウンドでVS Codeの自動アップデートを担当してくれるので
自動的に最新のVSCodeが使えるというメリットがあります．ただし，日本語入力ができない，漢字が入力できないというバグが
見受けられ，Native Japanese Speakerとして看過できないバグなので今回はお見送りしました.


### MicrosoftのVSCodeレポジトリを登録 & インストール

```zsh
% sudo apt-get install wget gpg
## 必要パッケージのインストール
% wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
## ASCII Armor 形式ファイルをバイナリファイルへ変換
% sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
## /etc/apt/keyrings ディレクトリにgpg keyを登録
% sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
## レポジトリの検証と登録, これでapt install codeが実行可能になる
% rm -f packages.microsoft.gpg
## gpg keyは登録したのでもう不要
% sudo apt install apt-transport-https
% sudo apt update
% sudo apt install code
```

## VSCode初期設定
### Telemetry 無効化

VSCodeはデフォルトで, クラッシュ時の情報や使用状況/ErrorのデータをMicrosoftに送信する
「Telemetry」機能がOnになっています. 煩わしいので, これを無効にします.

1. Preference: Open User Settings JSONをコマンドパレットから選択
2. `settings.json`に以下のラインを追加します:

```json
{   
    // Telemetry Report: turn off Crash, Error, Usage Report
    "telemetry.telemetryLevel": "off",
}
```

### Font family設定

[Ryo's Tech Blog > Ubuntu 22.04 LTSに Meslo LGSとUDEV Gothicをインストールする](https://ryonakagami.github.io/2024/03/11/install-menlo-into-ubuntu/#vscode%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)を参照してください

### 行番号表示設定

VSCodeでは `Ctrl+G` で Vimのように指定した行番号までジャンプすることができます. 
この機能を念頭に, Editorエリアで行番号を表示させます. 設定は同じく, `settings.json` にて

```json
  "editor.lineNumbers": "on", // 行番号の表示
```

### Window Reload設定

VSCodeを使用しているとき, パッケージインストール直後にMissingImportErrorが発生するときがあります.
この場合, VSCodeを閉じて開き直すという動作をすると解決したりします.

ただ, 毎回閉じる & 開き直すのはめんどくさいので, Reload Windowをショートカットで設定します

```json
    // Reload Windows
    {
        "key": "ctrl+r",
        "command": "-workbench.action.reloadWindow",
        "when": "isDevelopment"
    },
    {
        "key": "shift+meta+r",
        "command": "workbench.action.reloadWindow",
    },
```

### Toggle Tab Key Moves Focusの削除

<strong > &#9654;&nbsp; Pain</strong>

- VSCodeではデフォルトで`ctrl + m`ショートカットにToggle Tab Key Moves Focusがアサインされている
- 誤って`ctrl + m`を押すと，`tab`がインデント挿入として機能せず，focusの移動モードになってしまう(これをTab trappingと呼ぶ)

<strong > &#9654;&nbsp; Solution</strong>

`keybindings.json`にて以下の設定をすることで，Tab trapping ショートカットを無効化する

```json
  {
    "key": "ctrl+m",
    "command": "-editor.action.toggleTabFocusMode"
  }
```

参考情報としてこちらの[Issue](https://github.com/microsoft/vscode/issues/128858)は一読の価値あり



## 拡張機能設定

TBA


## Appendix: Snapパッケージとは？

snapパッケージとは, ディストリビューションを問わず利用できる「ユニバーサルパッケージ」のことです.
パッケージ管理システムとしての名称は「Snappy」です. Ubuntuにおけるパッケージ管理コマンド `apt`と対応するコマンドは
`snap` で, 例としては以下

|Snap|Ubuntu|
|---|---|
|`snap install`|`apt install`|
|`snap remove`|`apt remove`|
|`snap find`|`apt search`|
|(自動)|`apt update`|
|(自動)|`apt upgrade`|


ただし, `snap`コマンドを使うためには `snapd`パッケージが必要でそのインストール方法は結局 `apt`を使います.

```zsh
% sudo apt install snapd
```

**snap経由でのVSCodeのインストール**

```zsh
% sudo snap install --classic code # or code-insiders
```


References
----------
- [Visual Studio Code on Linux](https://code.visualstudio.com/docs/setup/linux)
- [vscode > unable to input chinese character](https://github.com/microsoft/vscode/issues/96041)
