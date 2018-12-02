# Linux系统常用命令（2）

### 1. 排序、单一与重复
> 同文本文件打交道时，总避不开排序，那是因为对于文本处理任务而言，排序（sort）可以起到不小的作用。</br>
sort命令能够帮助我们对文本文件和stdin进行排序操作。通常，它会结合其他命令来生产所需要的输出。</br>
uniq是一个经常与sort一同使用的命令。它的作用是从文本或stdin中提取单一的行。sort和uniq能够用来查找重复数据。

#### 1.1 sort 
*sort命令既可以从特定的文件，也可以从stdin中获取输入，并将输出写入stdout。uniq的工作模式和sort一样。*

#### 1.2 依据键或列进行排序
> -k指定了排序应该按照哪一个键（key）来进行。键指的是列号，而列号就是执行排序时的依据。-r告诉sort命令按照逆序进行排序。
```
[root@localhost studying]# cat data.txt 
1 mac   2000
2 winxp 4000
3 bsd   1000
4 linux 1000

#依据第1列，以逆序形式排序
[root@localhost studying]# sort -nrk 1 data.txt 
4 linux 1000
3 bsd   1000
2 winxp 4000
1 mac   2000
#-nr表明按照数字，采用逆序形式排序

#依据第2列进行排序
[root@localhost studying]# sort -k 2 data.txt 
3 bsd   1000
4 linux 1000
1 mac   2000
2 winxp 4000


[root@localhost studying]# cat sorted.txt 
bash
foss
hack
hack

[root@localhost studying]# uniq sorted.txt 
bash
foss
hack
```

> 为了统计各行在文件中出现的次数，使用下面的命令：
```
[root@localhost studying]# sort sorted.txt | uniq -c
      1 bash
      1 foss
      2 hack
```

> 找出文件中重复的行
```
[root@localhost studying]# sort sorted.txt | uniq -d
hack
```

