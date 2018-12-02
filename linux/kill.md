### kill命令使用

> 无论你使用哪种操作系统，你一定会遇到某个行为失常的应用，它把自己锁死并拒绝关闭。在Linux(还有Mac)，你可以用一个"kill"命令强制终结它。在这个教程中，我们将展示给你多种方式使用"kill"命令终结应用。

你可以用这个命令看到所有信号的列表：
```
[artisan@localhost ~]$ kill -l
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
11) SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
16) SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
31) SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
38) SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
63) SIGRTMAX-1  64) SIGRTMAX
```

*当你执行一个"kill"命令，你实际上发送了一个信号给系统，让它去终结不正常的应用。总共有60个你可以使用的信号，但是基本上你只需要知道SIGTERM(15)和SIGKILL(9)。*

> SIGTERM - 此信号请求一个进程停止运行。此信号是可以被忽略的。进程可以用一段时间来正常关闭，一个程序的正常关闭一般需要一段时间来保存进度并释放资源。换句话说，它不是强制停止。

> SIGKILL - 此信号强制进程立刻停止运行。程序不能忽略此信号，而未保存的进度将会丢失。

> 使用"kill"的语法是：
```
kill [信号或选项] PID(s)
```

> 默认信号（当没有指定的时候）是SIGTERM。当它不起作用时，你可以使用下面的命令来强制kill掉一个进程:
```
kill SIGKILL PID
or
kill -9 PID #这里"-9"代表着SIGKILL信号
kill -9 PID1 PID2 PID3 #也可以在同一时间kill多个进程。
```

#### pkill
> "pkill"命令允许使用扩展的正则表达式和其它匹配方式。你现在可以使用应用的进程名kill掉它们，而不是使用PID。例如，要kill掉Firefox浏览器，只需要运行命令：
```
pkill firefox
```

> 为了避免kill掉错误的进程，你应该用一下"pgrep -l [进程名]"列表来匹配进程名称。
```
[artisan@localhost ~]$ pgrep -l mysql
674 mysql
928 mysqld_safe
1879 mysqld
```

#### killall
> killall同样使用进程名替代PID，并且它会kill掉所有的同名进程。例如，如果你正在运行多个Firefox浏览器的实例，可以用命令把它们全部kill掉:

```
[artisan@localhost ~]$ pgrep mysql
674
928
1879

[artisan@localhost ~]$ sudo killall mysql
[artisan@localhost ~]$ pgrep mysql
928
1879
```


