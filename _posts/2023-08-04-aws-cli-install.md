---
layout: post
title: "AWS CLI setup"
subtitle : "Getting used to AWS Service 2/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-09-25
tags:

- aws
- cloud

---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [AWS CLIとは？](#aws-cli%E3%81%A8%E3%81%AF)
- [How to Install AWS CLI](#how-to-install-aws-cli)
  - [How to uninstall AWS CLI](#how-to-uninstall-aws-cli)
- [Simple configuration](#simple-configuration)
  - [複数profileの設定](#%E8%A4%87%E6%95%B0profile%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>



## AWS CLIとは？

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: AWS Command Line Interface</ins></p>

- AWSコマンドラインインターフェース（AWS CLI）は, コマンドラインシェルでコマンドを使用してAWSサービスと対話するためのオープンソースのツール
- AWS CLIを使用することで, ブラウザベースのAWS管理コンソールで提供される機能と同等の機能をターミナルプログラムのコマンドプロンプトから実行できるようになる

</div>

> Example

```zsh
## install versionの確認
% aws --version
aws-cli/2.13.21 Python/3.11.5 Darwin/20.6.0 exe/x86_64 prompt/off

## S3 hogehogeからcurrent directoryへのファイルのsync
% aws s3 sync "s3://hogehoge/" ./ --dryrun
```

## How to Install AWS CLI

- AWS CLIのインストールはLinuxならば`.zip`, MacOSならば`.pkg`というようにインストーラを直接用いてインストールする形式を取る
- RPMやdebなどのパッケージ管理システムによってシステムに管理されないコマンドということになるので, コマンドの格納先は`/usr/local/bin`となる

Linux x86の場合を想定して以下解説する

> Pre-requisites

- パッケージの取得と解凍に`curl`と`unzip`
- Python 3 version 3.3+ installed
- AWS CLIの依存コマンドとして `glibc`, `groff`, `less`

> Install

```zsh
# current directoryにawscliv2.zipを取得
% curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# awscliv2.zipの解凍
% unzip awscliv2.zip

# install: デフォルトではaws commandを/usr/local/binへ, installerを/usr/local/aws-cliへ格納する
% sudo ./aws/install
```

commandのインストール先を確認してみると

```zsh
% which aws
/usr/local/bin/aws

% ls -l /usr/local/bin/aws
lrwxrwxrwx 1 root root 49 Oct 22 09:49 /usr/local/bin/aws -> /usr/local/aws-cli/v2/current/bin/aws*
```

> Update

updateの実行手順は以下:

- インストーラーを新たにダウンロードし `./aws/install`の内容をupdate
- その後, `--update`を用いて`sudo ./aws/install`を実行する

```zsh
# 余計なファイルを削除
% rm -r ./aws/install

# 新たにインストーラーを取得
% curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
% unzip awscliv2.zip

# update optionを用いてupdate
% sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```

### How to uninstall AWS CLI

install先情報を`rm`するだけでよいです. AWS SDKやAWS CLI settingsといったconfig情報も消去したい場合は, デフォルトでは`~/.aws/`を消去するので足ります.

```zsh
## コマンド格納場所を確認する
% which aws
% ls -l /usr/local/bin/aws

## which awsで確認したbin-dirを消去する
% sudo rm /usr/local/bin/aws
% sudo rm /usr/local/bin/aws_completer

## ls -lで確認したinstall-dirを削除する
% sudo rm -rf /usr/local/aws-cli

## delete AWS SDK and AWS CLI settings
% sudo rm -rf ~/.aws/
```

## Simple configuration

AWS CLIを利用するためにはconfigureを設定する必要があります. `aws configure`コマンドを用いて対話的に設定することが一番シンプルです.
事前準備として, 

- access key ID
- AWS secret access key

の２つが必要となります. これらが準備できたら以下のように対話式で設定することが可能です.

```zsh
% aws configure 
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE 
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY 
Default region name [None]: us-west-2 
Default output format [None]: json
```

なお, これら設定は`~/.aws/`以下の

- credential
- config

の２つのファイルに内容が結局は格納され, それらを参照してるだけなので直接上記を設定するだけでも足ります.

### 複数profileの設定

同時並行のprojectがあるとき, projectごとで簡単に切り替えながらAWS CLIを利用したい場合があります.
AWS CLIは設定内容を複数の**profile**で分けて登録することができるので, これを利用します.

AWS CLI設定ファイルは以下の形を想定しています:

|ファイル名|説明|
|---|---|
|`config`|IAM user-sepecificな設定を格納|
|`credentials`|aws access keyとsecret keyの設定|

```zsh
% tree
~/.aws
├── cli
│   └── cache
├── config
└── credentials
```

`credentials`の設定は以下を想定しています. `hogehoge`の部分は任意の文字列で設定して構いません.

```
[hogehoge]
aws_access_key_id = <your access key id>
aws_secret_access_key = <your secret access key>
```

`config`ファイルは場面に応じて`credentials`の設定にIAMロールを付与設定をしたい場合に使用します.
例として以下です.

```
[profile hogehogedmondai]
region = ap-northeast-1
output = text
source_profile=hogehoge

[profile foofoocampaign]
region = ap-northeast-1
output = text
role_arn=arn:aws:iam:123456773456:role/foofoocampaign
source_profile=hogehoge
```

このように設定することで, IAMロールを一時的にassumeしないと見れないS3バケットに対しても以下のコマンドでアクセスすることができます

```zsh
% aws s3 ls "s3://foofoocampaign/ponpokoko/"
```


References
--------------

- [AWS Command Line Interface Documentation](https://docs.aws.amazon.com/cli/)