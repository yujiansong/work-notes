### PHP扩展Xhprof分析
#### PHP7的Xhprof安装
```
[yujiansong@jiansong software]$ pwd
/home/yujiansong/software
[yujiansong@jiansong software]$ git clone https://github.com/longxinH/xhprof.git ./xhprof
Cloning into './xhprof'...
remote: Enumerating objects: 637, done.
remote: Total 637 (delta 0), reused 0 (delta 0), pack-reused 637
Receiving objects: 100% (637/637), 1.79 MiB | 11.00 KiB/s, done.
Resolving deltas: 100% (324/324), done.
[yujiansong@jiansong software]$ cd xhprof/extension/
[yujiansong@jiansong extension]$ phpize 
Configuring for:
PHP Api Version:         20151012
Zend Module Api No:      20151012
Zend Extension Api No:   320151012
[yujiansong@jiansong extension]$ ./configure --with-php-config=/usr/local/php/bin/php-config
[yujiansong@jiansong extension]$ make && make install
Installing shared extensions:     /usr/local/php/lib/php/extensions/no-debug-non-zts-20151012/
#vim php.ini
[xhprof]
extension=xhprof.so
xhprof.output_dir=/tmp/xhprof 
#在 /tmp目录下创建 xhprof目录， chmod -R 777 xhprof
[yujiansong@jiansong etc]$ sudo lnmp restart
[sudo] password for yujiansong: 
+-------------------------------------------+
|    Manager for LNMP, Written by Licess    |
+-------------------------------------------+
|              https://lnmp.org             |
+-------------------------------------------+
Stoping LNMP...
Stoping nginx...  done
Shutting down MySQL.. SUCCESS! 
Gracefully shutting down php-fpm . done
Starting LNMP...
Starting nginx...  done
Starting MySQL. SUCCESS! 
Starting php-fpm  done
[yujiansong@jiansong etc]$ php -m | grep xhprof
xhprof

#如果出现下面的问题
Warning: proc_open() has been disabled for security reasons in /mnt/hgfs/project/yixiaocai/191117/xhprof_lib/utils/callgraph_utils.php on line 112
failed to execute cmd " dot -Tpng"
#处理办法 移除php.ini disable_functions中的 proc_open函数
299 disable_functions = passthru,exec,system,chroot,chgrp,chown,shell_exec,proc_open,proc_get_status,popen,ini_alter,ini_restore,dl,o     penlog,syslog,readlink,symlink,popepassthru,stream_socket_server

```

>访问的文件
```
<?php
//加载所需文件
include_once "./xhprof_lib/utils/xhprof_lib.php";
include_once "./xhprof_lib/utils/xhprof_runs.php";

function testingA()
{
    echo 'aaa' . PHP_EOL;
    sleep(1);
    testingB();
}

function testingB()
{
    echo 'bbb' . PHP_EOL;
    sleep(3);
    testingC();
}

function testingC()
{
    echo 'ccc' . PHP_EOL;
    sleep(6);
}

//启动 xhprof 性能分析器
xhprof_enable();
testingA();
//停止 xhprof 分析器
$xhprof_data = xhprof_disable();
$xhprof_runs = new XHProfRuns_Default();
//获取当前当前页面分析结果
$run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_foo");
echo '<br>';
$href = <<<EOF
<a href=/191123/xhprof_html/index.php?run=$run_id&source=xhprof_foo>Xhprof性能分析</a>
EOF;
echo $href;

```
> nginx.conf
```
server
    {
        listen 80;
        #listen [::]:80;
        server_name www.yixiaocai.com ;
        index index.html index.htm index.php default.html default.htm default.php;
        root  /data/wwwroot/project/yixiaocai;

        include rewrite/none.conf;
        #error_page   404   /404.html;

        # Deny access to PHP files in specific directory
        #location ~ /(wp-content|uploads|wp-includes|images)/.*\.php$ { deny all; }

        include enable-php-pathinfo.conf;

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
        {
            expires      30d;
        }

        location ~ .*\.(js|css)?$
        {
            expires      12h;
        }

        location ~ /.well-known {
            allow all;
        }

        location ~ /\.
        {
            deny all;
        }

        access_log  /home/wwwlogs/www.yixiaocai.com.log;
    }

```
### 注意事项 <br>
> 把解压出来的xhprof/xhprof_html、xhprof_lib 放到当前访问文件的同级目录中<br>
> cp -r xhprof/xhprof_html/ /mnt/hgfs/project/yixiaocai/191117/ <br>
> cp -r xhprof/xhprof_lib/ /mnt/hgfs/project/yixiaocai/191117/ <br>

> yum安装graphviz <br>
yum install -y graphviz

> 如果出现下面的问题
Warning: proc_open() has been disabled for security reasons in /mnt/hgfs/project/yixiaocai/191117/xhprof_lib/utils/callgraph_utils.php on line 112
failed to execute cmd " dot -Tpng" <br>
处理办法 移除php.ini disable_functions中的 proc_open函数 <br>

> 参考文档
```
https://github.com/longxinH/xhprof
https://segmentfault.com/a/1190000016169496#articleHeader3
https://stackoverflow.com/questions/2930254/linux-dot-utility-with-xhprof
https://github.com/phacility/xhprof/issues/94
http://blog.sina.com.cn/s/blog_6f2274fb0100zs8h.html
https://blog.csdn.net/qq_28602957/article/details/72697901
https://blog.csdn.net/maquealone/article/details/80434699

```
