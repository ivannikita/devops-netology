1. Узнайте о sparse (разряженных) файлах.
файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях
2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?
да, потому что ссылка является отдельным файлом в системе и на нее можно назначить права.
3. Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:
```
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provider :virtualbox do |vb|
    lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
    lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
    vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
    vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
  end
end
```
Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.  
Так как VM запускается в hyper-v, вопервых не получилось добавить диски через конфиг, а так же hyper-v поддерживает только integer в размерах диска, по этой причини диски сделал по 3гб. и добавил их руками к вм.
4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
```
Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-6291455, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-6291455, default 6291455): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): e
Partition number (2-4, default 2):
First sector (4196352-6291455, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-6291455, default 6291455):

Created a new partition 2 of type 'Extended' and of size 1023 MiB.
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
5. Используя sfdisk, перенесите данную таблицу разделов на второй диск.  
```
root@ubuntu-20:~# sfdisk --dump /dev/sda > /tmp/sdb.dump
root@ubuntu-20:~# fdisk /dev/sdc
Command (m for help): o
Created a new DOS disklabel with disk identifier 0xfc2c1110.
The old gpt signature will be removed by a write command.

Command (m for help): w
root@ubuntu-20:~# sfdisk /dev/sdc < /tmp/sdb.dump
```
6. Соберите mdadm RAID1 на паре разделов 2 Гб.  
```
mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b1,c1}
```
7. Соберите mdadm RAID0 на второй паре маленьких разделов.  
```
 mdadm --create --verbose /dev/md1 -l 0 -n2 /dev/sdb2 /dev/sdc2
```
8. Создайте 2 независимых PV на получившихся md-устройствах.  
```
root@ubuntu-20:~# pvcreate /dev/md0 /dev/md1
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.
  ```
  9. Создайте общую volume-group на этих двух PV.  
  ```
  root@ubuntu-20:~# vgcreate vg01 /dev/md0 /dev/md1
  Volume group "vg01" successfully created
  ```
  10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.
  ```
  root@ubuntu-20:~# lvcreate -L 100M vg01
  Logical volume "lvol0" created.
  ```
  11. Создайте mkfs.ext4 ФС на получившемся LV.
  ```
root@ubuntu-20:~# mkfs.ext4 /dev/vg01/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Discarding device blocks: done
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```
 12. Смонтируйте этот раздел в любую директорию, например, /tmp/new.  
```
root@ubuntu-20:~# mkdir /tmp/new
root@ubuntu-20:~# mount /dev/vg01/lvol0 /tmp/new
```
13. Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz  
```
root@ubuntu-20:/tmp/new# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2022-03-23 19:16:35--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22314449 (21M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz              100%[=================================================>]  21.28M  1.95MB/s    in 8.8s

2022-03-23 19:16:44 (2.43 MB/s) - ‘/tmp/new/test.gz’ saved [22314449/22314449]
```
14. Прикрепите вывод lsblk.

```
root@ubuntu-20:/tmp/new# lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                       8:0    0   64G  0 disk
├─sda1                    8:1    0  512M  0 part  /boot/efi
└─sda2                    8:2    0 63.5G  0 part
  ├─vgubuntu--20-root   253:0    0 62.6G  0 lvm   /
  └─vgubuntu--20-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                       8:16   0    3G  0 disk
├─sdb1                    8:17   0    2G  0 part
│ └─md0                   9:0    0    2G  0 raid1
│   └─vg01-lvol0        253:2    0  100M  0 lvm   /tmp/new
└─sdb2                    8:18   0 1023M  0 part
  └─md1                   9:1    0    2G  0 raid0
sdc                       8:32   0    3G  0 disk
├─sdc1                    8:33   0    2G  0 part
│ └─md0                   9:0    0    2G  0 raid1
│   └─vg01-lvol0        253:2    0  100M  0 lvm   /tmp/new
└─sdc2                    8:34   0 1023M  0 part
  └─md1                   9:1    0    2G  0 raid0
sr0                      11:0    1 1024M  0 rom
```
15. Протестируйте целостность файла:
```
root@ubuntu-20:/tmp/new# gzip -t /tmp/new/test.gz
root@ubuntu-20:/tmp/new# echo $?
0
```
16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1. 
```
root@ubuntu-20:/tmp/new# pvmove -n lvol0 /dev/md0 /dev/md1
  /dev/md0: Moved: 20.00%

  /dev/md0: Moved: 100.00%
  ```
  17. Сделайте --fail на устройство в вашем RAID1 md.  
  ```
  root@ubuntu-20:/tmp/new# mdadm /dev/md0 --fail /dev/sdc1
mdadm: set /dev/sdc1 faulty in /dev/md0
```
18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии. 
```
[34949.541883] md/raid1:md0: Disk failure on sdc1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
```
19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:
```
root@ubuntu-20:/tmp/new#  gzip -t /tmp/new/test.gz
root@ubuntu-20:/tmp/new# echo $?
0
```

