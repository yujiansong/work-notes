# Linux 系统常用命令（1）

## 1. tar 压缩或解压缩
```
tar命令常用属性:
  -c: 建立一个压缩文件的参数指令(create 的意思)；
  -x: 解压缩文件 
  -z: 启用 gzip 压缩 
  -j: 启用 bzip2 压缩 
  -v: 显示压缩或解压过程 
  -f: 指定压缩包名 

```
==在linux里常见的压缩包类型有：tar.gz和tar.bz2==
> 案例1. 打包目录practise 为 practise.tar.gz
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 4.0K
drwxrwxr-x 3 yjs yjs 4.0K Jul 29 11:15 practise
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ tar -czvf practise.tar.gz practise
practise/
practise/wanger/
practise/wanger/laoerpang/
practise/isuid.sh
practise/pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 8.0K
-rw-rw-r-- 1 yjs yjs  540 Jul 29 14:05 practise.tar.gz
drwxrwxr-x 3 yjs yjs 4.0K Jul 29 11:15 practise
```
> 案例2. 打包 practise 为 practise.tar.bz2
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ tar -cjvf practise.tar.bz2 practise
practise/
practise/wanger/
practise/wanger/laoerpang/
practise/isuid.sh
practise/pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 8.0K
-rw-rw-r-- 1 yjs yjs  576 Jul 29 14:08 practise.tar.bz2
drwxrwxr-x 3 yjs yjs 4.0K Jul 29 11:15 practise
```

> 案例3. 解压 practise.tar.gz 文件
```
-rw-rw-r-- 1 yjs yjs 576 Jul 29 14:08 practise.tar.bz2
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ tar -xzvf practise.tar.gz 
practise/
practise/wanger/
practise/wanger/laoerpang/
practise/isuid.sh
practise/pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 12K
-rw-rw-r-- 1 yjs yjs  541 Jul 29 14:09 practise.tar.gz
-rw-rw-r-- 1 yjs yjs  576 Jul 29 14:08 practise.tar.bz2
drwxrwxr-x 3 yjs yjs 4.0K Jul 29 11:15 practise
```

> 案例4. 解压 practise.tar.bz2 文件
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ tar -xjvf practise.tar.bz2 
practise/
practise/wanger/
practise/wanger/laoerpang/
practise/isuid.sh
practise/pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 12K
-rw-rw-r-- 1 yjs yjs  541 Jul 29 14:09 practise.tar.gz
-rw-rw-r-- 1 yjs yjs  576 Jul 29 14:08 practise.tar.bz2
drwxrwxr-x 3 yjs yjs 4.0K Jul 29 11:15 practise
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ tar -xvf practise.tar.bz2 
practise/
practise/wanger/
practise/wanger/laoerpang/
practise/isuid.sh
practise/pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 12K
-rw-rw-r-- 1 yjs yjs  541 Jul 29 14:09 practise.tar.gz
-rw-rw-r-- 1 yjs yjs  576 Jul 29 14:08 practise.tar.bz2
drwxrwxr-x 3 yjs yjs 4.0K Jul 29 11:15 practise
```

### 1.1 tar 打包排除某个目录或文件
> 用tar打包时想剔除打包目录中的某个子目录或文件：
```
命令格式：
tar -zcvf xxx.tar.gz   要打包的目录  --exclude=dir1   --exclude=file1
```

> 案例1. 将toolink/ 目录全部打包
```
[root@izbp10vxf7nhzxulpx8k4wz testing]# pwd
/data/wwwroot/testing
[root@izbp10vxf7nhzxulpx8k4wz testing]# tar -czvf toolink_20180729.tar.gz toolink
[root@izbp10vxf7nhzxulpx8k4wz testing]# ls -lht
total 158M
-rw-r--r--  1 root root 158M Jul 29 15:55 toolink_20180729.tar.gz
drwxr-xr-x 23 www  www  4.0K Jul 27 16:50 toolink
drwxr-xr-x 12 www  www  4.0K Jun 20 12:27 toolink_client
```

> 案例2. 你想打包/toolink这个目录，但是/toolink/runtime/目录和/toolink/vendor_old/目录和 /toolink/vandor_old2/目录 你都不想打包，方法是：
```
[root@izbp10vxf7nhzxulpx8k4wz testing]# tar -czvf toolink_20180729b.tar.gz toolink --exclude=toolink/runtime --exclude=toolink/vendor_old --exclude=toolink/vendor_old2
or
[root@izbp10vxf7nhzxulpx8k4wz testing]# tar -czvf toolink_20180729a.tar.gz toolink --exclude=toolink/runtime --exclude=toolink/vendor_old* 
toolink/go/route.php
[root@izbp10vxf7nhzxulpx8k4wz testing]# ls -lht
total 180M
-rw-r--r--  1 root root  22M Jul 29 15:58 toolink_20180729a.tar.gz
-rw-r--r--  1 root root 158M Jul 29 15:55 toolink_20180729.tar.gz
drwxr-xr-x 23 www  www  4.0K Jul 27 16:50 toolink
drwxr-xr-x 12 www  www  4.0K Jun 20 12:27 toolink_client
```
==排除了运行生成的日志文件和其它冗余文件，打包出来的文件体积较小==

```
[yjs@izbp10vxf7nhzxulpx8k4wz toolink_bak]$ du -hs toolink
76M     toolink
[yjs@izbp10vxf7nhzxulpx8k4wz toolink_bak]$ du -hs toolink/public/uploads
3.3M    toolink/public/uploads
```
> ==打包某个目录时，最好在该目录的上一级目录打包==

## 2. lrzsz 上传和下载
> rz : ==上传== rz中的r意为received（接收），告诉客户端，我（服务器）要接收文件 received by cilent，就等同于客户端在上传。</br>
> sz : ==下载== sz中的s意为send（发送），告诉客户端，我（服务器）要发送文件 send to cilent，就等同于客户端在下载

> 案例1. 上传文件 hello.sh
```
[root@localhost shell_test]# rz
rz waiting to receive.
Starting zmodem transfer.  Press Ctrl+C to cancel.
  100%      78 bytes   78 bytes/s 00:00:01       0 Errors

[root@localhost shell_test]# ls -lht
总用量 16K
lrwxrwxrwx 1 root root  28 7月  23 17:43 hello_2.sh -> /tmp/shell_test/bin/hello.sh
drwxr-xr-x 2 root root  39 7月  23 17:43 bin
drwxr-xr-x 2 root root 12K 7月  20 18:26 wwwcopy
drwxr-xr-x 2 root root   6 7月  20 18:09 wwwbak
-rw-r--r-- 1 root root  78 7月  19 16:26 hello.sh
```
> 案例2. 下载文件 hello.py
```
[root@localhost bin]# sz hello.py
rz
Starting zmodem transfer.  Press Ctrl+C to cancel.
  100%      34 bytes   34 bytes/s 00:00:01       0 Errors
```

## 3. cat

### 3.1 用cat进行拼接
> cat命令是一个日常经常会使用到的简单命令。cat本身表示concatenate（拼接）。</br>
> 用cat读取文件内容的一般写法是：$ cat file1 file2 file3 ...
```
-rwxr-xr-x 1 yjs yjs 261 Jul 29 23:20 IFS.sh
[yjs@izbp10vxf7nhzxulpx8k4wz bin]$ cat test.sh 
#!/bin/bash
var1=0
if test $var1 -eq 0; then
    echo var1 is eqlal 0;
fi
```
> 要从标准输入中读取，就要使用管道操作符：OUTPUT_FROM_SOME COMMANDS | cat

```
[yjs@izbp10vxf7nhzxulpx8k4wz bin]$ echo 'hello,world' | cat
hello,world
```

> ==压缩空白行== 出于可读性或是别的一些原因，有时文本中的多个空行需要被压缩成单个。可以用下面的方法压缩文本文件中连续的空白行：
```
$ cat -s file
```
> 案例1.
```
[yjs@izbp10vxf7nhzxulpx8k4wz bin]$ cat -n file.txt 
     1  #!/bin/bash
     2
     3  echo 'hello,world'
     4
     5  echo 'wanger'
     6
     7
     8  echo 'laozheng'
     9
    10
    11  echo 'ouyanglaoer'
    12
    13
    14  echo 'liuyijie'
```

使用 **cat -s filename** 进行压缩空白行

```
[yjs@izbp10vxf7nhzxulpx8k4wz bin]$ cat -sn file.txt 
     1  #!/bin/bash
     2
     3  echo 'hello,world'
     4
     5  echo 'wanger'
     6
     7  echo 'laozheng'
     8
     9  echo 'ouyanglaoer'
    10
    11  echo 'liuyijie'
```

> 我们也可以用**tr**移除空白行：
```
[yjs@izbp10vxf7nhzxulpx8k4wz bin]$ cat file.txt | tr -s '\n'
#!/bin/bash
echo 'hello,world'
echo 'wanger'
echo 'laozheng'
echo 'ouyanglaoer'
echo 'liuyijie'
```

> **cat -T filename** 将制表符显示为^|

```
[yjs@izbp10vxf7nhzxulpx8k4wz bin]$ cat -T file.py 
#!/bin/bash python3
def function():
^Ivar = 5
        next = 6
^Ithrid = 7^I
```

## 4. 录制与回放终端会话 script, scriptreplay

> 开始录制终端会话
```
$ script -t 2 > timing.log -a output.session
type commands;
…
..
exit
两个配置文件被当做script命令的参数。
其中一个文件（timing.log）用于存储时序信息，描述每一个命令在何时运行；
另一个文件（out-put.session）用于存储命令输出。
-t选项用于将时序数据导入stderr。
2>则用于将stderr重定向到timing.log。
```

> 按照下面的方法回放命令执行过程：</br>
> $ ==scriptreplay== timing.log output.session # 按播放命令序列输出

> 案例1. 用script命令建立可以广播给多个用户的终端会话。

1. 打开两个终端 yjs, tom
```
[yjs@izbp10vxf7nhzxulpx8k4wz shell-testing]$ whoami
yjs
[tom@izbp10vxf7nhzxulpx8k4wz shell-testing]$ whoami
tom
```
2. 在 yjs 中输入以下命令
```
[yjs@izbp10vxf7nhzxulpx8k4wz shell-testing]$ sudo mkfifo scriptfifo
[yjs@izbp10vxf7nhzxulpx8k4wz shell-testing]$ ls -lht scriptfifo 
prw-r--r-- 1 root root 0 Jul 30 22:18 scriptfifo
```
3. 在 tom 中输入以下命令
```
[tom@izbp10vxf7nhzxulpx8k4wz shell-testing]$ ls -lht
total 16K
prw-r--r-- 1 root root    0 Jul 30 22:18 scriptfifo
drwxr-xr-x 2 yjs  yjs  4.0K Jul 24 23:51 bin
-rw-r--r-- 1 yjs  root   54 Jul 22 13:32 ls-output.txt
-rw-r--r-- 1 root root   54 Jul 22 13:02 ls-error.txt
-rw-r--r-- 1 root yjs   511 Jul 21 17:25 pw.py
[tom@izbp10vxf7nhzxulpx8k4wz shell-testing]$ cat scriptfifo 
```

4. 返回 yjs 输入以下命令
```
[yjs@izbp10vxf7nhzxulpx8k4wz shell-testing]$ sudo script -f scriptfifo 
Script started, file is scriptfifo
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# echo 'hello,world'
hello,world
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# echo 'hello,world'
hello,world
```
==如果需要结束会话，输入exit并按回车键。你会得到如下信息：“Script done, file is scriptfifo”。==

> 现在，yjs就成为了广播员，而tom则成为了听众。不管你在yjs中输入什么内容，它都会在tom或者使用了下列命令的任何终端中实时播放：</br>
**cat scriptfifo**

## 5. find 文件查找与文件列表
### 5.1 列出当前目录及子目录下所有的文件和文件夹，可以采用下面的写法：
> $ find base_path </br>
> bash_path可以是任何位置（例如/home/slynux），find会从该位置开始向下查找。

> 案例1. 打印文件和目录的列表
```
[root@localhost shell_test]# find . -print
.
./bin
./bin/hello.sh
./wwwbak
./wwwcopy
./hello_2.sh
./hello.sh
./scriptfifo
```
==-print指明打印出匹配文件的文件名（路径）。当使用-print时，'\n'作为用于分隔文件的定界符。==

-print0指明使用'\0'作为定界符来打印每一个匹配的文件名。当文件名中包含换行符时，这个方法就有用武之地了。

### 5.2 根据文件名或正则表达式匹配搜索
> 选项-name的参数指定了文件名所必须匹配的字符串。我们可以将通配符作为参数使用。*.txt能够匹配所有以.txt结尾的文件名。选项-print在终端中打印出符合条件（例如-name）的文件名或文件路径，这些匹配条件作为find命令的选项给出。</br>
> $ find /home/slynux -name "*.txt" –print

==find命令有一个选项-iname（忽略字母大小写），该选项的作用和-name类似，只不过在匹配名字的时候会忽略大小写。==

> 案例1.
```
[root@localhost tmp]# find /data/wwwroot/somshu/ -name '*.txt' -print
/data/wwwroot/somshu/vendor/psr/cache/LICENSE.txt
/data/wwwroot/somshu/vendor/overtrue/socialite/LICENSE.txt
/data/wwwroot/somshu/vendor/workerman/workerman/MIT-LICENSE.txt
/data/wwwroot/somshu/vendor/workerman/gateway-worker/MIT-LICENSE.txt
/data/wwwroot/somshu/clinic/work/readme.txt
/data/wwwroot/somshu/thinkphp_old/LICENSE.txt
/data/wwwroot/somshu/thinkphp/LICENSE.txt
/data/wwwroot/somshu/admin/clinic/work/readme.txt
```
> 案例2
```
[root@localhost tmp]# find /data/wwwroot/somshu/ -name '*clinic.php' -print 
/data/wwwroot/somshu/public/clinic.php
/data/wwwroot/somshu/order/extra/db_clinic.php
[root@localhost tmp]# find /data/wwwroot/somshu/ -iname '*clinic.php' -print
/data/wwwroot/somshu/extend/core/model/Clinic.php
/data/wwwroot/somshu/extend/core/obj/Clinic.php
/data/wwwroot/somshu/extend/core/datacell/Clinic.php
/data/wwwroot/somshu/extend/message/model/Clinic.php
/data/wwwroot/somshu/extend/message/obj/Clinic.php
/data/wwwroot/somshu/factory/common/model/FactoryClinic.php
```

==如果想匹配多个条件中的一个，可以采用OR条件操作：==
> 案例3
```
[root@localhost tmp]# find /data/wwwroot/somshu/ \( -name '*me.txt' -o -name '*7c.csv' \) -print    
/data/wwwroot/somshu/public/uploads/20180510/ca828e18e4c7586f3587300007c1dd7c.csv
/data/wwwroot/somshu/clinic/work/readme.txt
/data/wwwroot/somshu/admin/clinic/work/readme.txt
[root@localhost tmp]# find /data/wwwroot/somshu/ -type f -a \( -name '*me.txt' -o -name '*7c.csv' \) -print 
/data/wwwroot/somshu/public/uploads/20180510/ca828e18e4c7586f3587300007c1dd7c.csv
/data/wwwroot/somshu/clinic/work/readme.txt
/data/wwwroot/somshu/admin/clinic/work/readme.txt
```
> 选项-path的参数可以使用通配符来匹配文件路径或文件。。-path则将文件路径作为一个整体进行匹配

```
[root@localhost tmp]# find /data/wwwroot/somshu -path '*process*' -print
/data/wwwroot/somshu/vendor/monolog/monolog/doc/02-handlers-formatters-processors.md
/data/wwwroot/somshu/thinkphp_old/library/think/process
/data/wwwroot/somshu/thinkphp_old/library/think/process/Builder.php
/data/wwwroot/somshu/thinkphp_old/library/think/process/exception
/data/wwwroot/somshu/thinkphp_old/library/think/process/exception/Failed.php
/data/wwwroot/somshu/thinkphp_old/library/think/process/exception/Timeout.php
/data/wwwroot/somshu/thinkphp_old/library/think/process/pipes
```

>选项-regex的参数和-path的类似，只不过-regex是基于正则表达式来匹配文件路径的。
```
[root@localhost shell_test]# find /tmp/shell_test/ -regex ".*\(\.txt\|\.sh\)$"
/tmp/shell_test/bin/hello.sh
/tmp/shell_test/hello_2.sh
/tmp/shell_test/hello.sh
/tmp/shell_test/abc.txt
```
#### 5.2.2 否定参数
> find也可以用“!”否定参数的含义。例如：
==$ find . ! -name "*.txt" -print==
上面的find命令能够匹配所有不以.txt结尾的文件名。

> 案例1
```
[root@localhost shell_test]# find /tmp/shell_test/ ! -name '*.txt' -print
/tmp/shell_test/
/tmp/shell_test/bin
/tmp/shell_test/bin/hello.sh
/tmp/shell_test/wwwbak
/tmp/shell_test/wwwcopy
/tmp/shell_test/hello_2.sh
/tmp/shell_test/hello.sh
/tmp/shell_test/scriptfifo
```
#### 5.2.3 基于目录深度的搜索 ==-maxdepth==  ==-mindepth==
> find命令在使用时会遍历所有的子目录。我们可以采用一些深度参数来限制find命令遍历的深度。-maxdepth和-mindepth就是这类参数。大多数情况下，我们只需要在当前目录中进行搜索，无须再继续向下查找。对于这种情况，我们使用深度参数来限制find命令向下查找的深度。如果只允许find在当前目录中查找，深度可以设置为1；当需要向下两级时，深度可以设置为2；其他情况可以依次类推。</br></br>
> 可以用-maxdepth参数指定最大深度,。与此相似，我们也可以指定一个最小的深度，告诉find应该从此处开始向下查找。如果我们想从第二级目录开始搜索，那么使用-mindepth参数设置最小深度。使用下列命令将find命令向下的最大深度限制为1：</br>
==$ find . -maxdepth 1 -type f -print== </br>
该命令只列出当前目录下的所有普通文件。即使有子目录，也不会被打印或遍历。与之类似，-maxdepth 2最多向下遍历两级子目录。

> -mindepth类似于-maxdepth，不过它设置的是find遍历的最小深度。这个选项可以用来查找并打印那些距离起始路径超过一定深度的所有文件。例如，打印出深度距离当前目录至少两个子目录的所有文件：
```
$ find . -mindepth 2 -type f -print./dir1/dir2/file1./dir3/dir4/f2
```

> 案例1
```
[root@localhost shell_test]# pwd
/tmp/shell_test
[root@localhost shell_test]# ls -lht
总用量 4.0K
-rw-r--r-- 1 root root  0 8月   1 01:55 abc.txt
prw-r--r-- 1 root root  0 7月  31 17:12 scriptfifo
lrwxrwxrwx 1 root root 28 7月  23 17:43 hello_2.sh -> /tmp/shell_test/bin/hello.sh
drwxr-xr-x 2 root root 22 7月  23 17:43 bin
drwxr-xr-x 2 root root  6 7月  20 18:26 wwwcopy
drwxr-xr-x 2 root root  6 7月  20 18:09 wwwbak
-rw-r--r-- 1 root root 78 7月  19 16:26 hello.sh
[root@localhost shell_test]# find /tmp/shell_test/ -maxdepth 1 -type f -print
/tmp/shell_test/hello.sh
/tmp/shell_test/abc.txt
[root@localhost shell_test]# find /tmp/shell_test/ -maxdepth 2 -type f -print
/tmp/shell_test/bin/hello.sh
/tmp/shell_test/hello.sh
/tmp/shell_test/abc.txt
```

> 案例2
```
[root@localhost shell_test]# find /tmp/shell_test/ -mindepth 2 -type f -print
/tmp/shell_test/bin/hello.sh
```
==-maxdepth和-mindepth应该作为find的第3个参数出现。如果作为第4个或之后的参数，就可能会影响到find的效率，因为它不得不进行一些不必要的检查。==

> 目录深度作为第三个参数，-type作为第四个参数，那么find就能够在找到所有符合指定深度的文件后，再检查这些文件的类型，这才是最有效的搜索顺序。

#### 5.2.4 根据文件类型搜索
> 类UNIX系统将一切都视为文件。文件具有不同的类型，例如普通文件、目录、字符设备、块设备、符号链接、硬链接、套接字以及FIFO等。

![文件类型](26E0112D682E4D178545EF3DFC1661A8)

==-type可以对文件搜索进行过滤。借助这个选项，我们可以为find命令指明特定的文件匹配类型。==

```
[artisan@localhost ~]$ find /data/wwwroot/smilalign/ -maxdepth 1 -type f -name '*.php' -print
/data/wwwroot/smilalign/build.php
```

#### 5.2.5 根据文件时间进行搜索
> UNIX/Linux文件系统中的每一个文件都有三种时间戳（timestamp），如下所示。 </br>
•访问时间（-atime）：用户最近一次访问文件的时间。</br> 
•修改时间（-mtime）：文件内容最后一次被修改的时间。</br> •变化时间（-ctime）：文件元数据（metadata，例如权限或所有权）最后一次改变的时间。

==在UNIX中并没有所谓“创建时间”的概念。==

> -atime、-mtime、-ctime可作为find的时间参数。它们可以整数值给出，单位是天。这些整数值通常还带有-或+：-表示小于，+表示大于，如下所示。

> 案例1. 打印出/data/wwwroot/somshu/hlkq/, 3层目录内，最近7天内被访问过的为.php的所有文件

```
[root@localhost tmp]# find /data/wwwroot/somshu/hlkq/ -maxdepth 3 -type f -name '*.php' -mtime -7 -print  
/data/wwwroot/somshu/hlkq/api/controller/Qrcode.php
/data/wwwroot/somshu/hlkq/common/controller/WxController.php
/data/wwwroot/somshu/hlkq/index/service/Wechat.php
/data/wwwroot/somshu/hlkq/route.php
/data/wwwroot/somshu/hlkq/qualitycard/controller/Qualitycard.php
/data/wwwroot/somshu/hlkq/qualitycard/service/Qualitycard.php
/data/wwwroot/somshu/hlkq/qualitycard/validate/Qualitycard.php
```
> 案例2. 打印出/data/wwwroot/somshu/admin/, 3层目录内，恰好在7天前被访问过的为.php的所有文件

```
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 3 -type f -name '*.php' -mtime 7 -print
/data/wwwroot/somshu/admin/factory/validate/Processing.php
/data/wwwroot/somshu/admin/route.php
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 3 -type f -name '*.php' -mtime 7 -exec ls -lht '{}' ';'
-rw-r--r-- 1 root root 1.1K 7月  25 16:33 /data/wwwroot/somshu/admin/factory/validate/Processing.php
-rw-rw-r-- 1 root root 32K 7月  25 16:33 /data/wwwroot/somshu/admin/route.php
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 3 -type f -name '*.php' -mtime 7 -exec ls -lht {} \;
-rw-r--r-- 1 root root 1.1K 7月  25 16:33 /data/wwwroot/somshu/admin/factory/validate/Processing.php
-rw-rw-r-- 1 root root 32K 7月  25 16:33 /data/wwwroot/somshu/admin/route.php
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 3 -type f -name '*.php' -mtime 7 -exec ls -lht '{}' + 
-rw-r--r-- 1 root root 1.1K 7月  25 16:33 /data/wwwroot/somshu/admin/factory/validate/Processing.php
-rw-rw-r-- 1 root root  32K 7月  25 16:33 /data/wwwroot/somshu/admin/route.php
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 3 -type f -name '*.php' -mtime 7 -exec ls -lht {} +  
-rw-r--r-- 1 root root 1.1K 7月  25 16:33 /data/wwwroot/somshu/admin/factory/validate/Processing.php
-rw-rw-r-- 1 root root  32K 7月  25 16:33 /data/wwwroot/somshu/admin/route.php
```
> 案例3. 打印出/data/wwwroot/somshu/admin/, 1层目录内，超过7天被访问过的为.php的所有文件

```
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 1 -type f -name '*.php' -mtime +7 -exec ls -lht '{}' +
-rw-rw-r-- 1 root root 1009 5月   3 12:07 /data/wwwroot/somshu/admin/tags.php
-rw-rw-r-- 1 root root  628 5月   3 12:07 /data/wwwroot/somshu/admin/common.php
-rw-rw-r-- 1 root root  618 5月   3 12:07 /data/wwwroot/somshu/admin/command.php
-rw-rw-r-- 1 root root 9.8K 4月   9 19:13 /data/wwwroot/somshu/admin/config.php
-rw-rw-r-- 1 root root 2.0K 2月   5 16:41 /data/wwwroot/somshu/admin/database.php
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 1 -type f -name '*.php' -mtime +7 -exec ls -lht '{}' '+'
-rw-rw-r-- 1 root root 1009 5月   3 12:07 /data/wwwroot/somshu/admin/tags.php
-rw-rw-r-- 1 root root  628 5月   3 12:07 /data/wwwroot/somshu/admin/common.php
-rw-rw-r-- 1 root root  618 5月   3 12:07 /data/wwwroot/somshu/admin/command.php
-rw-rw-r-- 1 root root 9.8K 4月   9 19:13 /data/wwwroot/somshu/admin/config.php
-rw-rw-r-- 1 root root 2.0K 2月   5 16:41 /data/wwwroot/somshu/admin/database.php
[root@localhost tmp]# find /data/wwwroot/somshu/admin/ -maxdepth 1 -type f -name '*.php' -mtime +7 -exec ls -lht {} +
-rw-rw-r-- 1 root root 1009 5月   3 12:07 /data/wwwroot/somshu/admin/tags.php
-rw-rw-r-- 1 root root  628 5月   3 12:07 /data/wwwroot/somshu/admin/common.php
-rw-rw-r-- 1 root root  618 5月   3 12:07 /data/wwwroot/somshu/admin/command.php
-rw-rw-r-- 1 root root 9.8K 4月   9 19:13 /data/wwwroot/somshu/admin/config.php
-rw-rw-r-- 1 root root 2.0K 2月   5 16:41 /data/wwwroot/somshu/admin/database.php
```

> -atime、-mtime以及-ctime都是基于时间的参数，其计量单位是“天”。还有其他一些基于时间的参数是以==分钟==作为计量单位的。这些参数包括：   
•-amin（访问时间）；   
•-mmin（修改时间）；   
•-cmin（变化时间）。

> 案例1. 查找 /data/wwwroot/somshu/  在60分钟内修改的.php文件

```
[root@localhost tmp]# find /data/wwwroot/somshu/  -type f -name '*.php' -mmin -60 -exec ls -lht '{}' +           
-rw-rw-r-- 1 root root 12K 8月   2 18:49 /data/wwwroot/somshu/clinic/weiapp/service/Index.php
```

## 6.xargs
> xargs是一个很有用的命令，它擅长将标准输入数据转换成命令行参数。xargs能够处理stdin并将其转换为特定命令的命令行参数。xargs也可以将单行或多行文本输入转换成其他格式，例如单行变多行或是多行变单行。

> xargs命令应该紧跟在管道操作符之后。它以标准输入作为主要的源数据流，并使用stdin并通过提供命令行参数来执行其他命令。例如：command | xargs

==只需要将换行符移除，再用" "（空格）进行代替，就可以实现多行输入的转换。'\n'被解释成一个换行符，换行符其实就是多行文本之间的定界符。利用xargs，我们可以用空格替换掉换行符，这样一来，就能够将多行文本转换成单行文本：==
> 案例1. 将多行输入转换成单行输出
```
[artisan@localhost test]$ cat example.txt 
1 2 3 4 5 6
7 8 9 10
11 12
[artisan@localhost test]$ cat example.txt | xargs
1 2 3 4 5 6 7 8 9 10 11 12
```

将单行输入转换成多行输出
> 指定每行最大的参数数量n，我们可以将任何来自stdin的文本划分成多行，每行n个参数。每一个参数都是由" "（空格）隔开的字符串。空格是默认的定界符。按照下面的方法可以将单行划分成多行：

```
[artisan@localhost test]$ cat example.txt | xargs -n 3
1 2 3
4 5 6
7 8 9
10 11 12
```

> 我们可以用自己的定界符来分隔参数。用-d选项为输入指定一个定制的定界符：
```
[artisan@localhost test]$ echo "splitXwangtianshiXliaoning" | xargs -d X
split wangtianshi liaoning
同时结合-n，我们可以将输入划分成多行，而每行包含两个参数：

[artisan@localhost test]$ echo "wangtianshiXzhenbowenXouyanglinXliuyijie" | xargs -d X -n 2
wangtianshi zhenbowen
ouyanglin liuyijie
```

> 案例2. 读取stdin，将格式化参数传递给命令 </br>
编写一个小型的定制版echo来更好地理解用xargs提供命令行参数的方法：

```
[artisan@localhost bin]$ vim cecho.sh 
#!/bin/bash
#文件名 cecho.sh
echo $*'#'  
当参数被传递给文件cecho.sh后，它会将这些参数打印出来，并以#字符作为结尾。
[artisan@localhost bin]$ ./cecho.sh hello world
hello world#
[artisan@localhost bin]$ ./cecho.sh arg1
arg1#
[artisan@localhost bin]$ ./cecho.sh arg2
arg2#
[artisan@localhost bin]$ ./cecho.sh arg3
arg3#
[artisan@localhost bin]$ ./cecho.sh arg1 arg2 arg3
arg1 arg2 arg3#
```

> 上面的问题也可以用xargs来解决。我们有一个名为args.txt的参数列表文件，这个文件的内容如下：

```
[artisan@localhost bin]$ cat args.txt 
arg1
arg2
arg3
就第一个问题，我们可以将这个命令执行多次，每次使用一个参数：
[artisan@localhost bin]$ cat args.txt | xargs -n 1 ./cecho.sh 
arg1#
arg2#
arg3#
每次执行需要X个参数的命令时，使用：INPUT | xargs –n X
[artisan@localhost bin]$ cat args.txt | xargs -n 2 ./cecho.sh 
arg1 arg2#
arg3#
就第二个问题，我们可以执行这个命令，并一次性提供所有的参数：
[artisan@localhost bin]$ cat args.txt | xargs ./cecho.sh 
arg1 arg2 arg3#

```

> 在上面的例子中，我们直接为特定的命令（例如cecho.sh）提供命令行参数。这些参数都只源于args.txt文件。但实际上除了它们外，我们还需要一些固定不变的命令参数。思考下面这种命令格式：
```
./cecho.sh –p arg1 –l
```
> 在上面的命令执行过程中，arg1是唯一的可变文本，其余部分都保持不变。我们应该从文件（args.txt）中读取参数，并按照下面的方式提供给命令：
```
[artisan@localhost bin]$ ./cecho.sh -p arg1 -l
-p arg1 -l#
[artisan@localhost bin]$ ./cecho.sh -p arg2 -l
-p arg2 -l#
[artisan@localhost bin]$ ./cecho.sh -p arg3 -l
-p arg3 -l#
```

> xargs有一个选项-I，可以提供上面这种形式的命令执行序列。我们可以用-I指定一个替换字符串，这个字符串在xargs扩展时会被替换掉。当-I与xargs结合使用时，对于每一个参数，命令都会被执行一次。

```
[artisan@localhost bin]$ cat args.txt | xargs -I {} ./cecho.sh -p {} -l
-p arg1 -l#
-p arg2 -l#
-p arg3 -l#
```

==-I {}指定了替换字符串。对于每一个命令参数，字符串{}会被从stdin读取到的参数所替换。使用-I的时候，命令就似乎是在一个循环中执行一样。如果有三个参数，那么命令就会连同{}一起被执行三次，而{}在每一次执行中都会被替换为相应的参数。==

### 6.2 结合find使用args
> xargs和find算是一对死党。两者结合使用可以让任务变得更轻松。不过，人们通常却是以一种错误的组合方式使用它们。例如：
```
$ find . -type f -name "*.txt" -print | xargs rm -f
```
*这样做很危险。有时可能会删除不必要删除的文件。我们没法预测分隔find命令输出结果的定界符究竟是'\n'还是' '。很多文件名中都可能会包含空格符，而xargs很可能会误认为它们是定界符（例如，hell text.txt会被xargs误认为hell和text.txt）。*

> 只要我们把find的输出作为xargs的输入，就必须将-print0与find结合使用，以字符null来分隔输出。

```
[yjs@localhost 201804]$ find -name '*.txt'
./aaa.txt
./file a.txt
./file b.txt
./file c.txt
[yjs@localhost 201804]$ find -name '*.txt' | xargs rm
rm: 无法删除"./file": 没有那个文件或目录
rm: 无法删除"a.txt": 没有那个文件或目录
rm: 无法删除"./file": 没有那个文件或目录
rm: 无法删除"b.txt": 没有那个文件或目录
rm: 无法删除"./file": 没有那个文件或目录
rm: 无法删除"c.txt": 没有那个文件或目录
[yjs@localhost 201804]$ find -name '*.txt' -print0
./file a.txt./file b.txt./file c.txt
[yjs@localhost 201804]$ find -name '*.txt' -print0 | xargs -0 rm -f
[yjs@localhost 201804]$ find -name '*.txt' -print0

```
这样就可以删除所有的.txt文件。xargs-0将\0作为输入定界符。

>  统计代码目录中所有.php程序文件的行数
```
[yjs@localhost ~]$ find /data/wwwroot/somshu/admin/ -type f -name '*.php' -print0 | xargs -0 wc -l
     28 /data/wwwroot/somshu/admin/ar/service/User.php
     26 /data/wwwroot/somshu/admin/ar/validate/Statis.php
     26 /data/wwwroot/somshu/admin/ar/validate/User.php
    158 /data/wwwroot/somshu/admin/template/controller/Template.php
    185 /data/wwwroot/somshu/admin/template/service/Template.php
  43500 总用量
```

> 统计目录中所有 .php 程序文件的行数并进行排序
```
[yjs@localhost ~]$ find /data/wwwroot/somshu/admin/ -type f -name '*.php' -print0 | xargs -0 wc -l | sort -nr
  43500 总用量
   2333 /data/wwwroot/somshu/admin/admin/controller/Telemarket.php
   2326 /data/wwwroot/somshu/admin/admin/service/Telemarket.php
   1687 /data/wwwroot/somshu/admin/admin/service/PrepayCard.php
   1271 /data/wwwroot/somshu/admin/admin/controller/PrepayCard.php
   1055 /data/wwwroot/somshu/admin/clinic/work/controller/WorkToday.php
    991 /data/wwwroot/somshu/admin/admin/service/ShopRelate.php
    888 /data/wwwroot/somshu/admin/clinic/shop/controller/ShopManagement.php
    738 /data/wwwroot/somshu/admin/common/service/ClinicManager.php
    700 /data/wwwroot/somshu/admin/beaver/controller/Goods.php
    698 /data/wwwroot/somshu/admin/clinic/work/service/WorkToday.php
    696 /data/wwwroot/somshu/admin/beaver/service/Goods.php
    695 /data/wwwroot/somshu/admin/beaver/service/Store.php
    693 /data/wwwroot/somshu/admin/beaver/service/ChargesManager.php
    687 /data/wwwroot/somshu/admin/beaver/controller/Store.php
    644 /data/wwwroot/somshu/admin/beaver/controller/Charges.php
    595 /data/wwwroot/somshu/admin/route.php
    591 /data/wwwroot/somshu/admin/clinic/work/model/WorkToday.php
    581 /data/wwwroot/somshu/admin/factory/service/Goods.php
    
[yjs@localhost ~]$ find /data/wwwroot/somshu/ -type f -name '*.php' -print0 | xargs -0 wc -l | sort -nr | head -12
 253926 总用量
 210773 总用量
   3480 /data/wwwroot/somshu/extend/idvalidator/GB2260.php
   2852 /data/wwwroot/somshu/vendor/picqer/php-barcode-generator/src/BarcodeGenerator.php
   2850 /data/wwwroot/somshu/thinkphp/library/think/db/Query.php
   2813 /data/wwwroot/somshu/thinkphp_old/library/think/db/Query.php
   2545 /data/wwwroot/somshu/extend/alioss/src/OSS/OssClient.php
   2343 /data/wwwroot/somshu/vendor/workerman/workerman/Worker.php
   2333 /data/wwwroot/somshu/admin/admin/controller/Telemarket.php
   2326 /data/wwwroot/somshu/admin/admin/service/Telemarket.php
   2268 /data/wwwroot/somshu/vendor/symfony/http-foundation/Tests/RequestTest.php
   2268 /data/wwwroot/somshu/thinkphp/library/think/Model.php

[yjs@localhost ~]$ find /data/wwwroot/somshu -type f -name '*.php' -print0 | xargs -0 wc -l | sort -nr | tail
      4 /data/wwwroot/somshu/vendor/littlespark/aliyun-sms/vendor/guzzlehttp/guzzle/src/Exception/TooManyRedirectsException.php
      4 /data/wwwroot/somshu/vendor/littlespark/aliyun-sms/vendor/guzzlehttp/guzzle/src/Exception/GuzzleException.php
      4 /data/wwwroot/somshu/vendor/guzzlehttp/guzzle/src/Exception/TransferException.php
      4 /data/wwwroot/somshu/vendor/guzzlehttp/guzzle/src/Exception/TooManyRedirectsException.php
      4 /data/wwwroot/somshu/vendor/guzzlehttp/guzzle/src/Exception/GuzzleException.php
      3 /data/wwwroot/somshu/vendor/khanamiryan/qrcode-detector-decoder/tests/bootstrap.php
      3 /data/wwwroot/somshu/vendor/endroid/qr-code/tests/Bundle/app/bootstrap.php
      3 /data/wwwroot/somshu/extend/alioss/index.php
      2 /data/wwwroot/somshu/vendor/bacon/bacon-qr-code/autoload_register.php
      1 /data/wwwroot/somshu/vendor/easywechat-composer/easywechat-composer/extensions.php
```
==srot: -n 按照值的大小进行排序 -r 以相反的顺序进行排序==

> 结合stdin，巧妙运用while语句和子shell

```
[artisan@localhost bin]$ cat args.txt | ( while read arg; do echo $arg; done ) 
arg1
arg2
arg3

等同于

[artisan@localhost bin]$ cat args.txt | xargs -I {} echo {}
arg1
arg2
arg3
```
> xargs只能以有限的几种方式来提供参数，而且它也不能为多组命令提供参数。要执行一些包含来自标准输入的多个参数的命令，可采用一种非常灵活的方法。我将这个方法称为子shell妙招（subshell hack）。一个包含while循环的子shell可以用来读取参数，并通过一种巧妙的方式执行命令：
```
$ cat files.txt | ( while read arg; do cat $arg; done )
#等同于 cat files.txt | xargs -I {} cat {} </br>
在while循环中，可以将cat $arg替换成任意数量的命令，
这样我们就可以对同一个参数执行多项命令。
我们也可以不借助管道，将输出传递给其他命令。这个技巧能适用于各种问题环境。子shell内部的多个命令可作为一个整体来运行。
$ cmd0 | ( cmd1;cmd2;cmd3) | cmd4
如果cmd1是cd/，那么就会改变子shell工作目录，然而这种改变仅局限于子shell内部。cmd4则完全不知道工作目录发生了变化。
```

## 7. 用 tr 进行转换

```
tr可以对来自标准输入的字符进行替换、删除以及压缩。它可以将一组字符变成另一组字符，因而通常也被称为转换（translate）命令。
```

> 将输入字符由大写转换成小写
```
[root@localhost ~]# echo 'HELLO WHO IS THIS' | tr 'A-Z' 'a-z'
hello who is this
[root@localhost ~]# echo 'wangtianshi' | tr 'a-z' 'A-Z'
WANGTIANSHI
[root@localhost ~]# echo 'yujiansong' | tr 'a-z' 'A-Z'
YUJIANSONG
```

> 通过在tr中使用集合的概念，我们可以轻松地将字符从一个集合映射到另一个集合中。让我们通过一则示例看看如何用tr进行数字加密和解密。

```
#加密
[root@localhost ~]# echo '123456' | tr 0-9 9876543210
876543

#解密
[root@localhost ~]# echo '876543' | tr 9876543210 0-9
123456
```

> tr还可以用来将制表符转换成空格：
```
[root@localhost testing]# cat learn.txt | tr '\t' ' '
hello world, wangtianshi
```

### 7.2 用 tr 来删除字符
> tr有一个选项-d，可以通过指定需要被删除的字符集合，将出现在stdin中的特定字符清除掉：

```
[root@localhost testing]# cat learn.txt 
hello   world,  wangtianshi
zhengbowen is good boy
123     456     789

[root@localhost testing]# cat learn.txt | tr -d [wangtish]   
ello    orld,
zeboe  ood boy
123     456     789


[root@localhost testing]# cat learn.txt | tr -d [0-9]
hello   world,  wangtianshi
zhengbowen is good boy

[root@localhost testing]# echo "Hello 123 World 456" | tr -d [0-9]
Hello  World 
```

### 7.3 字符集补集
> 我们可以利用选项-c来使用set1的补集。-c[set]等同于定义了一个集合（补集），这个集合中的字符不包含在[set]中：</br>
tr -c [set1] [set2] </br>
set1的补集意味着这个集合中包含set1中没有的所有字符。

```
[root@localhost testing]# echo "HELLO 123 WORLD 456" | tr -d -c '0-9 \n'
 123  456
```
*在这里，补集中包含了除数字、空格字符和换行符之外的所有字符。因为指定了-d，所以这些字符全部都被删除。*

```
[root@localhost testing]# echo "HELLO 123 WORLD 456" | tr -d -c 'A-Z \n'
HELLO  WORLD 
```

### 7.4 用 tr 压缩字符
> tr命令在很多文本处理环境中相当有用。多数情况下，</br> 连续的重复字符应该被压缩成单个字符，而经常需要进行的一项任务就是压缩空白字符。</br>
tr的-s选项可以压缩输入中重复的字符，方法如下：

```
[root@localhost testing]# echo "wangtianshi is a good  boy    ok." | tr -s ' '
wangtianshi is a good boy ok.
```

> 让我们用一种巧妙的方式用tr将文件中的数字列表进行相加：

```
[root@localhost testing]# cat sum.txt 
1
2
3
4
5
6
[root@localhost testing]# cat sum.txt | echo $[ $(tr '\n' '+' ) 0 ]
21
```
==在上面的命令中，tr用来将'\n'替换成'+'，因此我们得到了字符串"1+2+3+…5+"，但是在字符串的尾部多了一个操作符+。为了抵消这个多出来的操作符，我们再追加一个0。==

### 7.5 字符类
> tr可以像使用集合一样使用各种不同的字符类，这些字符类如下所示。

```
[root@localhost testing]# cat learn.txt 
hello   world,  wangtianshi
zhengbowen is good boy
123     456     789
[root@localhost testing]# cat learn.txt | tr '[:lower:]' '[:upper:]'
HELLO   WORLD,  WANGTIANSHI
ZHENGBOWEN IS GOOD BOY
123     456     789
```
