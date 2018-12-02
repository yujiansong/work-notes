
> 在某些情况下，我们需要知道一个文件是否包含指定的文本。对此，我们要执行一个可以返回真假的条件测试。这可以通过设置grep的静默条件（-q）来实现。在静默模式（quiet mode）中，grep命令不会向标准输出打印任何输出。它仅是运行命令，然后根据命令执行成功与否返回退出状态。
```
#!/bin/bash
#文件名: silent_grep.sh
#用途：测试文件是否包含特定的文本内容

if [ $# -ne 2 ]; then
    echo "$0 match_text filename"
fi
match_text=$1
filename=$2
grep -q $match_text $filename
if [ $? -eq 0 ]; then
    echo "The text exists in the file"
else
    echo "Text doex not exist in the file"
fi

```

> 测试
```
[root@localhost ~]# /usr/local/bin/silent_grep.sh '明月' spring.txt 
The text exists in the file
```

[Linux下$#,$0,$1,$2,$3,$@,$*,$$,$?代表的含义](https://blog.csdn.net/xiangwanpeng/article/details/78664764)

1. $# :==传给脚本参数的个数==
2. $0 :==脚本名称==
3. $n :==n为数字，代表传给脚本的第n个参数==
4. $@ :==参数列表==
5. $* :==也是显示参数列表,与上一条命令不同的是,当在双引号里面时,”$*”表示一个参数,即”a b c”,而”$@”表示三个参数,即”a” “b” “c”;==
6. $$ : ==执行当前脚本的进程ID==
7. $? ：==最后一条命令的退出状态,0表示执行成功,非0表示执行失败.==

