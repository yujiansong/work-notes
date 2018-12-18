### linux系统管理技术（3）

#### linux系统中的目录
```
[artisan@localhost /]$ pwd
/ #根目录，万物起源。
[artisan@localhost /]$ tree -L 1
.
├── bin -> usr/bin  #包含系统启动和运行所必须的二进制程序。
├── boot #包含 Linux 内核、初始 RAM 磁盘映像（用于启动时所需的驱动）和 启动加载程序。
├── data
├── dev #这是一个包含设备结点的特殊目录。“一切都是文件”，也适用于设备。 在这个目录里，内核维护着所有设备的列表。
├── etc #这个目录包含所有系统层面的配置文件。它也包含一系列的 shell 脚本， 在系统启动时，这些脚本会开启每个系统服务。这个目录中的任何文件应该是可读的文本文件。
├── home #在通常的配置环境下，系统会在/home 下，给每个用户分配一个目录。普通用户只能 在自己的目录下写文件。这个限制保护系统免受错误的用户活动破坏。
├── lib -> usr/lib #包含核心系统程序所使用的共享库文件。这些文件与 Windows 中的动态链接库相似。
├── lib64 -> usr/lib64
├── media #在现在的 Linux 系统中，/media 目录会包含可移动介质的挂载点， 例如 USB 驱动器，CD-ROMs 等等。这些介质连接到计算机之后，会自动地挂载到这个目录结点下。
├── mnt #在早些的 Linux 系统中，/mnt 目录包含可移动介质的挂载点。
├── opt #这个/opt 目录被用来安装“可选的”软件。这个主要用来存储可能 安装在系统中的商业软件产品。
├── proc #这个/proc 目录很特殊。从存储在硬盘上的文件的意义上说，它不是真正的文件系统。 相反，它是一个由 Linux 内核维护的虚拟文件系统。它所包含的文件是内核的窥视孔。这些文件是可读的， 它们会告诉你内核是怎样监管计算机的。
├── root #root 帐户的家目录。
├── run 
├── runtime
├── sbin -> usr/sbin #这个目录包含“系统”二进制文件。它们是完成重大系统任务的程序，通常为超级用户保留。
├── srv
├── sys
├── tmp #这个/tmp 目录，是用来存储由各种程序创建的临时文件的地方。一些配置导致系统每次 重新启动时，都会清空这个目录。
├── usr #在 Linux 系统中，/usr 目录可能是最大的一个。它包含普通用户所需要的所有程序和文件。
└── var #除了/tmp 和/home 目录之外，相对来说，目前我们看到的目录是静态的，这是说， 它们的内容不会改变。/var 目录存放的是动态文件。各种数据库，假脱机文件， 用户邮件等等，都位于在这里。

21 directories, 0 files
```

### cp
```
[root@www ~]# cp [-adfilprsu] 来源档(source) 目标档(destination)
[root@www ~]# cp [options] source1 source2 source3 .... directory
选项与参数：
-a  ：相当於 -pdr 的意思，至於 pdr 请参考下列说明；(常用)
-d  ：若来源档为连结档的属性(link file)，则复制连结档属性而非文件本身；
-f  ：为强制(force)的意思，若目标文件已经存在且无法开启，则移除后再尝试一次；
-i  ：若目标档(destination)已经存在时，在覆盖时会先询问动作的进行(常用)
-l  ：进行硬式连结(hard link)的连结档创建，而非复制文件本身；
-p  ：连同文件的属性一起复制过去，而非使用默认属性(备份常用)；
-r  ：递回持续复制，用於目录的复制行为；(常用)
-s  ：复制成为符号连结档 (symbolic link)，亦即『捷径』文件；
-u  ：若 destination 比 source 旧才升级 destination ！
最后需要注意的，如果来源档有两个以上，则最后一个目的档一定要是『目录』才行！
```

> 拷贝一个目录下所有的txt文件 ——这些文件在目标目录不存在或者版本比目标目录的文件更新——到目标目录
```
[artisan@localhost ~]$ cp -u /data/wwwroot/somshu/admin/clinic/work/readme.txt /home/artisan/testing/
[artisan@localhost ~]$ ls -lht testing/
总用量 4.0K
-rw-r--r-- 1 artisan artisan 10 12月 18 14:56 readme.txt
```

### 通配符
```
*	匹配任意多个字符（包括零个或一个）
?	匹配任意一个字符（不包括零个）
[characters]	匹配任意一个属于字符集中的字符
[!characters]	匹配任意一个不是字符集中的字符
[[:class:]]	匹配任意一个属于指定字符类中的字符
    [:alnum:]	匹配任意一个字母或数字
    [:alpha:]	匹配任意一个字母
    [:digit:]	匹配任意一个数字
    [:lower:]	匹配任意一个小写字母
    [:upper:]	匹配任意一个大写字母
```
> 通配符案例
```
*	所有文件
g*	文件名以“g”开头的文件
b*.txt	以"b"开头，中间有零个或任意多个字符，并以".txt"结尾的文件
Data???	以“Data”开头，其后紧接着3个字符的文件
[abc]*	文件名以"a","b",或"c"开头的文件
BACKUP.[0-9][0-9][0-9]	以"BACKUP."开头，并紧接着3个数字的文件
[[:upper:]]*	以大写字母开头的文件
[![:digit:]]*	不以数字开头的文件
*[[:lower:]123]	文件名以小写字母结尾，或以 “1”，“2”，或 “3” 结尾的文件
```

> 1.查找以小写字母开头的.txt文件
```
[artisan@localhost ~]$ find /data/wwwroot/somshu -type f -name '[[:lower:]]*.txt' -exec ls -lht {} +;
-rw-rw-r-- 1 root root 10 5月   8 2018 /data/wwwroot/somshu/clinic/work/readme.txt
-rw-r--r-- 1 root root 10 3月   6 2018 /data/wwwroot/somshu/admin/clinic/work/readme.txt
```

> 2.查找以大写字母开头的.txt文件
```
[artisan@localhost ~]$ find /data/wwwroot/somshu -type f -name '[[:upper:]]*.txt' -exec ls -lht {} +;
-rw-r--r-- 1 root root 1.2K 5月  29 2018 /data/wwwroot/somshu/vendor/workerman/workerman/MIT-LICENSE.txt
-rw-r--r-- 1 root root 1.2K 5月  23 2018 /data/wwwroot/somshu/vendor/workerman/gateway-worker/MIT-LICENSE.txt
-rw-r--r-- 1 root root 1.1K 12月 29 2017 /data/wwwroot/somshu/vendor/overtrue/socialite/LICENSE.txt
-rw-rw-r-- 1 root root 1.1K 12月 29 2017 /data/wwwroot/somshu/vendor/psr/cache/LICENSE.txt
-rw-r--r-- 1 root root 1.8K 11月 30 2017 /data/wwwroot/somshu/thinkphp/LICENSE.txt
-rw-rw-r-- 1 root root 1.8K 8月  21 2017 /data/wwwroot/somshu/thinkphp_old/LICENSE.txt
```

> 3.查找以数字开头的文件
```
[artisan@localhost ~]$ ls -lht testing/
总用量 92K
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 29.log
-rw-r--r-- 1 artisan artisan  12K 12月 18 15:13 27.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
-rw-r--r-- 1 artisan artisan   10 12月 18 14:56 readme.txt
[artisan@localhost ~]$ find /home/artisan/testing/ -type f -name '[[:digit:]]*' -exec ls -lht {} +;
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 /home/artisan/testing/29.log
-rw-r--r-- 1 artisan artisan  12K 12月 18 15:13 /home/artisan/testing/27.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 /home/artisan/testing/28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 /home/artisan/testing/01.log
```

> 4.查找以 r开头的文件
```
[artisan@localhost ~]$ find /home/artisan/testing/ -type f -name 'r*' -exec ls -lht {} +;
-rw-r--r-- 1 artisan artisan 10 12月 18 14:56 /home/artisan/testing/readme.txt
```

> 5.查找以 r0开头的文件
```
[artisan@localhost ~]$ find /home/artisan/testing/ -type f -name '[r0]*' -exec ls -lht {} +;   
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 /home/artisan/testing/01.log
-rw-r--r-- 1 artisan artisan   10 12月 18 14:56 /home/artisan/testing/readme.txt
```

> 6.查询以 read开头、其后紧接着2个字符的txt文件
```
[artisan@localhost ~]$ ls -lht testing/
总用量 92K
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:19 readinterest.txt
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 29.log
-rw-r--r-- 1 artisan artisan  12K 12月 18 15:13 27.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
-rw-r--r-- 1 artisan artisan   10 12月 18 14:56 readme.txt
[artisan@localhost ~]$ find /home/artisan/testing/ -type f -name 'read??.txt' -exec ls -lht {} +;
-rw-r--r-- 1 artisan artisan 10 12月 18 14:56 /home/artisan/testing/readme.txt
```

> 7.查询不以数字开头的文件
```
[artisan@localhost ~]$ find /home/artisan/testing/ -type f -name '[![:digit:]]*' -exec ls -lht {} +;
-rw-rw-r-- 1 artisan artisan  0 12月 18 15:19 /home/artisan/testing/readinterest.txt
-rw-r--r-- 1 artisan artisan 10 12月 18 14:56 /home/artisan/testing/readme.txt
```

> 8. cp -r dir1 dir2 <br>
> 复制目录 dir1 中的内容到目录 dir2。如果目录 dir2 不存在， 创建目录 dir2，操作完成后，目录 dir2 中的内容和 dir1 中的一样。 如果目录 dir2 存在，则目录 dir1 (和目录中的内容)将会被复制到 dir2 中。
```
[artisan@localhost ~]$ ls -lht
总用量 0
drwxrwxr-x 2 artisan artisan  76 12月 18 15:38 testing2
drwxrwxr-x 2 artisan artisan 104 12月 18 15:20 testing
[artisan@localhost ~]$ cp -r testing testing3
[artisan@localhost ~]$ ls -lht testing3/
总用量 92K
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:40 01.log
-rw-r--r-- 1 artisan artisan  12K 12月 18 15:40 27.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:40 28.log
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:40 29.log
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:40 readinterest.txt
-rw-r--r-- 1 artisan artisan   10 12月 18 15:40 readme.txt
```

> 9. cp -u 当把文件从一个目录复制到另一个目录时，仅复制 目标目录中不存在的文件，或者是文件内容新于目标目录中已经存在的文件。
```
[artisan@localhost ~]$ ls -lht testing
总用量 92K
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:19 readinterest.txt
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 29.log
-rw-r--r-- 1 artisan artisan  12K 12月 18 15:13 27.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
-rw-r--r-- 1 artisan artisan   10 12月 18 14:56 readme.txt
[artisan@localhost ~]$ ls -lht testing2
总用量 20K
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:34 readinterest.txt
-rw-r--r-- 1 artisan artisan   10 12月 18 15:34 readme.txt
-rw-r--r-- 1 artisan artisan  12K 12月 18 15:13 27.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
[artisan@localhost ~]$ cp -u testing/* testing2/
[artisan@localhost ~]$ ls -lht testing2/
总用量 92K
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:43 28.log
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:43 29.log
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:34 readinterest.txt
-rw-r--r-- 1 artisan artisan   10 12月 18 15:34 readme.txt
-rw-r--r-- 1 artisan artisan  12K 12月 18 15:13 27.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log

[artisan@localhost ~]$ ls -lht testing/readme.txt 
-rw-r--r-- 1 artisan artisan 12 12月 18 15:44 testing/readme.txt
[artisan@localhost ~]$ ls -lht testing2/readme.txt 
-rw-r--r-- 1 artisan artisan 10 12月 18 15:34 testing2/readme.txt
[artisan@localhost ~]$ cp -u testing/* testing2/
[artisan@localhost ~]$ ls -lht testing2/readme.txt 
-rw-r--r-- 1 artisan artisan 12 12月 18 15:45 testing2/readme.txt
[artisan@localhost ~]$ cat testing2/readme.txt 
hello,world
```

### mv - 移动和重命名文件
```
-i --interactive	在重写一个已经存在的文件之前，提示用户确认信息。 如果不指定这个选项，mv 命令会默认重写文件内容。
-u --update	当把文件从一个目录移动另一个目录时，只是移动不存在的文件， 或者文件内容新于目标目录相对应文件的内容。
-v --verbose	当操作 mv 命令时，显示翔实的操作信息。
```

### rm - 删除文件和目录

>小贴士。 当你使用带有通配符的rm命令时（除了仔细检查输入的内容外）， 先用 ls 命令来测试通配符。这会让你看到将要被删除的文件是什么。然后按下上箭头按键，重新调用 刚刚执行的命令，用 rm 替换 ls。

### ln — 创建链接
> 创建硬连接
```
[artisan@localhost testing]$ pwd
/home/artisan/testing
[artisan@localhost testing]$ ls -lht
总用量 80K
-rw-r--r-- 1 artisan artisan   12 12月 18 15:44 readme.txt
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:19 readinterest.txt
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 29.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
#创建硬连接
[artisan@localhost testing]$ ln readme.txt readme_hard.txt
[artisan@localhost testing]$ ls -lht
总用量 84K
-rw-r--r-- 2 artisan artisan   12 12月 18 15:44 readme_hard.txt
-rw-r--r-- 2 artisan artisan   12 12月 18 15:44 readme.txt
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:19 readinterest.txt
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 29.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
[artisan@localhost testing]$ cat readme_hard.txt 
hello,world
[artisan@localhost testing]$ rm -rf readme_hard.txt 
[artisan@localhost testing]$ ls -lht
总用量 80K
-rw-r--r-- 1 artisan artisan   12 12月 18 15:44 readme.txt
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:19 readinterest.txt
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 29.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
```

> 创建符号连接
```
[artisan@localhost testing]$ ln -s readme.txt readme_soft.txt
[artisan@localhost testing]$ ls -lht
总用量 80K
lrwxrwxrwx 1 artisan artisan   10 12月 18 16:17 readme_soft.txt -> readme.txt
-rw-r--r-- 1 artisan artisan   12 12月 18 15:44 readme.txt
-rw-rw-r-- 1 artisan artisan    0 12月 18 15:19 readinterest.txt
-rw-r--r-- 1 artisan artisan  62K 12月 18 15:13 29.log
-rw-r--r-- 1 artisan artisan 4.8K 12月 18 15:13 28.log
-rw-r--r-- 1 artisan artisan 2.4K 12月 18 15:13 01.log
[artisan@localhost testing]$ cat readme_soft.txt 
hello,world
[artisan@localhost testing]$ vim readme_soft.txt 
hello,world
hello,wanglaoer
[artisan@localhost testing]$ cat readme.txt 
hello,world
hello,wanglaoer

```


























