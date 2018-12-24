### 从 shell 眼中看世界

#### echo － 显示一行文本
> 每当你输入一个命令并按下 enter 键，bash 会在执行你的命令之前对输入 的字符完成几个步骤的处理。</br>
我们已经见过几个例子：例如一个简单的字符序列”*”, 对 shell 来说有着多么丰富的涵义。这背后的的过程叫做（字符）展开。</br>通过展开， 你输入的字符，在 shell 对它起作用之前，会展开成为别的字符。为了说明这一点 ，让我们看一看 echo 命令。</br>
echo 是一个 shell 内建命令，可以完成非常简单的任务。 它将它的文本参数打印到标准输出中。

```
[artisan@toolink ~]$ echo this is a test
this is a test
```
> 这个命令的作用相当简单明了。传递到 echo 命令的任一个参数都会在（屏幕上）显示出来。 让我们试试另一个例子：

```
[artisan@toolink ~]$ echo *
good.txt hello.txt lazy_dog.txt ls-output.txt ls.txt name.001 name.002 name.003 name.txt
```
> 那么刚才发生了什么事情呢？ 为什么 echo 不打印”*“呢？如果你回忆起我们所学过的 关于通配符的内容，这个”*“字符意味着匹配文件名中的任意字符，但在原先的讨论 中我们并不知道 shell 是怎样实现这个功能的。简单的答案就是 shell 在 echo 命 令被执行前把”*“展开成了另外的东西（在这里，就是在当前工作目录下的文件名字）。 当回车键被按下时，shell 在命令被执行前在命令行上自动展开任何符合条件的字符， 所以 echo 命令的实际参数并不是”*“，而是它展开后的结果。知道了这个以后， 我们就能明白 echo 的行为符合预期。

#### 路径名展开
> 通配符所依赖的工作机制叫做路径名展开。如果我们试一下在之前的章节中使用的技巧， 我们会看到它们实际上是展开。给定一个家目录，它看起来像这样：

```
[artisan@toolink ~]$ ls
good.txt  hello.txt  lazy_dog.txt  ls-output.txt  ls.txt  name.001  name.002  name.003  name.txt
[artisan@toolink ~]$ echo l*
lazy_dog.txt ls-output.txt ls.txt
[artisan@toolink ~]$ echo h*
hello.txt
[artisan@toolink ~]$ echo *t
good.txt hello.txt lazy_dog.txt ls-output.txt ls.txt name.txt
[artisan@toolink ~]$ echo [[:lower:]]*
good.txt hello.txt lazy_dog.txt ls-output.txt ls.txt name.001 name.002 name.003 name.txt
[artisan@toolink ~]$ echo /usr/*/share
/usr/local/share
```

#### 波浪线展开
```
[artisan@toolink ~]$ echo ~
/home/artisan
[artisan@toolink ~]$ echo ~nginx
/home/nginx
```

#### 算术表达式展开

```
[artisan@toolink ~]$ echo $((2+2))
4
[artisan@toolink ~]$ echo $[2+3]
5
```

#### 花括号展开
> 可能最奇怪的展开是花括号展开。通过它，你可以从一个包含花括号的模式中 创建多个文本字符串。这是一个例子：
```
[artisan@toolink ~]$ echo Front-{A,B,C}-Back
Front-A-Back Front-B-Back Front-C-Back
```

> 花括号展开模式可能包含一个开头部分叫做报头，一个结尾部分叫做附言。花括号表达式本身可 能包含一个由逗号分开的字符串列表，或者一个整数区间，或者单个的字符的区间。这种模式不能 嵌入空白字符。这个例子中使用了一个整数区间：

```
[artisan@toolink ~]$ echo Number_{1..5}
Number_1 Number_2 Number_3 Number_4 Number_5
[artisan@toolink ~]$ echo Number_{a..z}
Number_a Number_b Number_c Number_d Number_e Number_f Number_g Number_h Number_i Number_j Number_k Number_l Number_m Number_n Number_o Number_p Number_q Number_r Number_s Number_t Number_u Number_v Number_w Number_x Number_y Number_z
```

> 倒序排列的字母区间：
```
[artisan@toolink ~]$ echo {Z..A}
Z Y X W V U T S R Q P O N M L K J I H G F E D C B A
```

> 花括号展开可以嵌套：
```
[artisan@toolink ~]$ echo a{A{1,2},B{3,4}}b
aA1b aA2b aB3b aB4b
```

> 那么这对什么有好处呢？最常见的应用是，创建一系列的文件或目录列表。例如， 如果我们是摄影师，有大量的相片。我们想把这些相片按年月先后组织起来。首先， 我们要创建一系列以数值”年－月”形式命名的目录。通过这种方式，可以使目录名按照 年代顺序排列。我们可以手动键入整个目录列表，但是工作量太大了，并且易于出错。 反之，我们可以这样做：
```
[artisan@toolink ~]$ mkdir Pics
[artisan@toolink ~]$ cd Pics/
[artisan@toolink Pics]$ mkdir {2007..2009}-{1..9} {2007..2009}-{10..12}
[artisan@toolink Pics]$ ls
2007-1   2007-11  2007-2  2007-4  2007-6  2007-8  2008-1   2008-11  2008-2  2008-4  2008-6  2008-8  2009-1   2009-11  2009-2  2009-4  2009-6  2009-8
2007-10  2007-12  2007-3  2007-5  2007-7  2007-9  2008-10  2008-12  2008-3  2008-5  2008-7  2008-9  2009-10  2009-12  2009-3  2009-5  2009-7  2009-9
```

#### 参数展开
```
[artisan@toolink Pics]$ echo $USER
artisan
```
> 你可能注意到在其它展开类型中，如果你误输入一个模式，展开就不会发生。这时 echo 命令只简单地显示误键入的模式。但在参数展开中，如果你拼写错了一个变量名， 展开仍然会进行，只是展开的结果是一个空字符串
```
[artisan@toolink Pics]$ echo $user

```

#### 命令替换
> 命令替换允许我们把一个命令的输出作为一个展开模式来使用：
```
[artisan@toolink ~]$ echo $(ls)
abc.txt good.txt hello.txt lazy_dog.txt ls-output.txt ls.txt name.001 name.002 name.003 name.txt Pics
```
> 我最喜欢用的一行命令是像这样的：
```
[artisan@toolink ~]$ ls -lh $(which cp)
-rwxr-xr-x. 1 root root 152K Nov  6  2016 /usr/bin/cp
```

> 这里我们把 which cp 的执行结果作为一个参数传递给 ls 命令，因此可以在不知道 cp 命令 完整路径名的情况下得到它的文件属性列表。我们不只限制于简单命令。也可以使用整个管道线 （只展示部分输出）：
```
[artisan@toolink ~]$ file $(ls /usr/bin/* | grep zip)
/usr/bin/gpg-zip: POSIX shell script, ASCII text executable
/usr/bin/gunzip:  POSIX shell script, ASCII text executable
/usr/bin/gzip:    ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=31a65cac38d3c43e1414595f0819a2b9b717b4cf, stripped
```

> 在旧版 shell 程序中，有另一种语法也支持命令替换，可与刚提到的语法轮换使用。 bash 也支持这种语法。它使用倒引号来代替美元符号和括号：
```
[artisan@toolink ~]$ file `ls /usr/bin/* | grep zip`
/usr/bin/gpg-zip: POSIX shell script, ASCII text executable
/usr/bin/gunzip:  POSIX shell script, ASCII text executable
/usr/bin/gzip:    ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=31a65cac38d3c43e1414595f0819a2b9b717b4cf, stripped
[artisan@toolink ~]$ ls -lh `which cp`
-rwxr-xr-x. 1 root root 152K Nov  6  2016 /usr/bin/cp
```

#### 双引号
```
[artisan@toolink ~]$ ls -l two words.txt
ls: cannot access two: No such file or directory
ls: cannot access words.txt: No such file or directory
```
使用双引号，我们可以阻止单词分割，得到期望的结果；进一步，我们甚至可以修复 破损的文件名。
```
[artisan@toolink ~]$ ls -lh "two words.txt"
-rw-rw-r-- 1 artisan artisan 12 Dec 24 15:55 two words.txt
```

> 记住，在双引号中，参数展开、算术表达式展开和命令替换仍然有效：
```
[artisan@toolink ~]$ echo "$USER $((2+2)) $(cal)"
artisan 4     December 2018   
Su Mo Tu We Th Fr Sa
                   1
 2  3  4  5  6  7  8
 9 10 11 12 13 14 15
16 17 18 19 20 21 22
23 24 25 26 27 28 29
30 31
```

```
[artisan@toolink ~]$ echo this is a     test
this is a test
[artisan@toolink ~]$ echo "this is a     test"
this is a     test
```

#### 单引号
> 如果需要禁止所有的展开，我们要使用单引号。以下例子是无引用，双引号，和单引号的比较结果：

#### 转义字符
> 有时候我们只想引用单个字符。我们可以在字符之前加上一个反斜杠，在这里叫做转义字符。 经常在双引号中使用转义字符，来有选择地阻止展开。
```
[artisan@toolink ~]$ echo "the balance for uer $USER is: \$5.00"
the balance for uer artisan is: $5.00
```