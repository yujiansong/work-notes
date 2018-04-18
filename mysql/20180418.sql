
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