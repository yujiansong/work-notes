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

#微信订单的平均价
mysql> delimiter ;;
mysql> create procedure dis_amount_avg()
    -> begin
    -> select avg(dis_amount) as dis_amount_average from ss_weiapp_order;
    -> end;;
Query OK, 0 rows affected (0.03 sec)

mysql> delimiter ;

#调用存储过程
mysql> call dis_amount_avg();
+--------------------+
| dis_amount_average |
+--------------------+
|        3985.824058 |
+--------------------+
1 row in set (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

#删除存储过程
mysql> drop procedure if exists abcd;
Query OK, 0 rows affected, 1 warning (0.04 sec)


#创建存储过程，查询订单的最高价，最低价，平均价
CREATE PROCEDURE orderpricing (
	OUT pl DECIMAL (8, 2),
	OUT ph DECIMAL (8, 2),
	OUT pa DECIMAL (8, 2)
)
BEGIN
	SELECT
		MIN(dis_amount) INTO pl
	FROM
		ss_weiapp_order;

SELECT
	MAX(dis_amount) INTO ph
FROM
	ss_weiapp_order;

SELECT
	AVG(dis_amount) INTO pa
FROM
	ss_weiapp_order;
END;

#调用存储过程
mysql> call orderpricing(@pricelow, @pricehigh, @priceaverage);            
Query OK, 1 row affected, 1 warning (0.03 sec)                             
                                                                           
mysql> select @pricelow;                                                   
+-----------+                                                              
| @pricelow |                                                              
+-----------+                                                              
|      5.00 |                                                              
+-----------+                                                              
1 row in set (0.03 sec)                                                    
                                                                           
mysql> select @pricehigh;                                                  
+------------+                                                             
| @pricehigh |                                                             
+------------+                                                             
|   31000.00 |                                                             
+------------+                                                             
1 row in set (0.03 sec)                                                    
                                                                           
mysql> select @priceaverage;                                               
+---------------+                                                          
| @priceaverage |                                                          
+---------------+                                                          
|       3985.82 |                                                          
+---------------+                                                          
1 row in set (0.03 sec)                                                   


mysql> select @pricelow, @pricehigh, @priceaverage;
+-----------+------------+---------------+
| @pricelow | @pricehigh | @priceaverage |
+-----------+------------+---------------+
|      5.00 |   31000.00 |       3985.82 |
+-----------+------------+---------------+
1 row in set (0.03 sec)

 
 
 CREATE PROCEDURE ordertotal (
	IN userid INT,
	OUT ototal DECIMAL (8, 2)
)
BEGIN
	SELECT
		SUM(product_num * dis_amount)
	FROM
		ss_weiapp_order
	WHERE
		uid = userid INTO ototal;
END;

mysql> call ordertotal(87, @total);
Query OK, 1 row affected (0.03 sec)

mysql> select @total;
+-----------+
| @total    |
+-----------+
| 157721.51 |
+-----------+
1 row in set (0.03 sec)


-- Name:platformtotal
-- Parameters: clinicid = clinic_id
-- taxable = 0 if not taxable, 1 if taxable
-- ototal = ori_price total variable
CREATE PROCEDURE platformtotal (
	IN clinicid INT,
	IN taxable BOOLEAN,
	OUT ototal DECIMAL (8, 2)
) COMMENT '诊所商品价格交税金额'
BEGIN
	DECLARE
		total DECIMAL (8, 2);

DECLARE
	taxrate INT DEFAULT 6;

SELECT
	SUM(price - ori_price)
FROM
	ss_platform_goods
WHERE
	clinic_id = clinicid INTO total;


IF taxable THEN
	SELECT
		total + (total / 100 * taxrate) INTO total;


END
IF;

SELECT
	total INTO ototal;
END;

#不交税
mysql> call platformtotal(14, 0, @total);
Query OK, 1 row affected (0.04 sec)

mysql> select @total;
+----------+
| @total   |
+----------+
| 18345.00 |
+----------+
1 row in set (0.04 sec)

#交税
mysql> call platformtotal(14, 1, @total);
Query OK, 1 row affected (0.03 sec)

mysql> select @total;
+----------+
| @total   |
+----------+
| 19445.70 |
+----------+
1 row in set (0.03 sec)