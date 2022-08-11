---
layout: post
title: "Linux基本コマンド"
subtitle: "reboot コマンド／poweroff コマンドの仕組み"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-04
tags:

- Ubuntu 20.04 LTS
- Linux
- Shell
---



**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回紹介すること](#%E4%BB%8A%E5%9B%9E%E7%B4%B9%E4%BB%8B%E3%81%99%E3%82%8B%E3%81%93%E3%81%A8)
- [reboot/poweroffコマンド](#rebootpoweroff%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [rebootコマンドとpoweroffコマンドの実体](#reboot%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A8poweroff%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E5%AE%9F%E4%BD%93)
  - [なぜreboot/poweroffコマンドではなくshutdownコマンドが推奨されるのか？](#%E3%81%AA%E3%81%9Crebootpoweroff%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%8Fshutdown%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%8C%E6%8E%A8%E5%A5%A8%E3%81%95%E3%82%8C%E3%82%8B%E3%81%AE%E3%81%8B)
- [systemctlとは？Ubuntuはどのようにサービス管理をしているのか？](#systemctl%E3%81%A8%E3%81%AFubuntu%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AB%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E7%AE%A1%E7%90%86%E3%82%92%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
  - [systemdはどの段階で登場するのか？](#systemd%E3%81%AF%E3%81%A9%E3%81%AE%E6%AE%B5%E9%9A%8E%E3%81%A7%E7%99%BB%E5%A0%B4%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)
  - [unit: systemd によるサービス処理の単位](#unit-systemd-%E3%81%AB%E3%82%88%E3%82%8B%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E5%87%A6%E7%90%86%E3%81%AE%E5%8D%98%E4%BD%8D)
  - [Unit構成ファイル](#unit%E6%A7%8B%E6%88%90%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)
  - [systemctlコマンド](#systemctl%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 今回紹介すること

- CLIからLinux OSをrebootとshutdownするコマンドの確認
- システム起動の仕組みのまとめ

## reboot/poweroffコマンド

---|---
`reboot [option]`|再起動コマンド
`poweroff [option]`|shutdownコマンド

rebootコマンド／poweroffコマンドのオプションは

|短いオプション |	長いオプション |	意味|
|---|---|---|
|`-f` |	`--force` |	強制的に再起動または電源をオフにする|

コマンドラインからLinuxを再起動したり、PCの電源をオフにしたりする場合、伝統的には　`shutdown` コマンドを使用します.しかし、shutdownコマンドは「スーパーユーザー」しか利用が許可されておらず、一般ユーザーはパスワードを入力しないと実行できません.個人用のLinux PCの場合、デスクトップのメニューから簡単に再起動や電源をオフできるように、rebootコマンドやpoweroffコマンドを使うことで、一般ユーザーでもコマンドから手軽に再起動や電源オフが実行できます.

**`shutdown`コマンドとの対応表**

---|---
`reboot`|`sudo shutdown -r now`
`poweroff`|`sudo shutdown -h now`


> `shutdown`コマンドになぜ管理者権限が必要?

LinuxというかUnixシステムの話になりますが、Unixシステムの利用方法の基本は「UNIXがインストールされたコンピューター（ホスト）に、ネットワーク経由で複数の別のターミナルから接続して、作業を行う」です. そのため、一般ユーザーレベルに`shutdown`コマンドの利用を許してしまうと、他の人が作業しているのにいきなりホストが停止するという事態を招きかねません. そのため、`shutdown`コマンドに管理者権限が必要ということになっています.

### rebootコマンドとpoweroffコマンドの実体

rebootコマンドとpoweroffコマンドは共に「/usr/bin/systemctl」(`systemctl` コマンド)への「シンボリックリンク」となっています.確認方法として、

```zsh
% ls -l $(which reboot)               
lrwxrwxrwx 1 root root 14 Mar 18 06:36 /usr/sbin/reboot -> /bin/systemctl*
% ls -l $(which shutdown)                                                 ?master
lrwxrwxrwx 1 root root 14 Apr 21 21:54 /usr/sbin/shutdown -> /bin/systemctl*
```

### なぜreboot/poweroffコマンドではなくshutdownコマンドが推奨されるのか？

`shutdown`コマンドはユーザー通知や時間指定の機能がある一方, `poweroff/reboot`はそれらの機能がありません.
後者はお手軽に実行できるメリットはありますが, 環境によっては複数ユーザーで共有しているなど「一般ユーザーが勝手に終了すべきではない」場面があります.
そのため, reboot/poweroffコマンドが嫌われているのではないかなと思います.

```zsh
% shutdown -h +5 "Shutdown At 03:48"
```

- `-h`: poweroffの指定（指定なしでもデフォルトでpoweroff）
- `+5`: 5分後
- `Shutdown At 10:43`: ユーザー通知メッセージ

キャンセルしたい場合は

```zsh
% shutdown -c
```

## systemctlとは？Ubuntuはどのようにサービス管理をしているのか？

Ubuntuでは、システムの起動とサービスの管理に `systemd` というLinuxの起動処理やシステム管理を行う仕組み（システム管理デーモン）を採用しています. なおここでのサービスの意味は、OS本体から切り離し可能な、何らかの役割をもったサブシステムのことです.ログ管理サービスやネットワークサービス、各種サーバープログラム(DBなど)がサービスに当たります. 

`systemctl` は `sytemd`を操作するコマンドと理解しています.

### systemdはどの段階で登場するのか？

Linuxの起動はざっくりと以下の4段階によって行われます.

1. 電源投入によりBIOSが起動する.
2. BIOSからブートローダーが呼び出される.
3. ブートローダーがLinuxカーネルを起動する.
4. Linuxカーネルがinitプロセス(PID 1)を起動する.

このinitプロセスが、Linuxの起動処理を司ります. 古くから使われていたのがSysvinitで、Sysvinitの代替えとしてsystemdが採用されています.なお、WSL2はデフォルトでsystemdが動いていないです(設定したい場合は[こちら](https://mametter.hatenablog.com/entry/2021/03/13/004038)参考)


<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210428_systemd_how_it_works.png?raw=true">

### unit: systemd によるサービス処理の単位

systemd では、システムやサービスの起動を Unit という処理単位で分割しています. Unitの種類は以下

|種類|説明|
|---|---|
|service|各種サービスの起動、停止のコマンドなどを定義しています|
|device|各種デバイスを表す|
|mount|ファイルシステムをマウントする|
|swap|スワップ領域を有効にする|
|target|複数のUnitをグループ化する|
|socket|特定のソケットを監視し接続があるとサービスを起動する|

**ランレベルとターゲット**

従来のランレベルに対応するのが、複数のUnitをグループ化したターゲットです. 従来のシステムランレベルの2または3に相当するものが`multi-user.target`です.ランレベルとは、UNIX System V 系のinit処理を実装したオペレーティングシステムに見られる動作モードです. Linuxがどういう状態で動作しているかを示す数字がランレベルと理解すれば十分です.

通常、ランレベル 0 になるとコンピュータは停止し、ランレベル 6 ではリブートされます. それらの中間のランレベル（1 - 5）は、マウントするディスクドライブ、ネットワークサービスを起動するか否かなどで差異があります. 低いランレベルは、保守や緊急の事態への対処に使われ、ネットワークサービスを起動しないことが多いです.

|ランレベル|systemd target|内容|
|---|---|---|
|0|poweroff.target|停止|
|1|rescue.target|シングルユーザーモード(ネットワークなし), rootだけがログインできるモード|
|2|multi-user.target|マルチユーザーモード（NFSマウントなし, ネットワークなし）|
|3|multi-user.target|CLIによるマルチユーザーモード|
|4|multi-user.target|未使用|
|5|graphical.target|GUIによるマルチユーザーモード. GUIでのログインの際に使用されます|
|6|reboot.target|システム再起動|

### Unit構成ファイル

Unitを定義した構成ファイルは、`/usr/lib/systemd`ディレクトリ及び`/etc/systemd/system`ディレクトリ以下に配置されています.前者はシステムのデフォルト設定で後者は管理者が編集可能なファイルです. systemdを用いたプログラムの自動起動を自作したい場合は、後者のディレクトリでファイルを設定することになります.

systemd のユニットファイルの作り方にかんしては[こちら](https://tex2e.github.io/blog/linux/create-my-systemd-service)が参考になります.

### systemctlコマンド

**Syntax**

```
systemctl サブコマンド [Unit] [option]
```

|操作 |	コマンド|
|---|---|
|サービス起動| 	systemctl start ${Unit}|
|サービス停止| 	systemctl stop ${Unit}|
|サービス再起動| 	systemctl restart ${Unit}|
|サービスリロード| 	systemctl reload ${Unit}|
|サービスステータス表示| 	systemctl status ${Unit}|
|サービス自動起動有効| 	systemctl enable ${Unit}|
|サービス自動起動無効| 	systemctl disable ${Unit}|
|サービス自動起動設定確認| 	systemctl is-enabled ${Unit}|
|サービス一覧| 	systemctl list-unit-files --type=service|
|設定ファイルの再読込| 	systemctl daemon-reload|
|システムを再起動|systemctl reboot|
|システムをシャットダウン|systemctl poweroff|


## References

> 関連ポスト

- [Ryo's Tech Blog > 権限管理入門とsudoの使い方](https://ryonakagami.github.io/2021/05/05/ubuntu-permission/)

> オンラインマテリアル

- [Ubuntuサーバー徹底入門 Tankobon Softcover](https://www.amazon.co.jp/Ubuntu%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E5%BE%B9%E5%BA%95%E5%85%A5%E9%96%80-%E4%B8%AD%E5%B3%B6-%E8%83%BD%E5%92%8C/dp/4798155764)
- [systemd のユニットファイルの作り方](https://tex2e.github.io/blog/linux/create-my-systemd-service)