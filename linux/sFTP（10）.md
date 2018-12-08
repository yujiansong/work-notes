### 使用 sFTP 传输文件/文件夹
> sFTP（安全文件传输程序）是一种安全的交互式文件传输程序，其工作方式与 FTP（文件传输协议）类似。 然而，sFTP 比 FTP 更安全；它通过加密 SSH 传输处理所有操作。
> 它可以配置使用几个有用的 SSH 功能，如公钥认证和压缩。 它连接并登录到指定的远程机器，然后切换到交互式命令模式，在该模式下用户可以执行各种命令。

#### 如何在 Linux 中使用 sFTP 传输文件/文件夹
> 默认情况下，SFTP 协议采用和 SSH 传输协议一样的方式建立到远程服务器的安全连接。虽然，用户验证使用类似于 SSH 默认设置的密码方式，但是，建议创建和使用 SSH 无密码登录，以简化和更安全地连接到远程主机。

```
#要连接到远程 sftp 服务器，如下建立一个安全 SSH 连接并创建 SFTP 会话：
[root@localhost ~]# sftp artisan@192.168.1.10
Connected to 192.168.1.10.
sftp> 
sftp> ls
20181109.txt                           Telemarket.php                         a.php                                  bin          
sftp> pwd
Remote working directory: /home/artisan
sftp> lpwd
Local working directory: /root
sftp> mkdir uploads_for_192_168_1_9  #在连接的远程服务器上创建文件目录
```

#### 如何使用 sFTP 上传文件夹
> 要将整个目录上传到远程 Linux 主机中，请使用 put 命令。
-r 参数允许拷贝子目录和子文件：

```
sftp> put -r 192_168_1_9
Uploading 192_168_1_9/ to /home/artisan/192_168_1_9
Entering 192_168_1_9/
192_168_1_9/192_168_1_9.txt                                                                                                100%    0     0.0KB/s   00:00 

sftp> ls 
192_168_1_9 
[artisan@localhost ~]$ whoami
artisan
[artisan@localhost ~]$ ls -lhd 192_168_1_9/
drwxr-xr-x 2 artisan artisan 29 12月  5 10:47 192_168_1_9/
#要保留修改时间、访问时间以及被传输的文件的模式，请使用 -p 标志。
sftp> put -pr 192_168_1_9/
Uploading 192_168_1_9/ to /home/artisan/192_168_1_9
Entering 192_168_1_9/
192_168_1_9/192_168_1_9.txt                                                                                                100%    0     0.0KB/s   00:00  
[artisan@localhost ~]$ ls -lhd 192_168_1_9/
drwxr-xr-x 2 artisan artisan 29 12月  5 10:42 192_168_1_9/
```

#### 如何使用 sFTP 下载文件夹
> 要从远程 Linux 主机下载整个 192.168.1.10 文件夹到本机中，如下所示使用 get 命令带上 -r 标志：

```
sftp> get -r 192_168_1_10/
Fetching /home/artisan/192_168_1_10/ to 192_168_1_10
Retrieving /home/artisan/192_168_1_10
/home/artisan/192_168_1_10/192_168_1_10.txt                                                                                100%   12     0.0KB/s   00:00    
sftp> lls
192_168_1_10
#要退出sftp
sftp> bye
[root@localhost ~]# sftp artisan@192.168.1.10
Connected to 192.168.1.10.
sftp> exit
```