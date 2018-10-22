## 启动
```
启动格式：nginx安装目录地址 -c nginx配置文件地址
[artisan@localhost ~]$ sudo /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```

## 停止
1. 从容停止
```
#1. 查看进程号
[artisan@localhost ~]$ ps -aux | grep nginx
www       2456  0.0  1.2  46012 24376 ?        S    12:25   0:00 nginx: worker process
artisan   9953  0.0  0.0 112724   988 pts/0    S+   14:15   0:00 grep --color=auto nginx
root     31625  0.0  0.1  24800  3352 ?        Ss   11:42   0:00 nginx: master process /usr/local/nginx/sbin/nginx

#2.杀死进程
[artisan@localhost ~]$ sudo kill -QUIT 31625
[artisan@localhost ~]$ ps -aux | grep nginx
artisan  10043  0.0  0.0 112724   988 pts/0    R+   14:16   0:00 grep --color=auto nginx
```

2. 快速停止
TERM----是请求彻底终止某项执行操作.它期望接收进程清除自给的状态并退出
```
[artisan@localhost ~]$ ps -aux | grep nginx
root     10098  0.0  0.0  24112  1548 ?        Ss   14:17   0:00 nginx: master process /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
www      10099  0.0  1.2  45364 23616 ?        S    14:17   0:00 nginx: worker process
artisan  10188  0.0  0.0 112724   988 pts/0    R+   14:18   0:00 grep --color=auto nginx

#2.杀死进程
[artisan@localhost ~]$ sudo kill -TERM 10098
[artisan@localhost ~]$ ps -aux | grep nginx
artisan  10366  0.0  0.0 112724   988 pts/0    R+   14:21   0:00 grep --color=auto nginx
```

3. 强制停止
```
[artisan@localhost ~]$ ps -aux | grep nginx
root     10383  0.0  0.0  24112  1556 ?        Ss   14:21   0:00 nginx: master process /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
www      10384  0.0  1.2  45364 23620 ?        S    14:21   0:00 nginx: worker process
artisan  10482  0.0  0.0 112724   988 pts/0    R+   14:22   0:00 grep --color=auto nginx
[artisan@localhost ~]$ sudo pkill -9 nginx
[artisan@localhost ~]$ ps -aux | grep nginx
artisan  10515  0.0  0.0 112724   988 pts/0    S+   14:23   0:00 grep --color=auto nginx
```

## 重启
1、验证nginx配置文件是否正确

```
方法一：进入nginx安装目录sbin下，输入命令./nginx -t
[artisan@localhost sbin]$ pwd
/usr/local/nginx/sbin
[artisan@localhost sbin]$ sudo ./nginx -t
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful

方法二：在启动命令-c前加-t
[artisan@localhost sbin]$ sudo /usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful
```

2.重启Nginx服务
> kill -HUP pid </br>
其中 pid 是进程标识。如果想要更改配置而不需停止并重新启动服务，则使用该命令。在对配置文件作必要的更改后，发出该命令以动态更新服务配置。
```
方法一：进入nginx可执行目录sbin下，输入命令./nginx -s reload 即可
[artisan@localhost sbin]$ sudo ./nginx -s reload

方法二：查找当前nginx进程号，然后输入命令：kill -HUP 进程号 实现重启nginx服务
[artisan@localhost sbin]$ sudo kill -HUP 11011
```