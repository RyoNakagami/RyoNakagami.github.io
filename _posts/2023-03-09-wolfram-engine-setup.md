---
layout: post
title: "Wolfram Engineをローカルで使用できるようにするまで"
subtitle: "Ubuntu Desktop環境構築 Part 27"
author: "Ryo"
header-img: "img/cpu.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-03-09
purpose: 
tags:

- Wolfram Engine
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Wolfram Engine設定手順](#wolfram-engine%E8%A8%AD%E5%AE%9A%E6%89%8B%E9%A0%86)
  - [Wolfram EngineのInstall](#wolfram-engine%E3%81%AEinstall)
  - [Wolfram EngineのActivation](#wolfram-engine%E3%81%AEactivation)
- [Jupyer notebookでWolfram Language kernelを選択できるようにする](#jupyer-notebook%E3%81%A7wolfram-language-kernel%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)
  - [手順](#%E6%89%8B%E9%A0%86)
  - [Removeしたい場合](#remove%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88)
- [Example](#example)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## Wolfram Engine設定手順


> 実行環境

実行環境

|項目||
|---|---| 	 
|マシン| HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 32.0 GB|
|GPU| NVIDIA GeForce RTX 2060 SUPER|

> Install Version

---|---
Version| Wolfram Engine 13.2
URL|https://www.wolfram.com/engine/

### Wolfram EngineのInstall

> 事前準備

- Walfram Alphaのアカウントを作成する
- Free Wolfram Engine Licenseを用意する(ダウンロード時についてくる)
- インストーラーを公式ページからダウンロードする(`sudo apt-get install wolfram-engine`でも良い)


> ローカル側での設定

```zsh
% sudo bash WolframEngine_13.2.0_LINUX.sh
```

その後以下２回ユーザー入力が求められる. 特段の要件がない場合は`Enter`で対応して良い

```
Wolfram Engine 13.2 for LINUX Installer Archive
Verifying archive integrity. 
Extracting installer...............
------------------------------------------------------------------------
                        Wolfram Engine 13.2 Installer 
------------------------------------------------------------------------
Copyright (c) 1988-2022 Wolfram Research, Inc. All rights reserved.
WARNING: Wolfram Engine is protected by copyright law and international
treaties. Unauthorized reproduction or distribution may result in severe
civil and criminal penalties and will be prosecuted to the maximum extent
possible under law.
Enter the installation directory, or press Enter to select
/usr/local/Wolfram/WolframEngine/13.2:>
```

```
Type the directory path in which the Wolfram Engine script(s) will be created,
or press Enter to select /usr/local/bin:> 
```

### Wolfram EngineのActivation

インストール後, activationを実行する必要があります. 実行手順は

1. `wolframscript`コマンドをTerminalにて入力
2. Wolfram Alphaのユーザー名とpasswordを入力する
3. Exitする(`Exit`と入力すれば良い)


```zsh
%  wolframscript                                                                                             master
The Wolfram Engine requires one-time activation on this computer.

Visit https://wolfram.com/engine/free-license to get your free license.

Wolfram ID: your_registered_email
Password: 
Wolfram Engine activated. See https://www.wolfram.com/wolframscript/ for more information.
Wolfram Language 13.2.0 Engine for Linux x86 (64-bit)
Copyright 1988-2022 Wolfram Research, Inc.
```

> REMARKS

Activation後の二回目以降に`wolframscript`を実行しようとするとAcativation Failedとなるパターンに遭遇するかもしれませんが,
自分の場合はRebootしたら治りました.

## Jupyer notebookでWolfram Language kernelを選択できるようにする

[WolframResearch / WolframLanguageForJupyter](https://github.com/WolframResearch/WolframLanguageForJupyter)を用いることでWolfram Language kernelをJupyterで選択できるようになります.

事前に`wolframscript`によるActivationが完了していないと実行できないことに注意.


### 手順

```zsh
# 
% git clone git@github.com:WolframResearch/WolframLanguageForJupyter.git
% cd ./WolframLanguageForJupyter
% ./configure-jupyter.wls add
```

で終了.

### Removeしたい場合

```
% cd ./WolframLanguageForJupyter
% ./configure-jupyter.wls remove
```

## Example

<div class="math display" style="overflow: auto">
<iframe width="770" height="2800" src="https://nbviewer.org/github/RyoNakagami/Wolfram_playground/blob/main/example/calculate_pi.ipynb" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>


## References

> Respositories

- [WolframResearch / WolframLanguageForJupyter](https://github.com/WolframResearch/WolframLanguageForJupyter)