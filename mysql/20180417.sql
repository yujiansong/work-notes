
#1.并发控制-读写锁
#处理并发读或者写时，可以通过实现一个由两种类型的锁组成的锁系统来解决问题。

shared lock    共享锁     读锁  read lock
exclusive lock 排他锁     写锁  write lock 

读锁: 共享的，互相不阻塞的，多个客户同一时刻可以同时读取同一个资源,互不干扰
写锁: 排他的，一个写锁会阻塞其它的写锁和读锁 

#错误记录
[ 2018-04-17T10:13:05+08:00 ] 127.0.0.1 127.0.0.1 GET /clinic/promote/category?code=message_type&token=8fdc399a55c98bde96ee6c7f134adc9d
[ error ] [10501]SQLSTATE[42000]: Syntax error or access violation: 1142 SELECT command denied to user 'admin'@'172.16.144.200' for table 'ss_dictionary'

#1.一般是权限问题 参考:https://www.cnblogs.com/bushe/p/5647767.html
#或者使用 navicat 用户->admin@%->编辑用户->服务器权限(进行编辑)->权限(使用的数据库进行编辑)->保存  最后刷新权限(flush privileges)

