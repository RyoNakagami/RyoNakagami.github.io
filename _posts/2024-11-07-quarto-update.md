---
layout: post
title: "Quarto Version Updateの備忘録"
subtitle: "quarto version update to 1.5.57"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-11-07
tags:

- quarto
---

## Update Steps

```zsh
# Linux
# Step 1: remove the bug version
sudo dpkg -r quarto

# Step 2: download the 1.5.57
wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-amd64.deb

# Step 3: install via gdebi
sudo gdebi quarto-1.5.57-linux-amd64.deb

# Step 4: check if you installed the version you intended
quarto check
```

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#00008B;'>
<strong >📘 REMARKS</strong> <br>


- Version `1.6.32` はbugあり

</div>
