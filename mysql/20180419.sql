
#多版本并发控制 MVCC 
MVCC 是行级锁的一个变种，但是它在很多情况下避免了加锁的操作，因此开销更低。虽然实现机制有所不同，但大都实现了非阻塞的操作，写操作也只锁定必要的行
MVCC 是通过保存数据在某个时间点的快照实现的，也就是说，不管需要执行多长时间，每个事务看到的数据都是一致的。
不用存储引擎的MVCC实现方式不同 典型的有乐观并发控制optimistic 和悲观并发控制pessimistic

#InnoDB的 MVCC,是通过每行记录后面保存两个隐藏的列来实现的。这两个列一个保存了行的创建时间，一个保存了行的过期时间(或删除时间)。当然存储的并不是实际的时间值，而是系统版本号system version number.每开始一个新的事务，系统版本号都很自动递增。事务开始时刻的系统版本号会作为事务的版本号，用来和查询到每行记录的版本号进行比较。

#REPEATABLE READ 隔离级别下 MVCC具体操作

select
InnoDB会根据以下两个条件检查每行记录
1.InnoDB只查找版本早于当前事务版本的数据行(也就是行的系统版本号小于或等于事务系统的版本号)，这样可以去确保事务读取的行，要么是在事务开始前已经存在的，要么是事务自身插入或者修改过的。
2.行的删除版本要么未定义，要么大于当前事务版本号。这可以确保事务读取到的行，在事务开始之前未被删除。

insert
InnoDB为新插入的每一行保存当前系统版本号作为行版本号

delete
InnoDB为删除的每一行保存当前系统版本号作为行删除标识

update
InnoDB为插入的一个新纪录，保存当前系统版本号为行版本号，同时保存当前系统版本号到原来的行作为行删除标识

保存这两个额外的系统版本号，使大多数的读操作都可以不用加锁。不足之处就是每行记录都需要额外的存储空间，需要做更多的行检查工作，以及一些额外的维护工作。

MVCC 只在REPEATABLE READ 和 READ COMMITTED 两个级别下工作。其它两个隔离级别都和MVCC不兼容，因为 READ UNCOMMITTED总是读取最新的行，而不是符合当前事务版本的数据行。而SERIALIZABLE 则会对所有读取的行都加锁。

######MySQL的存储引擎
显示表的相关信息

mysql> show table status like 'ss_staff' \G;  
*************************** 1. row ***************************
           Name: ss_staff              #表名
         Engine: InnoDB                #表的存储引擎类型
        Version: 10
     Row_format: Dynamic               #行的格式  Dynamic:行的长度是可变的 Fixed固定的
           Rows: 116                   #表中的行数  MyIsAM是精确的 对于InnoDB该值是估值
 Avg_row_length: 423                   #平均每行包含的字节数
    Data_length: 49152                 #表数据的大小(以字节为单位)
Max_data_length: 0                     #表数据的最大容量
   Index_length: 32768                 #索引的大小(以字节为单位)
      Data_free: 0                     #对于MyISAM表，表示已分配但是目前没有使用的空间。这部分空间包括了之前删除的行，以及后续可以被insert利用到的空间
 Auto_increment: 174                   #下一个 AUTO_INCREMENT的值
    Create_time: 2018-02-08 16:49:13   #表的创建时间
    Update_time: 2018-04-19 11:48:55   #表数据的最后修改时间
     Check_time: NULL                  #使用check table 命令或者myisamchk工具最后一次检查表的时间
      Collation: utf8mb4_general_ci    #表的默认字符集和字符列排序规则
       Checksum: NULL                  #如果启用，保存的是整个表的实时校验和
 Create_options:                       #创建表时指定的其它选项
        Comment: 诊所工作人员基本信息表#创建时的注释信息
1 row in set (0.00 sec)

