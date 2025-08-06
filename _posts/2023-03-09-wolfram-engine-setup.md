---
layout: post
title: "Build and Use Dockerized Wolfram Engine + Jupyter Lab"
subtitle: "Ubuntu Desktop環境構築 Part 27"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-08-05
tags:

- Wolfram Engine
- Docker
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Make the Dockerfile](#make-the-dockerfile)
  - [Dockerfileの構成](#dockerfile%E3%81%AE%E6%A7%8B%E6%88%90)
  - [Docker image size](#docker-image-size)
  - [Build shell script](#build-shell-script)
- [Example](#example)
- [Appendix: Jupyer LabでWolfram Language kernelを選択できるようにする](#appendix-jupyer-lab%E3%81%A7wolfram-language-kernel%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Overview

**What I did**

- Wolfram Language Engine v13.2.0をJupyter Lab経由でアクセスを提供してくれるDocker Imageの作成

**Why I Need Docker Image?**

- Localで構築すると, 環境Pythonや分析環境用Pythonとの関係で使いたい場所でWolfram Language Engine用Jupyter Labが使えないケースがあった
  - 別のところで既にactivatedされており, 使いたいタイミングで使えないなど
- PCをreplaceする際に, 毎回はじめから構築するのは手間がかかる


## Prerequisites

- Wolfram account
- [Free Wolfram Engine License ](https://www.wolfram.com/engine/free-license/)
- Docker

本質的には以下のものはいらないですが, 用いたもの

- `jq` command: command-line JSON processor
- `gpg` command: ID, Password情報が格納されたファイルを暗号化/復号化するため

## Usage

Dockerfileに基づき, docker imageのbuildが完了したあとの利用方法はCLIにて以下のコマンドを入力します

```zsh
docker run \
  --rm \
  -ti \
  --publish 8888:8888 \
  --user $(id -u $USER):$(id -g $USER) \
  --volume $PWD:/home/docker/work \
  ryonak/wolfram-jupyterserver:latest
```

そうすると, Jupyter Labが自動的にカレントディレクトリで立ち上がり, カーネル選択の場面で
Wolfram Language Engine v13.2.0が選択できるようになります

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/blog/Wolfram/wolfram_jupyterserver_startup.png?raw=true">

Docker containerを終了させたい場合は, Jupyter Labを停止するのと同じ要領で Terminalで`ctrl`+`c`を入力します.

## Make the Dockerfile

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>ユーザー要件</ins></p>

- Wolfram Language EngineをJupyter Lab経由で使用したい
- Jupyter Lab使用に伴うPythonについては大きなこだわりはないが, version指定ができるようにしたい

</div>

以上の要件から, Dockerfileには

1. pyenvによるPython version指定
2. Jupyter Labの設定
3. Wolfram Language Engineの設定
4. Wolfram Language EngineとJupyter Labの接続設定

の４つを明示的に取り組む必要があります.
幸いなことに, (3)と(4)については既に公開されたDocker ImageとGitHubで公開されているアプリがあるので
前者のDocker ImageをベースとしてDockerfileを構築し, Dockerfileの中で後者について設定すれば良いという形で対応しています.

### Dockerfileの構成

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>REMARKS</ins></p>

詳細については[RyoNakagami/wolfram_jupyterserver](https://github.com/RyoNakagami/wolfram_jupyterserver)を確認してください.

</div>

[wolframresearch/wolframengine](https://hub.docker.com/r/wolframresearch/wolframengine)をベースに今回はDockerfileを作成しています.
本件にはあまり関係ないですが, `wolframresearch/wolframengine`のベースOSはUbuntu 18.04 LTSとなっています.

**Python関連パッケージのインストール**

- `ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone`の部分は, パッケージインストール時に地理的な地域を選択するように求める対話的なプロンプトが出てくる可能性に対する予防措置を実施しときます
- `git`の他のパッケージは`pyenv`インストールに必要なパッケージのみを入れています

```zsh
# install apt packages
ARG BASE_IMAGE=wolframresearch/wolframengine
FROM ${BASE_IMAGE} as base

USER root

SHELL [ "/bin/bash", "-c" ]
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get -qq -y update && \
    apt-get -qq -y install \
      software-properties-common \
      wget curl \ 
      make nodejs build-essential libssl-dev zlib1g-dev libbz2-dev \
      libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
      libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*
```


**Jupyter Lab実行スクリプトの準備**

rootユーザーの段階でJupyter Lab実行スクリプトを作成し, そのオーナーを`docker`に譲渡しておきます

```zsh
printf '#!/bin/bash\n\njupyter lab --no-browser --ip 0.0.0.0 --port 8888\n' > /docker/entrypoint.sh && \
chown -R docker /docker 
```

`/docker/entrypoint.sh`は以下のようにlogin shellの段階で自動的に実行する設定する際に用います.

```zsh
CMD ["/docker/entrypoint.sh"]
```

**pyenv & Jupyter Labのインストール**

```zsh
# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV PATH=/home/docker/.local/bin:"${PATH}"

USER docker

ENV HOME=/home/docker
ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ARG PYTHON_VERSION=3.11.4
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    pyenv install $PYTHON_VERSION && \
    pyenv global $PYTHON_VERSION &&\
    python -m pip install --upgrade pip &&  \
    pip install --no-cache-dir \
    nodejs \
    jupyterlab \
    jupyterlab_code_formatter \
    jupyterlab-git \
    lckr-jupyterlab-variableinspector \
    jupyterlab_widgets \
    ipywidgets \
    import-ipynb
```

**Wolfram engin Jupyter Kernelのインストール**

- Wolfram engin Jupyter Kernelのインストール
- WolframscriptによるJupyterへのkernel追加を実施


```zsh
WORKDIR /home/docker
ARG WOLFRAM_ID
ARG WOLFRAM_PASSWORD
RUN git clone https://github.com/WolframResearch/WolframLanguageForJupyter && \
    cd WolframLanguageForJupyter/ && \
    wolframscript \
        -activate \
        -username "${WOLFRAM_ID}" \
        -password "${WOLFRAM_PASSWORD}" && \
    wolframscript -activate && \
    ./configure-jupyter.wls add
```

### Docker image size

```zsh
% docker images          
REPOSITORY                     TAG       IMAGE ID       CREATED        SIZE
ryonak/wolfram-jupyterserver   latest    980caz0a9e6a   5 hours ago    7.29GB
```

[wolframresearch/wolframengine](https://hub.docker.com/r/wolframresearch/wolframengine)時点で6.0GB近くのサイズがあるのである程度の大きさは仕方ないと
諦めています.

### Build shell script

ImageのBuildは以下のコマンドを実行するだけで基本的には足ります.

```bash
# Docker Build
docker buildx build . \
    --file Dockerfile \
    --build-arg BASE_IMAGE=wolframresearch/wolframengine \
    --build-arg WOLFRAM_ID=$WOLFRAM_ID \
    --build-arg WOLFRAM_PASSWORD=$WOLFRAM_PASSWORD \
    --tag ryonak/wolfram-jupyterserver:latest
```

ただし`WOLFRAM_ID`, `WOLFRAM_PASSOWRD`の設定が必要で新たにBuildが必要になる機会は少ないとは思いますが
平文で毎回毎回入力するのも億劫なのでgpgで一旦account情報を格納したJSONを暗号化し, そこから情報を読み取る形のshellscriptを作成しました.


```bash
#!/bin/bash
# AUTHOR: RyoNak

set -e

# Variable
FILE=$1

# Functions
gpg_decode() {
    gpg -dq $FILE
}

# Extract config
if [[ "${FILE: -4}" == ".gpg" ]]; then
    WOLFRAM_ID=$(gpg_decode |jq -r '.WOLFRAM_ID');
    WOLFRAM_PASSWORD=$(gpg_decode |jq -r '.WOLFRAM_PASSWORD');
else
    WOLFRAM_ID=$(jq -r '.WOLFRAM_ID' $FILE);
    WOLFRAM_PASSWORD=$(jq -r '.WOLFRAM_PASSWORD' $FILE);
fi


# Docker Build
docker buildx build . \
    --file Dockerfile \
    --build-arg BASE_IMAGE=wolframresearch/wolframengine \
    --build-arg WOLFRAM_ID=$WOLFRAM_ID \
    --build-arg WOLFRAM_PASSWORD=$WOLFRAM_PASSWORD \
    --tag ryonak/wolfram-jupyterserver:latest
```

アカウント情報を格納したGPG JSON FILE(またはJSON FILE)を上記のシェルスクリプトの引数と指定した上で実行すれば
Docker image buildが実施できます.

JSONファイルのgpg化は以下のコマンドでできます

```zsh
% gpg -e -r <your-id> <暗号化したいファイル>
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: `jq -r`の意図</ins></p>

上記のWolfram account情報を格納したJSONファイルは

```json
{
    "WOLFRAM_ID":"your Wolfram ID",
    "WOLFRAM_PASSWORD":"your Wolfram ID password"
}
```

という構成をしています. ここからkeyに対応したvalueを取得したい場合は `jq`コマンドを以下のように使用します:

```zsh
% jq '.WOLFRAM_ID' <JSON FILE PATH>
"your Wolfram ID"

% jq -r '.WOLFRAM_ID' <JSON FILE PATH>
your Wolfram ID
```

上記の例でわかるように, `-r`または`--raw-output`は文字列中のダブルクォートエスケープを解除することができます.

</div>


## Example

<div class="math display" style="overflow: auto">
<iframe width="770" height="2800" src="https://nbviewer.org/github/RyoNakagami/Wolfram_playground/blob/main/example/calculate_pi.ipynb" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>





## Appendix: Jupyer LabでWolfram Language kernelを選択できるようにする

[WolframResearch / WolframLanguageForJupyter](https://github.com/WolframResearch/WolframLanguageForJupyter)を用いることでWolfram Language kernelをJupyterで選択できるようになります.

事前に`wolframscript`によるActivationが完了していないと実行できないことに注意が必要です.
設定自体は

```zsh
% git clone git@github.com:WolframResearch/WolframLanguageForJupyter.git
% cd ./WolframLanguageForJupyter
% ./configure-jupyter.wls add
```

で終了. Removeしたい場合は

```
% cd ./WolframLanguageForJupyter
% ./configure-jupyter.wls remove
```




References
--------

> Dockerfile 

- [RyoNakagami/wolfram_jupyterserver](https://github.com/RyoNakagami/wolfram_jupyterserver)

> Respositories

- [pyenv](https://github.com/pyenv/pyenv)
- [wolfram-jupyter](https://github.com/matthewfeickert/wolfram-jupyter)
- [wolframresearch/wolframengine](https://hub.docker.com/r/wolframresearch/wolframengine)
- [WolframLanguageForJupyter](https://github.com/WolframResearch/WolframLanguageForJupyter)
