---
layout: post
title: "Install Brave into Ubuntu 22.04.2 LTS"
subtitle: "YouTube Ad Block Browser"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-03-13
tags:

- Ubuntu 22.04 LTS
- App

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is Brave?](#what-is-brave)
- [Install Brave into Ubuntu 22.04.2 LTS](#install-brave-into-ubuntu-22042-lts)
  - [Install script](#install-script)
    - [Root cause](#root-cause)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>


## What is Brave?

Brave is a web browser. 
It blocks privacy-invasive ads & trackers. It blocks third-party data storage. 
It protects from browser fingerprinting. It upgrades every webpage possible to secure https connections. And it does all this by default.

**Features**

---|---
Open source|It’s also built off the open-source Chromium Web core
License| Mozilla Public License 2.0
VPN|Brave Firewall + VPN, but not for free
Reward system|Basic Attention Token(one of bitcoin), which is given when you view first-party, privacy-protecting ads while browsing

## Install Brave into Ubuntu 22.04.2 LTS

---|---
OS|Ubuntu 22.04.2 LTS
CPU|AMD Ryzen 9 7950X 16-Core Processor

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>REMARKS: DO NOT USE Brave Snap package</ins></p>

[The official page](https://brave.com/linux/) says the follwoings:

You can find Brave in the Snapcraft Store, but while it is maintained by Brave Software, 
it is not yet working as well as our official packages. 
We currently recommend that users who are able to use our official package repositories do so instead of using the Snap.

</div>

Therefore, I've installed the brave by using `curl` and `deb` as the official instructs

### Install script

```zsh
% sudo apt install curl
% sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
% echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
% sudo apt update
% sudo apt install brave-browser
```

Note that the third line is slightly different from what the official instructs. 
I just add the architecture type by `[arch=amd64]`. Otherwise everytime you try `apt update`, you might come across the follwing warning:

```zsh
% sudo apt update
...
1 package can be upgraded. Run 'apt list --upgradable' to see it.
N: Skipping acquire of configured file 'main/binary-i386/Packages' as repository 'https://brave-browser-apt-release.s3.brave.com stable InRelease' doesn't support architecture 'i386'
```

#### Root cause

But the root cause is the OS enabled multiarch. To confirm, just type the following,

```zsh
% dpkg --print-foreign-architecture
```

If it says `i386`, that's the root cause. So instead of adding `[arch=amd64]`, it also works by

```zsh
% sudo dpkg --remove-architecture i386
```

To find the installed packages of architecture `i386, 

```zsh
## dpkg command based
% dpkg -l | awk '/^ii/ && $4 == "i386" { print }'

## apt command based, [installed,automatic] info added
% apt list --installed | awk '$3 == "i386" { print }'
```





References
----

- [brave official website](https://brave.com/)
- [AskUbuntu > Skipping acquire of configured file 'main/binary-i386/Packages' as repository 'xxx' doesn't support architecture 'i386'](https://askubuntu.com/questions/741410/skipping-acquire-of-configured-file-main-binary-i386-packages-as-repository-x)