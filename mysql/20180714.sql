
#触发器
mysql> select * from goods where id = 10 \G;
*************************** 1. row ***************************
          id: 10
  goods_name: 荣耀9
goods_number: 10
goods_price: 2400
1 row in set (0.00 sec)

mysql> select * from bank where id = 2 \G;
*************************** 1. row ***************************
     id: 2
   name: yujiansong
balance: 11000.000
1 row in set (0.00 sec)

mysql> delimiter ;
mysql> -- 创建触发器
mysql> delimiter ;;
mysql> create trigger trigger1 after update on bank for each row
    -> begin
    -> update goods set goods_number = goods_number - 1 where id = 10;
    -> end;;
Query OK, 0 rows affected (0.01 sec)

mysql> delimiter ;

mysql> select * from bank where id = 2;
+------+------------+-----------+
| id   | name       | balance   |
+------+------------+-----------+
|    2 | yujiansong | 11000.000 |
+------+------------+-----------+
1 row in set (0.00 sec)

mysql> update bank set balance = balance - 2400 where id = 2;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from bank where id = 2;
+------+------------+----------+
| id   | name       | balance  |
+------+------------+----------+
|    2 | yujiansong | 8600.000 |
+------+------------+----------+
1 row in set (0.00 sec)

mysql> select * from goods where id = 10;
+----+------------+--------------+-------------+
| id | goods_name | goods_number | goods_price |
+----+------------+--------------+-------------+
| 10 | 荣耀9         |            9 |        2400 |
+----+------------+--------------+-------------+
1 row in set (0.00 sec)


mysql> -- 创建触发器
mysql> delimiter ;;
mysql> create trigger trigger2 after update on member for each row
    -> begin
    -> update goods set goods_number = goods_number - new.goods_num where id = new.goods_id;
    -> end;;
Query OK, 0 rows affected (0.01 sec)

mysql> delimiter ;

mysql> select username, nickname, goods_id, goods_num from member where id = 15;
+----------+--------------+----------+-----------+
| username | nickname     | goods_id | goods_num |
+----------+--------------+----------+-----------+
| 于建松        | bestjiansong |        0 |         0 |
+----------+--------------+----------+-----------+
1 row in set (0.00 sec)

mysql> select * from goods where id = 10;
+----+------------+--------------+-------------+
| id | goods_name | goods_number | goods_price |
+----+------------+--------------+-------------+
| 10 | 荣耀9         |            9 |        2400 |
+----+------------+--------------+-------------+
1 row in set (0.00 sec)

mysql> update member set goods_id = 10, goods_num = 2 where id = 15;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select username, nickname, goods_id, goods_num from member where id = 15;
+----------+--------------+----------+-----------+
| username | nickname     | goods_id | goods_num |
+----------+--------------+----------+-----------+
| 于建松        | bestjiansong |       10 |         2 |
+----------+--------------+----------+-----------+
1 row in set (0.00 sec)

mysql> select * from goods where id = 10;
+----+------------+--------------+-------------+
| id | goods_name | goods_number | goods_price |
+----+------------+--------------+-------------+
| 10 | 荣耀9         |            7 |        2400 |
+----+------------+--------------+-------------+
1 row in set (0.00 sec)

#查看触发器
mysql> show triggers \G;                                                                                    
*************************** 1. row ***************************                                              
             Trigger: trigger1                                                                              
               Event: UPDATE                                                                                
               Table: bank                                                                                  
           Statement: begin                                                                                 
update goods set goods_number = goods_number - 1 where id = 10;                                             
end                                                                                                         
              Timing: AFTER                                                                                 
             Created: NULL                                                                                  
            sql_mode: NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION                                            
             Definer: root@localhost                                                                        
character_set_client: gbk                                                                                   
collation_connection: gbk_chinese_ci                                                                        
  Database Collation: latin1_swedish_ci                                                                     
*************************** 2. row ***************************                                              
             Trigger: trigger2                                                                              
               Event: UPDATE                                                                                
               Table: member                                                                                
           Statement: begin                                                                                 
update goods set goods_number = goods_number - new.goods_num where id = new.goods_id;                       
end                                                                                                         
              Timing: AFTER                                                                                 
             Created: NULL                                                                                  
            sql_mode: NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION                                            
             Definer: root@localhost                                                                        
character_set_client: gbk                                                                                   
collation_connection: gbk_chinese_ci                                                                        
  Database Collation: latin1_swedish_ci                                                                     
2 rows in set (0.02 sec)   

#删除触发器
mysql> drop trigger trigger1;
Query OK, 0 rows affected (0.00 sec)

mysql> show triggers \G;
*************************** 1. row ***************************
             Trigger: trigger2
               Event: UPDATE
               Table: member
           Statement: begin
update goods set goods_number = goods_number - new.goods_num where id = new.goods_id;
end
              Timing: AFTER
             Created: NULL
            sql_mode: NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
             Definer: root@localhost
character_set_client: gbk
collation_connection: gbk_chinese_ci
  Database Collation: latin1_swedish_ci
1 row in set (0.02 sec)

