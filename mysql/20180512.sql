
mysql����

#distinct	ȥ�أ���ѯ�õ�������ظ��ļ�¼ȥ����
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

2.	�ֶα���
�﷨
	�ֶ��� ��as�� �ֶα���
˵����
	����ʾ��ѯ���õĽ��ʱ����ָ���ı������档

mysql> select name as ���� from ss_clinic_info;
+----------------------------+
| ����                           |
+----------------------------+
| ����������������ǻ                          |
| �Ӣ��ǻ����                         |
| ����÷��ǻ����                         |
| ɽ����ֲ�ݿ�ҽԺ���޹�˾                    |
| �����ǻ���ǲ��ţ�����                        |
| �Ƿ���������                          |
| ̫ԭ����ֿ�ɿ�ǻ���ﲿ                     |
| �ÿ�ǻ������ļ���԰����                       |
| �ÿ�ǻС��󶼻�����                        |
| ������ǻ���ﲿ                         |
| �ư���ǻ���ﲿ                        |
| �̳��ÿ�ǻ����                        |


�Ӳ�ѯ����Դ
������Դ��һ��select��䣬
�﷨��
	select �ֶ��б� from (select ���)  ��as�� ����;
˵����
	select���õ����Ҳ��һ�������������λ���ڴ��У���ʹ�ñ�����һ��������

mysql> select id, name from (select * from ss_clinic_info) as clinic;
+----+----------------------------+
| id | name                       |
+----+----------------------------+
|  3 | ����������������ǻ                          |
| 10 | �Ӣ��ǻ����                         |
| 11 | ����÷��ǻ����                         |
| 12 | ɽ����ֲ�ݿ�ҽԺ���޹�˾                    |
| 13 | �����ǻ���ǲ��ţ�����                        |
| 14 | �Ƿ���������                          |
| 15 | ̫ԭ����ֿ�ɿ�ǻ���ﲿ                     |
| 16 | �ÿ�ǻ������ļ���԰����                       |
| 17 | �ÿ�ǻС��󶼻�����                        |
| 18 | ������ǻ���ﲿ                         |
| 19 | �ư���ǻ���ﲿ                        |
| 21 | �̳��ÿ�ǻ����                        |
| 22 | ���¿�ǻ                         |
| 23 | �����ǻ����                          |
| 24 | ��ʿ�ǻ����                         |
| 25 | �����ǻ����                          |
| 26 | ���ſ�ǻ���ﲿ                        |
| 27 | ������ǻ                          |
| 28 | ���ѿ�ǻ                         |
| 29 | ��������ǻ����                          |
| 30 | �����ÿ�ǻ                         |
| 31 | �����ǻ                          |
| 32 | ����ݿ�                          |
| 33 | ui����                         |
| 34 | �����ǻ���ﲿ                         |
| 35 | �����ֿ�ǻ����                         |
+----+----------------------------+
26 rows in set (0.03 sec)

mysql> select id, name, addr from (select * from ss_clinic_info) clinic;
+----+----------------------------+--------------------------------------------+
| id | name                       | addr                                       |
+----+----------------------------+--------------------------------------------+
|  3 | ����������������ǻ                          | ������̩��Ƽ�����17G����                                      |
| 10 | �Ӣ��ǻ����                         | ��ԷС��һ��2��¥1��2�ŵ�                                   |
| 11 | ����÷��ǻ����                         | ��ƽ��·150��50��¥����9��10��                                |
| 12 | ɽ����ֲ�ݿ�ҽԺ���޹�˾                    | ����·����̹���ֽ���ڣ���Ԫ�г����غ��ԣ�
        |
| 13 | �����ǻ���ǲ��ţ�����                        | ��԰����2��һ������34��                                      |
| 14 | �Ƿ���������                          | ƽ��·���彭ɽ����С������¥����                                    |
| 15 | ̫ԭ����ֿ�ɿ�ǻ���ﲿ                     | ��ƽ��·�����ɽ11#1003��                                 |
| 16 | �ÿ�ǻ������ļ���԰����                       | ǧ����·168��10��1������4��                                  |
| 17 | �ÿ�ǻС��󶼻�����                        | ƽ��·65��ƽ����ԷB��16��2��Ԫ302��                             |
| 18 | ������ǻ���ﲿ                         | С��ֵ����������������(������Է��)
|
| 19 | �ư���ǻ���ﲿ                        | ̫ԭ��ӭ����������48��                                      |


5.	group by�Ӿ�
�﷨��
	group by �ֶ�1,�ֶ�2��.
˵����
	group by ��where�Ӿ�õ��Ľ���ٰ�group by ����ֶ��б���з���ͳ�ơ�
	group by�ص�����ͳ��ÿһ�����ݡ�
group by��ִ��ԭ��
ʾ����
mysql> select clinic_id, count(*) �������� from test_patient group by clinic_id;          
+-----------+----------+                                                              
| clinic_id | ��������         |                                                          
+-----------+----------+                                                              
|         3 |       68 |                                                              
|        10 |        1 |                                                              
|        11 |        1 |                                                              
|        35 |       59 |                                                              
+-----------+----------+                                                              
4 rows in set (0.03 sec)  

��ǰ��������
mysql> select clinic_id, count(*) as �������� from test_patient group by clinic_id;
+-----------+----------+
| clinic_id | ��������         |
+-----------+----------+
|         3 |       68 |
|        10 |        1 |
|        11 |        1 |
|        35 |       59 |
+-----------+----------+
4 rows in set (0.03 sec)

mysql> select p.clinic_id, c.name, count(p.id) as �������� from test_patient as p left join ss_clinic_info as c on p.clini
c_id = c.id group by p.clinic_id;
+-----------+--------------------+----------+
| clinic_id | name               | ��������         |
+-----------+--------------------+----------+
|         3 | ����������������ǻ                  |       68 |
|        10 | �Ӣ��ǻ����                 |        1 |
|        11 | ����÷��ǻ����                 |        1 |
|        35 | �����ֿ�ǻ����                 |       59 |
+-----------+--------------------+----------+
4 rows in set (0.03 sec)

#������������������
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

mysql> select p.clinic_id, c.name, count(p.id) as �������� from test_patient as p left join ss_clinic_info as c on p.clini
c_id = c.id group by p.clinic_id order by count(p.id) desc;
+-----------+--------------------+----------+
| clinic_id | name               | ��������         |
+-----------+--------------------+----------+
|         3 | ����������������ǻ                  |       68 |
|        35 | �����ֿ�ǻ����                 |       59 |
|        10 | �Ӣ��ǻ����                 |        1 |
|        11 | ����÷��ǻ����                 |        1 |
+-----------+--------------------+----------+
4 rows in set (0.03 sec)


(�ۺ�)ͳ�ƺ���
count		ͳ�Ƽ�¼��
�﷨��
	count(*|�ֶ���)
˵����
	count(*)			��ʾͳ�Ƽ�¼��
	count(�ֶ���)		��ʾͳ�Ƽ�¼��������ͳ��nullֵ�ļ�¼
ʾ����count(*)
mysql> select clinic_id, count(*) as ԤԼ���� from test_dia group by clinic_id;
+-----------+----------+
| clinic_id | ԤԼ����       |
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

max		ͳ�����ֵ
�﷨:
	max(�ֶ���)
˵����
	ͳ��ָ�������е����ֵ��

min		ͳ����Сֵ
ʾ����
mysql> -- �鿴ÿһ��������Ӧ�ս������һ���˵�
mysql> select id, clinic_id, max(actual_amount) from ss_bills group by clinic_id;
+----+-----------+--------------------+
| id | clinic_id | max(actual_amount) |
+----+-----------+--------------------+
|  1 |         3 |           31000.00 |
|  5 |        35 |            7200.00 |
+----+-----------+--------------------+
2 rows in set (0.05 sec)

mysql> -- ��ѯÿһ���������շѽ����͵�һ���˵�
mysql> select id, clinic_id, min(actual_amount) as ���� from ss_bills group by clinic_id;
+----+-----------+-------+
| id | clinic_id | ����      |
+----+-----------+-------+
|  1 |         3 |  0.00 |
|  5 |        35 | 50.00 |
+----+-----------+-------+
2 rows in set (0.03 sec)

mysql> -- ��ѯÿһ������ƽ���շѽ��
mysql> select id, clinic_id, avg(actual_amount) as ƽ���շ� from ss_bills group by clinic_id;
+----+-----------+-------------+
| id | clinic_id | ƽ���շ�          |
+----+-----------+-------------+
|  1 |         3 | 1936.395417 |
|  5 |        35 | 1312.779500 |
+----+-----------+-------------+
2 rows in set (0.03 sec)

mysql> select id, clinic_id, count(patient_id) as ����, avg(actual_amount) as ƽ���շ� from ss_bills group by clinic_id;
+----+-----------+------+-------------+
| id | clinic_id | ����     | ƽ���շ�          |
+----+-----------+------+-------------+
|  1 |         3 |   24 | 1936.395417 |
|  5 |        35 |   40 | 1312.779500 |
+----+-----------+------+-------------+
2 rows in set (0.03 sec)


-- �����������
mysql> select b.id, b.clinic_id, c.name, count(b.patient_id) as ����, avg(b.actual_amount) as ƽ���շ� from ss_bills as b
 left join ss_clinic_info as c on b.clinic_Id = c.id group by b.clinic_id;
+----+-----------+--------------------+------+-------------+
| id | clinic_id | name               | ����     | ƽ���շ�          |
+----+-----------+--------------------+------+-------------+
|  1 |         3 | ����������������ǻ                  |   24 | 1936.395417 |
|  5 |        35 | �����ֿ�ǻ����                 |   40 | 1312.779500 |
+----+-----------+--------------------+------+-------------+
2 rows in set (0.03 sec)

mysql> select b.id, b.clinic_id, c.name as ��������, b.patient_id, p.truename as ��������, max(actual_amount) as ��߽��
from ss_bills as b left join ss_clinic_info as c on b.clinic_Id = c.id left join ss_patient as p on b.patient_id = p.id group by clinic_id;
+----+-----------+--------------------+------------+----------+----------+
| id | clinic_id | ��������                   | patient_id | ��������         | ��߽��        |
+----+-----------+--------------------+------------+----------+----------+
|  1 |         3 | ����������������ǻ                  |          6 | ���Զ�        | 31000.00 |
|  5 |        35 | �����ֿ�ǻ����                 |         27 | ������         |  7200.00 |
+----+-----------+--------------------+------------+----------+----------+
2 rows in set (0.05 sec)

sum		���
�﷨��
	sum(�ֶ���)
˵����
	��ָ���ֶεĺ�
ʾ����
mysql> select id, clinic_id, sum(actual_amount) from ss_bills group by clinic_id;
+----+-----------+--------------------+
| id | clinic_id | sum(actual_amount) |
+----+-----------+--------------------+
|  1 |         3 |           46473.49 |
|  5 |        35 |           52511.18 |
+----+-----------+--------------------+
2 rows in set (0.05 sec)


��ǰʱ��
mysql> select now();
+---------------------+
| now()               |
+---------------------+
| 2018-05-13 00:16:40 |
+---------------------+
1 row in set (0.05 sec)

6.	���ֶη���ͳ��
���group by����ֶ��Ƕ���ֶΣ���ô���Ȱ���1���ֶλ��ִ��飬����ÿ�������У��ٰ���2���ֶλ���С�顣ͳ�ƺ�����Ӧ������С��ġ�
ʾ����

mysql> select clinic_id, patient_id, sum(actual_amount) as �ܽ�� from ss_bills where patient_id = (select patient_id from
 (select patient_id, count(*) as numbers from ss_bills group by patient_id order by numbers desc limit 1) as p);
+-----------+------------+----------+
| clinic_id | patient_id | �ܽ��        |
+-----------+------------+----------+
|        35 |         36 | 14700.00 |
+-----------+------------+----------+
1 row in set (0.03 sec)

mysql> select clinic_id, patient_id, sum(actual_amount) as �ܽ�� from ss_bills group by clinic_id, patient_id;
+-----------+------------+----------+
| clinic_id | patient_id | �ܽ��        |
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


mysql> select clinic_id, patient_id, sum(actual_amount) as �ܽ�� from ss_bills group by clinic_id, patient_id order by cl
inic_id desc, �ܽ�� desc;
+-----------+------------+----------+
| clinic_id | patient_id | �ܽ��        |
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

����ͳ��with rollup
	���ڶ��ֶη��飬Ĭ��ͳ�ƺ����Ƕ���С�����ͳ�ƣ���ʵ����ʱ������Ҫ����С�����ͳ�ƣ�����Ҫ�԰�����С���������ٽ���ͬ����ͳ�ơ�
ʾ����

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

having �Ӿ�
��group by�õ���ͳ�ƽ�����ٽ��е�2��ɸѡ��
ʾ����
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

order by�Ӿ�
�﷨��
	order by �ֶ�1 ��asc|desc����,�ֶ�2 ��asc|desc����
˵����
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

#���ֶν�������
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

limit�Ӿ�
�﷨��
	limit ��offset,��rows
˵����
	�����յĽ��������ʾ�����Ŀ��ơ�
	offset��ʾ��ƫ��������ʡ�ԣ����ʡ�Ա�ʾ0����ʾ����еĵ�1��
	rows��ʾ��ָ��ƫ������ʼ��ʾrows����¼
ʾ����
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

���ã�
	����ʵ�����ݵķ�ҳ��
ͨ�õ����ݷ�ҳ�Ĺ�ʽ��
ÿһҳ�����У�	rows			��Ϊ�涨
��ǰҳ��		curPage		�û�����ڼ�ҳ���Ǽ�
limit (curPage-1)*rows,rows;

mysql> select id, truename from ss_patient limit 10,10;
+----+----------+
| id | truename |
+----+----------+
| 11 | ����         |
| 12 | ����53       |
| 13 | ����         |
| 15 | С��        |
| 16 | �׿�ˮ       |
| 17 | �ڼ���02      |
| 18 | ����         |
| 19 | ����         |
| 20 | �ڼ���01      |
| 21 | ��ǳ        |
+----+----------+
10 rows in set (0.03 sec)


����	���ϲ�ѯ
�﷨��
	select ���
	union ��all|distinct��
	select ���;
˵����
	��Ҫ�������ݷֱ�洢�����ϲ�ѯ��
	��һ����Ĳ�ͬ���ֽ��в�ͬ�Ĳ�����
	����sql�õ��ֶ���Ҫһ�£�ֻ���ڼ�¼���Ͻ��е���
	��all|distinct��unionѡ��

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

�鿴MySQL֧�ֵĴ洢����
�﷨��
	show engines;
ʾ����

����	�洢����
��ʵ�����������Ƿ����������������������������еġ�
MySQL�洢���������������ݵĶ�д�ġ�
ʾ����
myisam:
    .frm		��Ľṹ�ļ�
	.MyD	    ��������ļ�
	.MyI		��������ļ�
	
	��֧�����������

innodb:
ֻ�ᴴ��һ����ṹ�ļ� .frm
�����ļ��������ļ�������dataĿ¼��ibdata1�ļ��У�Ĭ��������е�innodb�洢��������ݶ�ʹ��1���ļ�����������������