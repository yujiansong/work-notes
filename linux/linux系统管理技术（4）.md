### linux系统管理技术（4）
```
type – 说明怎样解释一个命令名
[artisan@toolink ~]$ type ls
ls is aliased to `ls --color=auto'
which – 显示会执行哪个可执行程序
[artisan@toolink ~]$ which cd
/usr/bin/cd
man – 显示命令手册页
apropos – 显示一系列适合的命令
info – 显示命令 info
whatis – 显示一个命令的简洁描述
[artisan@toolink ~]$ whatis chattr
chattr (1)           - change file attributes on a Linux file system
alias – 创建命令别名
[artisan@toolink ~]$ alias 'u=uname'
[artisan@toolink ~]$ u
Linux
```

> 命令可以是下面四种形式之一：
```
1.是一个可执行程序，就像我们所看到的位于目录/usr/bin 中的文件一样。 这一类程序可以是用诸如 C 和 C++语言写成的程序编译的二进制文件, 也可以是由诸如shell，perl，python，ruby等等脚本语言写成的程序 。

2.是一个内建于 shell 自身的命令。bash 支持若干命令，内部叫做 shell 内部命令 (builtins)。例如，cd 命令，就是一个 shell 内部命令。

3.是一个 shell 函数。这些是小规模的 shell 脚本，它们混合到环境变量中。 在后续的章节里，我们将讨论配置环境变量以及书写 shell 函数。但是现在， 仅仅意识到它们的存在就可以了。

4.是一个命令别名。我们可以定义自己的命令，建立在其它命令之上。
```

> alias 应用 alias name='string'
```
[artisan@toolink ~]$ alias foo='cd /data/wwwroot/toolink/; ls -lht; cd -'
[artisan@toolink ~]$ foo
total 164K
drwxr-xr-x 15 root  root  4.0K Nov 12 15:26 kq
drwxr-xr-x 26 root  root  4.0K Nov 12 15:26 clinic
drwxrwxr-x  6 nginx nginx 4.0K Sep 26 16:15 runtime
drwxr-xr-x 16 root  root  4.0K Aug 23 16:02 factory
drwxr-xr-x  2 root  root  4.0K Aug 20 16:47 config
drwxr-xr-x 25 root  root  4.0K Aug 10 16:11 vendor
-rw-r--r--  1 root  root   70K Aug 10 16:11 composer.lock
-rw-r--r--  1 root  root   962 Aug 10 16:11 composer.json
drwxr-xr-x 17 root  root  4.0K Aug  9 17:04 hlkq
drwxr-xr-x 13 root  root  4.0K Aug  9 17:04 admin
-rw-r--r--  1 root  root   911 Jul 17 11:02 composer.json.bak
drwxr-xr-x  3 root  root  4.0K Jul  9 15:35 im_worker
drwxr-xr-x  3 root  root  4.0K Jul  5 17:43 monitor
drwxr-xr-x  3 root  root  4.0K May 14  2018 public
drwxr-xr-x  3 root  root  4.0K Mar 29  2018 go
drwxr-xr-x  7 root  root  4.0K Mar 21  2018 webim
drwxr-xr-x  5 root  root  4.0K Mar 21  2018 thinkphp
drwxr-xr-x  7 root  root  4.0K Mar 21  2018 order
drwxr-xr-x  2 root  root  4.0K Mar 21  2018 extra
drwxr-xr-x 12 root  root  4.0K Mar 21  2018 extend
drwxr-xr-x  2 root  root  4.0K Mar 21  2018 cert
-rw-r--r--  1 root  root  1.1K Jul 19  2017 build.php
-rw-r--r--  1 root  root   648 Jul 19  2017 phpunit.xml
-rw-r--r--  1 root  root   770 Jul 19  2017 think
/home/artisan
[artisan@toolink ~]$ type foo
foo is aliased to `cd /data/wwwroot/toolink/; ls -lht; cd -'
#删除别名
[artisan@toolink ~]$ unalias foo
[artisan@toolink ~]$ foo
-bash: foo: command not found
```

#### 标准输出重定向
> I/O 重定向允许我们来重定义标准输出的地点。我们使用 “>” 重定向符后接文件名将标准输出重定向到除屏幕 以外的另一个文件。为什么我们要这样做呢？因为有时候把一个命令的运行结果存储到 一个文件很有用处。例如，我们可以告诉 shell 把 ls 命令的运行结果输送到文件 ls-output.txt 中去， 由文件代替屏幕。
```
[artisan@toolink ~]$ ls -lht
total 0
[artisan@toolink ~]$ ls -lht /usr/bin/ > ls-output.txt
#这里，我们创建了一个长长的目录/usr/bin 列表，并且输送程序运行结果到文件 ls-output.txt 中。 我们检查一下重定向的命令输出结果：
[artisan@toolink ~]$ ls -lht
total 44K
-rw-rw-r-- 1 artisan artisan 44K Dec 20 18:01 ls-output.txt
#现在，重复我们的重定向测试，但这次有改动。我们把目录换成一个不存在的目录。
[artisan@toolink ~]$ ls -lht /bin/usr > ls-output.txt 
ls: cannot access /bin/usr: No such file or directory
```
我们收到一个错误信息。这讲得通，因为我们指定了一个不存在的目录/bin/usr, 但是为什么这条错误信息显示在屏幕上而不是被重定向到文件 ls-output.txt？答案是， 
==ls 程序不把它的错误信息输送到标准输出==。反而，像许多写得不错的 Unix 程序，ls 把 错误信息送到标准错误。因为我们只是重定向了标准输出，而没有重定向标准错误， 所以错误信息被送到屏幕。马上，我们将知道怎样重定向标准错误，但是首先看一下 我们的输出文件发生了什么事情。
```
[artisan@toolink ~]$ ls -lht
total 0
-rw-rw-r-- 1 artisan artisan 0 Dec 20 18:02 ls-output.txt
```
文件长度为零！这是因为，当我们使用 “>” 重定向符来重定向输出结果时，目标文件总是从开头被重写。</br>
因为我们 ls 命令没有产生运行结果，只有错误信息，重定向操作开始重写文件，然后 由于错误而停止，导致文件内容清空。事实上，如果我们需要清空一个文件内容（或者创建一个 新的空文件），可以使用这样的技巧：
```
[artisan@toolink ~]$ ls -lht /usr/bin/ > ls-output.txt 
[artisan@toolink ~]$ ls -lht
total 44K
-rw-rw-r-- 1 artisan artisan 44K Dec 20 18:04 ls-output.txt
[artisan@toolink ~]$ > ls-output.txt 
[artisan@toolink ~]$ ls -lht
total 0
-rw-rw-r-- 1 artisan artisan 0 Dec 20 18:04 ls-output.txt
```
==简单地使用重定向符，没有命令在它之前，这会清空一个已存在文件的内容或是 创建一个新的空文件。==

> 所以，怎样才能把重定向结果追加到文件内容后面，而不是从开头重写文件？为了这个目的， 我们使用”>>“重定向符，像这样：
```
[artisan@toolink ~]$ ls -lht /usr/bin/ >> ls-output.txt 
[artisan@toolink ~]$ ls -lht
total 44K
-rw-rw-r-- 1 artisan artisan 44K Dec 20 18:05 ls-output.txt
[artisan@toolink ~]$ ls -lht /usr/bin/ >> ls-output.txt 
[artisan@toolink ~]$ ls -lht /usr/bin/ >> ls-output.txt 
[artisan@toolink ~]$ ls -lht
total 132K
-rw-rw-r-- 1 artisan artisan 131K Dec 20 18:09 ls-output.txt
```
我们重复执行命令三次，导致输出文件大小是原来的三倍。

#### 标准错误重定向
> 标准错误重定向没有专用的重定向操作符。为了重定向标准错误，我们必须参考其文件描述符。 一个程序可以在几个编号的文件流中的任一个上产生输出。虽然我们已经将这些文件流的前 三个称作标准输入、输出和错误，shell 内部分别将其称为文件描述符0、1和2。shell 使用文件描述符提供 了一种表示法来重定向文件。因为标准错误和文件描述符2一样，我们用这种 表示法来重定向标准错误：
```
[artisan@toolink ~]$ ls -lht /bin/usr 2> ls-error.txt
[artisan@toolink ~]$ cat ls-error.txt 
ls: cannot access /bin/usr: No such file or directory
```
文件描述符”2”，紧挨着放在重定向操作符之前，来执行重定向标准错误到文件 ls-error.txt 任务。

#### 重定向标准输出和错误到同一个文件
> 可能有这种情况，我们希望捕捉一个命令的所有输出到一个文件。为了完成这个，我们 必须同时重定向标准输出和标准错误。有两种方法来完成任务。第一个，传统的方法， 在旧版本 shell 中也有效：
```
[artisan@toolink ~]$ ls -lht /bin/usr > ls-output.txt 2>&1
[artisan@toolink ~]$ ls -lht
total 4.0K
-rw-rw-r-- 1 artisan artisan 54 Dec 20 18:20 ls-output.txt
[artisan@toolink ~]$ cat ls-output.txt 
ls: cannot access /bin/usr: No such file or directory
```
==使用这种方法，我们完成两个重定向。首先重定向标准输出到文件 ls-output.txt，然后 重定向文件描述符2（标准错误）到文件描述符1（标准输出）使用表示法2>&1。==

*注意重定向的顺序安排非常重要。标准错误的重定向必须总是出现在标准输出 重定向之后，要不然它不起作用。上面的例子，*
```
[artisan@toolink ~]$ ls -lht /bin/usr > ls-output.txt 2>&1
```
*重定向标准错误到文件 ls-output.txt，但是如果命令顺序改为：*
```
[artisan@toolink ~]$ ls -lht /bin/usr 2>&1 > ls-output.txt
ls: cannot access /bin/usr: No such file or directory
```
*则标准错误定向到屏幕。*

**现在的 bash 版本提供了第二种方法，更精简合理的方法来执行这种联合的重定向。**
```
[artisan@toolink ~]$ ls -lht /bin/usr &> ls-output.txt
```
==在这个例子里面，我们使用单单一个表示法 &> 来重定向标准输出和错误到文件 ls-output.txt。==

#### 处理不需要的输出
> 有时候“沉默是金”，我们不想要一个命令的输出结果，只想把它们扔掉。这种情况 尤其适用于错误和状态信息。系统通过重定向输出结果到一个叫做”/dev/null”的特殊文件， 为我们提供了解决问题的方法。这个文件是系统设备，叫做位存储桶，它可以 接受输入，并且对输入不做任何处理。为了隐瞒命令错误信息，我们这样做：
```
[artisan@toolink ~]$ ls -lht /usr/huangping 2> /dev/null 
```
*位存储桶是个古老的 Unix 概念，由于它的普遍性，它的身影出现在 Unix 文化的 许多部分。当有人说他/她正在发送你的评论到/dev/null，现在你应该知道那是 什么意思了。*

#### 标准输入重定向
##### cat － 连接文件
cat 命令读取一个或多个文件，然后复制它们到标准输出，就像这样:
> cat 经常被用来显示简短的文本文件。因为 cat 可以 接受不只一个文件作为参数，所以它也可以用来把文件连接在一起。比方说我们下载了一个 大型文件，这个文件被分离成多个部分（USENET 中的多媒体文件经常以这种方式分离）， 我们想把它们连起来。如果文件命名为：
```
[artisan@toolink ~]$ echo 'wangtianshi' > name.001
[artisan@toolink ~]$ echo 'zhengbowen' > name.002
[artisan@toolink ~]$ echo 'yujiansong' > name.003
[artisan@toolink ~]$ ls -lht
total 56K
-rw-rw-r-- 1 artisan artisan  11 Dec 21 14:18 name.003
-rw-rw-r-- 1 artisan artisan  11 Dec 21 14:18 name.002
-rw-rw-r-- 1 artisan artisan  12 Dec 21 14:18 name.001
#我们能用这个命令把它们连接起来：
[artisan@toolink ~]$ cat name.* > name.txt
[artisan@toolink ~]$ cat name.txt 
wangtianshi
zhengbowen
yujiansong
```
因为通配符总是以有序的方式展开，所以这些参数会以正确顺序安排。

> 我们想创建一个叫做”lazy_dog.txt” 的文件，这个文件包含例子中的文本。我们这样做：
```
[artisan@toolink ~]$ cat > lazy_dog.txt
the quick brown fox jumped over the lazy dog.
[artisan@toolink ~]$ cat lazy_dog.txt 
the quick brown fox jumped over the lazy dog.
```
输入命令，其后输入要放入文件中的文本。记住，最后输入 Ctrl-d。通过使用这个命令，我们 实现了世界上最低能的文字处理器！看一下运行结果，我们使用 cat 来复制文件内容到 标准输出：
> 现在我们知道 cat 怎样接受标准输入，除了文件名参数，让我们试着重定向标准输入：
```
[artisan@toolink ~]$ cat < lazy_dog.txt 
the quick brown fox jumped over the lazy dog.
```
使用“<”重定向操作符，我们把标准输入源从键盘改到文件 lazy_dog.tx。我们看到结果 和传递单个文件名作为参数的执行结果一样。把这和传递一个文件名参数作比较，不是特别有意义， 但它是用来说明把一个文件作为标准输入源。有其他的命令更好地利用了标准输入，我们不久将会看到。



#### 管道线
> 命令从标准输入读取数据并输送到标准输出的能力被一个称为管道线的 shell 特性所利用。 使用管道操作符”|”（竖杠），一个命令的标准输出可以通过管道送至另一个命令的标准输入：
command1 | command2
```
[artisan@toolink ~]$ ls -lht /usr/bin/ | less
```

#### 过滤器
> 管道线经常用来对数据完成复杂的操作。有可能会把几个命令放在一起组成一个管道线。 通常，以这种方式使用的命令被称为过滤器。过滤器接受输入，以某种方式改变它，然后 输出它。第一个我们想试验的过滤器是 sort。想象一下，我们想把目录/bin 和/usr/bin 中 的可执行程序都联合在一起，再把它们排序，然后浏览执行结果：
```
[artisan@toolink ~]$ ls /bin/ /usr/bin/ | sort | less
```
因为我们指定了两个目录（/bin 和/usr/bin），ls 命令的输出结果由有序列表组成， 各自针对一个目录。通过在管道线中包含 sort，我们改变输出数据，从而产生一个 有序列表。

#### uniq - 报道或忽略重复行
> uniq 命令经常和 sort 命令结合在一起使用。uniq 从标准输入或单个文件名参数接受数据有序 列表（详情查看 uniq 手册页），默认情况下，从数据列表中删除任何重复行。所以，为了确信 我们的列表中不包含重复句子（这是说，出现在目录/bin 和/usr/bin 中重名的程序），我们添加 uniq 到我们的管道线中：
```
[artisan@toolink ~]$ ls /bin/ /usr/bin/ | sort | uniq | less
```

#### wc － 打印行数、字数和字节数
> wc（字计数）命令是用来显示文件所包含的行数、字数和字节数。例如：
```
[artisan@toolink ~]$ wc ls-output.txt 
  822  7553 44425 ls-output.txt
```
在这个例子中，wc 打印出来三个数字：包含在文件 ls-output.txt 中的行数，单词数和字节数， 正如我们先前的命令，如果 wc 不带命令行参数，它接受标准输入。”-l”选项限制命令输出只能 报道行数。添加 wc 到管道线来统计数据，是个很便利的方法。查看我们的有序列表中程序个数， 我们可以这样做：
```
[artisan@toolink ~]$ ls /bin/ /usr/bin/ | sort | wc -l
1645
[artisan@toolink ~]$ ls /bin/ /usr/bin/ | sort | uniq | wc -l
824
```

#### grep － 打印匹配行
> grep 是个很强大的程序，用来找到文件中的匹配文本。这样使用 grep 命令：</br>
grep pattern [file...]

比如说，我们想在我们的程序列表中，找到文件名中包含单词”zip”的所有文件。这样一个搜索， 可能让我们了解系统中的一些程序与文件压缩有关系。这样做：
```
[artisan@toolink ~]$ ls /bin/ /usr/bin/ | sort | uniq | grep zip
gpg-zip
gunzip
gzip
```
grep 有一些方便的选项：”-i”使得 grep 在执行搜索时忽略大小写（通常，搜索是大小写 敏感的），”-v”选项会告诉 grep 只打印不匹配的行。

#### head / tail － 打印文件开头部分/结尾部分
> 有时候你不需要一个命令的所有输出。可能你只想要前几行或者后几行的输出内容。</br> 
head 命令打印文件的前十行，而 tail 命令打印文件的后十行。默认情况下，两个命令 都打印十行文本，但是可以通过”-n”选项来调整命令打印的行数。
```
[artisan@toolink ~]$ head -n 5 ls-output.txt 
total 88M
-rwxr-xr-x  1 root root    20K Oct 31 07:03 gapplication
-rwxr-xr-x  1 root root    41K Oct 31 07:03 gdbus
-rwxr-xr-x  1 root root    74K Oct 31 07:03 gio
-rwxr-xr-x  1 root root    12K Oct 31 07:03 gio-querymodules-64
[artisan@toolink ~]$ tail -n 5 ls-output.txt 
-rwxr-xr-x  1 root root    45K Jun 10  2014 dc
-rwxr-xr-x  1 root root    62K Jun 10  2014 tree
-rwxr-xr-x  1 root root    125 Apr  1  2014 jemalloc.sh
-rw-r--r--  1 root root    576 Feb 29  2012 redhat_lsb_init
-rwxr-xr-x  1 root root   1.4K Mar  9  2003 libmcrypt-config
#它们也能用在管道线中：
[artisan@toolink ~]$ ls /bin/ /usr/bin/ | sort | uniq | tail -n 5
zgrep
zless
zmore
znew
zsoelim
```
> tail 有一个选项允许你实时地浏览文件。当观察日志文件的进展时，这很有用，因为 它们同时在被写入。在以下的例子里，我们要查看目录/var/log 里面的信息文件。在 一些 Linux 发行版中，要求有超级用户权限才能阅读这些文件，因为文件/var/log/messages 可能包含安全信息。
```
[artisan@toolink ~]$ tail -f /data/wwwroot/toolink/runtime/log/201812/20.log 
---------------------------------------------------------------
[ 2018-12-20T22:53:21+08:00 ] 172.16.144.200 36.36.120.233 POST /weiappapi/index/register
[ info ] hlkqweiapp.toolink.cn/weiappapi/index/register [运行时间：0.337917s][吞吐率：2.96req/s] [内存消耗：5,689.14kb] [文件加载：160]
[ error ] [2]mkdir(): Permission denied[/data/wwwroot/toolink/vendor/symfony/cache/Traits/FilesystemCommonTrait.php:105]
[ error ] [512]Failed to save values[/data/wwwroot/toolink/vendor/symfony/cache/CacheItem.php:184]
---------------------------------------------------------------
```
使用”-f”选项，tail 命令继续监测这个文件，当新的内容添加到文件后，它们会立即 出现在屏幕上。这会一直继续下去直到你输入 Ctrl-c。

#### tee － 从 Stdin 读取数据，并同时输出到 Stdout 和文件
> 为了和我们的管道隐喻保持一致，Linux 提供了一个叫做 tee 的命令，这个命令制造了 一个”tee”，安装到我们的管道上。tee 程序从标准输入读入数据，并且同时复制数据 到标准输出（允许数据继续随着管道线流动）和一个或多个文件。当在某个中间处理 阶段来捕捉一个管道线的内容时，这很有帮助。这里，我们重复执行一个先前的例子， 这次包含 tee 命令，在 grep 过滤管道线的内容之前，来捕捉整个目录列表到文件 ls.txt：
```
[artisan@toolink ~]$ ls /bin/ /usr/bin/ | sort | uniq | tee ls.txt | grep zip
gpg-zip
gunzip
gzip
```
