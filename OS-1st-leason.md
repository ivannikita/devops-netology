1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd.  
Команда встроенная, работая внутри сессии терминала логичнее менять указатель на текущую дерикторию внутренней функцией, 
Если использовать внешний вызов, то он будет работать со своим окружением, и менять  текущий каталог внутри своего окружения, а на вызвовший shell влиять не будет. Ее можно сделать внешеней но как сказано ранее это не имеет смысла.
2. Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:
```
agrant@netology1:~$ file /dev/tty
/dev/tty: character special (5/0)
vagrant@netology1:~$ file /dev/sda
/dev/sda: block special (8/0)
vagrant@netology1:~$ file /bin/bash
/bin/bash: ELF 64-bit LSB shared object, x86-64
```  
Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.  
```
vagrant@ubuntu-20:~$ strace -e open -c sh "file /bin/bash " 
execve("/usr/bin/sh", ["sh", "-c", "file /bin/bash ", "-e", "open:"], 0x7fff530a5860 /* 24 vars */) = 0
brk(NULL)                               = 0x557e97882000
arch_prctl(0x3001 /* ARCH_??? */, 0x7ffda1e3a220) = -1 EINVAL (Invalid argument)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=23738, ...}) = 0
mmap(NULL, 23738, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7efc0b409000
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
```
Файл базы типов - /usr/share/misc/magic.mgc
3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
```  
 echo '' > /proc/PID/fd/1
 ```
 4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?  
 нет они освобождают занимаемые ресурсы, остается только запись в таблице процессов.
 5. В iovisor BCC есть утилита opensnoop:
 ```
root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
```
На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04.   
```
vagrant@ubuntu-20:~$ dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
vagrant@ubuntu-20:~$ sudo su -
root@ubuntu-20:~# /usr/sbin/opensnoop-bpfcc
PID    COMM               FD ERR PATH
696    irqbalance          6   0 /proc/interrupts
696    irqbalance          6   0 /proc/stat
696    irqbalance          6   0 /proc/irq/8/smp_affinity
696    irqbalance          6   0 /proc/irq/9/smp_affinity
```
6.Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.  
системный вызов uname()
 Part of the utsname information is also accessible via
       /proc/sys/kernel/{ostype, hostname, osrelease, version,
       domainname}.  
7.  Чем отличается последовательность команд через ; и через && в bash? Например:
```
root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir && echo Hi
root@netology1:~#
```
Есть ли смысл использовать в bash &&, если применить set -e?  
&& - последующая команда выполняется только при успешном выполнении предыдущей.
; - просто разделяет команды
set -e - немедленный выход, если выходное состояние команды ненулевое  
использовать && при set -e не имеет смысла так как команда прервет свое выполенение в случае ошибки.  
8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?  
-е немедленный выход, если выходное состояние команды ненулевое.  
-u во время замещения рассматривает незаданную переменную как ошибку.  
-x выводит команды и их аргументы по мере выполнения команд.  
-o pipefail возвращает код возврата набора/последовательности команд, ненулевой при последней команды или 0 для успешного выполнения команд.
Использование этх параметров при написании сценариев, позволит лучше проводить дебагинг кода, и останавливать выполнение скрипта при ошибке в любом его месте.
9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).
```
vagrant@ubuntu-20:~$ ps -o stat
STAT
Ss
T
R+
```
S*(S,S+,Ss,Ssl,Ss+) - Процессы ожидающие завершения (спящие с прерыванием "сна")
I*(I,I<) - фоновые(бездействующие) процессы ядра

доп символы это доп характеристики, например приоритет.