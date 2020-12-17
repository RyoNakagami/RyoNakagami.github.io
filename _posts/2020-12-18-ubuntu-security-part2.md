---
layout: post
title: "Ubuntu Desktop環境構築 Part 6"
subtitle: "最低限のセキュリティ対策"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
---

||概要|
|---|---|
|目的|最低限のセキュリティ対策|
|参考|[fail2ban設定例](https://www.bigbang.mydns.jp/fail2ban-x.htm)<br>[ ufw と fail2ban の連携](https://www.osarusystem.com/misc/fail2ban_with_ufw.html)<br>[rkhunter no long updating under MX Linux](https://www.linuxquestions.org/questions/linux-security-4/%5Bsolved%5D-rkhunter-no-long-updating-under-mx-linux-4175638503/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. 今回の方針](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E6%96%B9%E9%87%9D)
- [2. システムのアップデート設定](#2-%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E8%A8%AD%E5%AE%9A)
  - [通知設定 (任意設定)](#%E9%80%9A%E7%9F%A5%E8%A8%AD%E5%AE%9A-%E4%BB%BB%E6%84%8F%E8%A8%AD%E5%AE%9A)
- [3. IPS (Intrusion Prevent System) の設定: `fail2ban` (任意設定)](#3-ips-intrusion-prevent-system-%E3%81%AE%E8%A8%AD%E5%AE%9A-fail2ban-%E4%BB%BB%E6%84%8F%E8%A8%AD%E5%AE%9A)
  - [fail2banのインストール](#fail2ban%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [fail2banのconfig設定と起動](#fail2ban%E3%81%AEconfig%E8%A8%AD%E5%AE%9A%E3%81%A8%E8%B5%B7%E5%8B%95)
- [4. rootkit対策](#4-rootkit%E5%AF%BE%E7%AD%96)
  - [データベースのアップデート](#%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88)
- [5. `lynis`によるシステム診断](#5-lynis%E3%81%AB%E3%82%88%E3%82%8B%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E8%A8%BA%E6%96%AD)
  - [lynisのバージョン確認](#lynis%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%A2%BA%E8%AA%8D)
  - [lynisのアップデート情報の確認](#lynis%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E6%83%85%E5%A0%B1%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [6. `clam antivirus`によるウイルス対策](#6-clam-antivirus%E3%81%AB%E3%82%88%E3%82%8B%E3%82%A6%E3%82%A4%E3%83%AB%E3%82%B9%E5%AF%BE%E7%AD%96)
- [Appendix: lynisのwarning修正](#appendix-lynis%E3%81%AEwarning%E4%BF%AE%E6%AD%A3)
  - [WARNING: `Permissions for directory: /etc/sudoers.d`](#warning-permissions-for-directory-etcsudoersd)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回の方針

1. システムのアップデート設定
2. Intrusion Prevent Systemの設定
3. rootkit対策
4. `lynis`によるシステム診断
5. `clam antivirus`によるウイルス対策

## 2. システムのアップデート設定

ソフトウェアのセキュリティホールはひっきりなしに発見されます。利用しているソフトウェアにセキュリティホールが存在した場合、直ちにセキュリティホールのないバージョンへアップデートさせる必要があります。

```
$ sudo apt install unattended-upgrades
```

`unattended-upgrades` パッケージをインストールすると設定画面が表示されます。

|設定項目||
|---|---|
|Automatically dpwnload and install stable updates?|Yes|
|Origins-Pattern|デフォルトの設定で良いので`OK`を選択|

設定は `/etc/apt/apt.conf.d/50unattended-upgrades` ファイルに保存されているので、これを編集してアップデートする内容を設定できます。

### 通知設定 (任意設定)

メールサーバーのセットアップが完了している場合、アップデートの内容をメールで通知するように設定す流ことができる。

```
$ sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

通知を送信するメールアドレスを設定する。

```
//Unattended-Upgrade::Mail "root";
Unattended-Upgrade::Mail "user@example.com";
```

## 3. IPS (Intrusion Prevent System) の設定: `fail2ban` (任意設定)

IPSは侵入の試みを検知して積極的に防御してくれます。`fail2ban` はログファイルをスキャンし、悪意のあるアクセスや攻撃の全長を捉えてアクセス元のIPアドレスをbanします。

<img src = "https://github.com/RyoNakagami/omorikaizuka/blob/master/linux/security/20201217_ubuntu_fail2ban.jpg?raw=true">

### fail2banのインストール

```
$ sudo apt install fail2ban
```

設定ファイルは `/etc/fail2ban/jail.conf`ファイル及び `/etc/fail2ban/jail.d`以下のファイルとなります

### fail2banのconfig設定と起動

設定は `/etc/fail2ban/jail.conf` を直接編集するのではなく、`jail.local` ファイルとしてコピーしてこちらに設定を記述します。

設定例は以下、

```
ignoreip = 127.0.0.1/8 #無視しても良いIPアドレスがあれば記述

bantime  = 600         #IPアドレスを600秒間遮断する

findtime  = 900        #ログファイル内で900秒間に三回の兆候があれば遮断する
maxretry = 3

banaction = ufw        #firewall設定パッケージの指定 ufw
```

fail2banの起動は

```
$ sudo systemctl start fail2ban.service
```

## 4. rootkit対策

rootkitとは、クラッカーが利用するための何らかの不正侵入ツールのことです。不正侵入者にrootkitを仕掛けられると、侵入の発見が困難になってしまいます。[Rootkit Hunter](http://rkhunter.sourceforge.net)は、rootkitやファイルの改ざん形さに加えて、主なサーバーソフトウェアなどの検査も行うツールです。

```
$ sudo apt install rkhunter
```

検査は

```
$ sudo rkhunter -c
```

出力結果から`[[Warning]]`のように黄色もしくは赤色で表示される項目を確認し、対応策を実施することが望ましいです。

### データベースのアップデート

Rootkit Hunterはrootkitの情報を格納したデータベースをオンラインでアップデートできるなっています。

```
$ sudo rkhunter --update
$ sudo rkhunter --propupd
```

アップデートができない場合はconfigの設定を以下のように変える。各パラメータがどのようなものを指しているかは `/etc/rkhunter.conf` に記載してあるので確認。

```
$ sudo nano /etc/rkhunter.conf
UPDATE_MIRRORS=1
MIRRORS_MODE=0
WEB_CMD=""
PKGMGR=DPKG
```

## 5. `lynis`によるシステム診断

lynisはUNIX系OS向けのセキュリティ診断ツールです。システム設定や状態をチェックして、利用可能なシステム情報やセキュリティ問題のレポートを作成します。インストールは以下、

```
$ sudo apt install lynis
```

lynisによる診断は

```
$ sudo lynis audit sysytem
```

いろいろ怒られる項目が出てきますが、できる範囲内で対応していきます。今回は個人用Desktopの設定なので厳密に実施する必要はないと思いますが、サーバーとして運用する場合はほぼすべて対応することが望ましいです。

### lynisのバージョン確認

```
$ lynis show version
```

### lynisのアップデート情報の確認

```
$ sudo luynis update info
```

update方法の詳細は[公式サイト](https://packages.cisofy.com/community/)を参考にしてください。以下では簡単にチュートリアル程度に説明します。

まずキーサーバーから最新のレポジトリを落としてきます。

```
$ wget -O - https://packages.cisofy.com/keys/cisofy-software-public.key | sudo apt-key add -
```

レポジトリをインストールします。

```
$ echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
$ apt install apt-transport-https
```

レポジトリを更新し、インストールしなおします

```
$ apt update
$ apt install lynis
```

## 6. `clam antivirus`によるウイルス対策

Linux地震に感染するコンピューターウイルスやワームは多くないですが、WindowsやmacOS用のウイルスが書き込まれ、サーバーの利用者に感染してしまうことは考えられます。今回は、オープンソースのウイルス対策ソフトウェアである`clan antivirus`を紹介します。

```
$ sudo apt install clamav -y
```

設定ファイル `/etc/clamav/freshclam.conf` から NotifyClamd の行をコメントアウトします。そしてウイルスデータベース更新コマンドの `freshclam` コマンドを実行します。デーモンとして動いている場合は、手動で実行する必要はありません。

home directory以下のウイルススキャンを実施します。`-i`, `-r` はinfected fileの出力とrecursiveの意味です。

```
$ sudo clamscan -i -r /home
```







## Appendix: lynisのwarning修正
### WARNING: `Permissions for directory: /etc/sudoers.d`

`Permissions for directory: /etc/sudoers.d`をothersからunreadable(読み込み不可)にすることで解決することができます。パーミッションとは、ファイルやディレクトリに対してユーザーやグループが持つ権利のことです。パーミションには読み込み、書き込み、実行の三つの属性があります。今回はこれを`750`とします。`750`はそれぞれuser, group, otherのパーミッションレベルに対応しております。

```
$ chmod 750 /etc/sudoers.d
```

|パーミッション|数値|
|---|---|---|
|r(readble)|4|
|w(writable)|2|
|x(executable)|1|
|-(不許可)|0|

- home directoryのパーミッションWARNINGも同じ要領で修正可能










