#mysql基础操作

转换unix时间戳
mysql> select unix_timestamp('2018-05-06 15:16:40');
+---------------------------------------+
| unix_timestamp('2018-05-06 15:16:40') |
+---------------------------------------+
|                            1525591000 |
+---------------------------------------+
1 row in set (0.00 sec)

mysql> select from_unixtime(1525591000);
+---------------------------+
| from_unixtime(1525591000) |
+---------------------------+
| 2018-05-06 15:16:40       |
+---------------------------+
1 row in set (0.00 sec)

#1.修改表名
mysql> alter table test_enmu rename to test_emnu;
Query OK, 0 rows affected (0.01 sec)

mysql> show tables;
+-----------------+
| Tables_in_test2 |
+-----------------+
| orders          |
| persons         |
| student         |
| test_date       |
| test_emnu       |
| test_set        |
+-----------------+
6 rows in set (0.00 sec)

第二种方式:
mysql> rename table persons to person;
Query OK, 0 rows affected (0.01 sec)  

#2.添加字段
mysql> alter table student add column mobile char(12) comment'手机' after age;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> alter table student add column email char(40) comment'邮箱' after mobile;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> alter table student add email char(40) default'' comment'邮箱' after mobile;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

#3.删除字段
mysql> alter table student drop email;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

#4.修改字段类型
mysql> alter table student modify mobile char(11) default'' comment'手机号' after gender;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

#5.更改字段名
mysql> alter table student change work_email email char(30) default'';
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> desc student;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| no     | char(10)    | YES  |     | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| age    | tinyint(2)  | YES  |     | NULL    |       |
| gender | tinyint(1)  | YES  |     | NULL    |       |
| mobile | char(11)    | YES  |     |         |       |
| email  | char(30)    | YES  |     |         |       |
+--------+-------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

#6. unique
约束列中不能出现重复的值，但允许为null
mysql> alter table student modify no char(10) unique default'';
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc student;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| no     | char(10)    | YES  | UNI |         |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| age    | tinyint(2)  | YES  |     | NULL    |       |
| gender | tinyint(1)  | YES  |     | NULL    |       |
| mobile | char(11)    | YES  |     |         |       |
| email  | char(30)    | YES  |     |         |       |
+--------+-------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

mysql> select * from student;
+------------+------------+------+--------+--------+-------+
| no         | name       | age  | gender | mobile | email |
+------------+------------+------+--------+--------+-------+
| 1210040109 | laoerpang  |   28 |      1 | NULL   |       |
| 1210040111 | zhengbowen |   30 |      1 | NULL   |       |
+------------+------------+------+--------+--------+-------+
2 rows in set (0.00 sec)

mysql> insert into student(no, name) values('1210040109', 'wanger');
ERROR 1062 (23000): Duplicate entry '1210040109' for key 'no'

mysql> insert into student(no, name) values(null, 'oulaoer');
Query OK, 1 row affected (0.00 sec)
mysql> insert into student(no, name) values(null, 'huangzhen');
Query OK, 1 row affected (0.00 sec)

mysql> select * from student;
+------------+------------+------+--------+--------+-------+
| no         | name       | age  | gender | mobile | email |
+------------+------------+------+--------+--------+-------+
| 1210040109 | laoerpang  |   28 |      1 | NULL   |       |
| 1210040111 | zhengbowen |   30 |      1 | NULL   |       |
|            | shangfeipo | NULL |   NULL |        |       |
| NULL       | oulaoer    | NULL |   NULL |        |       |
| NULL       | huangzhen  | NULL |   NULL |        |       |
+------------+------------+------+--------+--------+-------+
5 rows in set (0.00 sec)

说明：由于 null 不等于 null ,所以满足unique 约束

primary key
添加主键
mysql> alter table student add column id int(11) unsigned primary key auto_increment first;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0
mysql> select * from student;
+----+------------+------------+------+--------+--------+-------+
| id | no         | name       | age  | gender | mobile | email |
+----+------------+------------+------+--------+--------+-------+
|  1 | 1210040109 | laoerpang  |   28 |      1 | NULL   |       |
|  2 | 1210040111 | zhengbowen |   30 |      1 | NULL   |       |
|  3 |            | shangfeipo | NULL |   NULL |        |       |
|  4 | NULL       | oulaoer    | NULL |   NULL |        |       |
|  5 | NULL       | huangzhen  | NULL |   NULL |        |       |
+----+------------+------------+------+--------+--------+-------+
5 rows in set (0.00 sec)


mysql> desc student;                                                 
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| no     | char(10)         | YES  | UNI |         |                |
| name   | varchar(20)      | YES  |     | NULL    |                |
| age    | tinyint(2)       | YES  |     | NULL    |                |
| gender | tinyint(1)       | YES  |     | NULL    |                |
| mobile | char(11)         | YES  |     |         |                |
| email  | char(30)         | YES  |     |         |                |
+--------+------------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)                                             

查看auto_increment 自增长的相关信息
mysql> show variables like '%auto_increment%';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| auto_increment_increment | 1     |
| auto_increment_offset    | 1     |
+--------------------------+-------+
2 rows in set (0.00 sec)


复合主键：
一个表中允许有一个主键存在，但可以有多个唯一键
多个字段共同作用来唯一标识一条记录
primary key(字段1，字段2)

模拟主键：
当一个表中如果没有主键字段， Mysql会将第一个 具有 unique 和 not null 约束的字段视之为主键字段

删除表：
mysql> drop table if exists student2;
Query OK, 0 rows affected (0.01 sec)

添加unique
mysql> desc student;
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| no     | char(10)         | YES  | UNI |         |                |
| name   | varchar(20)      | YES  |     | NULL    |                |
| age    | tinyint(2)       | YES  |     | NULL    |                |
| gender | tinyint(1)       | YES  |     | NULL    |                |
| mobile | char(11)         | YES  |     |         |                |
| email  | char(30)         | YES  |     |         |                |
+--------+------------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)

mysql> alter table student modify name varchar(20) not null default'' unique;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> desc student;
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| no     | char(10)         | YES  | UNI |         |                |
| name   | varchar(20)      | NO   | UNI |         |                |
| age    | tinyint(2)       | YES  |     | NULL    |                |
| gender | tinyint(1)       | YES  |     | NULL    |                |
| mobile | char(11)         | YES  |     |         |                |
| email  | char(30)         | YES  |     |         |                |
+--------+------------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)

第二种方式添加unique
mysql> alter table student add unique(mobile);
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc student;
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| no     | char(10)         | YES  | UNI |         |                |
| name   | varchar(20)      | NO   | UNI |         |                |
| age    | tinyint(2)       | YES  |     | NULL    |                |
| gender | tinyint(1)       | YES  |     | NULL    |                |
| mobile | char(11)         | YES  | UNI |         |                |
| email  | char(30)         | YES  |     |         |                |
+--------+------------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)

删除key
mysql> alter table student drop key name;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

删除 primary key
1.如果主键有 auto_increment 需要先去掉后再删除主键
mysql> alter table student modify id int(11) unsigned;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> desc student;
+--------+------------------+------+-----+---------+-------+
| Field  | Type             | Null | Key | Default | Extra |
+--------+------------------+------+-----+---------+-------+
| id     | int(11) unsigned | NO   | PRI | 0       |       |
| no     | char(10)         | YES  | UNI |         |       |
| name   | varchar(20)      | NO   |     |         |       |
| age    | tinyint(2)       | YES  |     | NULL    |       |
| gender | tinyint(1)       | YES  |     | NULL    |       |
| mobile | char(11)         | YES  | UNI |         |       |
| email  | char(30)         | YES  |     |         |       |
+--------+------------------+------+-----+---------+-------+
7 rows in set (0.01 sec)

mysql> alter table student drop primary key;                
Query OK, 5 rows affected (0.02 sec)                        
Records: 5  Duplicates: 0  Warnings: 0                      
                                                            
mysql> desc student;                                        
+--------+------------------+------+-----+---------+-------+
| Field  | Type             | Null | Key | Default | Extra |
+--------+------------------+------+-----+---------+-------+
| id     | int(11) unsigned | NO   |     | 0       |       |
| no     | char(10)         | YES  | UNI |         |       |
| name   | varchar(20)      | NO   |     |         |       |
| age    | tinyint(2)       | YES  |     | NULL    |       |
| gender | tinyint(1)       | YES  |     | NULL    |       |
| mobile | char(11)         | YES  | UNI |         |       |
| email  | char(30)         | YES  |     |         |       |
+--------+------------------+------+-----+---------+-------+
7 rows in set (0.01 sec)                       

添加 primary key
mysql> alter table student add primary key(id);             
Query OK, 0 rows affected (0.03 sec)                        
Records: 0  Duplicates: 0  Warnings: 0                      
                                                            
mysql> desc student;                                        
+--------+------------------+------+-----+---------+-------+
| Field  | Type             | Null | Key | Default | Extra |             
+--------+------------------+------+-----+---------+-------+
| id     | int(11) unsigned | NO   | PRI | 0       |       |
| no     | char(10)         | YES  | UNI |         |       |
| name   | varchar(20)      | NO   |     |         |       |
| age    | tinyint(2)       | YES  |     | NULL    |       |
| gender | tinyint(1)       | YES  |     | NULL    |       |
| mobile | char(11)         | YES  | UNI |         |       |
| email  | char(30)         | YES  |     |         |       |
+--------+------------------+------+-----+---------+-------+
7 rows in set (0.01 sec)                                   

auto_increment 必须应用在一个 key(要么是primary key 或者 unique key) 而且 必须是 int 型
mysql> alter table student modify id int(11) unsigned auto_increment; 
Query OK, 5 rows affected (0.02 sec)                                  
Records: 5  Duplicates: 0  Warnings: 0                                 
                                                                      
mysql> desc student;                                                  
+--------+------------------+------+-----+---------+----------------+ 
| Field  | Type             | Null | Key | Default | Extra          | 
+--------+------------------+------+-----+---------+----------------+ 
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment | 
| no     | char(10)         | YES  | UNI |         |                | 
| name   | varchar(20)      | NO   |     |         |                | 
| age    | tinyint(2)       | YES  |     | NULL    |                | 
| gender | tinyint(1)       | YES  |     | NULL    |                | 
| mobile | char(11)         | YES  | UNI |         |                | 
| email  | char(30)         | YES  |     |         |                | 
+--------+------------------+------+-----+---------+----------------+ 
7 rows in set (0.01 sec)  
                                           

###高级操作
1.复制表结构(只会复制结构而不会复制数据)
create table 新表名 like 旧表名
mysql> create table new_student like student;                        
Query OK, 0 rows affected (0.01 sec)                                 
                                                                     
mysql> desc new_student;                                             
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| no     | char(10)         | YES  | UNI |         |                |
| name   | varchar(20)      | NO   |     |         |                |
| age    | tinyint(2)       | YES  |     | NULL    |                |
| gender | tinyint(1)       | YES  |     | NULL    |                |
| mobile | char(11)         | YES  | UNI |         |                |
| email  | char(30)         | YES  |     |         |                |
+--------+------------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)

2.备份sql数据(主要用于备份sql执行的结果)
create table 表名 select 语句
mysql> create table new_student select * from student;
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0
mysql> select * from new_student;
+----+------------+------------+------+--------+-------------+-------+
| id | no         | name       | age  | gender | mobile      | email |
+----+------------+------------+------+--------+-------------+-------+
|  1 | 1210040109 | laoerpang  |   28 |      1 | 13066976802 |       |
|  2 | 1210040111 | zhengbowen |   30 |      1 | 13066976803 |       |
|  3 |            | shangfeipo | NULL |   NULL | 13066976804 |       |
|  4 | NULL       | oulaoer    | NULL |   NULL | 13066976805 |       |
|  5 | NULL       | huangzhen  | NULL |   NULL | 13066976806 |       |
+----+------------+------------+------+--------+-------------+-------+
5 rows in set (0.00 sec)

限制更新
mysql> select * from student;
+----+------------+------------+------+--------+-------------+-------+
| id | no         | name       | age  | gender | mobile      | email |
+----+------------+------------+------+--------+-------------+-------+
|  1 | 1210040109 | laoerpang  |   28 |      1 | 13066976802 |       |
|  2 | 1210040111 | zhengbowen |   30 |      1 | 13066976803 |       |
|  3 |            | shangfeipo | NULL |   NULL | 13066976804 |       |
|  4 | NULL       | oulaoer    | NULL |      1 | 13066976805 |       |
|  5 | NULL       | huangzhen  | NULL |      1 | 13066976806 |       |
+----+------------+------------+------+--------+-------------+-------+
5 rows in set (0.00 sec)

mysql> update student set gender = 2 where age is null limit 2;
Query OK, 2 rows affected (0.00 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> select * from student;
+----+------------+------------+------+--------+-------------+-------+
| id | no         | name       | age  | gender | mobile      | email |
+----+------------+------------+------+--------+-------------+-------+
|  1 | 1210040109 | laoerpang  |   28 |      1 | 13066976802 |       |
|  2 | 1210040111 | zhengbowen |   30 |      1 | 13066976803 |       |
|  3 |            | shangfeipo | NULL |      2 | 13066976804 |       |
|  4 | NULL       | oulaoer    | NULL |      2 | 13066976805 |       |
|  5 | NULL       | huangzhen  | NULL |      1 | 13066976806 |       |
+----+------------+------------+------+--------+-------------+-------+
5 rows in set (0.00 sec)

按id倒序后更新前2条
mysql> update student set gender = 3 where age is null order by id desc limit 2;
Query OK, 2 rows affected (0.00 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> select * from student;
+----+------------+------------+------+--------+-------------+-------+
| id | no         | name       | age  | gender | mobile      | email |
+----+------------+------------+------+--------+-------------+-------+
|  1 | 1210040109 | laoerpang  |   28 |      1 | 13066976802 |       |
|  2 | 1210040111 | zhengbowen |   30 |      1 | 13066976803 |       |
|  3 |            | shangfeipo | NULL |      2 | 13066976804 |       |
|  4 | NULL       | oulaoer    | NULL |      3 | 13066976805 |       |
|  5 | NULL       | huangzhen  | NULL |      3 | 13066976806 |       |
+----+------------+------------+------+--------+-------------+-------+
5 rows in set (0.00 sec)


限制删除(用于限制对where匹配到的记录的删除数量)
mysql> delete from student where gender = 3 order by id desc limit 1;
Query OK, 1 row affected (0.00 sec)

mysql> select * from student;
+----+------------+------------+------+--------+-------------+-------+
| id | no         | name       | age  | gender | mobile      | email |
+----+------------+------------+------+--------+-------------+-------+
|  1 | 1210040109 | laoerpang  |   28 |      1 | 13066976802 |       |
|  2 | 1210040111 | zhengbowen |   30 |      1 | 13066976803 |       |
|  3 |            | shangfeipo | NULL |      2 | 13066976804 |       |
|  4 | NULL       | oulaoer    | NULL |      3 | 13066976805 |       |
+----+------------+------------+------+--------+-------------+-------+
4 rows in set (0.00 sec)

set语句：

mysql> update student set no = '1210040108', name = 'shangmengjia', age = 29, gender = 2 ,email = 'smj@sina.cn' where id = 3;    
Query OK, 1 row affected (0.00 sec)

mysql> select * from student where id = 3;
+----+------------+--------------+------+--------+-------------+-------------+
| id | no         | name         | age  | gender | mobile      | email       |
+----+------------+--------------+------+--------+-------------+-------------+
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn |
+----+------------+--------------+------+--------+-------------+-------------+
1 row in set (0.00 sec)

mysql> insert into student set no = '1210040106', name = 'wangtianshi', age = 29, gender = 2; 
Query OK, 1 row affected (0.00 sec)                                                                                                                   
mysql> select * from student;                                                                 
+----+------------+--------------+------+--------+-------------+-------------+                
| id | no         | name         | age  | gender | mobile      | email       |                
+----+------------+--------------+------+--------+-------------+-------------+                
|  1 | 1210040109 | laoerpang    |   28 |      1 | 13066976802 |             |                
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |             |                
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn |                
|  4 | NULL       | oulaoer      | NULL |      3 | 13066976805 |             |                
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |             |                
+----+------------+--------------+------+--------+-------------+-------------+                
5 rows in set (0.00 sec)   

#蠕虫复制
mysql> insert into student(name, age, gender) select name, age, gender from student;
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from student;
+----+------------+--------------+------+--------+-------------+-------------+
| id | no         | name         | age  | gender | mobile      | email       |
+----+------------+--------------+------+--------+-------------+-------------+
|  1 | 1210040109 | laoerpang    |   28 |      1 | 13066976802 |             |
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |             |
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn |
|  4 | NULL       | oulaoer      | NULL |      3 | 13066976805 |             |
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |             |
| 11 |            | laoerpang    |   28 |      1 |             |             |
| 12 |            | zhengbowen   |   30 |      1 |             |             |
| 13 |            | shangmengjia |   29 |      2 |             |             |
| 14 |            | oulaoer      | NULL |      3 |             |             |
| 15 |            | wangtianshi  |   29 |      2 |             |             |
+----+------------+--------------+------+--------+-------------+-------------+
10 rows in set (0.00 sec)

#主键冲突的处理方式
①、冲突更新
语法：
	insert into 表名(字段列表) values(值列表) on duplicate key update字段=值;
说明：
	当主键冲突时执行更改操作，如果不冲突执行添加操作
mysql> select * from student;
+----+------------+--------------+------+--------+-------------+-------------+
| id | no         | name         | age  | gender | mobile      | email       |
+----+------------+--------------+------+--------+-------------+-------------+
|  1 | 1210040109 | laoerpang    |   28 |      1 | 13066976802 |             |
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |             |
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn |
|  4 | NULL       | oulaoer      | NULL |      3 | 13066976805 |             |
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |             |
+----+------------+--------------+------+--------+-------------+-------------+
5 rows in set (0.00 sec)

mysql> insert into student values(1, '1210040103', 'wanger', 28, 1, '15773265611', 'wanger@qq.com') on duplicate key update age=age+1;
Query OK, 2 rows affected (0.00 sec)                                                                   
mysql> select * from student;
+----+------------+--------------+------+--------+-------------+-------------+
| id | no         | name         | age  | gender | mobile      | email       |
+----+------------+--------------+------+--------+-------------+-------------+
|  1 | 1210040109 | laoerpang    |   29 |      1 | 13066976802 |             |
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |             |
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn |
|  4 | NULL       | oulaoer      | NULL |      3 | 13066976805 |             |
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |             |
+----+------------+--------------+------+--------+-------------+-------------+
5 rows in set (0.00 sec)


mysql> select * from student;
+----+------------+---------------+------+--------+-------------+-------------+
| id | no         | name          | age  | gender | mobile      | email       |
+----+------------+---------------+------+--------+-------------+-------------+
|  1 | 1210040109 | wangzheerpang |   39 |      1 | 13066976802 |             |
|  2 | 1210040111 | zhengbowen    |   30 |      1 | 13066976803 |             |
|  3 | 1210040108 | shangmengjia  |   29 |      2 | 13066976804 | smj@sina.cn |
|  4 | NULL       | oulaoer       | NULL |      3 | 13066976805 |             |
|  6 | 1210040106 | wangtianshi   |   29 |      2 |             |             |
+----+------------+---------------+------+--------+-------------+-------------+
5 rows in set (0.00 sec)

mysql> insert into student values(1, '1210040103', 'wanger', 28, 1, '15773265611', 'wanger@qq.com') on duplicate key update age=age-10, name='laoerpang', email='laoerpang@sina.com';
Query OK, 2 rows affected (0.00 sec)

mysql> select * from student;
+----+------------+--------------+------+--------+-------------+--------------------+
| id | no         | name         | age  | gender | mobile      | email              |
+----+------------+--------------+------+--------+-------------+--------------------+
|  1 | 1210040109 | laoerpang    |   29 |      1 | 13066976802 | laoerpang@sina.com |
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |                    |
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn        |
|  4 | NULL       | oulaoer      | NULL |      3 | 13066976805 |                    |
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |                    |
+----+------------+--------------+------+--------+-------------+--------------------+
5 rows in set (0.00 sec)



②、冲突替换
语法：
	replace into 表名(字段列表) values(值列表)
说明：
	主键冲突替换
mysql> select * from student;
+----+------------+--------------+------+--------+-------------+--------------------+
| id | no         | name         | age  | gender | mobile      | email              |
+----+------------+--------------+------+--------+-------------+--------------------+
|  1 | 1210040109 | laoerpang    |   29 |      1 | 13066976802 | laoerpang@sina.com |
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |                    |
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn        |
|  4 | NULL       | oulaoer      | NULL |      3 | 13066976805 |                    |
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |                    |
+----+------------+--------------+------+--------+-------------+--------------------+
5 rows in set (0.00 sec)

mysql> replace into student values(4,'1210040110','ouyanglaoer',29,1,'15966668888','ouyanglin@163.com');
Query OK, 2 rows affected (0.00 sec)

mysql> select * from student;
+----+------------+--------------+------+--------+-------------+--------------------+
| id | no         | name         | age  | gender | mobile      | email              |
+----+------------+--------------+------+--------+-------------+--------------------+
|  1 | 1210040109 | laoerpang    |   29 |      1 | 13066976802 | laoerpang@sina.com |
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |                    |
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn        |
|  4 | 1210040110 | ouyanglaoer  |   29 |      1 | 15966668888 | ouyanglin@163.com  |
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |                    |
+----+------------+--------------+------+--------+-------------+--------------------+
5 rows in set (0.00 sec)


#备份表数据不会同步表结构
mysql> create table new_student select * from student;
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> desc new_student;
+--------+------------------+------+-----+---------+-------+
| Field  | Type             | Null | Key | Default | Extra |
+--------+------------------+------+-----+---------+-------+
| id     | int(11) unsigned | NO   |     | 0       |       |
| no     | char(10)         | YES  |     |         |       |
| name   | varchar(20)      | NO   |     |         |       |
| age    | tinyint(2)       | YES  |     | NULL    |       |
| gender | tinyint(1)       | YES  |     | NULL    |       |
| mobile | char(11)         | YES  |     |         |       |
| email  | char(30)         | YES  |     |         |       |
+--------+------------------+------+-----+---------+-------+
7 rows in set (0.01 sec)

mysql> desc student;
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| no     | char(10)         | YES  | UNI |         |                |
| name   | varchar(20)      | NO   |     |         |                |
| age    | tinyint(2)       | YES  |     | NULL    |                |
| gender | tinyint(1)       | YES  |     | NULL    |                |
| mobile | char(11)         | YES  | UNI |         |                |
| email  | char(30)         | YES  |     |         |                |
+--------+------------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)


#可以先同步表结构，在使用蠕虫复制进行数据同步
mysql> create table new_student like student;
Query OK, 0 rows affected (0.01 sec)

mysql> desc new_student;
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| no     | char(10)         | YES  | UNI |         |                |
| name   | varchar(20)      | NO   |     |         |                |
| age    | tinyint(2)       | YES  |     | NULL    |                |
| gender | tinyint(1)       | YES  |     | NULL    |                |
| mobile | char(11)         | YES  | UNI |         |                |
| email  | char(30)         | YES  |     |         |                |
+--------+------------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)

mysql> insert into new_student select * from student;
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from new_student;
+----+------------+--------------+------+--------+-------------+--------------------+
| id | no         | name         | age  | gender | mobile      | email              |
+----+------------+--------------+------+--------+-------------+--------------------+
|  1 | 1210040109 | laoerpang    |   29 |      1 | 13066976802 | laoerpang@sina.com |
|  2 | 1210040111 | zhengbowen   |   30 |      1 | 13066976803 |                    |
|  3 | 1210040108 | shangmengjia |   29 |      2 | 13066976804 | smj@sina.cn        |
|  4 | 1210040110 | ouyanglaoer  |   29 |      1 | 15966668888 | ouyanglin@163.com  |
|  6 | 1210040106 | wangtianshi  |   29 |      2 |             |                    |
+----+------------+--------------+------+--------+-------------+--------------------+
5 rows in set (0.00 sec)

#mysql 备份数据库(参考https://www.cnblogs.com/lvchenfeng/p/5442775.html)
mysqldump -u 用户名 -p 数据库名 > 导出的文件名

C:\phpstudy\MySQL\bin
λ pwd

Path
----
C:\phpstudy\MySQL\bin

C:\phpstudy\MySQL\bin
λ mysqldump -h 127.0.0.1 -u root -p  test2 > G:\work_notes\mysql\test2_bak.sql
Enter password: ****
或者
C:\phpstudy\MySQL\bin
λ mysqldump -h 127.0.0.1 -u root -p test2 > F:\test2_bak.sql
Enter password: ****
或者
λ mysqldump -h 127.0.0.1 -P 3306 -u root -p test2 > F:\test_2_bak2.sql
Enter password: ****