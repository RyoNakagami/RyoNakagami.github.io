---
layout: post
title: "コーヒー抽出の仕組み"
subtitle: "抽出研究編 1/N"
author: "Ryo"
header-img: "img/tag-bg.jpg"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2022-10-20
tags:

- Coffee
---

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [なぜ抽出の仕組みを学ぶのか？](#%E3%81%AA%E3%81%9C%E6%8A%BD%E5%87%BA%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF%E3%82%92%E5%AD%A6%E3%81%B6%E3%81%AE%E3%81%8B)
- [抽出とは？](#%E6%8A%BD%E5%87%BA%E3%81%A8%E3%81%AF)
  - [透過抽出と浸漬抽出](#%E9%80%8F%E9%81%8E%E6%8A%BD%E5%87%BA%E3%81%A8%E6%B5%B8%E6%BC%AC%E6%8A%BD%E5%87%BA)
  - [親油性](#%E8%A6%AA%E6%B2%B9%E6%80%A7)
- [ペーパードリップ抽出原則](#%E3%83%9A%E3%83%BC%E3%83%91%E3%83%BC%E3%83%89%E3%83%AA%E3%83%83%E3%83%97%E6%8A%BD%E5%87%BA%E5%8E%9F%E5%89%87)
  - [RULE 1: 粒の大きさは均一に](#rule-1-%E7%B2%92%E3%81%AE%E5%A4%A7%E3%81%8D%E3%81%95%E3%81%AF%E5%9D%87%E4%B8%80%E3%81%AB)
  - [RULE 2: 粉砕時に熱を発生させない](#rule-2-%E7%B2%89%E7%A0%95%E6%99%82%E3%81%AB%E7%86%B1%E3%82%92%E7%99%BA%E7%94%9F%E3%81%95%E3%81%9B%E3%81%AA%E3%81%84)
  - [RULE 3: 湯温は浅高深低](#rule-3-%E6%B9%AF%E6%B8%A9%E3%81%AF%E6%B5%85%E9%AB%98%E6%B7%B1%E4%BD%8E)
  - [RULE 4: 湯量のコントロール](#rule-4-%E6%B9%AF%E9%87%8F%E3%81%AE%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%AB)
  - [RULE 5: ハンバーグを作る](#rule-5-%E3%83%8F%E3%83%B3%E3%83%90%E3%83%BC%E3%82%B0%E3%82%92%E4%BD%9C%E3%82%8B)
  - [RULE 6: 濾過層の縁を崩さない](#rule-6-%E6%BF%BE%E9%81%8E%E5%B1%A4%E3%81%AE%E7%B8%81%E3%82%92%E5%B4%A9%E3%81%95%E3%81%AA%E3%81%84)
  - [RULE 7: 抽出液はすぐ飲む](#rule-7-%E6%8A%BD%E5%87%BA%E6%B6%B2%E3%81%AF%E3%81%99%E3%81%90%E9%A3%B2%E3%82%80)
  - [ペーパードリップ抽出のアンチパターン](#%E3%83%9A%E3%83%BC%E3%83%91%E3%83%BC%E3%83%89%E3%83%AA%E3%83%83%E3%83%97%E6%8A%BD%E5%87%BA%E3%81%AE%E3%82%A2%E3%83%B3%E3%83%81%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
- [ペーパードリップによる抽出](#%E3%83%9A%E3%83%BC%E3%83%91%E3%83%BC%E3%83%89%E3%83%AA%E3%83%83%E3%83%97%E3%81%AB%E3%82%88%E3%82%8B%E6%8A%BD%E5%87%BA)
  - [How-to-Brew](#how-to-brew)
  - [抽出方法参考動画の紹介](#%E6%8A%BD%E5%87%BA%E6%96%B9%E6%B3%95%E5%8F%82%E8%80%83%E5%8B%95%E7%94%BB%E3%81%AE%E7%B4%B9%E4%BB%8B)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## なぜ抽出の仕組みを学ぶのか？

コーヒー豆のハンドピックから始まる一連のコーヒー作成プロセスの最後の工程が抽出です.
豆のコンディション, 焙煎の出来など味を左右する要素の状態を踏まえた上で最後に「味のコントロール」ができるチャンスです.

ただカフェイン摂取したいだけならば適当に湯を注いでコーヒーを淹れて飲むでもいいですが, 「こーいう味を出したい」であるとか「いつもどおりの味を出したい」という「味の再現性」を突き詰めることが
コーヒーを楽しむ上で重要であるとするならば, 湯温や注ぎ方といった抽出方法をちょっと変えるだけで味が変化するので, その仕組みを理解することは重要です.

## 抽出とは？

抽出とは, 焙煎までのプロセスを経て生成されたコーヒーの香味成分を「どのようにどれだけ引き出すか？」という工程です.
豆のまま煮出してもコーヒー成分は抽出できないので, 豆を粉砕(グラインディング)して, それをペーパードリップなり浸漬方式なりでお湯にコーヒー成分を溶け出させることが抽出の基本的な流れです.





### 透過抽出と浸漬抽出

コーヒーの抽出方法は基本原理から２つに分類されます

|方式|抽出例|説明|
|---|---|---|
|透過方式|ドリップ, エスプレッソ, 水出し式|コーヒー粉でできた層に水を透過させる|
|浸漬方式|プレス式, サイフォン, ボイル式|コーヒー粉を水に漬けてコーヒーを作成する|

どの方式が優れているとかはなくそれぞれ抽出の特徴があるという感じですが, 浸漬式では
「長く抽出しすぎると雑味が出る」, 透過方式では「美味しい成分が先に出て, その後雑味が流れ出てくる」ということが一般的に言われています.

### 親油性

親油性(疏水性, hydrophobic）とは水に対する親和性が低い, すなわち水に溶解しにくい, あるいは水と混ざりにくい物質または分子の性質のことです. 
コーヒーの文脈における「美味しい成分が先に出て, その後雑味が流れ出てくる」は, 美味しい成分は親水性で, 雑味と言われるものは親油性に分類される傾向があると理解することが出来ます.

> なぜコーヒーの泡は重要なのか？

コーヒーの泡を舐めてみると不快感のある渋みを感じると思います. これはコーヒーの泡が疎水性の苦味成分を集めているためと考えられています.
液相の中で生じる泡の内部は気相となっており, ２つは交わることがないことから, 気相の部分が疎水的, 液相の部分が親水的という二層分配が起こります. 二層分配が発生することにより, コーヒー粉内部にある疎水成分(あと界面活性成分も)が泡に選択的に吸収されていきます.

苦い焦げ成分であるコーヒーメラノイジン(親油性)や微粉や脂質といった成分がコーヒー泡に吸着するので, 苦味を抑えるという観点からコーヒーの泡は重要と理解することが出来ます.


## ペーパードリップ抽出原則
### RULE 1: 粒の大きさは均一に

同じ時間, 同じ湯温に浸した場合を考えると, 大きな粒は内側の成分が溶け出しにくいが, 小さな粒であればすべての成分がすぐ溶け出します. 両者が混在すると, 溶け出す成分が場所場所で均一にはならず, 抽出された味の分散なるものが定義できるとするとその分散が大きくなってしまいます. 

家庭ではグラインディングの段階で大きさを均一にすることは難しいので微粉を取り除くために粉砕後, 茶こしなどで微粉をふるいにかけることが推奨されます.
また, コーヒーミルに微粉が付着し酸化したものが, 次のタイミングのコーヒーに付着してしまうことも考えられるので, コーヒーミルのクリーリングも重要です.

> コーヒー粉ふるい機器: KRUVE SIFTERシリーズ

<iframe width="560" height="315" src="https://www.youtube.com/embed/GrRrXMEvJ4s" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### RULE 2: 粉砕時に熱を発生させない

粉砕時に発生する摩擦熱が大きいと, 酸化のスピードが早まりコーヒーの風味に影響を与えると言われます.
実際に, カリタKH-3を使用し新鮮な焙煎豆をグラインドし, その時に発生する粉砕熱を熱電対により測定した結果, 「2人分のコーヒー豆26gを,特に意識しないスピードで粉砕する際に,ミルの粉砕物が堆積する底部において5℃程度の温度上昇が確認できた」との科研研究があります. [here](https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-24917004/)

ただし, 摩擦熱による「味の違いはプロの僕が飲み比べて分かる程度」と言われたりもするので余り神経質にならなくて良いと思います.

### RULE 3: 湯温は浅高深低

物質の溶解度が温度によって変化するため, どのような成分がどのような比率で抽出されるかは湯温が大きく影響します.
一般的には以下のことが知られています:

- 温度が高いほうが溶け出す成分の総量が増える
- 酸味は移動速度が早く, あまり湯温の影響を受けない
- 苦味成分の移動速度は早いものから遅いものまでさまざまだが, その中で遅いものほど渋味を伴い, 湯温や接触時間の影響を受けやすい

高い湯温で淹れると苦味（場合によっては不要な雑味も）がしっかり出て, 低い湯温で淹れた場合は(苦味が相対的に出ないため)酸味を感じやすくなる傾向があります.
そのため, 一般論として「湯温は浅高深低」と言われていると理解しています.

>  カフェバッハの焙煎度と湯温目安

---|---|---
浅煎り|中~高温(82~85℃)|苦味成分が元から少ないので, 成分を効率よく抽出するため湯温を高めにする
中煎り|中温(82~83℃)|いわゆる適温と呼ばれる湯温で, バランスよく抽出する
深煎り|やや低温〜中温(75~81℃)|苦味を抑えつつ抽出という目的

湯温が86℃以上の場合は「泡が出て膨らみすぎて表面が割れ, 蒸らしが不十分になる」, 74℃以下の場合は「旨味が十分抽出できない & 蒸らしも不十分になる」とのこと.
ただし, ディッティング コーヒーグラインダー KR-804の中挽き（メモリ 5.5）での目安湯温なので, あくまで参考値として用いること.


### RULE 4: 湯量のコントロール

「湯は粉面から3~4cmの高さ, 湯柱の太さは2~3mmが良い」,「落とし始めはゆっくり細く, 後半は苦味成分抽出を抑えるために徐々に太く」と言われたりしますが, これらのような抽出を実現するためには湯量の太さを自由に安定的に調整できる技量が必要となります. 安定的に湯を注ぐためには, 不確定要素を減らす = 毎回の環境を同じにするという方向性で努力すればよく, その一例として
「たとえ１人分だとしても, コーヒーポットには必ず８分目まで湯を注ぎ, ポットの傾き方と湯量の関係を毎回同じにする」というベスプラがあります.

### RULE 5: ハンバーグを作る

<img src="https://github.com/ryonakimageserver/omorikaizuka/blob/master/%E3%83%96%E3%83%AD%E3%82%B0%E7%94%A8/Coffee/20221015-coffee-murashi.jpg?raw=true">

一般的なドリップ式のコーヒーの淹れ方では最初に少量のお湯を注いて, コーヒー粉を蒸らす工程があります. 
このとき写真のようにハンバーグを一旦作り, 目安として20~30秒ほど待ちます. このときサーバーに落ちるコーヒー液はできる限り少なく数滴程度に留めることが良いとされています.

蒸らしは ***コーヒーとお湯をなじませるための工程*** です. コーヒー粉の内部炭酸ガスのせいでお湯とコーヒー粉が接触せず成分抽出できたりできなかったりする箇所が生まれると味にムラができてしまいます.
お湯で蒸らすことでコーヒー粉から炭酸ガスを放出させ, 炭酸ガスが抽出の際に邪魔をすることを防ぐことができる(=コーヒーエキスを安定的に抽出できるようになる)とされています. 
ただし, この炭酸ガスがコーヒーの香りに影響を与える要素でもあるので必ずしも悪の存在というわけでもないです. 
蒸らしによって炭酸ガスをお湯にゆっくり溶け込ませ, 香り成分を抽出するという側面もあるかもしれません. 

> 蒸らしの目安：20~30秒

20~30秒ほどが蒸らしの目安ですが, 「コーヒーとお湯をなじんだ」状態がわかるならばその段階がストップのタイミングとなります.
コーヒーとお湯をなじませる理由の一つとして「炭酸ガスを放出させる」という事象があるので「炭酸ガスが抜けた」タイミングが止め時となります.

ハンバーグ状態とは, お湯に炭酸ガスが溶け込んでプクプク膨らんで来ることなので, 「炭酸ガスが抜けた」タイミングとは「プクプク膨らみが止まる時」となります.
人によっては, 「ぷしゅ」と小さく萎む瞬間で判断しているようですが, だいたいこのタイミングが20~30秒なので, それが蒸らし工程の目安時間となっています.

> 蒸らし工程での注意点

1. ドリッパーに粉を入れたら, 静かに揺らして粉面を平らにすること
2. ペーパーに直接お湯をかけないように注意
3. 「の」（５円玉とも）を描きながらゆっくり注ぎ, コーヒー粉全体に湯が染み渡るように「蒸らし」をする

> 蒸らし時間によって味わいが変化

蒸らす時間を短めにすると甘みが出にくくスッキリとした味わいになります:

- 時間短め: 酸味が強く出る傾向にある
- 時間長め: 渋みが増しやすくなる

### RULE 6: 濾過層の縁を崩さない

蒸らしが終えたら, 2投目, 3投目と注湯をしますが, 「の」を描くように全体に行き渡るようにする他に, 
「濾過層の縁を崩さない」ように注意する必要があります.

濾過層の縁を崩すことは, (1) お湯がペーパーに直接いってしまう, (2) 抽出層が注湯のたびに異なってしまう, という２つの観点から
成分抽出の安定性と効率性を崩してしまい薄っぺらい味になってしまうというデメリットがあります.

> カフェ・バッハ式注湯は三投目まで？

バッハ式では「コーヒー成分は3回目までの注湯で抽出される」としています. これ以降の4投目とかは濃度と抽出量の調整と考えています.
なお3投目以降の抽出お作法として, 濾過層の形をできる限りキープするため「粉面の中心部が少し凹み, 湯が落ちきる寸前に注湯する」と推奨しています. 

抽出層の形をできる限りキープすることで, 抽出の不確実要素を減らすというカフェ・バッハ式らしいアドバイスかなと思います.

### RULE 7: 抽出液はすぐ飲む

ハンドドリップ後に抽出液を保存しておくと, 熱によって水分蒸発が進み, 抽出液の濃度が上昇してしまいます.
濃度変化は味変化に繋がるので, 再現性のある味を良いコーヒーとするならば, 抽出液はすぐ飲むことが推奨されます.

また, 密閉された容器に入れて保存したとしても, 熱による成分変化による味の変化が発生してしまうので,
作ったら出来るだけ早く飲むべきと言えます.




### ペーパードリップ抽出のアンチパターン

> 蒸らしタイミングにおける陥没

蒸らしのタイミングで中央部分が陥没したり, 膨らまない場合は基本的には炭酸ガスの不足が原因となります. 炭酸ガス不足のパターン例は以下が考えられます:

- 豆の鮮度が落ちているため, 炭酸ガス等の香味が抜けきってしまいハンバーグが形成されない
- 湯温が低すぎて, コーヒー豆内の炭酸ガスが溶け出さないため

> 蒸らし時に蒸気が吹き出す

蒸らしの際にプツプツと蒸気が吹き出して大きな気泡が形成されハンバーグが割れることがあります. 
このとき, 蒸らしが不十分となりまとまりのない味（＝ムラのある味）になるリスクがあります.

この場合は煎りたて, メッシュが細かい, 湯温が高すぎる, メッシュが細かすぎるて炭酸ガスが多くなってしまっている or/and 発生したガスを上手く逃しきれていない事が考えられます.

対応策としては, 大きな気泡が形成されそうである兆候を見つけたときに投入する湯量を少なくすることが一つ考えられます.


## ペーパードリップによる抽出

> コーヒー粉の量の目安

コーヒーカップ１杯を 120 cc程度と定義した時, 目安としてのコーヒー粉の量は以下となります:

---|---
1杯|12~15g
2杯|20~24g
3杯|24~28g
4杯|28~32g
5杯|35g




### How-to-Brew







### 抽出方法参考動画の紹介




## References

> オンラインマテリアル

- [コーヒードリッパーのリブって意味あるの？](https://every-coffee.com/article/doriper-rib.html)
- [THE COFFEESHOP > 微粉を取り除くとコーヒーの味はどう変わるのか｜フルイにかけて検証](https://www.thecoffeeshop.jp/ct_beans/%E5%BE%AE%E7%B2%89%E3%82%92%E5%8F%96%E3%82%8A%E9%99%A4%E3%81%8F%E3%81%A8%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC%E3%81%AE%E5%91%B3%E3%81%AF%E3%81%A9%E3%81%86%E5%A4%89%E3%82%8F%E3%82%8B%E3%81%AE%E3%81%8B/)
- [COFFEE TOWN > コーヒーを蒸らすのは何のため？コーヒーを美味しく味わうための大切なコツも紹介](https://www.ejcra.org/column/ca_129.html)
- [コーヒー豆粉砕時における熱発生および熱伝達挙動の解析](https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-24917004/)

> 書籍

- [NHK出版, コーヒー抽出の法則, 著田口護, 山田康一](https://www.nhk-book.co.jp/detail/000000333002019.html)
- [BLUE BACKS, コーヒーの科学 「おいしさ」はどこで生まれるのか (ブルーバックス) 新書, 旦部 幸博 (著)](https://www.amazon.co.jp/%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC%E3%81%AE%E7%A7%91%E5%AD%A6-%E3%80%8C%E3%81%8A%E3%81%84%E3%81%97%E3%81%95%E3%80%8D%E3%81%AF%E3%81%A9%E3%81%93%E3%81%A7%E7%94%9F%E3%81%BE%E3%82%8C%E3%82%8B%E3%81%AE%E3%81%8B-%E3%83%96%E3%83%AB%E3%83%BC%E3%83%90%E3%83%83%E3%82%AF%E3%82%B9-%E6%97%A6%E9%83%A8-%E5%B9%B8%E5%8D%9A/dp/4062579561/ref=as_li_ss_tl?_encoding=UTF8&qid=&sr=&linkCode=sl1&tag=bluebacks-22&linkId=ab75490fd32cb18af305fbe65ec42018&language=ja_JP)