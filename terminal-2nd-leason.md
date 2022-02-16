1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.  
cd это встроенная команда оболочки
2. Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l? man grep поможет в ответе на этот вопрос. Ознакомьтесь с документом о других подобных некорректных вариантах использования pipe.  
grep -c <some_string> <some_file>
3. Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?  
systemd
4. Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала? 
ls 2> /dev/pts/1
5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.  
cat </tmp/in_file >/tmp/out_file 
6. Получится ли вывести находясь в графическом режиме данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные? 
Да можно, но увидеть их можно будет только переключившись в тот tty куда перенаправили.
7. Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?  
bash 5>&1 - Создаст дескриптор с 5 и перенатправит его в stdout  
echo netology > /proc/\$$/fd/5 - выведет в дескриптор "5", который был пернеаправлен в stdout
8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от | на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.  
ls -l /root 9>&2 2>&1 1>&9 |grep denied -c 
9. Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?  
Выведет список переменных окружения, можно воспользоваться командой env для более читаймого вида.
10. Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe.  
/proc/<PID>/cmdline - полный путь до исполняемого файла процесса [PID]  (строка 231)
/proc/<PID>/exe - содержит ссылку до файла запущенного для процесса [PID], cat выведет содержимое запущенного файла запуск этого файла,  запустит еще одну копию самого файла   (строка 285)
11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo  
sse4_2
12. При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty. Это можно подтвердить командой tty, которая упоминалась в лекции 3.2. Однако:

vagrant@netology1:~$ ssh localhost 'tty'
not a tty
Почитайте, почему так происходит, и как изменить поведение. 
При подключении к серверу по SSH по умолчанию не выделяется tty, для назначения терминала необходимо вызвать команду ssh с ключем -t который переназначит псевдотерминал
13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.  
открыть новую ssh сеесию запустить в ней screen после этого из него узнав PID нужного процесса вызвать reptyr PID. Закрыть обе сессии.
14. sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.  
При использовании команды **sudo echo string > /root/new_file** будет выдана ошибка так как > не будет выполняться от sudo. Для записи необходимо использовать команду: 
**echo 'новая строка' | sudo tee --append /etc/apt/sources.list > /dev/null**
Команда tee выводит информацию сразу и в файл и на консоль, чтобы не видить повторно информацию в консоли мы перенаправим ее sdout в /dev/null