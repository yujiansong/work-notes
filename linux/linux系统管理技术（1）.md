# linux系统管理技术（1）
---
## 1. 用户相关文件 
> 用户文件 ==/etc/passwd==                                     
> 用户密码文件 ==/etc/shadow==
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# ls -lht /etc/passwd /etc/shadow
---------- 1 root root  940 Jun 23 18:30 /etc/shadow
-rw-r--r-- 1 root root 1.4K Jun 23 18:30 /etc/passwd
```
## 2. 组相关文件
> 组文件 ==/etc/group== </br>
> 组密码文件 ==/etc/gshadow==

```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# ls -lht /etc/group /etc/gshadow
---------- 1 root root 458 Jun 23 18:30 /etc/gshadow
-rw-r--r-- 1 root root 579 Jun 23 18:30 /etc/group
```
---
### 1.1 用户文件详解
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# vim /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:99:99:Nobody:/:/sbin/nologin
systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
```
*6个冒号将一行分为7列*
1. 第一列：用户名
2. 第二列：用户的密码，x表示占位符，为了安全起见，将用户的密码存放到 ==/etc/shadow== 中
3. 第三列：用户的id, 0-499表示系统占用的id，新用户的id从500开始
4. 第四列：用户组的id，0-499表示系统占用的id, 新用户的id从500开始
5. 第五列：用户的备注信息
6. 第六列：用户的家目录
7. 第七列：用户可以执行脚本的类型

### 1.2 用户密码文件详解
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# vim /etc/shadow
root:$6$XHCUIHZM$IH/I1AlAy9i85S9TjYp5UCliHGuT9HQ62dcGpDvOmSgaEMFi4bDZQGHiA/PQG.A2baWfxGzt0PoY4PZXSUdT51:17639:0:99999:7::
:
bin:*:17110:0:99999:7:::
daemon:*:17110:0:99999:7:::
adm:*:17110:0:99999:7:::
lp:*:17110:0:99999:7:::
sync:*:17110:0:99999:7:::
shutdown:*:17110:0:99999:7:::
halt:*:17110:0:99999:7:::
mail:*:17110:0:99999:7:::
operator:*:17110:0:99999:7:::
games:*:17110:0:99999:7:::
ftp:*:17110:0:99999:7:::
```

1. 第一列：用户名
2. 第二列：用户密码
3. 第三列：密码最后修改的时间
4. 第四列：密码最短修改的期限（两次修改密码所需的最小天数）
5. 第五列：密码多长时间过期 99999 表示用户终身不用改密码
6. 第六列：密码过期前多少天发出警告
7. 第七列：密码过期几天后账号将被禁用
8. 第八列：账号过期时间，即从建立账号起，经过多或长时间账号过期
9. 第九列：保留

==注：密码过期，但帐号没有过期，则用户登陆系统时提示修改密码，如果帐号也过期了，则不能登陆，必须由管理员重新给设置密码。==

---
### 2.1 组文件详解
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# vim /etc/group
root:x:0:
bin:x:1:
daemon:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mem:x:8:
```
1. 第一列：组名
2. 第二列：组密码 放在 /etc/gshadow 文件中
3. 第三列：组id 
4. 第四列：组成员 多个成员用 ， 隔开

### 2.2 组密码文件详解
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# vim /etc/gshadow
root:::
bin:::
daemon:::
sys:::
adm:::
tty:::
disk:::
lp:::
mem:::
```
1. 第一列：组名
2. 第二列：组密码，通常不会对用户组设置密码
3. 第三列：组管理员账号
4. 第四列：属于改组的用户列表，只显示系统内的用户，自定义用户不显示

---
### 3.用户与组之间的关系
![用户和组](1F1DEAF151D348C2AB536F4B3FBDC98C)

---
### 4.与用户管理相关的shell命令
#### 4.1 添加用户 ==useradd==
```
格式： useradd   [选项]   用户名
选项：
           -g ：指定用户所属组 
           -d ：指定用户家目录

```

> 案例1. 添加用户 yjs
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# useradd yjs
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd
tss:x:59:59:Account used by the trousers package to sandbox the tcsd daemon:/dev/null:/sbin/nologin
vsftpd:x:1001:1001::/home/vsftpd:/sbin/nologin
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003::/home/yjs:/bin/bash
```
> 添加的 yjs 属于哪个组？
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/group  
tss:x:59:
vsftpd:x:1001:
virtusers:x:1002:
apache:x:48:
yjs:x:1003:
```
==在添加用户时，不指定用户组的情况下，系统会默认添加一个和用户名相同的组名.==

> 案例2. 添加用户 tom 并指定组为 yjs
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# useradd -g yjs tom
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd
vsftpd:x:1001:1001::/home/vsftpd:/sbin/nologin
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003::/home/yjs:/bin/bash
tom:x:1004:1003::/home/tom:/bin/bash
```

> 查看组信息文件时，新添加用户 tom 是没有组的
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/group
tss:x:59:
vsftpd:x:1001:
virtusers:x:1002:
apache:x:48:
yjs:x:1003:
```
> 案例3. 添加用户 laoerpang 并指定用户家目录为 wnagtianshi
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# useradd -d /home/wangtianshi laoerpang
[root@izbp10vxf7nhzxulpx8k4wz tmp]# ls -lht /home/
total 28K
drwx------ 2 laoerpang laoerpang 4.0K Jul 28 13:26 wangtianshi
drwx------ 2 tom       yjs       4.0K Jul 28 13:20 tom
drwx------ 2 yjs       yjs       4.0K Jul 28 13:12 yjs
```

### 4.2 修改用户信息 usermod
```
格式： usermod  [选项]   参数
选项：
	-c ：修改用户的备注信息
	-l ：修改用户名
	-d ：修改用户的家目录
    -g : 修改用户的所属组id
```
> 案例1. 修改 laoerpang 的备注信息为 wangtianshi
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# usermod -c wangtianshi laoerpang
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003::/home/yjs:/bin/bash
tom:x:1004:1003::/home/tom:/bin/bash
laoerpang:x:1005:1005:wangtianshi:/home/wangtianshi:/bin/bash
```
> 案例2. 修改 laoerpang 的用户名为 wangtianshi
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# usermod -l wangtianshi laoerpang
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003::/home/yjs:/bin/bash
tom:x:1004:1003::/home/tom:/bin/bash
wangtianshi:x:1005:1005:wangtianshi:/home/wangtianshi:/bin/bash
```

> 案例3. 修改 tom 的家目录为 /home/yjs
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# usermod -d /home/yjs tom
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003::/home/yjs:/bin/bash
tom:x:1004:1003::/home/yjs:/bin/bash
wangtianshi:x:1005:1005:wangtianshi:/home/wangtianshi:/bin/bash
```

==修改用户的家目录时，/home下对应的用户的家目录没有变改，需要手工改动/home目录的家目录。==

```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# usermod -d /home/yujiansong yjs
[root@izbp10vxf7nhzxulpx8k4wz tmp]# ls -lht /home/
total 28K
drwx------ 2 wangtianshi laoerpang 4.0K Jul 28 13:26 wangtianshi
drwx------ 2 tom         yjs       4.0K Jul 28 13:20 tom
drwx------ 2 yjs         yjs       4.0K Jul 28 13:12 yjs
```

### 4.3 删除用户 userdel
```
格式：userdel   [选项]   参数
选项：
	-r ： 删除用户同时删除用户的家目录

```

> 案例1. 删除用户 tom
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# userdel tom
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd
vsftpd:x:1001:1001::/home/vsftpd:/sbin/nologin
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003::/home/yjs:/bin/bash
wangtianshi:x:1005:1005:wangtianshi:/home/wangtianshi:/bin/bash
```

> 案例2. 删除用户 wangtianshi 并删除此用户的家目录
```
drwxr-xr-x 2 root        root      4.0K Apr 18 16:45 config
[root@izbp10vxf7nhzxulpx8k4wz tmp]# userdel -r wangtianshi
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd; ls -lht /home/
tss:x:59:59:Account used by the trousers package to sandbox the tcsd daemon:/dev/null:/sbin/nologin
vsftpd:x:1001:1001::/home/vsftpd:/sbin/nologin
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003::/home/yjs:/bin/bash
total 24K
drwx------ 2      1004 yjs       4.0K Jul 28 13:20 tom
drwx------ 2 yjs       yjs       4.0K Jul 28 13:12 yjs
drwxr-xr-x 8 root      root      4.0K May  3 11:47 software
drwx------ 2 virtusers virtusers 4.0K Apr 19 15:51 virtusers
drwx------ 2 vsftpd    vsftpd    4.0K Apr 19 15:51 vsftpd
drwxr-xr-x 2 root      root      4.0K Apr 18 16:45 config
```
---
## 5.与组管理相关的shell 命令
### 5.1 添加组指令 groupadd 
```
格式： groupadd   [选项]    参数
选项：
 	-g(group): 指定创建的组id
```

> 案例1. 添加组 fisher
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# groupadd fisher
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/group
virtusers:x:1002:
apache:x:48:
yjs:x:1003:
laoerpang:x:1005:
fisher:x:1006:
```

> 案例2. 添加组 shark 并指定组id 1008
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# groupadd -g 1008 shark
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/group
apache:x:48:
yjs:x:1003:
laoerpang:x:1005:
fisher:x:1006:
shark:x:1008:
```

### 5.2 修改组信息 groupmod
```
修改组名： groupmod  -n  新组名   旧组名
修改组id： groupmod  -g  组id     组名

```

> 案例1. 修改 fisher 的组名为 flyfisher
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# groupmod -n flyfisher fisher
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/group
apache:x:48:
yjs:x:1003:
laoerpang:x:1005:
shark:x:1008:
flyfisher:x:1006:
```

> 案例2. 修改 shark 的组id 为 1007
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# groupmod -g 1007 shark
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/group
apache:x:48:
yjs:x:1003:
laoerpang:x:1005:
shark:x:1007:
flyfisher:x:1006:
```

### 5.3 删除组信息 groupdel
```
格式： groupdel 组名
```
> 案例： 删除组 shark
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# groupdel shark
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/group
virtusers:x:1002:
apache:x:48:
yjs:x:1003:
laoerpang:x:1005:
flyfisher:x:1006:
```

> 使用 man 指令 查看帮助文档
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# man useradd
```
说明：在使用man命令查看其它命令时，可以使用q退出man命令。

---
## 6.设置用户口令
```
设置密码命令：passwd
格式： passwd  [选项]   用户名
选项：
	-S ：（大写S），显示用户口令状态
	-l ：lock缩写，锁定用户
	-u ：unlock缩写，解锁用户
	-d ：删除用户口令

```

> 案例1. 设置 yjs 的密码为 123456
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd yjs
Changing password for user yjs.
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
passwd: all authentication tokens updated successfully.
```
> 案例2. 显示 yjs 的密码状态
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd -S yjs
yjs PS 2018-07-28 0 99999 7 -1 (Password set, SHA512 crypt.)
```

> 案例3. 锁定 yjs 用户
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd -l yjs
Locking password for user yjs.
passwd: Success

[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd -S yjs
yjs LK 2018-07-28 0 99999 7 -1 (Password locked.)
```

==说明：被锁定的用户密码前会有两个!==
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/shadow
tss:!!:17640::::::
vsftpd:!!:17640:0:99999:7:::
virtusers:!!:17640:0:99999:7:::
apache:!!:17705::::::
yjs:!!$6$Avv58vDI$.8v4mmUDZw7Xh1zYYbMmkAZwqov0w8ndMPiHoK7iU9p2.t2edKdOyPpTsb8BpnsGJgN.0BHTBJpx1IC.5ioO41:17740:0:99999:7:::
```

> 案例4. 解锁用户 yjs
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd -u yjs
Unlocking password for user yjs.
passwd: Success
[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd -S yjs
yjs PS 2018-07-28 0 99999 7 -1 (Password set, SHA512 crypt.)
```
解锁后yjs用户密码前的 !! 消失
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/shadow
tss:!!:17640::::::
vsftpd:!!:17640:0:99999:7:::
virtusers:!!:17640:0:99999:7:::
apache:!!:17705::::::
yjs:$6$Avv58vDI$.8v4mmUDZw7Xh1zYYbMmkAZwqov0w8ndMPiHoK7iU9p2.t2edKdOyPpTsb8BpnsGJgN.0BHTBJpx1IC.5ioO41:17740:0:99999:7:::
```

> 案例5. 删除用户yjs的密码
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd -d yjs
Removing password for user yjs.
passwd: Success
[root@izbp10vxf7nhzxulpx8k4wz tmp]# passwd -S yjs
yjs NP 2018-07-28 0 99999 7 -1 (Empty password.)
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/shadow
tss:!!:17640::::::
vsftpd:!!:17640:0:99999:7:::
virtusers:!!:17640:0:99999:7:::
apache:!!:17705::::::
yjs::17740:0:99999:7:::
```

### 6.2 禁止普通用户登录
==通过修改/etc/shadow中的密码信息阻止普通用户登录：（在用户的密码前加两个!）==

```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# vim /etc/shadow
yjs:!!$6$8axuFqF5$4KpLvmqnbJyEtcvqifhRBR/LdfPeTay9BaPFAkJxAy6s4sWJ.liT/cpXEdtFBn2LybMxuQD/gloUyia/Ysygt.:17740:0:99999:7:
::
```
![屏幕截图](2EC1EA40348449AFB3C27E8051E74C11)

禁止yjs登陆 </br>
![屏幕截图2](148BFBD397B8472EBAC04AB15E8C2DD8)

### 6.3 禁止所有用户登录
> 创建空文件: touch 文件名 </br>
> 创建 /etc/nologin 文件来阻止所有普通用户登录

```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# touch /etc/nologin
[root@izbp10vxf7nhzxulpx8k4wz tmp]# ls -lht /etc/nologin 
-rw-r--r-- 1 root root 0 Jul 28 14:43 /etc/nologin
```
---
## 7.用户相关的指令
### 7.1 su指令： 切换用户

> 案例1. 切换到yjs
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# su yjs
[yjs@izbp10vxf7nhzxulpx8k4wz tmp]$ 
```
> 案例2. 从 yjs 切换到 root 
```
[yjs@izbp10vxf7nhzxulpx8k4wz tmp]$ su
Password:
[root@izbp10vxf7nhzxulpx8k4wz tmp]#
```
### 7.2 whoami指令： 显示当前用户名
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ whoami
yjs
```

### 7.3 id指令： 显示用户的信息
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ id
uid=1003(yjs) gid=1003(yjs) groups=1003(yjs)
```

### 7.4 groups指令： 显示用户所属组的信息
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ groups
yjs
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ groups root yjs
root : root
yjs : yjs
```
### 7.5 查看用户资料信息
#### 7.5.1 chfn指令： 设置用户的详细信息

> 案例1. 设置用户 yjs 的详细信息
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ chfn yjs
Changing finger information for yjs.
Name []: 工匠   
Office []: 17G
Office Phone []: 075512345678
Home Phone []: 13066667777

Password: 
Finger information changed.
```
查看信息 <br>
```
[root@izbp10vxf7nhzxulpx8k4wz tmp]# tail -5 /etc/passwd
tss:x:59:59:Account used by the trousers package to sandbox the tcsd daemon:/dev/null:/sbin/nologin
vsftpd:x:1001:1001::/home/vsftpd:/sbin/nologin
virtusers:x:1002:1002::/home/virtusers:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003:工匠,17G,075512345678,13066667777:/home/yjs:/bin/bash
```

#### 7.5.2 finger指令： 显示用户的详细信息
> 案例1. 显示用户 yjs 的详细信息
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ finger yjs
Login: yjs                              Name: 工匠
Directory: /home/yjs                    Shell: /bin/bash
Office: 17G, 075512345678               Home Phone: +1-306-666-7777
On since Sat Jul 28 14:45 (CST) on pts/4 from 61.141.72.238
   2 seconds idle
Last login Sat Jul 28 14:49 (CST) on pts/3
No mail.
No Plan.
```
#### 7.5.3 批量添加用户
> 1.创建用户文件user.txt格式, 一定要与用户信息文件相同：
先到root用户的家目录：

```
[root@izbp10vxf7nhzxulpx8k4wz ~]# cd
[root@izbp10vxf7nhzxulpx8k4wz ~]# pwd
/root
```
> 2.创建用户 user.txt文件
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# vim user.txt
tom:x:1004:1004::/home/tom:/bin/bash
tom:x:1004:1004::/home/tom:/bin/bash
carter:x:1005:1005::/home/carter:/bin/bash
jike:x:1006:1006::/home/jike:/bin/bash
```
> 3.创建用户密码文件 password.txt
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# vim password.txt
tom:123456
carter:123456
jike:123456
```

> 4.使用 newusers 导入 user.txt文件
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# newusers < user.txt
```
> 5.使用 chpasswd 导入 password.txt 文件
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# chpasswd < password.txt
```

> 6.查看用户密码文件
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# tail -5 /etc/passwd
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
yjs:x:1003:1003:工匠,17G,075512345678,13066667777:/home/yjs:/bin/bash
tom:x:1004:1004::/home/tom:/bin/bash
carter:x:1005:1005::/home/carter:/bin/bash
jike:x:1006:1006::/home/jike:/bin/bash
[root@izbp10vxf7nhzxulpx8k4wz ~]# tail -5 /etc/shadow
apache:!!:17705::::::
yjs:$6$hXD3VhpF$VL/s8Z861QhflscOlwIgeTpGHpf6.Mfj2FK06BezKHnkzHxpuHuysOiclHKA8RRxGw32bLMxDoFqwkn8lzI1T0:17740:0:99999:7:::
tom:$6$RdPPx/3.BaM$BWHiz18bUwzL6qwYP0t4rIKeFvkXcy9a59Rm3K6oBIsRwn6mAZ1T8IarUrdnRoDkIvbWirdkvGqvhTlK9uPCF0:17740:0:99999:7:::
carter:$6$sPnGj/JcfqW$xZ3LmvWXxY.Sa1VWpl5NNHKfUBp3qxutjXV8hg0x4jFV3nakSk0t/bvFW5Hxd7QUnOUOUdAOJmjF5PVwBNi40.:17740:0:99999:7:::
jike:$6$0b8REkvzRu$FsTtGy1ewIkwVIkuyq6NSX48e5Jv./nuc3Mmj2AH9145zZZ44p7XkrwO3YdJxP/4xyXG8dglU5S1.812Vd3BN1:17740:0:99999:7:::
```

> 7.验证登录
```
Last login: Sat Jul 28 15:47:09 2018 from 61.141.72.238

Welcome to Alibaba Cloud Elastic Compute Service !

[carter@izbp10vxf7nhzxulpx8k4wz ~]$ whoami
carter
```
#### 7.5.4 赋予普通用户特殊权限
> 实现方法有两种， 命令 ==visudo==, 修改配置文件 ==/etc/sudoers==

> 案例1. 给普通用户 yjs 添加用户的权限
1. 先得到添加用户命令的绝对路径
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# whereis useradd
useradd: /usr/sbin/useradd /usr/share/man/man8/useradd.8.gz
```
2. 编辑相关的配置文件
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# vim /etc/sudoers
# %users  localhost=/sbin/shutdown -h now
   yjs    localhost=/sbin/useradd 
```

3. 切换到用户 yjs 添加用户 tom
```
[root@izbp10vxf7nhzxulpx8k4wz ~]# su - yjs
Last login: Sat Jul 28 15:46:45 CST 2018 from 61.141.72.238 on pts/4
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ whoami
yjs

```
#### 7.5.5 sudo
> 由于 sudo 可以让你以其他用户的身份运行命令 (通常是使用 root 的身份来运行命令)，
因此并非所有人都能够运行 sudo ， 而是仅有规范到 /etc/sudoers 内的用户才能够运行 sudo 这个命令

```
[root@www ~]# sudo [-b] [-u 新使用者账号]
选项与参数：
-b  ：将后续的命令放到背景中让系统自行运行，而不与目前的 shell 产生影响
-u  ：后面可以接欲切换的使用者，若无此项则代表切换身份为 root 。
```
> 案例1. 以huangping的身份在 /tmp 下创建一个名为myhuangping的文件
```
[root@localhost ~]# sudo -u huangping touch /tmp/myhuangping
[root@localhost ~]# ls -lht /tmp/myhuangping 
-rw-r--r-- 1 huangping huangping 0 8月  22 16:19 /tmp/myhuangping
```
> sudo 运行的流程

    1.当用户运行 sudo 时，系统于 /etc/sudoers 文件中搜寻该使用者是否有运行 sudo 的权限；
    2.若使用者具有可运行 sudo 的权限后，便让使用者『输入用户自己的口令』来确认；
    3.若口令输入成功，便开始进行 sudo 后续接的命令(但 root 运行 sudo 时，不需要输入口令)；
    4.若欲切换的身份与运行者身份相同，那也不需要输入口令。

==直接使用 vi 去编辑是不好的。 此时，我们得要透过 visudo 去修改这个文件==

> 1.**单一用户可进行 root 所有命令，与 sudoers 文件语法：**
```
[huangping@localhost ~]$ sudo /etc/shadow

我们信任您已经从系统管理员那里了解了日常注意事项。
总结起来无外乎这三点：

    #1) 尊重别人的隐私。
    #2) 输入前要先考虑(后果和风险)。
    #3) 权力越大，责任越大。

[sudo] huangping 的密码：
huangping 不在 sudoers 文件中。此事将被报告。

[root@localhost ~]# visudo
     91 ## Allow root to run any commands anywhere
     92 root    ALL=(ALL)       ALL
     93 artisan ALL=(ALL)       ALL
     94 huangping ALL=(ALL)     ALL

[huangping@localhost ~]$ sudo tail -5 /etc/shadow
[sudo] huangping 的密码：
tl_ftp:$6$3Zn6ohuT$4/LQWsGtqf6CezHDxd2DGKRWBc0u0S00.m.RQ7lei/YtsDlpau2uF93bfjg9Wg6tnG4mKNWknX.B7SCVLVNzA/:17511:0:99999:7:::
git:!!:17536:0:99999:7:::
git01:$6$VKb36mpn$onE9SVUFE2AH6Wayxlzmf2Cthojzh5HTn/nUGok1xwxgBJAlM1XycRejkguHvavAcR54uNxrOW4k2arMVWjis1:17536:0:99999:7:::
artisan:$6$wA7A0sDs$TOIgtyRNxnevzRRNgs3ErsH3YJ.8YdZ/hKIOJXDBaJtyWaZf9QD9Q7yVBn19slJy8PW.j3MmJf3j5qGBGg0s.1:17744:0:99999:7:::
huangping:$6$s0xmI8Qw$ejxyatNhkETohkgRPGT5Pe8jW2i8zxuKmwuSZa6ZqxeUtScqXoprL9Bisdo5sDGcjHbV9OiGcxNZSFos8WNEk/:17765:0:99999:7:::

```

==其实 visudo 只是利用 vi 将 /etc/sudoers 文件呼叫出来进行修改而已，所以这个文件就是 /etc/sudoers 啦==

> 2.**利用群组以及免口令的功能处理 visudo**

> 我们在本章前面曾经创建过 huangyongjun, zhangshaowei, yangningshu ，这三个用户能否透过群组的功能让这三个人可以管理系统？ 可以的，而且很简单！同样我们使用实际案例来说明：

```
[root@localhost ~]# tail -5 /etc/passwd
artisan:x:1005:1005::/home/artisan:/bin/bash
huangping:x:1006:1006::/home/huangping:/bin/bash
huangyongjun:x:1007:1007::/home/huangyongjun:/bin/bash
zhangshaowei:x:1008:1008::/home/zhangshaowei:/bin/bash
yangningshu:x:1009:1009::/home/yangningshu:/bin/bash

[root@localhost ~]# tail -5 /etc/group
artisan:x:1005:
huangping:x:1006:
huangyongjun:x:1007:
zhangshaowei:x:1008:
yangningshu:x:1009:

## Allows people in group wheel to run all commands
%wheel  ALL=(ALL)       ALL
# 在最左边加上 % ，代表后面接的是一个『群组』之意！改完请储存后离开

# 将zhangshaowei 加入 wheel的支持
[root@localhost ~]# usermod -a -G wheel zhangshaowei

```

> 上面的配置值会造成『任何加入 wheel 这个群组的使用者，</br>
就能够使用 sudo 切换任何身份来操作任何命令』的意思。 你当然可以将 wheel 换成你自己想要的群组名。</br>
接下来，请分别切换身份成为 zhangshaowei 试试 sudo 的运行。

```
# 没有加入 wheel 之前
[zhangshaowei@localhost ~]$ sudo tail -5 /etc/shadow

我们信任您已经从系统管理员那里了解了日常注意事项。
总结起来无外乎这三点：

    #1) 尊重别人的隐私。
    #2) 输入前要先考虑(后果和风险)。
    #3) 权力越大，责任越大。

[sudo] zhangshaowei 的密码：
zhangshaowei 不在 sudoers 文件中。此事将被报告。

# 加入之后
[zhangshaowei@localhost ~]$ sudo tail -5 /etc/shadow
[sudo] zhangshaowei 的密码：
artisan:$6$wA7A0sDs$TOIgtyRNxnevzRRNgs3ErsH3YJ.8YdZ/hKIOJXDBaJtyWaZf9QD9Q7yVBn19slJy8PW.j3MmJf3j5qGBGg0s.1:17744:0:99999:7:::
huangping:$6$s0xmI8Qw$ejxyatNhkETohkgRPGT5Pe8jW2i8zxuKmwuSZa6ZqxeUtScqXoprL9Bisdo5sDGcjHbV9OiGcxNZSFos8WNEk/:17765:0:99999:7:::
huangyongjun:$6$hZjqzoGs$haAtzd5SxBd20woKpBsVxEUPTCpHoYe.5sNT6L99sqblY1TeKgoo4R.Ro.N5lq7c9drPbKPuSw.m.9ZKfUHUk1:17765:0:99999:7:::
zhangshaowei:$6$hsgiav.Q$mePWx5hwDGWmJYz9I1nbq7NuqzpFKy1Kixa49AsyZLwAb7lKo/lig/vnloSI.INw9hfKNLDK.Vsftv6.xCWOh1:17765:0:99999:7:::
yangningshu:$6$CZM.TLOh$sNnPV.jbRVTGs0prAxY/cKAMq3Yx95dIEvAWYVl9yB7XQmvcpH8R7j3F17A7QyuJPbkHCF1pl/y5NEmC0mQ8s1:17765:0:99999:7:::

```

> 案例2.

```
# 1.创建 yaling 用户组
[root@localhost ~]# groupadd yaling
[root@localhost ~]# tail -5 /etc/group
huangping:x:1006:
huangyongjun:x:1007:
zhangshaowei:x:1008:
yangningshu:x:1009:
yaling:x:1010:

# 2.把yaling组添加进去
[root@localhost ~]# visudo
## Allows people in group wheel to run all commands
%wheel  ALL=(ALL)       ALL
%yaling ALL=(ALL)       ALL
# 在最左边加上 % ，代表后面接的是一个『群组』之意！改完请储存后离开

# 3. huangyongjun未加入 yaling组之前
[huangyongjun@localhost ~]$ sudo tail -5 /etc/shadow
[sudo] huangyongjun 的密码：
huangyongjun 不在 sudoers 文件中。此事将被报告。

# 4. 将 huangyongjun 加入到 yaling组
[root@localhost ~]# usermod -a -G yaling huangyongjun
[root@localhost ~]$ tail -5 /etc/group
huangping:x:1006:
huangyongjun:x:1007:
zhangshaowei:x:1008:
yangningshu:x:1009:
yaling:x:1010:huangyongjun

# 5. 退出 huangyongjun 账户，再次重新登录执行 sudo
[huangyongjun@localhost ~]$ exit
登出
[zhangshaowei@localhost ~]$ su - huangyongjun
密码：
上一次登录：三 8月 22 17:14:28 CST 2018pts/0 上
WARNING:
        Could not source '/usr/local/rvm/scripts/version' as file does not exist.
        RVM will likely not work as expected.
[huangyongjun@localhost ~]$ sudo tail -5 /etc/shadow
[sudo] huangyongjun 的密码：
artisan:$6$wA7A0sDs$TOIgtyRNxnevzRRNgs3ErsH3YJ.8YdZ/hKIOJXDBaJtyWaZf9QD9Q7yVBn19slJy8PW.j3MmJf3j5qGBGg0s.1:17744:0:99999:7:::
huangping:$6$s0xmI8Qw$ejxyatNhkETohkgRPGT5Pe8jW2i8zxuKmwuSZa6ZqxeUtScqXoprL9Bisdo5sDGcjHbV9OiGcxNZSFos8WNEk/:17765:0:99999:7:::
huangyongjun:$6$hZjqzoGs$haAtzd5SxBd20woKpBsVxEUPTCpHoYe.5sNT6L99sqblY1TeKgoo4R.Ro.N5lq7c9drPbKPuSw.m.9ZKfUHUk1:17765:0:99999:7:::
zhangshaowei:$6$hsgiav.Q$mePWx5hwDGWmJYz9I1nbq7NuqzpFKy1Kixa49AsyZLwAb7lKo/lig/vnloSI.INw9hfKNLDK.Vsftv6.xCWOh1:17765:0:99999:7:::
yangningshu:$6$CZM.TLOh$sNnPV.jbRVTGs0prAxY/cKAMq3Yx95dIEvAWYVl9yB7XQmvcpH8R7j3F17A7QyuJPbkHCF1pl/y5NEmC0mQ8s1:17765:0:99999:7:::
```


---
## 8. Linux系统中的文件管理
### 8.1 查看文件的详细信息

```
[yjs@izbp10vxf7nhzxulpx8k4wz toolink]$ ls -lht
total 184K
-rw-r--r--  1 www  www  7.9K Jul 27 16:50 FamilyCard.php
drwxr-xr-x  3 www  www  4.0K Jul 20 14:14 public
drwxr-xr-x 17 www  www  4.0K Jul 19 15:45 hlkq
drwxr-xr-x  5 www  www  4.0K Jul 19 09:30 runtime
drwxr-xr-x  2 www  www  4.0K Jul 18 15:35 cert
drwxr-xr-x  2 www  www  4.0K Jul 17 17:27 config
drwxr-xr-x  8 www  www  4.0K Jul 17 16:36 kq
drwxr-xr-x 26 www  www  4.0K Jul 13 14:22 vendor
-rw-r--r--  1 www  www   74K Jul 13 14:22 composer.lock
-rw-r--r--  1 www  www   959 Jul 13 14:21 composer.json
drwxr-xr-x 22 root root 4.0K Jul 13 14:21 vendor_old2
```

1. 第一列：文件/目录的权限
2. 第二列：1代表文件，目录则为该目录下子目录的和（包含.和..隐藏目录）
3. 第三列：文件/目录的所有者
4. 第四列：所有者所在的组（所属组）
5. 第五列：文件/目录的大小
6. 第六列：文件/目录的修改时间
7. 第七列：文件/目录的名称
```
第一列详解：
	第1位：d代表目录　-代表文件　l代表连接文件（相当于win系统的快捷方式）
	第2,3,4位：所有者（u）对该文件/目录的权限
	第5,6,7位：所属组（g）对该文件/目录的权限
	第8,9,10位：其它用户（o）对该文件/目录的权限

```
```
r：read：可读　　　　　　　4
w：write：可写　　　　　　 2
x：execute：可执行　　　　 1
-没有任何权限

```
==黑色字体为普通的文件、蓝色的为目录、红色的为压缩文件、青色的为链接文件==

### 8.2 所有者，所属组，其他用户的关系
![1](1485C7085AD24607BDD2FFB8BF6B66BC)

### 8.3 更改文件权限
```
①　chmod ： 变更文件或目录的权限
格式： chmod  [选项]  文件/目录名
选项：
	-R ：递归修改 
注意chmod a+x,g+x,o+x使用方法 

```
> 案例1. 将pw.py的文件权限更改为 777
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 4.0K
-rw-r--r-- 1 yjs yjs 511 Jul 21 17:25 pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ chmod 777 pw.py 
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 4.0K
-rwxrwxrwx 1 yjs yjs 511 Jul 21 17:25 pw.py

```
> 案例2. 将目录aaa的权限更改为644
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 8.0K
drwxrwxr-x 2 yjs yjs 4.0K Jul 29 10:12 aaa
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht aaa/
total 4.0K
-rw-r--r-- 1 yjs yjs 511 Jul 21 17:25 pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ chmod -R 644 aaa
[root@izbp10vxf7nhzxulpx8k4wz practise]# ls -lht
total 8.0K
drw-r--r-- 2 yjs yjs 4.0K Jul 29 10:12 aaa
[root@izbp10vxf7nhzxulpx8k4wz practise]# ls -lht aaa/
total 4.0K
-rw-r--r-- 1 yjs yjs 511 Jul 21 17:25 pw.py
```

> 案例3. 给目录aaa加上可执行权限
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ chmod -R u+x,g+x,o+x aaa
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 8.0K
drwxr-xr-x 2 yjs yjs 4.0K Jul 29 10:12 aaa
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht aaa/
total 4.0K
-rwxr-xr-x 1 yjs yjs 511 Jul 21 17:25 pw.py
```
==说明：加权限使用+，减权限使用-==

```
②　chown ： 变更文件或目录的所有者

格式： chown  [选项]   用户名  文件/目录名
选项：
    -R 递归修改
```

> 案例1. 将文件ls-output.txt的所有者更改为yjs用户
```
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# ls -lht ls-output.txt 
-rw-r--r-- 1 root root 54 Jul 22 13:32 ls-output.txt
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# chown yjs ls-output.txt 
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# ls -lht ls-output.txt 
-rw-r--r-- 1 yjs root 54 Jul 22 13:32 ls-output.txt
```
> 案例2. 将/tmp/shell-testing/bin的目录所有者更改为yjs
```
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# ls -lht; ls -lht bin/     
total 22M
drwxr-xr-x 2 root root 4.0K Jul 24 23:51 bin
-rw-r--r-- 1 root root  22M Jul 18 15:22 toolink_20180718_bak.tar.gz
total 20K
-rw-r--r-- 1 root root  12 Jul 24 23:51 out.txt
-rwxr-xr-x 1 root root 380 Jul 22 15:53 sleep.sh
-rwxr-xr-x 1 root root 266 Jul 22 15:51 debug.sh
-rwxr-xr-x 1 root root 183 Jul 19 22:11 isuid.sh
-rwxr-xr-x 1 root root  90 Jul 19 22:03 variables.sh
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# chown -R yjs bin
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# ls -lht; ls -lht bin/
total 22M
drwxr-xr-x 2 yjs  root 4.0K Jul 24 23:51 bin
-rw-r--r-- 1 root root  22M Jul 18 15:22 toolink_20180718_bak.tar.gz
total 20K
-rw-r--r-- 1 yjs root  12 Jul 24 23:51 out.txt
-rwxr-xr-x 1 yjs root 380 Jul 22 15:53 sleep.sh
-rwxr-xr-x 1 yjs root 266 Jul 22 15:51 debug.sh
-rwxr-xr-x 1 yjs root 183 Jul 19 22:11 isuid.sh
-rwxr-xr-x 1 yjs root  90 Jul 19 22:03 variables.sh
```

```
③　chgrp ： 变更文件或目录的所属组

格式： chgrp  [选项]  用户组名  文件/目录名
选项：
	-R： 递归修改
```
> 案例1. 变更 /tmp/shell-testing/bin的目录的所属组为yjs
```
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# chgrp -R yjs bin
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# ls -lht; ls -lht bin/
total 22M
drwxr-xr-x 2 yjs  yjs  4.0K Jul 24 23:51 bin
-rw-r--r-- 1 root root  22M Jul 18 15:22 toolink_20180718_bak.tar.gz
total 20K
-rw-r--r-- 1 yjs yjs  12 Jul 24 23:51 out.txt
-rwxr-xr-x 1 yjs yjs 380 Jul 22 15:53 sleep.sh
-rwxr-xr-x 1 yjs yjs 266 Jul 22 15:51 debug.sh
-rwxr-xr-x 1 yjs yjs 183 Jul 19 22:11 isuid.sh
-rwxr-xr-x 1 yjs yjs  90 Jul 19 22:03 variables.sh
```

> 案例2. 变更 pw.py的所属组为 yjs
```
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# ls -lht pw.py 
-rw-r--r-- 1 root root 511 Jul 21 17:25 pw.py
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# chgrp yjs pw.py 
[root@izbp10vxf7nhzxulpx8k4wz shell-testing]# ls -lht pw.py 
-rw-r--r-- 1 root yjs 511 Jul 21 17:25 pw.py
```
---
## 9.目录操作
### 9.1 创建目录 mkdir
```
格式：mkdir  [选项]  目录名
选项：
	  -p ：递归创建目录
	  -m ：创建目录同时指定目录的操作权限

```
> 案例1. 创建目录test
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ mkdir test
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 8.0K
drwxrwxr-x 2 yjs yjs 4.0K Jul 29 10:39 test
```
> 案例2. 创建目录aaa/bbb
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ mkdir -p aaa/bbb
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht aaa
total 4.0K
drwxrwxr-x 2 yjs yjs 4.0K Jul 29 10:40 bbb
```

> 案例3. 创建权限为700的目录wanger
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ mkdir -m 700 wanger
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 16K
drwx------ 2 yjs yjs 4.0K Jul 29 10:41 wanger
```
### 9.2 删除目录 rmdir
```
格式： rmdir   [选项]  目录名
选项：
        -p: 递归删除目录
```

> 案例1. 删除test目录
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ rmdir test
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 12K
drwx------ 2 yjs yjs 4.0K Jul 29 10:41 wanger
drwxrwxr-x 3 yjs yjs 4.0K Jul 29 10:40 aaa
-rwxrwxrwx 1 yjs yjs  511 Jul 21 17:25 pw.py
```

> 案例2. 删除aaa/bbb目录
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ rmdir -p aaa/bbb
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 8.0K
drwx------ 2 yjs yjs 4.0K Jul 29 10:41 wanger
-rwxrwxrwx 1 yjs yjs  511 Jul 21 17:25 pw.py
```

> 案例3. 删除wanger目录
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht wanger/
total 4.0K
drwxrwxr-x 2 yjs yjs 4.0K Jul 29 10:47 laoerpang
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ rmdir wanger/
rmdir: failed to remove ‘wanger/’: Directory not empty
```

## 10.文件操作
### 10.1 文件统计 wc
```
格式： wc  [选项]  文件名
选项：
-c ：统计文件的字符数
-l ：统计文件的行数
-w ：统计文件的单词数

```
> 案例1. 统计文件的字符数，行数，单词数
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ wc -c /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php 
126150 /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ wc -l /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php  
2180 /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ wc -w /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php  
8042 /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php
```

### 10.2 搜索匹配行 grep
```
格式：grep  [选项]  字符串  源文件
选项： 
-n ：显示搜索到关键词的行号
-c ：统计一共有多少行
-i ：ignore缩写，忽略大小写

```
> 案例1. 搜索Telemarket.php 文件中关键字为 王彦廷 ，并显示行号
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ grep -n 王彦廷 /data/wwwroot/testing/toolink/admin/admin/controller/Telemarket.php 
677:     *            'remark': '王彦廷牛逼',
867:     *        'name': '王彦廷',
947:     *                'patient': '王彦廷',
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ grep -n 文俊金 /data/wwwroot/testing/toolink/admin/admin/controller/Telemarket.php 
1040:     *            'patient_name': '北海小霸王文俊金',
1860:     *            'name': '北海小霸王文俊金',
```

> 案例2. 统计Telemarket.php 文件中关键词为 文俊金 的行数
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ grep -c 文俊金 /data/wwwroot/testing/toolink/admin/admin/controller/Telemarket.php  
2
```

> 案例3. 忽略大小写搜索关键字 patient
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ grep -in patient /data/wwwroot/testing/toolink/admin/admin/controller/Telemarket.php 
14:     * @ApiCode(name="admin@telemarket@addpatient")
16:     * @ApiRoute(name="/admin/telemarket/addpatient")
45:    public function addPatient(Request $request)
51:        if (!$Validate->scene('addPatient')->check($data)) {
54:        $return_data = model('Telemarket', 'service')->addPatient($data, $userInfo);
62:     * @ApiCode(name="admin@telemarket@updatepatient")
64:     * @ApiRoute(name="/admin/telemarket/updatepatient")
```

### 10.3 创建软链接
```
格式： ln  -s  源文件/目录   目标文件/目录
```

> 案例1. 将/tmp/shell-testing/bin/isuid.sh 的快捷方式放到~/practise/isuid.sh
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ln -s /tmp/shell-testing/bin/isuid.sh ~/practise/isuid.sh
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ ls -lht
total 8.0K
lrwxrwxrwx 1 yjs yjs   31 Jul 29 11:15 isuid.sh -> /tmp/shell-testing/bin/isuid.sh
drwx------ 3 yjs yjs 4.0K Jul 29 10:47 wanger
-rwxrwxrwx 1 yjs yjs  511 Jul 21 17:25 pw.py
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ /bin/bash isuid.sh 
Non root user. Please run as root.
```

### 10.4 显示磁盘信息
```
格式： df  [选项]  
选项：
-l ：查看本地磁盘信息
-h ：以1024进制显示磁盘信息
-H ：以1000进制显示磁盘信息
-T ：显示磁盘分区格式
-t ：显示指定的分区格式
-x ：显示除指定分区格式以外的其他分区信息 

```

> 案例1. 显示本地磁盘信息
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ df -lh
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        40G   19G   19G  51% /
devtmpfs        1.9G     0  1.9G   0% /dev
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           1.9G  684K  1.9G   1% /run
tmpfs           1.9G     0  1.9G   0% /sys/fs/cgroup
tmpfs           380M     0  380M   0% /run/user/0
tmpfs           380M     0  380M   0% /run/user/1003
```
1. 第一列：设备名称
2. 第二列：磁盘大小
3. 第三列：已经使用的硬盘空间
4. 第四列：可用空间
5. 第五列：使用空间的百分比
6. 第六列：挂载点

> 案例2. 显示磁盘分区格式
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ df -T
Filesystem     Type     1K-blocks     Used Available Use% Mounted on
/dev/vda1      ext4      41151808 19831720  19206656  51% /
devtmpfs       devtmpfs   1931336        0   1931336   0% /dev
tmpfs          tmpfs      1940844        0   1940844   0% /dev/shm
tmpfs          tmpfs      1940844      684   1940160   1% /run
tmpfs          tmpfs      1940844        0   1940844   0% /sys/fs/cgroup
tmpfs          tmpfs       388172        0    388172   0% /run/user/0
tmpfs          tmpfs       388172        0    388172   0% /run/user/1003
```

> 案例3. 显示ext4磁盘分区格式
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ df -Tt ext4
Filesystem     Type 1K-blocks     Used Available Use% Mounted on
/dev/vda1      ext4  41151808 19831748  19206628  51% /
```

> 案例4. 显示除ext4以外的磁盘分区格式
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ df -Tx ext4
Filesystem     Type     1K-blocks  Used Available Use% Mounted on
devtmpfs       devtmpfs   1931336     0   1931336   0% /dev
tmpfs          tmpfs      1940844     0   1940844   0% /dev/shm
tmpfs          tmpfs      1940844   684   1940160   1% /run
tmpfs          tmpfs      1940844     0   1940844   0% /sys/fs/cgroup
tmpfs          tmpfs       388172     0    388172   0% /run/user/0
tmpfs          tmpfs       388172     0    388172   0% /run/user/1003
```

### 10.5 统计文件大小 du
```
格式： du  [选项]
选项： 
-b ：以字节为单位统计文件大小（b）
-k ：以千字节为单位统计文件大小（kb）
-m ：以兆为单位统计文件大小（mb）
-h ：以1024进制统计文件大小，不足以m或k显示
-s ：统计文件夹大小

```

> 案例1. 统计文件大小
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ du -h /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php
124K    /data/wwwroot/testing/toolink/admin/admin/service/Telemarket.php
```

> 案例2. 统计文件夹大小
```
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ du -hs /data/wwwroot/testing/toolink/admin/admin/service/
452K    /data/wwwroot/testing/toolink/admin/admin/service/
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ du -hs /data/wwwroot/testing/toolink/
4.1G    /data/wwwroot/testing/toolink/
[yjs@izbp10vxf7nhzxulpx8k4wz practise]$ du -hs /data/wwwroot/testing/toolink/runtime/
4.0G    /data/wwwroot/testing/toolink/runtime/
```

> 案例3. 统计文件夹大小并排序

```
[yjs@localhost ~]$ du -s /data/wwwroot/somshu/* | sort -nr | head
7171060 /data/wwwroot/somshu/runtime
2124384 /data/wwwroot/somshu/clinic
32252   /data/wwwroot/somshu/vendor
4100    /data/wwwroot/somshu/apidocs
2984    /data/wwwroot/somshu/extend
2356    /data/wwwroot/somshu/admin
1636    /data/wwwroot/somshu/vendor.tar.gz
1604    /data/wwwroot/somshu/thinkphp
1580    /data/wwwroot/somshu/thinkphp_old
928     /data/wwwroot/somshu/factory

[yjs@localhost ~]$ du -s /data/wwwroot/somshu/* | sort -nr | tail
48      /data/wwwroot/somshu/api
12      /data/wwwroot/somshu/cert
8       /data/wwwroot/somshu/tests
8       /data/wwwroot/somshu/go
4       /data/wwwroot/somshu/think
4       /data/wwwroot/somshu/phpunit.xml
4       /data/wwwroot/somshu/composer.json.bak
4       /data/wwwroot/somshu/composer.json
4       /data/wwwroot/somshu/build.php
0       /data/wwwroot/somshu/cache
```

> 案例4. 按文件大小进行排序

```

```

