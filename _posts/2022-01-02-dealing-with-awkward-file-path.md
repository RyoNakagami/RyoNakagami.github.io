---
layout: post
title: "spaceなどお行儀の悪い文字がPATHに含まれている場合の対処"
subtitle: "シングルクォートとダブルクォートの挙動の違い"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
revise_date: 2023-08-10
tags:

- Linux
- Shell

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [お行儀の悪いPATH](#%E3%81%8A%E8%A1%8C%E5%84%80%E3%81%AE%E6%82%AA%E3%81%84path)
  - [お行儀の悪いファイル名はどれくらいあるのか？](#%E3%81%8A%E8%A1%8C%E5%84%80%E3%81%AE%E6%82%AA%E3%81%84%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%90%8D%E3%81%AF%E3%81%A9%E3%82%8C%E3%81%8F%E3%82%89%E3%81%84%E3%81%82%E3%82%8B%E3%81%AE%E3%81%8B)
- [シングルクォートとダブルクォートの差異](#%E3%82%B7%E3%83%B3%E3%82%B0%E3%83%AB%E3%82%AF%E3%82%A9%E3%83%BC%E3%83%88%E3%81%A8%E3%83%80%E3%83%96%E3%83%AB%E3%82%AF%E3%82%A9%E3%83%BC%E3%83%88%E3%81%AE%E5%B7%AE%E7%95%B0)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## お行儀の悪いPATH

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

```zsh
% mkdir -p './sandbox/hop step/heisei jamp'
% touch './sandbox/hop step/heisei jamp'/README.md
% ls './sandbox/hop step/heisei jamp'         
README.md
```

という形で誤ってスペースを含めたディレクトリを作成してしまったとします.
`hop step`を含む以下のディレクトリを消す場合どのようなコマンドが考えられるか？

</div>

このような場合, 

- エスケープ `\` をスペースの前に加える
- シングルクオート `''` で文字を囲み, シェルに１つの文字列として認識させる

という対応策が考えられます.

```zsh
# with escape
% rm -rf ./sandbox/hop\ step 

# with single quotes
% rm -rf './sandbox/hop step'
% rm -rf ./sandbox/'hop step'
% rm -rf .'/sandbox/hop step'
```

### お行儀の悪いファイル名はどれくらいあるのか？

簡易的に, `find`コマンドで確かめてみます

```zsh
% find ~ -name "*[ \[\(\<\;\&\|\"\{\~\|]*"  -type f | wc -l
5137
```

結構あることがわかります. 簡単に確認してみると, snap経由でいれたfirefoxや`.venv`内部にある
Pythonパッケージの中やGoogle-Chromeなどの設定ファイルの中にある傾向でした.

```zsh
% find ~ -name "*[ ]*"  -type f | wc -l 
267

% find ~ -name "*[\{]*"  -type f | wc -l
4866

% find ~ -name "*[\~]*"  -type f | wc -l
4
```


## シングルクォートとダブルクォートの差異

クォートは特定の文字列をリテラルとして使用する機能がありますが、各クォートで処理が異なる場合があります. 感覚的な話になりますが, 以下のような区分があります. 

---|---|---
'|シングルクォート|強いクォート
"|ダブルクォート|弱いクォート

```zsh
## 環境変数の出力
% echo $PWD
/home/hogehoge/Desktop/

## 環境変数をダブルクォートで囲んで出力
% echo "$PWD"
/home/hogehoge/Desktop/

## 環境変数をシングルクォートで囲んで出力
% echo '$PWD'
$PWD
```

上記の例ではダブルクォートでは変数が展開される一方, シングルクォートにおいては変数が展開されないという違いが確認できます. これは各クォートでエスケープできるメタキャラクタが異なるのが理由です.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: クォートとメタキャラクタ</ins></p>

|クォート種類|エスケープしないメタキャラクタ|
|---|---|
|シングルクォート|シングルクォートの中にシングルクォートは入れられない|
|ダブルクォート|`$`, バッククォート, ダブルクォート, `\`, `!`|

</div>

`date`

```zsh
## 
% echo "today: $(date)"
today: Thu Aug 24 02:45:42 PM JST 2021


```





References
-------------

- [筑波大学 シェル変数、環境変数、ヒストリ 講義ノート](http://www.coins.tsukuba.ac.jp/~yas/coins/literacy-2012/2012-06-15/)
