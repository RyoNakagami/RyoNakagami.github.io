---
layout: post
title: "Ubuntu Desktop環境構築 Part 16"
subtitle: "Dockerによる環境構築 Part 2: サンプルアプリケーションを動かしてみる"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Ubuntu 20.04 LTS
- Docker
---


||概要|
|---|---|
|目的|Dockerによる環境構築 Part 2: サンプルアプリケーションを動かしてみる。|
|関連記事|[Ubuntu Desktop環境構築 Part 14](https://ryonakagami.github.io/2021/01/27/ubuntu-docker-setup/)|
|参考|[Docker docs: Sample application](https://docs.docker.com/get-started/02_our_app/)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. Node.jsを活用したtodo listマネジャーアプリの作成](#1-nodejs%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%97%E3%81%9Ftodo-list%E3%83%9E%E3%83%8D%E3%82%B8%E3%83%A3%E3%83%BC%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AE%E4%BD%9C%E6%88%90)
  - [アプリソースコードの入手](#%E3%82%A2%E3%83%97%E3%83%AA%E3%82%BD%E3%83%BC%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E5%85%A5%E6%89%8B)
  - [container imageのビルド](#container-image%E3%81%AE%E3%83%93%E3%83%AB%E3%83%89)
  - [コンテナの起動](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E8%B5%B7%E5%8B%95)
- [2. Node.jsを活用したtodo listマネジャーアプリのアップデート](#2-nodejs%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%97%E3%81%9Ftodo-list%E3%83%9E%E3%83%8D%E3%82%B8%E3%83%A3%E3%83%BC%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AE%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88)
  - [3. Docker imageのシェアの方法](#3-docker-image%E3%81%AE%E3%82%B7%E3%82%A7%E3%82%A2%E3%81%AE%E6%96%B9%E6%B3%95)
  - [Repositoryの作成](#repository%E3%81%AE%E4%BD%9C%E6%88%90)
  - [Push the image](#push-the-image)
  - [PushされたDocker imageの動作確認](#push%E3%81%95%E3%82%8C%E3%81%9Fdocker-image%E3%81%AE%E5%8B%95%E4%BD%9C%E7%A2%BA%E8%AA%8D)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. Node.jsを活用したtodo listマネジャーアプリの作成

MVP (minimum viable product)としてNode.jsを活用したtodo listマネジャーアプリの挙動をお披露目したいとします。

### アプリソースコードの入手

[こちらのレポジトリ](https://github.com/docker/getting-started/app)からソースコードを入手します。zip fileでダウロードしても良いですが今回はgit cloneで`/app`ディレクトリのみcloneします。

まずworking directoryを作成と設定します。

```zsh
% mkdir sample_app && cd sample_app
% git init
% git config core.sparsecheckout true
```

リモートレポジトリの登録とサブディレクトリの取得を実施します。

```zsh
% git remote add origin git@github.com:docker/getting-started
% echo app/ > .git/info/sparse-checkout
% git pull origin master
% cd ./app
```

### container imageのビルド

まずDockerfileを作成します。

```Dockerfile
FROM node:12-alpine
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
```

つぎにコンテナイメージのビルドを実行します。

```zsh
% docker build -t getting-started .
Sending build context to Docker daemon  4.659MB
Step 1/5 : FROM node:12-alpine
12-alpine: Pulling from library/node
e95f33c60a64: Pull complete 
fdb0a3f5f08b: Pull complete 
f4587ca7dc77: Pull complete 
b0657687f782: Pull complete 
Digest: sha256:5d8b181a0738654bbe659a68879298f8d2d4256685282ee1c2330d97c33e3eee
Status: Downloaded newer image for node:12-alpine
 ---> 5c6db76c80d7
Step 2/5 : WORKDIR /app
 ---> Running in 6c20d67238ec
Removing intermediate container 6c20d67238ec
 ---> c1ccf4545758
Step 3/5 : COPY . .
 ---> 24aafec39d0d
Step 4/5 : RUN yarn install --production
 ---> Running in 423e1312204b
yarn install v1.22.5
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.9: The platform "linux" is incompatible with this module.
info "fsevents@1.2.9" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
[4/4] Building fresh packages...
Done in 12.38s.
Removing intermediate container 423e1312204b
 ---> c75cc24d32b7
Step 5/5 : CMD ["node", "src/index.js"]
 ---> Running in d52748593cf0
Removing intermediate container d52748593cf0
 ---> 4d83f78bd171
Successfully built 4d83f78bd171
Successfully tagged getting-started:latest
```

### コンテナの起動

`-d`オプションを用いて、detached modeで起動します。また`-p`オプションを用いて、ホスト側のポートとコンテナ側のポートのマッピングを設定します。今回は`3000:3000`と設定します。

```zsh
% docker run -dp 3000:3000 getting-started
```

するとアプリが起動するので`http://localhost:3000`にアクセスして確かめてください。

コンテナそれ自体が実行されているかを確認したい場合は、

```zsh
% docker ps
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS          PORTS                    NAMES
e0bfa7127923   getting-started   "docker-entrypoint.s…"   32 minutes ago   Up 32 minutes   0.0.0.0:3000->3000/tcp   vigilant_williams
```

起動を止めたい場合は

```zsh
% docker stop $(docker ps -q)
```

## 2. Node.jsを活用したtodo listマネジャーアプリのアップデート

ToDo itemを入力するエリアに`You have no todo items yet! Add one above!`を表示するようにupdateします。

つぎに`src/static/js/app.js`のline 56を以下のように変更します。

```raw
-                <p className="text-center">No items yet! Add one above!</p>
+                <p className="text-center">You have no todo items yet! Add one above!</p>
```

つぎに、container imageをBuildし直します。

```zsh
% docker build -t getting-started .
```

その後に、再びコンテナを起動します。

```zsh
% docker run -dp 3000:3000 getting-started
```

### 3. Docker imageのシェアの方法

上で作成したDocker Imageを他人とシェアしたいとします。Docker Hubを用いたImageの共有方法を紹介します。

### Repositoryの作成

1. [Docker Hub](https://hub.docker.com/)にアクセスしてログインします
2. the Create Repositoryボタンをクリックします
3. Repositoryの名前とDescription(任意)とVisibilityを設定します。今回は他人とシェアしたいのでVisibilityはPublicにします
4. Createボタンをクリックして完了です。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/docker/2021-02-27_Docker_Hub.png?raw=true">

### Push the image

1. まずdocker hubにコマンドラインからログインします

```zsh
% docker login -u <username>
```

2. つぎに`docker tag`コマンドを用いて`getting-started`イメージをDocker Hubのレポジトリネームと一致するように変更します

```zsh
% docker tag getting-started <username>/getting-started
```

3. 最後にContainer imageをpushします

```zsh
% docker push <username>/getting-started:latest
```

### PushされたDocker imageの動作確認

Docker HubにPushされたイメージが別のインスタンスでどのように動作するか確認します。

1. [Play with Docker](https://labs.play-with-docker.com/)にアクセスします
2. ログインをクリックしてドロップダウンリストから`docker`を選択します。
3. Docker Hubに登録したDocker imageをpullします

```zsh
$ docker pull <username>/getting-started
```

4. 最後にdocker runを実行して、挙動を確認します。

```zsh
$ docker run -dp 3000:3000 <username>/getting-started
```



