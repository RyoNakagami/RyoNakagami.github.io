---
layout: post
title: "ssh接続時のシステムメッセージを非表示にする"
subtitle: "ssh series 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-06-30
tags:

- ssh
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [ssh接続時のシステムメッセージ](#ssh%E6%8E%A5%E7%B6%9A%E6%99%82%E3%81%AE%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8)
- [ログインメッセージをユーザー単位で非表示にする](#%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%82%92%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E5%8D%98%E4%BD%8D%E3%81%A7%E9%9D%9E%E8%A1%A8%E7%A4%BA%E3%81%AB%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## ssh接続時のシステムメッセージ

Ubuntu OSのhostへSSHでログインする時，次のようなシステムメッセージが表示されます

```zsh
% ssh kirakirabushi
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-35-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

Expanded Security Maintenance for Applications is enabled.

56 updates can be applied immediately.
To see these additional updates run: apt list --upgradable
```

上記のログインメッセージは以下のスクリプトで再現することができます

```zsh
% run-parts /etc/update-motd.d/
```

このような「⁠ログインした時にメッセージを表示する」仕組みは「MOTD（Message Of The Day）」と呼ばれます．
メンテナンスの予定日など，システム管理者からログインしたユーザーに伝えるべき情報を伝えるための仕組みです．

UbuntuのMOTDは`/etc/update-motd.d`以下のスクリプトを順番に実行することで生成されます．

```zsh
% ls /etc/update-motd.d/                                                                                      
00-header*     85-fwupd*                   91-release-upgrade*      98-fsck-at-reboot*
10-help-text*  90-updates-available*       92-unattended-upgrades*  98-reboot-required*
50-motd-news*  91-contract-ua-esm-status*  95-hwe-eol*              99-livepatch-kernel-upgrade-required*
```

|Script|Comments|
|---|---|
|`00-header`|「Welcome to ...」の1行を表示|
|`10-help-text`|各種ドキュメントのリンクを表示|
|`50-landscape-sysinfo`|ロードアベレージ等のシステム情報の表示|
|`50-motd-news`|「https://motd.ubuntu.com」の内容を表示|
|`85-fwupd`|/run/motd.d/85-fwupdに記録されているfwupdmgrの結果を表示|
|`88-esm-announce`|/var/lib/ubuntu-advantage/messages/motd-esm-announceの内容を表示|
|`90-updates-available`|/var/lib/update-notifier/updates-availableの内容、主に更新可能なパッケージの数に加えて、Ubuntu Proが提供するESMの宣伝を表示|
|`91-contract-ua-esm-status`|/var/lib/ubuntu-advantage/messages/以下の、主にUbuntu Proの状態を表示|
|`91-release-upgrade`|rootアカウントなら/usr/lib/ubuntu-release-upgrader/release-upgrade-motdを実行して、より新しいUbuntuのバージョンを表示|
|`92-unattended-upgrades`|/usr/share/unattended-upgrades/update-motd-unattended-upgradesを実行して、自動アップグレードされなかったパッケージ情報等を表示|
|`95-hwe-eol`|/usr/lib/update-notifier/update-motd-hwe-eolを実行して、HWEのEOL状態の表示|
|`97-overlayroot`|ルートファイルシステムがoverlayrootならその情報を表示[1]|
|`98-fsck-at-reboot`|/usr/lib/update-notifier/update-motd-fsck-at-rebootを実行して、次回再起動時にfsckが行われるかを表示|
|`98-reboot-required`|/usr/lib/update-notifier/update-motd-reboot-requiredを実行して、更新を適用するために再起動が必要かどうかを表示|

## ログインメッセージをユーザー単位で非表示にする

表示内容をユーザー単位で非表示にしたい場合は，Home directory直下に`.hushlogin`という空ファイルを生成するだけで十分です．

```zsh
% touch ~/.hushlogin
```


References
----------
- [UbuntuにおけるMOTDの仕組みのすべて](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0755)
