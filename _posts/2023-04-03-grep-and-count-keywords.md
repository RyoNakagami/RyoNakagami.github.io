---
layout: post
title: "grep: Basic vs Extended Regular Expressions"
subtitle: "grep command 2/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
last_modified_at: 2023-05-29
tags:

- Linux
- Shell
---


<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Basic vs Extended Regular Expressions](#basic-vs-extended-regular-expressions)
  - [Difference between BRE and ERE](#difference-between-bre-and-ere)
- [ERE Problem: Find out the IP address with the highest occurrence frequency](#ere-problem-find-out-the-ip-address-with-the-highest-occurrence-frequency)
  - [Count the occurrences of each IP address](#count-the-occurrences-of-each-ip-address)
    - [What is `sort -nr -k 1` doing?](#what-is-sort--nr--k-1-doing)
  - [先頭ラインのIP addressの出力](#%E5%85%88%E9%A0%AD%E3%83%A9%E3%82%A4%E3%83%B3%E3%81%AEip-address%E3%81%AE%E5%87%BA%E5%8A%9B)
- [ERE Problem: Find the secret combination](#ere-problem-find-the-secret-combination)
  - [(1) Find the number of lines where the string `Alice` occurs](#1-find-the-number-of-lines-where-the-string-alice-occurs)
    - [Solution A: `grep -c` + `awk`](#solution-a-grep--c--awk)
    - [Solution B: print the filename and the line numbers with Alice and count them](#solution-b-print-the-filename-and-the-line-numbers-with-alice-and-count-them)
  - [(2) Find a file where "Alice" appears exactly once](#2-find-a-file-where-alice-appears-exactly-once)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## Basic vs Extended Regular Expressions

正規表現において文字はMeta charactersとLiteral charactersの二つの種類に分類されますが, 
利用可能なMeta charactersの集合に応じて, 正規表現はBREとEREの２つのカテゴリーに分類されます:

- Basic Regular Expression(BRE): An expression which uses the default Meta characters
- Extended Regular Expression(ERE): An expression which uses the later added Meta characters

BREで用いられていたMeta characterに加えて, `?`, `+`, `{`, `|`, `(`, `)`, and so onを新しい
Meta charactersとして利用できるようにした/修正したのがEREです.

`grep`は初めBREベースの`g/re/p`として誕生しました. その後, EREが世の中に登場したのに合わせて`grep`でも利用できるようになりましたが, `-E` optionで明示する必要があります. (なお, `grep -E`と`egrep`は同じです.)

挙動例を確認してみると,

```zsh
% echo "hoge foo hoo" | grep "voo|hoo"
% echo "hoge foo hoo" | grep -E "voo|hoo"
hoge foo hoo
```

EREの場合は「`voo` or `hoo`」で検索を掛けてくれますが, BREの場合は「`voo|hoo`」という一つのsearch wordで検索を掛けていることがわかります. ただし, BREでも `\|` と指定することで「`voo` or `hoo`」というsearch wordを設定することが出来ます:

```zsh
% echo "hoge foo hoo" | grep "voo\|hoo"
hoge foo hoo
```

### Difference between BRE and ERE

BREとEREの差分の基本ルールは, meta charactersは`\`(backslash)を用いないとBREではmeta character
として機能しないです. なお, `[`, `]`はERE, BREともにbackslashなしで機能します. 

実際に, [GNU公式ページ](https://www.gnu.org/software/grep/manual/html_node/Basic-vs-Extended.html)で確認してみると,

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>GNU公式: Basic vs Extended Regular Expressions</ins></p>


- The characters `?`, `+`, `{`, `|`, `(`, and `)` lose their special meaning; instead use the backslashed versions `\?`, `\+`, `\{`, `\|`, `\(`, and `\)`. Also, a backslash is needed before an interval expression's closing `}` .
- An unmatched `\)` is invalid.
- If an unescaped `^` appears neither first, nor directly after `\(` or `\|`, it is treated like an ordinary character and is not an anchor.
- If an unescaped `$` appears neither last, nor directly before `\|` or `\)`, it is treated like an ordinary character and is not an anchor.
- If an unescaped `*` appears first, or appears directly after `\(` or `\|` or anchoring `^`, it is treated like an ordinary character and is not a repetition operator. 

</div>



## ERE Problem: Find out the IP address with the highest occurrence frequency

以下の問題は[SadServers > "Saskatoon": counting IPs.](https://sadservers.com/newserver/saskatoon)を参考にしています.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: Find out the IP address with the highest occurrence frequency</ins></p>

とあるサーバーの`/home/admin/access.log`にHTTP requestが発生した時のthe requester's IP addressを格納しています.
ここから, 最もrequest回数が多かったIP addressを`grep`を用いて取得してください

</div>

まず, `/home/admin/access.log` の形式を確認します:

```
$ cat /home/admin/access.log | head
83.149.9.216 - - [17/May/2015:10:05:03 +0000] "GET /presentations/logstash-monitorama-2013/images/kibana-search.png HTTP/1.1" 200 203023 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:43 +0000] "GET /presentations/logstash-monitorama-2013/images/kibana-dashboard3.png HTTP/1.1" 200 171717 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:47 +0000] "GET /presentations/logstash-monitorama-2013/plugin/highlight/highlight.js HTTP/1.1" 200 26185 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:12 +0000] "GET /presentations/logstash-monitorama-2013/plugin/zoom-js/zoom.js HTTP/1.1" 200 7697 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:07 +0000] "GET /presentations/logstash-monitorama-2013/plugin/notes/notes.js HTTP/1.1" 200 2892 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:34 +0000] "GET /presentations/logstash-monitorama-2013/images/sad-medic.png HTTP/1.1" 200 430406 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:57 +0000] "GET /presentations/logstash-monitorama-2013/css/fonts/Roboto-Bold.ttf HTTP/1.1" 200 38720 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:50 +0000] "GET /presentations/logstash-monitorama-2013/css/fonts/Roboto-Regular.ttf HTTP/1.1" 200 41820 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:24 +0000] "GET /presentations/logstash-monitorama-2013/images/frontend-response-codes.png HTTP/1.1" 200 52878 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:50 +0000] "GET /presentations/logstash-monitorama-2013/images/kibana-dashboard.png HTTP/1.1" 200 321631 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
```

行の先頭にrequester's IP addressが格納されていることがわかります. ですのでまず, このIP address listの取得を`grep -o`用いて実行します:

```bash
## Using ERE
% grep -E -o "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /home/admin/access.log

## Using BRE
% grep -o "^[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}" /home/admin/access.log
```

これでIP address一覧が取得できたので次に各IP addressの出現回数をカウントします.

### Count the occurrences of each IP address

出現回数をカウントするコマンド自体は（たぶん）Linuxには存在しないですが, 各ラインの前に重複出現する回数をカウントする`uniq -c`というoption付コマンドがあるので活用します.
一旦IP address Listをsortしてから重複出現回数をカウントすれば, 各IP addressについて出現回数をカウントすることが実質出来ます:

```bash
% grep -E -o "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /home/admin/access.log | sort | uniq -c | sort -nr -k 1 | head
    482 66.249.73.135 
    364 46.105.14.53 
    357 130.237.218.86 
    273 75.97.9.59 
    113 50.16.19.13 
    102 209.85.238.199 
     99 68.180.224.225 
     84 100.43.83.137 
     83 208.115.111.72 
     82 198.46.149.143 
```

このように各IP addressについての出現回数が取得できました.

#### What is `sort -nr -k 1` doing?

`sort | uniq -c`で確かに各lineについての出現回数をカウントできますが, 今回はそのうち最も出現回数が多いものを取得したいので改めて, 出現回数順にsortする必要があります. 
`sort` commandはdefaultではascending orderなので, `-r` optionを用いて descending orderに変更する必要があります.

さらにどの列を用いて`sort`するかを指定するために, 1列目でsortするという意思を込めて `-k 1` を指定しています.
なお, defaultでは1列目を参照するようになっているので, 今回に限ってはこのoptionを省略しても構いません.

`-n` optionは`sort`の際に参照する列がnumeric valueであることを指定するoptionです. 例として, 
0~10までの数値を順番ぐちゃぐちゃに `printf "%s\n"  1 2 8 4 6 5 10 7 3 9` で表示したあとに, 
`-n` option有無それぞれで `sort` してみます:

```bash
$ printf "%s\n"  1 2 8 4 6 5 10 7 3 9 | sort
1
10
2
3
4
5
6
7
8
9

$ printf "%s\n"  1 2 8 4 6 5 10 7 3 9 | sort -n
1
2
3
4
5
6
7
8
9
10
```

前者では 0~10 を文字列ベースとしてsortしていて, 後者では numeric valueベースでsortしている違いが有ります.
今回の問題では, 出現回数という numeric valueベースで `sort` したいので, `-n` optionを付与する必要が有ります.

### 先頭ラインのIP addressの出力

一行目のカラム2の値のみを出力したい場合は, `awk` commandを以下のように用います:

```bash
% awk 'NR==1 {print $2}'
```

出現回数をベースにdescending orderでsortされたIP addressリストデータがあるので, 最終的には以下のワンライナーが問題に対する解答となります:

```bash
% grep -Eo "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /home/admin/access.log | sort | uniq -c | sort -nr | awk 'NR==1 {print $2}'
```

## ERE Problem: Find the secret combination

参考問題は["Santiago": Find the secret combination](https://sadservers.com/newserver/santiago)です.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem: "Santiago": Find the secret combination</ins></p>

1. `/home/admin` directory下の`.txt` filesにて, `Alice`という文字列が出現する行数の合計を出力せよ
2. `/home/admin` directory下の`.txt` filesにて, `Alice`という文字列が1回しか出現しないファイルがある. そのファイルでは, `Alice` という文字列が出現した次の行に数値が(例: 2345)必ず出現するので, その数字を出力せよ

</div>

### (1) Find the number of lines where the string `Alice` occurs 

`Alice`という文字列の出現回数ではなく, 出現するLineの数を求める問題です. 


#### Solution A: `grep -c` + `awk`

`grep -c`と`awk`を用いると以下のようにして出現ライン数を計算することが出来ます:

```bash
$ grep -c "Alice" /home/admin/*.txt | awk 'BEGIN{FS = ":"}{sum+=$2}END{print sum;}'
```

> 解説

`grep -c`は検索ワードの出現ライン数を表示する事が出来ます. manualを確認してみると

```zsh
% man grep | grep -E -B1 -A2 "\-c, \-\-count"
   General Output Control
       -c, --count
              Suppress normal output; instead print a count of matching lines for each input file.  With  the  -v,
              --invert-match option (see below), count non-matching lines.
```

ですので, `grep -c "Alice" /home/admin/*.txt`を実行することで, `/home/admin/`の各 txt fileで`Alice`が出現する行数が `<file-name>:<line-frequency>` で確認することが出来ます. 例として以下,

```bash
$ grep -c "hoge" ./*.txt   
./test01.txt:9
./test02.txt:3
./test03.txt:0
./test04.txt:1
./test05.txt:11
```

次に, 出現ライン数の合計を計算します. `<file-name>:<line-frequency>`の`<line-frequency>`の合計を計算すればよいだけなので, 

```bash
awk 'BEGIN{FS = ":"}{sum+=$<column-number>}END{print sum;}'
```

で簡単に計算できます. 今回は `:` でカラムを分けて, 2カラム目にライン数が入っているので, 

```bash
$ grep -c "Alice" /home/admin/*.txt | awk 'BEGIN{FS = ":"}{sum+=$2}END{print sum;}'
```

#### Solution B: print the filename and the line numbers with Alice and count them

```bash
$ grep -on "Alice" /home/admin/*.txt | sed -E 's/:Alice$//g' | sort | uniq |wc -l
```

> 解説

`grep -on`で`<file-name>:<line-number>:<match-word>`を出現させます.

```bash
$ grep -on "hoge" ./*.txt   
./test01.txt:1:hoge
./test01.txt:2:hoge
./test01.txt:2:hoge
./test01.txt:5:hoge
....
```

なお, １つのラインに２回以上マッチする場合は, 上記例の`./test01.txt:2:hoge`のようにそれぞれについて出力されます.

そのため, `sed -E 's/:Alice$//g'`で`<file-name>:<line-number>`の形式に直したあとに, `sort | uniq`をpipeでつなぎ, ユニークな`<file-name>:<line-number>`のリストを出力しています.

なお今回は, `<file-name>:<line-number>:Alice`というパターンで決まっているので, `sed -E 's/:Alice$//g'`は含めなくても大丈夫です.

その後, ユニークな`<file-name>:<line-number>`の一覧に対して`wc -l`でラインカウントをすれば, 出現ライン数の合計値が出力されます.


### (2) Find a file where "Alice" appears exactly once

今回はAliceという文字列の出現ライン数ではなく, 登場回数が1のファイルを見つける, かつ, Aliceという文字列が出現した行の次の行にある数値を出力する問題です. 解答例として, 

```bash
$ grep -o "Alice" /home/admin/*.txt | sed -E 's/:Alice$//g' | sort | uniq -c | sort -n -k 1 | awk 'NR==1 {print $2}' | xargs grep -A1 "Alice" | tail -1 | grep -Eo "[0-9]{1,}
```

> 解説

基本的な解説は, 上記と同様なので差分部分を以下紹介します:

- `grep -o "Alice" /home/admin/*.txt`: `<file-name>:<match-pattern>`の一覧を出力. 
- `sed -E 's/:Alice$//g' | sort | uniq -c`: Aliceの出現回数をカウントし, `<frequency> <file-name>`の形で出力
- `sort -n -k 1`: `<frequency> <file-name>`をfrequency昇順で出力
- `awk 'NR==1 {print $2}'`: `<frequency> <file-name>`の1行目のfile-nameのみを出力
- `xargs grep -A1 "Alice" | tail -1 | grep -Eo "[0-9]{1,}`: Aliceという文字列が出現した行の次の行にある数値を出力

## References

- [GNU公式 > Basic vs Extended Regular Expressions](https://www.gnu.org/software/grep/manual/html_node/Basic-vs-Extended.html)
- [stackoverflow > Getting the count of unique values in a column in bash](https://stackoverflow.com/questions/4921879/getting-the-count-of-unique-values-in-a-column-in-bash)

> SadServers

- ["Saskatoon": counting IPs.](https://sadservers.com/newserver/saskatoon)
- ["Santiago": Find the secret combination](https://sadservers.com/newserver/santiago)