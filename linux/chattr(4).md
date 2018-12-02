#### 文件隐藏属性

#### chattr 配置文件隐藏属性
```
root@www ~]# chattr [+-=][ASacdistu] 文件或目录名称
选项与参数：
+   ：添加某一个特殊参数，其他原本存在参数则不动。
-   ：移除某一个特殊参数，其他原本存在参数则不动。
=   ：配置一定，且仅有后面接的参数

A  ：当配置了 A 这个属性时，若你有存取此文件(或目录)时，他的存取时间 atime
     将不会被修改，可避免I/O较慢的机器过度的存取磁碟。这对速度较慢的计算机有帮助
S  ：一般文件是非同步写入磁碟的(原理请参考第五章sync的说明)，如果加上 S 这个
     属性时，当你进行任何文件的修改，该更动会『同步』写入磁碟中。
a  ：当配置 a 之后，这个文件将只能添加数据，而不能删除也不能修改数据，只有root 
     才能配置这个属性。 
c  ：这个属性配置之后，将会自动的将此文件『压缩』，在读取的时候将会自动解压缩，
     但是在储存的时候，将会先进行压缩后再储存(看来对於大文件似乎蛮有用的！)
d  ：当 dump 程序被运行的时候，配置 d 属性将可使该文件(或目录)不会被 dump 备份
i  ：这个 i 可就很厉害了！他可以让一个文件『不能被删除、改名、配置连结也无法
     写入或新增数据！』对於系统安全性有相当大的助益！只有 root 能配置此属性
s  ：当文件配置了 s 属性时，如果这个文件被删除，他将会被完全的移除出这个硬盘
     空间，所以如果误删了，完全无法救回来了喔！
u  ：与 s 相反的，当使用 u 来配置文件时，如果该文件被删除了，则数据内容其实还
     存在磁碟中，可以使用来救援该文件喔！
注意：属性配置常见的是 a 与 i 的配置值，而且很多配置值必须要身为 root 才能配置

范例：请尝试到/tmp底下创建文件，并加入 i 的参数，尝试删除看看。
[root@www ~]# cd /tmp
[root@www tmp]# touch attrtest     <==创建一个空文件
[root@www tmp]# chattr +i attrtest <==给予 i 的属性
[root@www tmp]# rm attrtest        <==尝试删除看看
rm: remove write-protected regular empty file `attrtest'? y
rm: cannot remove `attrtest': Operation not permitted  <==操作不许可
# 看到了吗？呼呼！连 root 也没有办法将这个文件删除呢！赶紧解除配置！

范例：请将该文件的 i 属性取消！
[root@www tmp]# chattr -i attrtest
```

> lsattr 显示文件隐藏属性
```
root@www ~]# lsattr [-adR] 文件或目录
选项与参数：
-a ：将隐藏档的属性也秀出来；
-d ：如果接的是目录，仅列出目录本身的属性而非目录内的档名；
-R ：连同子目录的数据也一并列出来！ 

[root@www tmp]# chattr +aij attrtest
[root@www tmp]# lsattr attrtest
----ia---j--- attrtest
```

> 例
```
[artisan@localhost tmp]$ echo 'A goal is not always meant to be reached, and it often serves simply as something to aim at.' > attrtest.txt
[artisan@localhost tmp]$ ls -lht attrtest.txt 
-rw-rw-r-- 1 artisan artisan 93 11月  8 15:08 attrtest.txt
[artisan@localhost tmp]$ sudo chattr +i attrtest.txt #
[artisan@localhost tmp]$ lsattr attrtest.txt 
----i----------- attrtest.txt
[artisan@localhost tmp]$ sudo rm -rf attrtest.txt 
rm: 无法删除"attrtest.txt": 不允许的操作
[artisan@localhost tmp]$ vim attrtest.txt
A goal is not always meant to be reached, and it often serves simply as something to aim at.
:hello
E45: 已设定选项 'readonly' (请加 ! 强制执行)

[artisan@localhost tmp]$ lsattr attrtest.txt 
---------------- attrtest.txt
[artisan@localhost tmp]$ rm -rf attrtest.txt
[artisan@localhost tmp]$ echo $?
0

[artisan@localhost tmp]$ echo 'A goal is not always meant to be reached, and it often serves simply as something to aim at.' > attrtest.txt
[artisan@localhost tmp]$ ls -lht attrtest.txt 
-rw-rw-r-- 1 artisan artisan 93 11月  8 15:13 attrtest.txt
[artisan@localhost tmp]$ sudo chattr +a attrtest.txt
[artisan@localhost tmp]$ lsattr attrtest.txt 
-----a---------- attrtest.txt
[artisan@localhost tmp]$ sudo rm -rf attrtest.txt 
rm: 无法删除"attrtest.txt": 不允许的操作
[artisan@localhost tmp]$ sudo echo 'hello,laoerpang' >> attrtest.txt 
[artisan@localhost tmp]$ cat attrtest.txt 
A goal is not always meant to be reached, and it often serves simply as something to aim at.
hello,laoerpang
```