
#转换表的引擎
mysql> show table status like '%ss_test%' \G;
*************************** 1. row ***************************
           Name: ss_test
         Engine: InnoDB
        Version: 10
     Row_format: Dynamic
           Rows: 34
 Avg_row_length: 481
    Data_length: 16384
Max_data_length: 0
   Index_length: 0
      Data_free: 0
 Auto_increment: 53
    Create_time: 2017-10-28 19:12:25
    Update_time: NULL
     Check_time: NULL
      Collation: utf8mb4_general_ci
       Checksum: NULL
 Create_options: 
        Comment: 
1 row in set (0.09 sec)

#alter table 转换表的引擎
mysql> alter table ss_test engine=myisam;
Query OK, 34 rows affected (0.11 sec)
Records: 34  Duplicates: 0  Warnings: 0

#再次查看表的引擎
mysql> show table status like 'ss_test' \G;
*************************** 1. row ***************************
           Name: ss_test
         Engine: MyISAM
        Version: 10
     Row_format: Fixed
           Rows: 34
 Avg_row_length: 85
    Data_length: 2890
Max_data_length: 23925373020405759
   Index_length: 2048
      Data_free: 0
 Auto_increment: 53
    Create_time: 2018-04-23 09:08:07
    Update_time: 2018-04-23 09:08:08
     Check_time: NULL
      Collation: utf8mb4_general_ci
       Checksum: NULL
 Create_options: 
        Comment: 
1 row in set (0.00 sec)

使用alter table 转换表的引擎有一个问题:需要执行很长时间。mysql按行将数据从原表复制到另一张新的表中，在复制期间可能会消耗系统所有的I/O能力，同时原表上会加上读锁.所以，在繁忙的表上执行此操作要特别小心。
#如果转换表的存储引擎，将会失去和原引擎相关的所有特性,例如将InnoDB表转换为MyIsAM,然后在转换为InnoDB,原InnoDB表上的所有外键都将丢失.

第二种转换技术
#替代方案 导出与导入的方法，手工进行表的复制
为了更好的控制转换过程，可以使用mysqldump工具将数据导出到文件，然后修改文件中CREATE TABLE 语句中的存储引擎选项，注意同时修改表名,因为同一个数据库中不能存在相同的表名，即使他们使用的是不同的存储引擎。同时注意mysqldump默认会自动在create table语句前加上DROP TABLE语句，不注意这一点可能会导致数据丢失

第三种转换技术
第三种转换技术综合了第一种方法的高效和第二种方法的安全。不需要导出整个表的数据，而是先创建一个新的存储引擎的表，然后利用insert...select语法来导数据
#1.查看原表
mysql> show table status like '%ss_test%' \G;
*************************** 1. row ***************************
           Name: ss_test
         Engine: MyISAM
        Version: 10
     Row_format: Fixed
           Rows: 34
 Avg_row_length: 85
    Data_length: 2890
Max_data_length: 23925373020405759
   Index_length: 2048
      Data_free: 0
 Auto_increment: 53
    Create_time: 2018-04-23 09:41:39
    Update_time: 2018-04-23 09:41:39
     Check_time: NULL
      Collation: utf8mb4_general_ci
       Checksum: NULL
 Create_options: 
        Comment: 
1 row in set (0.00 sec)

#2.创建新表
mysql> create table innodb_ss_test like ss_test;
Query OK, 0 rows affected (0.02 sec)

#3.查看新表状态
mysql> show table status like '%innodb_ss_test%' \G;
*************************** 1. row ***************************
           Name: innodb_ss_test
         Engine: MyISAM
        Version: 10
     Row_format: Fixed
           Rows: 0
 Avg_row_length: 0
    Data_length: 0
Max_data_length: 23925373020405759
   Index_length: 1024
      Data_free: 0
 Auto_increment: 1
    Create_time: 2018-04-23 09:42:31
    Update_time: 2018-04-23 09:42:31
     Check_time: NULL
      Collation: utf8mb4_general_ci
       Checksum: NULL
 Create_options: 
        Comment: 
1 row in set (0.00 sec)

#4.转换新表的存储引擎
mysql> alter table innodb_ss_test engine=innodb;
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

#5.转换后的新表状态
mysql> show table status like '%innodb_ss_test%' \G;
*************************** 1. row ***************************
           Name: innodb_ss_test
         Engine: InnoDB
        Version: 10
     Row_format: Dynamic
           Rows: 0
 Avg_row_length: 0
    Data_length: 16384
Max_data_length: 0
   Index_length: 0
      Data_free: 0
 Auto_increment: 1
    Create_time: 2018-04-23 09:43:57
    Update_time: NULL
     Check_time: NULL
      Collation: utf8mb4_general_ci
       Checksum: NULL
 Create_options: 
        Comment: 
1 row in set (0.00 sec)

#6.插入原表数据
mysql> insert into innodb_ss_test select * from ss_test;
Query OK, 34 rows affected (0.06 sec)
Records: 34  Duplicates: 0  Warnings: 0

如果数据量不大的话，这样做可以，如果数据量很大，可以考虑分批处理，针对每一段数据执行事务提交操作，以避免大事务产生过多的undo.假设有主键字段id,重复运行以下语句(最小值x,和最大值y进行相应的替换)将数据导入到新表:
mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> insert into innodb_ss_test select * from ss_test where id between 1 and 30;
Query OK, 21 rows affected (0.01 sec)
Records: 21  Duplicates: 0  Warnings: 0

mysql> insert into innodb_ss_test select * from ss_test where id between 31 and 60;
Query OK, 13 rows affected (0.02 sec)
Records: 13  Duplicates: 0  Warnings: 0

