1. Работа c HTTP через телнет.
Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
отправьте HTTP запрос
```
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
В ответе укажите полученный HTTP код, что он означает?   
**код 301 получаемый в ответ от сервера в ситуации, когда запрошенный ресурс был на постоянной основе перемещён в новое месторасположение, и указывающий на то, что текущие ссылки, использующие данный URL, должны быть обновлены**  
2. Повторите задание 1 в браузере, используя консоль разработчика F12.
откройте вкладку Network
отправьте запрос http://stackoverflow.com
найдите первый ответ HTTP сервера, откройте вкладку Headers
укажите в ответе полученный HTTP код.
проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
приложите скриншот консоли браузера в ответ.  
**307 Internal Redirect Дольше всего подгружались файлы js скриптов analytics.js и beacon.js по 788 мс**
3. Какой IP адрес у вас в интернете? **77.232.45.37**  
4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois  
**SATS-NET**
**AS57334**  
5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute
```
 unused.sats.spb.ru (176.97.32.242) [AS57334]  6.184 ms  5.875 ms  6.182 ms
 6  unused.sats.spb.ru (176.97.32.81) [AS57334]  6.423 ms unused.sats.spb.ru (176.97.39.133) [AS57334]  7.142 ms unused.sats.spb.ru (176.97.32.81) [AS57334]  7.402 ms
 7  spb.piter-ix.google.com (185.1.152.26) [AS50817]  10.252 ms  6.875 ms  7.026 ms
 8  74.125.244.132 (74.125.244.132) [AS15169]  7.012 ms  6.997 ms 74.125.244.180 (74.125.244.180) [AS15169]  7.510 ms
 9  72.14.232.85 (72.14.232.85) [AS15169]  7.947 ms 142.251.61.219 (142.251.61.219) [AS15169]  12.302 ms 216.239.48.163 (216.239.48.163) [AS15169]  9.795 ms
10  142.251.61.221 (142.251.61.221) [AS15169]  10.735 ms 142.251.51.187 (142.251.51.187) [AS15169]  60.115 ms 216.239.46.243 (216.239.46.243) [AS15169]  11.851 ms
11  * * 108.170.233.163 (108.170.233.163) [AS15169]  10.238 ms
````  
6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
```
Loss%   Snt   Last   Avg  Best  Wrst StDev
 
AS57334  unused.sats.spb.ru                                                                                   0.0%    37    7.0   4.9   3.0  13.1   2.4
AS57334  unused.sats.spb.ru                                                                                   0.0%    37    5.7   5.9   3.4  19.1   3.9
AS???    spb.piter-ix.google.com                                                                              0.0%    37   18.3   6.6   3.3  23.3   4.7
AS15169  74.125.244.132                                                                                       0.0%    37    4.7   5.5   3.5  26.3   4.0
AS15169  216.239.48.163                                                                                       0.0%    37   13.7  10.5   6.7  27.3   4.7
AS15169  142.250.56.125                                                                                       0.0%    37    8.9   9.8   8.0  19.4   2.4
AS15169  dns.google                                                                                           0.0%    36   26.5   9.1   6.7  33.7   5.4
```
Большая задержка на этапе AS15169  216.239.48.163  
7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig  
```
dns.google.com.         0       IN      A       8.8.8.8
dns.google.com.         0       IN      A       8.8.4.4
```
8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig  
```
;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.   0       IN      PTR     dns.google.
```