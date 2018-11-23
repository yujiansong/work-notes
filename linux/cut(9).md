### cut
> cut 不就是『切』吗？没错啦！这个命令可以将一段信息的某一段给他『切』出来～ 处理的信息是以『行』为单位喔！底下我们就来谈一谈：
```
[root@www ~]# cut -d'分隔字符' -f fields <==用于有特定分隔字符
[root@www ~]# cut -c 字符区间            <==用于排列整齐的信息
选项与参数：
-d  ：后面接分隔字符。与 -f 一起使用；
-f  ：依据 -d 的分隔字符将一段信息分割成为数段，用 -f 取出第几段的意思；
-c  ：以字符 (characters) 的单位取出固定字符区间；
```
```
范例一：将 PATH 变量取出，我要找出第10个路径。
[artisan@localhost tmp]$ echo $PATH
/usr/local/rvm/gems/ruby-2.4.1/bin:/usr/local/rvm/gems/ruby-2.4.1@global/bin:/usr/local/rvm/rubies/ruby-2.4.1/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/local/rvm/bin:/home/artisan/.local/bin:/home/artisan/bin

[artisan@localhost tmp]$ echo $PATH | cut -d ':' -f10
/home/artisan/bin
[artisan@localhost tmp]$ echo $PATH | cut -d ':' -f 4
/usr/local/bin
# 如同上面的数字显示，我们是以『 : 』作为分隔，因此会出现 /usr/local/bin 
# 那么如果想要列出第 4 与第 5 呢？，就是这样：
[artisan@localhost tmp]$ echo $PATH | cut -d ':' -f 4,5
/usr/local/bin:/usr/bin

范例二：将 export 输出的信息，取得第 12 字符以后的所有字符串
[root@www ~]# export
[artisan@localhost tmp]$ export | head -6
declare -x GEM_HOME="/usr/local/rvm/gems/ruby-2.4.1"
declare -x GEM_PATH="/usr/local/rvm/gems/ruby-2.4.1:/usr/local/rvm/gems/ruby-2.4.1@global"
declare -x HISTCONTROL="ignoredups"
declare -x HISTSIZE="1000"
declare -x HOME="/home/artisan"
declare -x HOSTNAME="localhost.localdomain"
# 注意看，每个数据都是排列整齐的输出！如果我们不想要『 declare -x 』时，
# 就得这么做：
[artisan@localhost tmp]$ export | head -6 | cut -c 12-
GEM_HOME="/usr/local/rvm/gems/ruby-2.4.1"
GEM_PATH="/usr/local/rvm/gems/ruby-2.4.1:/usr/local/rvm/gems/ruby-2.4.1@global"
HISTCONTROL="ignoredups"
HISTSIZE="1000"
HOME="/home/artisan"
HOSTNAME="localhost.localdomain"
# 知道怎么回事了吧？用 -c 可以处理比较具有格式的输出数据！
# 我们还可以指定某个范围的值，例如第 12-20 的字符，就是 cut -c 12-20 等等！
范例三：用 last 将显示的登陆者的信息中，仅留下用户大名
[artisan@localhost tmp]$ last | head -10
artisan  pts/6        192.168.1.220    Fri Nov 16 09:37   still logged in   
artisan  pts/4        192.168.1.220    Fri Nov 16 09:37   still logged in   
artisan  pts/3        192.168.1.220    Fri Nov 16 09:37   still logged in   
artisan  pts/2        192.168.1.220    Fri Nov 16 09:37   still logged in   
root     pts/0        192.168.1.175    Thu Nov 15 10:37 - 02:06 (6+15:29)   
huangpin pts/0        192.168.1.220    Thu Nov 15 09:34 - 09:42  (00:08)    
huangpin pts/2        192.168.1.220    Wed Nov 14 10:08 - 17:13  (07:05)    
huangpin pts/2        192.168.1.220    Wed Nov 14 10:04 - 10:07  (00:03)    
root     pts/0        192.168.1.175    Tue Nov 13 15:01 - 19:01 (1+03:59)   
artisan  pts/9        192.168.1.220    Tue Nov 13 11:38    gone - no logout 
# last 可以输出『账号/终端机/来源/日期时间』的数据，并且是排列整齐的
[artisan@localhost tmp]$ last | head -10 | cut -d ' ' -f 1
artisan
artisan
artisan
artisan
root
huangpin
huangpin
huangpin
root
artisan
# 由输出的结果我们可以发现第一个空白分隔的字段代表账号，所以使用如上命令：
# 但是因为 root   pts/1 之间空格有好几个，并非仅有一个，所以，如果要找出 
# pts/1 其实不能以 cut -d ' ' -f 1,2 喔！输出的结果会不是我们想要的。
```
> cut 主要的用途在于将『同一行里面的数据进行分解！』最常使用在分析一些数据或文字数据的时候！ 这是因为有时候我们会以某些字符当作分割的参数，然后来将数据加以切割，以取得我们所需要的数据。 鸟哥也很常使用这个功能呢！尤其是在分析 log 文件的时候！不过，cut 在处理多空格相连的数据时，可能会比较吃力一点。