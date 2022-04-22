1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.
![bitwarden_install](/images/bitwarden_install.png)
2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.
![bitwarden](/images/bitwarden.png)
3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

![сайт с ssl](/images/site_ssl.png)

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).
```
root@DESKTOP-NO8KIJV:~/testssl.sh# ./testssl.sh -U --sneaky https://sitronics-kt.ru


###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/
    (6054be6 2022-04-12 18:50:26 -- )

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.1.1f  31 Mar 2020" [~98 ciphers]
 on DESKTOP-NO8KIJV:/usr/bin/openssl
 (built: "Nov 24 13:20:48 2021", platform: "debian-amd64")


 Start 2022-04-13 16:45:23        -->> 178.154.221.239:443 (sitronics-kt.ru) <<--

 rDNS (178.154.221.239): --
 Service detected:       HTTP


 Testing vulnerabilities

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services
                                           https://censys.io/ipv4?q=69EE013D4B10EEB19478E5B1C46EF599BE0201221C98262DF6E8B7B58BFEAC48 could help you to find out
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES128-SHA ECDHE-RSA-AES256-SHA AES128-SHA AES256-SHA
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2022-04-13 16:46:45 [  91s] -->> 178.154.221.239:443 (sitronics-kt.ru) <<--
 ```
5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
```
root@DESKTOP-NO8KIJV:~# ssh-copy-id nick@192.168.1.27
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
nick@192.168.1.27's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'nick@192.168.1.27'"
and check to make sure that only the key(s) you wanted were added.

root@DESKTOP-NO8KIJV:~# ssh nick@192.168.1.27
Enter passphrase for key '/root/.ssh/id_rsa':
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-107-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun 17 Apr 2022 08:04:48 PM UTC

  System load:  0.0                Processes:             121
  Usage of /:   10.9% of 48.47GB   Users logged in:       1
  Memory usage: 22%                IPv4 address for ens3: 192.168.1.27
  Swap usage:   0%

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

61 updates can be applied immediately.
To see these additional updates run: apt list --upgradable


Last login: Wed Apr  6 07:23:45 2022
```
6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.  
```
config
Host aspia
User nick
HostName 192.168.1.27
Port 22
IdentityFile ~/.ssh/my
  
root@DESKTOP-NO8KIJV:~/.ssh# ls
config  known_hosts  my  my.pub
root@DESKTOP-NO8KIJV:~/.ssh# ssh aspia
Enter passphrase for key '/root/.ssh/my':
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-107-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri 22 Apr 2022 09:11:44 PM UTC

  System load:  0.08               Processes:             123
  Usage of /:   11.1% of 48.47GB   Users logged in:       1
  Memory usage: 24%                IPv4 address for ens3: 192.168.1.27
  Swap usage:   0%

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

59 updates can be applied immediately.
To see these additional updates run: apt list --upgradable


*** System restart required ***
Last login: Sun Apr 17 20:31:41 2022 from 
```

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
```
vagrant@ubuntu-20:~$ sudo tcpdump -c 100 -w ib.pcap
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
100 packets captured
110 packets received by filter
0 packets dropped by kernel
```
![сайт с ssl](/images/wireshark.png)