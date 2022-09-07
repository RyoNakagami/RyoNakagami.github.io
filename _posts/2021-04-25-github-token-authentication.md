---
layout: post
title: "Githubパスワード認証廃止への対応"
subtitle: "個人アクセストークン(PAT)の設定"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-25
tags:

- Ubuntu 20.04 LTS
- git
- GitHub
---



---|---
目的|GitHub 個人アクセストークンの設定
OS |	ubuntu 20.04 LTS Focal Fossa
CPU| 	Intel Core i7-9700 CPU 3.00 GHz

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

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
- [Appendix: リモートリポジトリについて](#appendix-%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [リモートレポジトリの作成](#%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%83%AC%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E4%BD%9C%E6%88%90)
  - [HTTPS URLによるクローンのメリット](#https-url%E3%81%AB%E3%82%88%E3%82%8B%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%B3%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
  - [過去ログ: git clone用の関数構築(2022年時点Obsolete)](#%E9%81%8E%E5%8E%BB%E3%83%AD%E3%82%B0-git-clone%E7%94%A8%E3%81%AE%E9%96%A2%E6%95%B0%E6%A7%8B%E7%AF%892022%E5%B9%B4%E6%99%82%E7%82%B9obsolete)
- [References](#references)
  - [関連記事](#%E9%96%A2%E9%80%A3%E8%A8%98%E4%BA%8B)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## 解決したい症状

Githubから以下のメールが来たのでその対処をしたい：

```
Hi @Hoo,

You recently used a password to access the repository at HooHoo.

Basic authentication using a password to Git is deprecated and will soon no longer work. Visit https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information around suggested workarounds and removal dates.

Thanks,
The GitHub Team
```

### 何が問題か？

対応がなぜ必要かというと、[Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)をみると

```
Beginning August 13, 2021, we will no longer accept account passwords when authenticating Git operations on GitHub.com
```

これにより、コマンドラインでのGit操作、Gitを使用するデスクトップアプリケーション、GitHub.comのGitリポジトリに直接アクセスするアプリやサービスでは、パスワードを用いてリポジトリへアクセスすることができなくなる恐れがあります.

### Background

GitHubでは、従来よりパスワード認証に代わってトークンベースの認証を使用することを推奨していました. 2020年11月にはすでにREST API利用時のパスワード認証を廃止しており、今回の発表はその適用範囲を大きく広げた形となります.

トークンベースの認証を推奨する理由として、セキュリティ上の利点が挙げられます：

---|---
Unique|トークンはGitHubにUniqueで、使用ごとやデバイスごとに生成することができます
Revocable|対象外の認証情報を更新することなく、いつでも個別にトークンを取り消すことができます
Limited|トークンの範囲を狭めて、ユースケースに必要なアクセスのみを許可することができます
Random|トークンは、定期的に覚えたり入力したりする必要のある単純なパスワードのように、辞書やブルートフォース（総当たり攻撃）の対象にはなりません

難しく考えずに、個人アクセストークンは、GitHub API またはコマンドラインを使用するときに GitHub への認証でパスワードの代わりに使用できる程度の知識で普段は十分です.なお、セキュリティ上の理由から、 GitHub は過去 1 年間使用されていない個人アクセストークンを自動的に削除します。

### だれが影響を受けるのか？

基本的には、Gitの操作にパスワード認証を利用している開発者は影響を受けますが、以下のいずれかに該当するアカウントは影響を受けません:

- 既にトークンベースの認証を導入している場合
- SSHベースの認証を行っている場合
- 2要素認証を使用したGitHubアカウント

## 対応方針

2021年8月13日までに、

- HTTPSまたはSSHキーを使用したパーソナルアクセストークンによる認証を導入
- インテグレーターの場合、WebまたはOAuthデバイス認証フローを使用してアプリに認証を付与
- two-factor authenticationを有効にする

という対応となります. 今回は「パーソナルアクセストークンによる認証を導入」します.

### トークンの作成

1. 任意のページの右上で、プロフィール画像をクリックし、`Settings`をクリック
2. 左サイドバーで `Developer settings` をクリック
3. 左のサイドバーで`Personal access tokens`をクリック
4. `Generate new token` をクリック
5. トークンを使用目的に則して設定する, その後 `Generate token` をクリック
6. トークンをクリップボードにコピー

### トークン使用のテスト

トークンを入手したなら、HTTPS経由でGitの操作をする際にパスワードの代わりにそのトークンを入力することができます.

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

- コマンドラインで、HTTPS URL を使用してリモートリポジトリに `git clone`, `git fetch`, `git pull` または `git push` を行った場合、GitHub のユーザ名とパスワードの入力を求められる. 
- Gitがパスワードを求めてきたときは、個人アクセストークン（PAT）の入力で十分ですが, 毎回入力するのは面倒(特にGitHub 2FA accessをEnabledしている場合は, PAT入力でないとだめ)
- どこかに平文でPATを保存するのはセキュリティ観点から望ましくない

> 対応方針

1. `github.com`へのアクセス情報を保存した`.netrc`ファイルを作成
2. `.netrc`ファイルをGPG keyで暗号化し, `.netrc.gpg`ファイルを作成(`.netrc`ファイルはこの時削除)
3. `git-credential-netrc`機能を実行可能にする
4. `git config`設定

### 対応作業

> `.netrc`ファイルの作成

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

> GPG暗号化

こちらの作業はすでにGPGキーが発行されている前提です. 

```zsh
% gpg -e -r email@example.com ~/.netrc #~/.netrc.gpgが生成される
% shred ~/.netrc
% rm ~/.netrc
```

> netrc credential helperの設定

git commandには, `git-credential-netrc.perl`というファイルの中にnetrcファイルを参照する機能が実装されています.
これに対して実行可能設定をします.

```zsh
% touch ~/.local/bin/git-credential-netrc
% cp git-credential-netrc.perl ~/.local/bin/git-credential-netrc
% sudo chmod +x ~/.local/bin/git-credential-netrc
```

> git configの設定

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

## Appendix: リモートリポジトリについて

インターネット上あるいはその他ネットワーク上のどこかに存在するファイルやディレクトリの履歴を管理する場所のことです.プッシュできるのは、2 種類の URL アドレスに対してのみです:

- `https://github.com/user/repo.git` のような HTTPS URL
- `git@github.com:user/repo.git` のような SSH URL

Git はリモート URL に名前を関連付けます. デフォルトのリモートは通常 `origin` と呼ばれます. 


### リモートレポジトリの作成

git remote add コマンドを使用してリモート URL に名前を関連付けることができます。 たとえば、コマンドラインに以下のように入力できます:

```
git remote add origin  <REMOTE_URL> 
```

設定状況を確認したい場合は

```
git remote -v
```

これで `origin` という名前が `REMOTE_URL` に関連付けられます。 `git remote set-url` を使えば、リモートの URL を変更できます。


### HTTPS URLによるクローンのメリット

- `https://` は、可視性に関係なく、すべてのリポジトリで使用できます. 
- `https://` のクローン URL は、ファイアウォールまたはプロキシの内側にいる場合でも機能する.


### 過去ログ: git clone用の関数構築(2022年時点Obsolete)

> 前提条件

- `.zshrc`にアクセストークンを参照するオブジェクトを作成してください
- ここではそれを`TEST_TOKEN`とします

> やりたいこと

- アクセストークン取得後,アクセス可能なprivate repositoryをcloneする際に毎回パスワードを入力するのが億劫
- 関数を作成し, URLを引数にすればcloneしてくれる仕様にしたい

> ワンライナーでprivate repositoryをcloneする場合

```
% git clone https://<USER NAME>:${TEST_TOKEN}@github.com/repositoryowner/repositoryname
```

> 関数作成

適当な場所に以下の`gh_clone`というファイルをつくります.

```bash
#!/usr/bin/bash
## GitHub private repositoryをcloneする関数

prefix='https://<GitHub User Name>:';
pass=$TEST_TOKEN
surfix=$(echo $1 |sed -e 's/^https:\/\//@/g');
clone_args=$prefix$pass$surfix;
git clone $clone_args
```

Then, `sudo chmod 755 ./gh_clone`で完成.



## References
### 関連記事

- [Ubuntu 20.04 LTS git GitHub Ubuntu Desktop環境構築 Part 13 - GitとGitHubの設定](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/)

### オンラインマテリアル

- [Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)
- [個人アクセストークンを使用する](https://docs.github.com/ja/github-ae@latest/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)