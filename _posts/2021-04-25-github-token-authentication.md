---
layout: post
title: "Set Up Personal Access Token for GitHub"
subtitle: "Githubパスワード認証廃止への対応"
author: "Ryo"
catelog: true
mathjax: true
revise_date: 2023-07-29
header-mask: 0.0
header-style: text
tags:

- Ubuntu 20.04 LTS
- Ubuntu 22.04.2 LTS
- git

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Overview](#overview)
  - [Pain](#pain)
  - [Background](#background)
  - [だれが影響を受けるのか？](#%E3%81%A0%E3%82%8C%E3%81%8C%E5%BD%B1%E9%9F%BF%E3%82%92%E5%8F%97%E3%81%91%E3%82%8B%E3%81%AE%E3%81%8B)
- [Solution: PATの発行](#solution-pat%E3%81%AE%E7%99%BA%E8%A1%8C)
  - [トークンの作成](#%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E3%81%AE%E4%BD%9C%E6%88%90)
  - [トークン使用のテスト](#%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E4%BD%BF%E7%94%A8%E3%81%AE%E3%83%86%E3%82%B9%E3%83%88)
- [GPG encrypted`.netrc.gpg`を用いたリモートレポジトリアクセス設定](#gpg-encryptednetrcgpg%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%83%AC%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E8%A8%AD%E5%AE%9A)
  - [対応作業](#%E5%AF%BE%E5%BF%9C%E4%BD%9C%E6%A5%AD)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Overview

今回のSolutionの想定OSは以下,

- Ubuntu 20.04 LTS Focal Fossa
- Ubuntu 22.04.2 LTS Jammy Jellyfish


### Pain

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

対応がなぜ必要かというと, [Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)をみると

```
Beginning August 13, 2021, we will no longer accept account passwords when 
authenticating Git operations on GitHub.com
```

これにより, コマンドラインでのGit操作, Gitを使用するデスクトップアプリケーション, 
GitHub.comのGitリポジトリに直接アクセスするアプリやサービスでは, パスワードを用いてリポジトリへアクセスすることができなくなる恐れがあります.

### Background

GitHubでは, 従来よりパスワード認証に代わってトークンベースの認証を使用することを推奨していました. 
2020年11月にはすでにREST API利用時のパスワード認証を廃止しており, 今回の発表はその適用範囲を大きく広げた形となります.

トークンベースの認証を推奨する理由として, セキュリティ上の利点が挙げられます：

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:gray; background-color:gray; color:white'>
---|---
Unique|トークンはGitHubにUniqueで, 使用ごとやデバイスごとに生成することができます
Revocable|対象外の認証情報を更新することなく, いつでも個別にトークンを取り消すことができます
Limited|トークンの範囲を狭めて, ユースケースに必要なアクセスのみを許可することができます
Random|トークンは, 定期的に覚えたり入力したりする必要のある単純なパスワードのように, 辞書やブルートフォース（総当たり攻撃）の対象にはなりません

</div>

難しく考えずに, 個人アクセストークンは, GitHub API またはコマンドラインを使用するときに
GitHub への認証でパスワードの代わりに使用できる程度の知識で普段は十分です.


### だれが影響を受けるのか？

基本的には, Gitの操作にパスワード認証を利用している開発者は影響を受けますが, 以下のいずれかに該当するアカウントは影響を受けません:

- 既にトークンベースの認証を導入している場合
- SSHベースの認証を行っている場合
- 2要素認証を使用したGitHubアカウント


## Solution: PATの発行

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

> REMARKS

- セキュリティ上の理由から, **GitHub は過去 1 年間使用されていない個人アクセストークンを自動的に削除します**.



## GPG encrypted`.netrc.gpg`を用いたリモートレポジトリアクセス設定

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

> STEP 1: `.netrc`ファイルの作成

`.netrc`ファイルは, 元々はftpのためのユーザー設定ファイルで, 自動ログインプロセスで使われる
ログイン情報と初期化情報を記載します.

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

> STEP 2: GPG暗号化 & `.netrc.gpg`の生成

**こちらの作業はすでにGPGキーが発行されている前提**です. 

GPGキーの発行は[こちら](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/#5-gpg%E3%82%AD%E3%83%BC%E3%81%AE%E7%99%BB%E9%8C%B2)
を参照してください


```zsh
% gpg -e -r email@example.com ~/.netrc #~/.netrc.gpgが生成される
% shred ~/.netrc
% rm ~/.netrc
```

これで`.netrc.gpg`が生成されます.

なお, 暗号化したファイルを復号化したい場合は, 

```zsh
% gpg ~/.netrc.gpg
% cat ~/.netrc
```

で確認することができます.


> STEP 3: netrc credential helperの設定

[git contrib](https://github.com/git/git)には, `git-credential-netrc.perl`というファイルの中に
netrcファイルを参照する機能が実装されています.

これをlocalへcopyして, PATHを通しに行きます.

```zsh
% git clone https://github.com/git/git <git-contribu-path>
% touch ~/.local/bin/git-credential-netrc
% cp <git-contribu-path>/contrib/netrc/git-credential-netrc.perl ~/.local/bin/git-credential-netrc
% sudo chmod +x ~/.local/bin/git-credential-netrc
```

なお, `~/.local/bin/`にPATHが通っていない時は以下のコマンドでPATHを通してください.

```zsh
% export PATH="$HOME/.local/bin:$PATH"
```


> STEP 4: git configの設定

```zsh
% git config --global credential.helper "netrc -v"
% cat ~/.gitconfig #設定確認
```

---|---
`-d`, `--debug`| turn on debugging (developer info), Onにする必要はない
`-v`, `--verbose`| be more verbose (show files and information found)


References
-----

> 関連記事

- [Ubuntu 20.04 LTS git GitHub Ubuntu Desktop環境構築 Part 13 - GitとGitHubの設定](https://ryonakagami.github.io/2020/12/28/ubuntu-git-and-github-setup/)

> 公式ドキュメント

- [GitHub Docs > Managing remote repositories](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories)
- [GitHub Docs > 個人アクセストークンを使用する](https://docs.github.com/ja/github-ae@latest/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)

> Others

- [Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)
- [How to update remote origin to use access token instead of SSH key?](https://stackoverflow.com/questions/71453194/how-to-update-remote-origin-to-use-access-token-instead-of-ssh-key)