---
layout: post
title: "GitLab開発環境設定 1/N"
subtitle: "個人アクセストークンの設定"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-04
tags:

- Ubuntu 20.04 LTS
- git
- GitLab
---



**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
- [Project用PersonalAccessTokenの設定](#project%E7%94%A8personalaccesstoken%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [作成手順](#%E4%BD%9C%E6%88%90%E6%89%8B%E9%A0%86)
  - [Cloneテスト](#clone%E3%83%86%E3%82%B9%E3%83%88)
- [Appendix](#appendix)
  - [SSH Keyの登録方法](#ssh-key%E3%81%AE%E7%99%BB%E9%8C%B2%E6%96%B9%E6%B3%95)
  - [ssh-keygenコマンドを用いた公開鍵,秘密鍵ペアの作成](#ssh-keygen%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E5%85%AC%E9%96%8B%E9%8D%B5%E7%A7%98%E5%AF%86%E9%8D%B5%E3%83%9A%E3%82%A2%E3%81%AE%E4%BD%9C%E6%88%90)
- [Referneces](#referneces)
  - [関連ポスト](#%E9%96%A2%E9%80%A3%E3%83%9D%E3%82%B9%E3%83%88)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題設定

- GitLab上のリソースにコマンドラインからclone, push, pullができるようにアクセス環境を整えたい
- Project用Personal Access Tokenを設定し, CLIからclone等ができるようにする


> アクセストークンって?

そもそもトークンとは,サーバがクライアントに対して有効期限が定義可能なトークンを発行し,APIリクエスト時に付随されたトークンを照合することでクライアントを認証するという仕組みのことです. GitLabにおけるアクセストークンとは,GitLab API, GitLab repository, GitLab registryへの各アクセスやCI/CDジョブからGitLabリソースへのアクセスの可否などを設定して発行されるトークンのことです.

GitLabにおいては発行できるアクセストークンの種類が複数あります. 公式ページが「GitLabにはパーソナルアクセストークンやプロジェクトアクセストークンや他にも何種類もアクセストークンがあります。どれを使ったらいいか悩みませんか?」って言っているくらいです.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220803-access-token-list.png?raw=true">


> なぜアクセストークンか？

GitLab上のGitリポジトリにアクセスする場合は, SSHの公開鍵認証方式も使用することができます.
しかし,社内ファイアウォール内部のマシンからだとSSHが使えない場合があったり,HTTPS経由でクローン/編集使用としても結局以下のようなエラーメッセージを言われ,アクセストークンを使いなさいとなる可能性があります.

それならば初めからアクセストークンで設定してしまいましょうという考えた次第です.

```
remote: You must use a personal access token with 'read_repository' or 'write_repository' scope for Git over HTTP.
remote: You can generate one at https://gitlab.com/profile/personal_access_tokens
fatal: Authentication failed for 'https://gitlab.com/my-test-project/example.git/'
```

> パスワード認証に対するアクセストークンの利点

GitLabのリソース(例:プロジェクト・リポジトリ・イシューなど)へのアクセスは通常,ウェブ画面からユーザー名とパスワードでログインしてウェブ画面でアクセスします. それに対してアクセストークンを利用するメリットは,セキュリティ目線で以下のことが挙げられます:

---|---
アクセス制限ができる|アクセストークンはAPI呼び出しのみや,Gitリポジトリへのアクセスのみなどのアクセス制限をかけられます.もしアクセストークンが漏洩した場合でも,パスワードと異なり,被害を軽減することができます.
個別に発行する|アクセストークンは外部サービスや開発ツールごとに個別に発行します.使わなくなったサービス・ツールなどのアクセストークンを個別に無効化し,確実にサービス・ツールからGitLabリソースへアクセスできないようにできます.パスワードで同じことをするためには,パスワードを変更し,継続して利用するサービスすべてのパスワードを更新する必要があります.
類推されにくい|アクセストークンはGitLabがランダムで十分な長さの安全なな文字列を発行します.人間が覚えなければならないパスワードと比べると,強度が高めです.
2FAが不要|今では安全のため多要素認証を有効にすることが求められます.アクセストークンによるアクセスではこの2FAが不要です.

## Project用PersonalAccessTokenの設定
### 作成手順

1. GitLabのトップメニューの右側のユーザーアイコンから,Preferencesをクリックします
2. 左のサイドメニューのアクセス トークンを選択します
3. Token nameにわかりやすい名前を入力します
4. 必要に応じて有効期限を設定します
5. Select scopesから必要な権限を選びます
6. Create personal access tokenをクリックして,アクセストークンを作成します

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220803-set-access-token.png?raw=true">

> REMARKS

- パーソナルアクセストークンが作成され,一度だけ表示されます
- アクセストークンをメモしたりせずに,CI/CD変数やアクセストークンを利用するツールに設定
- パーソナルアクセストークンは何度でも作成できるため,使い回しをせずに,都度作成

### Cloneテスト

> Syntax

```
git clone https://<USER_NAME>:<TOKEN>@<project-url>
```

上記で検証したところ無事git clone実行できた.


## Appendix
### SSH Keyの登録方法

GitLab公式ページから, `User Settings > SSH Keys`へアクセスして,公開鍵をTitleとExpiratiopn dateとともに入力してAdd keyボタンをクリックするだけで設定できます. 

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20220803-Gitlab-ssh.png?raw=true">

### ssh-keygenコマンドを用いた公開鍵,秘密鍵ペアの作成

ssh-keygenコマンドは「OpenSSH」で使う公開鍵と秘密鍵や,CA鍵を使った「証明書」と呼ばれるファイルを作成できます.

> Syntax

```
ssh-keygen -t <暗号化形式> -C "ユーザー名@ホスト名" -b <ビット数> -N 'パスフレーズ' -f <file_name>
```

> Example

```zsh
% ssh-keygen -t rsa -C "unko@gitlab.devsample.com" -b 4096 -N 'unkounko' -f id_rsa_unko_test
```

すると,``~/.ssh/`以下に公開鍵(`.pub`形式)と秘密鍵２つが生成されます

```
~/.ssh % ls
        id_rsa_unko_test.pub  id_rsa_unko_test
```

既存の公開鍵の確認は`cat`コマンドを用いて`cat id_rsa_unko_test.pub`とかで確認してください.

## Referneces
### 関連ポスト

- [Ryo's Tech Blog > GitとGitHubの設定](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/#%E6%96%B0%E3%81%97%E3%81%84-ssh-%E3%82%AD%E3%83%BC%E3%82%92%E7%94%9F%E6%88%90%E3%81%97%E3%81%A6-ssh-agent-%E3%81%AB%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)

### オンラインマテリアル

- [GitLab > GitLabのアクセストークンの安全な選び方・使い方](https://www.gitlab.jp/blog/2021/12/06/access-token/)