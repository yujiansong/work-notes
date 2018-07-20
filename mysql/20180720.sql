#mysql instr应用

#口腔诊所表中的所有口腔诊所数量
mysql> select count(*) from ss_clinic_info;
+----------+
| count(*) |
+----------+
|     8261 |
+----------+
1 row in set (0.06 sec)

#查找 诊所名字中有‘口腔’的诊所
mysql> select id, name, create_time from ss_clinic_info where instr(name, '口腔') > 0;
5260 rows in set (0.23 sec)

#用 like 查询
mysql> select id, name, create_time from ss_clinic_info where name like '%口腔%';
5260 rows in set (0.26 sec)

#用 instr 查询 名字中有‘刘’的数据
mysql> select id, truename, gender from ss_patient where instr(truename, '刘') > 0;
123 rows in set (0.04 sec)

#用 like 查询 名字中有‘刘’的数据
mysql> select id, truename, gender from ss_patient where truename like '%刘%';
123 rows in set (0.03 sec)

想要在字符串中查找子字符串或检查字符串中是否存在子字符串。在这种情况下，您可以使用字符串内置INSTR()函数。
INSTR()函数返回字符串中子字符串第一次出现的位置。如果在str中找不到子字符串，则INSTR()函数返回零(0)。

INSTR(str,substr);

INSTR函数接受两个参数：

    str是要搜索的字符串。
    substr是要搜索的子字符串。

INSTR()函数不区分大小写。这意味着如果通过小写，大写，标题大小写等，结果总是一样的。
如果希望INSTR函数在非二进制字符串上以区分大小写的方式执行搜索，则可以使用BINARY运算符将INSTR函数的参数从非二进制字符串转换为二进制字符串。
SELECT INSTR('MySQL INSTR', BINARY 'sql');

#搜索平台商品表中 name中还有‘A’的商品
mysql> select id, name from ss_platform_goods where name like '%A%';           
+-----+-----------------------------+                                          
| id  | name                        |                                          
+-----+-----------------------------+                                          
|  45 | stutas                      |                                          
|  68 | 种植牙（以色列ABT）媲美真牙 |                                                      
|  82 | 牙周SPA(无痛)               |                                              
|  90 | 牙周SPA（无痛）洁牙         |                                                  
|  96 | 牙周SPA（无痛）             |                                                
| 109 | 牙周SPA（无痛）             |                                                
| 111 | 牙周SPA（无痛洁牙）         |                                                  
| 115 | 牙周SPA（无痛洁牙）         |                                                  
| 118 | 牙周SPA（无痛洁牙）         |                                                  
| 122 | 牙周SPA（无痛洁牙）         |                                                  
| 123 | 牙周SPA（无痛）洁牙         |                                                  
| 124 | 牙周SPA（无痛）洁牙         |                                                  
| 178 | 商品名称A                   |                                              
+-----+-----------------------------+                                          
13 rows in set (0.03 sec)

#like搜索不区分大小写
mysql> select id, name from ss_platform_goods where name like '%a%';
+-----+-----------------------------+
| id  | name                        |
+-----+-----------------------------+
|  45 | stutas                      |
|  68 | 种植牙（以色列ABT）媲美真牙 |
|  82 | 牙周SPA(无痛)               |
|  90 | 牙周SPA（无痛）洁牙         |
|  96 | 牙周SPA（无痛）             |
| 109 | 牙周SPA（无痛）             |
| 111 | 牙周SPA（无痛洁牙）         |
| 115 | 牙周SPA（无痛洁牙）         |
| 118 | 牙周SPA（无痛洁牙）         |
| 122 | 牙周SPA（无痛洁牙）         |
| 123 | 牙周SPA（无痛）洁牙         |
| 124 | 牙周SPA（无痛）洁牙         |
| 178 | 商品名称A                   |
+-----+-----------------------------+
13 rows in set (0.03 sec)

mysql> select id, name from ss_platform_goods where instr(name, 'A') > 0;
+-----+-----------------------------+
| id  | name                        |
+-----+-----------------------------+
|  45 | stutas                      |
|  68 | 种植牙（以色列ABT）媲美真牙 |
|  82 | 牙周SPA(无痛)               |
|  90 | 牙周SPA（无痛）洁牙         |
|  96 | 牙周SPA（无痛）             |
| 109 | 牙周SPA（无痛）             |
| 111 | 牙周SPA（无痛洁牙）         |
| 115 | 牙周SPA（无痛洁牙）         |
| 118 | 牙周SPA（无痛洁牙）         |
| 122 | 牙周SPA（无痛洁牙）         |
| 123 | 牙周SPA（无痛）洁牙         |
| 124 | 牙周SPA（无痛）洁牙         |
| 178 | 商品名称A                   |
+-----+-----------------------------+
13 rows in set (0.03 sec)

#instr搜索结果不区分大小写
mysql> select id, name from ss_platform_goods where instr(name, 'a') > 0;
+-----+-----------------------------+
| id  | name                        |
+-----+-----------------------------+
|  45 | stutas                      |
|  68 | 种植牙（以色列ABT）媲美真牙 |
|  82 | 牙周SPA(无痛)               |
|  90 | 牙周SPA（无痛）洁牙         |
|  96 | 牙周SPA（无痛）             |
| 109 | 牙周SPA（无痛）             |
| 111 | 牙周SPA（无痛洁牙）         |
| 115 | 牙周SPA（无痛洁牙）         |
| 118 | 牙周SPA（无痛洁牙）         |
| 122 | 牙周SPA（无痛洁牙）         |
| 123 | 牙周SPA（无痛）洁牙         |
| 124 | 牙周SPA（无痛）洁牙         |
| 178 | 商品名称A                   |
+-----+-----------------------------+
13 rows in set (0.03 sec)

#instr区分大小写查询
mysql> select id, name from ss_platform_goods where instr(name, BINARY 'A') > 0;       
+-----+-----------------------------+                                                  
| id  | name                        |                                                  
+-----+-----------------------------+                                                  
|  68 | 种植牙（以色列ABT）媲美真牙 |                                                              
|  82 | 牙周SPA(无痛)               |                                                      
|  90 | 牙周SPA（无痛）洁牙         |                                                          
|  96 | 牙周SPA（无痛）             |                                                        
| 109 | 牙周SPA（无痛）             |                                                        
| 111 | 牙周SPA（无痛洁牙）         |                                                          
| 115 | 牙周SPA（无痛洁牙）         |                                                          
| 118 | 牙周SPA（无痛洁牙）         |                                                          
| 122 | 牙周SPA（无痛洁牙）         |                                                          
| 123 | 牙周SPA（无痛）洁牙         |                                                          
| 124 | 牙周SPA（无痛）洁牙         |                                                          
| 178 | 商品名称A                   |                                                      
+-----+-----------------------------+                                                  
12 rows in set (0.03 sec)

mysql> explain select id, name from ss_platform_goods where instr(name, BINARY 'A') > 0;
+----+-------------+-------------------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table             | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------------------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | ss_platform_goods | NULL       | ALL  | NULL          | NULL | NULL    | NULL |  155 |   100.00 | Using where |
+----+-------------+-------------------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.03 sec)

mysql> explain select id, name from ss_platform_goods where name like '%A%';
+----+-------------+-------------------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table             | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------------------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | ss_platform_goods | NULL       | ALL  | NULL          | NULL | NULL    | NULL |  155 |    11.11 | Using where |
+----+-------------+-------------------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.03 sec)

reference:
https://www.yiibai.com/mysql/instr.html
http://blog.sina.com.cn/s/blog_55d57a4601015rzl.html
