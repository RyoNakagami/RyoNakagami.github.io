---
layout: post
title: "LinuxにおけるUser: nobodyとはだれか？"
subtitle: "Linux general 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-06-30
tags:

- Linux
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [LinuxにおけるUser & Group](#linux%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Buser--group)
  - [代表的なユーザー一覧](#%E4%BB%A3%E8%A1%A8%E7%9A%84%E3%81%AA%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E4%B8%80%E8%A6%A7)
  - [nobodyとは誰か？](#nobody%E3%81%A8%E3%81%AF%E8%AA%B0%E3%81%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## LinuxにおけるUser & Group

Linuxでは大きく分けるとユーザーは以下３つあります

|ユーザー区分|説明|
|---|---|
|スーパーユーザー|システム唯一の特権ユーザー，すべてのアクセス制御を無視することができる<br>ユーザー名: root, ユーザーid: 0と決まっている|
|システムユーザー|各種サーバープログラムやシステムプログラムの実行に利用されるユーザー<br>ユユーザーIDは主に1~99の範囲で割り当てられる|
|一般ユーザー|システムの一般利用者<br>ユーザーIDは1000以降が割り当てられる（初めてのユーザーなら1000）|

root以外のuid1000未満のアカウントはデーモンやディレクトリの所有者として利用するシステムアカウントとして用意されています．そのため，100未満のUIDについてシステムによって静的に割り当てられるべきであり，アプリケーションによって作成されるべきではない範囲であると理解できます．一方，100 から 499 は，システム管理者やインストール後のスクリプトが `useradd` を使用して動的に割り当てるために予約された領域となります．

一般ユーザーのリストを取得したい場合は，

- 一般ユーザーは1000以上
- 65535はnobodyに予約されている
- ユーザー情報は `/etc/passwd`ファイルに記録されている

以上の３点を踏まえて，以下のようなスクリプトで確認することができます．

```zsh
## usernameのみ出力
% awk -F':' '{ if ($3 >= 1000 && $1 != "nobody") print $1; }' /etc/passwd

## comma-separatedでuidと合わせて出力
% awk -F':' '{ if ($3 >= 1000 && $1 != "nobody") print $1","$3 }' /etc/passwd
```


### 代表的なユーザー一覧

|User|Group|Comments|
|---|---|---|
|root|root|スーパーユーザー|
|bin|bin|Legacy applicationとの互換性を持たせるためのユーザー，基本的には使用されない|
|daemon|daemon|daemon用のLegacy UID/GUID|
|lp|lp|Printer special privileges|
|sync|sync|Login to sync the system|
|shutdown|shutdown|Login to shutdown the system|
|halt|halt|Login to halt the system|
|mail|mail|Mail special privileges|
|news|news|News special privileges|
|uucp|uucp|UUCP special privileges|
|man|man|Man special privileges|
|nobody|nobody|Used by NFS|

### nobodyとは誰か？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: Unix systemにおけるnobody</ins></p>

- nobodyに対して，一般的にはuid 65534が割り当てられている
- NFS(Network File System)サーバーがクライアントから提供されたUIDやGIDを信頼できない場合，またはroot-squashオプションが使用されている場合に使用される
- 基本的にはNFS用に用意されたユーザー

</div>

注意点として，ネットワークを通じてコンピューター間でファイルを共有するNFS用のユーザーであってその他の目的で使用されることは想定されていません．「nobodyを信頼できないプログラムの実行や信頼できないデータの処理に使用すること」は推奨されません．**「あくまで，サービスには専用のユーザーアカウントを持たせるべき」**というルールを忘れないようにしましょう．

`/etc/shadow`ファイルを見てみると第２フィールドであるpasswordカラムが`*`と表現されています

```zsh
% sudo cat /etc/shadow | grep nobody
nobody:*:11111:0:99999:7:::
```

これnobodyユーザーはパスワードが設定されていないことを意味します．

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#F8F8F8'>
<p class="h4"><ins><strong >Column: 65535について</strong></ins></p>

- 65535は16bit符号なし整数で表すことのできる一番大きな数字
- 16進数だとFFFFとして表現される
- 以下のように初めの４つのフェルマー数の積で表現できる特徴がある 

$$
65535 = (2 + 1)(4+1)(16+1)(256+1)
$$


</div>


References
----------
- [ubuntu Wiki > nobody](https://wiki.ubuntu.com/nobody)
- [Linux Standard Base PDA Specification 3.0RC1 > Chapter 9. Users & Groups](https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/usernames.html)