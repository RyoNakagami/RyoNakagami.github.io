---
layout: post
title: "デバイスが利用しているグローバルIPアドレスとローカルネットワーク内のデバイスの検索"
subtitle: "ネットワークを学ぶ 5/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
mermaid: false
last_modified_at: 2024-03-04
tags:

- Network
- Linux

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [現在利用しているデバイスのグローバルIPアドレスの確認方法](#%E7%8F%BE%E5%9C%A8%E5%88%A9%E7%94%A8%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%81%AE%E3%82%B0%E3%83%AD%E3%83%BC%E3%83%90%E3%83%ABip%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9%E3%81%AE%E7%A2%BA%E8%AA%8D%E6%96%B9%E6%B3%95)
  - [グローバルIPアドレスからわかること](#%E3%82%B0%E3%83%AD%E3%83%BC%E3%83%90%E3%83%ABip%E3%82%A2%E3%83%89%E3%83%AC%E3%82%B9%E3%81%8B%E3%82%89%E3%82%8F%E3%81%8B%E3%82%8B%E3%81%93%E3%81%A8)
- [ローカルネットワーク内のデバイスの検索](#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E5%86%85%E3%81%AE%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%81%AE%E6%A4%9C%E7%B4%A2)
  - [自分のデバイスのprivate IP addressの確認](#%E8%87%AA%E5%88%86%E3%81%AE%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%81%AEprivate-ip-address%E3%81%AE%E7%A2%BA%E8%AA%8D)
  - [`nmap`でローカルネットワーク内の端末確認](#nmap%E3%81%A7%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E5%86%85%E3%81%AE%E7%AB%AF%E6%9C%AB%E7%A2%BA%E8%AA%8D)
  - [`ping`コマンドを用いたIPレベルの接続確認](#ping%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E7%94%A8%E3%81%84%E3%81%9Fip%E3%83%AC%E3%83%99%E3%83%AB%E3%81%AE%E6%8E%A5%E7%B6%9A%E7%A2%BA%E8%AA%8D)
  - [`firewalld`で PINGを拒否設定する](#firewalld%E3%81%A7-ping%E3%82%92%E6%8B%92%E5%90%A6%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)
- [Appendix: ICMPパケットの構成要素](#appendix-icmp%E3%83%91%E3%82%B1%E3%83%83%E3%83%88%E3%81%AE%E6%A7%8B%E6%88%90%E8%A6%81%E7%B4%A0)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>
ローカルネットワーク内の端末確認
## 現在利用しているデバイスのグローバルIPアドレスの確認方法

グローバルIPはサーバーが持っていない情報であるため, サーバーが自分のグローバルIPを確認するには、他のウェブサイトから確認してもらい、その値を返してもらう必要があります.

やり方の１つとして, [http://ipconfig.io/](http://ipconfig.io/)にアクセスして確認することができます.

```zsh
% curl http://ipconfig.io/
216.xxx.xxx.xx
```

より詳細な情報を取得したい場合は
ローカルネットワーク内の端末確認
```zsh
% curl -H 'Accept: application/json' ifconfig.co | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   511  100   511    0     0   1769      0 --:--:-- --:--:-- --:--:--  1774
{
  "ip": "216.xxx.xxx.xx",
  "ip_decimal": 26xxxxxxxx,
  "country": "Japan",
  "country_iso": "JP",
  "country_eu": false,
  "region_name": "Tokyo",
  "region_code": "13",
  "zip_code": "151-xxxx",
  "city": "Tokyo",
  "latitude": 35.xxxx,ローカルネットワーク内の端末確認
  "longitude": 139.xxxx,
  "time_zone": "Asia/Tokyo",
  "asn": "AS44xxx",
  "asn_org": "INTERNET MULTIFEED CO.",
  "hostname": "xx.xxx.xxx.xxx.shared.user.transix.jp",
  "user_agent": {
    "product": "curl",
    "version": "7.81.0",
    "raw_value": "curl/7.81.0"
  }
}
```

### グローバルIPアドレスからわかること
ローカルネットワーク内の端末確認
Webアクセスをすると, IPデータグラム（パケット）には発信者のIPアドレスが書いてあるためWebサーバー側に利用者のIPアドレスがログとして残ります.

```zsh
% nslookup github.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
www.github.com  canonical name = github.com.
Name:   github.com
Address: 20.27.177.113
```

例えば, 上のコマンドより`20.27.177.113`はgithub.comのグローバルIPアドレスであることがわかります.
逆にこのグローバルIPアドレスがわかっているとして情報を確認してみると

```zsh
% curl https://ipinfo.io/20.27.177.113 | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Currentローカルネットワーク内の端末確認
                                 Dload  Upload   Total   Spent    Left  Speed
100   253  100   253    0     0   1197      0 --:--:-- --:--:-- --:--:--  1199
{
  "ip": "20.27.177.113",
  "city": "Tokyo",
  "region": "Tokyo",
  "country": "JP",
  "loc": "35.6895,139.6917",
  "org": "AS8075 Microsoft Corporation",
  "postal": "101-8656",ローカルネットワーク内の端末確認
  "timezone": "Asia/Tokyo",
  "readme": "https://ipinfo.io/missingauth"
}
```

このように

- `org`: サーバーのプロバイダ名
- `loc`: サーバーの緯度経度情報

の情報を取得することができます. IPアドレスを割り当てはアドレス管理組織によって厳密に決められており, IPアドレスとその範囲ごとに管理者の名前が公開されているため, Webサーバーなどに残る送信元IPアドレスから, 利用者が接続しているプロバイダや企業の名前を特定するのは比較的簡単にできます. 一方, そこから利用者の名前や住所といった個人情報は簡単には特定することはできません.

IPアドレスとそれが使われた時間がわかれば, プロバイダなどの記録から利用者の名前や住所を調べることが原理的に可能です. しかし,
電気通信事業者法という法律で, プロバイダは利用者の通信の秘密を守る義務が課せられているため, 基本的には犯罪捜査などの強い理由がないと開示されることはありません. 企業ネットワークでは制約はありませんが, IPアドレスの利用者情報を関係がない第三者に明かすケースはたいへんまれです.

## ローカルネットワーク内のデバイスの検索

手順としては

1. 自分のデバイスのprivate IP addressの確認(`nmcli device show `コマンド)
2. `nmap`でローカルネットワーク内の端末確認

という流れになります.

### 自分のデバイスのprivate IP addressの確認

`hostname -I`コマンドや`ip a`コマンドでも確認できますが, ここでは`nmcli device show`で確認する方法を紹介します.

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: nmcliコマンド</ins></p>

`nmcli`は, コンソールやターミナル上からコマンドでNetworkManagerの制御を行うコマンドラインツール

```zsh
% nmcli [option] Object {command|help}
```

`Object`には, デバイスの表示と管理を行う`device`と, 接続の管理を行う`connection`などがあります.

</div>

以下のように, `nmcli`コマンドに`device show`というオブジェクトとコマンドを付けることでネットワークデバイスの情報を表示させることができます

```zsh
% nmcli device show
GENERAL.DEVICE:                         wlp13s0
GENERAL.TYPE:                           wifi
GENERAL.HWADDR:                         XX:XX:XX:XX:XX:XX
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected)
GENERAL.CONNECTION:                     yushimarvelローカルネットワーク内の端末確認
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/1
IP4.ADDRESS[1]:                         192.168.10.110/24
IP4.GATEWAY:                            192.168.10.1
IP4.ROUTE[1]:                           dst = 192.168.10.0/24, nh = 0.0.0.0, mt = 600
IP4.ROUTE[2]:                           dst = 0.0.0.0/0, nh = 192.168.10.1, mt = 600
IP4.DNS[1]:                             192.168.10.1
IP6.GATEWAY:                            --

GENERAL.DEVICE:                         xx-xxxxxxxxxxxx
GENERAL.TYPE:                           bridge
GENERAL.HWADDR:                         XX:XX:XX:XX:XX:XX
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected (externally))
GENERAL.CONNECTION:                     xx-xxxxxxxxxxxx
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/2
IP4.ADDRESS[1]:                         172.xx.xx.1/16
IP4.GATEWAY:                            --
IP4.ROUTE[1]:                           dst = 172.xx.xx.0/16, nh = 0.0.0.0, mt = 0
IP6.GATEWAY:                            --
```

操作している端末のPrivate IP addressは`IP4.ADDRESS[1]`より`192.168.10.110/24`とわかります. 

```
IP4.ROUTE[1]:                           dst = 192.168.10.0/24
```

より, LAN内ネットワークアドレスは`192.168.10.0/24`であることも読み取れます.

### `nmap`でローカルネットワーク内の端末確認
ローカルネットワーク内の端末確認
<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: nmap</ins></p>

Nmap(Network Mapper)は, ネットワーク調査およびセキュリティ監査を行うためのオープンソースのツール. 

Raw IPパケットを用いて, 

- ネットワーク上でどのようなホストか利用可能になっているか
- これらのホストが提供しているサービス(アプリケーション名とバージョン)は何か
- ホストが実行しているOS(OS名とバージョン)は何か
- どのような種類のパケットフィルタ/ファイアウォールが使用されているか

などの情報を判別 & ユーザーに提供することができる. 

</div>


`nmap`をインストールしていない場合は以下のコマンドでインストールを実行します.

```zsh
% sudo apt update
% sudo apt install nmap
```

実行時間が遅いので高速スキャンのオプションである`-T4`をもちいてLAN内ネットワークを探索する場合

```zsh
% sudo nmap -T4 192.168.10.0/24 
Starting Nmap 7.80 ( https://nmap.org ) at 2020-03-05 00:54 JST
Nmap scan report for xxxxx.xx (192.168.10.1)
Host is up (0.0013s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE
53/tcp   open  domain
80/tcp   open  http
3517/tcp open  802-11-iapp
MAC Address: XX:XX:XX:XX:XX:XX (Unknown)

Nmap scan report for kirby-B2 (192.168.10.104)
Host is up (0.0013s latency).
All 1000 scanned ports on kirby-B2 (192.168.10.104) are filtered
MAC Address: XX:XX:XX:XX:XX:XX (Hewlett Packard)

Nmap scan report for kirby-MBP (192.168.10.105)
Host is up (0.0090s latency).
All 1000 scanned ports on kirby-MBP (192.168.10.105) are filtered
MAC Address: XX:XX:XX:XX:XX:XX (Apple)

Nmap scan report for kirby-Desktop (192.168.10.103)
Host is up (0.0000060s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
80/tcp open  http

Nmap done: 256 IP addresses (4 hosts up) scanned in 41.68 seconds
```

これでローカルネットワーク内の端末とそれらのPrivate IP Addressを知ることができます.

### `ping`コマンドを用いたIPレベルの接続確認

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: pingコマンド</ins></p>

`ping`コマンドはICMP(Internet Control Message Protocol)というプロトコルを使用したパケットをホストに送信し, 
その応答を調べることにより, IPレベルでのホスト間の接続性をテストするコマンド.

```zsh
% ping [option] 送信先ホスト
```

|オプション|説明|
|---|---|
|`-c 送信パケット個数`|送信するパケットの個数を指定. 指定しない場合は, 中断するまでパケットの送信を続ける|
|`-i 送信間隔`|秒単位の送信間隔の指定. デフォルトは1秒(=`-i 1`)|

</div>

`ping`コマンドは, ICMPの`echo request`パケットを相手に送信し, 相手ホストからの`echo reply`パケットの応答により
接続性を調べています. 


GitHub.comとの疎通を確認したい場合は

```zsh
% ping github.com
PING github.com (20.27.177.113) 56(84) bytes of data.
64 bytes from 20.27.177.113 (20.27.177.113): icmp_seq=1 ttl=115 time=6.89 ms
64 bytes from 20.27.177.113 (20.27.177.113): icmp_seq=2 ttl=115 time=19.0 ms
^C
--- github.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 6.891/12.924/18.958/6.033 ms
```

`2 packets transmitted, 2 received, 0% packet loss, time 1000ms`より読み解けることは

- ２個のパケットを送信
- それらに対して2個とも応答があった
- パケットロスはゼロであった


### `firewalld`で PINGを拒否設定する

同じローカルネットワークに２台の端末が存在するとします. そのうち, Local IP Address `192.168.100.113`をもつ端末について, `ping`されても応答しない設定を行います.

まず, 設定しない場合は同じLAN内部の別端末より

```zsh
% ping 192.168.100.113        
PING 192.168.100.113 (192.168.100.113) 56(84) bytes of data.
64 bytes from 192.168.100.113: icmp_seq=1 ttl=64 time=4.07 ms
64 bytes from 192.168.100.113: icmp_seq=2 ttl=64 time=15.3 ms
64 bytes from 192.168.100.113: icmp_seq=3 ttl=64 time=4.03 ms
64 bytes from 192.168.100.113: icmp_seq=4 ttl=64 time=19.5 ms
64 bytes from 192.168.100.113: icmp_seq=5 ttl=64 time=16.0 ms
64 bytes from 192.168.100.113: icmp_seq=6 ttl=64 time=17.9 ms
^C
--- 192.168.100.113 ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5003ms
rtt min/avg/max/mdev = 4.029/12.800/19.497/6.330 ms
```

このように反応しています. 次に`ICMP`拒否の設定を行います.

```zsh
kirby@192.168.100.113: ~$ firewall-cmd --set-target=DROP --permanent
success
kirby@192.168.100.113: ~$ firewall-cmd --reload
success
```

`DROP`と設定することでICMP応答を返さなくなります. 設定後にもう一度確かめてみます.

```zsh
% ping 192.168.100.113
PING 192.168.100.113 (192.168.100.113) 56(84) bytes of data.
^C
--- 192.168.100.113 ping statistics ---
7 packets transmitted, 0 received, 100% packet loss, time 6246ms
```

`0 received, 100% packet loss`となっているので設定が上手く行っていることがわかります.

## Appendix: ICMPパケットの構成要素

ICMPパケットはタイプ, コード, チェックサムからなる4 byteのヘッダと, その後に続くデータで構成されています.

|構成要素|Byte|説明|
|---|---|---|
|タイプ|1 byte|メッセージのタイプ|
|コード|1 byte|タイプごとの機能|
|チェックサム|2 byte|誤り検出符号|
|データ|可変長|メッセージ|

|メッセージタイプ|説明|
|---|---|
|0|Echo Reply(疎通確認に使われる)|
|3|Destinatyion Unreachable(ホストへ到達不可能なときに送信元へ送られる)|
|8|Echo Request(疎通確認に使われる)|
|11|Time Exceeded, 経路途中に経由するルーターの個数がTTLの値を超えたときに送信元へ送られる|

よくある引掛けとして「不正なアドレス」「再送要求」というメッセージは`ICMP`メッセージには無いので注意が必要です.




References
----------
- [Ryo's Tech Blog > IPアドレスの構造](https://ryonakagami.github.io/2020/10/17/IP-Address/)
- [ipinfo.io](https://ipinfo.io/)
- [Github Respository > echoip](https://github.com/mpolden/echoip?tab=readme-ov-file)
