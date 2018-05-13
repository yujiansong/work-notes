
mysql基础

#distinct	去重，查询得到结果中重复的记录去掉。
mysql> select distinct clinic_id from test_patient;
+-----------+
| clinic_id |
+-----------+
|         3 |
|        11 |
|        35 |
|        10 |
+-----------+
4 rows in set (0.03 sec)

2.	字段别名
语法
	字段名 【as】 字段别名
说明：
	在显示查询到得的结果时，以指定的别名代替。

mysql> select name as 诊所 from ss_clinic_info;
+----------------------------+
| 诊所                           |
+----------------------------+
| 外网新深圳诊所口腔                          |
| 窦英口腔诊所                         |
| 王冬梅口腔诊所                         |
| 山西众植齿科医院有限公司                    |
| 光宇口腔（星博雅）诊所                        |
| 星范美齿中心                          |
| 太原化建挚成口腔门诊部                     |
| 皓久口腔万柏林四季花园诊所                       |
| 皓久口腔小店大都会诊所                        |
| 真美口腔门诊部                         |
| 善爱口腔门诊部                        |
| 固齿堂口腔诊所                        |


子查询数据源
数据来源是一个select语句，
语法：
	select 字段列表 from (select 语句)  【as】 别名;
说明：
	select语句得到结果也是一个表，但是这个表位于内存中，想使用必须起一个别名。

mysql> select id, name from (select * from ss_clinic_info) as clinic;
+----+----------------------------+
| id | name                       |
+----+----------------------------+
|  3 | 外网新深圳诊所口腔                          |
| 10 | 窦英口腔诊所                         |
| 11 | 王冬梅口腔诊所                         |
| 12 | 山西众植齿科医院有限公司                    |
| 13 | 光宇口腔（星博雅）诊所                        |
| 14 | 星范美齿中心                          |
| 15 | 太原化建挚成口腔门诊部                     |
| 16 | 皓久口腔万柏林四季花园诊所                       |
| 17 | 皓久口腔小店大都会诊所                        |
| 18 | 真美口腔门诊部                         |
| 19 | 善爱口腔门诊部                        |
| 21 | 固齿堂口腔诊所                        |
| 22 | 新月口腔                         |
| 23 | 杨金锋口腔诊所                          |
| 24 | 皓仁口腔诊所                         |
| 25 | 刘斌口腔诊所                          |
| 26 | 齐雅口腔门诊部                        |
| 27 | 安康口腔                          |
| 28 | 美佳口腔                         |
| 29 | 刘贵锁口腔诊所                          |
| 30 | 恒仁堂口腔                         |
| 31 | 礼万口腔                          |
| 32 | 精益齿科                          |
| 33 | ui测试                         |
| 34 | 万豪口腔门诊部                         |
| 35 | 牙牙乐口腔管理                         |
+----+----------------------------+
26 rows in set (0.03 sec)

mysql> select id, name, addr from (select * from ss_clinic_info) clinic;
+----+----------------------------+--------------------------------------------+
| id | name                       | addr                                       |
+----+----------------------------+--------------------------------------------+
|  3 | 外网新深圳诊所口腔                          | 高新区泰邦科技大厦17G啊啊                                      |
| 10 | 窦英口腔诊所                         | 河苑小区一期2号楼1层2号店                                   |
| 11 | 王冬梅口腔诊所                         | 和平南路150号50号楼底商9、10号                                |
| 12 | 山西众植齿科医院有限公司                    | 体育路与许坦西街交叉口（开元市场美特好旁）
        |
| 13 | 光宇口腔（星博雅）诊所                        | 菜园东街2号一层西起34号                                      |
| 14 | 星范美齿中心                          | 平阳路锦绣江山二号小区二号楼二层                                    |
| 15 | 太原化建挚成口腔门诊部                     | 和平南路万科蓝山11#1003号                                 |
| 16 | 皓久口腔万柏林四季花园诊所                       | 千峰南路168号10幢1层商铺4号                                  |
| 17 | 皓久口腔小店大都会诊所                        | 平阳路65号平阳景苑B区16幢2单元302号                             |
| 18 | 真美口腔门诊部                         | 小店街道康宁东街万豪明珠(康宁雅苑西)
|
| 19 | 善爱口腔门诊部                        | 太原市迎泽区朝阳街48号                                      |


5.	group by子句
语法：
	group by 字段1,字段2….
说明：
	group by 对where子句得到的结果再按group by 后的字段列表进行分组统计。
	group by重点在于统计每一个数据。
group by的执行原理：
示例：
mysql> select clinic_id, count(*) 诊所人数 from test_patient group by clinic_id;          
+-----------+----------+                                                              
| clinic_id | 诊所人数         |                                                          
+-----------+----------+                                                              
|         3 |       68 |                                                              
|        10 |        1 |                                                              
|        11 |        1 |                                                              
|        35 |       59 |                                                              
+-----------+----------+                                                              
4 rows in set (0.03 sec)  

当前诊所人数
mysql> select clinic_id, count(*) as 诊所人数 from test_patient group by clinic_id;
+-----------+----------+
| clinic_id | 诊所人数         |
+-----------+----------+
|         3 |       68 |
|        10 |        1 |
|        11 |        1 |
|        35 |       59 |
+-----------+----------+
4 rows in set (0.03 sec)

mysql> select p.clinic_id, c.name, count(p.id) as 诊所人数 from test_patient as p left join ss_clinic_info as c on p.clini
c_id = c.id group by p.clinic_id;
+-----------+--------------------+----------+
| clinic_id | name               | 诊所人数         |
+-----------+--------------------+----------+
|         3 | 外网新深圳诊所口腔                  |       68 |
|        10 | 窦英口腔诊所                 |        1 |
|        11 | 王冬梅口腔诊所                 |        1 |
|        35 | 牙牙乐口腔管理                 |       59 |
+-----------+--------------------+----------+
4 rows in set (0.03 sec)

#按诊所人数降序排序
mysql> select clinic_id, count(*) as numbers from test_patient group by clinic_id order by numbers desc;
+-----------+---------+
| clinic_id | numbers |
+-----------+---------+
|         3 |      68 |
|        35 |      59 |
|        10 |       1 |
|        11 |       1 |
+-----------+---------+
4 rows in set (0.05 sec)                                                            

mysql> select p.clinic_id, c.name, count(p.id) as 诊所人数 from test_patient as p left join ss_clinic_info as c on p.clini
c_id = c.id group by p.clinic_id order by count(p.id) desc;
+-----------+--------------------+----------+
| clinic_id | name               | 诊所人数         |
+-----------+--------------------+----------+
|         3 | 外网新深圳诊所口腔                  |       68 |
|        35 | 牙牙乐口腔管理                 |       59 |
|        10 | 窦英口腔诊所                 |        1 |
|        11 | 王冬梅口腔诊所                 |        1 |
+-----------+--------------------+----------+
4 rows in set (0.03 sec)


(聚合)统计函数
count		统计记录数
语法：
	count(*|字段名)
说明：
	count(*)			表示统计记录数
	count(字段名)		表示统计记录数，不会统计null值的记录
示例：count(*)
mysql> select clinic_id, count(*) as 预约人数 from test_dia group by clinic_id;
+-----------+----------+
| clinic_id | 预约人数       |
+-----------+----------+
|         3 |       98 |
|        10 |        1 |
|        12 |        1 |
|        14 |        1 |
|        16 |        2 |
|        23 |        1 |
|        30 |        1 |
|        32 |        1 |
|        33 |        2 |
|        34 |        2 |
|        35 |      135 |
+-----------+----------+
11 rows in set (0.03 sec)

max		统计最大值
语法:
	max(字段名)
说明：
	统计指定的列中的最大值。

min		统计最小值
示例：
mysql> -- 查看每一个诊所中应收金额最多的一个账单
mysql> select id, clinic_id, max(actual_amount) from ss_bills group by clinic_id;
+----+-----------+--------------------+
| id | clinic_id | max(actual_amount) |
+----+-----------+--------------------+
|  1 |         3 |           31000.00 |
|  5 |        35 |            7200.00 |
+----+-----------+--------------------+
2 rows in set (0.05 sec)

mysql> -- 查询每一个诊所中收费金额最低的一次账单
mysql> select id, clinic_id, min(actual_amount) as 费用 from ss_bills group by clinic_id;
+----+-----------+-------+
| id | clinic_id | 费用      |
+----+-----------+-------+
|  1 |         3 |  0.00 |
|  5 |        35 | 50.00 |
+----+-----------+-------+
2 rows in set (0.03 sec)

mysql> -- 查询每一个诊所平均收费金额
mysql> select id, clinic_id, avg(actual_amount) as 平均收费 from ss_bills group by clinic_id;
+----+-----------+-------------+
| id | clinic_id | 平均收费          |
+----+-----------+-------------+
|  1 |         3 | 1936.395417 |
|  5 |        35 | 1312.779500 |
+----+-----------+-------------+
2 rows in set (0.03 sec)

mysql> select id, clinic_id, count(patient_id) as 人数, avg(actual_amount) as 平均收费 from ss_bills group by clinic_id;
+----+-----------+------+-------------+
| id | clinic_id | 人数     | 平均收费          |
+----+-----------+------+-------------+
|  1 |         3 |   24 | 1936.395417 |
|  5 |        35 |   40 | 1312.779500 |
+----+-----------+------+-------------+
2 rows in set (0.03 sec)


-- 查出诊所名称
mysql> select b.id, b.clinic_id, c.name, count(b.patient_id) as 人数, avg(b.actual_amount) as 平均收费 from ss_bills as b
 left join ss_clinic_info as c on b.clinic_Id = c.id group by b.clinic_id;
+----+-----------+--------------------+------+-------------+
| id | clinic_id | name               | 人数     | 平均收费          |
+----+-----------+--------------------+------+-------------+
|  1 |         3 | 外网新深圳诊所口腔                  |   24 | 1936.395417 |
|  5 |        35 | 牙牙乐口腔管理                 |   40 | 1312.779500 |
+----+-----------+--------------------+------+-------------+
2 rows in set (0.03 sec)

mysql> select b.id, b.clinic_id, c.name as 诊所名称, b.patient_id, p.truename as 患者姓名, max(actual_amount) as 最高金额
from ss_bills as b left join ss_clinic_info as c on b.clinic_Id = c.id left join ss_patient as p on b.patient_id = p.id group by clinic_id;
+----+-----------+--------------------+------------+----------+----------+
| id | clinic_id | 诊所名称                   | patient_id | 患者姓名         | 最高金额        |
+----+-----------+--------------------+------------+----------+----------+
|  1 |         3 | 外网新深圳诊所口腔                  |          6 | 测试二        | 31000.00 |
|  5 |        35 | 牙牙乐口腔管理                 |         27 | 王传奇         |  7200.00 |
+----+-----------+--------------------+------------+----------+----------+
2 rows in set (0.05 sec)

sum		求和
语法：
	sum(字段名)
说明：
	求指定字段的和
示例：
mysql> select id, clinic_id, sum(actual_amount) from ss_bills group by clinic_id;
+----+-----------+--------------------+
| id | clinic_id | sum(actual_amount) |
+----+-----------+--------------------+
|  1 |         3 |           46473.49 |
|  5 |        35 |           52511.18 |
+----+-----------+--------------------+
2 rows in set (0.05 sec)


当前时间
mysql> select now();
+---------------------+
| now()               |
+---------------------+
| 2018-05-13 00:16:40 |
+---------------------+
1 row in set (0.05 sec)

6.	多字段分组统计
如果group by后的字段是多个字段，那么会先按第1个字段划分大组，再在每个大组中，再按第2个字段划分小组。统计函数是应该在最小组的。
示例：

mysql> select clinic_id, patient_id, sum(actual_amount) as 总金额 from ss_bills where patient_id = (select patient_id from
 (select patient_id, count(*) as numbers from ss_bills group by patient_id order by numbers desc limit 1) as p);
+-----------+------------+----------+
| clinic_id | patient_id | 总金额        |
+-----------+------------+----------+
|        35 |         36 | 14700.00 |
+-----------+------------+----------+
1 row in set (0.03 sec)

mysql> select clinic_id, patient_id, sum(actual_amount) as 总金额 from ss_bills group by clinic_id, patient_id;
+-----------+------------+----------+
| clinic_id | patient_id | 总金额        |
+-----------+------------+----------+
|         3 |          5 |  1101.30 |
|         3 |          6 |  1700.00 |
|         3 |          8 | 31000.00 |
|         3 |         31 |   294.07 |
|         3 |         34 |  2778.00 |
|         3 |         35 |   678.00 |
|         3 |         44 |   737.00 |
|         3 |         83 |   266.25 |
|         3 |         95 |  1200.00 |
|         3 |         97 |  1401.30 |
|         3 |        101 |   400.00 |
|         3 |        103 |  2000.00 |
|         3 |        107 |  1467.59 |
|         3 |        110 |   466.23 |
|         3 |        120 |   400.02 |
|         3 |        126 |   583.73 |
|        35 |         27 |  2300.00 |
|        35 |         36 | 14700.00 |
|        35 |         38 |   400.02 |
|        35 |         39 | 15200.00 |
|        35 |         43 |  1200.00 |
|        35 |         70 |  1500.02 |
|        35 |         71 |    50.00 |
|        35 |         82 |   588.02 |
|        35 |         94 |  1200.02 |
|        35 |         96 |   400.00 |
|        35 |         99 |   800.00 |
|        35 |        100 |   200.00 |
|        35 |        104 |  1100.00 |
|        35 |        106 |  1300.00 |
|        35 |        108 |   123.02 |
|        35 |        109 |  7100.02 |
|        35 |        111 |  1200.04 |
|        35 |        119 |   500.00 |
|        35 |        123 |   450.00 |
|        35 |        128 |  1600.00 |
|        35 |        130 |   600.02 |
+-----------+------------+----------+
37 rows in set (0.03 sec)


mysql> select clinic_id, patient_id, sum(actual_amount) as 总金额 from ss_bills group by clinic_id, patient_id order by cl
inic_id desc, 总金额 desc;
+-----------+------------+----------+
| clinic_id | patient_id | 总金额        |
+-----------+------------+----------+
|        35 |         39 | 15200.00 |
|        35 |         36 | 14700.00 |
|        35 |        109 |  7100.02 |
|        35 |         27 |  2300.00 |
|        35 |        128 |  1600.00 |
|        35 |         70 |  1500.02 |
|        35 |        106 |  1300.00 |
|        35 |        111 |  1200.04 |
|        35 |         94 |  1200.02 |
|        35 |         43 |  1200.00 |
|        35 |        104 |  1100.00 |
|        35 |         99 |   800.00 |
|        35 |        130 |   600.02 |

回溯统计with rollup
	由于多字段分组，默认统计函数是对最小组进行统计，现实中有时不但需要对最小组进行统计，还需要对包含最小组的最大组再进行同样的统计。
示例：

mysql> select clinic_id, patient_id, sum(actual_amount) from ss_bills group by clinic_id, patient_id with rollup;
+-----------+------------+--------------------+
| clinic_id | patient_id | sum(actual_amount) |
+-----------+------------+--------------------+
|         3 |          5 |            1101.30 |
|         3 |          6 |            1700.00 |
|         3 |          8 |           31000.00 |
|         3 |         31 |             294.07 |
|         3 |         34 |            2778.00 |
|         3 |         35 |             678.00 |
|         3 |         44 |             737.00 |
|         3 |         83 |             266.25 |
|         3 |         95 |            1200.00 |
|         3 |         97 |            1401.30 |
|         3 |        101 |             400.00 |
|         3 |        103 |            2000.00 |
|         3 |        107 |            1467.59 |
|         3 |        110 |             466.23 |
|         3 |        120 |             400.02 |
|         3 |        126 |             583.73 |
|         3 |       NULL |           46473.49 |
|        35 |         27 |            2300.00 |
|        35 |         36 |           14700.00 |
|        35 |         38 |             400.02 |
|        35 |         39 |           15200.00 |
|        35 |         43 |            1200.00 |
|        35 |         70 |            1500.02 |
|        35 |         71 |              50.00 |
|        35 |         82 |             588.02 |
|        35 |         94 |            1200.02 |
|        35 |         96 |             400.00 |
|        35 |         99 |             800.00 |
|        35 |        100 |             200.00 |
|        35 |        104 |            1100.00 |
|        35 |        106 |            1300.00 |
|        35 |        108 |             123.02 |
|        35 |        109 |            7100.02 |
|        35 |        111 |            1200.04 |
|        35 |        119 |             500.00 |
|        35 |        123 |             450.00 |
|        35 |        128 |            1600.00 |
|        35 |        130 |             600.02 |
|        35 |       NULL |           52511.18 |
|      NULL |       NULL |           98984.67 |
+-----------+------------+--------------------+
40 rows in set (0.03 sec)

having 子句
对group by得到的统计结果，再进行第2次筛选。
示例：
mysql> select clinic_id, patient_id, count(patient_id) as numbers from test_dia group by clinic_id, patient_id having numbers >= 5;
+-----------+------------+---------+
| clinic_id | patient_id | numbers |
+-----------+------------+---------+
|         3 |          0 |      27 |
|         3 |         17 |       5 |
|         3 |         83 |       6 |
|        35 |          0 |      61 |
|        35 |         36 |       6 |
|        35 |        109 |       8 |
+-----------+------------+---------+
6 rows in set (0.05 sec)

order by子句
语法：
	order by 字段1 【asc|desc】【,字段2 【asc|desc】】
说明：
mysql> select clinic_id, patient_id, count(patient_id) as numbers from test_dia group by clinic_id, patient_id having numbers >= 5 order by numbers desc;
+-----------+------------+---------+
| clinic_id | patient_id | numbers |
+-----------+------------+---------+
|        35 |          0 |      61 |
|         3 |          0 |      27 |
|        35 |        109 |       8 |
|         3 |         83 |       6 |
|        35 |         36 |       6 |
|         3 |         17 |       5 |
+-----------+------------+---------+
6 rows in set (0.03 sec)

#多字段进行排序
mysql> select clinic_id, patient_id, count(patient_id) as numbers from test_dia group by clinic_id, patient_id having numbers >= 5 order by clinic_id desc, numbers desc;
+-----------+------------+---------+
| clinic_id | patient_id | numbers |
+-----------+------------+---------+
|        35 |          0 |      61 |
|        35 |        109 |       8 |
|        35 |         36 |       6 |
|         3 |          0 |      27 |
|         3 |         83 |       6 |
|         3 |         17 |       5 |
+-----------+------------+---------+
6 rows in set (0.03 sec)

mysql> select clinic_id, patient_id, count(patient_id) as numbers from test_dia group by clinic_id, patient_id having numbers >= 5 order by clinic_id desc, patient_id desc, numbers desc;
+-----------+------------+---------+
| clinic_id | patient_id | numbers |
+-----------+------------+---------+
|        35 |        109 |       8 |
|        35 |         36 |       6 |
|        35 |          0 |      61 |
|         3 |         83 |       6 |
|         3 |         17 |       5 |
|         3 |          0 |      27 |
+-----------+------------+---------+
6 rows in set (0.03 sec)

mysql> select clinic_id, patient_id, sum(actual_amount) as money from ss_bills group by clinic_id, patient_id having money > 5000;
+-----------+------------+----------+
| clinic_id | patient_id | money    |
+-----------+------------+----------+
|         3 |          8 | 31000.00 |
|        35 |         36 | 14700.00 |
|        35 |         39 | 15200.00 |
|        35 |        109 |  7100.02 |
+-----------+------------+----------+
4 rows in set (0.03 sec)

mysql> select clinic_id, patient_id, sum(actual_amount) as money from ss_bills group by clinic_id, patient_id having money > 5000 order by clinic_id asc, patient_id desc, money desc;
+-----------+------------+----------+
| clinic_id | patient_id | money    |
+-----------+------------+----------+
|         3 |          8 | 31000.00 |
|        35 |        109 |  7100.02 |
|        35 |         39 | 15200.00 |
|        35 |         36 | 14700.00 |
+-----------+------------+----------+
4 rows in set (0.03 sec)

limit子句
语法：
	limit 【offset,】rows
说明：
	对最终的结果进行显示条数的控制。
	offset表示是偏移量，可省略，如果省略表示0，表示结果中的第1表
	rows表示从指的偏移量开始显示rows条记录
示例：
mysql> select clinic_id, patient_id, sum(actual_amount) as money from ss_bills group by clinic_id, patient_id having money > 5000 order by clinic_id asc, patient_id desc, money desc limit 3;
+-----------+------------+----------+
| clinic_id | patient_id | money    |
+-----------+------------+----------+
|         3 |          8 | 31000.00 |
|        35 |        109 |  7100.02 |
|        35 |         39 | 15200.00 |
+-----------+------------+----------+
3 rows in set (0.03 sec)

mysql> select clinic_id, patient_id, sum(actual_amount) as money from ss_bills where patient_id <= 100 group by clinic_id, patient_id having money >= 5000 order by clinic_id asc, patient_id desc, money desc;
+-----------+------------+----------+
| clinic_id | patient_id | money    |
+-----------+------------+----------+
|         3 |          8 | 31000.00 |
|        35 |         39 | 15200.00 |
|        35 |         36 | 14700.00 |
+-----------+------------+----------+
3 rows in set (0.05 sec)

mysql> select clinic_id, patient_id, sum(actual_amount) as money from ss_bills where patient_id <= 100 group by clinic_id, patient_id having money >= 5000 order by clinic_id asc, patient_id desc, money desc limit 2;
+-----------+------------+----------+
| clinic_id | patient_id | money    |
+-----------+------------+----------+
|         3 |          8 | 31000.00 |
|        35 |         39 | 15200.00 |
+-----------+------------+----------+
2 rows in set (0.03 sec)

mysql> select clinic_id, patient_id, sum(actual_amount) as money from ss_bills where patient_id <= 100 group by clinic_id, patient_id having money >= 5000 order by clinic_id asc, patient_id desc, money desc limit 0, 1;
+-----------+------------+----------+
| clinic_id | patient_id | money    |
+-----------+------------+----------+
|         3 |          8 | 31000.00 |
+-----------+------------+----------+
1 row in set (0.05 sec)

作用：
	用于实现数据的分页。
通用的数据分页的公式：
每一页多少行：	rows			人为规定
当前页：		curPage		用户点击第几页就是几
limit (curPage-1)*rows,rows;

mysql> select id, truename from ss_patient limit 10,10;
+----+----------+
| id | truename |
+----+----------+
| 11 | 哈哈         |
| 12 | 测试53       |
| 13 | 谷雨         |
| 15 | 小尘        |
| 16 | 白开水       |
| 17 | 黑键盘02      |
| 18 | 张三         |
| 19 | 张三         |
| 20 | 黑键盘01      |
| 21 | 白浅        |
+----+----------+
10 rows in set (0.03 sec)


二、	联合查询
语法：
	select 语句
	union 【all|distinct】
	select 语句;
说明：
	主要用于数据分表存储，联合查询。
	对一个表的不同部分进行不同的操作。
	两条sql得到字段数要一致，只是在记录数上进行叠加
	【all|distinct】union选项

mysql> (select clinic_id, actual_amount from ss_bills where clinic_id = 35 and actual_amount > 1000 order by actual_amount desc limit 99999)
    -> union
    -> (select clinic_id, actual_amount from ss_bills where clinic_id = 3 and actual_amount > 1000 order by actual_amount desc limit 99999);
+-----------+---------------+
| clinic_id | actual_amount |
+-----------+---------------+
|        35 |       7200.00 |
|        35 |       6800.00 |
|        35 |       1200.00 |
|        35 |       1100.02 |
|        35 |       1100.00 |
|         3 |      31000.00 |
|         3 |       1700.00 |
|         3 |       1301.34 |
|         3 |       1101.30 |
|         3 |       1100.00 |
+-----------+---------------+
10 rows in set (0.03 sec)

查看MySQL支持的存储引擎
语法：
	show engines;
示例：

三、	存储引擎
现实中汽车引擎是发动机，作用是用于驱动汽车运行的。
MySQL存储引擎是驱动，数据的读写的。
示例：
myisam:
    .frm		表的结构文件
	.MyD	    表的数据文件
	.MyI		表的索引文件
	
	不支持事务与外键

innodb:
只会创建一个表结构文件 .frm
数据文件与索引文件保存在data目录的ibdata1文件中，默认情况所有的innodb存储引擎的数据都使用1个文件保存数据与索引。