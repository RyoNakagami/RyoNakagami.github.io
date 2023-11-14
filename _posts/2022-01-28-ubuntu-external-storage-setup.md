---
layout: post
title: "システム起動時に自動的にドライブをマウントする"
subtitle: "Ubuntu Desktop環境構築 Part 25"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2022-08-06
tags:

- Ubuntu 20.04 LTS
- Linux
---

> 実行環境

実行環境

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

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. やりたいこと](#1-%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
- [2. マウントとは？](#2-%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%88%E3%81%A8%E3%81%AF)
  - [ファイルシステムとは？](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%A8%E3%81%AF)
  - [デバイスファイル](#%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB)
  - [`mount`コマンド](#mount%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [3. `mount`コマンド：実践編](#3-mount%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E5%AE%9F%E8%B7%B5%E7%B7%A8)
  - [デバイスファイルの確認](#%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [一時的なマウントの実行](#%E4%B8%80%E6%99%82%E7%9A%84%E3%81%AA%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%88%E3%81%AE%E5%AE%9F%E8%A1%8C)
  - [システム起動時のマウント設定](#%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E8%B5%B7%E5%8B%95%E6%99%82%E3%81%AE%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%88%E8%A8%AD%E5%AE%9A)
- [Appenidx](#appenidx)
  - [HDD?SSDとは？](#hddssd%E3%81%A8%E3%81%AF)
  - [2種類のデバイス: 「キャラクター型」と「ブロック型」](#2%E7%A8%AE%E9%A1%9E%E3%81%AE%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9-%E3%82%AD%E3%83%A3%E3%83%A9%E3%82%AF%E3%82%BF%E3%83%BC%E5%9E%8B%E3%81%A8%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF%E5%9E%8B)
- [Refereneces](#refereneces)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. やりたいこと

- ST2000DM008 BarraCudaシリーズ 2TB 3.5インチ SATA 7200rpm をUbuntu 起動時にマウントしたい

## 2. マウントとは？

マウントとは, ハードディスクやUSBメモリなどドライブを利用するための仕組みです(= ドライブはマウントしないと使えない).
Linuxプログラム目線でいうと, ファイルシステムの管理というトピックの中の命令（ファイルシステムの結合命令）としてマウントがあります. ですのでまずマウントコマンドを説明する前に
ファイルシステムとはなにかというところから説明します.

### ファイルシステムとは？

ファイルシステムとは, 「ファイル」というインターフェースをユーザーやアプリケーションに提供する仕組みのことです.
ファイルシステムのおかげで以下のことがユーザーはできます:

- 記憶装置の種類の違いや記憶装置にデータがどのように記録されているか意識することなく, データをファイルという
仮想的な容器に格納したり取り出す
- ファイルをディレクトリにまとめる(=ファイルの管理性の向上)
- ファイルをアクセス権で保護する(=セキュリティ確保)

> ファイルシステム同士の互換性

利用できるファイルシステムはOSによって違います. Linuxが扱うことができるファイルシステム種類例は以下です:

|ファイルシステム|説明|
|---|---|
|ext4|Linuxの標準的なファイルシステム<br>ext3に比べてストレージサイズが大きく進化<br>4Kブロックサイズが標準|
|ext3|ext4の古いバージョン|
|NTFS|Windowsのファイルシステム|
|XFS|RHELやCentOSのデフォルト|
|VFAT|SDカードやフラッシュメモリで使われるファイルシステム|

ファイルシステムの異なるWindows, Mac, Linuxなどは, 基本的にそのままではお互いのファイルを利用することはできません. 
ファイルをやり取りするためには, 専用のアプリケーションを使うか, 互換性のあるファイルフォーマットを使用します.

> なぜ一つのOSで異なるファイルシステムが共存できるのか？

`parted -l`コマンドを使ってパーティション情報を見てみると, 自分の環境では`ext4`, `fat32`, `ntfs`といった
ファイルシステムが確認できます. ファイルシステムの種類が違えば, メタデータの構造が違うので, 根本的にファイルに対するアクセス方法は
違うはずなのですが, 普通にファイルアクセスはできます.

これはLinuxカーネルが「仮想ファイルシステム（VFS）」という多種類のファイルシステムについて共通インターフェイスを提供してくれているからです.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220128-filesystem-and-VFS.png?raw=true">


### デバイスファイル

Linuxでは, HDDやSSD, USBメモリといったデバイス（=ドライバ）に対応するデバイスファイルが用意されています.
デバイスファイルは各種ハードウェアの入出力を扱うための特殊ファイルです. 
ファイルシステムによってデバイスデータがデバイスファイルとして管理され, そのためデバイス操作（データの入出力）が普通のファイル操作
と同じ感覚で実行できるようになっています. 

Linux ではデバイスファイルは `/dev` ディレクトリに存在します.

---|---
`/dev/sda`|1番目に認識されたSATA/USBドライブ
`/dev/sda1`|`/dev/sda`に作られた1番目のパーティション
`/dev/sdb`|2番目に認識されたSATA/USBドライブ
`/dev/sdc`|3番目に認識されたSATA/USBドライブ
`/dev/sr0`|１番目に認識されたDVD/BDドライブ


### `mount`コマンド

`mount`は, HDDやUSBメモリ, DVD-ROMなどのフォーマット済みの領域（ファイルシステム）を指定したディレクトリ（= mount point）と
一時的に結び付けてアクセスできるようにするコマンドです. 


```
mount -t <filesyetem type> <device file path> <mount point>
```

> 主要オプション

---|---|---
`-t`|`--types`|マウントするファイルシステムの種類を指定する（「,」区切りで複数指定可能、「～以外」としたい場合はnoを付ける、autoで自動判定 ※3）
`-r`|`--read-only`| 	読み込み専用でマウントする（「-o ro」相当)
`-w`|`--rw`、`--read-write|読み書き可能な状態でマウントする（デフォルト)
`-f`|`--fake`| 	実際にはマウントしない（実行内容を確認したいときに使用）


> マウントを削除したい場合

```
umount <mount point>
```

アンマウントが実行されたかどうかは, `ls`コマンドで内容を参照できるかどうかで確認できます.
なお, アンマウントできるのは, そのディレクトリが使用されていない状態のときだけで, ディレクトリを参照している
プロセスがある場合は アンマウントできません.


## 3. `mount`コマンド：実践編

### デバイスファイルの確認

`parted -l`コマンドですべてのブロックデバイスのパーティション情報を表示することができます(`fdisk -l`でも可能).

```
% sudo parted -l 
Model: ATA ST2000DM008-2FR1 (scsi)
Disk /dev/sda: 2000GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name                  Flags
 1      1049kB  2000GB  2000GB  ntfs         Basic data partition  msftdata
（略）
```

### 一時的なマウントの実行

```zsh
% mkdir mnt/share_01 ###mount pointの作成
% sudo mount /dev/sda1 mnt/share_01  
```

### システム起動時のマウント設定

システム起動時にマウントを実行したい場合は. 設定を`/etc/fstab`に記載します.
記載すべき内容は以下,

```
<file system> <mount point>   <type>  <options>       <dump>  <pass>
```

---|---
`<file system>`|デバイスファイル名(PATH), UUIDのいずれかを指定
`<mount point>`|マウントポイント 
`<type>`|ファイルシステムの種類
`<options>`|マウント時のオプション, 複数指定する場合はカンマ(`,`)で区切って指定
`<dump>`|バックアップコマンド`dump`の対象とするか否かの設定<br>0または無記述の場合はdump不要のファイルシステムであると見なされる
`<pass>`|システム起動時に`fsck`チェック（ファイルシステム整合性確認）を行うか否かの指定

> デバイスのUUIDの確認

デバイスファイルは別のディスクに置き換わる可能性があるので今回はUUIDベースで設定したいと思います.
UUIDの確認は`blkid`コマンドを用います.

```zsh
% blkid /dev/sda1
```

> 今回の設定例

```
UUID=hogehoge /mnt/share_01 auto nosuid,nodev,nofail,x-gvfs-show 0 0
```


> 番外編: GUIでの設定

GNOME DisksとはUbuntuのストレージ管理ツールです. 
GUIでの設定内容を`/etc/fstab`に保存してくれるので便利です.
起動コマンドは以下,

```zsh
% sudo gnome-disks
```


## Appenidx
### HDD?SSDとは？

ハードディスクドライブ (Hard Disk Drive, 略して HDD) は磁気を用いてデータを記録する装置です．HDD の内部には金属製の円板が何枚か入っており，ヘッドと呼ばれる装置で磁気を書き込むようになっています．円板の上にたくさんの小さい磁石が並んでいて，この磁石の向きでデータを記憶しています．HDD の中でデータを記憶する円板の 1 枚 1 枚をプラッタといいます．HDD の記憶容量を増やすにはプラッタの枚数を増やす方法と 1 プラッタあたりの記憶容量を増やす方法があり，この両方を進めることで HDD の容量増加が図られてきました．

ソリッドステートドライブ (Solid State Drive, 略して SSD) は可動部を持たないドライブという意味で，フラッシュメモリなどの装置を使ってデータを記録します. HDD に比べて優れた点の 1 つは，HDD のヘッドのような動くパーツを持たないということです．したがって物理的な衝撃に対して SSD は HDD よりも優れています．また SSD は一般に HDD よりデータ読み書きの速度が速いとされています．

どのようにデータを記録しているかのイメージは以下のYoutube videoがおすすめ.

<iframe width="560" height="315" src="https://www.youtube.com/embed/wteUW2sL7bc" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### 2種類のデバイス: 「キャラクター型」と「ブロック型」

Linuxではデバイスを主に「キャラクター型」と「ブロック型」の2種類に分類します.

> キャラクター型

- シリアル回線や端末のようにデータを1 byteずつ入出力するタイプのデバイス. 
- データは基本的にバッファーされない

> ブロック型

- ハードディスクのように固定長のデータ（ブロック）単位に入出力するタイプのデバイス
- データは基本的にバッファーされる

## Refereneces

> 参考書籍

- [Ubuntuサーバー徹底入門, 中島 能和 著](https://www.shoeisha.co.jp/book/detail/9784798155760)
- [UNIXの絵本, 株式会社アンク著](https://www.shoeisha.co.jp/book/detail/4798109339)

> オンラインマテリアル

- [gihyo.jp > ストレージ管理ツール「ディスク」を活用する［2022年版］](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0701)