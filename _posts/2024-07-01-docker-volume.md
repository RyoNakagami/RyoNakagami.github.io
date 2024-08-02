---
layout: post
title: "Docker Volumne"
subtitle: "Dockerの基礎知識 */N"
author: "RyoNak"
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-08-04
header-mask: 0.0
header-style: text
tags:

- Docker
---

## DockerにおけるVolumeとは？

コンテナ内のファイルシステムをホストのファイルシステムに接続する方法として

- Volume mount
- bind mount

の２つが有ります．bind mountがホストマシーンのOSやディレクトリ構造に依存する一方，
volumeはDockerに寄って管理されるという差分が有ります．

<strong > &#9654;&nbsp; Volumeの特徴</strong>

- Dockerの管理下でストレージ領域を確保
    - Linuxならば`/var/lib/docker/volumes/`
    - Dockerコマンドを使って管理可能
- データのバックアップと復元が容易
- Linux DockerとWindows Dockerどちらでも動作する
- 他のコンテナとの共有が容易 and 複数のコンテナ間でボリュームを安全に共有可能
- bind mountよりもI/O効率が良い
- 永続データを扱う場合でも，volumeのコンテンツはコンテナ外に存在するのでコンテナサイズを増加させない
    - bindはコンテナ内のファイルシステムとホストのファイルシステムが直接リンクする仕組み

### Docker volumeの作成

Docker Volumeは以下のコマンドで作成可能です

```zsh
% docker volume create docker-sandbox
docker-sandbox

# list all your volumes
% docker volume ls                   
DRIVER    VOLUME NAME
local     docker-sandbox
local     vscode

# inspect the detail
% docker volume inspect docker-sandbox 
[
    {
        "CreatedAt": "2024-07-01T13:25:23Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/docker-sandbox/_data",
        "Name": "docker-sandbox",
        "Options": null,
        "Scope": "local"
    }
]
```

### Docker Volumeの利用

上で作成した新規volumeをコンテナにattachして起動する場合以下のコマンドとなります

```zsh
% docker container run --rm \
     --mount source=docker-sandbox,target=/app \
     ubuntu:latest touch /app/my-persistent-data
```

別のコンテナにも以下のようにattach可能です

```zsh
% docker container run --rm \
    --mount source=docker-sandbox,target=/app \
    fedora:latest ls -lFa /app/my-persistent-data
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#00008B;'>
<strong >📘 REMARKS</strong> <br>

- `source`にvolumeを指定しますが，上記コマンド実行時にvolumeに存在しない名前を入力すると自動的にvolumeが作成されます

</div>

<br>

volumeを削除する場合は

```zsh
% docker volume rm docker-sandbox
```

使用されていないvolumeを一括で削除したい場合は

```zsh
% docker volume prune
```


References
----------
- [Docker: Up & Running, 3rd Edition By Sean P. Kane, Karl Matthias](https://learning.oreilly.com/library/view/docker-up/9781098131814/)