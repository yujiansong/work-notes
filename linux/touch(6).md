### 修改文件时间或建置新档： touch

1. modification time (mtime)：
当该文件的『内容数据』变更时，就会升级这个时间！内容数据指的是文件的内容，而不是文件的属性或权限喔！
2. status time (ctime)：
当该文件的『状态 (status)』改变时，就会升级这个时间，举例来说，像是权限与属性被更改了，都会升级这个时间啊。
3. access time (atime)：
当『该文件的内容被取用』时，就会升级这个读取时间 (access)。举例来说，我们使用 cat 去读取 /etc/man.config ， 就会升级该文件的 atime 了。

```
[artisan@localhost testing]$ stat /data/wwwroot/smilalign/extend/core/logic/orthdontics/CaseLogic.php
  文件："/data/wwwroot/smilalign/extend/core/logic/orthdontics/CaseLogic.php"
  大小：80616           块：160        IO 块：4096   普通文件
设备：fd00h/64768d      Inode：35842094    硬链接：1
权限：(0664/-rw-rw-r--)  Uid：( 1001/     www)   Gid：( 1001/     www)
最近访问：2018-11-12 16:44:24.022193342 +0800
最近更改：2018-11-13 10:01:54.233629658 +0800
最近改动：2018-11-13 10:01:54.251629658 +0800
创建时间：-
```

```
[root@www ~]# touch [-acdmt] 文件
选项与参数：
-a  ：仅修订 access time；
-c  ：仅修改文件的时间，若该文件不存在则不创建新文件；
-d  ：后面可以接欲修订的日期而不用目前的日期，也可以使用 --date="日期或时间"
-m  ：仅修改 mtime ；
-t  ：后面可以接欲修订的时间而不用目前的时间，格式为[YYMMDDhhmm]

范例一：新建一个空的文件并观察时间
[root@www ~]# cd /tmp
[root@www tmp]# touch testtouch
[root@www tmp]# ls -l testtouch
-rw-r--r-- 1 root root 0 Sep 25 21:09 testtouch
# 注意到，这个文件的大小是 0 呢！在默认的状态下，如果 touch 后面有接文件，
# 则该文件的三个时间 (atime/ctime/mtime) 都会升级为目前的时间。若该文件不存在，
# 则会主动的创建一个新的空的文件喔！例如上面这个例子！

范例二：将 ~/.bashrc 复制成为 bashrc，假设复制完全的属性，检查其日期
[root@www tmp]# cp -a ~/.bashrc bashrc
[root@www tmp]# ll bashrc; ll --time=atime bashrc; ll --time=ctime bashrc
-rw-r--r-- 1 root root 176 Jan  6  2007 bashrc  <==这是 mtime
-rw-r--r-- 1 root root 176 Sep 25 21:11 bashrc  <==这是 atime
-rw-r--r-- 1 root root 176 Sep 25 21:12 bashrc  <==这是 ctime
```

> 案例1
```
[artisan@localhost tmp]$ touch testtouch
[artisan@localhost tmp]$ stat testtouch
  文件："testtouch"
  大小：0               块：0          IO 块：4096   普通空文件
设备：fd00h/64768d      Inode：68128766    硬链接：1
权限：(0664/-rw-rw-r--)  Uid：( 1005/ artisan)   Gid：( 1005/ artisan)
最近访问：2018-11-13 10:19:06.899620307 +0800
最近更改：2018-11-13 10:19:06.899620307 +0800
最近改动：2018-11-13 10:19:06.899620307 +0800
创建时间：-

#范例二：将 ~/.bashrc 复制成为 bashrc，假设复制完全的属性，检查其日期
[artisan@localhost tmp]$ ls -lh bashrc; ls -lht --time=atime bashrc; ls -lh --time=ctime bashrc 
-rw-r--r-- 1 artisan artisan 283 9月   4 10:19 bashrc #mtime 文件内容修改时间
-rw-r--r-- 1 artisan artisan 283 11月 12 17:56 bashrc #atime 文件访问时间
-rw-r--r-- 1 artisan artisan 283 11月 13 10:20 bashrc #ctime 文件修改及属性修改时间

#范例三：修改案例二的 bashrc 文件，将日期调整为两天前
[artisan@localhost tmp]$ touch -d "2 days ago" testtouch
[artisan@localhost tmp]$ ls -lh testtouch; ls -lh --time=atime testtouch; ls -lh --time=ctime testtouch
-rw-rw-r-- 1 artisan artisan 0 11月 11 10:28 testtouch
-rw-rw-r-- 1 artisan artisan 0 11月 11 10:28 testtouch
-rw-rw-r-- 1 artisan artisan 0 11月 13 10:28 testtouch
# 跟上个范例比较看看，本来是 13 日的变成了 11 日了 (mtime/atime)～
# 不过， ctime 并没有跟著改变喔！

#范例四：将上个范例的 bashrc 日期改为 2018/11/15 12:02
[artisan@localhost tmp]$ ls -lh testtouch; ls -lh --time=atime testtouch; ls -lh --time=ctime testtouch; 
-rw-rw-r-- 1 artisan artisan 0 11月 15 2018 testtouch
-rw-rw-r-- 1 artisan artisan 0 11月 15 2018 testtouch
-rw-rw-r-- 1 artisan artisan 0 11月 13 10:33 testtouch
```

透过 touch 这个命令，我们可以轻易的修订文件的日期与时间。并且也可以创建一个空的文件喔！ 不过，要注意的是，即使我们复制一个文件时，复制所有的属性，但也没有办法复制 ctime 这个属性的。 ctime 可以记录这个文件最近的状态 (status) 被改变的时间。无论如何，还是要告知大家， 我们平时看的文件属性中，比较重要的还是属於那个 mtime 啊！我们关心的常常是这个文件的『内容』 是什么时候被更动的说～了乎？

无论如何， touch 这个命令最常被使用的情况是：

创建一个空的文件；
将某个文件日期修订为目前 (mtime 与 atime)