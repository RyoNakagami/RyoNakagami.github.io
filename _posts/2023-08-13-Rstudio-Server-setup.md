---
layout: post
title: "リモートサーバーにRStudio Serverをインストール & sshアクセス"
subtitle: "R環境構築ノート 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2024-02-21
tags:

- Ubuntu 22.04 LTS
- R
- ssh

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [はじめに](#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB)
- [Remote ServerへのRstudio Serverのインストール](#remote-server%E3%81%B8%E3%81%AErstudio-server%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [ssh configの設定（任意）](#ssh-config%E3%81%AE%E8%A8%AD%E5%AE%9A%E4%BB%BB%E6%84%8F)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## はじめに

- Client: MBP
- Remote Server: Ubuntu 22.04 LTS

にて, Remote Server側にRStudio Serverをインストールし, Clientのブラウザからアクセスできるか
試してみます. 

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Prerequisites</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

- ssh設定
- Remote Serverでの`sudo` privileges
- Remote Server側でRはインストール済み

</div>

Rの設定が完了していない場合は, [Ryo's Tech Blog > How To Install R on Ubuntu 22.04 and set-up Renv](https://ryonakagami.github.io/2023/07/28/Ubuntu-R-setup/)を参照してください.

## Remote ServerへのRstudio Serverのインストール

<div style='padding-left: 2em; padding-right: 2em; border-radius: em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>手順</ins></p>

1. Rstudio-serverのdebファイルダウンロード
2. Rstudio-serverのインストール
3. `rstudio-server.service`の起動状態の確認
4. Rstudio Serverへのアクセス確認

</div>

<br>

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black"><span >Prerequisites</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

---|---8000:localhost:8787
`gdebi-core`|deb ファイルインストール用のツール, ローカルの deb パッケージをその依存関係を解決しながらのインストールが可能になる

```bash
$ sudo apt-get install gdebi-core
```

</div>

> (1) Rstudio-serverのdebファイルダウンロード

Remote Serverへアクセス後以下のコマンドを入力します

```bash
$ mkdir ~/deb_packages
$ cd ./deb_packages
$ wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.12.1-402-amd64.deb
$ ls
rstudio-server-2023.12.1-402-amd64.deb
```

debファイルをダウンロードするので`deb_packages`という格納ディレクトリに移動していますが, これは好みの問題です.

> (2) Rstudio-serverのインストール

```bash
$ sudo gdebi rstudio-server-2023.12.1-402-amd64.deb
```

> (3) `rstudio-server.service`の起動状態の確認

Rstudio-serverインストール後は自動的に`rstudio-server.service`が起動しているはずです.
以下のコマンドでactive (running)となっているか確認できます.

```bash
hoshinokirby@HOSTSERVERNAME$  systemctl status rstudio-server.service
● rstudio-server.service - RStudio Server
     Loaded: loaded (/lib/systemd/system/rstudio-server.service; enabled; vendo>
     Active: active (running) since Thu 2023-08-12 00:54:57 JST; 20min ago
    Process: 166643 ExecStart=/usr/lib/rstudio-server/bin/rserver (code=exited,>
   Main PID: 166645 (rserver)
      Tasks: 12 (limit: 154163)
     Memory: 80.5M
        CPU: 5.050s
     CGroup: /system.slice/rstudio-server.service
             ├─366645 /usr/lib/rstudio-server/bin/rserver
             └─366748 /usr/lib/rstudio-server/bin/rsession -u hoshinokirby --ses>
Aug 12 00:54:57 HOSTSERVERNAME systemd[1]: Starting RStudio Server...
Aug 12 00:54:57 HOSTSERVERNAME systemd[1]: Started RStudio Server.
Aug 12 00:57:15 HOSTSERVERNAME svn[166771]: DIGEST-MD5 common mech free
```

> (4) Rstudio Serverへのアクセス確認

8787ポートがRStudio Serverが使用するポートです. これが空いていることが`sudo ufw status`等で確認出来たのち, 
Client側からsshアクセスを以下のコマンドで試みます.

```zsh
## ssh -L local-port:remote-host:remote-port
% ssh username@hostname -L 8787:localhost:8787
```

実行後, Clientのブラウザで`localhost:8787`を開くとRstudio serverにアクセスできます. 
`ssh username@hostname -L 8000:localhost:8787`とすると`localhost:8000`でアクセスできるようになります.

なおLANGUAGEを日本語や英語に変更したい場合は, サーバー側のlocale設定を変更した後,
`systemctl restart rstudio-server.service`とすれば修正することが出来ます.

### ssh configの設定（任意）

アクセスのたびに`ssh username@hostname -L 8787:localhost:8787`を入力するのは, 
補完機能があったとしても少し長すぎます. 

Client側で`~/.ssh/config`ファイルで設定を管理するのが一つの対策となります.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>configファイルの主な設定項目</ins></p>

|設定項目|説明|
|---|---|
|Host|任意の接続名|
|HostName|接続先ホスト名 or IPアドレス|
|User|ユーザー名|
|Port|接続先ポート番号|
|IdentityFile|秘密鍵のパス|
|LocalForward|ポートフォワーディングの設定|

</div>

`ssh username@hostname -p 2222 -L 8000:localhost:8787`を`ssh test`でアクセスできるようにする場合,
以下のように記述します

```
Host test
    HostName hostname
    User username
    Port 2222
    LocalForward 8000 localhost:8787
```

References
----------
- [Ryo's Tech Blog > How To Install R on Ubuntu 22.04 and set-up Renv](https://ryonakagami.github.io/2023/07/28/Ubuntu-R-setup/)