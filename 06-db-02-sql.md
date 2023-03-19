## 1. Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.
Приведите получившуюся команду или docker-compose-манифест.
```docker
docker run --name netology_postgres  -p 5432:5432 -e POSTGRES_PASSWORD=pgpwdnet -e PGDATA="/var/lib/postgresql/data/pgdata" -v /pgdata:/var/lib/postgresql/data -v /backup:/backup -d postgres:12
```
## 2. В БД из задачи 1:

- создайте пользователя test-admin-user и БД test_db;
```postgresql
postgres=# create database test_db;
postgres=# create user test_admin_user with encrypted password 'testadmin';
```
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
```postgresql
postgres=# create table if not exists orders (id serial PRIMARY KEY, title character (200) NOT NULL, price INTEGER NOT NULL);
postgres=# create table if not exists clients (
id serial PRIMARY KEY,
 surname character (200) NOT NULL,
 country character (200),
 order_id INT,
 FOREIGN KEY(order_id) REFERENCES orders(id)
);
postgres=# create index ON clients (country);
```

- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
```postgresql
test_db=# GRANT ALL ON clients TO test_admin_user;
test_db=# GRANT ALL ON orders TO test_admin_user;
```

- создайте пользователя test-simple-user;
```postgresql
test_db=# create user test_simple_user with encrypted password 'testuser';
```
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.
```postgresql
test_db=# GRANT INSERT, SELECT, UPDATE, DELETE ON clients TO test_simple_user;
test_db=# GRANT INSERT, SELECT, UPDATE, DELETE ON orders TO test_simple_user;
```
# Приведите:

- итоговый список БД после выполнения пунктов выше;
![databases](/images/6_2_5.png)
- описание таблиц (describe);
![describe1](/images/6_2_2.png)
![describe2](/images/6_2_3.png)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;   
список пользователей с правами над таблицами test_db.
![access](/images/6_2_4.png)

## 3. Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:
```sql
test_db=# INSERT INTO orders (title, price) values
('Шоколад',     '10'),
('Принтер',     '3000'),
('Книга',       '500'),
('Монитор',     '7000'),
('Гитара',      '4000');
INSERT 0 5
test_db=# SELECT COUNT(*) FROM orders;
 count 
-------
     5
(1 row)
test_db=# INSERT INTO clients (surname, country) values
('Иванов Иван Иванович', 'USA'),
('Петров Петр Петрович', 'Canada'),
('Иоганн Себастьян Бах', 'Japan'),
('Ронни Джеймс Дио', 'Russia'),
('Ritchie Blackmore', 'Russia');
INSERT 0 5

test_db=# SELECT COUNT(*) FROM clients;
 count 
-------
     5
(1 row)
```

## 4. Часть пользователей из таблицы clients решили оформить заказы из таблицы orders. Используя foreign keys, свяжите записи из таблиц, согласно таблице:
```sql
test_db=# update clients set order_id=3  where surname='Иванов Иван Иванович';
UPDATE 1

test_db=# update clients set order_id=4 where surname='Петров Петр Петрович';
UPDATE 1

test_db=# update clients set order_id=5 where surname='Иоганн Себастьян Бах';
UPDATE 1

test_db=# SELECT surname FROM clients INNER JOIN orders ON clients.order_id = orders.id;
                                                                                                 surname                                                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Иванов Иван Иванович                                                                                                                                                                                    
 Петров Петр Петрович                                                                                                                                                                                    
 Иоганн Себастьян Бах                                                                                                                                                                                    
(3 rows)
```

## 5. Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN). Приведите получившийся результат и объясните, что значат полученные значения.
```sql
test_db=# explain (FORMAT YAML) SELECT surname FROM clients INNER JOIN orders ON clients.order_id = orders.id;
                   QUERY PLAN                    
-------------------------------------------------
 - Plan:                                        +
     Node Type: "Hash Join"                     +
     Parallel Aware: false                      +
     Join Type: "Inner"                         +
     Startup Cost: 10.90                        +
     Total Cost: 22.54                          +
     Plan Rows: 40                              +
     Plan Width: 804                            +
     Inner Unique: false                        +
     Hash Cond: "(orders.id = clients.order_id)"+
     Plans:                                     +
       - Node Type: "Seq Scan"                  +
         Parent Relationship: "Outer"           +
         Parallel Aware: false                  +
         Relation Name: "orders"                +
         Alias: "orders"                        +
         Startup Cost: 0.00                     +
         Total Cost: 10.90                      +
         Plan Rows: 90                          +
         Plan Width: 4                          +
       - Node Type: "Hash"                      +
         Parent Relationship: "Inner"           +
         Parallel Aware: false                  +
         Startup Cost: 10.40                    +
         Total Cost: 10.40                      +
         Plan Rows: 40                          +
         Plan Width: 808                        +
         Plans:                                 +
           - Node Type: "Seq Scan"              +
             Parent Relationship: "Outer"       +
             Parallel Aware: false              +
             Relation Name: "clients"           +
             Alias: "clients"                   +
             Startup Cost: 0.00                 +
             Total Cost: 10.40                  +
             Plan Rows: 40                      +
             Plan Width: 808
(1 row)
```

## 6. Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1). Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```shell
docker exec -it netology_postgres sh

pg_dump  -U postgres -d test_db > /backup/test_db

docker stop netology_postgres

docker run --name netology_postgres1  -p 5432:5432 -e POSTGRES_PASSWORD=pgpwdnet -e PGDATA="/var/lib/postgresql/data/pgdata" -v /pgdata1:/var/lib/postgresql/data -v /backup:/backup -d postgres:12

docker exec -it netology_postgres sh

psql -U postgres
create database test_db;
create user test_admin_user with encrypted password 'testadmin';
create user test_simple_user with encrypted password 'testuser';
exit
psql -U postgres -d test_db < /backup/test_db
```
