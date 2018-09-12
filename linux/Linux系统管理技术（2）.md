# linux系统管理技术（2）
---
### 1.查看在线用户 w
> 系统管理员若想知道某一时刻用户的行为，只需要输入命令w即可，在SHELL终端中输入如下命令：
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ w
 00:24:27 up 103 days, 11:51,  3 users,  load average: 5.38, 3.22, 2.71
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/3    119.137.55.170   Tue09   15:24m  0.00s  0.00s -bash
yjs      pts/4    113.87.128.228   23:16    1:07m  0.00s  0.00s -bash
yjs      pts/7    113.87.128.228   00:11    3.00s  0.02s  0.00s w
```
> 1. 第一行显示系统的汇总信息，字段分别表示系统当前时间、系统运行时间、登陆内用户总数及系统平均负载信息 </br>
a. 00:24:27 表示执行w的时间点 </br>
b. 103 days, 11:51 表示系统运行时间 </br>
c. 3 users  表示当前系统登陆用户总数为3 </br>
d. load average: 5.38, 3.22, 2.71 表示系统在过去1，5，10分钟内的负载程度，数值越小，系统负载越轻。</br>
> 2. 第二行开始构成一个表格，共有8列，分别显示各个用户正在做的事情及该用户所占用的系统资料 </br>
a. USER：显示登陆用户帐号名。用户重复登陆，该帐号也会重复出现 </br>
b. TTY：用户登陆所用的终端。 </br>
c. FROM：显示用户在何处登陆系统。</br>
d. LOGIN@：是LOGIN AT的意思，表示登陆进入系统的时间。</br>
e. IDLE：用户空闲时间，从用户上一次任务结束后，开始记时。</br>
f. JCPU：一终端代号来区分，表示在某段时间内，所有与该终端相关的进程任务所耗费的CPU时间。</br>
g. PCPU：指WHAT域的任务执行后耗费的CPU时间。</br>
h. WHAT：表示当前执行的任务。</br>

#### 1.2 w username 查看某用户信息
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ w yjs
 00:42:21 up 103 days, 12:09,  3 users,  load average: 2.54, 2.76, 2.65
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
yjs      pts/4    113.87.128.228   23:16    1:25m  0.00s  0.00s -bash
yjs      pts/7    113.87.128.228   00:11    5.00s  0.03s  0.00s w yjs
```

### 2.查看每个账号最近登入的时间 ==lastlog==
> 如果您想要知道每个账号癿最近登入癿时间，则可以使用 lastlog 指令， lastlog 会去读
取 /var/log/lastlog 档案

```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ lastlog
Username         Port     From             Latest
root             pts/4    113.87.128.228   Tue Jul 31 23:16:14 +0800 2018
bin                                        **Never logged in**
daemon                                     **Never logged in**
adm                                        **Never logged in**
lp                                         **Never logged in**
sync                                       **Never logged in**
shutdown                                   **Never logged in**
```

#### 2.2 查看某个用户最近的登录时间 ==lastlog -u username==
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ lastlog -u yjs
Username         Port     From             Latest
yjs              pts/7    113.87.128.228   Wed Aug  1 00:11:26 +0800 2018
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ lastlog -u tom
Username         Port     From             Latest
tom              pts/4    113.87.128.228   Mon Jul 30 21:56:42 +0800 2018
```

### 3. 查看网络接口状态 ==ifconfig==

> 要快速查看系统的网络设备，以及它们是否正在运行，可以使用ifconfig（代表interface config-uration，接口配置）命令和它的-a（代表all）选项。

```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ifconfig -a
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.16.144.201  netmask 255.255.240.0  broadcast 172.16.159.255
        ether 00:16:3e:08:3e:2b  txqueuelen 1000  (Ethernet)
        RX packets 1516837585  bytes 1341352969396 (1.2 TiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 976607367  bytes 175212546605 (163.1 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1  (Local Loopback)
        RX packets 77404935  bytes 15936002974 (14.8 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 77404935  bytes 15936002974 (14.8 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

这里列出了2个网络接口：eth0（一个以太网卡）和lo［环回（loop-back）接口] </br></br>
==ifconfig -a命令会显示全部的接口，包括那些没有启用的接口；而单用ifconfig命令时，只显示启用的网络连接。==


### 4. 验证计算机是否正在运行和能否接收请求 ==ping==

> ping命令能够向指定的IP地址发送一种特殊的数据包（（ICMP ECHO_REQUEST消息）。如果那个地址上的计算机正在监听ICMP消息，它将用ICMP ECHO_REPLY数据包做出响应如果ping响应成功，则意味着两台计算机之间的网络是连通的。

```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ping www.goggle.com
PING www.goggle.com (162.242.150.89) 56(84) bytes of data.
64 bytes from ns2.uniregistry-dns.com (162.242.150.89): icmp_seq=1 ttl=45 time=237 ms
64 bytes from ns2.uniregistry-dns.com (162.242.150.89): icmp_seq=2 ttl=45 time=237 ms
64 bytes from ns2.uniregistry-dns.com (162.242.150.89): icmp_seq=3 ttl=45 time=237 ms
64 bytes from ns2.uniregistry-dns.com (162.242.150.89): icmp_seq=4 ttl=45 time=237 ms
64 bytes from ns2.uniregistry-dns.com (162.242.150.89): icmp_seq=5 ttl=45 time=237 ms
64 bytes from ns2.uniregistry-dns.com (162.242.150.89): icmp_seq=6 ttl=45 time=237 ms
```

> ==ping -c 数字==
ping发送的数据包个数达到指定的数量后，就会停止，并报告结果。

```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ping -c 3 www.jianlibao.com.cn
PING www.jianlibao.com.cn.cname.yunjiasu-cdn.net (58.211.137.113) 56(84) bytes of data.
64 bytes from 58.211.137.113 (58.211.137.113): icmp_seq=1 ttl=53 time=11.8 ms
64 bytes from 58.211.137.113 (58.211.137.113): icmp_seq=2 ttl=53 time=12.0 ms
64 bytes from 58.211.137.113 (58.211.137.113): icmp_seq=3 ttl=53 time=11.7 ms

--- www.jianlibao.com.cn.cname.yunjiasu-cdn.net ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2001ms
rtt min/avg/max/mdev = 11.770/11.878/12.010/0.160 ms
```

### 5. 执行DNS查询 host

> 要快速获得和某个域名关联的IP地址，可以使用host命令

```
[root@localhost ~]# host www.jianlibao.com.cn
www.jianlibao.com.cn has address 58.211.137.113
www.jianlibao.com.cn is an alias for 1708280055.cdn.site.cdn300.cn.
www.jianlibao.com.cn is an alias for 1708280055.cdn.site.cdn300.cn.
```

> 也可以做相反的操作，找出与某个IP地址关联的域名

```
host 58.211.137.113
```

### 6. 配置网络接口 ifconfig

> 用ifconfig来获得网络接口的状态。不过，ifconfig命令更为强大的功能是能够配置网络接口。

> 案例1. 要将eth0上的以太网卡的IP地址修改为192.168.80.137
```
[root@localhost ~]# ifconfig eth0 192.168.80.137
[root@localhost ~]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0C:29:1F:82:BC  
          inet addr:192.168.80.137  Bcast:192.168.80.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fe1f:82bc/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1863 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1370 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:161312 (157.5 KiB)  TX bytes:319851 (312.3 KiB)
          Interrupt:19 Base address:0x2000 
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
```

### 7.同步网络时间 ntpdate ip

> Linux服务器运行久时，系统时间就会存在一定的误差，一般情况下可以使用date命令进行时间设置，但在做数据库集群分片等操作时对多台机器的时间差是有要求的，此时就需要使用ntpdate进行时间同步

```
[root@localhost ~]# yum install ntpdate
[root@localhost ~]# date
2018年 08月 03日 星期五 20:22:11 CST
[root@localhost ~]# ntpdate ntp2.aliyun.com
 3 Aug 12:14:56 ntpdate[23925]: step time server 203.107.6.88 offset -29244.991149 sec
[root@localhost ~]# date
2018年 08月 03日 星期五 12:15:01 CST

```
==ntp2.aliyun.com==  阿里云提供了7个NTP时间服务器 ntp[1..7].aliyun.com

#### 7.1 date
> 查看当前时间
```
[root@localhost ~]# date
2018年 08月 03日 星期五 12:19:09 CST
```

> 修改当前时间设置为 09:39:40
```
[root@localhost ~]# date -s 09:39:40
2018年 08月 03日 星期五 09:39:40 CST
```

> 修改当前日期为 2017-10-23
```
[root@localhost ~]# date -s 10/23/2017
2017年 10月 23日 星期一 00:00:00 CST
[root@localhost ~]# date -s 12:00:00
2017年 10月 23日 星期一 12:00:00 CST
```

> 使用阿里云时间服务器同步当前时间
```
[root@localhost ~]# ntpdate ntp2.aliyun.com
 3 Aug 12:24:55 ntpdate[24621]: step time server 203.107.6.88 offset 24538998.913313 sec
[root@localhost ~]# date
2018年 08月 03日 星期五 12:24:58 CST
```

> ==越过防火墙与主机同步时间 ntpdate -u==
```
[root@localhost ~]# ntpdate -u ntp2.aliyun.com
 3 Aug 12:27:28 ntpdate[24797]: adjust time server 203.107.6.88 offset -0.002311 sec
[root@localhost ~]# date
2018年 08月 03日 星期五 12:27:30 CST
```

#### 7.2 cal 查看本月日历
```
[root@localhost ~]# cal
      八月 2018     
日 一 二 三 四 五 六
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31
```

### 8.光盘挂载 mount

```
# 1.创建cdrom目录
[root@localhost mnt]# pwd
/mnt
[root@localhost mnt]# mkdir cdrom
[root@localhost mnt]# ls
cdrom
# 2.查看光驱设备的名称
[root@localhost mnt]# df -T
Filesystem           Type  1K-blocks    Used Available Use% Mounted on
/dev/mapper/VolGroup-lv_root
                     ext4    6795192 4932680   1510668  77% /
tmpfs                tmpfs    515244       0    515244   0% /dev/shm
/dev/sda1            ext4     487652   26771    435281   6% /boot
# 3.挂载光盘
[root@localhost mnt]# mount /dev/sr0 /mnt/cdrom
mount: block device /dev/sr0 is write-protected, mounting read-only
# 4.挂载成功
[root@localhost mnt]# ls -lht cdrom/
总用量 562K
dr-xr-xr-x. 3 root root 2.0K 10月 24 2014 images
dr-xr-xr-x. 2 root root 4.0K 10月 24 2014 repodata
-r--r--r--. 1 root root 3.1K 10月 24 2014 TRANS.TBL
dr-xr-xr-x. 2 root root 522K 10月 24 2014 Packages
dr-xr-xr-x. 2 root root 2.0K 10月 24 2014 isolinux
-r--r--r--. 2 root root   14 10月 24 2014 CentOS_BuildTag
-r--r--r--. 2 root root 1.4K 10月 19 2014 RELEASE-NOTES-en-US.html
-r--r--r--. 2 root root  212 11月 27 2013 EULA
-r--r--r--. 2 root root  18K 11月 27 2013 GPL
-r--r--r--. 2 root root 1.7K 11月 27 2013 RPM-GPG-KEY-CentOS-6
-r--r--r--. 2 root root 1.7K 11月 27 2013 RPM-GPG-KEY-CentOS-Debug-6
-r--r--r--. 2 root root 1.7K 11月 27 2013 RPM-GPG-KEY-CentOS-Security-6
-r--r--r--. 2 root root 1.7K 11月 27 2013 RPM-GPG-KEY-CentOS-Testing-6
# 5.取消挂载
[root@localhost mnt]# umount /mnt/cdrom/
[root@localhost mnt]# ls -lht cdrom/
总用量 0
# 6.弹出光盘
[root@localhost mnt]# eject
说明：执行此命令后，虚拟机右下角的光盘标记会变灰。

```

### 9.scp

> 案例1. 单个文件传输， 传送137.txt, 从192.168.80.137 到 192.168.80.138的/root/目录下 
```
[root@localhost ~]# scp 137.txt root@192.168.80.138:/root/
The authenticity of host '192.168.80.138 (192.168.80.138)' can't be established.
RSA key fingerprint is a5:b4:5e:27:44:79:3f:92:33:d8:98:78:8e:b8:e8:89.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.80.138' (RSA) to the list of known hosts.
root@192.168.80.138's password: 
137.txt                                                                                100%   49     0.1KB/s   00:00
# 在192.168.80.138上查看是否传输成功
[root@localhost ~]# ls -lht
总用量 108K
-rw-r--r--. 1 root root   49 8月   4 16:33 137.txt
```

> 案例2. 单个文件传输， 传送137.txt, 从192.168.80.137 到 yjs@47.98.240.217:/home/yjs/

```
[root@localhost ~]# scp 137.txt yjs@47.98.240.217:/home/yjs/
yjs@47.98.240.217's password: 
137.txt                                                                                100%   49     0.1KB/s   00:00 
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ pwd
/home/yjs
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 20K
-rw-r--r-- 1 yjs yjs   49 Aug  5 21:24 137.txt
```

> 案例3. 把47.98.240.217的项目打包 传到 tom@47.98.240.217:/home/tom/
```
[yjs@izbp10vxf7nhzxulpx8k4wz testing]$ pwd
/data/wwwroot/testing
[yjs@izbp10vxf7nhzxulpx8k4wz testing]$ sudo tar -czvf toolink_20180805_bak.tar.gz toolink --exclude toolink/vendor_old* --exclude toolink/runtime
[yjs@izbp10vxf7nhzxulpx8k4wz toolink_bak]$ sudo mv /data/wwwroot/testing/toolink_20180805_bak.tar.gz /home/yjs/toolink_bak/toolink_20180805.tar.gz    
[yjs@izbp10vxf7nhzxulpx8k4wz toolink_bak]$ ls -lht
total 70M
-rw-r--r--  1 root root  26M Aug  5 21:28 toolink_20180805.tar.gz

[yjs@izbp10vxf7nhzxulpx8k4wz toolink_bak]$ scp toolink_20180805.tar.gz tom@47.98.240.217:/home/tom/
tom@47.98.240.217's password: 
toolink_20180805.tar.gz                                                                100%   26MB 400.4KB/s   01:06 

[tom@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 26M
-rw-r--r-- 1 tom tom  26M Aug  5 21:53 toolink_20180805.tar.gz

```

> 案例4. 文件夹传输 把文件夹 /root/data/test/ 从 192.168.80.137 传送到 tom@47.98.240.217:/home/tom/
```
[root@localhost data]# scp -r test tom@47.98.240.217:/home/tom/
tom@47.98.240.217's password: 
helloworld.txt                                                                         100%   19     0.0KB/s   00:00

[tom@izbp10vxf7nhzxulpx8k4wz ~]$ pwd
/home/tom
[tom@izbp10vxf7nhzxulpx8k4wz ~]$ ls -lht
total 4.0K
drwxr-xr-x 2 tom tom 4.0K Aug  5 21:43 test

```

### 10. ssh 安全登录到另一台计算机

```
[root@localhost ~]# ssh artisan@192.168.1.10
artisan@192.168.1.10's password: 
Last failed login: Mon Aug  6 14:06:59 CST 2018 from 192.168.1.9 on ssh:notty
There was 1 failed login attempt since the last successful login.
Last login: Wed Aug  1 17:49:51 2018 from 192.168.1.220
WARNING:
        Could not source '/usr/local/rvm/scripts/version' as file does not exist.
        RVM will likely not work as expected.
[artisan@localhost ~]$ whoami
artisan
[artisan@localhost ~]$ exit
登出
Connection to 192.168.1.10 closed.
```

#### 10.2 不用密码安全登录到另一台计算机
> 标题看起来有些像是在误导人，但确实可以在不提供密码的情况下而通过ssh登录到其他计算机。如果每天都要登录某台计算机（或许有几台机子，可能一天要登录好多次），本节介绍的技术就能让你非常满意。

> 案例1.假设现在想从192.168.1.9（用户名为yjs）登录到192.168.1.10（用户名为artisan），而且不需要输入任何密码。首先，用以下命令在yjs上创建一个ssh身份验证密钥（authentication key）：
```
[yjs@localhost ~]$ ssh-keygen -t dsa
Generating public/private dsa key pair.
Enter file in which to save the key (/home/yjs/.ssh/id_dsa): 
Created directory '/home/yjs/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/yjs/.ssh/id_dsa.
Your public key has been saved in /home/yjs/.ssh/id_dsa.pub.
The key fingerprint is:
53:83:17:53:d2:e3:dd:84:2b:36:ee:ee:70:0f:a5:58 yjs@localhost.localdomain
The key's randomart image is:
+--[ DSA 1024]----+
|          +o.  . |
|         . +o . .|
|        . +. o + |
|         o .= o .|
|        S  oEo.  |
|         . o.o   |
|          o.+    |
|           o.o   |
|           oo .  |
+-----------------+

```

> 按Enter键，接受密钥要保存到的默认位置，密语（passphrase）为空，此时将提示按两次Enter键。这样就在~/.ssh/id_dsa文件中创建了一个私钥，在~/.ssh/id_dsa.pub文件中创建了一个公钥。

> 现在需要将公钥（不是私钥）从yjs传送到artisan上。ssh开发人员走得比我们要远，他们已经创建了一个程序，让这一操作变得易如反掌。为了将公钥自动从yjs复制到artisan，只需要在yjs上输入以下命令：

```
[yjs@localhost ~]$ ssh-copy-id -i /home/yjs/.ssh/id_dsa.pub artisan@192.168.1.10
The authenticity of host '192.168.1.10 (192.168.1.10)' can't be established.
ECDSA key fingerprint is df:f4:e0:2e:26:a4:88:5d:11:51:ae:ce:08:7d:16:09.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
artisan@192.168.1.10's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'artisan@192.168.1.10'"
and check to make sure that only the key(s) you wanted were added.
```

> 现在试着用ssh'artisan@192.168.1.10'登录192.168.1.10，再检查一下.ssh/authorized_keys，确保这次它没有在这个文件中额外添加你不想要的密钥。

```
[yjs@localhost ~]$ ssh artisan@192.168.1.10
Last login: Mon Aug  6 15:40:04 2018 from 192.168.1.9
WARNING:
        Could not source '/usr/local/rvm/scripts/version' as file does not exist.
        RVM will likely not work as expected.
[artisan@localhost ~]$ whoami
artisan
注意，命令没有要求输入密码，这就是想要的效果。
[artisan@localhost ~]$ cat .ssh/authorized_keys 
ssh-dss AAAAB3NzaC1kc3MAAACBAIDl3pR07/MpTf03xTARQ3uh9314cfvIuubbdRsZF+UkhTojahJi+EBGBG/1J+zF21KgLjJMjDe8oW26DRs6804//zVLdFjPnqmTUVX/vjYGbTu91zO+69I0RX4wVISYy/z/S46TE9drdQLTQYjP6d/lP5BVrxNKJJrBpAzUBEkbAAAAFQDKsMv1+fDTkVEfKFUD4fGiKauGCQAAAIB5O9UIZQWRhutsvo6ezt76voeXl6EeesggwAkGvpfbxgggNGxc5Jw3CD2QMVzByrEPzp1WYLAz9MX27hu0MSQfmNr2rLhT1QLa91jH6BiyPGZJo3VGxceQrmhR7mB5Z3RxGQKZGKbM5gz5M6JKKZFpU4hBHglaS4S4yDMgpqMBOwAAAIARILjFAQrMEXK5+wlxE+6mJ52nDCI1ORKI4jonPSbDir/X++iGEgDVaqeP4Bmqty4KUSURF1qQ5g1u6F9MV10WsMCXG0hZC+igan38//S9R433m5lGAdEcgbomeWVkkYOlFWseIG8oILq7mLbpjoRJgHEdceQqYakWSnB7sr5iAw== yjs@localhost.localdomain
```

