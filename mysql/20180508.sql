# mysqldump备份数据库 mysql恢复数据库

#1.备份单个数据库的数据和结构
E:\phpstudy\MySQL\bin
λ mysqldump -h 192.168.1.10 -P 3306 -u root -p somshu > C:\Users\Administrator\Desktop\export\db_somshu_bak.sql
Enter password: ******

#2.备份全部数据库的数据和结构
myssqldump -h 服务器地址 -P 端口号 -u 用户名 -p -A > C:\Users\Administrator\Desktop\export\db_all_bak.sql
-A : 备份所有数据库 = -all-databases

E:\phpstudy\MySQL\bin
λ mysqldump -h 192.168.1.10 -P 3306 -u root -p -A > C:\Users\Administrator\Desktop\export\db_all_bak.sql
Enter password: ******

#3.备份全部数据库的结构(-d 参数)
-A： 备份所有数据库=--all-databases    --no-data, -d：只导出表结构
E:\phpstudy\MySQL\bin
λ mysqldump -h 192.168.1.10 -P 3306 -u root -p -A -d > C:\Users\Administrator\Desktop\export\db_allfrm_bak.sql
Enter password: ******

#4.备份单个数据库的表结构(不备份实际数据) -d 
E:\phpstudy\MySQL\bin
λ mysqldump -h 192.168.1.9 -P 3306 -u root -p admin -d > C:\Users\Administrator\Desktop\export\db_adminfrm_bak.sql
Enter password: ******

#5.备份多个表的数据和结构
E:\phpstudy\MySQL\bin
λ mysqldump -h 192.168.1.9 -P 3306 -u root -p  somshu ss_patient ss_staff > C:\Users\Administrator\Desktop\export\db_table_bak.sql
Enter password: ******

#6.一次备份多个数据库
E:\phpstudy\MySQL\bin
λ mysqldump -h 192.168.1.9 -P 3306 -u root -p --databases somshu admin > C:\Users\Administrator\Desktop\export\db_somhu_admin_bak.sql
Enter password: ******

