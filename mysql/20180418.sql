
#���� �������һ��ԭ���Ե�sql��ѯ������˵��һ�������Ĺ�����Ԫ��
#�����ڵ���䣬Ҫôȫ��ִ�гɹ���Ҫôȫ��ִ��ʧ��

start transaction;
select balance from checking where customer_id = 10233276;
update checking set balance = balance - 200.00 where customer_id = 10233276;
update savings set balance = balance + 200.00 where customer_id = 10233276;
commit;

#���ָ��뼶��
read uncommitted δ�ύ��  �����е��޸ģ���ʹû���ύ������������Ҳ���ǿɼ��ġ�������Զ�ȡδ�ύ�����ݣ���Ҳ����Ϊ���(dirty read) һ�����ʹ��
read committed �ύ�� һ������ӿ�ʼ���ύ֮ǰ���������κ��޸Ķ����������ǲ��ɼ��ġ����������ʱ��Ҳ�в����ظ��� nonrepeatable read
repeatable read ���ظ��� ��֤����ͬһ�������У���ζ�ȡͬ���ļ�¼�����һ�µģ������޷�����ö�phantom read������
#�ö� ��ĳ�������ȡĳ����Χ�ڵļ�¼ʱ������һ���������ڸ÷�Χ�ڲ������µļ�¼����֮ǰ�������ٴζ�ȡ�÷�Χ�ڵļ�¼ʱ�����������phantom row
 innodb �� xtradb �洢����ͨ����汾��������MVCC (Multiversion concurrency control)����˻ö�������
���ظ�����mysqlĬ�ϵ�������뼶��
serializable �ɴ��л� ��ߵĸ��뼶�� ͨ��ǿ��������ִ�У�����Ļö����� serializable���ڶ�ȡ��ÿһ�������϶��������ᵼ�´����ĳ�ʱ�������õ����� ʵ�ʺ���ʹ��������뼶�� ֻ���ڷǳ���Ҫȷ�����ݵ�һ���Զ��ҿ��Խ���û�в���������£��ſ���ʹ�øü���
#�鿴mysql��������뼶��
mysql> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| READ-COMMITTED |
+----------------+
1 row in set (0.03 sec)

#����mysql��������뼶��
set session transaction isolation level

#���� ��ָ����������߶��������ͬһ����Դ���໥ռ�ã������������Է�ռ�õ���Դ���Ӷ����¶���ѭ��������
 �����������ͼ�Բ�ͬ��˳��������Դʱ���Ϳ��ܻ��������
 �������ͬʱ����ͬһ����Դʱ��Ҳ�����������
 
 start transaction;
 update StockPrice set close = 45.50 where stock_id = 4 and date = '2018-04-18';
 update StockPrice set close = 19.80 where stock_id = 3 and date = '2018-04-19';
 commit;
 
 start transaction;
 update StockPrice set close = 20.12 where stock_id = 3 and date = '2018-04-19';
 update StockPrice set close = 19.80 where stock_id = 4 and date = '2018-04-18';
 commit;
 
 ������ɣ���������ִ���˵�һ��update��䣬������һ�����ݣ�ͬʱҲ�����˸������ݣ�����ÿ�����񶼳���ȥִ�еڶ���update��䣬
 ȴ���ָ����ѱ��Է�������Ȼ���������񶼵ȴ��Է��ͷ�����ͬʱ�г��жԷ���Ҫ��������������ѭ����
 �����ʽ�� ��������������ʱ����
	Խ���ӵ�ϵͳ��Խ�ܼ�⵽������ѭ������ ����Innodb�������� ��������һ������ ���ֽ����ʽ����Ч�����������ᵼ�·ǳ����Ĳ�ѯ
	����ѯʱ��ﵽ���ȴ���ʱ���趨�����������(���ַ�ʽ���Ƽ�)
	InnoDBĿǰ���������İ취: �����������м���������������лع� ������ԱȽϼ򵥵������ع��㷨

�����Ĳ�����˫��ԭ��:��Щ����Ϊ���������ݳ�ͻ�� ��Щ����ȫ�Ǵ洢�����ʵ�ַ�ʽ���µ�
����������ֻ�в��ֻ�����ȫ�ع�һ�����񣬲��ܴ������������������͵�ϵͳ�������޷�����ġ�
���������£�ֻ��Ҫ����ִ���������ع������񼴿ɡ�

######������־
mysql �ṩ�����������͵Ĵ洢���� InnoDB �� NDB Cluster

AUTOCOMMIT �Զ��ύ
mysqlĬ�ϲ����Զ��ύģʽ�����������ʵ�Ŀ�ʼһ��������ÿ����ѯ���ᱻ����һ������ִ���ύ������
mysql> show variables like 'autocommit';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| autocommit    | ON    |
+---------------+-------+
1 row in set (0.03 sec)

�����Զ��ύ
mysql> set autocommit = 1;
Query OK, 0 rows affected (0.00 sec)

�ر��Զ��ύ
mysql> set autocommit = 0;
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like 'autocommit';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| autocommit    | OFF   |
+---------------+-------+
1 row in set (0.01 sec)

���ø��뼶��
mysql> set transaction isolation level read committed;
Query OK, 0 rows affected (0.01 sec)

��ͬһ�������У�ʹ�ö��ִ洢�����ǲ��ɿ��ģ� ����������л��ʹ���������ͺͷ������͵ı��� InnoDB �� MyIsAM,�����ύ������²�����ʲô���⡣
�������������Ҫ�ع����������͵ı��ϵı�����޷�����

