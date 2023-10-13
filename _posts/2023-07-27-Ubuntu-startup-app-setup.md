---
layout: post
title: "Ubuntu Startup Application Settings"
subtitle: "Login時に自動的に実行されるスクリプトの設定"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-07-28
tags:

- Ubuntu 22.04 LTS
- Shell

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Overview](#overview)
- [How to set-up start-up apps in Ubuntu?](#how-to-set-up-start-up-apps-in-ubuntu)
  - [(1) Set-up via Startup Applications](#1-set-up-via-startup-applications)
  - [(2) Make `.desktop` file in `~/.config/autostart`](#2-make-desktop-file-in-configautostart)
    - [`.desktop` ファイルの作成](#desktop-%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90)
    - [`~/.config/autostart`配下の`.desktop` ファイル](#configautostart%E9%85%8D%E4%B8%8B%E3%81%AEdesktop-%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)
- [今回の設定](#%E4%BB%8A%E5%9B%9E%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [Set up default audio device](#set-up-default-audio-device)
    - [Solution](#solution)
  - [Set up System Monitor](#set-up-system-monitor)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Overview
**想定環境**

|OS|	CPU|
|---|---|
|Ubuntu 20.04 LTS| 	Intel Core i7-9700 CPU 3.00 GHz|
|Ubuntu 22.04.2 LTS| 	AMD Ryzen 9 7950X 16-Core Processor|


**実行内容**

Ubuntu Desktop login時に以下の処理が自動的に走る設定

- Gnome-system-monitorがRight topに表示
- Sound Ouput/Input Deviceを自分が指定したDeviceを選択

## How to set-up start-up apps in Ubuntu?

- Startup Applicationsソフトを用いてGUI経由で設定
- `~/.config/autostart`以下に`.desktop`ファイルを設定

の２つの方法があります. 個人的には管理しやすさの観点から後者を採用していますが大差ありません.

### (1) Set-up via Startup Applications

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>公式ドキュメントの説明</ins></p>

- You can configure what applications should be started at login, in addition to the default startup applications configured on the system.
- デフォルトでシステムに設定されているスタートアップアプリケーションに加えて, ログイン時に起動するアプリケーションを設定することができます

</div>

Activitiesから`Startup Applications`を選択すると下記のようなウィンドウが立ち上がります.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/blog/Ubuntu/2023-07-28_startup_applications.png?raw=true">

起動時のアプリケーションを追加したい場合は, 上記画面の`Add`ボタンをクリックし, **non-login & non-interactive shell** で実行可能な `command` を入力するだけで完了です. 


### (2) Make `.desktop` file in `~/.config/autostart`
#### `.desktop` ファイルの作成

`.desktop`ファイル(デスクトップエントリ)はapplication launcherやアプリのmeta dataを定義したtext fileのことです. 

`.desktop`ファイルは(Key, Value)の組を記述します. 形式例としては以下です:

```desktop
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/home/user/run.sh
Name=Application Name
Comment=Test Application
Icon=/home/user/Pictures/icon.png
```

`.desktop`ファイルは, Chrome経由でショートカットを作る際にも生成されるファイルで, `~/.local/share/applications` を見てみるとChromeショートカットファイルを確認することができます. また, `/usr/share/applications/`を確認するとすべてのユーザーがアクセスできるDesktop Appsの一覧を見ることができます.

|PATH|説明|
|---|---|
|`/usr/share/applications`|システム全体でインストールしたアプリケーション|
|`~/.local/share/applications`|ユーザ固有のアプリケーション|

なおユーザーのエントリはシステムのエントリよりも優先されるという特徴があります.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: Desktop entry keys</ins></p>

Dektop entry keysの代表的なものを紹介します. 詳細は[Recognized desktop entry keys](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys)を参考にしてください:

|Key|Description|
|---|---|
|Type|Application, Link, Directoryのどれか|
|Version|version|
|Name|アプリケーション名|
|Icon|Icon画像をfull pathで指定|
|Exec|実行コマンド|
|Terminal|実行時にTerminalを表示するか否か|
|X-GNOME-AUtostart-enable|自動起動するか否かが設定|

</div>

#### `~/.config/autostart`配下の`.desktop` ファイル

`~/.config/autostart`配下にアプリケーションを記載した`.desktop` ファイルを設置すると, login時に自動的にそのアプリケーションが立ち上がってくれます.

```zsh
username@host ~/.config/autostart % ls -l
total 12
drwxrwxr-x 2 username username 4096 Jul 28 19:42 script/
-rw-rw-r-- 1 username username  162 Jul 28 19:29 hoo-app.desktop
-rw-rw-r-- 1 username username  171 Jul 28 19:42 hoge-app.desktop
```

`.dektop` file自体には実行権限を付与することなくても自分の場合は自動起動が確認できました.

## 今回の設定

Desktop Entryの作成にあたり, 今回の構成は以下のようにしました:

```zsh
username@host ~/.config/autostart % tree
.
├── script                          # startup appのシェルスクリプト格納directory
│   ├── install-sound.sh            # 音声セットアップシェルスクリプト
│   └── start-system-monitor.sh     # System Monitorセットアップシェルスクリプト
├── sound-install.desktop
└── monistor-install.desktop
```

`install-sound.sh`は普段の作業の中で利用したいスクリプトでもあるので, 
PATHが通った自作シェルスクリプトディレクトリへsymblic link fileを`ln -s`で作成しています.

### Set up default audio device

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: </ins></p>

- login時に自動的に認識される音声deviceが自分の意図するDeviceではない(会議用の音声スピーカーになってしまう)

</div>


自分の環境はMonitorのスピーカーに加えて, CreativeのスピーカーとJabraヘッドホンを起動時に接続います. 仕事の会議のときはJabraヘッドホンを使いたい一方, YouTubeやSportifyはCreativeのスピーカーのスピーカーを使いたいので, 後者をデフォルトのOutputとして認識させたいのが今回の目的です.


#### Solution

> Requirements

- `pactl`: PulseAudioを操作するコマンド
- `pulseaudio`: POSIX用のsound server（音声デバイス管理用ソフト）

> 接続Deviceの確認

`pactl`では`sink`と`source`に関する設定することができます. 

---|---
`sink`|Input device
`source`|Output device

Input/Output Deviceを簡易的に検索したい場合はそれぞれ以下のコマンドを入力します:

```zsh
% pactl list short sinks     # list-up output devices
% pactl list short sources   # list-up input devices
```

`pactl list short sinks/sources`を実行すると各デバイスについて以下の情報を得ることができます:

---|---
sink_name, source_name|デバイス名(これが後に必要)
sound cards kernel module|audio処理を担当するkernel module
format|audio sample format(defaultは`s16`)
channels| audio channels
rate|sample rate
status|RUNNING, SUSPENDED, IDLE


> Shell Scriptの定義

`output-device-name`, `input-device-name`を自分好みのデバイスに設定します

```bash
#!/bin/bash
# ---------------------------------------------------------------------------
# OUTPUT DEVICE
# ---------------------------------------------------------------------------
# get list of available available audio output devices (sinks)
# pactl list short sinks
# set default output device to Creative_Technology_Ltd_Sound_BlasterX_Katana
pactl set-default-sink 'output-device-name'


# ---------------------------------------------------------------------------
# INPUT DEVICE
# ---------------------------------------------------------------------------
# get list of available available audio input devices (sources):
# pactl list short sources
pactl set-default-source 'input-device-name'
```


> Desktop Entryの設定

```desktop
[Desktop Entry]
Type=Application
Name=Sound setup
Exec=<上記で作成したshell-scriptのfull path>
Icon=system-run
X-GNOME-Autostart-enabled=true
```

### Set up System Monitor

> Requirements

- `wmctrl`: ウィンドウの位置を操作するコマンド
- `gnome-system-monitor`: system-monitor(defaultでinstallされている)

> Shell Scriptの定義

```bash
#!/bin/bash
#-----------------------------------------
# General
#-----------------------------------------
# error handling
set -e

# variables
window_x_axis=7000
window_y_axis=-30
window_width=1130
window_height=670


#-----------------------------------------
# Main
#-----------------------------------------

sh -c '/usr/bin/gnome-system-monitor' \
    &
sleep 1 &&
    wmctrl -r "System Monitor" -e 0,$window_x_axis,$window_y_axis,$window_width,$window_height
```

`sleep 1`を加えているのは`gnome-system-monitor`が立ち上がる時間を待つためです. 

> Desktop Entryの設定

```desktop
[Desktop Entry]
Type=Application
Name=Monitor setup
Exec=<上記で作成したshell-scriptのfull path>
Icon=system-run
X-GNOME-Autostart-enabled=true
```



References
------------

- [Ubuntu documentation > Startup Applications](https://help.ubuntu.com/stable/ubuntu-help/startup-applications.html.en)
- [Recognized desktop entry keys](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys)