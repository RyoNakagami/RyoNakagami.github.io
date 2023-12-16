---
layout: post
title: "有限要素の全体集合から２つの部分集合をつくるとき"
subtitle: "組合せ論 2/N"
author: "Ryo"
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-14
header-mask: 0.0
header-style: text
tags:

- math

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [AIME 1993](#aime-1993)
- [AIME 1991改題](#aime-1991%E6%94%B9%E9%A1%8C)
  - [Pythonでエラトステネスのふるいを実装して計算](#python%E3%81%A7%E3%82%A8%E3%83%A9%E3%83%88%E3%82%B9%E3%83%86%E3%83%8D%E3%82%B9%E3%81%AE%E3%81%B5%E3%82%8B%E3%81%84%E3%82%92%E5%AE%9F%E8%A3%85%E3%81%97%E3%81%A6%E8%A8%88%E7%AE%97)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## AIME 1993

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

$S$ を$n$個の元からなる集合とする. $S$の２つの部分集合(同じでも良い)の組 $(A, B)$ であって, その和集合が

$$
A \cup B = S
$$

となるような組はいくつ存在するか? ただし, 順番を変えただけのものは区別しないものとする.

例として, $S$の要素が6のとき$[\{a, c\}, \{b, c, d, e, f\}], [\{b, c, d, e, f\}, \{a, c\}]$は同一の組として扱う

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

$A \cup B = S$ より $s \in S$について, 以下のいずれかが成立する

$$
\begin{align*}
(1)& \ \ s \in A \ \ \land \ \ s\notin B\\[3pt]
(2)& \ \ s \in A \ \ \land \ \ s\in B\\[3pt]
(3)& \ \ s \notin A \ \ \land \ \ s\in B\\[3pt]
\end{align*}
$$

従って, 順番を変えただけのものも含めて $s\in S$を部分集合 $A, B$に割り当て方は $3^n$ 通り存在する.
このうち, $A=B$となる場合(すべての要素が(2)パターンとなる場合)を除くと, $\{A, B\}$の組を２回ずつ数えていることになるので

$$
\frac{3^n-1}{2} + 1\text{通り}
$$

が答えとなる.

</div>

## AIME 1991改題

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

0より大きく1より小さい有理数であって既約分数で書いたときの分母と分子の積が100!となるようなものはいくつあるか？

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 10px;color:#FFFFFF"><span >解答</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 20px;">

既約分数は互いに素. 100!を素因数分解すると

$$
\{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97\}
$$

の25個である.

すべての素数が分子, 分母のいずれかに分類される. このままだと１より大きい分け方が発生してしまうが, 分子分母を入れ替えることで1より小さい既約分数となるペアが生成できることを考えると, 分子分母の区別のない組み合わせを数えれば良い = 重複して数えた分除去すれば良いので

$$
2^{25} / 2 = 2^{24}\text{通り}
$$

が答えとなる.

</div>


### Pythonでエラトステネスのふるいを実装して計算

なお100!を素因数分解するのは面倒なのでPythonでエラトステネスのふるいを実装して計算しました.

<div style='background-color:#F8F8F8'>
<span class='psuedo_line'>**Sieve of Eratosthenes**</span>

<div class="math display" style="text-align: left !important; margin:0pt !important; margin-bottom:-0.8em !important">
$$
\begin{align*}
\textbf{Time Complexity: } O(n\log\log n)
\end{align*}
$$
</div>
<div class="math display" style="text-align: left !important; margin:0pt !important; margin-bottom:-0.8em !important">
$$
\begin{align*}
\textbf{Input: } n > 1 \textbf{ integer }
\end{align*}
$$
</div>
<div class="math display" style="text-align: left !important; margin:0pt !important; margin-bottom:0em !important">
$$
\begin{align*}
\textbf{Output: }& A \textbf{ Array} \text{ - all prime numbers from 2 through n} 
\end{align*}
$$
</div>
<div class="math display" style="text-align: left !important; margin:0pt !important; margin-bottom:0em !important">
$$
\begin{align*}
\text{1.}\quad&\textbf{let } A \text{ be an}\textbf{ array of Boolean}\text{ values, indexed by}\textbf{ integers } 2\text{ to }n\\
\text{2.}\quad&\textbf{for } i = 2,3,\cdots, \text{ not exceeding } \sqrt{n} \textbf{ do}\\
\text{3.}\quad&\quad \textbf{if } A\text{[j]} \textbf{ is True}\\
\text{4.}\quad&\quad \quad \textbf{for } j = i^2, i^2+i,i^2+2i, \cdots, \text{not exceeding } n \textbf{ do}\\
\text{5.}\quad&\quad\quad\quad\textbf{set } A\text{[j]} := \textbf{ False}\\
\text{6.}\quad&\textbf{return }\text{ all i such that A[i] }\textbf{is True}
\end{align*}
$$
</div>
<span class='psuedo_endline'></span>

</div>

```python
def Sieve_of_Eratosthenes(n):
    if n < 2:
        raise ValueError('n should be greater than 1')
    
    idx = [True] * (n-1)
    root = int(pow(n, 0.5)) + 1
    for i in range(2, root):
        if idx[i-2]:
            j = i*i
            while j <= n:
                idx[j-2] = False
                j += i
    
    return [i+2 for i, j in enumerate(idx) if j]


2 ** (len(Sieve_of_Eratosthenes(100)) - 1)
>>> 16777216
```
