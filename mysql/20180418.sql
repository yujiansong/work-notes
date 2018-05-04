
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

#死锁 是指两个事务或者多个事务在同一个资源上相互占用，并请求锁定对方占用的资源，从而导致恶性循环的现象。
 当多个事务试图以不同的顺序锁定资源时，就可能会产生死锁
 多个事务同时锁定同一个资源时，也会产生死锁。
 
 start transaction;
 update StockPrice set close = 45.50 where stock_id = 4 and date = '2018-04-18';
 update StockPrice set close = 19.80 where stock_id = 3 and date = '2018-04-19';
 commit;
 
 start transaction;
 update StockPrice set close = 20.12 where stock_id = 3 and date = '2018-04-19';
 update StockPrice set close = 19.80 where stock_id = 4 and date = '2018-04-18';
 commit;
 
 如果凑巧，两个事务都执行了第一条update语句，更新了一行数据，同时也锁定了该行数据，接着每个事务都尝试去执行第二条update语句，
 却发现改行已被对方锁定，然后两个事务都等待对方释放锁，同时有持有对方需要的锁，则陷入死循环。
 解决方式： 死锁检测和死锁超时机制
	越复杂的系统，越能检测到死锁的循环依赖 比如Innodb存数引擎 立即返回一个错误 这种解决方式很有效，否则死锁会导致非常慢的查询
	当查询时间达到锁等待超时的设定后放弃锁请求(这种方式不推荐)
	InnoDB目前处理死锁的办法: 将持有最少行级排他锁的事务进行回滚 这是相对比较简单的死锁回滚算法

死锁的产生有双重原因:有些事因为真正的数据冲突， 有些则完全是存储引擎的实现方式导致的
死锁发生后，只有部分或者完全回滚一个事务，才能打破死锁，对于事务型的系统，这是无法避免的。
大多数情况下，只需要重新执行因死锁回滚的事务即可。

######事务日志
mysql 提供了两种事务型的存储引擎 InnoDB 和 NDB Cluster

AUTOCOMMIT 自动提交
mysql默认采用自动提交模式。如果不是现实的开始一个事务，则每个查询都会被当做一个事务执行提交操作。
mysql> show variables like 'autocommit';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| autocommit    | ON    |
+---------------+-------+
1 row in set (0.03 sec)

开启自动提交
mysql> set autocommit = 1;
Query OK, 0 rows affected (0.00 sec)

关闭自动提交
mysql> set autocommit = 0;
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like 'autocommit';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| autocommit    | OFF   |
+---------------+-------+
1 row in set (0.01 sec)

设置隔离级别
mysql> set transaction isolation level read committed;
Query OK, 0 rows affected (0.01 sec)

在同一个事务中，使用多种存储引擎是不可靠的： 如果在事务中混合使用了事务型和非事务型的表如 InnoDB 和 MyIsAM,正常提交的情况下不会有什么问题。
但如果该事物需要回滚，非事务型的表上的变更就无法撤销

