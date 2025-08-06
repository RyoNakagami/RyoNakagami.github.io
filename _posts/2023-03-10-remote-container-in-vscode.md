---
layout: post
title: "VS Codeにおける開発ンテナ機能"
subtitle: "Visual Studio Code Dev Containers extensionの導入"
author: "RyoNak"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-08-04
header-mask: 0.0
header-style: text
tags:

- VSCode
- Docker
---

## Development Container機能

<strong > &#9654;&nbsp; 機能概要</strong>

- Development Container機能は，DockerコンテナをVSCode上で操作できる機能のこと
- 開発に使うDockerコンテナ内でVSCode上でのファイルアクセス機能，VSCode拡張機能やLanguage Serverを動かすことが可能
- プロジェクト内の`devcontainer.json`ファイルにてVSCodeがアクセスする開発コンテナを指定する
- 利用するためには `Dev Containers` 拡張機能が必要


<strong > &#9654;&nbsp; Localとコンテナ間のworkspaceファイル共有方法</strong>

![docker-file-access-scheme](https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/Docker/2023-03-10-architecture-containers.png?raw=true)


- Local workspace fileはコンテナ内にクローンされるかVolume Mountされる
- VSCode拡張機能はコンテナ内にインストールされ，コンテナ内部で実行される
