### 与使用者对谈
那么我是否可以跟系统上面的用户谈天说地呢？当然可以啦！利用 write 这个命令即可。 write 可以直接将信息传给接收者啰！举例来说，我们的 Linux 目前有 artisan 与 huangping 两个人在在线， 我的 artisan 要跟 huangping 讲话，可以这样做：
```
[root@www ~]# write 使用者账号 [用户所在终端接口]


[artisan@localhost ~]$ who
root     pts/0        2018-11-13 15:01 (192.168.1.175)
huangping pts/2        2018-11-14 10:08 (192.168.1.220) <== 有看到 huangping 在在线
artisan  pts/3        2018-11-13 11:38 (192.168.1.220)  

[artisan@localhost ~]$ write huangping pts/2
hello,huangping
you are handsome <==这两行是 artisan 写的信息！
# 结束时，请按下 [crtl]-c 来结束输入。此时在 huangping 的画面中，会出现：
[huangping@localhost ~]$ 
Message from artisan@localhost.localdomain on pts/9 at 11:15 ...
hello,huangping
you are handsomeEOF
```
怪怪～立刻会有信息响应给 huangping ！不过......当时 huangping 正在查数据，哇！ 这些信息会立刻打断 huangping 原本的工作喔！所以，如果 huangping 这个人不想要接受任何信息，直接下达这个动作：
```
[huangping@localhost ~]$ mesg n
[huangping@localhost ~]$ mesg
is n

[artisan@localhost ~]$ write huangping pts/2
write: huangping has messages disabled on pts/2
```

==不过，这个 mesg 的功能对 root 传送来的信息没有抵挡的能力！所以如果是 root 传送信息， huangping 还是得要收下。 但是如果 root 的 mesg 是 n 的，那么 huangping 写给 root 的信息会变这样：==

> 了解乎？如果想要解开的话，再次下达『 mesg y 』就好啦！想要知道目前的 mesg 状态，直接下达『 mesg 』即可！瞭呼？ 相对于 write 是仅针对一个使用者来传『简讯』，我们还可以『对所有系统上面的用户传送简讯 (广播)』哩～ 如何下达？用 wall 即可啊！他的语法也是很简单的喔！
```
[huangping@localhost ~]$ mesg n
[huangping@localhost ~]$ mesg
is n
[huangping@localhost ~]$ mesg y
[huangping@localhost ~]$ mesg
is y
```

#### 对所有系统上面的用户传送简讯 (广播) wall
```
[huangping@localhost ~]$ wall "I will shutdown your linux server..."
[huangping@localhost ~]$ 
Broadcast message from huangping@localhost.localdomain (pts/2) (Wed Nov 14 11:27:27 2018):

I will shutdown your linux server...


Broadcast message from huangping@localhost.localdomain (pts/2) (Wed Nov 14 11:27:27 2018):

I will shutdown your linux server...

[artisan@localhost ~]$ wall "It's not the man in your life that counts but the life in your man."

[huangping@localhost ~]$ 
Broadcast message from artisan@localhost.localdomain (pts/9) (Wed Nov 14 11:30:56 2018):

It's not the man in your life that counts but the life in your man.
```

#### 使用者邮件信箱： mail
使用 wall, write 毕竟要等到使用者在在线才能够进行，有没有其他方式来联络啊？ 不是说每个 Linux 主机上面的用户都具有一个 mailbox 吗？ 我们可否寄信给使用者啊！呵呵！当然可以啊！我们可以寄、收 mailbox 内的信件呢！ 一般来说， mailbox 都会放置在 /var/spool/mail 里面，一个账号一个 mailbox (文件)。 举例来说，我的 artisan 就具有 /var/spool/mail/artisan 这个 mailbox 喔！

那么我该如何寄出信件呢？就直接使用 mail 这个命令即可！这个命令的用法很简单的，直接这样下达：『 mail username@localhost -s "邮件标题" 』即可！ 一般来说，如果是寄给本机上的使用者，基本上，连『 @localhost 』都不用写啦！ 举例来说，我以 yjs 寄信给 tom ，信件标题是『 nice to meet you 』，则：
```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ mail tom@172.16.144.201 -s "hello,tom" #tom的ip 
Subject: are you tom?
nice to meet you.
i am yjs
.    <==这里很重要喔，结束时，最后一行输入小数点 . 即可！
EOT
You have mail in /var/spool/mail/yjs
# -s 后面里要有发送的用户名字tom,否则发送不出去
```
如此一来，你就已经寄出一封信给 vbird1 这位使用者啰，而且，该信件标题为： nice to meet you，信件内容就如同上面提到的。不过，你或许会觉得 mail 这个程序不好用～ 因为在信件编写的过程中，如果写错字而按下 Enter 进入次行，前一行的数据很难删除ㄟ！ 那怎么办？没关系啦！我们使用数据流重导向啊！呵呵！利用那个小于的符号 ( < ) 就可以达到取代键盘输入的要求了。也就是说，你可以先用 vi 将信件内容编好， 然后再以 mail vbird1 -s "nice to meet you" < filename 来将文件内容传输即可。

```
[yjs@izbp10vxf7nhzxulpx8k4wz ~]$ mail -s "a testing file" yjs < /home/yjs/137.txt
```

刚刚上面提到的是关于『寄信』的问题，那么如果是要收信呢？呵呵！同样的使用 mail 啊！ 假设我以 tom 的身份登陆主机，然后输入 mail 后，会得到什么？
```
[tom@izbp10vxf7nhzxulpx8k4wz ~]$ mail
Heirloom Mail version 12.5 7/5/10.  Type ? for help.
"/var/spool/mail/tom": 1 message 1 new
>N  1 工匠                  Wed Nov 14 15:10  21/831   "are you tom?"
& 
```
```
h	列出信件标头；如果要查阅 40 封信件左右的信件标头，可以输入『 h 40 』
d	删除后续接的信件号码，删除单封是『 d10 』，删除 20~40 封则为『 d20-40 』。 不过，这个动作要生效的话，必须要配合 q 这个命令才行(参考底下说明)！
s	将信件储存成文件。例如我要将第 5 封信件的内容存成 ~/mail.file:『s 5 ~/mail.file』
x	或者输入 exit 都可以。这个是『不作任何动作离开 mail 程序』的意思。 不论你刚刚删除了什么信件，或者读过什么，使用 exit 都会直接离开 mail，所以刚刚进行的删除与阅读工作都会无效。 如果您只是查阅一下邮件而已的话，一般来说，建议使用这个离开啦！除非你真的要删除某些信件。
q	相对于 exit 是不动作离开， q 则会进行两项动作： 1. 将刚刚删除的信件移出 mailbox 之外； 2. 将刚刚有阅读过的信件存入 ~/mbox ，且移出 mailbox 之外。鸟哥通常不很喜欢使用 q 离开， 因为，很容易忘记读过什么咚咚～导致信件给他移出 mailbox 说～
```

由于读过的信件若使用『 q 』来离开 mail 时，会将该信件移动到 ~/mbox 中，所以你可以这样想象： /var/spool/mail/vbird1 为 vbird1 的『新件匣』，而 /home/vbird1/mbox 则为『收件匣』的意思。 那如何读取 /home/vbird1/mbox 呢？就使用『mail -f /home/vbird1/mbox』即可。