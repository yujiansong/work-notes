
#mysql根据两个字段的数据之和进行排序
select *, num1+num2 sum_num from $tableName where 1 order by sum_num desc