---
layout: post
title: "ssh接続セットアップ: Tailscaleを用いた接続設定"
subtitle: "分析用サーバーとしてのUbuntu Desktop Noble Numbat Setup 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-06-24
tags:

- Ubuntu 24.04 LTS
- ssh
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [記事のスコープ](#%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [Tailscaleの仕組み](#tailscale%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [Tailscale SSH](#tailscale-ssh)
- [Install Tailscale](#install-tailscale)
  - [Tailscaleのuninstall](#tailscale%E3%81%AEuninstall)
- [Tailscale SSH接続前準備](#tailscale-ssh%E6%8E%A5%E7%B6%9A%E5%89%8D%E6%BA%96%E5%82%99)
  - [SSH host server側でのTailscaleのセットアップ](#ssh-host-server%E5%81%B4%E3%81%A7%E3%81%AEtailscale%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97)
  - [Client側でのTailscaleセットアップ](#client%E5%81%B4%E3%81%A7%E3%81%AEtailscale%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97)
    - [Block incoming connections](#block-incoming-connections)
- [SSH接続の実行](#ssh%E6%8E%A5%E7%B6%9A%E3%81%AE%E5%AE%9F%E8%A1%8C)
  - [Tailnetを介したnodes間の疎通確認](#tailnet%E3%82%92%E4%BB%8B%E3%81%97%E3%81%9Fnodes%E9%96%93%E3%81%AE%E7%96%8E%E9%80%9A%E7%A2%BA%E8%AA%8D)
  - [SSH hostserver側でのユーザー設定](#ssh-hostserver%E5%81%B4%E3%81%A7%E3%81%AE%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E8%A8%AD%E5%AE%9A)
    - [ユーザーの作成](#%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%81%AE%E4%BD%9C%E6%88%90)
    - [ユーザーをグループに追加する](#%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%82%92%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97%E3%81%AB%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)
  - [Tailscale sshの実行](#tailscale-ssh%E3%81%AE%E5%AE%9F%E8%A1%8C)
    - [VSCodeを介したssh接続](#vscode%E3%82%92%E4%BB%8B%E3%81%97%E3%81%9Fssh%E6%8E%A5%E7%B6%9A)
    - [`.ssh/config`ファイルの設定](#sshconfig%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [SSH Agent Forwarding機能](#ssh-agent-forwarding%E6%A9%9F%E8%83%BD)
    - [Access Control Listsを用いたSSHログインユーザーの制限](#access-control-lists%E3%82%92%E7%94%A8%E3%81%84%E3%81%9Fssh%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%81%AE%E5%88%B6%E9%99%90)
- [Tailscaleにおけるuser switching](#tailscale%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Buser-switching)
    - [Tailscale accountをswitchする場合](#tailscale-account%E3%82%92switch%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)
- [Appendix: 用語整理](#appendix-%E7%94%A8%E8%AA%9E%E6%95%B4%E7%90%86)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## 記事のスコープ

- Ubuntu 24.04 LTS, 22.02 LTSにおけるTailscaleのインストール
- Ubuntu 24.04 LTS側をssh host serverとしてTailscale sshを実行する

## Tailscaleの仕組み

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>サービスとしてのTailscale</ins></p>

- Tailscaleとは，tailnetとよばれる[WireGuard protocol](https://www.wireguard.com/)を用いたP2P型仮想プライベートネットワーク(VPN)を提供してくれるサービスのこと
- P2P型VPN(=VPNサーバーで通信を集中制御していない)のため，tailscale利用者の同時接続数の影響によって通信速度が落ちるような心配がない特徴がある

|Traditional VPN(hub and spoke型)|Tailnet|
|---|---|
|<img alt="traditionalvpn" src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/ssh/20240610_traditional_vpn.png?raw=true">|<img alt="tailnet" src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/ssh/20240610_tailscale_vpn.png?raw=true">|


</div>


Tailscaleでは，ネットワークに参加しているnodes同士を直接結んでいます，このネットワークのことをmesh networkと呼びます．
Tailscaleではこの独自ドメインメッシュネットワークでP2P通信をするので，

- スループットが向上
- レイテンシーが低下
- 分散化により単一障害点が減少するため，安定性と信頼性が向上

一方，mesh netowrkでは10個のnodesが存在する時，

- connectionsは$10 \times 9 \div 2 = 45$個
- endpointsは90個
- 各nodeは自分のキーと他のnodesのキーの合計10個をデータとして管理する必要がある
- node間通信時において通信相手の各nodeの対応したfirewallルールの管理の必要性

以上の点を管理する必要が有ります．このようなnetwork configurationはTailscale側で負担してくれるので，ユーザーが意識する認証はTailscaleの認証のみとなり，細かいところはACL(access control lists)で設定します．


### Tailscale SSH

Tailscale SSHでは，ailscaleがTailscaleネットワークからのSSH接続のためにポート22を利用します．Tailscale SSHを実行する際，内部的に以下の処理をTailscaleは実行しています：

- WireGuardを使用して接続を認証および暗号化
- Tailscaleノードキーを利用してSSH接続を作成

ポイントとして，Tailscale SSH作成後はさらなる認証(authentication)は要求されずにそのままssh接続することができます．また，`/etc/ssh/sshd_config`や`~/.ssh/authorized_keys`といったssh config fileは影響を受けません．つまり，`~/.ssh/`以下に通常配置されるssh keyがなくてもssh接続をすることができます．

注意点としては以下，

- SCPやSFTPは実行可能ですが，普通のssh接続と異なり2024-06-08時点ではX11 forawrdingはできない．．．
- Linux or macOSのみssh host serverになれる


## Install Tailscale

ここで紹介するInstall手順はTailnetに接続したいデバイス全てに対して実行します．各OSそれぞれに対応したインストール手順は[こちら](https://tailscale.com/kb/1347/installation)を参照してください．以下ではUbuntuにフォーカスしたインストール手順を紹介します．

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>手順</ins></p>

1. （もしないなら）curlコマンドをインストールする
2. https://tailscale.com/install.sh のスクリプトを実行する

</div>

まず，`curl`コマンドをインストールします


```zsh
% sudo apt install curl
```

続いて，Linuxでは以下のコマンドでtailscaleをインストールします

```zsh
% curl -fsSL https://tailscale.com/install.sh | sh
Installing Tailscale for ubuntu jammy, using method apt
+ sudo mkdir -p --mode=0755 /usr/share/keyrings
[sudo] password for kirakira-bushi: 
```

その後，インストールが完了すると以下の画面が表示されます．

```zsh
Installation complete! Log in to start using Tailscale by running:

sudo tailscale up
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: curlコマンドのオプション</ins></p>

`curl`コマンドはURLを指定してファイルをダウンロードする際に使用するコマンドです．

|short option|long option|説明|
|---|---|---|
|`-o`|`--output ファイル名`|保存するファイル名（指定しない場合は標準出力）|
|`-f`|`--fail`| 失敗してもエラーメッセージを表示しない|
|`-s`|`-silent`|実行中のメッセージを表示しない|
|`-L`|`–location`| 要求したページにリダイレクトが掛かっていた場合に追従する|

</div>


### Tailscaleのuninstall

UbuntuやDebian versionsでは，`apt-get`を用いてuninstallします

```zsh
% sudo apt-get remove tailscale
```

上記だけでは，Tailscale IP addressなどのlocal側の情報が残ってしまっているので，完全に削除する場合は以下のファイルの削除も行います

```zsh
% rm /var/lib/tailscale/tailscaled.state
```

上記実行後に再度デバイスにTailscaleをインストールすると，新しいIPアドレスが割り当てられます．


## Tailscale SSH接続前準備

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>作業手順</ins></p>

1. SSH host server側でのTailscaleのインストールとssh hostの立ち上げ
2. client側でのTailscaleセットアップ(基本的にはインストールのみ)
3. Access rulesの設定

</div>

ミニマムでssh接続を実現したい場合は上記1，2の手順を実施するのみですが，ssh host serverのログインユーザーの制限をしたい場合は手順3の実施が必要となります．

### SSH host server側でのTailscaleのセットアップ

上で紹介したインストール及び認証手順が完了した後, Advertise SSH on the hostという工程が必要です．これは，nodeがssh host serverになりますという宣言に相当する工程です．コマンドでは以下を実施，

```zsh
% tailscale up --ssh
```

このコマンドの効果の詳細は以下です

- host keyparirを生成
- 生成したhost keypairのうち，の公開鍵をTailscaleと共有し，tailnet上の各クライアントに配布
- Tailscale IPアドレスのポート22にルーティングされるtailnetからのすべてのトラフィックを `tailscaled`(daemonみたいなもの)がインターセプトできるようにする

このコマンドはhost serverにつき，一回入力すれば完了です，


### Client側でのTailscaleセットアップ

Client側もTailscaleをインストールします．インストール後，authenticationが必要となります．

```zsh
% sudo tailscale up
```

を実行すると以下のような表示が現れます．

```zsh
To authenticate, visit:

	https://login.tailscale.com/a/hogehogehogehoge
```

実施後は，Tailnetに参加している状態となります．参加状態を確認するためには `tailscale status` コマンドを入力します.

```zsh
% tailscale status
100.xxx.xxx.xxx    kirby-desktop kirakirabushi@ linux   -
100.xxx.xxx.xxx    dev-machine kirakirabushi@ linux   -
```

ほかのデバイスが参加している状態ならばそのデバイス一覧が確認できるはずです．


Tailscaleからdisconnectしたい場合は

```zsh
% sudo tailscale down
```

再接続の場合は，`tailscale up`をもう一度実行します．


#### Block incoming connections

Tailscaleに接続した時，デフォルトでは

- Allow incoming connections
- Tailscale DNSの有功

という設定になっています．Client側では少なくとも前者の設定はいらないので

```zsh
% sudo tailscale up --shields-up
```

と実行することが推奨されます．Tailscale DNS設定を利用しない場合は

```zsh
% sudo tailscale up --accept-dns=false
```

設定内容を確認したい場合は，`tailscale debug prefs`で確認することができます．


## SSH接続の実行

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>作業手順</ins></p>

1. Tailnetを介したnodes間の疎通確認
2. SSH hostserver側でのユーザー設定
3. Tailscale sshの実行

</div>

### Tailnetを介したnodes間の疎通確認

各デバイスのTailnetへの接続状況は `tailscale status`で確認することができますが，実際に疎通できるかは

- `tailscale ping`
- `nmap`コマンド

のいずれかの方法で確認できます．

`ping`コマンドでも確認することできますが`tailscale ping`で簡潔に以下のように確認できます．

```zsh
% tailscale ping 100.xxx.xxx.xxx

pong from kirakirabushi-server (100.xxx.xxx.xxx) via xxx.xxx.xxx.xxx:yyyy in 2ms
```

より詳細な状態を確認したい場合は，`nmap`コマンドを以下のように用います．

```zsh
% nmap 100.xxx.xxx.xxx
Starting Nmap 7.80 ( https://nmap.org ) at 2024-06-09 03:18 JST
Nmap scan report for kirakirabushi-server.tail0pkk5.ts.net (100.xxx.xxx.xxx)
Host is up (0.013s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
```

### SSH hostserver側でのユーザー設定

ssh接続を行うためには予めユーザーがホストサーバー側で作成されている必要が有ります．Linuxでは大きく分けるとユーザーは以下３つあります

|ユーザー区分|説明|
|---|---|
|スーパーユーザー|システム唯一の特権ユーザー，すべてのアクセス制御を無視することができる<br>ユーザー名: root, ユーザーid: 0と決まっている|
|システムユーザー|各種サーバープログラムやシステムプログラムの実行に利用されるユーザー，ユーザーIDは主に1~99の範囲で割り当てられる|
|一般ユーザー|システムの一般利用者，ユーザーIDは1000以降が割り当てられる（初めてのユーザーなら1000）|


#### ユーザーの作成

ユーザーを作成する場合は `adduser`コマンドを使います．

- ホームディレクトリの雛形ディレクトリは`/etc/skel/`
- ユーザー作成時に参照する設定ファイルはデフォルトでは`/etc/adduser.conf`

という特徴が有ります．ユーザー作成時の段階からデフォルトのloginシェルをzshに変更したい場合は，`/etc/adduser.conf` 設定ファイルを変更する形でもできます．

```zsh
% adduser <username who you want to create>
```

|オプション|説明|
|---|---|
|`--no-create-home`|ホームディレクトリが存在しない場合でも新規作成しない|
|`--uid ユーザーID`|新規作成時のユーザーIDを指定する（指定しない場合，他と重複しない値を自動で設定する|
|`--conf ファイル名`|デフォルトの設定ファイル（`/etc/adduser.conf`）以外の設定ファイルを指定する|

ユーザー作成後は, `id <作成ユーザー名>`で念の為作成結果を確認することが推奨されます．実行時に，`fatal: Only root may add a user or group to the system.`というエラーが出た場合，

```zsh
% sudo adduser <username who you want to create>
```

と`sudo`コマンドを用いて実行してください．誤ったユーザーを作成してしまった場合は

```zsh
% iserde; -r <username>
```

`-r`オプションを付与することで，ユーザー削除時にホームディレクトリも合わせて削除することができます．


<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#ffa657; background-color:#F8F8F8'>
<strong style="color:#ffa657">注意 !</strong> <br> 

Ubuntuでは`adduser`と似た名前のコマンドとして`useradd`コマンドが有りますが，デフォルトではホームディレクトリが作成されません．誤って`useradd`でユーザーを作成しホームディレクトリの作成の必要が出てきたならば

```zsh
% mkhomedir_helper <username> 
```

コマンドを実行します．`Desktop`や`Downloads`といったX-relatedフォルダーはGUIログインのときに自動的に作成されます．

</div>


#### ユーザーをグループに追加する

作成したユーザーに`sudo`実行権限を付与したい場合，作成したユーザーを`sudo`グループに追加するのが基本方針となります．やり方は大きく２つあり

- ユーザー作成時に`sudo`グループに追加する
- ユーザー作成後に，改めて`sudo`グループに追加する

```zsh
# ユーザー作成時に`sudo`グループに追加する場合
% adduser <username> <groupname>

# ユーザー作成後に，改めて`sudo`グループに追加する: gpasswdの場合
% gpasswd -a <username> <groupname>

# ユーザー作成後に，改めて`sudo`グループに追加する: usermodの場合
% usermod -G <groupname> <username>
```

上記実行後は，`groups <username>`でグループ所属状況を確認できます．


### Tailscale sshの実行

`ssh`コマンドの利用の仕方は通常のOpenSSHクライアントコマンドと同様に

```zsh
% ssh <username>@<hostname>
```

でログインすることができます. ログアウトする場合は

- `exit`コマンド
- `ctrl` + `D`

のいずれかで抜けることができます．

#### VSCodeを介したssh接続

Remote-ssh機能を利用することでGUI操作でssh接続先を開くことができますが, 以下のようにコマンドでssh先directoryを対象に
直接workspaceを開くこともできます


```zsh
% code --folder-uri "vscode-remote://ssh-remote+<ssh接続名>/<path>" 
```

個人では以下のようなスクリプトを組みました：

```bash
#!/bin/bash
## open a directory at the ssh server as a vscode workspace
## Author: Ryo Nakagami
## Revised: 2024-06-25
## REQUIREMENT: code + ssh setup

set -eu

function usage {
    cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -h                   Display help
  -s sshconfig_name    reference .ssh/config hostname
  -r directory         relative-path directory
  -a directory         abolute-path directory
EOM

    exit 2
}

while getopts ":s:r:a:h" optKey; do
    case "$optKey" in
    s)
        SSH_CONFIG="${OPTARG}";
        USER_ROOT=$(ssh -G ${SSH_CONFIG} | grep ^"user "| sed 's/user //')
        ;;
    r)
        RELATIVE_TARGET_DIRECTORY="${OPTARG}"
        TARGET_DIRECTORY="/home/${USER_ROOT}/${RELATIVE_TARGET_DIRECTORY}/"
        ;;
    a) 
        TARGET_DIRECTORY="${OPTARG}";
        ;;
    '-h' | '--help' | *)
        usage
        ;;
    esac
done

code --folder-uri "vscode-remote://ssh-remote+$SSH_CONFIG$TARGET_DIRECTORY" 
```


#### `.ssh/config`ファイルの設定

`~/.ssh/config`にssh接続のときに参照するパラメータを設定できます

```                        
# yushima ml server connection
Host kirbyserver
    Hostname tmp-kirbyserver
    User kirakira-bushi
    ForwardAgent yes
    RequestTTY yes 
```

上記のように設定すると以下のコマンドは`ssh kirakira-bushi@tmp-kirbyserver`の代わりに

```zsh
% ssh kirbyserver
```

だけでアクセスできるようになります. `ForwardAgent yes`はSSH 先のホストでSSH公開鍵認証を利用して GitHub にアクセスするための設定となります．

#### SSH Agent Forwarding機能

SSH Agent Forwarding 機能を使うと，ssh-agentを介して，秘密鍵をローカルPCに置いたまま，ログイン先のサーバーからさらに別のサーバーにログインすることもできます．

事前に `ssh-add`コマンドを用いてssh-agentに秘密鍵を登録する必要が有ります．

```zsh
% ssh-add ~/.ssh/<ssh private key>
Enter passphrase for ~/.ssh/<ssh private key>: 
Identity added: ~/.ssh/<ssh private key> (hogehoge@foo.com)
```

例として，上記の手順を踏んでGitHub用の秘密鍵を登録した後に，ssh接続先で以下のコマンドを叩いて接続確認してください．

```zsh
% ssh -T git@github.com
Hi hoshinokirby! You've successfully authenticated, but GitHub does not provide shell access.
```



#### Access Control Listsを用いたSSHログインユーザーの制限

TailscaleのAccess Controlsを用いると, ユーザーグループや接続先に応じたログインユーザーの設定ができます．
個人で使用する範囲では必要ない機能ですが，知人を簡易的に自分のネットワークに招待するときに使用したりします．

設定のポイントとしては２つ

- `groups`を作成する
- `groups`に対応した`ssh`ルールを作成する


```json
{
    "groups": {
	"group:admin": ["kirakirabushi@hoge.com"],
	"group:dev":   ["dedede@daioh.com"],
	},

    "tagOwners": {
	"tag:pupupuserver": ["autogroup:admin"],
	"tag:devserver": ["group:dev"],
	},

    "ssh": [
	// Allow all users to SSH into their own devices in check mode.
	// Comment this section out if you want to define specific restrictions.
	{
		"action": "accept",
		"src":    ["group:admin"],
		"dst":    ["tag:pupupuserver"],
		"users":  ["autogroup:nonroot", "root"],
	},
	{
		"action": "check",
		"src":    ["group:dev"],
		"dst":    ["tag:pupupuserver"],
		"users":  ["ubuntu-daioh"],
	},
	],
}
```

上のACLでは次のような設定をしています

- `kirakirabushi@hoge.com`はadmin
- `dedede@daioh.com`はdevというグループに配属
- devグループのユーザーは`pupupuserve`にアクセスするときに`ubuntu-daioh`というusernameしか接続することができない

|ACL設定項目|説明|
|---|---|
|`action`|`accept`:tailnet上ですでに認証されたユーザーからの接続を受け入れる<br>`check`:ユーザーに定期的な再認証を要求する|
|`src`|ssh接続元, `user:dedede@daioh.com`のようにユーザーを直接指定することができる|
|`dst`|ssh接続先|


## Tailscaleにおけるuser switching

Tailscaleは一つのデバイスで同時に複数のアカウントでloginすることはできない(=１時点に一つのアカウントのみ)ですが，userの切り替えは簡単に実施することができます．

swithcingの際にre-authenticationは要求されないですが以下の場合は要求されます

- 使用しているデバイスから初めてloginする場合
- デバイスのtailnet node keyが期限切れの場合


#### Tailscale accountをswitchする場合

`tailscale login`コマンドを実行することでaccount switchすることができます．


```zsh
% sudo tailscale login
[sudo] password for kirakirabushi: 

To authenticate, visit:

	https://login.tailscale.com/a/hogehoge

```

Activeアカウント一覧は`tailscale switch --list`で確認することができます．
Activeアカウントに対してニックネームを以下のようにつけることができます．

```zsh
% tailscale set --nickname=work
```

すると `sudo tailscle switch work`で`work`ニックネームのアカウントに切り替えることができます．


## Appendix: 用語整理

|Terminology |説明|
|---|---|
|Authentication| ユーザー認証のこと．いわゆる「check who you are」のプロセス|
|Authorization| ユーザー認証のをベースに，ユーザーに対して認可するリソースやアクションを決定するプロセス|
|Firewall|ファイアウォールは，2つのポイント間で通過できるネットワークトラフィックを制限します．ファイアウォールには，ハードウェアベースのものとソフトウェアベースのものがあります．Tailscaleには，ドメインのアクセスルールによって定義される組み込みのファイアウォールが含まれています．|
|MagicDNS|Tailscaleネットワーク内のデバイスに対して人間が覚えやすいホストネームを割り当てる機能|
|Node(Tailscale)|ユーザーとデバイスの組のこと|
|Peer|コミュニケーション先のNodeのこと．Peerは同じdomain，異なるdomainの両方のケースがあり得る．|
|SSO|Single sign-onの略．SSOはユーザーが別のサイトの認証情報を使用して1つのサイトにログインできるようにする仕組み．|


References
----------
- [What is Tailscale?](https://tailscale.com/kb/1151/what-is-tailscale)
- [Tailscale SSH](https://tailscale.com/kb/1193/tailscale-ssh)