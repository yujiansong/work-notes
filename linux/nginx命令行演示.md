### nginx命令行演示

#### 1.重载配置文件 </br>
> 修改了 /nginx/conf/nginx.conf 文件，直接使用 sbin/nginx -s reload </br>
> 在不停止对客户服务的情况下，重载了配置文件
```
#打开 nginx.conf 的 tcp_nopush 选项
 28     #tcp_nopush     on; 去掉前面的注释

 28     tcp_nopush     on;
"conf/nginx.conf" 117L, 2655C 已写入

#重载配置文件 nginx -s reload
[root@localhost nginx]# sbin/nginx -s reload
```
####  2.nginx 热部署
> 用另一个更新版本的nginx的二进制文件替换正在运行的nginx的二进制文件
```
#查看运行中的nginx
[root@localhost sbin]# ps aux | grep nginx
root     10863  0.0  0.1   3896  1264 ?        Ss   16:52   0:00 nginx: master process /home/bestjiansong/nginx/sbin/nginx
nobody   20969  0.0  0.1   4044  1040 ?        S    17:26   0:00 nginx: worker process              
root     23728  0.0  0.0   5976   728 pts/1    S+   17:40   0:00 grep --color=auto nginx

#1. 安装一个新版本的nginx
[root@localhost local]# pwd
/usr/local
[root@localhost local]# wget http://nginx.org/download/nginx-1.15.7.tar.gz
[root@localhost local]# tar -xvf nginx-1.15.7.tar.gz 
[root@localhost nginx-1.15.7]# ./configure --prefix=/usr/local/nginx
[root@localhost nginx-1.15.7]# make && make install

#之前的nginx二进制文件
[root@localhost sbin]# pwd
/home/bestjiansong/nginx/sbin
[root@localhost sbin]# ls -lhta nginx 
-rwxr-xr-x. 1 root root 3.2M 12月  1 16:09 nginx

#新安装的nginx后生成的二进制文件
[root@localhost sbin]# pwd
/usr/local/nginx/sbin
You have new mail in /var/spool/mail/root
[root@localhost sbin]# ls -lht nginx 
-rwxr-xr-x. 1 root root 3.2M 12月  1 17:36 nginx

#备份要替换的nginx二进制文件
[root@localhost sbin]# cp -a nginx nginx.old
You have new mail in /var/spool/mail/root
[root@localhost sbin]# ls -lhta
总用量 6.3M
drwxr-xr-x.  2 root root 4.0K 12月  1 17:39 .
drwxr-xr-x. 11 root root 4.0K 12月  1 16:52 ..
-rwxr-xr-x.  1 root root 3.2M 12月  1 16:09 nginx
-rwxr-xr-x.  1 root root 3.2M 12月  1 16:09 nginx.old

#将新版本的ningx二进制文件放到 /home/bestjiansong/nginx/sbin/ 中，替换掉进程中正在使用的nginx二进制文件
[root@localhost sbin]# cp -a /usr/local/nginx/sbin/nginx nginx
cp：是否覆盖"nginx"？ y
cp: 无法创建普通文件"nginx": 文本文件忙
[root@localhost sbin]# cp -a /usr/local/nginx/sbin/nginx nginx -f
cp：是否覆盖"nginx"？ y
You have new mail in /var/spool/mail/root

#USR1信号对应于reopen命令，用于重新打开文件，即切割日志用的；USR2信号用于升级nginx，它会以子进程方式启动另一个nginx
[root@localhost sbin]# kill -USR2 10863
[root@localhost sbin]# ps -ef | grep nginx
root     10863     1  0 16:52 ?        00:00:00 nginx: master process /home/bestjiansong/nginx/sbin/nginx
nobody   23888 10863  0 17:51 ?        00:00:00 nginx: worker process              
root     24029 10863  0 18:00 ?        00:00:00 nginx: master process /home/bestjiansong/nginx/sbin/nginx
nobody   24031 24029  0 18:00 ?        00:00:00 nginx: worker process              
root     24068  5903  0 18:02 pts/1    00:00:00 grep --color=auto nginx
#nginx 会新启一个master进程和worker进程，是新版本

#关闭老的worker进程
[root@localhost sbin]# kill -WINCH 10863
You have new mail in /var/spool/mail/root
[root@localhost sbin]# ps -ef | grep nginx
root     10863     1  0 16:52 ?        00:00:00 nginx: master process /home/bestjiansong/nginx/sbin/nginx
root     24029 10863  0 18:00 ?        00:00:00 nginx: master process /home/bestjiansong/nginx/sbin/nginx
nobody   24031 24029  0 18:00 ?        00:00:00 nginx: worker process              
root     24106  5903  0 18:05 pts/1    00:00:00 grep --color=auto nginx
```

#### 3.切割日志
```
[root@localhost logs]# mv testing.log testing.log.bak
[root@localhost logs]# ../sbin/nginx -s reopen
```

