> 1.把nginx服务器变更为上游服务器
```
 38     server {
 39         listen       127.0.0.1:8080; #前面加上IP地址，只有本机才可以访问
 40         server_name  localhost;
 41 
 42         #charset koi8-r;
 43 
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
 
#此时停掉nginx
[root@localhost nginx]# sbin/nginx -s stop
[root@localhost nginx]# ps -ef | grep nginx
root     17819 17647  0 15:50 pts/3    00:00:00 grep nginx
#再启动nginx
[root@localhost nginx]# sbin/nginx
#访问
http://192.168.80.138:8080/
则已经无法访问了
```
> 2.搭建一个反向代理 openresty https://www.jianshu.com/p/8d2c5bf4b179
```
[root@localhost openresty]# pwd
/usr/local/openresty
[root@localhost openresty]# cd nginx/
[root@localhost nginx]# pwd
/usr/local/openresty/nginx
[root@localhost nginx]# vim conf/nginx.conf
 37     #gzip  on;
 38     upstream local {
 39         server 127.0.0.1:8080; #上游服务器
 40     }
 41 
 50         location / {
 51             #root   html;
 52             #index  index.html index.htm;
 53             proxy_set_header Host $host;
 54             proxy_set_header X-Real-IP $remote_addr;
 55             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
 56             #proxy_cache my_cache;
 57             #proxy_cache_key $host$uri$is_args$args;
 58             #proxy_cache_valid 200 304 302 1d;
 59             proxy_pass http://local; #代理到上游服务
 60         }
 
#启动openresty的nginx服务器
[root@localhost nginx]# sbin/nginx 
[root@localhost nginx]# ps -ef | grep nginx
root     17834     1  0 15:51 ?        00:00:00 nginx: master process sbin/nginx
nobody   17835 17834  0 15:51 ?        00:00:00 nginx: worker process
root     18028     1  0 16:03 ?        00:00:00 nginx: master process sbin/nginx
nobody   18029 18028  0 16:03 ?        00:00:00 nginx: worker process
root     18031 17647  0 16:03 pts/3    00:00:00 grep nginx
#访问 http://192.168.80.138/
可以正常访问
从响应头里发现了 Server: openresty/1.13.6.2
```

#### 配置一个缓存服务器
```
 27     proxy_cache_path /tmp/nginxcache levels=1:2 keys_zone=my_cache:10m max_size=10g
 28                 inactive=60m use_temp_path=off; #缓存路径及相关配置
 
  50         location / {
 51             #root   html;
 52             #index  index.html index.htm;
 53             proxy_set_header Host $host;
 54             proxy_set_header X-Real-IP $remote_addr;
 55             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
 56             proxy_cache my_cache;  #缓存配置
 57             proxy_cache_key $host$uri$is_args$args; #缓存配置
 58             proxy_cache_valid 200 304 302 1d; #缓存配置
 59             proxy_pass http://local;
 60         }
 
 "conf/nginx.conf" 131L, 3230C 已写入                                                                   
You have new mail in /var/spool/mail/root
[root@localhost nginx]# sbin/nginx -t
nginx: the configuration file /usr/local/openresty/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/openresty/nginx/conf/nginx.conf test is successful
[root@localhost nginx]# sbin/nginx -s reload

#访问 http://192.168.80.138/ 点击几个页面生成缓存
[root@localhost nginx]# ls -lht /tmp/nginxcache/
总用量 64K
drwx------. 11 nobody nobody 4.0K 12月  2 16:14 8
drwx------. 12 nobody nobody 4.0K 12月  2 16:14 d
drwx------.  9 nobody nobody 4.0K 12月  2 16:14 6
drwx------. 10 nobody nobody 4.0K 12月  2 16:14 c
drwx------.  8 nobody nobody 4.0K 12月  2 16:14 b
drwx------. 16 nobody nobody 4.0K 12月  2 16:14 4
#停掉之前的静态web资源服务器
[root@localhost nginx]# ps -ef | grep nginx
root     17834     1  0 15:51 ?        00:00:00 nginx: master process sbin/nginx
nobody   17835 17834  0 15:51 ?        00:00:00 nginx: worker process
root     18028     1  0 16:03 ?        00:00:00 nginx: master process sbin/nginx
nobody   18152 18028  0 16:12 ?        00:00:01 nginx: worker process
nobody   18153 18028  0 16:12 ?        00:00:00 nginx: cache manager process
root     18204 17647  0 16:16 pts/3    00:00:00 grep nginx
[root@localhost nginx]# cd /usr/local/nginx
[root@localhost nginx]# pwd
/usr/local/nginx
[root@localhost nginx]# sbin/nginx -s stop
You have new mail in /var/spool/mail/root
[root@localhost nginx]# ps -ef | grep nginx
root     18028     1  0 16:03 ?        00:00:00 nginx: master process sbin/nginx
nobody   18152 18028  0 16:12 ?        00:00:01 nginx: worker process
nobody   18153 18028  0 16:12 ?        00:00:00 nginx: cache manager process
root     18208 17647  0 16:17 pts/3    00:00:00 grep nginx

#接着再次访问 http://192.168.80.138/
因为部分页面已经被nginx反向代理缓存了，所以可以访问
但是有的页面没有被缓存，因此不能正常访问
```