Задача 1
Сценарий выполения задачи:

создайте свой репозиторий на https://hub.docker.com;
выберете любой образ, который содержит веб-сервер Nginx;
создайте свой fork образа;
реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

**https://hub.docker.com/repository/docker/ivannikita/ivannikita**

Задача 2
Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

Высоконагруженное монолитное java веб-приложение; не подходит так как докер подходит не для монолитных приложений  
Nodejs веб-приложение; подходит  
Мобильное приложение c версиями для Android и iOS; да удобно маштабировать и перезаливать  
Шина данных на базе Apache Kafka;  да
Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;на чистом докере нет, лучше использовать тогда обычные вм  
Мониторинг-стек на базе Prometheus и Grafana; да, плюс в маштабировании  
MongoDB, как основное хранилище данных для java-приложения; да опять таки маштабирование  
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry. нет, сервер должен быть доступен постоянно  



Задача 3
Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;
Добавьте еще один файл в папку /data на хостовой машине;
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

![Listfiles](/images/file_list.jpg)
```
[nivanov@localhost mynginx]$ docker pull centos
Using default tag: latest
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest
[nivanov@localhost mynginx]$ docker pull debian
Using default tag: latest
latest: Pulling from library/debian
1671565cc8df: Pull complete 
Digest: sha256:d52921d97310d0bd48dab928548ef539d5c88c743165754c57cfad003031386c
Status: Downloaded newer image for debian:latest
docker.io/library/debian:latest
[nivanov@localhost mynginx]$ sudo mkdir /data
[nivanov@localhost ~]$ docker run -it -v /data:/data centos
[root@a41dc4d37205 /]# 
[root@a41dc4d37205 /]# vi /data/first_file
[root@a41dc4d37205 /]# ls /data/
first_file
[root@a41dc4d37205 /]# exit
[nivanov@localhost ~]$ vi /data/second_file
[nivanov@localhost ~]$ docker run -it -v /data:/data debian
root@d542c5ec7fbe:/# ls /data
first_file  second_file
root@d542c5ec7fbe:/# exit
```
