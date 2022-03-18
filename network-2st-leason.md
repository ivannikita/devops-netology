1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?  
window 
ipconfig /all 
Get-NetAdapter
linux
ip a
2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?  
cdp/LLDP 
```
root@ubuntu-20:~# lldpcli
-- Help
       show  Show running system information
      watch  Monitor neighbor changes
     update  Update information and send LLDPU on all ports
  configure  Change system settings
unconfigure  Unconfigure system settings
       help  Get help on a possible command
      pause  Pause lldpd operations
     resume  Resume lldpd operations
       exit  Exit interpreter
```
3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.  
```
vlan, простой конфиг
auto eth0.5
iface eth0.5 inet static
address 192.168.5.1
netmask 255.255.255.0
```
4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.  
LACP 
Существуют 6 типов агрегации в Linux   
Mode-0(balance-rr)   
Mode-1(active-backup)  
Mode-2(balance-xor)   
Mode-3(broadcast)  
Mode-4(802.3ad)  
Mode-5(balance-tlb)  
Mode-6(balance-alb)  
Пакет ifenslave
```
auto bond0
iface bond0 inet static
    address 192.168.1.150
    netmask 255.255.255.0    
    gateway 192.168.1.1
    dns-nameservers 192.168.1.1 8.8.8.8
    dns-search domain.local
        slaves eth0 eth1
        bond_mode 0
        bond-miimon 100
        bond_downdelay 200
        bound_updelay 200
```
5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.  
6 хостов
32 подсети
10.10.10.0-10.10.10.7,10.10.10.144-10.10.10.151...
6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.
100.64.0.0/26 или 2001:db8:85a3::8a2e:370:7334/122
7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?
windows 
вся таблица arp -a  
очистка таблицы arp -d *
удаление узла arp -d address
linux
нужно поставить пакет net-tools
arp -a
arp -d *
arp -d address 

