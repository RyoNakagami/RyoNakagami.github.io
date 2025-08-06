---
layout: post
title: "定数についての命名規則"
subtitle: "Python Programming Styling Part 1"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: true
last_modified_at: 2024-03-13
tags:

- coding
- 方法論
- Python
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Constantは大文字で](#constant%E3%81%AF%E5%A4%A7%E6%96%87%E5%AD%97%E3%81%A7)
- [VSCodeで選択範囲の大文字/小文字の切り替え](#vscode%E3%81%A7%E9%81%B8%E6%8A%9E%E7%AF%84%E5%9B%B2%E3%81%AE%E5%A4%A7%E6%96%87%E5%AD%97%E5%B0%8F%E6%96%87%E5%AD%97%E3%81%AE%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Constantは大文字で

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Rule</ins></p>

- Constants(定数)は大文字とアンダースコアで表記されるべき

</div>

このNaiming conventionはPython runtimeが要請するものではなく, semanticな意味での要請となります.
他の開発者がコードをレビューするとき, この規則があると変数の値がどのように変化するのか調べなくて良い（なぜなら定数だから）
と判断することができレビュー時間の節約に繋がります.

例として以下のような`my_convert_ftoc.py`を考えます

```python
def convert_ftoc(f_temp):
    # convert Fahrenheit to Celsius
    f_boil_temp = 212.0
    f_freeze_temp = 32.0
    c_boil_temp = 100.0
    c_freeze_temp = 0.0
    f_range = f_boil_temp - f_freeze_temp
    c_range = c_boil_temp - c_freeze_temp
    f_c_ratio = c_range / f_range
    c_tmp = (f_temp + f_freeze_temp) * f_c_ratio + c_freeze_temp
    return c_temp


if __name__ == '__main__':
    for f_temp in [-40.0, 0.0, 32.0, 100.0, 212.0]:
        c_temp = convert_ftoc(f_temp)
        print('%f F => % C' % (f_temp, c_temp))
```

このとき, ２つの改善が考えられます: 

- Constants(定数)は大文字とアンダースコアの表記に変更する
- 定数値をモジュールトップに移動する

前者は, PEP8のルールから要請されるアクションとなります. 後者は, 定数をモジュールトップに移動させることで
定数の読み込みはモジュール読み込み時のみに限定され, `convert_ftoc()`関数を読み出すたびに定数を読み込むという
無駄を削減することができるという意図があります.

```python
F_BOIL_TEMP = 212.0
F_FREEZE_TEMP = 32.0
C_BOIL_TEMP = 100.0
C_FREEZE_TEMP = 0.0
F_RANGE = F_BOIL_TEMP - F_FREEZE_TEMP
C_RANGE = C_BOIL_TEMP - C_FREEZE_TEMP
F_C_RATIO = C_RANGE / F_RANGE

def convert_ftoc(f_temp):
    # convert Fahrenheit to Celsius
    c_tmp = (f_temp + F_FREEZE_TEMP) * F_C_RATIO + C_FREEZE_TEMP
    return c_temp


if __name__ == "__main__":
    for f_temp in [-40.0, 0.0, 32.0, 100.0, 212.0]:
        c_temp = convert_ftoc(f_temp)
        print("%f F => % C" % (f_temp, c_temp))
```

## VSCodeで選択範囲の大文字/小文字の切り替え

VS CodeではDefaultではキーはアサインされてはいないですが, 大文字/小文字の切り替えのコマンドがsystemに入っています

- Transform to Uppercase: `editor.action.transformToUppercase`
- Transform to Lowercase: `editor.action.transformToLowercase`


<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 10px;color:black">
<span >VSCode settings.jsonの設定例</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 20px;">

```json
    {
        "key": "ctrl+u",
        "command": "editor.action.transformToUppercase"
    },
    {
        "key": "ctrl+shift+u",
        "command": "editor.action.transformToLowercase"
    },
```


</div>





References
----------
- [PEP 8 – Style Guide for Python Code > Constants](https://peps.python.org/pep-0008/#constants)
