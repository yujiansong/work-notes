#mysql 存储过程应用

语法：
	create procedure 过程名(方向 变量 类型,方向 变量 类型)
	begin


	end

形参的方向有三种：in、out、inout
	    in能把数据传递到过程内，但不能传出
	    out不能把数据传递到过程内，但可以传出
	    inout可以传进，也可以传出

mysql> -- 定义存储过程
mysql> -- 第一步：修改提示符
mysql> delimiter #
mysql> -- 第二步：创建存储过程
mysql> create procedure pro(in v1 int, out v2 int, inout v3 int)
    -> begin
    -> select v1,v2,v3;
    -> end
    -> #
Query OK, 0 rows affected (0.10 sec)

mysql> -- 第三步： 还原提示符
mysql> delimiter ;

mysql> -- 定义自定义变量，将自定义变量传递到过程中
mysql> set @v1=10, @v2=20, @v3=30;
Query OK, 0 rows affected (0.11 sec)		

mysql> call pro(@v1, @v2, @v3);
+------+------+------+
| v1   | v2   | v3   |
+------+------+------+
|   10 | NULL |   30 |
+------+------+------+
1 row in set (0.08 sec)

Query OK, 0 rows affected (0.08 sec)
#此结果是内输出的 所以 v2 = null;

	
mysql> -- 定义存储过程
mysql> -- 第一步：修改提示符
mysql> delimiter #
mysql> -- 创建存储过程
mysql> create procedure prob(in v1 int, out v2 int, inout v3 int)
    -> begin
    -> set v1 = 100;
    -> set v2 = 200;
    -> set v3 = 300;
    -> select v1,v2,v3;
    -> end
    -> #
Query OK, 0 rows affected (0.03 sec)

mysql> -- 第三步，还原提示符
mysql> delimiter ;


mysql> set @v1=10, @v2=20, @v3=30;
Query OK, 0 rows affected (0.04 sec)

mysql> call prob(@v1, @v2, @v3);
+------+------+------+
| v1   | v2   | v3   |
+------+------+------+
|  100 |  200 |  300 |
+------+------+------+
1 row in set (0.04 sec)

Query OK, 0 rows affected (0.04 sec)
#此处的结果是过程内部显示的

mysql> -- 过程外查看传递进去的变量的值
mysql> select @v1, @v2, @v3;
+------+------+------+
| @v1  | @v2  | @v3  |
+------+------+------+
|   10 |  200 |  300 |
+------+------+------+
1 row in set (0.03 sec)

#3.调用存储过程 
call 过程名(实参)

#4.查看存储过程
mysql> show procedure status \G;
*************************** 1. row ***************************
                  Db: test_clinic
                Name: pro
                Type: PROCEDURE
             Definer: test_clinic@%
            Modified: 2018-06-30 17:52:38
             Created: 2018-06-30 17:52:38
       Security_type: DEFINER
             Comment:
character_set_client: gbk
collation_connection: gbk_chinese_ci
  Database Collation: utf8mb4_general_ci
*************************** 2. row ***************************
                  Db: test_clinic
                Name: prob
                Type: PROCEDURE
             Definer: test_clinic@%
            Modified: 2018-06-30 18:00:47
             Created: 2018-06-30 18:00:47
       Security_type: DEFINER
             Comment:
character_set_client: gbk
collation_connection: gbk_chinese_ci
  Database Collation: utf8mb4_general_ci
2 rows in set (0.03 sec)

#5.删除存储过程
drop procedure 过程名
mysql> drop procedure pro；
Query OK, 0 rows affected (0.03 sec)


#创建不带参数的存储过程
#查询当前诊所数量
mysql> delimiter ;;                               
mysql> create procedure `select_clinic_count`()   
    -> begin                                      
    -> select count(*) from ss_clinic_info;       
    -> end;;                                      
Query OK, 0 rows affected (0.03 sec)              
                                                  
mysql> delimiter ;                                
mysql> call select_clinic_count();                
+----------+                                      
| count(*) |                                      
+----------+                                      
|       59 |                                      
+----------+                                      
1 row in set (0.03 sec)                           
                                                  
Query OK, 0 rows affected (0.04 sec)   

#在navicat里写存储过程
CREATE PROCEDURE `select_patient_count` ()
BEGIN
	SELECT
		count(id)
	FROM
		ss_patient;

END

#查询电销患者的预约数量           
CREATE PROCEDURE `select_tel_reserve` ()
BEGIN
	SELECT
		count (id)
	FROM
		ss_diagnostic_appointment_wx
	WHERE
		source = 3;

END
#调用存储过程进行查询
mysql> call select_tel_reserve();
+-----------+
| count(id) |
+-----------+
|       423 |
+-----------+
1 row in set (0.03 sec)

Query OK, 0 rows affected (0.05 sec)

