---
layout: post
title: "apt vs apt-get"
subtitle: "APTによるパッケージ管理 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 
tags:

- Linux
- apt
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is the `apt` command?](#what-is-the-apt-command)
  - [How user-friendly `apt` command is?](#how-user-friendly-apt-command-is)
- [`apt` vs `apt-get`](#apt-vs-apt-get)
  - [Why `apt-get` still in use today?](#why-apt-get-still-in-use-today)
- [Appendix: Relationship between the `apt` command and the `apt-get` command](#appendix-relationship-between-the-apt-command-and-the-apt-get-command)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## What is the `apt` command?

`apt`コマンドは, `apt-get`, `apt-cache`, `apt-config`など複数のpackage management toolの機能をユーザーフレンドリーな形で1つのコマンドにまとめたものです. エンドユーザー観点からインタラクティブで使いやすいものとして作られた, `apt-get` や `apt-cache` 等のコマンドのラッパーという立ち位置になります.


### How user-friendly `apt` command is?

`apt`コマンドがuser-friendlyである例として, `apt-cache`との挙動の違いを見てみます.
古から存在する音声読み上げソフトの`espeak`をそれぞれのコマンドで調べてみると以下のような違いが生まれます:

```zsh
% apt-cache search espeak
espeak-ng-data - Multi-lingual software speech synthesizer: speech data files
libespeak-ng-dev - Multi-lingual software speech synthesizer: development files
libespeak-ng-libespeak-dev - Multi-lingual software speech synthesizer: development files
libespeak-ng1 - Multi-lingual software speech synthesizer: shared library
speech-dispatcher-espeak-ng - Speech Dispatcher: Espeak-ng output module
asterisk-espeak - eSpeak module for Asterisk
brltty-espeak - Access software for a blind person - espeak driver
emacspeak-espeak-server - espeak synthesis server for emacspeak
espeak - Multi-lingual software speech synthesizer
espeak-data - Multi-lingual software speech synthesizer: speech data files
espeak-ng - Multi-lingual software speech synthesizer
espeak-ng-espeak - Multi-lingual software speech synthesizer
espeakedit - Multi-lingual software speech synthesizer - editor
espeakup - Connector between speakup kernel modules and espeak
gstreamer1.0-espeak - GStreamer plugin for eSpeak speech synthesis
libespeak-dev - Multi-lingual software speech synthesizer: development files
libespeak-ng-libespeak1 - Multi-lingual software speech synthesizer: shared library
libespeak1 - Multi-lingual software speech synthesizer: shared library
python3-espeak - Python bindings for eSpeak
ruby-espeak - small Ruby API to create Text-To-Speech mp3 files
speech-dispatcher-espeak - Speech Dispatcher: Espeak output module

% apt search espeak
Sorting... Done
Full Text Search... Done
asterisk-espeak/focal 5.0~1-3 amd64
  eSpeak module for Asterisk

brltty-espeak/focal 6.0+dfsg-4ubuntu6 amd64
  Access software for a blind person - espeak driver

emacspeak-espeak-server/focal 50.0+dfsg-2build1 amd64
  espeak synthesis server for emacspeak

espeak/focal,now 1.48.04+dfsg-8build1 amd64 [installed]
  Multi-lingual software speech synthesizer

espeak-data/focal,now 1.48.04+dfsg-8build1 amd64 [installed,automatic]
  Multi-lingual software speech synthesizer: speech data files

espeak-ng/focal 1.50+dfsg-6 amd64
  Multi-lingual software speech synthesizer

espeak-ng-data/focal,now 1.50+dfsg-6 amd64 [installed,automatic]
  Multi-lingual software speech synthesizer: speech data files

espeak-ng-espeak/focal,focal 1.50+dfsg-6 all
  Multi-lingual software speech synthesizer

espeakedit/focal 1.48.03-7build1 amd64
  Multi-lingual software speech synthesizer - editor

espeakup/focal 1:0.80-16build1 amd64
  Connector between speakup kernel modules and espeak

gstreamer1.0-espeak/focal 0.5.0-1 amd64
  GStreamer plugin for eSpeak speech synthesis

libespeak-dev/focal 1.48.04+dfsg-8build1 amd64
  Multi-lingual software speech synthesizer: development files

libespeak-ng-dev/focal 1.50+dfsg-6 amd64
  Multi-lingual software speech synthesizer: development files

libespeak-ng-libespeak-dev/focal 1.50+dfsg-6 amd64
  Multi-lingual software speech synthesizer: development files

libespeak-ng-libespeak1/focal 1.50+dfsg-6 amd64
  Multi-lingual software speech synthesizer: shared library

libespeak-ng1/focal,now 1.50+dfsg-6 amd64 [installed,automatic]
  Multi-lingual software speech synthesizer: shared library

libespeak1/focal,now 1.48.04+dfsg-8build1 amd64 [installed,automatic]
  Multi-lingual software speech synthesizer: shared library

python3-espeak/focal 0.5-2build1 amd64
  Python bindings for eSpeak

ruby-espeak/focal,focal 1.0.4-1 all
  small Ruby API to create Text-To-Speech mp3 files

speech-dispatcher-espeak/focal 0.9.1-4 amd64
  Speech Dispatcher: Espeak output module

speech-dispatcher-espeak-ng/focal,now 0.9.1-4 amd64 [installed,automatic]
  Speech Dispatcher: Espeak-ng output module
```

`apt-cache search`での検索ではどのようなパッケージが存在するかの情報のみの一方, `apt search`では

- Install status
- available package version
- package description

といった情報まで表示されます.

## `apt` vs `apt-get`

`apt`と`apt-get`は, 両方ともDebianベースLinuxディストリビューションで使用されるパッケージマネージャーです.
パッケージのinstall, upgrade, removeで用いられるという意味では共通していますが, 

- Level of Control(=制御レベル)
- User interface

といった観点で異なる点があります.

**Level of Control**

```zsh
% sudo apt install chromium-browser
```

と実施するとchromiumが動作するために必要なdependenciesを自動的にdownload & installしてくれますが, `apt-get`の場合は自動的にはdependencies対応を実行しれません. もし必要なdependenciesを自動的にdownload & install場合は, `-f` を用いて以下のように実行する必要があります:

```zsh
% sudo apt-get install chromium-browser -f
```

**User interface**

- `apt install`はpackage install時のprogress barの表示をしてくれます
- `apt-get install`はprogress barの表示はない

ケースによっては不必要なprogress barの表示がない分, `apt-get`の方がメモリーの消費は少なく実行速度が早いというメリットがあります.

### Why `apt-get` still in use today?

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Debian公式ドキュメント Tips</ins></p>

Users are recommended to use the new `apt(8)` command for interactive usage and use the `apt-get(8)` and `apt-cache(8)` commands in the shell script.

</div>

shellscriptやDockerfileのスクリプト上では`apt-get`をつかうことが推奨されています.
Dockerfileで`apt install`を用いると,`apt-get`の場合出現しない警告が出現するケースがあります:

```zsh
RUN apt install -y nyancat
WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
```

## Appendix: Relationship between the `apt` command and the `apt-get` command

|Function|`apt-get`|`apt`|
|---|---|---|
|Install package|`apt-get install`|`apt install`|
|Remove package|`apt-get remove`|`apt remove`|
|Update all package| `apt-get upgrade`|`apt upgrade`|
|Update all packages (auto handling of dependencies)|`apt-get dist-upgrade`|`apt full-upgrade`|
|Search packages| `apt-cache search`| `apt search`|
|Show package information| `apt-cache show`| `apt show`|
|Remove unwanted dependencies|`apt-get autoremove`|`apt autoremove`|
|Removes package with associated configuration|`Apt-get purge`|`apt purge`|


References
----------------

> Ryo's Tech Blog

- [Linux環境構築基礎知識：パッケージマネジャーの導入](https://ryonakagami.github.io/2020/12/20/packages-manager-apt-command/)


> Others

- [公式Debianドキュメント](https://www.debian.org/doc/manuals/debian-reference/ch02.en.html)
