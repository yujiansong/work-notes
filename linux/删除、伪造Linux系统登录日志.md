
**PS：本文仅限技术分享与讨论，严禁用于非法用途，任何非法利用与本文作者yujiansong无关**

Linux中涉及到登录的二进制日志文件有
1. /var/run/utmp
2. /var/log/wtmp
3. /var/log/btmp
4. /var/log/lastlog

> 其中 utmp 对应w 和 who命令； wtmp 对应last命令；btmp对应lastb命令；lastlog 对应lastlog命令


```
root@raspberrypi:~/playground# w
 18:56:57 up 3 days, 20:12,  4 users,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
pi       tty1     -                六22    4days  0.33s  0.26s -bash
pi       tty7     :0               六22    4days  2:40   1.58s /usr/bin/lxsession -s LXDE-pi -e LXDE
pi       pts/0    192.168.1.102    17:44    0.00s  2.90s  0.25s sshd: pi [priv]     
yujianso pts/1    192.168.1.102    18:49    5:16   0.02s  0.02s -sh

root@raspberrypi:~/playground# who
pi       tty1         2019-01-26 22:43
pi       tty7         2019-01-26 22:43 (:0)
pi       pts/0        2019-01-30 17:44 (192.168.1.102)
yujiansong pts/1        2019-01-30 18:49 (192.168.1.102)

root@raspberrypi:~/playground# lastb
root     ssh:notty    192.168.1.100    Sun Jan 20 16:07 - 16:07  (00:00)
root     ssh:notty    192.168.1.100    Sun Jan 20 16:07 - 16:07  (00:00)
raspberr ssh:notty    192.168.1.103    Wed Jan  2 17:05 - 17:05  (00:00)
raspberr ssh:notty    192.168.1.103    Wed Jan  2 17:05 - 17:05  (00:00)
raspberr ssh:notty    192.168.1.103    Wed Jan  2 17:05 - 17:05  (00:00)
raspberr ssh:notty    192.168.1.103    Wed Jan  2 17:04 - 17:04  (00:00)
raspberr ssh:notty    192.168.1.103    Wed Jan  2 17:04 - 17:04  (00:00)
raspberr ssh:notty    192.168.1.103    Wed Jan  2 17:04 - 17:04  (00:00)
raspberr ssh:notty    192.168.1.103    Wed Jan  2 17:04 - 17:04  (00:00)

root@raspberrypi:~/playground# lastlog
用户名           端口     来自             最后登陆时间
root                                       **从未登录过**
daemon                                     **从未登录过**
bin                                        **从未登录过**
sys                                        **从未登录过**
sync                                       **从未登录过**
games                                      **从未登录过**
pi               pts/0    192.168.1.102    三 1月 30 17:44:40 +0800 2019
yujiansong       pts/1    192.168.1.102    三 1月 30 18:49:47 +0800 2019
```

### 修改 last 记录
> 因为 last 记录在 /var/log/wtmp 文件中，而且是非文本方式保存的，所以不能用 vim 直接打开编辑

> 1.utmpdump /var/log/wtmp > newdump 将 last 日志（wtmp）转换 ASCII 格式并保存 newdump；<br>
2.用 vim 打开 newdump 编辑（当然是删掉你的记录了）<br>
3.utmpdump -r newdump > /var/log/wtmp 将修改后的 newdump 文件转换成二进制并替换 wtmp <br>
4.last一下，检查

```
#yujiansong用户登陆，之后切换pi用户，且拥有sudo权限，登陆之后做了一些事情，然后想删除和自己相关的登陆信息
$ sudo tail -f /etc/shadow

我们信任您已经从系统管理员那里了解了日常注意事项。
总结起来无外乎这三点：

    #1) 尊重别人的隐私。
    #2) 输入前要先考虑(后果和风险)。
    #3) 权力越大，责任越大。

[sudo] yujiansong 的密码：
_apt:*:17709:0:99999:7:::
pi:$6$D12eVhKX$00kKcOd8ExXk0ZruVWRQnukJi4CEW7Jg7DAgf3E6umxe4PQn7ac4X4TobozWbBIthsUM26EA7ZY4Ypvv63H121:17709:0:99999:7:::
messagebus:*:17709:0:99999:7:::
statd:*:17709:0:99999:7:::
sshd:*:17709:0:99999:7:::
avahi:*:17709:0:99999:7:::
lightdm:*:17709:0:99999:7:::
epmd:*:17709:0:99999:7:::
xrdp:!:17783:0:99999:7:::
yujiansong:$6$Haxhvunb$pP7KQkUZTKWU73V13T3qTaIIEcnmRs4IyPcCBzQVIsFmTAOLGcKrvcDnkGCOilUHs2g8ISHvu5Efar0c7maQ4/:17926:0:99999:7:::

$ su - pi
密码：

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.

pi@raspberrypi:~ $ whoami
pi
#将 last 日志（wtmp）转换 ASCII 格式并保存 newdump
pi@raspberrypi:~ $ utmpdump /var/log/wtmp > newdump
Utmp dump of /var/log/wtmp
#vim wtmp 删除和yujiansong相关的记录
pi@raspberrypi:~ $ vim newdump
#将修改后的 newdump 文件转换成二进制并替换 wtmp（先切换为root用户）

pi@raspberrypi:~ $ su - root
密码：

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.

root@raspberrypi:~# cd /home/pi/
root@raspberrypi:/home/pi# ls -lht
总用量 1.1M
-rw-r--r-- 1 pi pi  13K 1月  30 19:10 newdump
drwxr-xr-x 9 pi pi 4.0K 12月  1 15:41 nginx-1.14.1
drwxr-xr-x 2 pi pi 4.0K 11月 14 00:19 testing
-rw-r--r-- 1 pi pi 991K 11月  6 23:26 nginx-1.14.1.tar.gz
drwxr-xr-x 3 pi pi 4.0K 9月   9 18:43 Documents
drwxr-xr-t 2 pi pi 4.0K 9月   9 18:41 thinclient_drives
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 Desktop
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 Downloads
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 Music
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 Pictures
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 Public
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 Templates
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 Videos
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 MagPi
drwxr-xr-x 2 pi pi 4.0K 6月  27  2018 python_games

root@raspberrypi:/home/pi# utmpdump -r newdump > /var/log/wtmp
Utmp undump of newdump

#再次查看 last
```

### /var/log/lastlog 修改,直接清空,再次查询

```
root@raspberrypi:/home/pi# > /var/log/lastlog
```

> 相关参考 https://hacpai.com/article/1513672652459 <br>
> https://www.freebuf.com/articles/system/141474.html