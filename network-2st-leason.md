1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
```
route-views>show ip route 109.195.83.34
Routing entry for 109.195.80.0/20
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 5w1d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 5w1d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 6939
      MPLS label: none
route-views>show bgp 109.195.83.34
BGP routing table entry for 109.195.80.0/20, version 311629336
Paths: (23 available, best #13, table default)
  Not advertised to any peer
  Refresh Epoch 1
  20912 3257 9002 9049 51570
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8052 3257:50001 3257:54900 3257:54901 20912:65004 65535:65284
      path 7FE16D157E08 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 9002 9049 51570
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      path 7FE1611BD1B0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 174 174 1299 9049 51570
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin incomplete, localpref 100, valid, external
      Community: 174:21000 174:22013 53767:5000
      path 7FE11D7CE078 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 1299 9049 51570
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin incomplete, localpref 100, valid, external
      path 7FE0A40348A0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 9002 9002 9002 9002 9002 9049 51570
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      path 7FE039F2DE28 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 1299 9049 51570
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin incomplete, metric 0, localpref 100, valid, external
      Community: 1299:30000 8283:1 8283:101
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001
      path 7FE18827A288 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 9002 9002 9002 9002 9002 9049 51570
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE183133A88 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  101 174 1299 9049 51570
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin incomplete, localpref 100, valid, external
      Community: 101:20100 101:20110 101:22100 174:21000 174:22013
      Extended Community: RT:101:22100
      path 7FE0A1D640D0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 9049 51570
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE117ADCF20 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 1299 9049 51570
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE10DCF7A38 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 9002 9049 51570
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 9002:0 9002:64667
      path 7FE01F953C78 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 9049 51570
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE1451E5ED8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 9049 51570
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, best
      path 7FE0E019D910 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  3549 3356 9002 9002 9002 9002 9002 9049 51570
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840
      path 7FE006B0E820 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3303 6939 9049 51570
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3303:1006 3303:1021 3303:1030 3303:3067 6939:7040 6939:8752 6939:9002
      path 7FE090ADB368 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 1299 9049 51570
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin incomplete, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE0260A6B00 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 9002 9002 9002 9002 9002 9049 51570
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE109A72778 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 1299 9049 51570
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin incomplete, localpref 100, valid, external
      Community: 2516:1030 7660:9003
      path 7FE019033CB8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 2
  2497 1299 9049 51570
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin incomplete, localpref 100, valid, external
      path 7FE0E60DA8F8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 1299 9049 51570
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin incomplete, localpref 100, valid, external
      Community: 1299:30000
      Extended Community: 0x43:100:1
      path 7FE0F23E7E98 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 9002 9049 51570
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external
      path 7FE03D25A9D8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 9002 9049 51570
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8052 3257:50001 3257:54900 3257:54901 65535:65284
      path 7FE03641BEA8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 174 1299 9049 51570
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin incomplete, localpref 100, valid, external
      Community: 174:21000 174:22013
      path 7FE042A88250 RPKI State not found
      rx pathid: 0, tx pathid: 0
```
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.   
```
root@ubuntu-20:~# modprobe -v dummy numdummies=2
root@ubuntu-20:~# ip a | grep dummy
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
4: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
root@ubuntu-20:~# ip addr add 192.168.1.150/24 dev dummy0
root@ubuntu-20:~# ip route add 192.168.1.0/24 dev dummy0
root@ubuntu-20:~# ip route
default via 172.22.80.1 dev eth0 proto dhcp src 172.22.82.202 metric 100
172.22.80.0/20 dev eth0 proto kernel scope link src 172.22.82.202
172.22.80.1 dev eth0 proto dhcp scope link src 172.22.82.202 metric 100
192.168.1.0/24 dev dummy0 proto kernel scope link src 192.168.1.150
```

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
```
root@ubuntu-20:~# ss -lt
State        Recv-Q       Send-Q               Local Address:Port                 Peer Address:Port       Process
LISTEN       0            4096                 127.0.0.53%lo:domain                    0.0.0.0:*
LISTEN       0            128                        0.0.0.0:ssh                       0.0.0.0:*
LISTEN       0            128                           [::]:ssh                          [::]:*
```
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
```
State      Recv-Q     Send-Q                           Local Address:Port             Peer Address:Port     Process
UNCONN     0          0                                127.0.0.53%lo:domain                0.0.0.0:*
UNCONN     0          0                           172.22.82.202%eth0:bootpc                0.0.0.0:*
UNCONN     0          0                                172.22.82.202:ntp                   0.0.0.0:*
UNCONN     0          0                                    127.0.0.1:ntp                   0.0.0.0:*
UNCONN     0          0                                      0.0.0.0:ntp                   0.0.0.0:*
UNCONN     0          0              [fe80::215:5dff:fe01:1401]%eth0:ntp                      [::]:*
UNCONN     0          0                                        [::1]:ntp                      [::]:*
UNCONN     0          0                                         [::]:ntp                      [::]:*
```
5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.   
<a href="https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=os.drawio#R1VZdb5swFP01eSzCNp%2BPTdqkkzqpWqV1e3TAgFWDkXEasl8%2FO9h8jCRLt2lS8xLuuRfb3HPOhQVale1G4Lr4zFPCFtBN2wW6W0B447uh%2BtPIoUMQQB2QC5p2EBiAZ%2FqDGNA16I6mpJkUSs6ZpPUUTHhVkUROMCwE30%2FLMs6mu9Y4JzPgOcFsjr7QVBYGBa47JB4IzQuzdeSbxBYnr7ngu8rsV%2FGKdJkS22VMaVPglO9HELpfoJXgXHZXZbsiTLfVdqy7b30m2x9ZkEpedUMS4iDcZlGWIojc7MY3SzTyYPtAUtUWEx4fBS0LWTIVAXXJ8JawZf%2FEK864GAobiYVcU6arXRWTKr3V1AwVChnlGyn4a99u1Y5lxiu5xiVlWkVfiUhxhQ1sJAN0GWmp%2FKYXcbwQmfj7MY5haOK71p5CB4dR8EQELYkkwmDzNloBYpETeaZ3XtQV6YaN7jKd3xCuthAHVSAIw5K%2BTXWGjVzzvq6%2F9YlTdQ7oGmsBFIZOHHqu%2FcFuBeMz348dBKM%2B%2B8v6Dd%2BJhJglB2moi9EZB%2BgomCvFA%2FxuqzfMdubhPlWqq5VqGQyY6ttyK9RVrq9izwmhE0AHBnPJMaZcfhRQgWsNJozv1LbLfUElea5xosG9GjxTNR41SFKrJusuHSS8pMlJmYHrZXZWGG9ESNJeZN1mfd%2Bb8BXEpgH70ZSxA6IYDxj3vFImNL6HMx9%2BTMOfZaLT928setHHVsb%2Fzsd%2FzI4978hRIIYOCCIHOPNRbd1Strl%2BJzsJbRLuKJ6UCRvzP2UzxU3R%2ByVTvFg%2BF2p%2FFERx2JM0ymTH30n6tBGoeok%2Bapk88YZKyiuV23IpeTkquGU01wnJ6%2BuN%2Bx9t6oHpWA1APLNpGM1d6qO%2F18Fj%2B7LZL1cUZtkXt37Y%2BK3c3MALUlCTYQ29jzZHZ2yc4Ow8QTBwJwR5oTufo%2BGJOdp%2Fwb2DIhUOX2Xdu3L46kX3PwE%3D">Cхема</a>