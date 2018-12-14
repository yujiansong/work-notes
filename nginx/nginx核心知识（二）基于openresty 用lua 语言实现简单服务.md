
### 基于openresty 用lua 语言实现简单服务

```
#下载openresty
[root@localhost bestjiansong]# pwd
/home/bestjiansong
[root@localhost bestjiansong]# wget https://openresty.org/download/openresty-1.13.6.2.tar.gz
[root@localhost bestjiansong]# tar -xzf openresty-1.13.6.2.tar.gz 
[root@localhost bestjiansong]# cd openresty-1.13.6.2
[root@localhost openresty-1.13.6.2]# ls -lht
总用量 104K
drwxrwxr-x 43 1000 1000 4.0K 5月  15 2018 bundle
-rwxrwxr-x  1 1000 1000  48K 5月  15 2018 configure
-rw-rw-r--  1 1000 1000  23K 5月  15 2018 COPYRIGHT
drwxrwxr-x  2 1000 1000 4.0K 5月  15 2018 patches
-rw-rw-r--  1 1000 1000 4.6K 5月  15 2018 README.markdown
-rw-rw-r--  1 1000 1000 8.8K 5月  15 2018 README-windows.txt
drwxrwxr-x  2 1000 1000 4.0K 5月  15 2018 util
#编译openresty
[root@localhost openresty-1.13.6.2]# make && make install
[root@localhost openresty-1.13.6.2]# echo $?
0
[root@localhost openresty-1.13.6.2]# cd /usr/local/openresty/nginx/
[root@localhost nginx]# pwd
/usr/local/openresty/nginx
[root@localhost nginx]# ls -lht
总用量 16K
drwxr-xr-x 2 root root 4.0K 12月 14 17:20 html
drwxr-xr-x 2 root root 4.0K 12月 14 17:20 logs
drwxr-xr-x 2 root root 4.0K 12月 14 17:20 conf
drwxr-xr-x 2 root root 4.0K 12月 14 17:20 sbin

 35     server {
 36         listen       80;
 37         server_name  localhost;
 38 
 39         #charset koi8-r;
 40 
 41         #access_log  logs/host.access.log  main;
 42 
 43        location /lua{
 44             default_type text/html;
 45             content_by_lua 'ngx.say("User-Agent: ", ngx.req.get_headers()["User-Agent"])'; 
 46         }
 47 
 48        location / {
 49             root   html;
 50             index  index.html index.htm;
 51         }
 
 "conf/nginx.conf" 122L, 2824C 已写入                                                                   
[root@localhost nginx]# ps -ef | grep nginx
root      1639 16535  0 17:29 pts/0    00:00:00 grep nginx
[root@localhost nginx]# sbin/nginx 
[root@localhost nginx]# ps -ef | grep nginx
root      1642     1  0 17:29 ?        00:00:00 nginx: master process sbin/nginx
root      1643  1642  0 17:29 ?        00:00:00 nginx: worker process
root      1645 16535  0 17:29 pts/0    00:00:00 grep nginx
#在浏览器中访问 http://192.168.80.137/lua
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36
```

> 正常的请求是nginx->应用服务->mysql，用openresty后，有些简单的业务只需要查询数据库，那么可以变为nginx->mysql，这样就降低了请求次数及往返次数。

