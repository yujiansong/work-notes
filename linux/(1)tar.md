### 打包命令 tar

```
[root@www ~]# tar [-j|-z] [cv] [-f 创建的档名] filename... <==打包与压缩
[root@www ~]# tar [-j|-z] [tv] [-f 创建的档名]             <==察看档名
[root@www ~]# tar [-j|-z] [xv] [-f 创建的档名] [-C 目录]   <==解压缩
选项与参数：
-c  ：创建打包文件，可搭配 -v 来察看过程中被打包的档名(filename)
-t  ：察看打包文件的内容含有哪些档名，重点在察看『档名』就是了；
-x  ：解打包或解压缩的功能，可以搭配 -C (大写) 在特定目录解开
      特别留意的是， -c, -t, -x 不可同时出现在一串命令列中。
-j  ：透过 bzip2 的支持进行压缩/解压缩：此时档名最好为 *.tar.bz2
-z  ：透过 gzip  的支持进行压缩/解压缩：此时档名最好为 *.tar.gz
-v  ：在压缩/解压缩的过程中，将正在处理的档名显示出来！
-f filename：-f 后面要立刻接要被处理的档名！建议 -f 单独写一个选项罗！
-C 目录    ：这个选项用在解压缩，若要在特定目录解压缩，可以使用这个选项。

其他后续练习会使用到的选项介绍：
-p  ：保留备份数据的原本权限与属性，常用於备份(-c)重要的配置档
-P  ：保留绝对路径，亦即允许备份数据中含有根目录存在之意；
--exclude=FILE：在压缩的过程中，不要将 FILE 打包！ 
```

其实最简单的使用 tar 就只要记忆底下的方式即可：
> 压缩：tar -cz|jv -f filename.tar.gz 要被压缩的文件或目录名称 </br>
> 查询：tar -tz|jv -f filename.tar.gz </br>
> 解压缩: tar -xz|jv -f filename.tar.gz -C 欲解压缩的目录

例. 使用 tar 加入 -j 或 -z 的参数备份 /etc/ 目录
```
[artisan@localhost ~]$ sudo tar -czpv -f testing/etc.tar.gz /etc
[artisan@localhost ~]$ ls -lht testing/
总用量 11M
-rw-r--r-- 1 root    root     11M 10月 30 11:07 etc.tar.gz

[artisan@localhost ~]$ sudo tar -cjpv -f testing/etc.tar.bz2 /etc
[artisan@localhost ~]$ ls -lht testing/
总用量 20M
-rw-r--r-- 1 root    root    9.1M 10月 30 11:09 etc.tar.bz2
-rw-r--r-- 1 root    root     11M 10月 30 11:07 etc.tar.gz
```
==为什么建议您使用 -j 这个选项？从上面的数值你可以知道了吧？^_^==

>查阅 tar 文件的数据内容(可察看档名)，与备份档名有否根目录的意义
```
[artisan@localhost ~]$ tar -tjv -f testing/etc.tar.bz2
```

> 果你确定你就是需要备份根目录到 tar 的文件中，那可以使用 -P (大写) 这个选项，请看底下的例子分析：
```
[artisan@localhost ~]$ sudo tar -cjpPv -f testing/etc.and.root.tar.bz2 /etc
[artisan@localhost ~]$ tar -tjv -f testing/etc.and.root.tar.bz2 
-rw-r--r-- root/root       885 2018-04-11 09:37 /etc/libblockdev/conf.d/00-default.cfg
drwxr-xr-x root/root         0 2018-04-11 14:42 /etc/multipath/
-rw-r--r-- root/root       356 2014-06-10 07:02 /etc/urlview.conf
-rw-r--r-- root/root        32 2018-08-21 02:47 /etc/Muttrc.local
```
*有发现不同点了吧？如果加上 -P 选项，那么档名内的根目录就会存在喔！不过，鸟哥个人建议，还是不要加上 -P 这个选项来备份！ 毕竟很多时候，我们备份是为了要未来追踪问题用的，倒不一定需要还原回原本的系统中！ 所以拿掉根目录后，备份数据的应用会比较有弹性！也比较安全呢！*

> 将备份的数据解压缩，并考虑特定目录的解压缩动作 (-C 选项的应用)
```
[artisan@localhost testing]$ tar -xjv -f etc.tar.bz2 
```
> 有没有更简单的方法可以『指定欲解开的目录』呢？ 有的，可以使用 -C 这个选项喔！举例来说：
```
[artisan@localhost testing]$ tar -xjv -f etc.tar.bz2 -C /tmp/
[artisan@localhost testing]$ ls -lht /tmp/
总用量 24K
drwxr-xr-x 96 artisan artisan 8.0K 8月  29 17:54 etc
srwxrwxrwx  1 mysql   mysql      0 3月  31 2018 mysql.sock
```

> 仅解开单一文件的方法:
刚刚上头我们解压缩都是将整个打包文件的内容全部解开！想像一个情况，如果我只想要解开打包文件内的其中一个文件而已， 那该如何做呢？很简单的，你只要使用 -jtv 找到你要的档名，然后将该档名解开即可。 我们用底下的例子来说明一下：
```
# 1. 先找到我们要的档名，假设解开 shadow 文件好了：
[artisan@localhost testing]$ tar -tjv -f etc.tar.bz2 | grep 'shadow'
---------- root/root       582 2018-08-22 17:16 etc/gshadow
---------- root/root       570 2018-08-22 17:10 etc/gshadow-
---------- root/root      1678 2018-08-22 16:36 etc/shadow #这是我们要的
---------- root/root      1356 2018-08-22 16:35 etc/shadow-

# 2. 将该文件解开！语法与实际作法如下：
[root@www ~]# tar -jxv -f 打包档.tar.bz2 待解开档名
[artisan@localhost testing]$ tar -xjv -f etc.tar.bz2 etc/shadow 
etc/shadow
[artisan@localhost testing]$ ls -lht etc
总用量 4.0K
---------- 1 artisan artisan 1.7K 8月  22 16:36 shadow
# 很有趣！此时只会解开一个文件而已！不过，重点是那个档名！你要找到正确的档名。
# 在本例中，你不能写成 /etc/shadow ！因为记录在 etc.tar.bz2 内的档名之故！
```

> 打包某目录，但不含该目录下的某些文件之作法
```
[artisan@localhost ~]$ ls -lht testing
总用量 56M
drwxrwxr-x 2 artisan artisan   20 10月 30 11:48 etc
-rw-rw-r-- 1 artisan artisan  17M 10月 30 11:16 smilaign.tar.bz2
-rw-rw-r-- 1 artisan artisan  19M 10月 30 11:13 smilalign.tar.gz
-rw-r--r-- 1 root    root    9.1M 10月 30 11:09 etc.tar.bz2
-rw-r--r-- 1 root    root     11M 10月 30 11:07 etc.tar.gz
lrwxrwxrwx 1 artisan artisan   22 9月  25 11:54 halo.py -> /home/artisan/hello.py
-rw-r--r-- 1 artisan artisan 4.2K 5月  31 10:07 spring.txt

#打包testing目录除了 etc相关文件
[[artisan@localhost ~]$ tar -cjv -f testing.tar.bz2 testing/ --exclude=testing/etc*
testing/
testing/halo.py
testing/smilalign.tar.gz
testing/smilaign.tar.bz2
testing/spring.txt

#查看testing.tar.bz2目录下的文件
[artisan@localhost ~]$ tar -tjv -f testing.tar.bz2 
drwxrwxr-x artisan/artisan   0 2018-10-30 12:02 testing/
lrwxrwxrwx artisan/artisan   0 2018-09-25 11:54 testing/halo.py -> /home/artisan/hello.py
-rw-rw-r-- artisan/artisan 19720067 2018-10-30 11:13 testing/smilalign.tar.gz
-rw-rw-r-- artisan/artisan 17723694 2018-10-30 11:16 testing/smilaign.tar.bz2
-rw-r--r-- artisan/artisan     4227 2018-05-31 10:07 testing/spring.txt

#先删除掉 testing下的spring文件
[artisan@localhost testing]$ ls -lht
总用量 56M
drwxrwxr-x 2 artisan artisan   20 10月 30 11:48 etc
-rw-rw-r-- 1 artisan artisan  17M 10月 30 11:16 smilaign.tar.bz2
-rw-rw-r-- 1 artisan artisan  19M 10月 30 11:13 smilalign.tar.gz
-rw-r--r-- 1 root    root    9.1M 10月 30 11:09 etc.tar.bz2
-rw-r--r-- 1 root    root     11M 10月 30 11:07 etc.tar.gz
lrwxrwxrwx 1 artisan artisan   22 9月  25 11:54 halo.py -> /home/artisan/hello.py
#只解压出 testing/spring.txt文件
[artisan@localhost ~]$ tar -xjv -f testing.tar.bz2 testing/spring.txt
testing/spring.txt
[artisan@localhost ~]$ ls -lht testing
总用量 56M
drwxrwxr-x 2 artisan artisan   20 10月 30 11:48 etc
-rw-rw-r-- 1 artisan artisan  17M 10月 30 11:16 smilaign.tar.bz2
-rw-rw-r-- 1 artisan artisan  19M 10月 30 11:13 smilalign.tar.gz
-rw-r--r-- 1 root    root    9.1M 10月 30 11:09 etc.tar.bz2
-rw-r--r-- 1 root    root     11M 10月 30 11:07 etc.tar.gz
lrwxrwxrwx 1 artisan artisan   22 9月  25 11:54 halo.py -> /home/artisan/hello.py
-rw-r--r-- 1 artisan artisan 4.2K 5月  31 10:07 spring.txt #解压出的文件

```

> 
```
[artisan@localhost ~]$ find /data/wwwroot/smilalign -type f -name '*.php' -mtime -1 -exec ls -lht {} +;
-rw-rw-r-- 1 www  www   30K 10月 29 17:50 /data/wwwroot/smilalign/extend/core/logic/orthdontics/FactoryOrthdontics.php
-rw-rw-r-- 1 www  www   36K 10月 29 15:35 /data/wwwroot/smilalign/extend/core/logic/clinic/ClinicStaffLogic.php
-rw-rw-r-- 1 www  www  8.1K 10月 29 15:11 /data/wwwroot/smilalign/admin/route.php
-rw-rw-r-- 1 root root  977 10月 29 15:08 /data/wwwroot/smilalign/clinic/orthdontics/service/Doctor.php
-rw-rw-r-- 1 www  www   642 10月 29 15:05 /data/wwwroot/smilalign/clinic/orthdontics/controller/Doctor.php
-rw-rw-r-- 1 root root  573 10月 29 15:04 /data/wwwroot/smilalign/clinic/orthdontics/validate/Doctor.php
-rw-rw-r-- 1 root root 4.8K 10月 29 14:53 /data/wwwroot/smilalign/admin/clinic/service/Doctor.php
-rw-rw-r-- 1 www  www  8.1K 10月 29 14:49 /data/wwwroot/smilalign/clinic/route.php
```

>仅备份比某个时刻还要新的文件
```
# 1. 先由 find 找出比 /data/wwwroot/smilalign/clinic/orthdontics/service/Doctor.php 还要新的文件
[artisan@localhost ~]$ find /data/wwwroot/smilalign -type f -name '*.php' -mtime -1 -exec ls -lht {} +;
-rw-rw-r-- 1 www  www   30K 10月 29 17:50 /data/wwwroot/smilalign/extend/core/logic/orthdontics/FactoryOrthdontics.php
-rw-rw-r-- 1 www  www   36K 10月 29 15:35 /data/wwwroot/smilalign/extend/core/logic/clinic/ClinicStaffLogic.php
-rw-rw-r-- 1 www  www  8.1K 10月 29 15:11 /data/wwwroot/smilalign/admin/route.php
-rw-rw-r-- 1 root root  977 10月 29 15:08 /data/wwwroot/smilalign/clinic/orthdontics/service/Doctor.php
-rw-rw-r-- 1 www  www   642 10月 29 15:05 /data/wwwroot/smilalign/clinic/orthdontics/controller/Doctor.php
-rw-rw-r-- 1 root root  573 10月 29 15:04 /data/wwwroot/smilalign/clinic/orthdontics/validate/Doctor.php
-rw-rw-r-- 1 root root 4.8K 10月 29 14:53 /data/wwwroot/smilalign/admin/clinic/service/Doctor.php
-rw-rw-r-- 1 www  www  8.1K 10月 29 14:49 /data/wwwroot/smilalign/clinic/route.php

[artisan@localhost ~]$ find /data/wwwroot/smilalign -type f -name '*.php' -newer /data/wwwroot/smilalign/clinic/orthdontics/service/Doctor.php \
> -exec ls -lt {} +;
-rw-rw-r-- 1 www www 29967 10月 29 17:50 /data/wwwroot/smilalign/extend/core/logic/orthdontics/FactoryOrthdontics.php
-rw-rw-r-- 1 www www 36684 10月 29 15:35 /data/wwwroot/smilalign/extend/core/logic/clinic/ClinicStaffLogic.php
-rw-rw-r-- 1 www www  8248 10月 29 15:11 /data/wwwroot/smilalign/admin/route.php

# 2. 好了，那么使用 tar 来进行打包吧！日期为上面看到的 2018/10/29 15:08 并排除文件
[artisan@localhost testing]$ sudo tar -cjv -f smilaign.newer.tar.bz2 --newer-mtime="2018/10/29 15:08" /data/wwwroot/smilalign/ --exclude=/data/wwwroot/smilalign/runtime --exclude=/data/wwwroot/smilalign/clinic/orthdontics/service/Doctor.php

# 3.查询打包的文件（排除目录）
[artisan@localhost testing]$ tar -tjv -f smilaign.newer.tar.bz2 | grep -v '/$'
-rw-rw-r-- www/www        8248 2018-10-29 15:11 data/wwwroot/smilalign/admin/route.php
-rw-rw-r-- www/www       29967 2018-10-29 17:50 data/wwwroot/smilalign/extend/core/logic/orthdontics/FactoryOrthdontics.php
-rw-rw-r-- www/www       36684 2018-10-29 15:35 data/wwwroot/smilalign/extend/core/logic/clinic/ClinicStaffLogic.php
```

> 特殊应用：利用管线命令与数据流
```
# 1. 将 /etc 整个目录一边打包一边在 /tmp 解开
[artisan@localhost tmp]$ tar -cvf - /etc/ | tar -xvf -
```

> 例题：系统备份范例
```
# 1. 先处理要放置备份数据的目录与权限：
[root@localhost ~]# mkdir /backups
[root@localhost ~]# chmod 700 /backups
[root@localhost ~]# ll -d /backups
drwx------ 2 root root 6 10月 30 15:14 /backups

# 2. 假设今天是 20018/10/30 ，则创建备份的方式如下：
[root@localhost ~]# tar -cjv -f /backups/backup-system-20181030.tar.bz2 --exclude=/root/*.bz2 --exclude=/root/*.gz --exclude=/home/loop* /etc /home /var/spool/mail /var/spool/cron /root

[root@localhost ~]# ls -lht /backups/
总用量 173M
-rw-r--r-- 1 root root 173M 10月 30 15:19 backup-system-20181030.tar.bz2
```