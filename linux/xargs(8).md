### 参数代换： xargs

> xargs 是在做什么的呢？就以字面上的意义来看， x 是加减乘除的乘号，args 则是 arguments (参数) 的意思，所以说，这个玩意儿就是在产生某个命令的参数的意思！ xargs 可以读入 stdin 的数据，并且以空格符或断行字符作为分辨，将 stdin 的数据分隔成为 arguments 。 因为是以空格符作为分隔，所以，如果有一些档名或者是其他意义的名词内含有空格符的时候， xargs 可能就会误判了～他的用法其实也还满简单的！就来看一看先！

```
[root@www ~]# xargs [-0epn] command
选项与参数：
-0  ：如果输入的 stdin 含有特殊字符，例如 `, \, 空格键等等字符时，这个 -0 参数
      可以将他还原成一般字符。这个参数可以用于特殊状态喔！
-e  ：这个是 EOF (end of file) 的意思。后面可以接一个字符串，当 xargs 分析到
      这个字符串时，就会停止继续工作！
-p  ：在运行每个命令的 argument 时，都会询问使用者的意思；
-n  ：后面接次数，每次 command 命令运行时，要使用几个参数的意思。看范例三。
当 xargs 后面没有接任何的命令时，默认是以 echo 来进行输出喔！

范例一：将 /etc/passwd 内的第一栏取出，仅取三行，使用 finger 这个命令将每个
        账号内容秀出来
[root@izbp10vxf7nhzxulpx8k4wz ~]# cut -d ':' -f1 /etc/passwd | tail -3 | xargs finger
Login: apache                           Name: Apache
Directory: /usr/share/httpd             Shell: /sbin/nologin
Never logged in.
No mail.
No Plan.

Login: yjs                              Name: 工匠
Directory: /home/yjs                    Shell: /bin/bash
Office: 17G, 075512345678               Home Phone: +1-306-666-7777
Last login Fri Nov 16 15:51 (CST) on pts/4 from 119.137.54.234
No mail.
No Plan.

Login: tom                              Name: 
Directory: /home/tom                    Shell: /bin/bash
Last login Wed Nov 14 17:04 (CST) on pts/4 from 119.137.53.88
No mail.
No Plan.

# 由 finger account 可以取得该账号的相关说明内容，例如上面的输出就是 finger root
# 后的结果。在这个例子当中，我们利用 cut 取出账号名称，用 head 取出三个账号，
# 最后则是由 xargs 将三个账号的名称变成 finger 后面需要的参数！

范例二：同上，但是每次运行 finger 时，都要询问使用者是否动作？
[root@izbp10vxf7nhzxulpx8k4wz ~]# cut -d ':' -f1 /etc/passwd | tail -3 | xargs -p finger
finger apache yjs tom ?...y
Login: apache                           Name: Apache
Directory: /usr/share/httpd             Shell: /sbin/nologin
Never logged in.
No mail.
No Plan.

Login: yjs                              Name: 工匠
Directory: /home/yjs                    Shell: /bin/bash
Office: 17G, 075512345678               Home Phone: +1-306-666-7777
Last login Fri Nov 16 15:51 (CST) on pts/4 from 119.137.54.234
No mail.
No Plan.

Login: tom                              Name: 
Directory: /home/tom                    Shell: /bin/bash
Last login Wed Nov 14 17:04 (CST) on pts/4 from 119.137.53.88
No mail.
No Plan.
# 呵呵！这个 -p 的选项可以让用户的使用过程中，被询问到每个命令是否运行！

范例三：将所有的 /etc/passwd 内的账号都以 finger 查阅，但一次仅查阅五个账号
[root@izbp10vxf7nhzxulpx8k4wz ~]# cut -d ':' -f1 /etc/passwd | xargs -p -n 5 finger
finger root bin daemon adm lp ?...n
finger sync shutdown halt mail operator ?...n
finger games ftp nobody systemd-network dbus ?...n
finger polkitd postfix chrony sshd ntp ?...n
finger tcpdump nscd www redis zarafa ?...n
finger tss vsftpd virtusers apache yjs ?...n
finger tom ?...y
Login: tom                              Name: 
Directory: /home/tom                    Shell: /bin/bash
Last login Wed Nov 14 17:04 (CST) on pts/4 from 119.137.53.88
No mail.
No Plan.
# 在这里鸟哥使用了 -p 这个参数来让您对于 -n 更有概念。一般来说，某些命令后面
# 可以接的 arguments 是有限制的，不能无限制的累加，此时，我们可以利用 -n
# 来帮助我们将参数分成数个部分，每个部分分别再以命令来运行！这样就 OK 啦！^_^

范例四：同上，但是当分析到 tom 就结束这串命令？
[root@izbp10vxf7nhzxulpx8k4wz ~]# cut -d ':' -f1 /etc/passwd | tail -3
apache
yjs
tom
[root@izbp10vxf7nhzxulpx8k4wz ~]# cut -d ':' -f1 /etc/passwd | tail -3 | xargs -p -e'tom' finger
finger apache yjs ?...y
Login: apache                           Name: Apache
Directory: /usr/share/httpd             Shell: /sbin/nologin
Never logged in.
No mail.
No Plan.

Login: yjs                              Name: 工匠
Directory: /home/yjs                    Shell: /bin/bash
Office: 17G, 075512345678               Home Phone: +1-306-666-7777
Last login Fri Nov 16 15:51 (CST) on pts/4 from 119.137.54.234
No mail.
No Plan.
# 仔细与上面的案例做比较。也同时注意，那个 -e'tom' 是连在一起的，中间没有空格键。
# 上个例子当中，第五个参数是 tom 啊，那么我们下达 -e'tom' 后，则分析到 tom
# 这个字符串时，后面的其他 stdin 的内容就会被 xargs 舍弃掉了！
```

> 其实，在 man xargs 里面就有三四个小范例，您可以自行参考一下内容。 此外， xargs 真的是很好用的一个玩意儿！您真的需要好好的参详参详！会使用 xargs 的原因是， 很多命令其实并不支持管线命令，因此我们可以透过 xargs 来提供该命令引用 standard input 之用！举例来说，我们使用如下的范例来说明：
```
范例五：找出 /sbin 底下具有特殊权限的档名，并使用 ls -l 列出详细属性
[root@izbp10vxf7nhzxulpx8k4wz ~]# find /sbin/ -perm 7000 | ls -lht
total 230M
drwxr-xr-x 2 root root 4.0K Nov 21 14:25 toolink_bak
drwxr-xr-x 2 root root 4.0K Nov 21 12:09 bin
drwxr-xr-x 3 root root 4.0K Jul 30 09:52 tmp
-rw-r--r-- 1 root root  32K May  4  2018 dump.rdb
drwxr-xr-x 7 root root 4.0K Apr 20  2018 oneinstack
-rw-r--r-- 1 root root 230M Apr 19  2018 oneinstack-full.tar.gz
# 结果竟然仅有列出 root 所在目录下的文件！这不是我们要的！
# 因为 ll (ls) 并不是管线命令的原因啊！
[root@izbp10vxf7nhzxulpx8k4wz ~]# find /sbin/ -perm 700 | xargs ls -lht
-rwx------  1 root root 837K Dec  1  2017 /sbin/build-locale-archive
-rwx------  1 root root 752K Dec  1  2017 /sbin/glibc_post_upgrade.x86_64
-rwx------. 1 root root 136K Aug  2  2017 /sbin/iprdbg
-rwx------. 1 root root  36K Nov  6  2016 /sbin/unix_update
-rwx------  1 root root 6.1K Mar 27  2015 /sbin/redhat_lsb_trigger.x86_64
```

### 关于减号 - 的用途
> 管线命令在 bash 的连续的处理程序中是相当重要的！另外，在 log file 的分析当中也是相当重要的一环， 所以请特别留意！另外，在管线命令当中，常常会使用到前一个命令的 stdout 作为这次的 stdin ， 某些命令需要用到文件名 (例如 tar) 来进行处理时，该 stdin 与 stdout 可以利用减号 "-" 来替代， 举例来说：
```
[artisan@localhost tmp]$ pwd
/tmp
[artisan@localhost tmp]$ tar -cvf - /home/artisan/bin | tar -xvf -
tar: 从成员名中删除开头的“/”
/home/artisan/bin/
/home/artisan/bin/math_calculate.sh
/home/artisan/bin/transform_number
/home/artisan/bin/log_rate.sh
/home/artisan/bin/turtle_clock.py
/home/artisan/bin/hello_world.sh
/home/artisan/bin/math.sh
/home/artisan/bin/hello.sh
home/artisan/bin/
home/artisan/bin/math_calculate.sh
home/artisan/bin/transform_number
home/artisan/bin/log_rate.sh
home/artisan/bin/turtle_clock.py
home/artisan/bin/hello_world.sh
home/artisan/bin/math.sh
home/artisan/bin/hello.sh
[artisan@localhost tmp]$ ls -lht
总用量 12K
drwxrwxr-x 3 artisan artisan   21 11月 23 11:20 home
-rw------- 1 www     www     1.9K 11月 20 09:12 sess_no4u7uavap815vu2m02vu0mfr5
-rw------- 1 www     www      187 11月 16 14:07 sess_q4oqsbbmt0uram4m1im1qlku75
-rw-rw-r-- 1 artisan artisan    0 11月 13 12:12 testtouch
srwxrwxrwx 1 mysql   mysql      0 11月  7 11:37 mysql.sock
-rw-r--r-- 1 artisan artisan  283 9月   4 10:19 bashrc
srw-rw-rw- 1 www     www        0 9月   4 10:08 php-cgi.sock
[artisan@localhost tmp]$ ls -lht home/artisan/bin/
总用量 28K
-rwxr-xr-x 1 artisan artisan   59 11月 12 17:43 hello_world.sh
-rwxr-xr-x 1 artisan artisan 3.5K 11月  7 15:38 turtle_clock.py
-rwxr-xr-x 1 artisan artisan  632 11月  5 18:54 log_rate.sh
-rwxr-xr-x 1 artisan artisan  281 10月 17 15:18 transform_number
-rwxr-xr-x 1 artisan artisan  792 10月 17 14:58 math_calculate.sh
-rwxr-xr-x 1 artisan artisan  543 10月 17 12:29 math.sh
-rwxr-xr-x 1 artisan artisan   59 9月  26 12:01 hello.sh
```
> 上面这个例子是说：『我将 /home 里面的文件给他打包，但打包的数据不是纪录到文件，而是传送到 stdout； 经过管线后，将 tar -cvf - /home 传送给后面的 tar -xvf - 』。后面的这个 - 则是取用前一个命令的 stdout， 因此，我们就不需要使用 file 了！这是很常见的例子喔！注意注意！