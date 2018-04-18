
#事务 事务就是一组原子性的sql查询，或者说是一个独立的工作单元。
#事务内的语句，要么全部执行成功，要么全部执行失败

start transaction;
select balance from checking where customer_id = 10233276;
update checking set balance = balance - 200.00 where customer_id = 10233276;
update savings set balance = balance + 200.00 where customer_id = 10233276;
commit;

#四种隔离级别
read uncommitted 未提交读  事务中的修改，即使没有提交，对其他事物也都是可见的。事务可以读取未提交的数据，这也被称为脏读(dirty read) 一般很少使用
read committed 提交读 一个事务从开始到提交之前，所做的任何修改对其他事务都是不可见的。这个级别有时候也叫不可重复读 nonrepeatable read
repeatable read 可重复读 保证了在同一个事务中，多次读取同样的记录结果是一致的，但是无法解决幻读phantom read的问题
#幻读 当某个事物读取某个范围内的记录时，另外一个事务又在该范围内插入了新的记录，当之前的事务再次读取该范围内的记录时，会产生换行phantom row
 innodb 和 xtradb 存储引擎通过多版本并发控制MVCC (Multiversion concurrency control)解决了幻读的问题
可重复读是mysql默认的事务隔离级别
serializable 可串行化 最高的隔离级别 通过强制事务串行执行，避免的幻读问题 serializable会在读取的每一行数据上都加锁，会导致大量的超时和锁争用的问题 实际很少使用这个隔离级别 只有在非常需要确保数据的一致性而且可以接受没有并发的情况下，才考虑使用该级别
#查看mysql的事务隔离级别
mysql> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| READ-COMMITTED |
+----------------+
1 row in set (0.03 sec)

#设置mysql的事务隔离级别
set session transaction isolation level