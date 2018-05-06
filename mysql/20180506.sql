#mysql 常用命令操作

#1.查看数据库
show databases;
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| boxuegu            |
| itshop             |
| legend             |
| mysql              |
| mysqlslap          |
| performance_schema |
| phper              |
| somshu             |
| test               |
| test2              |
+--------------------+
11 rows in set (0.00 sec)

#2.创建数据库
mysql> create database test1 charset utf8mb4;
Query OK, 1 row affected (0.00 sec)

#3.查看数据库的创建语句
mysql> show create database test1;
+----------+-------------------------------------------------------------------+
| Database | Create Database                                                   |
+----------+-------------------------------------------------------------------+
| test1    | CREATE DATABASE `test1` /*!40100 DEFAULT CHARACTER SET utf8mb4 */ |
+----------+-------------------------------------------------------------------+
1 row in set (0.00 sec)

#4.删除数据库
mysql> drop database test1;
Query OK, 0 rows affected (0.00 sec)

#5.选择数据库
mysql> use test2;
Database changed

#6.查看当前所在的数据库
mysql> select database();
+------------+
| database() |
+------------+
| test2      |
+------------+
1 row in set (0.00 sec)

#7.mysql 信息
mysql> \s;
--------------
F:\wamp\mysql-5.5\bin\mysql.exe  Ver 14.14 Distrib 5.5.28, for Win32 (x86)

Connection id:          1
Current database:       test2
Current user:           root@localhost
SSL:                    Not in use
Using delimiter:        ;
Server version:         5.5.53 MySQL Community Server (GPL)
Protocol version:       10
Connection:             127.0.0.1 via TCP/IP
Server characterset:    utf8
Db     characterset:    utf8
Client characterset:    utf8
Conn.  characterset:    utf8
TCP port:               3306
Uptime:                 13 min 42 sec

Threads: 1  Questions: 29  Slow queries: 0  Opens: 34  Flush tables: 1  Open tables: 27  Queries per second avg: 0.035

#8.设置客户端字符集
mysql> set names gbk;
Query OK, 0 rows affected (0.00 sec)

#9.查看数据表
mysql> show tables;
+-----------------+
| Tables_in_test2 |
+-----------------+
| orders          |
| persons         |
+-----------------+
2 rows in set (0.00 sec)

#10.创建数据表
mysql> create table student(
    -> no char(10) comment'学号',
    -> name varchar(20) comment'姓名',
    -> age tinyint(2) comment'年龄',
    -> gender tinyint(1) comment'性别'
    -> )charset utf8;
Query OK, 0 rows affected (0.01 sec)

#11.查看表结构
mysql> desc student;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| no     | char(10)    | YES  |     | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| age    | tinyint(2)  | YES  |     | NULL    |       |
| gender | tinyint(1)  | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

#12.查看表的创建语句
mysql> show create table student \G;                
*************************** 1. row *****************
       Table: student                               
Create Table: CREATE TABLE `student` (              
  `no` char(10) DEFAULT NULL COMMENT '学号',          
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',     
  `age` tinyint(2) DEFAULT NULL COMMENT '年龄',       
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别'     
) ENGINE=InnoDB DEFAULT CHARSET=utf8                
1 row in set (0.00 sec)                             
                                                    
ERROR:                                              
No query specified

#13.创建同样的表结构
mysql> create table student2 like student;
Query OK, 0 rows affected (0.01 sec)

mysql> show tables;
+-----------------+
| Tables_in_test2 |
+-----------------+
| orders          |
| persons         |
| student         |
| student2        |
+-----------------+
4 rows in set (0.00 sec)                                  

#14.删除表
mysql> drop table student2;
Query OK, 0 rows affected (0.01 sec)

#15.增加数据
insert into 表名(字段列表) values(值列表)
mysql> insert into student(no, name, age, gender) values('1210040109', 'laoerpang', 28, 1);
Query OK, 1 row affected (0.00 sec)

mysql> select * from student;
+------------+-----------+------+--------+
| no         | name      | age  | gender |
+------------+-----------+------+--------+
| 1210040109 | laoerpang |   28 |      1 |
+------------+-----------+------+--------+
1 row in set (0.00 sec)

mysql> insert into student(name, age) values('zhengbowen', 29);
Query OK, 1 row affected (0.00 sec)

#语法2 省略字段列表全部插入数据
insert into 表名 value(值列表)
mysql> insert into student values('1210040116', 'yujiansong', 28, 1);
Query OK, 1 row affected (0.00 sec)

mysql> select * from student;
+------------+------------+------+--------+
| no         | name       | age  | gender |
+------------+------------+------+--------+
| 1210040109 | laoerpang  |   28 |      1 |
| NULL       | zhengbowen |   29 |   NULL |
| 1210040116 | yujiansong |   28 |      1 |
+------------+------------+------+--------+
3 rows in set (0.00 sec)
#16.更新语句
mysql> update student set no = '1210040111', age = age + 1, gender = 1 where name = 'zhengbowen';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from student where name = 'zhengbowen';
+------------+------------+------+--------+
| no         | name       | age  | gender |
+------------+------------+------+--------+
| 1210040111 | zhengbowen |   30 |      1 |
+------------+------------+------+--------+
1 row in set (0.00 sec)

#17.删除语句
mysql> delete from student where name = 'yujiansong';
Query OK, 1 row affected (0.00 sec)

mysql> select * from student;
+------------+------------+------+--------+
| no         | name       | age  | gender |
+------------+------------+------+--------+
| 1210040109 | laoerpang  |   28 |      1 |
| 1210040111 | zhengbowen |   30 |      1 |
+------------+------------+------+--------+
2 rows in set (0.00 sec)

#18.查看服务器支持的全部字符集
mysql> show charset;

#19.collate
英文翻译：校验，校对。
概念
	所谓的检验就是比较。校验集就是某一种字符集就字符的比较规则(是否区分大小写)。
查看服务器支持的校对规则
命令：
	show collation;
校验集一般有三种
	以ci结尾			CaseInsensitive大小写不敏感(不区分大小写)
	以cs结尾 			CaseSensitive大小写敏感(区分大小写)
	以bin结尾 			二进制(区分大小写)
	
枚举类型
	在多个选项中只允许选择一个，这样的数据就是枚举数据。
语法：
	enum(值列表)
mysql> create table test_enmu(
    -> color enum('red','green','blue','yellow')
    -> ) charset utf8mb4;
Query OK, 0 rows affected (0.01 sec)

mysql> show create table test_enmu \G;
*************************** 1. row ***************************
       Table: test_enmu
Create Table: CREATE TABLE `test_enmu` (
  `color` enum('red','green','blue','yellow') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

ERROR:
No query specified

mysql> insert into test_enmu values('red');
Query OK, 1 row affected (0.00 sec)

mysql> select * from test_enmu;
+-------+
| color |
+-------+
| red   |
+-------+
1 row in set (0.00 sec)

mysql> insert into test_enmy values('cyan');
ERROR 1146 (42S02): Table 'test2.test_enmy' doesn't exist

集合类型
	在多个可选择的数据中允许选择多个。
语法：
	set(值列表)

	mysql> create table test_set (
    -> color set('red', 'green', 'blue', 'yellow')
    -> ) charset utf8mb4;
Query OK, 0 rows affected (0.01 sec)

mysql> show create table test_set \G;
*************************** 1. row ***************************
       Table: test_set
Create Table: CREATE TABLE `test_set` (
  `color` set('red','green','blue','yellow') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

ERROR:
No query specified

mysql> insert into test_set values('red,green,blue');
Query OK, 1 row affected (0.00 sec)

mysql> select * from test_set;
+----------------+
| color          |
+----------------+
| red,green,blue |
+----------------+
1 row in set (0.00 sec)

mysql> insert into test_set values('yellow');  
Query OK, 1 row affected (0.00 sec)            
                                               
mysql> select * from test_set ;                
+----------------+                             
| color          |                             
+----------------+                             
| red,green,blue |                             
| yellow         |                             
+----------------+                             
2 rows in set (0.00 sec)                       

3、日期时间型
year			年
格式：
	year(2或4);

date			日期
格式:
	’yyyy-mm-dd’   	例如：’2017-05-07’

time			时间
格式：
	‘hh:ii:ss’			例如：’17:51:59’
datetime		日期时间型
格式：
	‘yyyy-mm-dd   hh:ii:ss’		例如：‘2017-05-07  17:53:40’ 

timestamp	时间戳
格式：
	‘yyyy-mm-dd   hh:ii:ss’		例如：‘2017-05-07  17:53:40’
示例：

#timestamp 会自动记录当前记录被修改的时间
mysql> create table test_date(
    -> y year(4),
    -> d date,
    -> t time,
    -> dt datetime,
    -> tp timestamp
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> desc test_date;
+-------+-----------+------+-----+-------------------+-----------------------------+
| Field | Type      | Null | Key | Default           | Extra                       |
+-------+-----------+------+-----+-------------------+-----------------------------+
| y     | year(4)   | YES  |     | NULL              |                             |
| d     | date      | YES  |     | NULL              |                             |
| t     | time      | YES  |     | NULL              |                             |
| dt    | datetime  | YES  |     | NULL              |                             |
| tp    | timestamp | NO   |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |
+-------+-----------+------+-----+-------------------+-----------------------------+
5 rows in set (0.01 sec)

mysql> insert into test_date(y, d, t, dt) values('2018', '2018-05-06', '15:16:40', '2018-05-06 15:16:40');
Query OK, 1 row affected (0.00 sec)

mysql> select * from test_date;
+------+------------+----------+---------------------+---------------------+
| y    | d          | t        | dt                  | tp                  |
+------+------------+----------+---------------------+---------------------+
| 2018 | 2018-05-06 | 15:16:40 | 2018-05-06 15:16:40 | 2018-05-06 15:17:32 |
+------+------------+----------+---------------------+---------------------+
1 row in set (0.00 sec)

mysql> update test_date set t = '15:16:41' where y = '2018';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from test_date;
+------+------------+----------+---------------------+---------------------+
| y    | d          | t        | dt                  | tp                  |
+------+------------+----------+---------------------+---------------------+
| 2018 | 2018-05-06 | 15:16:41 | 2018-05-06 15:16:40 | 2018-05-06 15:19:16 |
+------+------------+----------+---------------------+---------------------+
1 row in set (0.00 sec)






