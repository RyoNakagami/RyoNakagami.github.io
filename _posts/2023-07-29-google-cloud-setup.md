---
layout: post
title: "個人用gcloud project設定"
subtitle: "個人用アカウントとその他アカウントの両立"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-02-21
tags:

- google cloud
- Ubuntu 22.04 LTS
- cloud
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [はじめに](#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB)
  - [Prerequisites](#prerequisites)
  - [gcloud CLIインストールの確認](#gcloud-cli%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [デフォルトのconfigurationの確認](#%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%81%AEconfiguration%E3%81%AE%E7%A2%BA%E8%AA%8D)
- [gcloud configの設定](#gcloud-config%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [bq commandのテスト](#bq-command%E3%81%AE%E3%83%86%E3%82%B9%E3%83%88)
- [gcloud configコマンド](#gcloud-config%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [configの切り替え](#config%E3%81%AE%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88)
  - [不要なconfgの削除](#%E4%B8%8D%E8%A6%81%E3%81%AAconfg%E3%81%AE%E5%89%8A%E9%99%A4)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## はじめに

個人用に新たにGoogle Cloud projectを設定し, そのprojectを対象にlocal側から
`gcloud`をコマンドを叩けるようにする設定をまとめます.

この手法は同一アカウントのprojectの切り替えに加えて, アカウント自体の切り替えにも活用できます.


### Prerequisites

- 個人用project作成済み
- gcloud CLIインストール済み(see [here](https://cloud.google.com/sdk/docs/install#deb))
- `gcloud init`ですでにデフォルトのconfigurationは作成済み

### gcloud CLIインストールの確認

gcloud CLIインストール済みかどうかはTerminalで

```zsh
% gcloud --version
Google Cloud SDK 441.0.0
bq 2.0.95
bundled-python3-unix 3.9.16
core 2023.07.28
gcloud-crc32c 1.0.0
gsutil 5.25
Updates are available for some Google Cloud CLI components.  To install them,
please run:
  $ gcloud components update
```

上記のような出力が確認できれば大丈夫です.

### デフォルトのconfigurationの確認

なにかしらのconfigurationが設定されている場合

```zsh
% gcloud init
Welcome! This command will take you through the configuration of gcloud.

Settings from your current configuration [default] are:
compute:
  region: asia-northeast1
  zone: asia-northeast1-b
core:
  account: hosinokirby@gmail.com
  disable_usage_reporting: 'True'
  project: dedede-daioh

Pick configuration to use:
 [1] Re-initialize this configuration [default] with new settings 
 [2] Create a new configuration
 [3] Switch to and re-initialize existing configuration: [pokemon]
Please enter your numeric choice:
```

という出力となるはずです. ただ, この情報はUbuntuにおいては`~/.config/gcloud`配下につくられており, 
直接確認しに行くことも出来ます. または, `gcloud config configurations list` で確認することもできます.

```zsh
% gcloud config configurations list
NAME     IS_ACTIVE  ACCOUNT                    PROJECT               COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default  True       hoshinokirby@gmail.com     dedede-daioh          asia-northeast1-b     asia-northeast1
pokemon  False      hoshinokirby@gmail.com     pokemon               asia-northeast1-a     asia-northeast1
```

## gcloud configの設定

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>手順</ins></p>

1. configurationの追加とactivate
2. accountの追加
3. projectの設定
4. compute/zone, compute/regionの設定

</div>

既存の設定に加えて新しいconfigurationを追加します. ここでは`test`とします.

```zsh
% gcloud config configurations create test
Created [test].
Activated [test].
```

作成とともに`activated`されます. このとき, まだ他の設定はしていないので

```zsh
% gcloud config configurations list
NAME     IS_ACTIVE  ACCOUNT                    PROJECT               COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default  False      hoshinokirby@gmail.com     dedede-daioh          asia-northeast1-b     asia-northeast1
pokemon  False      hoshinokirby@gmail.com     pokemon               asia-northeast1-a     asia-northeast1
test     True
```

次にアカウントの設定を行います. 他の設定のアカウントと異なり`mudahmudahmudah@gmail.com`のアカウントで設定するとします.
これはaccess認証がまだ済んでいないので`gcloud auth login`が必要となります.

```zsh
## accountの設定
% gcloud config set account mudahmudahmudah@gmail.com
```

access認証がまだ未実施なので, project一覧を取得しようとすると以下のようなエラーが出ます.

```zsh
% gcloud projects list
ERROR: (gcloud.projects.list) Your current active account [mudahmudahmudah@gmail.com] does not have any valid credentials
Please run:

  $ gcloud auth login

to obtain new credentials.

For service account, please activate it first:
  $ gcloud auth activate-service-account ACCOUNT
```

次に`gcloud auth login`を叩くと, 認証ページURLが表示されるのでブラウザでloginします.
login後, `You are now logged in as [mudahmudahmudah@gmail.com].`が以下のように表示されます.

```zsh
## access credentialsの取得
% gcloud auth login
Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?.....


You are now logged in as [mudahmudahmudah@gmail.com].
Your current project is [None].  You can change this setting by running:
```

次に, project, compute/zone, compute/regionを設定します. 

```zsh
% gcloud config set project dio-the-world
% gcloud config set compute/zone asia-northeast1-b
% gcloud config set compute/region asia-northeast1
```

設定が成功した場合, 以下のように設定一覧が見えるはずです

```zsh
% gcloud config configurations list
NAME     IS_ACTIVE  ACCOUNT                    PROJECT               COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default  False      hoshinokirby@gmail.com     dedede-daioh          asia-northeast1-b     asia-northeast1
pokemon  False      hoshinokirby@gmail.com     pokemon               asia-northeast1-a     asia-northeast1
test     True       mudahmudahmudah@gmail.com  dio-the-world         asia-northeast1-b     asia-northeast1
```

### bq commandのテスト

local側に存在する, 四半期ごとの中国のGDPを格納した`gdpquarterlychina1992Jan_2017Apr.csv`をBQに上げてみます.

```zsh
### gdpquarterlychina1992Jan_2017Apr.csv
time_index,GDP
1992-03-31,5234.8
1992-06-30,6536.8
1992-09-30,7122.5
1992-12-31,8174.3
1993-03-31,6803.1
...

### schema.json
[
  {
    "name": "time_index",
    "type": "DATE",
    "mode": "REQUIRED",
    "description": "quarter"
  },
  {
    "name": "GDP",
    "type": "FLOAT",
    "mode": "NULLABLE",
    "description": "Chinese quaterly GDP"
  }
]
```

まず, datasetを作成します. ちゃんと明示的にlocationは設定しましょう.

```zsh
% bq --location asia-northeast1 mk -d \
        --description "For personal Use or statistical analysis." \
        timeseries_dataset
Dataset 'dio-the-world:timeseries_dataset' successfully created.

% bq ls
      datasetId       
 -------------------- 
  timeseries_dataset 
```

次にテーブルを作成します. headerがカラム名となっているのでskipを指定します.

```zsh
## syntax
bq --location=location load \
    --source_format=format\
    dataset.table\
    path_to_source\
    schema

## 実行
% bq load  \
        --source_format=CSV \
        --skip_leading_rows=1 \
        timeseries_dataset.gdpquarterlychina1992Jan_2017Apr \
        ./gdpquarterlychina1992Jan_2017Apr.csv \
        ./schema.json

Upload complete.
Waiting on bqjob_ ... (0s) Current status                                                                             Waiting on bqjob_ ... (0s) Current status: DONE 
```

もし間違ったものを上げてしまった場合は

```zsh
% bq rm -t timeseries_dataset.gdpquarterlychina1992Jan_2017Apr
```

四半期別GDPを年間換算に直してLockerで簡単に可視化すると以下のようになります

<img src="https://raw.githubusercontent.com/ryonakimageserver/omorikaizuka/e6a3c6b1cee97d4452fb9004ff3f8981bd0e7157/blog/Ubuntu/googlecloud/Lookerexample.png">


## gcloud configコマンド
### configの切り替え

```zsh
% gcloud config configurations activate <config name>
```

でconfigを切り替えることが出来ます. `default`へ切り替えたい場合の例として

```zsh
% gcloud config configurations activate default
Activated [default].
```

### 不要なconfgの削除

なお以下のコマンドはactiveなconfigに対しては使用できません. 
使用する前に別configへのactivateを実行するようにしてください.


```zsh
## 一つのconfigの削除
% gcloud config configurations delete my-config

## 複数configの削除
% gcloud config configurations delete my-config1 my-config2
```


References
----------
- [Cloud SDK > Documentation > Guides > Install the gcloud CLI](https://cloud.google.com/sdk/docs/install#deb)