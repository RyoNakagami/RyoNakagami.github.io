---
layout: post
title: "Psuedo code Tutorial"
subtitle: "疑似コードの読み方と書き方"
author: "Ryo"
header-img: "img/post-bg-miui6.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Pseudo code
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>


||概要|
|---|---|
|目的|疑似コードの読み方と書き方|
|参考|- [Pseudo codeTutorialand Exercises–Teacher’s Version](https://www.cosc.canterbury.ac.nz/tim.bell/dt/Tutorial_Pseudocode.pdf)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 今回のスコープ](#1-%E4%BB%8A%E5%9B%9E%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
  - [やりたいこと](#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8)
  - [注意点](#%E6%B3%A8%E6%84%8F%E7%82%B9)
- [2. Pseudo-codeとは](#2-pseudo-code%E3%81%A8%E3%81%AF)
  - [Pseudo-codeを書くにあたって気をつけるべき点](#pseudo-code%E3%82%92%E6%9B%B8%E3%81%8F%E3%81%AB%E3%81%82%E3%81%9F%E3%81%A3%E3%81%A6%E6%B0%97%E3%82%92%E3%81%A4%E3%81%91%E3%82%8B%E3%81%B9%E3%81%8D%E7%82%B9)
  - [Pseudo codeでよく見るスタイル](#pseudo-code%E3%81%A7%E3%82%88%E3%81%8F%E8%A6%8B%E3%82%8B%E3%82%B9%E3%82%BF%E3%82%A4%E3%83%AB)
    - [Sequenceの例](#sequence%E3%81%AE%E4%BE%8B)
    - [IF-THEN-ELSEの例](#if-then-else%E3%81%AE%E4%BE%8B)
    - [WHILEの例](#while%E3%81%AE%E4%BE%8B)
    - [CASEの例](#case%E3%81%AE%E4%BE%8B)
    - [REPEAT-UNTILの例](#repeat-until%E3%81%AE%E4%BE%8B)
    - [FORの例](#for%E3%81%AE%E4%BE%8B)
    - [NESTED CONSTRUCTSの例](#nested-constructs%E3%81%AE%E4%BE%8B)
    - [INVOKING SUBPROCEDURESの例](#invoking-subprocedures%E3%81%AE%E4%BE%8B)
    - [EXCEPTION HANDLINGの例](#exception-handling%E3%81%AE%E4%BE%8B)
  - [良いPseudo Codeの例](#%E8%89%AF%E3%81%84pseudo-code%E3%81%AE%E4%BE%8B)
    - [Adequate](#adequate)
    - [Better](#better)
    - [Not So Good](#not-so-good)
    - [Better](#better-1)
  - [良いPseudo codeとソースコードの関係の例](#%E8%89%AF%E3%81%84pseudo-code%E3%81%A8%E3%82%BD%E3%83%BC%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E9%96%A2%E4%BF%82%E3%81%AE%E4%BE%8B)
    - [Pseudo code](#pseudo-code)
    - [Java source code](#java-source-code)
- [3. Pseudo-code Examples](#3-pseudo-code-examples)
  - [Bubble sort アルゴリズム](#bubble-sort-%E3%82%A2%E3%83%AB%E3%82%B4%E3%83%AA%E3%82%BA%E3%83%A0)
    - [C implementation](#c-implementation)
    - [Pseudo codeでの表現](#pseudo-code%E3%81%A7%E3%81%AE%E8%A1%A8%E7%8F%BE)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 今回のスコープ
### やりたいこと

- 疑似コードの書き方の読み方と書き方の指針のまとめ

### 注意点

疑似コード(Pseudo code)は、特定のプログラミング言語の知識を持たない人でもアルゴリズムが理解できるように自然言語に近い形で記述するコードです。疑似コードには厳格なルールがあるわけではなく、書く人によって様々な書き方があります。

## 2. Pseudo-codeとは

Pseudo-codeは、アルゴリズムを記述するための一種の構造化された文章です。これにより、実装者はプログラミング特有のSyntaxに気を取られることなく、アルゴリズムのロジックに集中することができます。同時に、疑似コードはアルゴリズムを他人に伝えるためのツールなので、疑似コードはアルゴリズムのロジック全体を記述する必要があります。

### Pseudo-codeを書くにあたって気をつけるべき点

- Pseudo-codeで使用する語彙は、implementation domainの語彙ではなく、problem domainの語彙でなければなりません。
- アルゴリズムのロジックは、単一のループまたは決定のレベルに分解されなければなりません。

例えば「顧客名簿の中から一年間で最も購買したお客様を探す」という文章は曖昧すぎてだめです。Problem domainの共通認識として購買チャネルと購買期間が明確だったとしても、「最も購買したお客様」を探すためには一人ひとりの１年間の購買金額を知った上で、比較して、「最も購買したお客様」を決定する必要があるので、「アルゴリズムのロジックは、単一のループまたは決定のレベルに分解されなければなりません。」という要件を満たしていません。

### Pseudo codeでよく見るスタイル

ロジックの流れを表現するにあたってよく見るconstructs（構造を表現するもの）を紹介します。

|constructs|説明|
|---|---|
|SEQUENCE|1つのタスクが別のタスクの後に順次実行される直線的な進行のことです|
|WHILE|単純な条件テストが上部に付いているループのこと|
|IF-THEN-ELSE|2つの代替行動の間で選択を行うこと|
|REPEAT-UNTIL|下部に単純な条件付きテストを持つループです|
|CASE|式の値に基づく多元分岐（決定）です。CASEはIF-THEN-ELSEの一般化です|
|FOR|カウントループのこと|

次に、input, output, and processing operationに関係するキーワードを紹介します。

|処理|Pseudo codeで使われる表現|
|---|---|
|Input|READ, OBTAIN, GET|
|Output|PRINT, DISPLAY, SHOW|
|Compute|COMPUTE, CALCULATE, DETERMINE|
|Initialize|SET, INIT|
|Add one|INCREMENT, BUMP|

#### Sequenceの例

```raw
Example

    READ height of rectangle
    READ width of rectangle
    COMPUTE area as height times width
```

#### IF-THEN-ELSEの例

一般的な構文は以下のような形となります。

```raw
IF condition THEN

    sequence 1

ELSE

    sequence 2

ENDIF
```

一例として、

```raw
    IF HoursWorked > NormalMax THEN

        Display overtime message

    ELSE

        Display regular time message

    ENDIF
```

#### WHILEの例

```raw
WHILE condition

    sequence

ENDWHILE
```

という構造を取ります。

```raw
    WHILE Population < Limit

        Compute Population as Population + Births - Deaths

    ENDWHILE
```

#### CASEの例

```raw
CASE expression OF

    condition 1 : sequence 1
    condition 2 : sequence 2
    ...
    condition n : sequence n
    OTHERS:
    default sequence

ENDCASE 
```

```raw
CASE  grade  OF
        A       : points = 4
        B       : points = 3
        C       : points = 2
        D       : points = 1
        F       : points = 0
ENDCASE
```

#### REPEAT-UNTILの例

```raw
REPEAT

    sequence

UNTIL condition
```

#### FORの例

```raw
FOR iteration bounds

    sequence

ENDFOR
```

一例として

```raw
FOR each month of the year (good)
FOR month = 1 to 12 (ok)

FOR each employee in the list (good)
FOR empno = 1 to listsize (ok)
```

#### NESTED CONSTRUCTSの例

```raw
    SET total to zero
    REPEAT

        READ Temperature
        IF Temperature > Freezing THEN
            INCREMENT total
        END IF

    UNTIL Temperature < zero
    Print total
```

#### INVOKING SUBPROCEDURESの例

```raw
    CALL AvgAge with StudentAges
    CALL Swap with CurrentItem and TargetItem
    CALL Account.debit with CheckAmount
    CALL getBalance RETURNING aBalance
    CALL SquareRoot with orbitHeight RETURNING nominalOrbit
```

#### EXCEPTION HANDLINGの例

```raw
    BEGIN
        statements
    EXCEPTION
        WHEN exception type
            statements to handle exception
        WHEN another exception type
            statements to handle exception
    END
```

### 良いPseudo Codeの例


#### Adequate

```raw
FOR X = 1 to 10
    FOR Y = 1 to 10
        IF gameBoard[X][Y] = 0
            Do nothing
        ELSE
            CALL theCall(X, Y) (recursive method)
            increment counter                 
        END IF
    END FOR
END FOR
```



#### Better
```raw
Set moveCount to 1
FOR each row on the board
    FOR each column on the board
        IF gameBoard position (row, column) is occupied THEN
            CALL findAdjacentTiles with row, column
            INCREMENT moveCount
        END IF
    END FOR
END FOR
```





#### Not So Good

```raw
FOR all the number at the back of the array
    SET Temp equal the addition of each number
    IF > 9 THEN
        get the remainder of the number divided by 10 to that index
        and carry the "1"
    Decrement one
Do it again for numbers before the decimal
```





#### Better
```raw
SET Carry to 0
FOR each DigitPosition in Number from least significant to most significant

    COMPUTE Total as sum of FirstNum[DigitPosition] and SecondNum[DigitPosition] and Carry  

    IF Total > 10 THEN
        SET Carry to 1
        SUBTRACT 10 from Total
    ELSE
        SET Carry to 0
    END IF

    STORE Total in Result[DigitPosition]

END LOOP  

IF Carry = 1 THEN
    RAISE Overflow exception
END IF
```



<div class="column-one">

### 良いPseudo codeとソースコードの関係の例




#### Pseudo code

```raw
public boolean moveRobot (Robot aRobot)
{
    //IF robot has no obstacle in front THEN
        // Call Move robot
        // Add the move command to the command history
        // RETURN true
    //ELSE
        // RETURN false without moving the robot
    //END IF
} 
```





#### Java source code
```raw
public boolean moveRobot (Robot aRobot)
{
    //IF robot has no obstacle in front THEN
    if (aRobot.isFrontClear())
    {
        // Call Move robot
        aRobot.move();
        // Add the move command to the command history
        cmdHistory.add(RobotAction.MOVE);
        return true;
    }
    else // don't move the robot
    {
        return false;
    }//END IF
}
```


<div class="column-one">

## 3. Pseudo-code Examples

習うより慣れろという方針で、各アルゴリズムについてC言語で記述したバージョンと擬似言語で記述した場合の２つを以下比較していきます。

### Bubble sort アルゴリズム

バブルソートは、「配列の後ろから先頭に向かってスキャンしていき、もし隣り合う２つの要素の大小関係がぎゃくであったら入れ替える」という作業を繰り返して配列をソートするアルゴリズムです。



#### C implementation

```raw
#include<stdio.h>

void bubble_sort(int array[], int size)
{
    int i, j, tmp;

    for (i = 0; i < size; i++)
        for (j = size - 1; j > i; j--)
            if (array[j-1] > array[j])
            {
                tmp = array[j];
                array[j] = array[j-1];
                array[j-1] = tmp;
            }
}
```





#### Pseudo codeでの表現

```raw
procedure bubble_sort

  Set array: array to be sorted
  Set size : array size

  repeat
  for i = 0 to size-1 do;
    for j = size - 1 to i do;
      if array[j - 1] > array[j] then
        swap array[j - 1] and array[j]
      end if
    end do
  end do 

end procedure
```
