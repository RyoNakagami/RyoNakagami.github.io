---
layout: post
title: "Ubuntu Desktop環境構築 Part 14"
subtitle: "Dockerによる環境構築 Part 1: Dockerのインストール"
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
|目的|Dockerによる環境構築 Part 1: Dockerのインストール|
|参考|- [初心者のためのコンテナ入門教室:連載第二回](https://thinkit.co.jp/article/17301)<br>- [開発環境、テスト環境、ステージング環境、本番環境について ](https://note.com/gunj/n/nf139710d0e4a)<br>- [Docker 概要](https://matsuand.github.io/docs.docker.jp.onthefly/get-started/overview/)<br>- [Dockerインストール](https://docs.docker.com/engine/install/ubuntu/)<br>- [Issue with WARNING: No blkio weight support](https://forums.docker.com/t/issues-with-sudo-systemctl-status-docker/98564)<br>- [Docker Tutorial Video](https://www.youtube.com/watch?v=iqqDU2crIEQ&feature=emb_logo)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [実行環境](#%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
- [2. コンテナとは？](#2-%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%A8%E3%81%AF)
  - [コンテナの概要](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E6%A6%82%E8%A6%81)
  - [なぜコンテナを使うのか・どのようなメリットがあるのか？](#%E3%81%AA%E3%81%9C%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AE%E3%81%8B%E3%83%BB%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AA%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88%E3%81%8C%E3%81%82%E3%82%8B%E3%81%AE%E3%81%8B)
    - [開発者目線：アプリケーションの可搬性をたかめる](#%E9%96%8B%E7%99%BA%E8%80%85%E7%9B%AE%E7%B7%9A%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E5%8F%AF%E6%90%AC%E6%80%A7%E3%82%92%E3%81%9F%E3%81%8B%E3%82%81%E3%82%8B)
    - [計算科学目線：分析結果の再現可能性を高める](#%E8%A8%88%E7%AE%97%E7%A7%91%E5%AD%A6%E7%9B%AE%E7%B7%9A%E5%88%86%E6%9E%90%E7%B5%90%E6%9E%9C%E3%81%AE%E5%86%8D%E7%8F%BE%E5%8F%AF%E8%83%BD%E6%80%A7%E3%82%92%E9%AB%98%E3%82%81%E3%82%8B)
    - [仮想マシンに対するコンテナのメリット](#%E4%BB%AE%E6%83%B3%E3%83%9E%E3%82%B7%E3%83%B3%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8B%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
- [3. コンテナの構造](#3-%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E6%A7%8B%E9%80%A0)
  - [コンテナの基本構成](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E5%9F%BA%E6%9C%AC%E6%A7%8B%E6%88%90)
    - [MacとWindowsにおけるDocker](#mac%E3%81%A8windows%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Bdocker)
  - [コンテナのプロセス](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E3%83%97%E3%83%AD%E3%82%BB%E3%82%B9)
    - [namespace](#namespace)
    - [cgroups](#cgroups)
  - [コンテナのネットワーク](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF)
- [4. Dockerとは？](#4-docker%E3%81%A8%E3%81%AF)
  - [Dockerの３つのフェーズ](#docker%E3%81%AE%EF%BC%93%E3%81%A4%E3%81%AE%E3%83%95%E3%82%A7%E3%83%BC%E3%82%BA)
  - [Dockerアーキテクチャ](#docker%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3)
  - [Dockerイメージとは？](#docker%E3%82%A4%E3%83%A1%E3%83%BC%E3%82%B8%E3%81%A8%E3%81%AF)
- [5. UbuntuへのDockerのインストール](#5-ubuntu%E3%81%B8%E3%81%AEdocker%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [OS requirements](#os-requirements)
  - [Uninstall old versions](#uninstall-old-versions)
  - [Install](#install)
    - [レポジトリーの設定](#%E3%83%AC%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%83%BC%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [Install Docker Engine](#install-docker-engine)
    - [Test: Hello-world](#test-hello-world)
  - [Dockerのバージョン確認](#docker%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%A2%BA%E8%AA%8D)
  - [Dockerの実行環境確認](#docker%E3%81%AE%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83%E7%A2%BA%E8%AA%8D)
  - [Docker imageの確認](#docker-image%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [Dockerのディスク利用状況: `docker system df`](#docker%E3%81%AE%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E5%88%A9%E7%94%A8%E7%8A%B6%E6%B3%81-docker-system-df)
- [6. インストール後の設定](#6-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E5%BE%8C%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [Manage Docker as a non-root user](#manage-docker-as-a-non-root-user)
- [7. Docker Fileの作成からDocker ImageのBuildまでのチュートリアル](#7-docker-file%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%8B%E3%82%89docker-image%E3%81%AEbuild%E3%81%BE%E3%81%A7%E3%81%AE%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB)
  - [Dockerfileの構文](#dockerfile%E3%81%AE%E6%A7%8B%E6%96%87)
  - [Docker buildの例](#docker-build%E3%81%AE%E4%BE%8B)
- [Appendix: サーバ仮想化技術](#appendix-%E3%82%B5%E3%83%BC%E3%83%90%E4%BB%AE%E6%83%B3%E5%8C%96%E6%8A%80%E8%A1%93)
  - [ホスト型サーバー仮想化](#%E3%83%9B%E3%82%B9%E3%83%88%E5%9E%8B%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E4%BB%AE%E6%83%B3%E5%8C%96)
  - [ハイパーバイザー型サーバー仮想化](#%E3%83%8F%E3%82%A4%E3%83%91%E3%83%BC%E3%83%90%E3%82%A4%E3%82%B6%E3%83%BC%E5%9E%8B%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E4%BB%AE%E6%83%B3%E5%8C%96)
- [Appendix: 開発環境、テスト環境、ステージング環境、プロダクション環境の違い](#appendix-%E9%96%8B%E7%99%BA%E7%92%B0%E5%A2%83%E3%83%86%E3%82%B9%E3%83%88%E7%92%B0%E5%A2%83%E3%82%B9%E3%83%86%E3%83%BC%E3%82%B8%E3%83%B3%E3%82%B0%E7%92%B0%E5%A2%83%E3%83%97%E3%83%AD%E3%83%80%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E7%92%B0%E5%A2%83%E3%81%AE%E9%81%95%E3%81%84)
- [Appendix: パブリックIPアドレスとプライベートIPアドレス](#appendix-%E3%83%91%E3%83%96%E3%83%AA%E3%83%83%E3%82%AFip%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9%E3%81%A8%E3%83%97%E3%83%A9%E3%82%A4%E3%83%99%E3%83%BC%E3%83%88ip%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9)
- [Appendix: GPGキー](#appendix-gpg%E3%82%AD%E3%83%BC)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ

- Dockerの仕組みの確認
- UbuntuへのDockerのインストール

### 実行環境

|項目| 	 |
|---|---|
|マシン|HP ENVY TE01-0xxx|
|OS|ubuntu 20.04 LTS Focal Fossa|
|CPU|Intel Core i7-9700 CPU 3.00 GHz|
|RAM|32.0 GB|
|GPU|NVIDIA GeForce RTX 2060 SUPER|


## 2. コンテナとは？

Dockerとは、アプリケーションの実行に必要な環境(ミドルウェアやライブラリやOS/ネットワークといったインフラ環境)を１つのコンテナ(Dockerコンテナ)にまとめ、そのコンテナを用いて、さまざまな環境でアプリケーション実行環境を構築/運用するためのプラットフォームのことです。Docker を使えば、アプリケーションをインフラストラクチャーから切り離すことができるため、ソフトウエアをすばやく提供することができます。 Docker であれば、アプリケーションを管理する手法をそのまま、インフラストラクチャーの管理にも適用できます。 Docker が採用する方法を最大限利用して、アプリケーションの導入、テスト、コードデプロイをすばやく行うことは、つまりコーディングと実稼動の合間を大きく削減できることを意味します。
### コンテナの概要

コンテナとは、ホストOS上に論理的な区画(コンテナ)を作り、アプリケーションを動作させるのに必要なライブラリやミドルウェアといったdependenciesを一つのコンテナにパッケージ化し、ホストOS上の独立したアプリケーション実行環境を作成できるようにしたものです。そのため、あたかも個別のサーバーが存在するように動くので、コンテナ技術を使うことで、同じホストOSの上で、バージョンの異なるPythonを同時に動かすこともできます。Virtual BoxやVMwareといった仮想環境構築ソフトと似た働きをしますが、あくまでコンテナはコンテナエンジンというプロセスを通して、ホストOSの「カーネル」を共有することでCPUやメモリなどのリソースを隔離し、仮想的な空間を作り出しています（コンテナ型仮想化といいます）。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker_container.jpg?raw=true">

### なぜコンテナを使うのか・どのようなメリットがあるのか？
#### 開発者目線：アプリケーションの可搬性をたかめる

アプリケーション開発において、プロダクション環境にできあがったプログラムをデプロイするためには次の要素が必要となります：

- アプリケーションの実行ファイル
- ミドルウェアやライブラリ
- OS/ネットワーク/ハードウェア/security patchesといったインフラ環境

アプリケーション開発は開発環境・テスト環境・ステージング環境・プロダクション環境とさまざまな環境がありますが、よく直面する問題として「開発環境ではプログラムは動作したが、ステージング/プロダクション環境では動作しない」ことが挙げられます。この問題の要因の一つとして、それぞれの環境においてミドルウェア/ライブラリを含むインフラ環境の構成が開発環境と異なるケースが多いです。コンテナ（特にDocker）は、開発したアプリケーションの実行に必要なインフラ構成要素(dependencies)を一つのコンテナ(Dockerイメージ)にまとめることで、どの環境でも同じコンテナをインストール・稼働させれば、アプリケーションが同じように動作することを可能にしてくれます。一度作ってしまえばどこでも動くソフトウェアの特性のことを可搬性（ポータビリティ）といいます。コンテナを利用すること開発した成果物のポータビリティを高めることができます。

より具体的には、複数のサーバーから構成されるE-commerceサイトのメンテナンスを担当するケースを考えます。E-commerceサイトを運用するとき100台のサーバーを同時に管理しなければならない場面は度々あります。100台のサーバーをメンテナンスするということは100個のOSをそれぞれメンテナンスするということです。セキュリティ対策の一環として、とあるSecurity patchをupgradeしなてはならない場合を考えます。このとき、対象のsecurity patchのdependenciesに注意を払いながらupgradeをする必要がありますが、ただでさえアプリケーションに配慮した上でのOSのメンテナンスは大変ですが100個のサーバーで個別に実施するとなると人員も時間も取られます。OSアップデートとアプリケーションの実行環境をコンテナによって分離できれば、security patch upgrade対応も少し楽になります。

#### 計算科学目線：分析結果の再現可能性を高める

上の開発者目線で紹介したように、コンテナ技術はdependenciesをコンテナイメージに集約し、それをインストール・可動させればどのような環境でもプログラムは同じ動作をしてくれます。計算科学の場合では、分析で活用したプログラミング言語、ライブラリやパッケージをコンテナイメージに集約することで、他人または共著者でも同じコンテナイメージを稼働させてしまえば、同じ分析手法を用いる範囲内で分析結果の再現が容易となります。このように、コンテナを用いることで研究の分析結果の再現性を高めてくれることに繋がります。分析結果の再現性が高まることは、他人が自分の分析手法を理解することを容易にし、コラボレーションの円滑化やレビューの迅速化が期待できます。分析のソースコード渡したけど、正常に動作せず文句言われるというリスクを回避することができます。

また過去の自分が実施した分析結果をしばらく時が経てから再現したい場合でも、分析環境構築がコンテナイメージを稼働させるだけで完了するので、振り返りも容易となります。

#### 仮想マシンに対するコンテナのメリット

異なる環境を別のマシンで再現することはホスト型サーバー仮想化やハイバーバイザー型仮想化技術と似ているところがあります。しかしコンテナ技術は1つのOSの上で仮想的なユーザー空間であるコンテナを作ることで仮想環境を作る一方、後者の仮想化技術ではホストOSまたはハイパーバイザーの上でゲストOSを立ち上げ、その上に仮想環境をつくります。もう少し簡単にいうと、コンテナ技術はカーネルを共有し、アプリケーションレベルでのみ分離を行っていますが、一般的な仮想マシンでは、OSレベルで環境が分離しています。そのため仮想マシンを立ち上げる(= ゲストOSを立ち上げる)際にOS用にCPU/メモリ/ストレージといったリソースを確保する必要があるのでオーバーヘッドが生じます。また仮想マシンの設定はめんどくさいです。複数の仮想マシンを同時に使うときは、仮想マシンごとにゲストOSが必要なので、設定や管理の負荷が増大するというデメリットもあります。

これに対して、コンテナ技術は以下のようなメリットがあります：

- アプリケーションを動作させるために必要な環境が、1つのコンテナで完結し、独立
- 簡単にコンテナを作成でき、増えても管理が楽
- ベースOSの機能を共有するため、OSの全機能は必要なく、オーバーヘッドを小さく抑えられる
- 新旧バージョンOSやライブラリの違いなど、開発検証環境を多数用意しなくてもいい
- 最小限のシステムでOK、ディスクスペースの節約と管理の簡素化
- ベースOSと独立したファイルシステムやデバイスを利用可能

## 3. コンテナの構造

上でも説明したように、コンテナはコンテナエンジンというプロセスを通して、ホストOSの「カーネル」を共有することでCPUやメモリなどのリソースを隔離し、仮想的な空間を作り出します。これをコンテナ型仮想化といいます。コンテナでは起動しているホストOSの「カーネル」を共有することでアプリケーションの実行土台を備えることから、コンテナの起動には従来のOSの起動といった工程が必要ないため、ハイパーバイザー型仮想マシンなどで発生するオーバヘッドがありません。

### コンテナの基本構成

コンテナ型仮想化では、その実行基盤としてハードウェアとOSを共有します。コンテナは単一のホストOS上で動作するコンテナエンジン上にプロセスとして存在し、そのエンジンが管理するシステムリソースの範囲内で、複数のコンテナを同時に動作させることができます。

コンテナの中には、ユーザが動作させたい「アプリケーション」と、そのアプリケーションの実行に必要な「ミドルウェア」、そして「ライブラリ」などが含まれます。このライブラリの中にはOSの基本的なコマンドセットやファイルシステムのライブラリなど、OSが提供する機能の一部が含まれています。OSが提供する機能の一部がコンテナに含まれる理由は、そもそもアプリケーションは、内部でOSの中核であるカーネルの機能を呼び出して動作しているからです。その代表的な例としてファイルの読み書き(I/O)が挙げられます。このようなカーネルに対する呼び出しをシステムコールといい、カーネルがシステムコールを処理することでアプリケーションを動作させています。実際にはABI(Application Binary Interface)と呼ばれる専用のインターフェース経由でやり取りされます。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker-kernel.jpeg?raw=true">

また、コンテナに必要なライブラリをパッケージとして組み込んでおくことで、ホストOSがUbuntuであったとしてもLinux系であれば別OS(別ディストリビューション)の実行環境をコンテナとして稼働することができます。Linux系と呼ばれるOS群には、RedHat Enterprise Linux(RHEL)やCentOS、Ubuntuなど様々なディストリビューション(各社の配付パッケージ)が存在しますが、基本的に共通のカーネルを使用しているからです。そのため、アプリケーションの実行に必要なライブラリさえあれば、どのディストリビューションでもアプリケーションを動作できる仕様になっています。ただし、例えばRHELで動作するように作成したアプリケーションをUbuntuで動作させようとする場合、動作環境の違い(ファイルシステムやライブラリなど)により正しく動作しません。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker-why-other-distribution-works.jpeg?raw=true">

OSのコンテナイメージはあくまでもアプリケーションの動作に必要な環境を「それっぽく」再現しているに過ぎません。コンテナの動作に必要なリソースはホストOSからコンテナエンジンを通して間借りしており、コンテナ内のアプリケーションが発行するシステムコールはホストOSで動作しているカーネルが処理します。ハイパーバイザー型仮想化のように個別のOSは存在しないため、コンテナ型仮想化ではLinuxカーネルの互換性に依存します。この点でコンテナ型仮想化はハイパーバイザー型仮想化と異なります。OS固有の機能を含めた動作環境を再現するには、コンテナ型仮想化よりもハイパーバイザー型仮想化を使用する方が良いです。

#### MacとWindowsにおけるDocker

DockerはLinuxカーネル機能を使うため、通常はLinuxディストリビューション上で動作します。しかし開発環境などで利用するためのクライアントPC向けツールも提供されています。macOS向けのDocker for MacはHypervisorフレームワークであるxhyveの上にDocker実行環境が構築されます。Windowsの場合はハイパーバイザーベースのx64向け仮想システムであるHyper-Vを使っています。

### コンテナのプロセス

Linux は命令を実行する際に、そのプログラムのソースファイルに書かれた内容を読み込み、メモリ上に展開し、そのメモリに乗ったプログラムを実行していますが、この実行されたプログラムをプロセスと呼びます。コンテナ型仮想化におけるコンテナは、ホストOS上からは1つのプロセスとして扱われるという大きな特徴があります。この仕組みを理解するためにはLinuxカーネル機能のNamespace、Cgroupsを理解する必要があります。

#### namespace

何回も繰り返し説明しているように、コンテナとはホストOS上に論理的な区画(コンテナ)を作り、独立したアプリケーション実行環境を作成できるようにしたものです。このコンテナを区画化する技術はLinuxカーネルのnamespaceという機能で実現されています。namespaceは、まとまったデータに名前をつけて分割することで衝突の可能性を減らし、参照を容易に行う機能です。名前に結び付けられた実体は、その名前がどの名前空間に属するかで一意に定まります。名前空間が異なれば、同じ名前でも別の実体に対応付けることができます。

Linuxカーネルのnamespace機能は次の６つの機能に分類されます。

|環境|説明|
|---|---|
|PID namespace|PIDとは、各プロセスに割り当てられたユニークなIDのことです。PID namespaceとは、名前空間の異なるプロセス同士は互いにアクセスできなくなる機能です。|
|Network namespace|Network namespaceは、ネットワークデバイス・IPアドレス・ポート番号などのネットワークリソースを隔離された名前空間ごとに独立してもつことを可能にする機能です。生空間が異なっていれば、ホストOS上で使用中のポートがあったとしても、コンテナ内で同じ番号のポートを使用することができます。|
|UID namespace|UID namespaceはUID/GIDを名前空間ごとに独立して設定できる機能です。コンテナ内ではrootユーザーだが、ホストOSでは一般ユーザーという設定が可能となります。|
|MOUNT namespace|名前空間ごとに独立したファイルシステムツリーを作成する機能。|
|UTS namespace|名前空間ごとにホスト名やドメイン名を独自に設定する機能。|
|IPC namespace|プロセス間通信(IPC)オブジェクトを名前空間ごとに独立させる機能。|

#### cgroups

Dockerでは、物理マシン上のリソースを複数のコンテナで共有して動作します。cgroupsはプロセスをグループ化し、CPUやメモリなどホストOSの物理的なリソースを分離する役割を担っています。例えば、プロセスが用いるCPUの使用率(e.g. CPU使用率は50%上限)やメモリの割当、デバイスへのアクセスを制御します。1つの特定のプロセスがCPUやメモリリソースを大量に消費することで、ホストOSや他のプロセスに影響が出るといったリスクをコントロールします。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker-cgroups.png?raw=true">

### コンテナのネットワーク

物理サーバには、物理的なNIC(Network Interface Card)が通信の出入り口として機能します。NICには個別のMACアドレスが割り振られており、NICに接続したLANケーブルでサーバ同士をつなげば通信自体は実現できます。ただし、膨大な数のサーバを直接つなぐには限界があります。その限界を突破するにはケーブルを集約する集線装置、つまり「スイッチ」が必要になります。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker-network.jpeg?raw=true">

コンテナ型仮想化におけるコンテナの通信では、物理サーバの物理NICとNamespaceで分離されたコンテナ内の仮想NICの間にコンテナエンジンで制御されている仮想ブリッジ(Dockerの場合docker0という仮想ブリッジ)があり、コンテナとホストOS間の橋渡しをしています。このdocker0は、Dockerを起動後にデフォルトで作成されます。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker-container-network.jpeg?raw=true">

Dockerコンテナを起動すると、コンテナに172.17.0.0/16のサブネットマスクを持つプライベートIPアドレスがeth0に自動的に割り当てられます。コンテナのeth0は、ホストOSに作成された仮想NICがペアで割り当てられます。ホストOSのNAPT(Network Address Port Translation)機能により、コンテナのプライベートIPからホストOSが持つIPへ変換されます。これでコンテナは外部と通信できるようになるわけです。簡単にイメージするなら、とあるマンションに住んでいるとして、ホストOSのIPは住所、コンテナのIPはただの部屋番号に過ぎないと解釈できます。

NAPTとは、１つのIPアドレスを複数のコンピューターで共有する技術で、IPアドレスとポート番号を変換する機能です。プライベートIPアドレスと、グローバルIPアドレスを透過的に相互変換する技術で、TCP/UDPのポート番号まで動的に変換されるため、１つのグローバルIPアドレスで複数のマシンから同時に接続することができます。Dockerでは、NAPTにLinuxのiptablesを使っています。Dockerでこの機能を使うときは、コンテナの起動時にコンテナ内で使っているポートを仮想ブリッジdocker0に対して開放します。たとえば、コンテナの起動時にコンテナ内のWebサーバが使用する80番ポートを、ホストOSの8080番ポートに転送するよう設定します。すると、外部のネットワークからホストOSの8080番ポートにアクセスすると、コンテナ内の80番ポートに繋がります。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker-NAPT.png?raw=true">

## 4. Dockerとは？

上ではコンテナ技術の概要を紹介しましたが、ここではコンテナの動作に不可欠なコンテナエンジンについて、実質的なデファクトスタンダードのDockerについて紹介します。Dockerの重要な構成要素は「Docker Engine」と「Docker Hub」です。

- Docker Engineは、アプリケーション本体とそれを実行するための環境を1つのDockerイメージにまとめることができます。そして、移動先でDockerイメージに基づいてコンテナを実行させ、簡単かつ高速にアプリケーションを起動できます。

- Docker HubはDockerイメージの移動や管理、Dockerイメージを共有する場としての役割を果たします(いわゆるリポジトリ)。Docker Hubの「Automated Build」の機能でGitHubと連携させれば、自動でDockerイメージを作成することもできます。DockerイメージをプライベートレジストリやDockerHubなどへアップロードすることをプッシュといい、逆にダウンロードすることをプルといいます。

### Dockerの３つのフェーズ

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_docker_works.jpeg?raw=true">


|DockerのPhase|説明|
|---|---|
|`Build Image`|アプリケーションが必要とするdependenciesをconsistentlyにパッケージ化するフェーズ|
|`Ship Image`|Build Phaseで作成されたイメージを実行環境に移植するフェーズ|
|`Run Image`|Imageを実行して、アプリケーション実行環境を作成するフェーズ|

### Dockerアーキテクチャ

Docker はクライアントサーバー型のアーキテクチャーを採用しています。 Docker クライアント は Docker デーモンに処理を依頼します。 このデーモンは、Docker コンテナーの構築、実行、配布という複雑な仕事をこなします。 Docker クライアントとデーモンは同一システム上で動かすことも 可能 ですが、別のシステム上であっても、Docker クライアントからリモートにある Docker デーモンへのアクセスが可能です。 Docker クライアントとデーモンの間の通信には REST API が利用され、UNIX ソケットまたはネットワークインターフェイスを介して行われます。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker_architecture.png?raw=true">

|項目|説明|
|---|---|
|Docker デーモン|Docker デーモン（dockerd）は Docker API リクエストを受け付け、イメージ、コンテナー、ネットワーク、ボリュームといった Docker オブジェクトを管理します。 また Docker サービスを管理するため、他のデーモンとも通信を行います。|
|REST API|プログラムとデーモンとの間での通信方法を定義し、何をなすべきかを指示する。|
|Docker クライアント|Docker クライアント（docker）は Docker とのやりとりを行うために、たいていのユーザーが利用するものです。 docker run のようなコマンドが実行されると、Docker クライアントは dockerd にそのコマンドを伝えます。 そして dockerd はその内容を実現します。 docker コマンドは Docker API を利用しています。 Docker クライアントは複数のデーモンと通信することができます。|
|Docker オブジェクト|イメージ、コンテナー、ネットワーク、データボリュームなどです。|

### Dockerイメージとは？

Dockerイメージとは、Dockerコンテナーを作成する命令が入った読み込み専用のテンプレートです。 イメージは作ろうと思えば作ることができ、他の方が作ってレジストリに公開されているイメージを使うということもできます。 イメージを自分で作る場合は Dockerfile というファイルを生成します。DockerfileはDocker Imageにブループリントみたいなものです。このファイルの文法は単純なものであり、そこにはイメージを生成して実行するまでの手順が定義されます。アプリケーションが動作する土台となるインフラ環境を構築するコマンドや手順などを所定の書き方でDockerfileに記載すれば、その作業は全部Dockerが自動でやってくれます。 Dockerfileからベースイメージを使用してDockerイメージを作成することをビルドといいます。また、既に起動されたDockerコンテナからイメージを作成することをコミットと呼びます。

DockerイメージはUFS(Union File System)という、複数のファイルやディレクトリをレイヤ(層)として積み重ねて、仮想的に1つのファイルシステムとして扱う技術を用いています。Dockerfile 内の個々の命令ごとに、イメージ内にはレイヤーというものが生成されます。 Dockerfile の内容を書き換えたことでイメージが再構築されるときには、変更がかかったレイヤーのみが再生成されます。これをコピーオンライトと呼びます。 他の仮想化技術に比べて Dockerイメージというものが軽量、小さい、早いを実現できているのも、そういった部分があるからです。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker_layer.jpeg?raw=true">

さらにもう一つの特徴として、同一のホスト上で動く複数のコンテナがある場合は、イメージレイヤを共有できます。これにより、ホストのストレージ容量の圧迫を抑制できるようになります。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker_share_layer.jpeg?raw=true">

## 5. UbuntuへのDockerのインストール

Docker は コミュニティ版（CE; Community Edition） と エンタープライズ版（EE; Enterprise Edition） の２つのエディションがあります。今回はCE版のインストール方法を紹介します。

### OS requirements

Docker Engineは`x86_64`(or `amd64`), `armhf`, `arm64` architecturesでサポートされています。サポートされているUbuntuのversionは以下、

- Ubuntu Groovy 20.10
- Ubuntu Focal 20.04 (LTS)
- Ubuntu Bionic 18.04 (LTS)
- Ubuntu Xenial 16.04 (LTS)

今回は、`x86_64`アーキテクチャでのインストール方法を紹介します。

### Uninstall old versions

古いversionのdockerがインストールされている場合があるので一旦アンインストールします。

```
% sudo apt-get remove docker docker-engine docker.io containerd runc
```

images, containers, volumes, and networksといったdockerオブジェクトは`/var/lib/docker/`に保存されていますが、上記のコマンドを実行してもこれらdockerオブジェクトは削除されません。これらを削除したい場合は`sudo rm -rf /var/lib/docker`を実行します。

### Install

手順としては

1. Docker repositoryの登録
2. Docker Engineのインストール

となります。

#### レポジトリーの設定

まずいつもどおりにpackage indexのupdateを実施します

```
% sudo apt update
```

次にSetupに必要なpackageのインストールをします（HTTPS経由でレポジトリを使用できるようにするため）。

```
% sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```

次にDockerの公式GPGキーを追加します。

```
% curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Dockerの公式GPGキーが追加されているかどうか確認します。

```
% sudo apt-key fingerprint 0EBFCD88                                                                                                                                                                          ?master[sudo] password for ryo_nak: 
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```

最後にDockerのレポジトリを登録します。今回は`stable`版を登録します。

```
% sudo add-apt-repository \                                 
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

#### Install Docker Engine

Docker EngineとcontainerdとCLIをインストールします。

```
% sudo apt install docker-ce docker-ce-cli containerd.io
```

#### Test: Hello-world

インストールしたDockerが正しく動作するか確認テストします。

```
% sudo docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

### Dockerのバージョン確認

インストールしたDockerのバージョンを確認するには、`docker version`コマンドを使います。

```
% docker version
Client: Docker Engine - Community
 Version:           20.10.2
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        2291f61
 Built:             Mon Dec 25 16:17:43 2020
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.2
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       8891c58
  Built:            Mon Dec 25 16:15:19 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.3
  GitCommit:        269548fa27e0089a8b8278fc4fc781d7f65a939b
 runc:
  Version:          1.0.0-rc92
  GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

### Dockerの実行環境確認

`docker system info`コマンドを実行すると、Dockerの実行環境の詳細設定が表示されます。

```
% docker system info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Build with BuildKit (Docker Inc., v0.5.1-docker)

Server:
 Containers: 3 #コンテナの数
  Running: 0
  Paused: 0
  Stopped: 3
 Images: 40
 Server Version: 20.10.2  # Dockerのバージョン
 Storage Driver: overlay2 # ストレージドライバーの種類
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: true
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 1
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 io.containerd.runtime.v1.linux runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 269548fa27e0089a8b8278fc4fc781d7f65a939b
 runc version: ff819c7e9184c13b7c2607fe6c30ae19403a7aff
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: default
 Kernel Version: 5.8.0-41-generic
 Operating System: Ubuntu 20.04.1 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 8
 Total Memory: 31.24GiB
 Name: <user name>
 ID: <ID>
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

### Docker imageの確認

`docker image ls`(または`docker images`)でイメージの確認が実施できます。

```
% docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
example      latest    2345asdasd22   5 days ago      2.5GB
(略)
```

### Dockerのディスク利用状況: `docker system df`

`docker system df`コマンドはDockerが使用しているディスクの利用状況が表示されます。

```zsh
% docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          10        2         6.757GB   5.487GB (81%)
Containers      5         0         70.29MB   70.29MB (100%)
Local Volumes   1         0         258.6MB   258.6MB (100%)
Build Cache     0         0         0B        0B
```

詳細を表示したい場合は`-v` optionを追加します。

## 6. インストール後の設定
### Manage Docker as a non-root user

The Docker daemonはTCP portではなく Unix socketにバインドされています。デフォルトではUnix socketは`root` userの管理下となっており、他のユーザーは`sudo`コマンドを用いてアクセスする必要があります。そのためデフォルトでは、Dockerを起動するとき`sudo`コマンドを用いる必要がありますが、今回はその設定を変更し、自分が指定したユーザーならば`sudo`コマンドを用いなくてもDockerを起動できるように変更します。

まず、`docker` groupを作成します。

```
% sudo groupadd docker
```

自分が指定するユーザーを`docker` groupに加えます（current userを今回は加えます）

```
% sudo usermod -aG docker $USER
```

次にdocker groupの変更を反映します。

```
% newgrp docker
```

最後にhello-worldのテストをします。

```
% docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```

## 7. Docker Fileの作成からDocker ImageのBuildまでのチュートリアル

こちらの[記事](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)を参考にしています。

### Dockerfileの構文

Dockerfileに記載された指示にしたがってDockerはコンテナを作ります。

```Dockerfile
FROM ubuntu:18.04
COPY . /app
RUN make /app
CMD python /app/app.py
```

|指示|説明|
|---|---|
|`FROM`|ベースレイヤーを定義しています。今回は`ubuntu:18.04`|
|`COPY`|`COPY` 命令は `<src>` からファイルやディレクトリを新たにコピーして、コンテナ内のファイルシステムのパス `<dest>` に追加します。今回はDocker Client側のカレントディレクトリすべてのファイルを`/app`に追加しています。|
|`RUN`|`RUN` 命令は、現在のイメージの最上位の最新レイヤーにおいて、あらゆるコマンドを実行します。|
|`CMD`|`CMD`命令はコンテナイメージを実行する時、自動的に実行するコマンドを指定しています。|

### Docker buildの例

tagで`helloapp:v1`と名付けたイメージを作成します。なお、`Docker build -h`で確認するとTagオプションの使用方法は以下。

```raw
 -t, --tag list                Name and optionally a tag in the 'name:tag' format
```

Docker fileの作成とbuildを実行します。

```zsh
mkdir myproject && cd myproject
echo "hello" > hello
echo -e "FROM busybox\nCOPY /hello /\nRUN cat /hello" > Dockerfile
docker build -t helloapp:v1 .
```

実行後、作成されたDocker imageを確認します。

```zsh
% docker images
REPOSITORY                                                        TAG       IMAGE ID       CREATED          SIZE
helloapp                                                          v1        eab00ecb1bfb   11 seconds ago   1.23MB
```

次にこのDOcker imageを削除します。基本的には`docker rmi <image ID>`となります。

```zsh
% docker rmi eab00ecb1bfb
```

## Appendix: サーバ仮想化技術
### ホスト型サーバー仮想化

仮想化ソフトが既存のオペレーティングシステム（ホストOS）上にアプリケーションの一つとしてインストールされ、この中で追加のオペレーティングシステム（ゲストOS）を実行することで仮想環境を作る仕組みです。Oracle VM VirtualBoxが有名どころです。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker_host-vm.png?raw=true">


### ハイパーバイザー型サーバー仮想化

ハイパーバイザがハードウェア上で直接動作 (=ベアメタル実装)し、全てのOS（ゲストOS）はそのハイパーバイザ上で動作する方式のことです。Xen, VMwareの ESX、ESXi、vSphere, L4マイクロカーネルファミリー, TRANGO, マイクロソフトのHyper-V, LinuxのKernel-based Virtual Machine (KVM), SELTECHのFOXvisorが有名どころ。

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/20210127_ubuntu_docker_hypervisor-vm.png?raw=true">

## Appendix: 開発環境、テスト環境、ステージング環境、プロダクション環境の違い

|環境|説明|
|---|---|
|開発環境|開発環境とは開発者（プログラマー）がアプリケーションのプログラム本体を開発するために利用する環境のことです。環境の用意と管理は開発者側で行います。|
|テスト環境|できあがったプログラムの動作を検証する環境です。秘匿性の高い情報を扱う場合もあるので環境の用意と管理はクライアント側で行うのが望ましいと思いますが、状況により制作会社側で行うこともあります。<br><br>誤記やリンクミス、動作に不具合が無いかを検証・修正します。|
|ステージング環境|プロダクション環境とほぼ同じ環境になります。同じ環境とは、リバース プロキシ、SSL 設定、またはロードバランサなどを含めてプロダクション環境と同じ構成にし、プロダクション環境をほぼ複製したものになります。アップするファイルもプロダクション環境と同じものだけです。テスト環境でOKが出たものをデプロイ（UP + 実行）し、動作や不具合が無いかを最終チェックします。テスト環境とはサーバ構成が異なるため、テスト環境では問題が無くてもステージング環境では問題が出る場合があり、ステージングで問題が出るということは本番でも同じ問題が出る可能性が限りなく高いということになります。<br><br> 動作や表示など閲覧するのに問題が無いかが焦点になります。|
|プロダクション環境|アプリケーションが製品としてデプロイされ、運用担当や実際のユーザ（顧客）がシステムを利用する実稼働環境。ステージングでテスト（レビュー）が完了した機能・特徴が提供されます。|

## Appendix: パブリックIPアドレスとプライベートIPアドレス

インターネットで使わているTCP/IPというプロトコルでは、通信先を特定するのにIPアドレスを用います。IPアドレスは、ネットワーク上で互いに重複しないユニークな番号で、いわゆる住所に相当します。住所に相当する方のIPアドレスはパブリックIPアドレスと言われ、各ユーザーは自由に設定することができません。一方、自由に使えるIPアドレスはプライベートIPアドレスといいます。IPv4におけるプライベートIPアドレスの範囲は定義されており、以下のようになります。

|IPアドレス範囲|
|---|
|`10.0.0.0`~`10.255.255.255`|
|`172.16.0.0`~`172.31.255.255`|
|`192.168.0.0`~`192.168.255.255`|

## Appendix: GPGキー

GPGキーとは「GnuPG」（GNU Privacy Guard）という暗号化ソフトで生成される公開鍵です。Linuxの場合，apt-getコマンドやyumコマンドを使ってインターネットから入手できるパッケージが正しい配布先のものかどうかのチェックなどに利用しています。
