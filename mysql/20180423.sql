
#ת���������
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

#alter table ת���������
mysql> alter table ss_test engine=myisam;
Query OK, 34 rows affected (0.11 sec)
Records: 34  Duplicates: 0  Warnings: 0

#�ٴβ鿴�������
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

ʹ��alter table ת�����������һ������:��Ҫִ�кܳ�ʱ�䡣mysql���н����ݴ�ԭ���Ƶ���һ���µı��У��ڸ����ڼ���ܻ�����ϵͳ���е�I/O������ͬʱԭ���ϻ���϶���.���ԣ��ڷ�æ�ı���ִ�д˲���Ҫ�ر�С�ġ�
#���ת����Ĵ洢���棬����ʧȥ��ԭ������ص���������,���罫InnoDB��ת��ΪMyIsAM,Ȼ����ת��ΪInnoDB,ԭInnoDB���ϵ��������������ʧ.

�ڶ���ת������
#������� �����뵼��ķ������ֹ����б�ĸ���
Ϊ�˸��õĿ���ת�����̣�����ʹ��mysqldump���߽����ݵ������ļ���Ȼ���޸��ļ���CREATE TABLE ����еĴ洢����ѡ�ע��ͬʱ�޸ı���,��Ϊͬһ�����ݿ��в��ܴ�����ͬ�ı�������ʹ����ʹ�õ��ǲ�ͬ�Ĵ洢���档ͬʱע��mysqldumpĬ�ϻ��Զ���create table���ǰ����DROP TABLE��䣬��ע����һ����ܻᵼ�����ݶ�ʧ

������ת������
������ת�������ۺ��˵�һ�ַ����ĸ�Ч�͵ڶ��ַ����İ�ȫ������Ҫ��������������ݣ������ȴ���һ���µĴ洢����ı�Ȼ������insert...select�﷨��������
#1.�鿴ԭ��
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

#2.�����±�
mysql> create table innodb_ss_test like ss_test;
Query OK, 0 rows affected (0.02 sec)

#3.�鿴�±�״̬
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

#4.ת���±�Ĵ洢����
mysql> alter table innodb_ss_test engine=innodb;
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

#5.ת������±�״̬
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

#6.����ԭ������
mysql> insert into innodb_ss_test select * from ss_test;
Query OK, 34 rows affected (0.06 sec)
Records: 34  Duplicates: 0  Warnings: 0

�������������Ļ������������ԣ�����������ܴ󣬿��Կ��Ƿ����������ÿһ������ִ�������ύ�������Ա����������������undo.�����������ֶ�id,�ظ������������(��Сֵx,�����ֵy������Ӧ���滻)�����ݵ��뵽�±�:
mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> insert into innodb_ss_test select * from ss_test where id between 1 and 30;
Query OK, 21 rows affected (0.01 sec)
Records: 21  Duplicates: 0  Warnings: 0

mysql> insert into innodb_ss_test select * from ss_test where id between 31 and 60;
Query OK, 13 rows affected (0.02 sec)
Records: 13  Duplicates: 0  Warnings: 0

