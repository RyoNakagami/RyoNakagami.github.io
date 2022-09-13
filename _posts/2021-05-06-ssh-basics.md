---
layout: post
title: "SSH(Secure Shell)の基礎知識"
subtitle: "VSCodeを用いたSSH接続設定まで"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-09-03
tags:

- Linux
- VSCode
---

> 技術スペック

---|---
OS | ubuntu 20.04 LTS Focal Fossa
CPU| Intel Core i7-9700 CPU 3.00 GHz


**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [SSHの仕組み](#ssh%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [SSHとは？](#ssh%E3%81%A8%E3%81%AF)
  - [ホスト認証](#%E3%83%9B%E3%82%B9%E3%83%88%E8%AA%8D%E8%A8%BC)
  - [ユーザー認証](#%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E8%AA%8D%E8%A8%BC)
- [クライアント目線からのssh接続](#%E3%82%AF%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E7%9B%AE%E7%B7%9A%E3%81%8B%E3%82%89%E3%81%AEssh%E6%8E%A5%E7%B6%9A)
  - [sshコマンド](#ssh%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [ssh-keygenコマンドによる認証鍵生成](#ssh-keygen%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AB%E3%82%88%E3%82%8B%E8%AA%8D%E8%A8%BC%E9%8D%B5%E7%94%9F%E6%88%90)
    - [接続先ホストへの公開鍵登録](#%E6%8E%A5%E7%B6%9A%E5%85%88%E3%83%9B%E3%82%B9%E3%83%88%E3%81%B8%E3%81%AE%E5%85%AC%E9%96%8B%E9%8D%B5%E7%99%BB%E9%8C%B2)
  - [sshpassコマンド](#sshpass%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
- [接続先ホストとクライアント間のファイル転送: scp コマンド](#%E6%8E%A5%E7%B6%9A%E5%85%88%E3%83%9B%E3%82%B9%E3%83%88%E3%81%A8%E3%82%AF%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E9%96%93%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E8%BB%A2%E9%80%81-scp-%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [実践編](#%E5%AE%9F%E8%B7%B5%E7%B7%A8)
- [VS CodeとGCEへのSSH接続](#vs-code%E3%81%A8gce%E3%81%B8%E3%81%AEssh%E6%8E%A5%E7%B6%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## SSHの仕組み
### SSHとは？

SSH(Secure SHell)は, ネットワークで接続された他コンピューターを遠隔操作するためのプロトコルです.
強力な認証機能と暗号化により, ファイル転送やリモート操作を安全に行うことができます. 

またSSHでは, ユーザーログイン時のユーザー認証に先立って, クライアントがサーバーの正当性を確認する
ホスト認証が行われます. 接続先サーバーが偽サーバーでないか毎回接続時に確認するので, 偽サーバーに接続することで発生する
情報漏えいを防ぐことができるというメリットがSSHにはあります.

SSHプロトコルには現在, SSH1とSSH2という２つのプロトコルがあります.
それぞれのプロトコルには互換性はありません. 一般的には, SSH1プロトコルには脆弱性が発見されているのでSSH2を用います.
Ubuntu Serverでは, デフォルトでSSH2のみが有効となっています.

なおクライアント側から `ssh` コマンドを用いてSSH接続を試みる場合は, 接続先のコンピュータでsshd（SSH daemon：SSHのサーバプログラム）が
動作している必要があります. また, インターネット経由で接続する場合にはルーターなどで外部から接続できるように設定しておく必要もあります.

### ホスト認証

SSH接続を試みる際の認証は以下のような手順となります:

1. ホスト認証
2. ユーザー認証
    - 公開鍵認証
    - パスワード認証

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210506_ssh_protocol.png?raw=true">

ホスト認証鍵がクライアント側で登録したknown hostの鍵と一致しない場合は以下のようなエラーメッセージが出現します:

```zsh
% ssh ubuntu@12.3.4.56
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## VSCodeを用いたSSH開発環境



@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:tfZBzQ16o7O7SH6u4ixBmL061Sxz8DOo1cFZ9oMuGjE.
Please contact your system administrator.
Add correct host key in /home/hogehoge/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/hogehoge/.ssh/known_hosts:4
  remove with:
  ssh-keygen -f "/home/hogehoge/.ssh/known_hosts" -R "12.3.4.56"
ECDSA host key for 12.3.4.56 has changed and you have requested strict checking.
Host key verification failed.
```

> 初回SSH接続時のメッセージ

初回接続時の際は, 接続先サーバーのホスト認証鍵を持っていないので,接続先ホストが登録されていない旨のWarningが表示されます.
このとき, 接続をこのまま続けるか？と聞かれます. yesと選択すると, SSH接続先サーバーが`~/.ssh/known_hosts`に登録されます.

```zsh
% ssh hogehoge@123.456.78.9
The authenticity of host '123.456.78.9 (123.456.78.9)' can not be established.
ECDSA key fingerprint is SHA256:ghzvH/1TBjI0wvlYiRNDJvUsiYAX/R9eip5bw6+Rv10.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
$ yes
Warning: Permanently added '123.456.78.9' (ECDSA) to the list of known hosts.
Password:
Last login: Thu Apr 11 04:16:45 2021
```

上記における`ECDSA key fingerprintSHA256:ghzvH/1TBjI0wvlYiRNDJvUsiYAX/R9eip5bw6+Rv10`, の意味はSHA256で公開鍵をハッシュ化すると
`ghzvH/1TBjI0wvlYiRNDJvUsiYAX/R9eip5bw6+Rv10`というフィンガープリントが発行されることを指しています.

### ユーザー認証

ホスト認証後に実施されるユーザー認証は, デフォルトでは, 公開鍵認証, パスワード認証の順に実施されます.
公開鍵認証を行うには予めクライアントの公開鍵を接続先サーバーに登録する必要があります.

なおサーバー側でsshdの設定で

```
PubkeyAuthentication No
```

としていた場合は公開鍵認証なしでホスト認証後アクセスすることができます.
ただし, パスワード認証ではブルートフォース攻撃を受けることもあるので一般的には公開鍵認証をオンにします.


## クライアント目線からのssh接続

SSHを使ってサーバーに接続するには, 以下のように`ssh`コマンドを使います. 終了する場合は, `exit`を入力します.

```zsh
% ssh <username@><hostname>
```

### sshコマンド

> Syntax

```zsh
% ssh [option] <username@>接続先サーバー [コマンド]
```

> Option

---|---
`-p ポート番号` | 接続に使用するポート番号を指定する
`-l ユーザー名` | 接続に使用するユーザー名を指定する
`-i IDファイル` | 接続に使用する公開鍵ファイルを指定する
`-f` | コマンドを実行する際にsshをバックグラウンドにする（Xアプリケーションを実行する際に使用）
`-F 設定ファイル` | 設定ファイルを指定する

### ssh-keygenコマンドによる認証鍵生成

公開鍵認証を利用するためにはまず, `ssh-keygen`コマンドで公開鍵と秘密鍵の鍵ペアを作成する必要があります.

> Syntax & Options

```zsh
% ssh-keygen [option]
```

---|---
-t タイプ|暗号化タイプの指定
-l|鍵のフィンガープリントを表示する
-f ファイル名|鍵ファイルを指定する（生成または読み出すファイルを指定）
-R ホスト名|指定したホスト情報をknwon_hostsファイルから削除する
-C コメント|コメントを指定する（デフォルトは「ユーザー名@ホスト名」。「-C ""」でコメントを削除）

> 暗号化アルゴリズムの種類

|SSH version|ssh-keygenコマンド|
|---|---|
|SSH1 RSA|`ssh-keygen -t rsa1`|
|SSH2 DSA|`ssh-keygen -t dsa`|
|SSH2 RSA|`ssh-keygen -t rsa`|
|SSH2 ECDSA|`ssh-keygen -t ecdsa`|
|SSH2 ED25519|`ssh-keygen -t ed25519`|

> 鍵の生成

`ssh-keygen`コマンドを使うと

1. 鍵ファイル名の指定（そのまま`Enter`を入力するとデフォルトのファイル名となる）
2. パスフレーズの入力（特別な理由がない限り設定する）

が求められます. 特段の事情がない限り個人的には設定する方針としています.
なお生成される公開鍵には, デフォルトではユーザ名とホスト名がコメントとして記載されています(以下の例では`hoge@foofoo`)

```
% ssh-keygen -t ed25519                                           
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/hogehoge/.ssh/id_ed25519): hogehoge_ed25519
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in hogehoge_ed25519
Your public key has been saved in hogehoge_ed25519.pub
The key fingerprint is:
SHA256:MnM1r0IqwugnLCTEnSHjuPoTk7mdmSMExw+r5cOkrwQ hoge@foofoo
The key's randomart image is:
+--[ED25519 256]--+
|@+%.  o  o       |
|.o.Eo *  + S     |
|. o..oo +        |
|@+%.  o  o       |
| .oo=.= S =      |
|   ..B o + +     |
|    = * . o .    |
| o++o            |
|+B==.. ....      |
+----[SHA256]-----+
```

秘密鍵の作成後, 誤って内容が書き換わってしまうリスクを抑えるため, Permissionを`400`に設定しときます:

```
sudo chmod 400 id_ed25519
```

#### 接続先ホストへの公開鍵登録

鍵ペア作成後, 公開鍵を接続先ホストへ登録する必要あります. この時使われるコマンドが `ssh-copy-id`コマンドです.
なお, 初回登録時点では接続先ホストではパスワード認証によるログインが許可されている必要があります.

> Syntax

```
ssh-copy-id [-p ポート番号] -i 公開鍵ファイル名 [ユーザー名@]host
```

このコマンド実施時には接続先ホストのパスワード入力が求められます. 登録後はOpenSSHサーバーの設定を変更し,
パスワード認証を無効にすることが推奨されます.


### sshpassコマンド

sshpass(noninteractive ssh password provider)とは, sshコマンドでSSH接続を試みる際に要求されるログインパスワードを
事前に指定した方法でコマンドプロンプトへ渡し, 簡単にSSH接続を実現するCLI機能のことです.

ただし, `sshpass -p <password> ssh <usename@>接続先ホスト` という形で実行するとシステムユーザーによる`ps`コマンドで
パスワードがバレてしまうというリスクがあるので, 便利さの一方, セキュリティリスクがある点について留意が必要です.

> インストール方法

```zsh
% sudo apt install sshpass ## Ubuntu
```

Macだと以下のようなメッセージで怒られます.

```
#Error: No available formula or cask with the name "sshpass".
#We won't add sshpass because it makes it too easy for novice SSH users to
#ruin SSH's security.
```

それでもインストールしたい場合は, ソースから直接以下のような方法でインストールします:

```zsh
% wget http://sourceforge.net/projects/sshpass/files/latest/download -O sshpass.tar.gz
% tar -xvf sshpass.tar.gz
% cd sshpass-1.08
% ./configure
% sudo make install 
% which sshpass ##pathが通っているか確認
```

> How to Use sshpass command

まずヘルプコマンドで利用方法を確認してみます:

```
% sshpass -h
Usage: sshpass [-f|-d|-p|-e] [-hV] command parameters
   -f filename   Take password to use from file
   -d number     Use number as file descriptor for getting password
   -p password   Provide password as argument (security unwise)
   -e            Password is passed as env-var "SSHPASS"
   With no parameters - password will be taken from stdin

   -P prompt     Which string should sshpass search for to detect a password prompt
   -v            Be verbose about what you're doing
   -h            Show help (this screen)
   -V            Print version information
At most one of -f, -d, -p or -e should be used
```

```
% sshpass -p '<passphrase>' ssh username@host 
```

という形で利用することもできますが, `ps`コマンドでpassphraseがダダ漏れになってしまうので

```
% sshpass -f <configfilepath> ssh username@host
```

または, `-e`オプションを指定することで環境変数`SSHPASS`を参照することができるので

```
% export SSHPASS='my_pass_here'
% echo $SSHPASS
% sshpass -e ssh username@host 
```

## 接続先ホストとクライアント間のファイル転送: scp コマンド

> Syntax

```
scp [オプション] コピー元 コピー先 
```

> コピー元,コピー先の書式

|引数|入力規則|
|---|---|
|コピー先|`username@hostname：PATH`|
|コピー元|`PATH`|

> Options

---|---
`-i 秘密鍵ファイル`| 	RSAまたはDSA認証の秘密鍵ファイルを指定する
`-P ポート番号`| 	ポート番号を指定する
`-p`| コピー元ファイルとディレクトリの更新時間、アクセス時間、パーミッションを保持したまま転送する場合
`-r` |	ディレクトリ内を再帰的にコピーする


### 実践編

> ローカルからリモートホストにファイル/ディレクトリをコピー

```zsh
## ファイルのコピー
% scp ~/tmp/file1 user@192.168.10.1:/home/user/tmp/ 

## ディレクトリのコピー
% scp -r ~/tmp user1@192.168.10.1:/home/user/tmp

## sshpassとの組合せ
% sshpass -f passwordFile scp ~/tmp/file1 user@192.168.10.1:/home/user/tmp/ 
```

> リモートホストからローカルにファイル/ディレクトリをコピー

```zsh
## ファイルのコピー
% scp user@192.168.10.1:/home/user/file1 ~/tmp
 
## ディレクトリのコピー
% scp -r user@192.168.10.1:/home/user/tmp ~/tmp
 
## 複数のファイルを、{}で囲んで「,」で区切り指定しコピーする例
% scp user@192.168.10.1:/home/user/{file1,file2,file3} ~/tmp
```

> リモートホストから別のリモートホストにファイル/ディレクトリをコピー

```zsh
% scp user1@192.168.10.1:/home/user/tmp/file1 user2@192.168.10.2:/home/user/tmp/
```

## VS CodeとGCEへのSSH接続

(後ほど)

## References

> オンラインマテリアル

- [sshpass: An Excellent Tool for Non-Interactive SSH Login – Never Use on Production Server](https://www.tecmint.com/sshpass-non-interactive-ssh-login-shell-script-ssh-password/)