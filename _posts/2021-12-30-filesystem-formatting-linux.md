---
layout: post
title: "Linuxファイルシステムの作成"
subtitle: "Linux filesystem 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-07-28
tags:

- Linux
- filesystem

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [ファイルシステムとは？](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%A8%E3%81%AF)
  - [ファイルシステムの種類](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%AE%E7%A8%AE%E9%A1%9E)
    - [その他のファイルシステム](#%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0)
- [ファイルシステムの作成: `mkfs`コマンド](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%AE%E4%BD%9C%E6%88%90-mkfs%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [`ext4`フォーマットを作成する](#ext4%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B)
  - [`exfat` ファイルシステムを設定する場合](#exfat-%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
- [Appendix: ファイルの`atime/ctime/mtime`](#appendix-%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AEatimectimemtime)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## ファイルシステムとは？

デバイスファイルをパーティショニングしたあとに, 各パーティションにファイルシステムを作成しないと
そのデバイスは`mount`することができません. そもそも, `mount`は「**ファイルシステムを結合させる**」コマンド
であるためです.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: ファイルシステム</ins></p>

ファイルシステムとは, 「ファイル」というインターフェースをユーザーやアプリケーションに提供する仕組みのこと. 
ファイルシステムという仕組みによって以下のことが実現できる:

- 記憶装置の種類の違いや記憶装置にデータがどのように記録されているか意識することなく, データをファイルという 仮想的な容器に格納したり取り出す
- ファイルをディレクトリにまとめる(=ファイルの管理性の向上)
- ファイルをアクセス権で保護する(=セキュリティ確保)

</div>

ファイルシステムが用意されていない場合, ディスク上のデータの読み出しに例えば「1534セクタの
データを開く」という指示が必要となります. 一方, ファイルシステムが用意されていれば, 「`/tmp/data.txt`
のファイルを開く」のように分かりやすくデータを取り扱いできます.

### ファイルシステムの種類

利用できるファイルシステムはOSによって違います. Linuxでは`ext4`というファイルシステムがメインで用いられています.

|ファイルシステム|最大ファイルサイズ|最大ファイルシステムサイズ|説明|
|---|---|---|---|
|`ext`|2GB|2GB|2.1.21以降のカーネルではサポートされていない|
|`ext2`|2TB|32TB|可変ブロックサイズ<br>`ctime/atime/mtime`のサポート<br>ビットマップによるブロックとi-nodeの管理<br>ブロックグループの導入|
|`ext3`|2TB|32TB|`ext2`にジャーナル機能を追加. `ext2`と後方互換性がある|
|`ext4`|16TB|1EB|ナノ秒単位のタイムスタンプをサポート<br>デフラグ機能追加<br>4Kブロックサイズが標準<br>extentの採用<br>`ext2/ext3`と後方互換性がある|

`ext2/ext3/ext4`ファイルシステムは, ディスク上のセクタを集めたブロック単位で構成されます.
ブロックサイズが4096であるファイルサイズでは, 1 Byteのデータを格納する場合でも, 1ブロックを必要とします.
ブロックサイズは, ファイルシステム作成時に指定できますが, 後から変更することはできません. 

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: ジャーナル機能</ins></p>

ファイルシステムのデータの更新を記録する機能. 不要な電源切断があった場合など, 
変更履歴をチェックして管理データの再構築ができるため,. ファイルシステムチェックを短縮することができる.

</div>


#### その他のファイルシステム

|ファイルシステム|説明|
|---|---|
|`xfs`|ジャーナル機能を持ったファイルシステム. i-nodeの動的割当をサポート|
|`jfs`|ジャーナル機能を持ったファイルシステム. i-nodeの動的割当をサポート|
|`vfat`|SDカードやフラッシュメモリで使われるファイルシステム<br>WIndowsとLinuxの両方で読み書き可能<br>ファイルシステム最大サイズは4GB|
|`ntfs`|Windows NT系の標準ファイルシステム. Linuxでは読むことはできるが作成することはできない|
|`exfat`|`vfat`の拡張. 最大ファイルサイズ(16EiB)対応|
|`btrfs`|B-Tree（木構造）を採用<br>データ領域の割当にextentを採用<br>スナップショット機能あり<br>複数のディスクパーティションから１つのファイルシステムを構成可能|
|`reiserfs`|ジャーナル機能を持ったファイルシステム<br>ディスク使用効率が高い<br>i-nodeの動的割当をサポート<br>クラッシュからの高速回復機能がある|
|`tmpfs`|仮想メモリベースのファイルシステム|
|`sysfs`|デバイス情報を扱う仮想ファイルシステム|
|`procfs`|プロセス情報を扱う仮想ファイルシステム|
|`devpts`|疑似端末を制御するための仮想ファイルシステム|

## ファイルシステムの作成: `mkfs`コマンド

ファイルシステムを作成する際は, `mkfs`コマンドを利用します.
Usageは以下の形式に従います.

```zsh
% mkfs [options] [-t <type>] [fs-options] <device> [<size>]
```

option `-t <type>`でファイルシステムタイプを指定します.
何も指定しない場合は, `ext2`がデフォルトで動くようになっています.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: ext3の設定</ins></p>


`ext3`は`ext2`にジャーナル機能をつけたファイルシステムと先に説明しましたが, `mkfs`コマンドで
`-j`というジャーナル機能有効オプションを指定すると, `ext3`でファイルシステムを作成することができます.

```zsh
## ext2 
% sudo mkfs /dev/sda1

## ext3 
% sudo mkfs -j /dev/sda1
% sudo mkfs.ext3 /dev/sda1
% sudo mkfs -t ext3 /dev/sda1
```


</div>



### `ext4`フォーマットを作成する

```zsh
% lsblk /dev/sda 
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    1 57.3G  0 disk 
├─sda1   8:1    1   10G  0 part 
└─sda2   8:2    1 47.3G  0 part 
```

上記の構成で, `/dev/sda1`の方を`ext4`でフォーマットする場合は以下のように実行します.

```zsh
% sudo mkfs -t ext4 /dev/sda1
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 2621440 4k blocks and 655360 inodes
Filesystem UUID: 534b46bf-6259-4f70-a46b-e898389cfdbc
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 
```

なお, `sudo mkfs.ext4 /dev/sda1`でも同じ挙動となります. 


### `exfat` ファイルシステムを設定する場合

ファイルシステムの異なるWindows, Mac, Linuxなどは, 基本的にそのままではお互いのファイルを利用することはできません. 
ファイルをやり取りするためには, 専用のアプリケーションを使うか, 互換性のあるファイルフォーマットを使用する必要があります.

WindowsやMacでも利用可能性のあるFlash Driveをフォーマットしたい場合は, `exfat`ファイルシステムを用いることが推奨されます.
ただし, Ubuntuではデフォルトでは利用できないので, 必要なパッケージをまずインストールします.

```zsh
% sudo apt install exfat-fuse
```

その後は, `mkfs`コマンドでフォーマットを `exfat`を指定すればOKです.

```zsh
% sudo mkfs -t exfat /dev/sda2
exfatprogs version : 1.1.3
Creating exFAT filesystem(/dev/sda2, cluster size=131072)

Writing volume boot record: done
Writing backup volume boot record: done
Fat table creation: done
Allocation bitmap creation: done
Upcase table creation: done
Writing root directory entry: done
Synchronizing...

exFAT format complete!
```

このままではまだMacでは使用できません. 実際にMacでファイルシステムを確認してみると
`Linux Filesystem`という形で認識されデータを読み込むことができません.

`parted`コマンドを用いて, gpt partition情報について`msftdata`を設定する必要があります.

```zsh
% sudo parted /dev/sda 
GNU Parted 3.4
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) set 1 msftdata on                                                
(parted) quit                                                             
Information: You may need to update /etc/fstab.
```

`fdisk`で以下のようにTypeが確認できればMacでも使用できるようになります.

```zsh
% sudo fdisk -l /dev/sda
Device        Start       End  Sectors  Size Type
/dev/sda1      2048  20973567 20971520   10G Linux filesystem
/dev/sda2  20973568 120127454 99153887 47.3G Microsoft basic data
```


## Appendix: ファイルの`atime/ctime/mtime`

|時間種類|説明|確認コマンド|
|---|---|---|
|`atime`|アクセス時間|`ls -la`|
|`ctime`|作成時間|`ls -lc`|
|`mtime`|修正時間|`ls -l`|

`stat`コマンドでファイルアクセス時刻を検索することも可能です.

```zsh
% stat README.md
  File: README.md
  Size: 2527            Blocks: 8          IO Block: 4096   regular file
Device: 10302h/66306d   Inode: 1715881     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/hoshinokirby)   Gid: ( 1000/hoshinokirby)
Access: 2021-09-10 05:27:40.311500980 +0900
Modify: 2021-08-02 16:50:33.582077940 +0900
Change: 2021-08-02 16:50:33.582077940 +0900
 Birth: 2021-07-23 04:08:26.370426410 +0900
```



References
--------------

- [Ryo's Tech Blog > 2021-12-29 Partitioning Storage Volumnes]()
- [Ubuntuサーバー徹底入門, 中島 能和 著](https://www.shoeisha.co.jp/book/detail/9784798155760)
- [UNIXの絵本, 株式会社アンク著](https://www.shoeisha.co.jp/book/detail/4798109339)
- [Mac OS cannot mount exFAT disk created on (Ubuntu) linux](https://unix.stackexchange.com/questions/460155/mac-os-cannot-mount-exfat-disk-created-on-ubuntu-linux)
