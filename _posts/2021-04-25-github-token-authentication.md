---
layout: post
title: "Githubパスワード認証廃止への対応"
subtitle: "個人アクセストークン(PAT)の設定"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-04-05
tags:

- Ubuntu 20.04 LTS
- git
- GitHub
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [今回の環境](#%E4%BB%8A%E5%9B%9E%E3%81%AE%E7%92%B0%E5%A2%83)
- [解決したい症状](#%E8%A7%A3%E6%B1%BA%E3%81%97%E3%81%9F%E3%81%84%E7%97%87%E7%8A%B6)
  - [何が問題か？](#%E4%BD%95%E3%81%8C%E5%95%8F%E9%A1%8C%E3%81%8B)
  - [Background](#background)
  - [だれが影響を受けるのか？](#%E3%81%A0%E3%82%8C%E3%81%8C%E5%BD%B1%E9%9F%BF%E3%82%92%E5%8F%97%E3%81%91%E3%82%8B%E3%81%AE%E3%81%8B)
- [対応方針](#%E5%AF%BE%E5%BF%9C%E6%96%B9%E9%87%9D)
  - [トークンの作成](#%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E3%81%AE%E4%BD%9C%E6%88%90)
  - [トークン使用のテスト](#%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E4%BD%BF%E7%94%A8%E3%81%AE%E3%83%86%E3%82%B9%E3%83%88)
- [PATとGPG encrypted`.netrc`を用いたリモートレポジトリアクセス設定](#pat%E3%81%A8gpg-encryptednetrc%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%83%AC%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E8%A8%AD%E5%AE%9A)
  - [作業方針](#%E4%BD%9C%E6%A5%AD%E6%96%B9%E9%87%9D)
  - [対応作業](#%E5%AF%BE%E5%BF%9C%E4%BD%9C%E6%A5%AD)
    - [STEP 1: `.netrc`ファイルの作成](#step-1-netrc%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90)
    - [STEP 2: GPG暗号化](#step-2-gpg%E6%9A%97%E5%8F%B7%E5%8C%96)
    - [STEP 3: netrc credential helperの設定](#step-3-netrc-credential-helper%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [STEP 4: git configの設定](#step-4-git-config%E3%81%AE%E8%A8%AD%E5%AE%9A)
- [remote originをSSH URLからaccess token URLへ変更する](#remote-origin%E3%82%92ssh-url%E3%81%8B%E3%82%89access-token-url%E3%81%B8%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B)
  - [基本手順](#%E5%9F%BA%E6%9C%AC%E6%89%8B%E9%A0%86)
  - [実際にやってみる](#%E5%AE%9F%E9%9A%9B%E3%81%AB%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B)
- [Appendix: リモートリポジトリについて](#appendix-%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [リモートレポジトリの作成](#%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%83%AC%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E4%BD%9C%E6%88%90)
  - [HTTPS URLによるクローンのメリット](#https-url%E3%81%AB%E3%82%88%E3%82%8B%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%B3%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## 今回の環境

---|---
OS |	ubuntu 20.04 LTS Focal Fossa
CPU| 	Intel Core i7-9700 CPU 3.00 GHz



## 解決したい症状

Githubから以下のメールが来たのでその対処をしたい：

```
Hi @Hoo,

You recently used a password to access the repository at HooHoo.

Basic authentication using a password to Git is deprecated and will soon no longer work. 
Visit https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ 
for more information around suggested workarounds and removal dates.

Thanks,
The GitHub Team
```

### 何が問題か？

対応がなぜ必要かというと, [Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)をみると

```
Beginning August 13, 2021, we will no longer accept account passwords when 
authenticating Git operations on GitHub.com
```

これにより, コマンドラインでのGit操作, Gitを使用するデスクトップアプリケーション, GitHub.comのGitリポジトリに直接アクセスするアプリやサービスでは, パスワードを用いてリポジトリへアクセスすることができなくなる恐れがあります.

### Background

GitHubでは, 従来よりパスワード認証に代わってトークンベースの認証を使用することを推奨していました. 2020年11月にはすでにREST API利用時のパスワード認証を廃止しており, 今回の発表はその適用範囲を大きく広げた形となります.

トークンベースの認証を推奨する理由として, セキュリティ上の利点が挙げられます：

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:gray; background-color:gray; color:white'>
---|---
Unique|トークンはGitHubにUniqueで, 使用ごとやデバイスごとに生成することができます
Revocable|対象外の認証情報を更新することなく, いつでも個別にトークンを取り消すことができます
Limited|トークンの範囲を狭めて, ユースケースに必要なアクセスのみを許可することができます
Random|トークンは, 定期的に覚えたり入力したりする必要のある単純なパスワードのように, 辞書やブルートフォース（総当たり攻撃）の対象にはなりません

</div>

難しく考えずに, 個人アクセストークンは, GitHub API またはコマンドラインを使用するときに GitHub への認証でパスワードの代わりに使用できる程度の知識で普段は十分です.なお, セキュリティ上の理由から, **GitHub は過去 1 年間使用されていない個人アクセストークンを自動的に削除します**.

### だれが影響を受けるのか？

基本的には, Gitの操作にパスワード認証を利用している開発者は影響を受けますが, 以下のいずれかに該当するアカウントは影響を受けません:

- 既にトークンベースの認証を導入している場合
- SSHベースの認証を行っている場合
- 2要素認証を使用したGitHubアカウント

## 対応方針

2021年8月13日までに, 

- HTTPSまたはSSHキーを使用したパーソナルアクセストークンによる認証を導入
- インテグレーターの場合, WebまたはOAuthデバイス認証フローを使用してアプリに認証を付与
- two-factor authenticationを有効にする

という対応となります. 今回は「**パーソナルアクセストークンによる認証を導入**」します.

### トークンの作成

1. 任意のページの右上で, プロフィール画像をクリックし, `Settings`をクリック
2. 左サイドバーで `Developer settings` をクリック
3. 左のサイドバーで`Personal access tokens`をクリック
4. `Generate new token` をクリック
5. トークンを使用目的に則して設定する, その後 `Generate token` をクリック
6. トークンをクリップボードにコピー

### トークン使用のテスト

トークンを入手したなら, HTTPS経由でGitの操作をする際にパスワードの代わりにそのトークンを入力することができます.

```
% git clone https://hostname/username/repo.git
Username: your_username
Password: your_token
```

以下のコマンドでテストします

```
% cd ~/Desktop
% mkdir test
% cd ./test
% git init
% git config core.sparsecheckout true
% git remote add origin https://github.com/RyoNakagami/sample_size.git
% echo sample_size_calculation > .git/info/sparse-checkout\n
% git pull origin master
Username for 'https://github.com': RyoNakagami
Password for 'https://RyoNakagami@github.com': 
remote: Enumerating objects: 8, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 8 (delta 0), reused 8 (delta 0), pack-reused 0
Unpacking objects: 100% (8/8), 2.45 KiB | 502.00 KiB/s, done.
From https://github.com/RyoNakagami/sample_size
 * branch            master     -> FETCH_HEAD
 * [new branch]      master     -> origin/master
```

動作確認終了後テストフォルダを削除しときます

```
% cd -
% rm -rf ./test
```


## PATとGPG encrypted`.netrc`を用いたリモートレポジトリアクセス設定
### 作業方針

> 問題設定

- コマンドラインで, HTTPS URL を使用してリモートリポジトリに `git clone`, `git fetch`, `git pull` または `git push` を行った場合, GitHub のユーザ名とパスワードの入力を求められる. 
- Gitがパスワードを求めてきたときは, 個人アクセストークン（PAT）の入力で十分ですが, 毎回入力するのは面倒(特にGitHub 2FA accessをEnabledしている場合は, PAT入力でないとだめ)
- どこかに平文でPATを保存するのはセキュリティ観点から望ましくない

> 対応方針

1. `github.com`へのアクセス情報を保存した`.netrc`ファイルを作成
2. `.netrc`ファイルをGPG keyで暗号化し, `.netrc.gpg`ファイルを作成(`.netrc`ファイルはこの時削除)
3. `git-credential-netrc`機能を実行可能にする
4. `git config`設定

### 対応作業

#### STEP 1: `.netrc`ファイルの作成

`.netrc`ファイルは, 元々はftp のためのユーザー設定ファイルで, 自動ログインプロセスで使われる ログイン情報と初期化情報を記載します.

```
machine github.com
login <username>
password <token>
protocol https

machine gitlab.com
login <username>
password <token>
protocol https
```

#### STEP 2: GPG暗号化

こちらの作業はすでにGPGキーが発行されている前提です. 
なおこの工程後, `.netrc.gpg`が生成されます.

```zsh
% gpg -e -r email@example.com ~/.netrc #~/.netrc.gpgが生成される
% shred ~/.netrc
% rm ~/.netrc
```

#### STEP 3: netrc credential helperの設定

git commandには, `git-credential-netrc.perl`というファイルの中にnetrcファイルを参照する機能が実装されています.
これに対して実行可能設定をします.

```zsh
% touch ~/.local/bin/git-credential-netrc
% cp git-credential-netrc.perl ~/.local/bin/git-credential-netrc
% sudo chmod +x ~/.local/bin/git-credential-netrc
```

#### STEP 4: git configの設定

```zsh
% git config --global credential.helper "netrc -d -v"
% cat ~/.gitconfig #設定確認
```

---|---
`-d`, `--debug`| turn on debugging (developer info)
`-v`, `--verbose`| be more verbose (show files and information found)

なお, gitconfigに以下の情報を記載する形でもOKです

```
[credential]
    helper = /usr/share/git/credential/netrc/git-credential-netrc.perl
```

## remote originをSSH URLからaccess token URLへ変更する

すでにSSH経由でcloneしてしまったrepositoryについてPATによるアクセスを設定する場合には, 
`origin` URLを `git remote set-url`コマンドで更新する必要があります.

### 基本手順

[GitHub Docs > Managing remote repositories](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories)に書いてある通りに紹介します.

1. Terminalを開く
2. the current working directoryを変更を加えるlocal repositoryへ変更する
3. `git remote -v`でremote repositoryの名前を確認する
4. SSH to HTTPSとremote repositoryを変更する


### 実際にやってみる

```zsh
% git remote -v #まずremote urlの確認
origin  git@github.com:RyoNakagami/RyoNakagami.github.io (fetch)
origin  git@github.com:RyoNakagami/RyoNakagami.github.io (push)

% git remote set-url origin https://github.com/<username>/<repo_name>

% git remote -v #更新されたか確認
origin  https://github.com/RyoNakagami/RyoNakagami.github.io (fetch)
origin  https://github.com/RyoNakagami/RyoNakagami.github.io (push)
```

## Appendix: リモートリポジトリについて

インターネット上あるいはその他ネットワーク上のどこかに存在するファイルやディレクトリの履歴を管理する場所のことです.プッシュできるのは, 2 種類の URL アドレスに対してのみです:

- `https://github.com/user/repo.git` のような HTTPS URL
- `git@github.com:user/repo.git` のような SSH URL

Git はリモート URL に名前を関連付けます. デフォルトのリモートは通常 `origin` と呼ばれます. 


### リモートレポジトリの作成

git remote add コマンドを使用してリモート URL に名前を関連付けることができます。 たとえば, コマンドラインに以下のように入力できます:

```
git remote add origin  <REMOTE_URL> 
```

設定状況を確認したい場合は

```
git remote -v
```

これで `origin` という名前が `REMOTE_URL` に関連付けられます。 `git remote set-url` を使えば, リモートの URL を変更できます。


### HTTPS URLによるクローンのメリット

- `https://` は, 可視性に関係なく, すべてのリポジトリで使用できます. 
- `https://` のクローン URL は, ファイアウォールまたはプロキシの内側にいる場合でも機能する.


## References

> 関連記事

- [Ubuntu 20.04 LTS git GitHub Ubuntu Desktop環境構築 Part 13 - GitとGitHubの設定](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/)

> 公式ドキュメント

- [GitHub Docs > Managing remote repositories](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories)


> オンラインマテリアル

- [Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)
- [個人アクセストークンを使用する](https://docs.github.com/ja/github-ae@latest/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [How to update remote origin to use access token instead of SSH key?](https://stackoverflow.com/questions/71453194/how-to-update-remote-origin-to-use-access-token-instead-of-ssh-key)