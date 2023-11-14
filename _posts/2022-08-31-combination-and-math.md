---
layout: post
title: "Combinationの性質: 二項定理の応用"
subtitle: "組合せ論シリーズ 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
doctoc: false
last_modified_at: 2023-04-03
tags:

- math
---


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem </ins></p>

$1$より大きい奇数 $n$ が任意に与えられている. このとき,

<p style="text-align: center;">
$$
\\_nC_1, \\_nC_2, \cdots, \\_nC_{\frac{n-1}{2}}
$$
</p>

のなかに奇数は奇数個存在することを示せ.

</div>

**証明**

二項定理より

$$
\begin{align*}
(1 + 1)^n &= _nC_0 + _nC_1 + _nC_2 + \cdots + _nC_{\frac{n-1}{2}} + _nC_{\frac{n+1}{2}} + \cdots + _nC_{n-1} + _nC_n\\
          &= 2^n
\end{align*}
$$

従って,

$$
\begin{align*}
_nC_1 + _nC_2 + \cdots + _nC_{\frac{n-1}{2}} &= \frac{1}{2}(2^n - 2)\\
                                             &= 2^{n-1} - 1\\
                                             &= \text{奇数}
\end{align*}
$$

従って, $$(\\_nC_1, \\_nC_2, \cdots, \\_nC_{(n-1)/2})$$ の中に奇数は奇数個存在する.

**証明終了**

---


## References

- [数学オリンピックへの道 1 組合せ論の精選102問](https://www.asakura.co.jp/detail.php?book_code=11807)
