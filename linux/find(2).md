### find 使用

```
[root@www ~]# find [PATH] [option] [action]
选项与参数：
1. 与时间有关的选项：共有 -atime, -ctime 与 -mtime ，以 -mtime 说明
   -mtime  n ：n 为数字，意义为在 n 天之前的『一天之内』被更动过内容的文件；
   -mtime +n ：列出在 n 天之前(不含 n 天本身)被更动过内容的文件档名；
   -mtime -n ：列出在 n 天之内(含 n 天本身)被更动过内容的文件档名。
   -newer file ：file 为一个存在的文件，列出比 file 还要新的文件档名

范例一：将过去系统上面 24 小时内有更动过内容 (mtime) 的文件列出
[root@www ~]# find / -mtime 0
# 那个 0 是重点！0 代表目前的时间，所以，从现在开始到 24 小时前，
# 有变动过内容的文件都会被列出来！那如果是三天前的 24 小时内？
# find / -mtime 3 有变动过的文件都被列出的意思！

范例二：寻找 /etc 底下的文件，如果文件日期比 /etc/passwd 新就列出
[root@www ~]# find /etc -newer /etc/passwd
# -newer 用在分辨两个文件之间的新旧关系是很有用的！
```

```
范例三：搜寻 /home 底下属於 vbird 的文件
[root@www ~]# find /home -user vbird
# 这个东西也很有用的～当我们要找出任何一个使用者在系统当中的所有文件时，
# 就可以利用这个命令将属於某个使用者的所有文件都找出来喔！

范例四：搜寻系统中不属於任何人的文件
[root@www ~]# find / -nouser
# 透过这个命令，可以轻易的就找出那些不太正常的文件。
# 如果有找到不属於系统任何人的文件时，不要太紧张，
# 那有时候是正常的～尤其是你曾经以原始码自行编译软件时。
```

```
选项与参数：
3. 与文件权限及名称有关的参数：
   -name filename：搜寻文件名称为 filename 的文件；
   -size [+-]SIZE：搜寻比 SIZE 还要大(+)或小(-)的文件。这个 SIZE 的规格有：
                   c: 代表 byte， k: 代表 1024bytes。所以，要找比 50KB
                   还要大的文件，就是『 -size +50k 』
   -type TYPE    ：搜寻文件的类型为 TYPE 的，类型主要有：一般正规文件 (f),
                   装置文件 (b, c), 目录 (d), 连结档 (l), socket (s), 
                   及 FIFO (p) 等属性。
   -perm mode  ：搜寻文件权限『刚好等於』 mode 的文件，这个 mode 为类似 chmod
                 的属性值，举例来说， -rwsr-xr-x 的属性为 4755 ！
   -perm -mode ：搜寻文件权限『必须要全部囊括 mode 的权限』的文件，举例来说，
                 我们要搜寻 -rwxr--r-- ，亦即 0744 的文件，使用 -perm -0744，
                 当一个文件的权限为 -rwsr-xr-x ，亦即 4755 时，也会被列出来，
                 因为 -rwsr-xr-x 的属性已经囊括了 -rwxr--r-- 的属性了。
   -perm +mode ：搜寻文件权限『包含任一 mode 的权限』的文件，举例来说，我们搜寻
                 -rwxr-xr-x ，亦即 -perm +755 时，但一个文件属性为 -rw-------
                 也会被列出来，因为他有 -rw.... 的属性存在！

范例五：找出档名为 passwd 这个文件
[root@www ~]# find / -name passwd
# 利用这个 -name 可以搜寻档名啊！

范例六：找出 /var 目录下，文件类型为 Socket 的档名有哪些？
[root@www ~]# find /var -type s
# 这个 -type 的属性也很有帮助喔！尤其是要找出那些怪异的文件，
# 例如 socket 与 FIFO 文件，可以用 find /var -type p 或 -type s 来找！

范例七：搜寻文件当中含有 SGID 或 SUID 或 SBIT 的属性
[root@www ~]# find / -perm +7000 
# 所谓的 7000 就是 ---s--s--t ，那么只要含有 s 或 t 的就列出，
# 所以当然要使用 +7000 ，使用 -7000 表示要含有 ---s--s--t 的所有三个权限，
# 因此，就是 +7000 ～了乎？
```