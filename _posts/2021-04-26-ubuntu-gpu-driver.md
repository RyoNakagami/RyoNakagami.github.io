---
layout: post
title: "LinuxのGPU機械学習環境構築: GPUのドライバのインストール"
subtitle: "Ubuntu Desktop Datascience環境構築 2/N"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 
tags:

- Ubuntu 20.04 LTS

---



||概要|
|---|---|
|目的|LinuxのGPU機械学習環境構築: GPUのドライバのインストール|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [実行環境](#%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
- [解決したい問題](#%E8%A7%A3%E6%B1%BA%E3%81%97%E3%81%9F%E3%81%84%E5%95%8F%E9%A1%8C)
- [方針と実行](#%E6%96%B9%E9%87%9D%E3%81%A8%E5%AE%9F%E8%A1%8C)
  - [apt repositoryの追加](#apt-repository%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [GPU driverのインストール](#gpu-driver%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [GPUの設定画面を開く](#gpu%E3%81%AE%E8%A8%AD%E5%AE%9A%E7%94%BB%E9%9D%A2%E3%82%92%E9%96%8B%E3%81%8F)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 実行環境

|項目||
|---|---| 	 
|マシン| 	HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| 	Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 	32.0 GB|
|GPU| 	NVIDIA GeForce RTX 2060 SUPER|

## 解決したい問題

- デフォルトだとGPUのドライバがインストールされていないため、ディスプレイに表示される画面も解像度が低く、またこのままでは機械学習などの仕事をするときにGPUが使えない
- NVIDIA gpu driverをインストールする

## 方針と実行

基本方針は

1. NDIVIA GPU repositoryの追加
2. 推奨ドライバーの確認
3. 推奨ドライバーのインストールとreboot

### apt repositoryの追加

オフィシャルリポジトリのNDIVIA GPU driverは古いバージョンしかない恐れがあるので、まず[こちら](https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa)のNDIVIA レポジトリを追加します.

```zsh
% sudo apt update && sudo apt upgrade
% sudo add-apt-repository ppa:graphics-drivers/ppa
% sudo apt update
```
### GPU driverのインストール

```zsh
% ubuntu-drivers devices
vendor   : NVIDIA Corporation
model    : TU106 [GeForce RTX 2060 SUPER]
driver   : nvidia-driver-460 - third-party non-free recommended
driver   : nvidia-driver-460-server - distro non-free
driver   : nvidia-driver-450-server - distro non-free
driver   : nvidia-driver-465 - distro non-free
driver   : xserver-xorg-video-nouveau - distro free builtin
```

`nvidia-driver-460`が`recommended`となっているのでこれをインストールします. その後、再起動します.

```zsh
% sudo apt install -y nvidia-driver-460
% reboot
```

再起動するとnvidia-smiコマンドが使えて、ドライバが機能します。その確認方法として `nvidia-smi` コマンドがあります.

```zsh
% nvidia-smi
Mon Jun 14 21:54:28 2021       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 460.84       Driver Version: 460.84       CUDA Version: 11.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  GeForce RTX 206...  Off  | 00000000:01:00.0  On |                  N/A |
| 43%   43C    P0    43W / 175W |   1296MiB /  7974MiB |      9%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      xxxx      G   /usr/lib/xorg/Xorg                 77MiB |
|    0   N/A  N/A      xxxx      G   /usr/lib/xorg/Xorg                293MiB |
|    0   N/A  N/A      xxxx      G   /usr/bin/gnome-shell              110MiB |
|    0   N/A  N/A      xxxx      G   /usr/lib/firefox/firefox          765MiB |
|    0   N/A  N/A      xxxx      G   /usr/lib/firefox/firefox            3MiB |
|    0   N/A  N/A      xxxx      G   /usr/lib/firefox/firefox            3MiB |
|    0   N/A  N/A      xxxx      G   /usr/lib/firefox/firefox            3MiB |
|    0   N/A  N/A      xxxx      G   /usr/lib/firefox/firefox            3MiB |
+-----------------------------------------------------------------------------+

```

### GPUの設定画面を開く

nvidia-settingsコマンドでGPUの設定画面を開くことができる

```zsh
% nvidia-settings
```
