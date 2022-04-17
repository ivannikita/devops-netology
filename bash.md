Задание 1

Переменная | Значение|Обоснование
------ | ------| ------
c  | a+b | по умолчанию строки
d  | 1+2 | сложил значения переменных как строки
e  | 3 | сложил значения как цифры

Задание 2
```
while :
do
curl https://localhost:4757 > /dev/null 2>&1
        if (("$?" == "0"))
        then
                date >> curl.log
        else
                break
        fi
done
```
Задание 3
```
ip=("192.168.0.1" "173.194.222.113" "87.250.250.242")
for i in "${ip[@]}"
        do
                for j in {1..5}
                do
                nc -zvw3 $i 80 >> ping.log 2>&1
                done
        done
```
задание 4
```
ip=("192.168.0.1" "173.194.222.113" "87.250.250.242")
while :
do
for i in "${ip[@]}"
        do
                nc -zvw3 $i 80 >> /dev/null 2>&1
                if (("$?" != "0"))
                then
                echo $i >> error 2>&1
                break 2
                fi
                done
                sleep 3
        done
```
