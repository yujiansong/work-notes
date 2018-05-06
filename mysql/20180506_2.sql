#mysql��������

ת��unixʱ���
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

#1.�޸ı���
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

�ڶ��ַ�ʽ:
mysql> rename table persons to person;
Query OK, 0 rows affected (0.01 sec)  

#2.����ֶ�
mysql> alter table student add column mobile char(12) comment'�ֻ�' after age;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> alter table student add column email char(40) comment'����' after mobile;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> alter table student add email char(40) default'' comment'����' after mobile;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

#3.ɾ���ֶ�
mysql> alter table student drop email;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

#4.�޸��ֶ�����
mysql> alter table student modify mobile char(11) default'' comment'�ֻ���' after gender;
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

#5.�����ֶ���
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
Լ�����в��ܳ����ظ���ֵ��������Ϊnull
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

˵�������� null ������ null ,��������unique Լ��

primary key
�������
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

�鿴auto_increment �������������Ϣ
mysql> show variables like '%auto_increment%';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| auto_increment_increment | 1     |
| auto_increment_offset    | 1     |
+--------------------------+-------+
2 rows in set (0.00 sec)


����������
һ������������һ���������ڣ��������ж��Ψһ��
����ֶι�ͬ������Ψһ��ʶһ����¼
primary key(�ֶ�1���ֶ�2)

ģ��������
��һ���������û�������ֶΣ� Mysql�Ὣ��һ�� ���� unique �� not null Լ�����ֶ���֮Ϊ�����ֶ�

ɾ����
mysql> drop table if exists student2;
Query OK, 0 rows affected (0.01 sec)

���unique
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

�ڶ��ַ�ʽ���unique
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

ɾ��key
mysql> alter table student drop key name;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

ɾ�� primary key
1.��������� auto_increment ��Ҫ��ȥ������ɾ������
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

��� primary key
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

auto_increment ����Ӧ����һ�� key(Ҫô��primary key ���� unique key) ���� ������ int ��
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
                                           

###�߼�����
1.���Ʊ�ṹ(ֻ�Ḵ�ƽṹ�����Ḵ������)
create table �±��� like �ɱ���
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

2.����sql����(��Ҫ���ڱ���sqlִ�еĽ��)
create table ���� select ���
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

���Ƹ���
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

��id��������ǰ2��
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


����ɾ��(�������ƶ�whereƥ�䵽�ļ�¼��ɾ������)
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

set��䣺

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

#��渴��
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

#������ͻ�Ĵ���ʽ
�١���ͻ����
�﷨��
	insert into ����(�ֶ��б�) values(ֵ�б�) on duplicate key update�ֶ�=ֵ;
˵����
	��������ͻʱִ�и��Ĳ������������ͻִ����Ӳ���
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



�ڡ���ͻ�滻
�﷨��
	replace into ����(�ֶ��б�) values(ֵ�б�)
˵����
	������ͻ�滻
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


#���ݱ����ݲ���ͬ����ṹ
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


#������ͬ����ṹ����ʹ����渴�ƽ�������ͬ��
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

#mysql �������ݿ�(�ο�https://www.cnblogs.com/lvchenfeng/p/5442775.html)
mysqldump -u �û��� -p ���ݿ��� > �������ļ���

C:\phpstudy\MySQL\bin
�� pwd

Path
----
C:\phpstudy\MySQL\bin

C:\phpstudy\MySQL\bin
�� mysqldump -h 127.0.0.1 -u root -p  test2 > G:\work_notes\mysql\test2_bak.sql
Enter password: ****
����
C:\phpstudy\MySQL\bin
�� mysqldump -h 127.0.0.1 -u root -p test2 > F:\test2_bak.sql
Enter password: ****
����
�� mysqldump -h 127.0.0.1 -P 3306 -u root -p test2 > F:\test_2_bak2.sql
Enter password: ****