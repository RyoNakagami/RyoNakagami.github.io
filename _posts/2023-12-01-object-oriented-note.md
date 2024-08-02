---
layout: post
title: "はじめてのオブジェクト指向"
subtitle: "オブジェクト指向設計 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2023-12-26
tags:

- coding
- 方法論
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [オブジェクト指向をなぜ学ぶ必要があるのか？](#%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%8C%87%E5%90%91%E3%82%92%E3%81%AA%E3%81%9C%E5%AD%A6%E3%81%B6%E5%BF%85%E8%A6%81%E3%81%8C%E3%81%82%E3%82%8B%E3%81%AE%E3%81%8B)
- [オブジェクト指向の基本的考え方](#%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%8C%87%E5%90%91%E3%81%AE%E5%9F%BA%E6%9C%AC%E7%9A%84%E8%80%83%E3%81%88%E6%96%B9)
  - [OOPが生まれた背景](#oop%E3%81%8C%E7%94%9F%E3%81%BE%E3%82%8C%E3%81%9F%E8%83%8C%E6%99%AF)
- [クラス化のメリット](#%E3%82%AF%E3%83%A9%E3%82%B9%E5%8C%96%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
  - [Propety 1: まとめる](#propety-1-%E3%81%BE%E3%81%A8%E3%82%81%E3%82%8B)
  - [Property 2: 隠す](#property-2-%E9%9A%A0%E3%81%99)
  - [Property 3: たくさん作る](#property-3-%E3%81%9F%E3%81%8F%E3%81%95%E3%82%93%E4%BD%9C%E3%82%8B)
  - [Property 4: インスタンス変数](#property-4-%E3%82%A4%E3%83%B3%E3%82%B9%E3%82%BF%E3%83%B3%E3%82%B9%E5%A4%89%E6%95%B0)
- [ポリモーフィズムのメリット](#%E3%83%9D%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%95%E3%82%A3%E3%82%BA%E3%83%A0%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
- [継承のメリット](#%E7%B6%99%E6%89%BF%E3%81%AE%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
  - [インターフェース](#%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%95%E3%82%A7%E3%83%BC%E3%82%B9)
- [その他のOOPの特徴](#%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AEoop%E3%81%AE%E7%89%B9%E5%BE%B4)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## オブジェクト指向をなぜ学ぶ必要があるのか？

プログラミング言語の一つのパラダイムとして手続き型と共にオブジェクト指向型(object-oriented programming, OOP)という考え方が昔からありました. 最近では, プログラミング技術を超えて, 設計活動や分析活動, アジャイル開発という多くの場面でも用いられる概念となっています.

- そもそもオブジェクト指向はなんなのか？ = what
- なぜ多くの現場で使われるようになったのか？ = why
- 実際にどのように現場で自分が使うのか？ = how

を理解することは最近の開発や分析の動向を理解するために重要といえます.

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/Development/20231201_OOP.png?raw=true">


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#e6e6fa; background-color:#e6e6fa'>
<p class="h4"><ins>Column: PythonはOOP?</ins></p>

Pythonはクラスとインスタンス, メソッド, スーパークラスとサブクラス, オーバーライドといったOOPの仕組みを実装したOOPLです. ただし, クラスに属さない関数やグローバル変数も定義できます. さらにmap関数やfilter関数の第一引数でよく用いられるラムダ式など関数型言語の仕組みもサポートしているという特徴もあります.

</div>のこと



## オブジェクト指向の基本的考え方

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>OOPの目的: 部品の独立性</ins></p>

- OOPはソフトウェアの保守や再利用をしやすくすることを重視する技術
- 個々のObjectの独立性を高め, それらを組み上げてシステム全体の機能を実現する流儀

</div>のこと

OOPが普及する以前は「機能中心」開発手法が主流でした. この開発機能は

- 開発対象となるシステム全体の機能を整理
- 段階的に詳細化していき, 個々の機能を定義する

というものです. 業務のフローや手順が固定化されていてそれを反映したシステムを構築する際には有効な考え方ですが, 
仕様変更が起きた場合修正範囲が広範囲に及びやすく, ソフトウェアの再利用も難しいという課題がありました. 一方, OOPでは個々のObject(=部品)の独立性を高め, それらを組み上げてシステム全体の機能を実現するという考え方です.

そのため, OOPが理想的に機能すれば, では一部のObjectに仕様変更が発生したとしてもそ
の影響範囲は最小限にとどまる, また別のシステムでもObjectを再利用する余地があるというメリットがあります.

この部品の独立性を実現する仕組みとしてOOPでは, クラス, ポリモーフィズム, 継承という三大要素を利用しています.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>OOP Property 2: クラス化（カプセル化）</ins></p>

- データ（attribute）と関数(method)を一つにまとめたオブジェクトを用いることで「各所に散らかっていた似たようなコードを一つにまとめる」ことを実現する
- オブジェクトの設計図のことをクラスという

</div>


クラスと対になる概念としてインスタンスがあります. 基本的には

- クラス: オブジェクトの設計図や種類
- インスタンス: 設計図や種類に対応する具体的なモノ


に相当します. プログラムが動くときには, 定義したクラスからインスタンスが作られ, それが相互作用し合いながらソフトウェアの機能を実現しています. ワンと吠える犬のクラスとインスタンスをJavaで書くとすると

```java
// classの定義
class Dog {
    String name; //Dog's name
    Dog(string name){ //コンストラクタ
        this.name = name;
    }
    String cry(){ //メソッド
        return "Bow";
    }
}

// classに基づいたinstanceの定義と動作

Dog pochi = new Dog("Pochi");
System.out,printin(pochi.cry());
```

なおインスタンスが帰属するクラスは基本的には１つだけです.


<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>OOP Property 3: ポリモーフィズムと継承</ins></p>

- ポリモーフィズム: 類似したクラスへのメッセージの送り方を共通化する仕組み
- 継承: 似たもの同士のクラスの共通点と相違点を整理する仕組み
のこと
どちらもコードの重複を排除して汎用性の高い部品を作る仕組みといえる

</div>


たとえば, 「cry!!」ってメッセージをオブジェクトに送るとき, 犬ならば「Bow」と鳴き, 鶏ならば「cock-a-doodle-doo」ってなくと思いますが, 鳴き方の具体的な定義が違うだけで, 動物ならば「cry」というmethodを持っています. これをabstract classと継承を用いて書くとすると

```java
class Animal {
    abstract String cry();
}

class Dog extends Animal { //Animalの継承
    String cry(){
        return "Bow";
    }
}
```

また継承を使いこなすことでよく似ているけど詳細は異なるクラスをそれぞれ以下のように定義することもできます. どの動物も`cry`は共通して持っているけれども, `bite`や`fly`というメソッドを動物クラスに応じて持っている状況を表現する場合は,

```java
class Animal {
    abstract String cry();
}

class Dog extends Animal { //Animalの継承
    void bite()
}

class Bird extends Animal { //Animalの継承
    void fly()
}
```

### OOPが生まれた背景

OOPはプログラミングの歴史の流れの中から生まれたものである日突然, 突然変異的に生まれたものではありません. マシン語, アセンブリ, FORTRANといった言語が出現したその歴史の中で, プログラミン技の生産性や品質を高めるためのプラグラミングパラダイムというのは模索され続けました. その探索の中, エドガー・ダイクストラ氏によって

- 「**正しく動作するプログラムを作成するためには, わかりやすい構造にすることが重要である**」

という構造化プログラミングが提唱されました. その具体的方法として,

- `GOTO`文の廃止
- 基本三構造（順次進行, 条件分岐, 繰り返し）だけでの処理の表現
- サブルーチンの独立性の確保
- グローバル変数の回避とロカール変数及び引数の値渡し(call by value)のススメ

これらの考えに基づく言語としてPascal, Cといった構造化言語が登場しました. しかしこの構造化言語でも

- グローバル変数問題; サブルーチンの外側で保持するデータはグローバル変数として保持せざる得ない
- 貧弱な再利用問題: プログラムをまたいで再利用できる範囲はサブルーチン単位に限定される

という問題は引き続き残りました. そして, これらの課題を解決するパラダイムとしてOOPは誕生しました. 具体的には上で説明したように

- クラス化を活用することによって, 「関連性の強いサブルーチン群とデータをまとめて管理」することができる
- ポリモーフィズムと継承によって, 「重複したコードを一本化する（＝再利用する）」ことができる

OOPのこれら利点を実装した言語として, Python, Java, PHP, Ruby, C++といった言語が登場しそして現在でも多くの場面で利用されています.

## クラス化のメリット

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>クラス化の特徴</ins></p>

クラスとは「まとめて, 隠して, たくさん生産する」仕組み

- サブルーチンとデータをまとめる
- クラスの内部だけで使う変数やサブルーチンを隠す
- 1つのクラスからインスタンスをたくさん生産する

</div>

Fileをopen, read, closeする以下のクラスを例に説明していきます.

```python
class TextFileReader:
    def __init__(self, FilePath:str, chunk:int=100):
        self.FilePath = FilePath
        self.chunk = chunk
        self.content = ''
        self.set_content()
    
    def set_content(self):
        self.__open()
        self.__read()
        self.__close()

    def __open(self):
        self.__data = open(self.FilePath, 'rt')
    
    def __read(self):
        while True:
            fragment = self.__data.read(self.chunk)
            if not fragment:
                break
            self.content += fragment
    
    def __close(self):
        self.__data.close()

    def display(self):
        if self.content != '':
            print(self.content)
        else:
            raise ValueError('content is empty! Please make sure you properly specified the file path')
```

最後の`display`は読み取った文字列をコンソール上に出力するメソッドです.


### Propety 1: まとめる

クラスにより複数のサブルーチンとデータをまとめて管理することができます. OOPの文脈では, まとめたサブルーチンをメソッドと呼び, データのことをインスタント変数（attribute, fieldなどとも）と呼びます. 

上の例では開いたファイル`self.__data`を, `read_data`, `close_file`の２つから参照する必要があります. クラスを用いない場合だとグローバル変数からわざわざ参照するか, 値渡しする必要がありますが, インスタンス変数として管理することでなんの値を参照しているかのスコープがわかりやすくなっています.

### Property 2: 隠す

`self.__data`はメソッドからはアクセスできる必要がありますが, クラス外からアクセスする必要はないインスタンス変数となります. クラス外からのアクセスを許容してしまうと不必要にデータが変更される恐れがあり, バグが見つかった場合の原因探索の範囲が板面に広がってしまうデメリットがあります. そのため, クラス外から「**隠す**」機能が必要となります.

Javaでは`private`や`public`をメソッドやインスタンス変数に対して宣言することで「隠す」ことができますが, Pythonでは**２つのアンダースコアを名前の先頭につける**ことで, 外から直接見えないようにするマングリングという仕組みがあります. 実際に, 

```python
RandomText = TextFileReader('sandbox/class/test.txt')
RandomText.__data
>>> AttributeError: 'TextFileReader' object has no attribute '__data'
```

ただし完全に隠せている訳ではなく

```python
RandomText._TextFileReader__data
>>> <_io.TextIOWrapper name='sandbox/class/test.txt' mode='rt' encoding='UTF-8'>
```

Pythonではこのようにある程度アクセスを防ぐことができるにとどまります.

### Property 3: たくさん作る

「まとめる」や「隠す」はC言語などの構造化言語でも十分実現可能ですが, 「たくさん作る」はOOP特有の機能と言えます.
一つのファイルの中身を確認するだけだと, この機能はあまり必要ではありませんが, 同時に複数のファイルの中身を読み取り & 比較するという処理を実現する場合めんどくさくなります.

個々で便利な仕組みが「クラスとインスタンス」です. クラスはあくまで設計図ですが, その設計図に基づいて作られたオブジェクトがインスタンスです. このインスタンスはクラスで定義したインスタンス変数が確保されるメモリ領域と考えることができます.

```python
RandomText = TextFileReader('sandbox/class/test.txt')
RandomText2 = TextFileReader('sandbox/class/test2.txt')
print(RandomText.content == RandomText2.content)
>>> False
```

のように, クラスに基づいて複数のインスタンスを同時に定義できますし, かつそれらのattributesを比較するなどの処理もかんたんに実装することができます.

### Property 4: インスタンス変数

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>インスタンス変数の性質</ins></p>

- 別のクラスのメソッドからアクセスできないように隠すことができる
- 一旦インスタンスが作られた後は, 必要なくなるまでメモリ上に残される

</div>

基本的にはインスタンス変数は「同じインスタンス内のみのグローバル変数」や「長持ちするローカル変数」という理解です.

||ローカル変数|グローバル変数|インスタンス変数|
|---|---|---|---|
|複数サブルーチンからのアクセス|不可|可|可|
|アクセス可能範囲の限定|可（一つのサブルーチンからしかアクセスできない）|不可（プログラムのどこからでもアクセス可能）|可（同じクラス内のメソッドからのみアクセス可能と指定できる）|
|存続期間の長さ|サブルーチン呼び出しのみに作られ, 抜けたら破棄される|アプリケーションの開始から終了まで|インスタンスが作られてから破棄されるまで|
|変数領域の複製|不可|不可|複製可能|

## ポリモーフィズムのメリット

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>ポリモーフィズムのメリット</ins></p>

- ポリモーフィズムとは共通メインルーチンを作るための仕組み

</div>

共通サブルーチンとの違いは, 

- 共通サブルーチン: 呼び出される側のロジックを1つにまとめる
- ポリモーフィズム: 呼び出す側のロジックを一本化する

「**呼び出す側のロジックを一本化する**」とは, 呼び出し元の差異があったとしても統一されたインターフェースで操作することができるようにすると理解することができます. 

例として, 10から1までのカウントダウンをする`Kids`と3の倍数だけMeowと言ってしまうがそれ以外は普通にカウントダウンする`ThreeCat`という2つのクラスを引数に, カウントダウン後, Happy Newyear!!出力する呼び出し側を実装してみます.

抽象基底クラス(インターフェースに相当)を用いて派生クラスにメソッドの実装を矯正させながら実装すると以下のようになります


```python
from abc import ABC, abstractmethod
from functools import reduce

class People(ABC):
    def __init__(self):
        self.max_num = 10

    @abstractmethod
    def count_ten(self):
        pass
    
class Kids(People):
    def count_ten(self):
        return reduce(lambda a, b: a + ',' + b, [str(i) for i in range(1, self.max_num+1)][::-1])
 
class ThreeCat(People):
    def count_ten(self):
        return reduce(lambda a, b: a + ',' + b, [str(i) if i % 3 != 0 else 'Meow' for i in range(1, self.max_num+1)][::-1])

def newyear_countdown(people):
    print(people.count_ten() + ', Happy Newyear!!')

Mike = Kids()
Nabe = ThreeCat()

newyear_countdown(Mike)
newyear_countdown(Nabe)
>>> 10,9,8,7,6,5,4,3,2,1, Happy Newyear!!
>>> 10,Meow,8,7,Meow,5,4,Meow,2,1, Happy Newyear!!
```

`newyear_countdown`を変更し, `Merry Xmas!!`と出力するようにしたとしても元のクラスをいじる必要はなく

```python
def xmas_countdown(people):
    print(people.count_ten() + ', Merry Xmas!!')
```

このように呼び出し元を意識することなく修正を実行することができます.

## 継承のメリット

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>継承のメリット</ins></p>

- クラスの共通部分を別のクラスにまとめることで, コードの重複を排除する仕組み

</div>

継承を利用することで, 別のクラスから手元のクラスにmethodやdataをまるごと拝借させることができます. 一般的に共通クラスのことをスーパークラス, それを利用するクラスをサブクラスと呼びます.

ただし, 継承を使うと混乱した設計になるケースが多いという理由から現場で継承の使用はそこまで推奨されるものではありません. 利用するとしても

- 依存関係のためのインターフェースを定義する場合
- オブジェクトの階層を定義する場合(組み込みの例外クラスを拡張してカスタム例外を定義するなど)

### インターフェース

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: インターフェース</ins></p>

- メソッドのシグネチャ（名前, 引数の定義, 戻り値の型）だけをもつクラスのこと
- インターフェースを継承したクラスは, インターフェースで定義されたメソッドの実際の実装を提供することを強制される

</div>

インターフェースは実装を定義せずにシグネチャだけを提供します. Fooインターフェースを実装したBazクラスならば

```c
interface Foo
{
    public function foo(): void;
}

class Baz implements Foo
{
    public foo(): void
    {
        //
    }
}
```

あるメソッドは実装を提供し, 他のメソッドではシグネチャのみという形を希望する場合は, **抽象クラス**という仕組みを利用します. Fooにて`bar`というメソッドは定義したいが, `foo`はシグネチャのみという形で定義. そして, その具体的実装は Bazクラスにて取り扱う場合は, 

```c
abstract class Foo
{
    abstract public function foo(): void;

    public function bar(): vooid
    {
        //
    }
}

class Baz extends Foo
{
    public function foo(): void
    {
        //
    }
}

```

## その他のOOPの特徴

クラス化, ポリモーフィズム, 継承がOOPの三大特徴ですが, 最近の実装では更に進んだ機能として

- パッケージ: 複数のクラスをまとめる仕組み
- 例外: 重複したエラー処理をまとめる仕組み
- ガーベジコレクション: 不要なインスタンスを自動的にメモリ上から削除する仕組み

などがあります.


References
----------
- [オブジェクト指向でなぜつくるのか 第3版 知っておきたいOOP、設計、アジャイル開発の基礎知識](https://bookplus.nikkei.com/atcl/catalog/21/S00180/)