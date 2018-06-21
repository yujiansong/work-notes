<<<<<<< HEAD
#1.查询当前诊所预约人数 >= 10 人， 且排除clinic_id = 3, clinic_id = 35, 状态未取消， 按照预约人数进行降序排序显示前10个数据
mysql> select clinic_id, clinic_name, count(*) numbers from ss_diagnostic_appointment_wx where status <> 3 and clinic_id not in (3, 35) group by clinic_id having numbers >= 10 order by numbers desc limit 10;
+-----------+----------------------------------+---------+
| clinic_id | clinic_name                      | numbers |
+-----------+----------------------------------+---------+
|        28 | 美佳口腔                         |      26 |
|        15 | 太原化建挚成口腔门诊部           |      25 |
|        22 | 新月口腔                         |      23 |
|        43 | 太原小店博凡口腔门诊部           |      19 |
|        18 | 真美口腔门诊部                   |      17 |
|        67 | 太原（口腔医院）雅乐尔口腔门诊部 |      14 |
|        14 | 星范美齿中心                     |      14 |
|        76 | 佳明口腔                         |      13 |
|        25 | 刘斌口腔诊所                     |      13 |
|        74 | 恒月口腔                         |      12 |
+-----------+----------------------------------+---------+
10 rows in set (0.03 sec)

mysql> select clinic_id, clinic_name, count(*) numbers from ss_diagnostic_appointment_wx where status <> 3 and clinic_name not like '%test%' and clinic_name not like '%新深
圳%' group by clinic_id having numbers >= 10 order by numbers desc limit 10;
+-----------+----------------------------------+---------+
| clinic_id | clinic_name                      | numbers |
+-----------+----------------------------------+---------+
|        28 | 美佳口腔                         |      26 |
|        15 | 太原化建挚成口腔门诊部           |      25 |
|        22 | 新月口腔                         |      23 |
|        43 | 太原小店博凡口腔门诊部           |      19 |
|        18 | 真美口腔门诊部                   |      17 |
|        14 | 星范美齿中心                     |      14 |
|        67 | 太原（口腔医院）雅乐尔口腔门诊部 |      14 |
|        76 | 佳明口腔                         |      13 |
|        25 | 刘斌口腔诊所                     |      13 |
|        74 | 恒月口腔                         |      12 |
+-----------+----------------------------------+---------+
10 rows in set (0.03 sec)

#1.查询当前诊所预约人数 >= 10 人， 且排除clinic_name = test, clinic_id = 新深圳, 状态未取消， 按照预约人数进行降序排序，按clinic_id 升序显示前10个数据
mysql> select clinic_id, clinic_name, count(*) numbers from ss_diagnostic_appointment_wx where status <> 3 and clinic_name not like '%test%' and clinic_name not like '%新深
圳%' group by clinic_id having numbers >= 10 order by numbers desc ,clinic_id asc limit 10;
+-----------+----------------------------------+---------+
| clinic_id | clinic_name                      | numbers |
+-----------+----------------------------------+---------+
|        28 | 美佳口腔                         |      26 |
|        15 | 太原化建挚成口腔门诊部           |      25 |
|        22 | 新月口腔                         |      23 |
|        43 | 太原小店博凡口腔门诊部           |      19 |
|        18 | 真美口腔门诊部                   |      17 |
|        14 | 星范美齿中心                     |      14 |
|        67 | 太原（口腔医院）雅乐尔口腔门诊部 |      14 |
|        25 | 刘斌口腔诊所                     |      13 |
|        76 | 佳明口腔                         |      13 |
|        16 | 皓久口腔万柏林四季花园诊所       |      12 |
+-----------+----------------------------------+---------+
10 rows in set (0.03 sec)

#1.查询'2018-06-07 09:00' and '2018-06-07 18:00'且诊所名不是 %新深圳%， 状态未取消，按诊所进行分组的预约数量,且统计总数量
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx where create_time between '2018-06-07 09:00' and '2018-06-07 18:00' and clinic_name not like '%新深圳%' and status <> 3 group by clinic_id with rollup;
+-----------+------------------------+--------------+
| clinic_id | clinic_name            | appoints_num |
+-----------+------------------------+--------------+
|        19 | 善爱口腔门诊部         |            4 |
|        30 | 恒仁堂口腔             |            1 |
|        47 | 牛丽口腔               |            2 |
|        48 | 海林口腔               |            1 |
|        54 | 太原华美整形美容医院   |            1 |
|        55 | 太原艾美菲恩口腔门诊部 |            3 |
|        56 | 太原贞信口腔门诊部     |            1 |
|        65 | 张寿岩口腔             |            2 |
|        66 | 正太口腔               |            1 |
|        75 | 精华牙科               |            2 |
|        77 | 佳鑫口腔               |            2 |
|      NULL | 佳鑫口腔               |           20 |
+-----------+------------------------+--------------+
12 rows in set (0.03 sec)

#1.查询'2018-06-07 09:00' and '2018-06-07 18:00'且诊所名不是 %新深圳%， 状态未取消，按诊所进行分组的预约数量,且预约数大于 3
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx where create_time between '2018-06-07 09:00' and '2018-06-07 18:00' and clinic_name not like '%新深圳%' and status <> 3 group by clinic_id having appoints_num >= 3 order by appoints_num desc;
+-----------+------------------------+--------------+
| clinic_id | clinic_name            | appoints_num |
+-----------+------------------------+--------------+
|        19 | 善爱口腔门诊部         |            5 |
|        55 | 太原艾美菲恩口腔门诊部 |            3 |
+-----------+------------------------+--------------+
2 rows in set (0.05 sec)
=======

#1.按诊所排序并分组数据查询每个诊所的预约数量
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx group by clinic_id;
+-----------+----------------------------------+--------------+
| clinic_id | clinic_name                      | appoints_num |
+-----------+----------------------------------+--------------+
|         3 | 新深圳诊所口腔                                |           80 |
|        10 | 窦英口腔诊所                               |            6 |
|        11 | 王东梅口腔诊所                               |            7 |
|        13 | 光宇口腔（星博雅）诊所                              |            7 |
|        14 | 星范美齿中心小店平阳路店                             |           18 |
|        15 | 太原化建挚成口腔门诊部                           |           25 |
|        16 | 皓久口腔万柏林四季花园诊所                             |           12 |
|        17 | 皓久口腔大都会诊所                               |            4 |
|        18 | 真美口腔门诊部                               |           19 |
|        19 | 善爱口腔门诊部                              |            8 |
|        21 | 固齿堂口腔诊所                              |            2 |
|        22 | 新月口腔                               |           24 |
|        23 | 杨金锋口腔诊所                                |           13 |


#2.使用 with rollup 关键字，可以得到每个分组以及每个分组汇总级别（总预约数为701）
mysql> select clinic_id, clinic_name, count(*) as appoints_numg from ss_diagnostic_appointment_wx group by clinic_id with rollup;
+-----------+----------------------------------+---------------+
| clinic_id | clinic_name                      | appoints_numg |
+-----------+----------------------------------+---------------+
|         3 | 新深圳诊所口腔                                |            80 |
|        10 | 窦英口腔诊所                               |             6 |
|        11 | 王东梅口腔诊所                               |             7 |
|        82 | 西乡诊所1                                |             1 |
|      NULL | 西乡诊所1                                |           701 |
+-----------+----------------------------------+---------------+

mysql> select count(*) from ss_diagnostic_appointment_wx;
+----------+
| count(*) |
+----------+
|      701 |
+----------+

#按诊所排序并分组数据查询每个诊所的预约数量 并使用having 过滤 count(*) >= 20 的分组
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx group by clinic_id having count(*) >= 20;
+-----------+------------------------+--------------+
| clinic_id | clinic_name            | appoints_num |
+-----------+------------------------+--------------+
|         3 | 新深圳诊所口腔                      |           80 |
|        15 | 太原化建挚成口腔门诊部                 |           25 |
|        22 | 新月口腔                     |           24 |
|        28 | 美佳口腔                     |           33 |
|        43 | 太原小店博凡口腔门诊部                |           44 |
+-----------+------------------------+--------------+
5 rows in set (0.05 sec)

#这里where子句不起作用，因为过滤是基于分组聚集值而不是特定行值的
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx where count(*) >= 20 group by clinic_id;
ERROR 1111 (HY000): Invalid use of group function

#查询在'2018-06-06 09:00' and '2018-06-06 19:00' 时间内预约人数在3个以上的诊所
mysql> select clinic_id, clinic_name, count(*) from ss_diagnostic_appointment_wx where create_time between '2018-06-06 09:00' and '2018-06-06 19:00' group by clinic_id having count(*) >= 3;
+-----------+--------------------+----------+
| clinic_id | clinic_name        | count(*) |
+-----------+--------------------+----------+
|        45 | 海燕口腔                  |        3 |
|        71 | 恒瑞口腔                  |        5 |
|        78 | 太原世林口腔门诊部              |        3 |
+-----------+--------------------+----------+
3 rows in set (0.03 sec)

#查询在'2018-06-06 09:00' and '2018-06-06 19:00' 时间内各个诊所的预约人数及总预约人数
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx where create_time between '2018-06-06 09:00' and '2018-06-06 19:00' group by clinic_id with rollup;
+-----------+----------------------+--------------+
| clinic_id | clinic_name          | appoints_num |
+-----------+----------------------+--------------+
|         3 | 新深圳诊所口腔1111                |            2 |
|        19 | 善爱口腔门诊部                  |            1 |
|        30 | 恒仁堂口腔                   |            1 |
|        45 | 海燕口腔                    |            3 |
|        48 | 海林口腔                   |            1 |
|        66 | 正太口腔                   |            1 |
|        71 | 恒瑞口腔                    |            5 |
|        72 | 富力口腔                    |            1 |
|        73 | 智英口腔                   |            1 |
|        75 | 精华牙科                     |            1 |
|        76 | 佳明口腔                    |            2 |
|        78 | 太原世林口腔门诊部                |            3 |
|        79 | 太原优里卡口腔门诊部                |            1 |
|      NULL | 太原优里卡口腔门诊部                |           23 |
+-----------+----------------------+--------------+
14 rows in set (0.03 sec)

#在 having过滤后不可以使用 with rollup
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx where create_time between '2018-06-06 09:00' and '2018-06-06 19:00' group by clinic_id having appoints_num >= 3 with rollup;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'rollup' at line 1

#在 group by 后面才可以使用 with rollup
mysql> select clinic_id, clinic_name, count(*) as appoints_num from ss_diagnostic_appointment_wx where create_time between '2018-06-06 09:00' and '2018-06-06 19:00' group by clinic_id with rollup having appoints_num >= 3;
+-----------+----------------------+--------------+
| clinic_id | clinic_name          | appoints_num |
+-----------+----------------------+--------------+
|        45 | 海燕口腔                    |            3 |
|        71 | 恒瑞口腔                    |            5 |
|        78 | 太原世林口腔门诊部                |            3 |
|      NULL | 太原优里卡口腔门诊部                |           23 |
+-----------+----------------------+--------------+
4 rows in set (0.03 sec)


#查询诊所每个诊所的总金额且 大约 15000的诊所
mysql> select clinic_id, clinic_name, sum(product_num * dis_amount) as sum_amount from ss_weiapp_order group by clinic_id having sum(product_num * dis_amount) > 15000;
+-----------+----------------------------+------------+
| clinic_id | clinic_name                | sum_amount |
+-----------+----------------------------+------------+
|         3 | 新深圳诊所口腔                          |  103292.45 |
|        10 | 窦英口腔诊所                         |   22898.00 |
|        14 | 星范美齿中心                          |  223630.00 |
|        16 | 皓久口腔万柏林四季花园诊所                       |   22000.00 |
|        19 | 善爱口腔门诊部                        |   87256.00 |
|        22 | 新月口腔                         |   21950.00 |
|        24 | 皓仁口腔诊所                         |   39360.00 |
|        26 | 齐雅口腔门诊部                        |   41996.00 |
|        30 | 恒仁堂口腔                         |   23930.00 |
|        73 | 智英口腔                         |   60000.00 |
+-----------+----------------------------+------------+
10 rows in set (0.03 sec)


#查询诊所每个诊所的总金额（及所有诊所的总金额）且 大约 15000的诊所
mysql> select clinic_id, clinic_name, sum(product_num * dis_amount) as sum_amount from ss_weiapp_order group by clinic_id with rollup having sum_amount > 15000;
+-----------+----------------------------+------------+
| clinic_id | clinic_name                | sum_amount |
+-----------+----------------------------+------------+
|         3 | 新深圳诊所口腔                          |  103292.45 |
|        10 | 窦英口腔诊所                         |   22898.00 |
|        14 | 星范美齿中心                          |  223630.00 |
|        16 | 皓久口腔万柏林四季花园诊所                       |   22000.00 |
|        19 | 善爱口腔门诊部                        |   87256.00 |
|        22 | 新月口腔                         |   21950.00 |
|        24 | 皓仁口腔诊所                         |   39360.00 |
|        26 | 齐雅口腔门诊部                        |   41996.00 |
|        30 | 恒仁堂口腔                         |   23930.00 |
|        73 | 智英口腔                         |   60000.00 |
|      NULL | 智英口腔                         |  660970.45 |
+-----------+----------------------------+------------+
11 rows in set (0.03 sec)

#不能同时用 with rollup 和 order by
mysql> select clinic_id, clinic_name, sum(product_num * dis_amount) as sum_amount from ss_weiapp_order group by clinic_id with rollup having sum_amount > 15000 order by sum_amount;
ERROR 1221 (HY000): Incorrect usage of CUBE/ROLLUP and ORDER BY

mysql> select clinic_id, clinic_name, sum(product_num * dis_amount) as sum_amount from ss_weiapp_order group by clinic_id  having sum_amount > 15000 order by sum_amount;
+-----------+----------------------------+------------+
| clinic_id | clinic_name                | sum_amount |
+-----------+----------------------------+------------+
|        22 | 新月口腔                         |   21950.00 |
|        16 | 皓久口腔万柏林四季花园诊所                       |   22000.00 |
|        10 | 窦英口腔诊所                         |   22898.00 |
|        30 | 恒仁堂口腔                         |   23930.00 |
|        24 | 皓仁口腔诊所                         |   39360.00 |
|        26 | 齐雅口腔门诊部                        |   41996.00 |
|        73 | 智英口腔                         |   60000.00 |
|        19 | 善爱口腔门诊部                        |   87256.00 |
|         3 | 新深圳诊所口腔                          |  103292.45 |
|        14 | 星范美齿中心                          |  223630.00 |
+-----------+----------------------------+------------+
10 rows in set (0.03 sec)


