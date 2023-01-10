---
layout: post
title: "LinuxのGPU機械学習環境構築: GPUドライバ/CUDA toolkitのインストール"
subtitle: "Ubuntu Desktop Datascience環境構築 2/N"
author: "Ryo"
header-img: "img/about-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 
tags:

- Ubuntu 20.04 LTS
- GPU
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [実行環境](#%E5%AE%9F%E8%A1%8C%E7%92%B0%E5%A2%83)
- [解決したい問題](#%E8%A7%A3%E6%B1%BA%E3%81%97%E3%81%9F%E3%81%84%E5%95%8F%E9%A1%8C)
- [方針と実行](#%E6%96%B9%E9%87%9D%E3%81%A8%E5%AE%9F%E8%A1%8C)
  - [apt repositoryの追加](#apt-repository%E3%81%AE%E8%BF%BD%E5%8A%A0)
  - [GPU driverのインストール](#gpu-driver%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [GPUの設定画面を開く](#gpu%E3%81%AE%E8%A8%AD%E5%AE%9A%E7%94%BB%E9%9D%A2%E3%82%92%E9%96%8B%E3%81%8F)
  - [CUDA toolkitのインストール](#cuda-toolkit%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [CUDAコードサンプルのCompile](#cuda%E3%82%B3%E3%83%BC%E3%83%89%E3%82%B5%E3%83%B3%E3%83%97%E3%83%AB%E3%81%AEcompile)
- [References](#references)

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
4. CUDA toolkitのインストール & Compile test

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

### CUDA toolkitのインストール

```zsh
% sudo apt update
% sudo apt install nvidia-cuda-toolkit
% nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2019 NVIDIA Corporation
Built on Sun_Jul_28_19:07:16_PDT_2019
Cuda compilation tools, release 10.1, V10.1.243
```

### CUDAコードサンプルのCompile

以下のコードを`hello.cu`というファイルで作成し, テストする.

```c
#include <stdio.h>

__global__
void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i];
}

int main(void)
{
  int N = 1<<20;
  float *x, *y, *d_x, *d_y;
  x = (float*)malloc(N*sizeof(float));
  y = (float*)malloc(N*sizeof(float));

  cudaMalloc(&d_x, N*sizeof(float)); 
  cudaMalloc(&d_y, N*sizeof(float));

  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice);

  // Perform SAXPY on 1M elements
  saxpy<<<(N+255)/256, 256>>>(N, 2.0f, d_x, d_y);

  cudaMemcpy(y, d_y, N*sizeof(float), cudaMemcpyDeviceToHost);

  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = max(maxError, abs(y[i]-4.0f));
  printf("Max error: %f\n", maxError);

  cudaFree(d_x);
  cudaFree(d_y);
  free(x);
  free(y);
}
```

> Compile Test

```zsh
% nvcc -o hello hello.cu 
% ./hello 
Max error: 0.000000
```

## References

- [How to install CUDA on Ubuntu 20.04 Focal Fossa Linux](https://linuxconfig.org/how-to-install-cuda-on-ubuntu-20-04-focal-fossa-linux)
