---
layout: post
title: "MacBookPro2016年モデルにUbuntu 22.04 LTSをインストールする"
subtitle: ""
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: true
last_modified_at: 2024-02-29
tags:

- Ubuntu 22.04
- Linux

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc -->
<!-- END doctoc -->


</div>

## 記事のスコープ

- MacBook Pro (13-inch, 2016, Thunderbolt 3ポートx 2)を対象にUbuntu 22.04 LTSをインストールする
- GPU Usage monitoring toolの導入

**MacBook Proについて**

|項目|説明|
|---|---|
|CPU modelname|Intel(R) Core(TM) i5-6360U CPU @ 2.00GHz|
|CPU max MHz|3100.0000|
|CPU min MHz| 400.0000|
|Thread(s) per core|2|
|Core(s) per socket|2|
|Socket(s)|2|
|Memory|LPDDR3 8GB × 2本|
|GPU|Intel Iris Graphics 540|
|Storage|256GB PCIe-based onboard SSD|


## GPU monitoring

Intel Iris Graphics 540の使用状況をモニタリングするため

- `intel_gpu_top`: GPUの使用状況を表示
- `sysmon`: GPU memoryの使用状況を表示

の2つをセットアップします.

前提条件としてUbuntuインストール済みMBPにてGPUが認識しているのか確認します.

```bash
$ lspci -k | grep -EA2 'VGA|video|3D'
00:02.0 VGA compatible controller: Intel Corporation Iris Graphics 540 (rev 0a)
	Subsystem: Apple Inc. Iris Graphics 540
	Kernel driver in use: i915
```

### `intel_gpu_top`コマンド: GPU使用状況の確認

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>intel_gpu_top</ins></p>

- intel_gpu_topは、Intel GPUの使用状況情報を表示するためのツール.
- i915およびRAPL（電力）やUncore IMC（メモリ帯域幅）などの他のプラットフォームドライバが公開するperf performance counter（PMU）を使用してデータを収集している

</div>

まず, `intel-gpu-tools`をインストールします

```bash
## install
$ sudo apt install intel-gpu-tools
```

利用はTerminalにて以下のコマンドを入力します

```bash
$ intel_gpu_tool
```

コマンドを実行すると, 現在のGPU使用状況がリアルタイムで以下のように確認することができます.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/mac_ubuntu/20240227_intel_gpu_top.png?raw=true">

表示を停止したい場合は`q`コマンドを入力します.

### `nvtop`: GPU使用状況をplotでモニタリング

processと紐づく形でGPU利用状況もモニタリングしたい場合は`intel_gpu_top`ではなく`nvtop`を[GitHub Repository]((https://github.com/Syllo/nvtop))からBuildします.

まずBuildにひつようなパッケージをインストールします

```bash
$ sudo apt install libdrm-dev libsystemd-dev cmake
```

その後, repositoryをcloneしてbuildします

```bash
$ git clone https://github.com/Syllo/nvtop.git
$ mkdir -p nvtop/build && cd nvtop/build
$ cmake .. -DNVIDIA_SUPPORT=ON -DAMDGPU_SUPPORT=ON -DINTEL_SUPPORT=ON
$ make

# Install globally on the system
$ sudo make install
```

利用する場合は`nvtop`コマンドを実行するだけです.

```bash
$ nvtop
```

なお起動時に「**This version of Nvtop does not yet support reporting all data for INtel GPUs, such as memory, power, fan and temperature information**」とでてきます.




References
----------
- [MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports) - Technical Specifications](https://support.apple.com/kb/SP747?locale=en_US)
- [GitHub > Syllo/nvtop](https://github.com/Syllo/nvtop)
