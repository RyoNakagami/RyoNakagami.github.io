---
layout: post
title: "Create VSCode + Dockernized LaTeX Environment"
subtitle: "Ubuntu Desktop環境構築 Part 26"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-07-06
tags:

- Ubuntu 20.04 LTS
- Linux
---

> 実行環境

実行環境

|項目||
|---|---| 	 
|マシン| HP ENVY TE01-0xxx|
|OS |	ubuntu 20.04 LTS Focal Fossa|
|CPU| Intel Core i7-9700 CPU 3.00 GHz|
|RAM| 32.0 GB|
|GPU| NVIDIA GeForce RTX 2060 SUPER|
|software|`docker-ce`|

```zsh
% lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.3 LTS
Release:        20.04
Codename:       focal
% uname -srvmpio
Linux 5.13.0-27-generic #29~20.04.1-Ubuntu SMP Fri Jan 14 00:32:30 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Why Dockerized LaTex Environment?](#why-dockerized-latex-environment)
- [Setup](#setup)
  - [VSCode Extension](#vscode-extension)
  - [Docker image setup](#docker-image-setup)
    - [VSCode `settings.json` setup](#vscode-settingsjson-setup)
- [Appendix: `apt-get purge` all of texlive related packages](#appendix-apt-get-purge-all-of-texlive-related-packages)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Why Dockerized LaTex Environment?

LaTeX on Dockerのメリットは主に２つあります:

- Linux, Windows, MacどこでもコンテナさえあればLaTexを同じ設定で動かすことができる
- `apt install texlive-full`でLinux上にLaTex環境を構築してしまうと, Ruby 2.7がglobal環境に入ってきてしまうがDockerで環境を構築することでこれを防ぐことができる

## Setup
### VSCode Extension

- [James Yu, LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)

### Docker image setup

```zsh
% docker pull tianon/latex
```

- メンテはされていない模様
- 日本語環境を充実させたいならば自分で作ってしまってもいいと思います


#### VSCode `settings.json` setup

```json
{
    "latex-workshop.docker.enabled": true,
    "latex-workshop.latex.outDir": "%DIR%/build",
    "latex-workshop.synctex.afterBuild.enabled": true,
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.docker.image.latex": "tianon/latex",
}
```

- `"latex-workshop.latex.outDir"`は個人の好みに合わせて好きなように変えてください


## Appendix: `apt-get purge` all of texlive related packages

```zsh
% sudo apt list --installed 2>/dev/null | grep "texlive" |awk 'BEGIN{FS = "/"}{print $1}'|xargs sudo apt-get purge -y  
```

`apt`を出力結果をパイプでつなぐと以下のような警告が表示されます:

```
WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
```

これを除去するために, `sudo apt list --installed 2>/dev/null` とスクリプトを書いています.

`2>/dev/null`は, "redirect the standard error (stderr) stream (file descriptor 2) to /dev/null."の意味です. `/dev/null` はdataのブラックホールみたいなdeviceでここに書き込まれたdataはすべて無視されます.


## References

- [Docker image > tianon/latex](https://hub.docker.com/r/tianon/latex/)