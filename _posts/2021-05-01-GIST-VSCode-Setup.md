---
layout: post
title: "GistとVS Codeの連携"
subtitle: "VS codeからGistにgist createできるようにする"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-08-04
reading_time: 6
tags:

- VS Code
- git
- GitHub
---



---|---
目的|VS codeから簡単にgistにgist createできるようにする
OS |	ubuntu 20.04 LTS Focal Fossa
CPU| 	Intel Core i7-9700 CPU 3.00 GHz

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [問題設定](#%E5%95%8F%E9%A1%8C%E8%A8%AD%E5%AE%9A)
  - [紹介する解決策](#%E7%B4%B9%E4%BB%8B%E3%81%99%E3%82%8B%E8%A7%A3%E6%B1%BA%E7%AD%96)
  - [採用理由](#%E6%8E%A1%E7%94%A8%E7%90%86%E7%94%B1)
  - [注意点](#%E6%B3%A8%E6%84%8F%E7%82%B9)
- [VS Code側での設定](#vs-code%E5%81%B4%E3%81%A7%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [方針](#%E6%96%B9%E9%87%9D)
  - [GITHUBでGist用Token取得](#github%E3%81%A7gist%E7%94%A8token%E5%8F%96%E5%BE%97)
  - [`GIST: select profile`でAccess Tokenを設定](#gist-select-profile%E3%81%A7access-token%E3%82%92%E8%A8%AD%E5%AE%9A)
  - [GIST Create/Addを試してみる](#gist-createadd%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%82%8B)
- [レビューにあたっての心構え](#%E3%83%AC%E3%83%93%E3%83%A5%E3%83%BC%E3%81%AB%E3%81%82%E3%81%9F%E3%81%A3%E3%81%A6%E3%81%AE%E5%BF%83%E6%A7%8B%E3%81%88)
  - [プロトコル: 共有まで](#%E3%83%97%E3%83%AD%E3%83%88%E3%82%B3%E3%83%AB-%E5%85%B1%E6%9C%89%E3%81%BE%E3%81%A7)
  - [コードレビューの項目](#%E3%82%B3%E3%83%BC%E3%83%89%E3%83%AC%E3%83%93%E3%83%A5%E3%83%BC%E3%81%AE%E9%A0%85%E7%9B%AE)
- [References](#references)
  - [VS Code Extension](#vs-code-extension)
  - [オンラインマテリアル](#%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%9E%E3%83%86%E3%83%AA%E3%82%A2%E3%83%AB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 問題設定

- ちょっとしたコードのreview/shareでg suite/slackのchatだとコードがちょっと長すぎる
- GitHubでrepository立てるほどでもない

### 紹介する解決策

- [GitHub Gist](https://gist.github.com/)でコードの共有及びコメントのやり取りをする
- VS Code Extension Gist [kenhowardpdx.vscode-gist](https://marketplace.visualstudio.com/items?itemName=kenhowardpdx.vscode-gist#review-details)を用いて,ローカルのVS Codeから任意のファイルをGistへcreate/addできるようにする

<img src = "https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/Git_workflow_Introduction/20210501-Gist-VSCode-Extension.png?raw=true">

### 採用理由

- 誰でも非公開なrepositoryを立てられる
- repositoryは簡略化されている
- 非公開でもurlを共有すれば誰でもアクセスできる
- githubアカウントがなくても確認することはできる
- htmlにembed簡単にできる
- 変更履歴がしっかり残る

### 注意点

- private gistでもurlバレたら誰でもアクセスできる（アカウント持っていなくても）
- 万が一にでも全世界に公開されたくない情報はSecret Gistに書かない
- 他人がCreateしたGistに関してはBrowser経由で確認するしかない


## VS Code側での設定
### 方針

1. GITHUBでGist用Token取得（セキュリティ観点から分ける意図）
2. VS Code環境からextension`GIST`をinstall
3. `GIST: select profile`でAccess Tokenを設定
4. `GIST CREATE`のテスト

### GITHUBでGist用Token取得

1. `Settings > Developer settings`へアクセスします.
2. `Personal access tokens`へアクセスし, `Generate new token`をクリック

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/git/Git_workflow_Introduction/20210501-VSCode-Gist-AccessToken.png?raw=true">

ここで,以下2点だけ設定します

- Expiration
- gist

そうすると,設定内容を踏まえたAccess Tokenが生成されるのでそれをコピーします.

### `GIST: select profile`でAccess Tokenを設定

これはVS Codeで`F1`キーをクリックし, VS Codeコマンドパレットを開き,`GIST: select profile`を選択すると入力指示がでてくるのでそれに従って登録するだけです

### GIST Create/Addを試してみる

- VS Codeで現在開いているファイルを対象にGist create/addをコマンドパレット経由で実行することができます
- Gist create/add実行後, `tmp`ディレクトリに対象ファイルのコピーが生成されますが,`tmp`ディレクトリに入っているのでシステムを再起動するとファイルは消去されるのでストーレージを圧迫するなどの懸念はありません

## レビューにあたっての心構え
### プロトコル: 共有まで
1. descriptionは目的をかく
2. ファイルはmd形式
   - 更新日
   - status
   - 目的
   - 言語
   - 動作環境
   - reviewをお願いしたいところを項目たてる（チェックボックス使うこと）
   - コードの説明（変数の定義やロジックなど）
   - コード本体
3. fileの拡張子に注意してsql/python/Rのコードをかく
4. reviewはコメントを中心に行う

### コードレビューの項目

- Design(システムにとって適切な設計か)
- Funcitionality(意図した通り振舞っているか)
- Complexity(簡略化できないか)
- Test(simulation codeは上がっているか、問題ないか)
- Naming(名前の付け方問題ないか？)
- Style (形式はスタイルガイドに従っているか、統一性あるか)

## References
### VS Code Extension

- [VS Code Extension Gist, kenhowardpdx.vscode-gist](https://marketplace.visualstudio.com/items?itemName=kenhowardpdx.vscode-gist#review-details)

### オンラインマテリアル

- [GitHub > gist](https://gist.github.com/)
- [GitHub > Google Engineering Practices Documentation](https://github.com/google/eng-practices)