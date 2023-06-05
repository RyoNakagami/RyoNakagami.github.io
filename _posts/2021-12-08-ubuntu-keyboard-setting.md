---
layout: post
title: "Keychron K6 Wireless Mechanical Keyboardとショートカットの整理"
subtitle: "Ubuntu Desktop環境構築 Part 24"
author: "Ryo"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 
reading_time: 6
tags:

- Ubuntu 20.04 LTS
- VSCode
- Keyboard
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 技術スペック](#1-%E6%8A%80%E8%A1%93%E3%82%B9%E3%83%9A%E3%83%83%E3%82%AF)
  - [実行環境](#%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
  - [Keyboardスペック](#keyboard%E3%82%B9%E3%83%9A%E3%83%83%E3%82%AF)
  - [ソフトウェア](#%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2)
- [2. Keychron K6初期設定](#2-keychron-k6%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A)
  - [Function keyの設定](#function-key%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [Keyboard Backlightの設定](#keyboard-backlight%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [Keyboard 配列の設定](#keyboard-%E9%85%8D%E5%88%97%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [3. Keyboard cheatsheet](#3-keyboard-cheatsheet)
  - [Ubuntu](#ubuntu)
  - [Browser](#browser)
  - [VSCode](#vscode)
- [4. UbuntuKeyboardショートカット変更](#4-ubuntukeyboard%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E3%82%AB%E3%83%83%E3%83%88%E5%A4%89%E6%9B%B4)
  - [Ubuntu Keyboard Shortcutの変更](#ubuntu-keyboard-shortcut%E3%81%AE%E5%A4%89%E6%9B%B4)
    - [`Super` + `P` ショートカットの解除とscreenshotコマンドの設定](#super--p-%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E3%82%AB%E3%83%83%E3%83%88%E3%81%AE%E8%A7%A3%E9%99%A4%E3%81%A8screenshot%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [Caps Lock キーを無効化する](#caps-lock-%E3%82%AD%E3%83%BC%E3%82%92%E7%84%A1%E5%8A%B9%E5%8C%96%E3%81%99%E3%82%8B)
- [5. VSCode Keyboard Shortcutの変更](#5-vscode-keyboard-shortcut%E3%81%AE%E5%A4%89%E6%9B%B4)
  - [分割先へActive Editorを移動するショートカットの設定](#%E5%88%86%E5%89%B2%E5%85%88%E3%81%B8active-editor%E3%82%92%E7%A7%BB%E5%8B%95%E3%81%99%E3%82%8B%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E3%82%AB%E3%83%83%E3%83%88%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [split terminal tab間の移動](#split-terminal-tab%E9%96%93%E3%81%AE%E7%A7%BB%E5%8B%95)
  - [`git`: Active Fileの前回commit時との変更差分確認](#git-active-file%E3%81%AE%E5%89%8D%E5%9B%9Ecommit%E6%99%82%E3%81%A8%E3%81%AE%E5%A4%89%E6%9B%B4%E5%B7%AE%E5%88%86%E7%A2%BA%E8%AA%8D)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## 1. 技術スペック

### 実行環境

|項目||
|---|---| 	 
|マシン| HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 32.0 GB|
|GPU| NVIDIA GeForce RTX 2060 SUPER|

```zsh
% lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.3 LTS
Release:        20.04
Codename:       focal
% uname -srvmpio
Linux 5.13.0-27-generic #29~20.04.1-Ubuntu SMP Fri Jan 14 00:32:30 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```

### Keyboardスペック

---|---
機種|[Keychron K6 Wireless Mechanical Keyboard](https://www.keychron.com/products/keychron-k6-wireless-mechanical-keyboard)
接続方法|有線接続(UBS 3.1 Gen 1)
mode|Windows

### ソフトウェア

> Ubuntu

|ソフトウェア名|説明|インストール|
|---|---|---|
|dcof-editor|Ubuntuの設定管理ツール|`sudo apt install dconf-editor`|
|gnome-tweaks|Gnome設定を調整する<br>Ubuntuアプリケーション|`sudo add-apt-repository universe`<br>`sudo apt update`<br>`sudo apt install gnome-tweak-tool`|
|SimpleScreenRecorder|画面録画アプリ|`sudo apt install simplescreenrecorder`|

> VSCode

|Extension名|説明|
|---|---|
|FontSize Shortcuts|Editor画面のZoom in/outのショートカット|



## 2. Keychron K6初期設定
### Function keyの設定
**問題**

- Defaultでは `f1-f12`ファンクションキー(`fn2` + 数字)が認識されない
- Windows modeで使用していても、function keyはApple keyboardの設定を参照していると思われる
- `/sys/module/hid_apple/parameters/fnmode`のApple keyboardのfuction keyの設定を変更する


**解決方針**

- カーネルモジュールの設定を変更する

> Step 1

```zsh
% sudo nano /etc/systemd/system/keychron.service
```

> Step 2: カーネルモジュールの設定を変更する

keychron.serviceを以下のように設定し、保存する

```zsh
[Unit]
Description=The command to make the Keychron K2 work

[Service]
Type=oneshot
ExecStart=/bin/bash -c "echo 0 > /sys/module/hid_apple/parameters/fnmode"

[Install]
WantedBy=multi-user.target
```

> Step 3: 

```zsh
% systemctl enable keychron
```

> Step 4: reboot

```zsh
% reboot
```

**解説**

Defaultでは`/sys/module/hid_apple/parameters/fnmode`は2と設定されているためspecial key扱いとなってしまっている

- 0 = disabled : Disable the 'fn' key. Pressing 'fn'+'F8' will behave like you only press 'F8'
- 1 = fkeyslast : Function keys are used as last key. Pressing 'F8' key will act as a special key. Pressing 'fn'+'F8' will behave like a F8.
- 2 = fkeysfirst : Function keys are used as first key. Pressing 'F8' key will behave like a F8. Pressing 'fn'+'F8' will act as special key 


### Keyboard Backlightの設定

|動作|コマンド|
|---|---|
|backlightのOn/Offの設定|`fn1` + `電球ボタン`|
|backlight設定の固定|`fn1` + `L` + `電球ボタン`(４秒以上長押し, キーボードが点滅したら設定完了)|

### Keyboard 配列の設定

> 右Controlと右Altキーを入れ替える

- `fn1` + `K` + `R`を４秒以上長押し, キーボードが点滅したら設定完了


## 3. Keyboard cheatsheet
### Ubuntu 
**General**

|Shortcut|動作|独自設定|
|---|---|---|
|`Ctrl` + `Alt` + `T`|Terminalを立ち上げる|Default|
|`Ctrl` +`Space`|入力言語の切り替え|Default|
|`Super` then `Ctrl` + `L`|任意のアプリケーションの立ち上げ, <br>`Super`はWindowsキーのこと|Default|
|`Super` + `A`|アプリケーション一覧を開く|Default|
|`Ctrl`+`P`|選択したエリアのスクリーンショットを取る & Clipboardへ保存|新規設定|
|`Ctrl`+ `Shift` + `P`|選択したエリアのスクリーンショットを取る & Picturesへ保存|新規設定|
|`alt` + `F4`|ウィンドウを閉じる|Default|
|`Super` + `F`|Launch the Firefox(the deflaut web browser)|新規設定|
|`Super` + `S`|Search|Default|
|`alt` + `F10`|Windowの最大化|Default|
|`Super` + `Shift` + `←/→`|現在のウィンドウを一つ左/右のモニターに移動|Default|
|`Super` + `移動キー`|Windowの最大化(↑/↓)、右寄せ左寄せ(←/→)を設定|Default|
|`Super` + `数字キー`|番号が対応しているFavaroite上のアプリを起動する|Default|
|`Ctrl`+ `Shift` + `alt` + `R`|SimpleScreenRecorderを起動した状態で画面録画の開始と停止|新規設定|


**Ubuntu Termianl**

|Shortcut|動作|
|---|---|
|`Ctrl` + `L`|clear console|
| `Ctrl` + `Shift` + `C`| Copy|
| `Ctrl` + `Shift` + `V`| Paste|
|`esc` + `.`|直前の実行引数を出力|
|`Alt`+`F`|move forward|
|`Alt`+`B`|move backward|
|`home`|行頭へカーソルを移動|
|`end`|文末へカーソルを移動|
|`Shift` + `Ctrl`+`W`|termial tabを閉じる|
|`Ctrl`+`D`|terminalを閉じる|
|`Ctrl`+`U`|terminalの入力行をすべて削除する|
|`Ctrl`+`backspace`|terminalの入力行についてカーソルの左側すべてを削除する|
|`Ctrl`+`del`|terminalの入力行についてカーソルの右側すべてを削除する|

### Browser
**Firefox**

|Shortcut|動作|
|---|---|
|`Super` + `F`|Firefoxの起動|
|`Alt` + `←`/`→`|戻る, 進む|
|`Ctrl` + `tab` ( + `Shift`)|tabを切り替える(逆向き)|
|`Ctrl` + `pageup/pagedown`|tabを切り替える(逆向き)|
|`Ctrl` + `Shift` + `R`|再読み込み (キャッシュ上書き) |
|`Ctrl` + `↑/↓`|ページ先端/終端へ移動|
|`Ctrl` + `F`|ページ検索|
|`Esc`|ページ検索バーを閉じる|
|`Ctrl` + `D`|ブックマークへの追加/解除|
|`Ctrl` + `B`|ブックマークへの一覧の表示|
|`Ctrl` + `I`|ページ情報の表示|
|`Ctrl` + `alt` + `G`|PDF viwer時にページ番号の入力|
|`/`|Youtube/GitHubなどで検索ボックスへ移動|

### VSCode
**General**

|Shortcut|動作|
|---|---|
|`Ctrl` + `Shift` + `P`	|コマンドパレットを表示|
|`Ctrl` + `Shift` + `N`	|新しいウィンドウを開く|
|`Ctrl` + `Shift` + `T`	|直前閉じたtabを再び開く|
|`Super` + `K`	|ショートカット一覧を開く|
|`Ctrl` + `page up/page down`	|tab移動|
|`Ctrl` + `K` `Z`|禅モード|
|`Ctrl` + `\`|Editorを分割する|
|`Ctrl` + `Super` + `[`|Active Editorを左に移動する|
|`Ctrl` + `Super` + `]`|Active Editorを右に移動する|
|`Ctrl` + `O`|Fileを開く|
|`Ctrl` + `+/-`|Editor画面のzoom in/out|

**Terminal**

|Shortcut|動作|
|---|---|
|`Ctrl` + `	|Terminalを開く、Editorから開いてあるTerminalへ移動する|
|`Ctrl` + `Shift` + `5`	|Terminalを分割する|
|`Ctrl` + `D`	|Terminalを閉じる|
|`Ctrl` + `1/2`	|TerminalからEditorへ移動する（1なら左、２なら右）|
|`Ctrl` + `pageup/pagedown`	|Split terminalの間をスイッチする|

**Navigation**

|Shortcut|動作|
|---|---|
|`Ctrl` + `page up/page down`	|tab移動|
|`Ctrl` + `tab`	|tab移動(選択式)|
|`Ctrl` + `G`	|指定した行への移動|
|`page up/page down`	/画面上の先頭/最後の行|
|`Ctrl` + `Shift` + `O`	|指定したindexへ移動|
|`Ctrl` + `U`	|直前にいたカーソルまで移動|
|`home/end`	|行頭/行末まで移動|
|`Ctrl` + `home/end`	|文頭/文末まで移動|

**Basic editing**

|Shortcut|動作|
|---|---|
|`Ctrl` + `Enter`	|下に行追加|
|`Ctrl` + `Shift` + `Enter`	|上に行追加|
|`Ctrl` + `Shift` + `\`	|次の対応する括弧に移動|
|`Ctrl` + `/`	|コメントアウト(Toggle)|
|`Ctrl` + `Shift` + `A`	|ブロックコメントアウト(Toggle)|
|`Ctrl` + `]/[`	|インデントの追加/削除 Toggle|
|`Ctrl` + `Shift` + `]/[`	|ブロック単位の展開/折りたたみ Toggle|
|`Ctrl` + `backspace`	|単語の部分削除（カーソル位置より左側）|
|`Ctrl` + `delete`	|単語の部分削除（カーソル位置より右側）|
|`alt` + `↑/↓`|カーソル行／選択行を移動(複数行対応)|
|`Ctrl` + `I`	|単語補完(前方検索)|
|`Ctrl` + `C`	|行コピー（選択なしの状態）|
|`Ctrl` + `L`	|現在の行を選択|
|`Ctrl` + `Shift` +`alt` + `↑/↓`|行を上方/下方に複製|


**マルチカーソルと検索/置換**

|Shortcut|動作|
|---|---|
|`alt` + `Shift` + `↑/↓`|マルチカーソルを展開|
|`Ctrl` + `Shift` + `L`	|選択箇所にマッチする箇所全てにカーソルを展開|
|`Ctrl` + `H`|置換|
|`alt` + `R`|置換モードで正規表現利用のtoggle|
|`alt` + `l`|置換モードで予め選択した範囲内のみを対象とする|
|`Ctrl` + `alt` + `Enter`|一括置換|


## 4. UbuntuKeyboardショートカット変更
### Ubuntu Keyboard Shortcutの変更

#### `Super` + `P` ショートカットの解除とscreenshotコマンドの設定

Defaultではモニター設定のキーが割り当てられているのでそれを解除する。 


> 方針

1. Defaultで設定されている`Super` + `P` ショートカットを解除する
2. Screenshotへ`Super` + `P` ショートカットを割り当てる

> 実行 1. Defaultで設定されている`Super` + `P` ショートカットを解除する

まずdconf-editorを開く. Terminalで

```zsh
% dconf-editor
```

を実行. 次に、

1. `/org/gnome/mutter/keybindings/switch-monitor`まで移動
2. "Custom value" field に `['<Super>p', 'XF86Display']`と設定してあることを確認する
3. Disable "Use default value"
4. "Custom value" fieldを `[]`と設定する
5. `/org/gnome/settings-daemon/plugins/media-keys/video-out`に移動する
6. 工程(3), (4)を実行する
7. 解除完了

> 2. 実行 2. Screenshotへ`Super` + `P` ショートカットを割り当てる

1. Settingを開く
2. Keyboard shortcutsを開く
3. Screenshotsのグループまで行く
4. ショートカットキーを入力し設定完了

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20211208_keyboardshortcuts_screenshots.png?raw=true">

なお、同じ方法でDefault Web browserのショートカットキーの設定をすることができます.

#### Caps Lock キーを無効化する

> 目的

- 現時点ではCaps Lockの恩恵はゼロ & むしろ押し間違いによる不利益しかない

> 実行

1. GNOME Tweaks を起動する．
2. Keyboard & Mouseをクリック
3. Additional Layout Optionsをクリック
4. Caps Lock behavior > Caps Lock is disabledを選択
5. Reboot


## 5. VSCode Keyboard Shortcutの変更

> 方針

- `keybindings.json`ファイルに新たなキーボートショートカットを追記する


### 分割先へActive Editorを移動するショートカットの設定

> 設定

- `meta`とは`Super`のこと

```json
    {
      "key": "ctrl+meta+[",
      "command": "workbench.action.splitEditorToPreviousGroup",
      "when": "editorTextFocus"
    },
    {
      "key": "ctrl+meta+]",
      "command": "workbench.action.splitEditorToNextGroup",
      "when": "editorTextFocus"
    }
```

### split terminal tab間の移動

> 設定


```json
    {
        "key": "ctrl+pageup",
        "command": "workbench.action.terminal.focusNextPane",
        "when": "terminalFocus"
    },
    {
        "key": "ctrl+pagedown",
        "command": "workbench.action.terminal.focusPreviousPane",
        "when": "terminalFocus"
    }
```

### `git`: Active Fileの前回commit時との変更差分確認

> 機能

- 現在編集中のファイルについて, 前回commit時との変更差分確認(=`Viewing diffs`)する
- `Viewing diffs`を閉じる

> 設定

```json
    //-----------------------------------------------------------
    //  Git Settings
    //-----------------------------------------------------------
    {
        "key": "ctrl+alt+h",
        "command": "git.openChange",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+h",
        "command": "git.openFile",
        "when": "isInDiffEditor",
        "description": "git.OpenChangeを閉じる"
    },
```




## References

- [Archlinux: Function keys do not work](https://wiki.archlinux.org/title/Apple_Keyboard#Function_keys_do_not_work)
- [How to disable global Super-p shortcut?](https://askubuntu.com/questions/68463/how-to-disable-global-super-p-shortcut)

> VSCode関連

- [VSCode > Using Git source control in VS Code > Viewing diffs](https://code.visualstudio.com/docs/sourcecontrol/overview#_viewing-diffs)
- [stackoverflow:How to switch between terminals in Visual Studio Code](https://stackoverflow.com/questions/48440673/how-to-switch-between-terminals-in-visual-studio-code/60224585)
