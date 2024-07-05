---
layout: post
title: "GitHubの設定"
subtitle: "GitとGitHubの設定 3/N"
author: "Ryo"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-07-06
header-mask: 0.0
header-style: text
tags:

- git
- ssh

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [GitとGitHubの違い](#git%E3%81%A8github%E3%81%AE%E9%81%95%E3%81%84)
- [GitHubの個人アカウントとの連携(非推奨)](#github%E3%81%AE%E5%80%8B%E4%BA%BA%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%A8%E3%81%AE%E9%80%A3%E6%90%BA%E9%9D%9E%E6%8E%A8%E5%A5%A8)
  - [新しい SSH キーを生成して ssh-agent に追加する](#%E6%96%B0%E3%81%97%E3%81%84-ssh-%E3%82%AD%E3%83%BC%E3%82%92%E7%94%9F%E6%88%90%E3%81%97%E3%81%A6-ssh-agent-%E3%81%AB%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)
  - [GitHub アカウントへの新しい SSH キーの追加](#github-%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%B8%E3%81%AE%E6%96%B0%E3%81%97%E3%81%84-ssh-%E3%82%AD%E3%83%BC%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [SSH 接続をテストする](#ssh-%E6%8E%A5%E7%B6%9A%E3%82%92%E3%83%86%E3%82%B9%E3%83%88%E3%81%99%E3%82%8B)
  - [ssh接続を使ったgit clone](#ssh%E6%8E%A5%E7%B6%9A%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%9Fgit-clone)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## GitとGitHubの違い

---|---
Git|ファイルやソースコードの変更を分散型でトラッキングする仕組み
GitHub|Gitで作成したリポジトリをホスティングするためのWebサービス<br>リポジトリ管理機能以外にDiscussion，Issue Tracking System，コードレビュー機能も提供

GitHubはGitレポジトリを管理する機能がコアなので，Gitの基本的知識がGitHub利用の必要条件となることは忘れないでください．
Gitの理解及びセットアップは[こちら](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/)の記事を参考にしてください．


### GitHub特有の機能

GitHubにはGitにはない特有の機能があります．代表例として以下．

<strong > &#9654;&nbsp; Pull Request</strong>

- GitHub上のGitレポジトリに対して，他の開発者に新たに作成した変更のマージのリクエストするサービス
- ソースコードとの差分確認(コードレビュー機能)とディスカッションをPull Requestベースで実施できる

<strong > &#9654;&nbsp; Issue</strong>

- １つのタスクやバグを１つのIssueに割り当てて，トラッキングや管理を行えうようにするための機能
- バグ管理システムやチケット管理サービスとして使用することができる
- commit messageに `#7` のようにIssue IDを書き加えることでリンクを張ることができる

<strong > &#9654;&nbsp; Organization</strong>

- チームを作成して各チームメンバーの権限の一括管理を可能とする機能
- チーム内部で共通ダッシュボードの作成も可能
- 公開レポジトリの範囲であれば無料でOrganizationアカウントを作成することができる


<br>

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#F8F8F8'>
<p class="h4"><ins><strong >REMARKS</strong></ins></p>

Pull RequestとIssueどちらも他の開発者へのnotification機能があります．GitHub登場前は「メーリングリスト + 課題管理アプリ + コードレビューアプリ」を組み合わせて開発体制を整える必要が有りましたが，
GitHub登場によりこれらをまとめることができるようになったのがGitHubが世界中で使われている理由の１つだと思います．


</div>

## GitHubの個人アカウントとの連携

SSH プロトコルを利用してGitHubへの接続環境を構築します.SSH をセットアップする際には,SSH キーを生成し,ssh-agent に追加し,それから キーを自分の GitHubアカウントに追加します. SSH キーを ssh-agent に追加することで,パスフレーズの利用を通じて SSH キーに追加のセキュリティのレイヤーを持たせることができます.

> REMARKS

- 個人的にはSSH接続ではなく，アクセストークンを用いた接続設定を推奨です
- アクセストークンを用いた接続設定は[Ryo's Tech Blog > 2021-04-25: Githubパスワード認証廃止への対応](https://ryonakagami.github.io/2021/04/25/github-token-authentication/)にまとめてあります

### 新しい SSH キーを生成して ssh-agent に追加する

`ssh-keygen`というコマンドを用いてsshキーを作成します.`which ssh-keygen`を実行して,コマンドが存在するか確かめます.

```zsh
% which ssh-keygen
usr/bin/ssh-keygen
```

次にsshキーを作成します.メールアドレスは自分のgit configで用いたメールアドレスを用いてください.

```zsh
% ssh-keygen -t ed25519 -C "your_email@example.com"
> Generating public/private ed25519 key pair.
```

Enter a file in which to save the key」というメッセージが表示されたら,Enter キーを押します. これにより,デフォルトのファイル場所が受け入れられます.

```
> Enter a file in which to save the key (/home/you/.ssh/id_ed25519): [Press enter]
```

プロンプトで,安全なパスフレーズを入力します. 

```
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

仮に`~/.ssh/id_ed25519`というキーが発行された場合,Permissionを変更しておく

```zsh
% chmod 600 ~/.ssh/id_ed25519.pub
```

`~/.ssh/config`ファイルも編集する.

```
Host github
  HostName github.com
  User git
  Port 22
  IdentityFile ~/.ssh/id_ed25519`
  IdentitiesOnly yes
  TCPKeepAlive yes
```

ここの設定は以下のコマンドに対応します.

```
% git clone [User]@[Host]:[リポジトリアドレス]
```

|設定項目|説明|
|---|---|
|Host|ホスト名, ssh hogehogeでhogehogeとなるところ|
|User|ログインユーザー, githubの場合はgit|
|Port| port, default 22|
|HostName|hostのアドレス, github.com|
|IdentityFile|秘密鍵のPATHを指定する|
|TCPKeepAlive|持続的接続の設定|
|IdentitiesOnly|使用する秘密鍵をIdentityFileだけにします.デフォルトではnoであり,noだと全ての秘密鍵を試そうとします.|

### GitHub アカウントへの新しい SSH キーの追加

SSH 公開鍵をGitHubに登録するところまでを目指します.そのためまず自分が作成したsshキーの公開鍵の内容を取得する必要があります.具体的にはクリップボードへのコピーです.

```zsh
% sudo apt install xclip
% xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

1. その後,GitHubにwebブラウザでアクセスし,`Settings`を変更します（Settingsをクリック）.
2. ユーザ設定サイドバーでSSH and GPG keys（SSH及びGPGキー）をクリックします.
3. `[New SSH key]` または `[Add SSH key]` をクリックします. `[Title]` フィールドで,新しいキーを説明するラベルを追加します. たとえば個人の Ubuntu Desktop を使っている場合,このキーを "Personal Ubuntu Desktop" などと呼ぶことが考えられます.
4. 次に,クリップボードにコピーしたキーを `[Key]` フィールドに貼り付けます. 

<img src="https://docs.github.com/assets/images/help/settings/ssh-key-paste.png">

その後,`[Add SSH key]` をクリックして完了です.

### SSH 接続をテストする

```
% ssh -T git@github.com
```

コマンド実行後以下のようなメッセージが出たら接続テスト成功です.

```
> Hi username! You've successfully authenticated, but GitHub does not
> provide shell access
```

### ssh接続を使ったgit clone

ssh接続のユースケースの一つとして,private repositoryのgit cloneです.

```
% git clone git@github.com:RyoNakagami/sample_size.git
Cloning into 'sample_size'...
remote: Enumerating objects: 8, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 8 (delta 0), reused 8 (delta 0), pack-reused 0
Receiving objects: 100% (8/8), done.
```

ただし,GitHubとしてはSSH接続ではなくHTTPS接続による方法が推奨されています.プロジェクトなどで特段の制限や方針がなければHTTPSを使うことを検討してください.

References
-----

- [Ryo's Tech Blog > Set Up Personal Access Token for GitHub](https://ryonakagami.github.io/2021/04/25/github-token-authentication/)