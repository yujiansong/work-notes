### chkconfig 管理系统服务默认启动启动与否
```
[root@www ~]# chkconfig --list [服务名称]
[root@www ~]# chkconfig [--level [0123456]] [服务名称] [on|off]
选项与参数：
--list ：仅将目前的各项服务状态栏出来
--level：配置某个服务在该 level 下启动 (on) 或关闭 (off)

范例一：列出目前系统上面所有被 chkconfig 管理的服务
[root@www ~]# chkconfig --list |more
NetworkManager  0:off   1:off   2:off   3:off   4:off   5:off   6:off
acpid           0:off   1:off   2:off   3:on    4:on    5:on    6:off
....(中间省略)....
yum-updatesd    0:off   1:off   2:on    3:on    4:on    5:on    6:off

xinetd based services:  <==底下为 super daemon 所管理的服务
        chargen-dgram:  off
        chargen-stream: off
....(底下省略)....
# 你可以发现上面的表格有分为两个区块，一个具有 1, 2, 3 等数字，一个则被 xinetd 
# 管理。没错！从这里我们就能够发现服务有 stand alone 与 super daemon 之分。

范例二：显示出目前在 run level 3 为启动的服务
[root@www ~]# chkconfig --list | grep '3:on'

范例三：让 atd 这个服务在 run level 为 3, 4, 5 时启动：
[root@www ~]# chkconfig --level 345 atd on
```

> 例1
```
#列出目前系统上面所有被 chkconfig 管理的服务
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ chkconfig --list

Note: This output shows SysV services only and does not include native
      systemd services. SysV configuration data might be overridden by native
      systemd configuration.

      If you want to list systemd services use 'systemctl list-unit-files'.
      To see services enabled on particular target use
      'systemctl list-dependencies [target]'.

aegis           0:off   1:off   2:on    3:on    4:on    5:on    6:off
agentwatch      0:off   1:off   2:on    3:on    4:on    5:on    6:off
netconsole      0:off   1:off   2:off   3:off   4:off   5:off   6:off
network         0:off   1:off   2:on    3:on    4:on    5:on    6:off
pureftpd        0:off   1:off   2:on    3:on    4:on    5:on    6:off

#范例二：显示出目前在 run level 3 为启动的服务
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ chkconfig --list | grep '3:on'

Note: This output shows SysV services only and does not include native
      systemd services. SysV configuration data might be overridden by native
      systemd configuration.

      If you want to list systemd services use 'systemctl list-unit-files'.
      To see services enabled on particular target use
      'systemctl list-dependencies [target]'.

aegis           0:off   1:off   2:on    3:on    4:on    5:on    6:off
agentwatch      0:off   1:off   2:on    3:on    4:on    5:on    6:off
network         0:off   1:off   2:on    3:on    4:on    5:on    6:off
pureftpd        0:off   1:off   2:on    3:on    4:on    5:on    6:off

#为nginx 服务配置在 3、4、5 的级别下默认启动
[artisan@localhost test]$ chkconfig --list | grep nginx

注：该输出结果只显示 SysV 服务，并不包含
原生 systemd 服务。SysV 配置数据
可能被原生 systemd 配置覆盖。 

      要列出 systemd 服务，请执行 'systemctl list-unit-files'。
      查看在具体 target 启用的服务请执行
      'systemctl list-dependencies [target]'。

nginx           0:关    1:关    2:开    3:开    4:开    5:开    6:关

[artisan@localhost test]$ sudo chkconfig --level 345 nginx on

```

### chkconfig： 配置自己的系统服务
```
[root@www ~]# chkconfig [--add|--del] [服务名称]
选项与参数：
--add ：添加一个服务名称给 chkconfig 来管理，该服务名称必须在 /etc/init.d/ 内
--del ：删除一个给 chkconfig 管理的服务
```

> 案例
```
[artisan@localhost ~]$ pwd
/home/artisan
[artisan@localhost ~]$ sudo vim /etc/init.d/myartisan
[sudo] artisan 的密码：
#!/bin/bash
# chkconfig: 35 80 70
# description: nothing! this is a testing for example
echo "Nothing"

# myartisan 将在 run level 3 及 5 启动,
# myartisan 在 /etc/rc.d/rc[35].d 当中启动时，以 80 顺位启动，以 70 顺位结束

[artisan@localhost ~]$ chkconfig --list myartisan

注：该输出结果只显示 SysV 服务，并不包含
原生 systemd 服务。SysV 配置数据
可能被原生 systemd 配置覆盖。 

      要列出 systemd 服务，请执行 'systemctl list-unit-files'。
      查看在具体 target 启用的服务请执行
      'systemctl list-dependencies [target]'。

服务 myartisan 支持 chkconfig，但它未在任何运行级别中被引用（请运行“chkconfig --add myartisan”）

# 尚未加入 chkconfig 的管理机制中！所以需要再动点手脚
[artisan@localhost ~]$ sudo chkconfig --add myartisan; chkconfig --list myartisan
[sudo] artisan 的密码：

注：该输出结果只显示 SysV 服务，并不包含
原生 systemd 服务。SysV 配置数据
可能被原生 systemd 配置覆盖。 

      要列出 systemd 服务，请执行 'systemctl list-unit-files'。
      查看在具体 target 启用的服务请执行
      'systemctl list-dependencies [target]'。

myartisan       0:关    1:关    2:关    3:开    4:关    5:开    6:关
# 看吧！加入了 chkconfig 的管理当中了！
# 很有趣吧！如果要将这些数据都删除的话，那么就下达这样的情况：

[root@www ~]# chkconfig --del myartisan
[root@www ~]# rm /etc/init.d/myartisan

```