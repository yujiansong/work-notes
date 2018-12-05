#### 1. 用nginx搭建一个可用的静态资源web服务器

```
[root@localhost nginx]# pwd
/usr/local/nginx
#在当前目录下新建一个 dlib 目录
[root@localhost nginx]# mkdir dlib
[root@localhost nginx]# ls -lht
总用量 40K
drwxr-xr-x. 2 root   root 4.0K 12月  2 12:31 conf
drwxrwxrwx. 3 root   root 4.0K 12月  2 11:33 dlib
drwxr-xr-x. 2 root   root 4.0K 12月  2 11:18 logs
drwx------. 2 nobody root 4.0K 12月  1 18:00 client_body_temp
drwx------. 2 nobody root 4.0K 12月  1 18:00 fastcgi_temp
drwx------. 2 nobody root 4.0K 12月  1 18:00 proxy_temp
drwx------. 2 nobody root 4.0K 12月  1 18:00 scgi_temp
drwx------. 2 nobody root 4.0K 12月  1 18:00 uwsgi_temp
drwxr-xr-x. 2 root   root 4.0K 12月  1 17:57 sbin
drwxr-xr-x. 2 root   root 4.0K 12月  1 17:36 html
[root@localhost nginx]# cd dlib/
#上传静态资源文件
[root@localhost dlib]# rz -y
rz waiting to receive.
Starting zmodem transfer.  Press Ctrl+C to cancel.
  100%   12470 KB 12470 KB/s 00:00:01       0 Errors

[root@localhost dlib]# ls -lht
总用量 13M
-rw-r--r--. 1 root root 13M 1月  15 2016 Static_Full_Version.zip
#解压静态资源文件
unzip Static_Full_Version.zip
#把dlib目录下的所有文件移动奥docs目录里
[root@localhost nginx]# mv dlib/* docs/
#再把 docs目录移动到dlib目录下
[root@localhost nginx]# mv docs/ dlib/
[root@localhost nginx]# ls -lht dlib/
总用量 4.0K
drwxr-xr-x. 9 root root 4.0K 12月  2 11:32 docs
#更改dilb目录权限为777
[root@localhost nginx]# chmod -R 777 dlib
#修改 nginx.conf配置文件
 35     server {
 36         listen       8080; #修改端口号为8080
 37         server_name  localhost;
 38 
 39         #charset koi8-r;
 40 
 41         #access_log  logs/host.access.log  main;
 42 
 43         location / {
 44             alias   dlib/docs/;  #以docs目录下的文件作为静态资源文件
 45             #root   html;  #注释掉
 46             #index  index.html index.htm; #注释掉
 47         }

#检查nginx配置文件是否正确
[root@localhost nginx]# sbin/nginx -t
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful
#重新加载nginx配置服务
[root@localhost nginx]# sbin/nginx -s reload
[root@localhost nginx]# ps -ef | grep nginx
root      5821     1  0 12:00 ?        00:00:00 nginx: master process sbin/nginx
nobody    6422  5821  0 12:32 ?        00:00:00 nginx: worker process
root      6500  6313  0 12:38 pts/1    00:00:00 grep nginx
#查询服务器的地址
[root@localhost nginx]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0C:29:D0:81:00  
          inet addr:192.168.80.138  Bcast:192.168.80.255  Mask:255.255.255.0
#在浏览器端访问 192.168.80.138:8080
everything is okay!
```

#### 2.打开gzip压缩
```
 32 
 33     gzip  on; #打开gzip压缩
 34     gzip_min_length 1;  #最小压缩字节为1,
 35     gzip_comp_level 2;  #压缩登记
 36     gzip_types text/plain application/x-javascript text/css application/xml text/javascript application/x-httpd-php i
    mage/jpeg image/gif image/png; #压缩类型
 37     
 38     server {
 39         listen       8080;
 40         server_name  localhost;
 41         
 42         #charset koi8-r;
 43         
 44         #access_log  logs/host.access.log  main;
 45         
 46         location / {
 47             alias   dlib/docs/;
 48             #root   html;
 49             #index  index.html index.htm;
 50         }

#检查修改后的配置文件 
[root@localhost nginx]# sbin/nginx -t
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful
#重载配置文件
[root@localhost nginx]# sbin/nginx -s reload
再次访问首页时http://192.168.80.138:8080/
从响应头发现，使用的gzip压缩
```

#### 3.共享静态资源-显示目录结构
```
 38     server {
 39         listen       8080;
 40         server_name  localhost;
 41 
 42         #charset koi8-r;
 43 
 44         #access_log  logs/host.access.log  main;
 45 
 46         location / {
 47             alias   dlib/docs/;
 48             autoindex on; #显示文件目录结构
 49             #root   html;
 50             #index  index.html index.htm;
 51         }
 52         
 53         #error_page  404              /404.html;
 54         
"conf/nginx.conf" 122L, 2911C 已写入                   
#重载配置文件
[root@localhost nginx]# sbin/nginx -s reload
#要确保，访问的目录里，没有index.html这个文件，否则会返回这个文件的内容。
#暂时先把 index.html 更改为 i.html
[root@localhost docs]# mv index.html i.html
#在浏览器上访问
http://192.168.80.138:8080/
```

#### 4.设置nginx向客户端浏览器发送相应的速度
```
 server {
        listen       8080;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            alias   dlib/docs/;
            #autoindex on;
            set $limit_rate 1k; #每秒传输1k到浏览器
            #root   html;
            #index  index.html index.htm;
        }
#重新加载配置文件
[root@localhost nginx]# sbin/nginx -s reload
再次访问时用了好久(5.3min)才完全加载好页面!
之前没有限制发送速度是用时(885ms)
```

#### 5.设置访问日志
```
 17 http {
 18     include       mime.types;
 19     default_type  application/octet-stream;
 20 
 21     log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
 22                       '$status $body_bytes_sent "$http_referer" '
 23                       '"$http_user_agent" "$http_x_forwarded_for"';
 ...
  44         access_log  logs/geekjiansong.access.log  main;
 45 
 46         location / {
 47             alias   dlib/docs/;
 48             #autoindex on;
 49             #set $limit_rate 1k;
 50             #root   html;
 51             #index  index.html index.htm;
 52         }
 53 
 
#重新加在配置文件
[root@localhost nginx]# sbin/nginx -s reload
#生成访问日志
[root@localhost nginx]# ls -lht logs/
总用量 264K
-rw-r--r--. 1 root   root  11K 12月  2 14:16 geekjiansong.access.log
-rw-r--r--. 1 nobody root  18K 12月  2 14:16 error.log
-rw-r--r--. 1 nobody root 217K 12月  2 14:11 access.log
-rw-r--r--. 1 root   root    5 12月  2 12:00 nginx.pid

[root@localhost nginx]# tail -f logs/geekjiansong.access.log 
192.168.80.130 - - [02/Dec/2018:14:18:51 +0800] "GET /css/patterns/header-profile-skin-1.png HTTP/1.1" 200 26319 "http://192.168.80.138:8080/css/style.css" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36" "-"
```