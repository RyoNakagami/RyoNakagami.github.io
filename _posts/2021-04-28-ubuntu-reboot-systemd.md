---
layout: post
title: "reboot コマンド／poweroff コマンドの仕組み"
subtitle: "Understanding systemd, systemctl 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-08-04
tags:

- Linux
- systemctl
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [reboot/poweroffコマンド](#rebootpoweroff%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
    - [`shutdown`コマンドによる電源オフ/再起動処理](#shutdown%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AB%E3%82%88%E3%82%8B%E9%9B%BB%E6%BA%90%E3%82%AA%E3%83%95%E5%86%8D%E8%B5%B7%E5%8B%95%E5%87%A6%E7%90%86)
  - [rebootコマンドとpoweroffコマンドの実体](#reboot%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A8poweroff%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E5%AE%9F%E4%BD%93)
- [systemctlとは？Ubuntuはどのようにサービス管理をしているのか？](#systemctl%E3%81%A8%E3%81%AFubuntu%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AB%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E7%AE%A1%E7%90%86%E3%82%92%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B)
  - [systemdはどの段階で登場するのか？](#systemd%E3%81%AF%E3%81%A9%E3%81%AE%E6%AE%B5%E9%9A%8E%E3%81%A7%E7%99%BB%E5%A0%B4%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B)
  - [unit: systemd によるサービス処理の単位](#unit-systemd-%E3%81%AB%E3%82%88%E3%82%8B%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E5%87%A6%E7%90%86%E3%81%AE%E5%8D%98%E4%BD%8D)
  - [Unit構成ファイル](#unit%E6%A7%8B%E6%88%90%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)
  - [systemctlコマンド](#systemctl%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## reboot/poweroffコマンド

Ubuntuを始めとするLinux Distributionを用いるとき再起動やシャットダウンを実行するとき以下のコマンドを用います.
1分後にシャットダウン
|コマンド|説明|`systemctl`対応コマンド|
|---|---|---|
|`reboot [option]`|システムを停止して再起動|`systemctl poweroff`|
|`poweroff [option]`|システムを停止して電源をオフ1分後にシャットダウンにする|`systemctl reboot`|

rebootコマンド／poweroffコマンドのオプションは

|短いオプション |	長いオプション |	意味|
|---|---|---|
|`-f` |	`--force` |	強制的に再起動または電源をオフにする|

CLIからLinuxを再起動したり, PCの電源をオフにしたりする場合, 伝統的には　`shutdown` コマンドを使用します.

### `shutdown`コマンドによる電源オフ/再起動処理

`shutdown`コマンドでも`poweroff`, `reboot`処理を実行することも可能です.

```zsh
## poweroff
% sudo shutdown -h +5 "Shutdown At 03:48"

## reboot
% sudo shutdown -r +5 "Shutdown At 03:48"
```

|オプション|説明|
|---|---|
|`-h`/`-r`| poweroff/rebootの指定, デフォルトではpoweroff = `-h`の挙動をする|
|`+5`| 5分後に停止時間の指定, 時間を指定しなかった場合は１分後がデフォルト|
|`Shutdown At 10:43`| Wallメッセージ, ログインユーザー全員に通知する|

予約した`shutdown`処理をキャンセルしたい場合は

```zsh
% shutdown -c
```

時間を指定しなかった場合は１分後がデフォルトなので, 以下のコマンドはどちらもホストを
1分後にシャットダウンするコマンドとなります

```zsh
## 1分後にシャットダウン
% shutdown

## こちらも上と同じ
% shutdown +1
```

ただちにshutdownする場合は

```zsh
% shutdown now
```



**shutdownコマンドとの対応表**

|command|shutdown command|
|---|---|
|`reboot`|`shutdown -r now`|
|`poweroff`|`shutdown -h now`|



### rebootコマンドとpoweroffコマンドの実体

rebootコマンドとpoweroffコマンドは共に`/usr/bin/systemctl`への「シンボリックリンク」となっています.

```zsh
% ls -l $(which reboot)               
lrwxrwxrwx 1 root root 14 Mar 18 06:36 /usr/sbin/reboot -> /bin/systemctl*
% ls -l $(which shutdown)
lrwxrwxrwx 1 root root 14 Apr 21 21:54 /usr/sbin/shutdown -> /bin/systemctl*
```

`reboot`, `poweroff`それぞれ実態としてはsystemctlコマンドが動いています.
これらを実行すると以下の順序で事が運びます:

1. systemctlはD-Busを介してsystemdにmメッセージ「poweroff」「reboot」を送信
2. systemdは並列に各ユニットの停止処理を実行
3. 最後に`reboot`や`poweroff`自体を実行する

なお, `shutdown`コマンドも現代では同じく`/usr/bin/systemctl`への「シンボリックリンク」となっています.

```zsh
% ls -l $(which shutdown)
lrwxrwxrwx 1 root root 14 Mar 20 23:32 /usr/sbin/shutdown -> /bin/systemctl*
```

となっており, optionに応じて`reboot`や`poweroff`が呼ばれる仕様となっています.



## systemctlとは？Ubuntuはどのようにサービス管理をしているのか？

Ubuntuでは、システムの起動とサービスの管理に `systemd` というLinuxの起動処理やシステム管理を行う仕組み（システム管理デーモン）を採用しています. 
なおここでのサービスの意味は, **OS本体から切り離し可能な**何らかの役割をもったサブシステムのことです. 
ログ管理サービスやネットワークサービス、各種サーバープログラム(DBなど)がサービスに当たります. 

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
