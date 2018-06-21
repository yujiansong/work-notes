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

