/* 1. Создать нового пользователя и задать ему права доступа на базу данных «Страны и города мира». */
mysql> CREATE USER 'user1'@'%' IDENTIFIED BY 'useruser';
Query OK, 0 rows affected (0.21 sec)

mysql> GRANT ALL PRIVILEGES ON geodata.* TO 'user1'@'%';
Query OK, 0 rows affected (0.01 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT user FROM user;
ERROR 1046 (3D000): No database selected
mysql> SELECT user();
+----------------+
| user()         |
+----------------+
| root@localhost |
+----------------+
1 row in set (0.01 sec)

mysql> use mysql;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT user FROM user;
+------------------+
| user             |
+------------------+
| root             |
| user1            |
| mysql.infoschema |
| mysql.session    |
| mysql.sys        |
| root             |
+------------------+
6 rows in set (0.00 sec)

/* 2. Сделать резервную копию базы, удалить базу и пересоздать из бекапа. */

root@4a3474f08f04:/# mysqldump -p geodata > geodata.sql
Enter password:
root@4a3474f08f04:/# ls -lh geodata.sql
-rw-r--r-- 1 root root 80M Dec 22 16:43 geodata.sql
root@4a3474f08f04:/# mysql -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 8.0.22 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> DROP DATABASE geodata;
Query OK, 3 rows affected (0.10 sec)

mysql> CREATE DATABASE geodata;
Query OK, 1 row affected (0.03 sec)

mysql> ^DBye
root@4a3474f08f04:/# mysql -p geodata < geodata.sql
Enter password:
root@4a3474f08f04:/# mysql -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 27
Server version: 8.0.22 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use geodata;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-------------------+
| Tables_in_geodata |
+-------------------+
| _cities           |
| _countries        |
| _regions          |
+-------------------+
3 rows in set (0.00 sec)

mysql> ^DBye
root@4a3474f08f04:/#