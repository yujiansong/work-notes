## 存储过程简介

> SQL语句需要先编译然后执行，而存储过程（Stored Procedure）是一组为了完成特定功能的SQL语句集，经编译后存储在数据库中，</br> 用户通过指定存储过程的名字并给定参数（如果该存储过程带有参数）来调用执行它。</br>
存储过程是可编程的函数，在数据库中创建并保存，可以由SQL语句和控制结构组成。</br>
当想要在不同的应用程序或平台上执行相同的函数，或者封装特定功能时，存储过程是非常有用的。数据库中的存储过程可以看做是对编程中面向对象方法的模拟，它允许控制数据的访问方式。 

存储过程的优点
1. 增强SQL语言的功能和灵活性：存储过程可以用控制语句编写，有很强的灵活性，可以完成复杂的判断和较复杂的运算。 
2. 标准组件式编程：存储过程被创建后，可以在程序中被多次调用，而不必重新编写该存储过程的SQL语句。而且数据库专业人员可以随时对存储过程进行修改，对应用程序源代码毫无影响。 
3. 较快的执行速度：如果某一操作包含大量的Transaction-SQL代码或分别被多次执行，那么存储过程要比批处理的执行速度快很多。因为存储过程是预编译的。在首次运行一个存储过程时查询，优化器对其进行分析优化，并且给出最终被存储在系统表中的执行计划。而批处理的Transaction-SQL语句在每次运行时都要进行编译和优化，速度相对要慢一些。
4. 减少网络流量：针对同一个数据库对象的操作（如查询、修改），如果这一操作所涉及的Transaction-SQL语句被组织进存储过程，那么当在客户计算机上调用该存储过程时，网络中传送的只是该调用语句，从而大大减少网络流量并降低了网络负载。 
5. 作为一种安全机制来充分利用：通过对执行某一存储过程的权限进行限制，能够实现对相应的数据的访问权限的限制，避免了非授权用户对数据的访问，保证了数据的安全。 

## mysql存储过程的创建

```
CREATE PROCEDURE  过程名([[IN|OUT|INOUT] 参数名 数据类型[,[IN|OUT|INOUT] 参数名 数据类型…]]) [特性 ...] 过程体

DELIMITER //
  CREATE PROCEDURE myproc(OUT s int)
    BEGIN
      SELECT COUNT(*) INTO s FROM students;
    END
    //
DELIMITER ;
```

存储过程根据需要可能会有输入、输出、输入输出参数，如果有多个参数用","分割开。MySQL存储过程的参数用在存储过程的定义，共有三种参数类型,IN,OUT,INOUT:
1. IN参数的值必须在调用存储过程时指定，在存储过程中修改该参数的值不能被返回，为默认值 
2. OUT:该值可在存储过程内部被改变，并可返回
3. INOUT:调用时指定，并且可被改变和返回

过程体的开始与结束使用BEGIN与END进行标识。

> in 参数的例子1.

```
mysql> delimiter //
mysql> create procedure in_param(in p_in int)
    -> begin
    -> select p_in;
    -> set p_in=2;
    -> select p_in;
    -> end;
    -> //
Query OK, 0 rows affected (0.29 sec)

mysql> delimiter ;

# 2.调用函数
mysql> set @p_in=1;
Query OK, 0 rows affected (0.03 sec)

mysql> call in_param(@p_in);
+------+
| p_in |
+------+
|    1 |
+------+
1 row in set (0.03 sec)

+------+
| p_in |
+------+
|    2 |
+------+
1 row in set (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

mysql> select @p_in;
+-------+
| @p_in |
+-------+
|     1 |
+-------+
1 row in set (0.03 sec)
# 以上可以看出，p_in虽然在存储过程中被修改，但并不影响@p_id的值
```

> in 参数例子2

```
mysql> delimiter //
mysql> create procedure getPatientName(in patient_id int)
    -> begin
    -> select truename from ss_telemarket_patient where id=patient_id;
    -> end;
    -> //
Query OK, 0 rows affected (0.03 sec)

mysql> delimiter ;
mysql> set @patient=176;
Query OK, 0 rows affected (0.03 sec)

mysql> call getPatientName(@patient);
+-----------------+
| truename        |
+-----------------+
| 翠神张少伟      |
+-----------------+
1 row in set (0.04 sec)

Query OK, 0 rows affected (0.04 sec)

```

> out 案例1.

```
mysql> delimiter //
mysql> create procedure out_param(out p_out int)
    -> begin
    -> select p_out;
    -> set p_out=2;
    -> select p_out;
    -> end;
    -> //
Query OK, 0 rows affected (0.03 sec)

mysql> delimiter ;
mysql> set @p_out=1;
Query OK, 0 rows affected (0.03 sec)

mysql> call out_param(@p_out);
+-------+
| p_out |
+-------+
|  NULL |
+-------+
1 row in set (0.03 sec)

+-------+
| p_out |
+-------+
|     2 |
+-------+
1 row in set (0.04 sec)

Query OK, 0 rows affected (0.04 sec)

mysql> select @p_out;
+--------+
| @p_out |
+--------+
|      2 |
+--------+
1 row in set (0.03 sec)
```

> inout 案例1.

```
mysql> delimiter //
mysql> create procedure inout_param(inout p_inout int)
    -> begin
    -> select p_inout;
    -> set p_inout=2;
    -> select p_inout;
    -> end;
    -> //
Query OK, 0 rows affected (0.03 sec)

mysql> delimiter ;
mysql> set @p_inout=1;
Query OK, 0 rows affected (0.03 sec)

mysql> call inout_param(@p_inout);
+---------+
| p_inout |
+---------+
|       1 |
+---------+
1 row in set (0.03 sec)

+---------+
| p_inout |
+---------+
|       2 |
+---------+
1 row in set (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

mysql> select @p_inout;
+----------+
| @p_inout |
+----------+
|        2 |
+----------+
1 row in set (0.03 sec)
```

### 用户变量
> 用户变量一般以@开头

注意：滥用用户变量会导致程序难以理解及管理 
```
#在mysql客户端使用用户变量
mysql> select 'hello,world' into @x;
Query OK, 1 row affected (0.03 sec)

mysql> select @x;
+-------------+
| @x          |
+-------------+
| hello,world |
+-------------+
1 row in set (0.03 sec)

mysql> select 'huangyongjun' into @h;
Query OK, 1 row affected (0.04 sec)

mysql> select @h;
+--------------+
| @h           |
+--------------+
| huangyongjun |
+--------------+
1 row in set (0.03 sec)

mysql> set @y='goodbye cruel world'; 
Query OK, 0 rows affected (0.03 sec)

mysql> select @y;
+---------------------+
| @y                  |
+---------------------+
| goodbye cruel world |
+---------------------+
1 row in set (0.03 sec)

#在存储过程中使用用户变量
mysql> create procedure GreetingWorld() select concat(@greeting,'World');
Query OK, 0 rows affected (0.03 sec)

mysql> set @greeting='hello';
Query OK, 0 rows affected (0.03 sec)

mysql> call GreetingWorld();
+---------------------------+
| concat(@greeting,'World') |
+---------------------------+
| helloWorld                |
+---------------------------+
1 row in set (0.03 sec)

#在存储过程间传递全局范围的用户变量
mysql> create procedure p1() set @last_proc='p1';
Query OK, 0 rows affected (0.03 sec)

mysql> create procedure p2() select concat('last procedure was ', @last_proc);
Query OK, 0 rows affected (0.03 sec)

mysql> call p1();
Query OK, 0 rows affected (0.03 sec)

mysql> call p2();
+-------------------------------------------+
| concat('last procedure was ', @last_proc) |
+-------------------------------------------+
| last procedure was p1                     |
+-------------------------------------------+
1 row in set (0.06 sec)

Query OK, 0 rows affected (0.06 sec)

mysql> select @last_proc;
+------------+
| @last_proc |
+------------+
| p1         |
+------------+
1 row in set (0.03 sec)

```

> 注释
MySQL存储过程可使用两种风格的注释：
1. 双杠：--，该风格一般用于单行注释
2. C风格： 一般用于多行注释

```
#查看存储过程详细信息
mysql> show create procedure getPatientName \G;
*************************** 1. row ***************************
           Procedure: getPatientName
            sql_mode: 
    Create Procedure: CREATE DEFINER=`test_admin`@`%` PROCEDURE `getPatientName`(in patient_id int)
begin
select truename from ss_telemarket_patient where id=patient_id;
end
character_set_client: utf8
collation_connection: utf8_general_ci
  Database Collation: utf8mb4_general_ci
1 row in set (0.03 sec)

```

### 变量作用域
内部变量在其作用域范围内享有更高的优先权，当执行到end时，内部变量消失，不再可见了，在存储
过程外再也找不到这个内部变量，但是可以通过out参数或者将其值指派给会话变量来保存其值。

```
mysql> delimiter //
mysql> create procedure proc()
    -> begin
    -> declare x1 varchar(5) default 'outer';
    -> begin
    -> declare x1 varchar(5) default 'inner';
    -> select x1;
    -> end;
    -> select x1;
    -> end;
    -> //
Query OK, 0 rows affected (0.03 sec)

mysql> delimiter ;
mysql> call proc();
+-------+
| x1    |
+-------+
| inner |
+-------+
1 row in set (0.04 sec)

+-------+
| x1    |
+-------+
| outer |
+-------+
1 row in set (0.04 sec)

Query OK, 0 rows affected (0.04 sec)
```

> 条件语句 IF-THEN-ELSE

```
mysql> delimiter //
mysql> create procedure proc3(in parameter int)
    -> begin
    -> declare var int;
    -> set var=parameter+1;
    -> if var=0 then
    -> update test_patient set truename = '吴世成' where id = 16;
    -> end if;
    -> if parameter=0 then
    -> update test_patient set truename = '黄勇君' where id = 18;
    -> else
    -> update test_patient set truename = '翠神张少伟' where id = 19;
    -> end if;
    -> end;
    -> //
Query OK, 0 rows affected (0.04 sec)

mysql> delimiter ;

mysql> call proc3(3);
Query OK, 1 row affected (0.04 sec)

mysql> select truename from test_patient where id = 19;
+-----------------+
| truename        |
+-----------------+
| 翠神张少伟      |
+-----------------+
1 row in set (0.03 sec)

mysql> call proc3(-1);
Query OK, 0 rows affected (0.03 sec)
mysql> select truename from test_patient where id = 16;
+-----------+
| truename  |
+-----------+
| 吴世成    |
+-----------+
1 row in set (0.04 sec)

mysql> call proc3(0);
Query OK, 1 row affected (0.03 sec)
mysql> select truename from test_patient where id = 18;
+-----------+
| truename  |
+-----------+
| 黄勇君    |
+-----------+
1 row in set (0.03 sec)

```

> 条件语句 CASE-WHEN-THEN-ELSE

```
mysql> delimiter //
mysql> create procedure proc4(in parameter int)
    -> begin
    -> declare var int;
    -> set var=parameter+1;
    -> case var
    -> when 0 then
    -> update test_patient set age=age+1 where id = 16;
    -> when 1 then
    -> update test_patient set age=age+2 where id = 16;
    -> when 2 then
    -> update test_patient set age=age+3 where id = 16;
    -> else
    -> update test_patient set age=age+4 where id = 16;
    -> end case;
    -> end;
    -> //
Query OK, 0 rows affected (0.03 sec)

mysql> delimiter ;

mysql> call proc4(-1);
Query OK, 1 row affected (0.03 sec)

mysql> select age from test_patient where id = 16;
+------+
| age  |
+------+
| 1.00 |
+------+
1 row in set (0.03 sec)

mysql> call proc4(1);
Query OK, 1 row affected (0.03 sec)

mysql> select age from test_patient where id = 16;
+------+
| age  |
+------+
| 4.00 |
+------+
1 row in set (0.03 sec)

```

> 条件语句 WHILE-DO…END-WHILE

```
mysql> delimiter //
mysql> create procedure proc5()
    -> begin
    -> declare var int;
    -> set var=0;
    -> while var<6 do
    -> update test_patient set age=age+1 where id = 16;
    -> set var=var+1;
    -> end while;
    -> end;
    -> //
Query OK, 0 rows affected (0.03 sec)
mysql> delimiter ;

#调用之前
mysql> select age from test_patient where id = 16;
+------+
| age  |
+------+
| 4.00 |
+------+
1 row in set (0.04 sec)

#调用存储过程
mysql> call proc5();
Query OK, 1 row affected (0.03 sec)

mysql> select age from test_patient where id = 16;
+-------+
| age   |
+-------+
| 10.00 |
+-------+
1 row in set (0.03 sec)
```

