
#mysql基础
1.	外键概念
如果stu表中c_id字段的值，必须是class表中主键字段c_id的某1个值，那么stu表中的c_id就是外键。
	
	本质就是使用1个表的某一个字段强制约束另一个表中的字段的取值。

二、子查询
	一个查询语句中包含另一个查询语句，那么被包含的查询语句就是子查询。

1.	子查询分类
根据子查询的位置可以分为以下几类：
①、from子查询(数据源子查询\表子查询)
②、where子查询
③、exists子查询

根据子查询得到的结果可以分为以下几类：
1)		①、标量子查询
		得到结果是1行1列
使用的运算符是		=
示例：

mysql> select * from ss_bills where patient_id = (select id from ss_patient where clinic_id = 3 and truename = '王彦廷') \G;
*************************** 1. row ***************************
             id: 24
       bills_no: 201805090005
       order_id: 0
     patient_id: 83
        patient: 王彦廷
         mobile: 15645678956
      clinic_id: 3
     medical_no: YL1805025
          da_id: 175
bills_doctor_id: 4
 bills_nurse_id: 0
   charges_type: 1
   bills_amount: 266.25
       discount: 100
  actual_amount: 266.25
     pay_amount: 0.00
  refund_amount: 0.00
 arrears_amount: 266.25
         status: 1
  settle_status: -1
        da_time: 2018-05-09 17:06:11
    add_user_id: 4
         remark:
  cancel_remark: NULL
            num: 1
       add_time: 2018-05-09 17:06:26
1 row in set (0.78 sec)

2)		②、列子查询
		得到的结果是1列多行
		使用的运算符是 in

mysql> select distinct clinic_id from ss_bills where clinic_id in (select id from ss_clinic_info where status = 1);
+-----------+
| clinic_id |
+-----------+
|        35 |
|         3 |
+-----------+
2 rows in set (0.03 sec)

③、行子查询
		得到的结果是1行多列
示例：

mysql> select id from ss_patient_info where (province) = (select province from ss_patient_info where id = (select id from ss_patient where clinic_id = 3 and truename = '王彦廷'));
+----+
| id |
+----+
| 66 |
| 83 |
+----+

mysql> select c.id, c.name, p.id as patient_id from ss_clinic_info c left join ss_patient_info p on c.city = p.city and c.county = p.county where c.auth_status = 1 and c.name like '%口腔%' and p.id = 72;
+----+------------------------+------------+
| id | name                   | patient_id |
+----+------------------------+------------+
| 17 | 皓久口腔小店大都会诊所                    |         72 |
| 18 | 真美口腔门诊部                     |         72 |
| 22 | 新月口腔                     |         72 |
| 26 | 齐雅口腔门诊部                    |         72 |
| 34 | 万豪口腔门诊部                     |         72 |
+----+------------------------+------------+
5 rows in set (0.04 sec)


mysql> select c.id, c.name, c.addr, p.id as patient_id, patient.truename from ss_clinic_info c left join ss_patient_info p on c.city = p.city and c.county = p.county left join ss_patient as patient on patient.id = 72 where c.auth_status = 1 and c.name like '%口腔%' and p.id = 72 order by c.id desc limit 1 \G;
*************************** 1. row ***************************
        id: 34
      name: 万豪口腔门诊部
      addr: 真武路通达街口路西万豪广场1幢B区B107号
patient_id: 72
  truename: 运营人员新增新新新
1 row in set (0.03 sec)


mysql> select c.id, c.name, s.province, s.country, s.name, c.addr, p.id as patient_id, patient.truename from ss_clinic_info c left join ss_patient_info p on c.city = p.city and c.county = p.county left join ss_patient as patient on patient.id = 72 left join ss_area as s on s.id = c.county where c.auth_status = 1 and c.name like '%口腔%' and p.id = 72 order by c.id
 desc limit 1 \G;
*************************** 1. row ***************************
        id: 34
      name: 万豪口腔门诊部
  province: 山西省
   country: 太原市
      name: 小店区
      addr: 真武路通达街口路西万豪广场1幢B区B107号
patient_id: 72
  truename: 运营人员新增新新新
1 row in set (0.03 sec)


提示：
①、②、③是where子查询，这种查询是出现在的where的表达式中。
	where表达式的形式就是字段名与值的匹配，根据字段名与值个数。可以有以下形式
	
等值比较
    1个字段名 =  1个字段值
	1个字段名 in  (n个字段值)
	(字段1,字段2) = (值1,值2)

	子查询的书写技巧：先写你最终想得到的那个查询，再将另一个查询作为这个查询的where条件

	
4.表子查询	
mysql> select id, clinic_id, max(actual_amount) from (select * from ss_bills order by actual_amount desc) as bill group by clinic_id;
+----+-----------+--------------------+
| id | clinic_id | max(actual_amount) |
+----+-----------+--------------------+
|  1 |         3 |           31000.00 |
|  5 |        35 |            7200.00 |
+----+-----------+--------------------+	

