---
layout: post
title: "AWS Identity and Access Management"
subtitle : "Getting used to AWS Service 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-09-25
tags:

- aws
- cloud

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [AWS Identity and Access Management](#aws-identity-and-access-management)
  - [IAMの仕組み](#iam%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
  - [IAMグループ](#iam%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97)
- [IAMロール](#iam%E3%83%AD%E3%83%BC%E3%83%AB)
  - [AWS CLI で IAM ロールを使用する](#aws-cli-%E3%81%A7-iam-%E3%83%AD%E3%83%BC%E3%83%AB%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## AWS Identity and Access Management

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: AWS IAM</ins></p>

AWS Identity and Access Management (IAM) は, AWSのリソースへのアクセスを管理するためのサービスのこと.
IAMを使用することで,

- 認証(Athetification): 誰が環境にアクセスできるか
- 認可(Authorization): 認証されたユーザーがどのような権限を持つか？

といったきめ細かいアクセス許可を一元管理する事が可能となる

</div>

IAMを用いることで, AWSにアクセスできるIAMユーザーやIAMグループ, IAMロールをAWSアカウントは定義することができます.
ここで注意が必要なのは「**IAMユーザーは個別のアカウントではなく, アカウント内のユーザー**」であることです.
AWS CLIやSDKを利用してAWSサービスを操作するときは, 基本的にはIAMユーザーを利用します.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: AWSアカウントとIAMユーザー</ins></p>

- AWSアカウント
- IAMユーザー

の２種類のアカウントがAWSではあります. AWSアカウントは, AWSへサインアップするときに作成されるアカウントのことで, 
AWSのすべてのサーのスをネットワーク上のどこからでも利用可能なため, ルートアカウントとも呼ばれます. 
ルートアカウントは権限が非常に強力なので, **AWSアカウントの利用は極力避け, IAMユーザーを利用することが推奨**されます

</div>

### IAMの仕組み

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/aws/20230803-aws-iam-structure.png?raw=true">

human userまたはアプリケーションがサインイン認証情報を使用して AWS と認証. 認証は、サインイン認証情報を AWS アカウント が信頼するプリンシパル (IAM ユーザー、フェデレーションユーザー、IAM ロール、またはアプリケーション) と照合することによって行われるれます.

次に、プリンシパルにリソースへのアクセスを許可するリクエストが行われます. アクセスは承認リクエストに応じて許可されます.
例えば, コンソールに初めてサインインしてコンソールのホームページを開いたときは, 特定のサービスにアクセスしているわけではありません. 

- サービスを選択すると, 承認リクエストがそのサービスに送信さる
- ユーザーの ID が認証されたユーザーのリストに含まれているかどうか, 付与されるアクセスレベルを制御するためにどのようなポリシーが適用されているか確認

という流れで承認が決定されます. 承認されると, プリンシパルはユーザー内の AWS アカウント リソースに対してアクションを実行したり, 操作を実行したりできます(例: S3でのバケットの作成やlocalとのsyncなど).

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Principal</ins></p>

プリンシパルとは, AWS リソースに対するアクションまたはオペレーションをリクエストできるIDまたはワークロードです. 
認証後, プリンシパルにはプリンシパルのタイプに応じて, AWS にリクエストを行うための永続的または一時的な認証情報を付与できます. 

- IAM ユーザーとルートユーザー: 永続的な認証情報が付与される
- IAMロール: 一時的な認証情報が付与される

という違いがあります. 

</div>

### IAMグループ

- IAMグループは同じ権限を持ったユーザーの集まり
- IAMグループ自体は, AWSへのアクセス認証情報は保持せず, 認証自体はあくまでユーザー単位で行う
- IAMグループの目的は権限を容易に, かつ正確に管理すること

複数のユーザーに同一の権限を個別に与えると, 権限付与漏れや過剰付与などミスが発生する可能性が高くなるので,
Linuxにおけるグループと同じようにまとめて管理することを可能にした機能と理解できます. 1つのユーザーに対して複数のグループを割り当てることもできますが, 
グループ自体を階層化して管理するということはできません.


## IAMロール

IAMロールは永続的な権限を保有するIAMユーザーやIAMグループと異なり, 一時的にとあるIAMユーザーに
**一時的にAWSリソースへアクセス権限を付与する場合などに使用します**. 

|ロールの使い方|状況|
|----|---|
|AWSリソースへの権限付与|インスタンス作成時にロールを付与することでEC2インスタンス上で稼働するアプリに一時的にAWSリソースへアクセス権限を与える|
|クロスアカウントアクセス|複数のAWSアカウント間のリソースを１つのアカウントで操作するときに使用|
|IDフェデレーション|社内サーバに登録されているアカウントにAWSリソースアクセスを許可する場合|
|Web IDフェデレーション|SNSアカウントを使用してAWSリソースアクセスを許可する場合|


### AWS CLI で IAM ロールを使用する

IAMロールを使用するようにAWS CLIを設定するには、`~/.aws/config`ファイルでIAMロールのプロファイルを定義する必要があります.
ただし, 個別のプロファイルを設定する形で対応することが推奨です.

- credential fileで`user1`と設定されてたprofileを利用
- Amazon リソースネーム (ARN) `arn:aws:iam::123456789012:role/marketingadminrole`のロールを引き受ける

という条件でロールプロファイルを設定する場合は`~/.aws/config`ファイルで以下のように設定します

```
[profile hoohoo]
role_arn = arn:aws:iam::123456789012:role/marketingadminrole
source_profile = user1
```

上記の設定をすることでAWS CLI はリンクされた `user1` プロファイルの認証情報を自動的に検索し, それらを使用して, 指定された IAM ロールの一時的な認証情報をリクエストします.
CLI では, バックグラウンドで `sts: AssumeRole` オペレーションを使用してこれを実現します.

利用方法としては, `--profile` optionで設定したprofileを参照することで, IAMロールを使用することができます. 例として, 

```zsh
% aws s3 ls --profile marketingadmin
```






References
------------

- [AWS Command Line Interface > AWS CLI で IAM ロールを使用する](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-role.html)