---
layout: post
title: "apt-file & apt-cache command: パッケージを検索する"
subtitle: "APTによるパッケージ管理 5/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-04-24
tags:

- Linux
- apt
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [`apt-file`コマンド](#apt-file%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [`apt-cache`コマンド](#apt-cache%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## `apt-file`コマンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins> 📘 apt-fileコマンド</ins></p>

- 指定したパターンを基にパッケージの検索を行うコマンド
- インストールされていないパッケージも検索の対象

|コマンド|説明|
|----|----|
|`apt-file search`|パターンで指定した名前のファイルが含まれているパッケージを表示|
|`apt-file list`|指定したパッケージに含まれるすべてのファイルを表示|
|`apt-file update`|キャッシュファイルの更新|

</div>

利用するためにはデータベースの更新が必要で以下のコマンドを実行します

```zsh
% sudo apt-file update
```

実行後に初めて検索可能になります．`/usr/sbin/sshd`というファイルを含むパッケージを検索する場合は

```zsh
% apt-file search /sbin/sshd
openssh-server: /usr/sbin/sshd  
```

## `apt-cache`コマンド

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins> 📘 apt-cacheコマンド</ins></p>

- debパッケージ情報の検索，表示に使用するコマンド
- データベースのアップデートは`apt update`の都度実行される

|コマンド|説明|
|----|----|
|`apt-cache pkgnames`|インストール可能なパッケージを表示|
|`apt-cache pkgnames <pattern>`|パターンで指定した名前が含まれている<br>パッケージのうち，インストール可能<br>なものを表示|
|`apt-cache show <packagename>`|指定したパッケージの詳細情報を表示|
|`apt-cache dependes <packagename>`|指定したパッケージの依存関係情報を表示|
|`apt-cache dependes <pattern>`|指定した文字列でパッケージ名と説明文<br>から検索し一致したパッケージを返す|
|

</div>

`apt-cache search`はキーワードから簡単に関連しそうなパッケージを探すときに役に立ちます．感覚としては，googleでワードを検索エンジンにかけるのと同じで，複数単語で検索したいときにはそのまま半角スペースを空けて列挙し検索することができます．

ubuntuにiphoneの画面をmirrorしたいなと考えて，以下のコマンドを実行してみたところ

```zsh
% apt-cache search iphone mirror
uxplay - open-source AirPlay mirroring server
```

`uxplay`というパッケージが関連してそうでした．`apt install`後，Firewallを開けて`uxplay -s 1280x720 -fps 60`を実行すると，iphone側からミラーリングを選択できました．

References
----------
- [Uxplay](https://github.com/antimof/UxPlay)
- [stackoverflow > Unable to connect to my UxPlay on Airplay when trying to mirror iphone screen to linux machine](https://stackoverflow.com/questions/74040764/unable-to-connect-to-my-uxplay-on-airplay-when-trying-to-mirror-iphone-screen-to)
