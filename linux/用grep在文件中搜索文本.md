
### 在文件中搜索一个单词
```
[root@localhost ~]# grep '黄平' /data/wwwroot/somshu/extend/core/model/FactoryOrder.php 
 * User: 黄平
[root@localhost ~]# grep 订单 /data/wwwroot/somshu/extend/core/model/FactoryOrder.php 
 * Description:FactoryOrder.php 义齿订单
```

### 也可以在stdin中读取
```
[root@localhost ~]# echo -e "this is a word\nnext line." | grep 'word'
this is a word
```

> 一个grep命令也可以对多个文件进行搜索
```
[root@localhost ~]# grep "黄平" /data/wwwroot/somshu/extend/core/model/FactoryOrder.php /data/wwwroot/somshu/extend/core/datacell/QrcodeBarcode.php 
/data/wwwroot/somshu/extend/core/model/FactoryOrder.php: * User: 黄平
/data/wwwroot/somshu/extend/core/datacell/QrcodeBarcode.php: * User: 黄平
```

> 为了只输出文件中匹配到的文本部分，可以使用选项-o：
```
[root@localhost ~]# echo this is a line. | grep -o -E "[a-z]+\."
line.

or

[root@localhost ~]# echo this is a line. | egrep -o "[a-z]+\."
line.
```

> 选项-v可以将匹配结果进行反转（invert）。即打印除包含匹配行之外的所有行
```
[root@localhost ~]# echo -e "to be or not to be,\nthat is a question 123," | egrep -v "[0-9]+\,"
to be or not to be,
```

> 统计文件或文本中包含匹配字符串的行数：
```
[root@localhost ~]# grep -c 'clinic_id' /data/wwwroot/somshu/hlkq/redenvelopes/service/Ad.php 
7
```
*需要注意的是-c只是统计匹配行的数量，并不是匹配的次数。*

> 为了文件中统计匹配项的数量，可以使用下面的技巧：
```
[root@localhost ~]# egrep -o 'clinic_id' /data/wwwroot/somshu/hlkq/redenvelopes/service/Ad.php | wc -l
8
```

> 打印样式匹配所位于的字符或字节偏移：
```
[root@localhost ~]# echo 'gnu is not unix' | grep -b -o 'not'
7:not
```
> 一行中字符串的字符偏移是从该行的第一个字符开始计算，起始值是0。</br>
在上面的例子中，“not”的偏移值是7 [也就是说，not是从该行（即“gnu is not unix”这一行）的第7个字符开始的]。


> 搜索多个文件并找出匹配文本位于哪一个文件中：
```
[artisan@localhost ~]$ cat sample1.txt 
gnu is not unix
linux is fun
bash is art
[artisan@localhost ~]$ cat sample2.txt 


planetlinux
[artisan@localhost ~]$ grep -l 'art' sample1.txt sample2.txt 
sample1.txt

```

> 和-l相反的选项是-L，它会返回一个不匹配的文件列表。 
```
[artisan@localhost ~]$ grep -L 'art' sample1.txt sample2.txt 
sample2.txt
[artisan@localhost ~]$ cat sample2.txt 


planetlinux
```

### 递归搜索文件
```
如果需要在多级目录中对文本进行递归搜索，
可以使用：$ grep "text" . -R -n
命令中的“.”指定了当前目录。
```

```
[root@localhost ~]# grep '黄平' -R -n /data/wwwroot/somshu/factory/
/data/wwwroot/somshu/factory/orthdontics/controller/Orthdontics.php:12:     * @ApiAuthor(author="黄平2018-04-25")
/data/wwwroot/somshu/factory/orthdontics/controller/Orthdontics.php:116:     * @ApiAuthor(author="黄平2018-05-02")
/data/wwwroot/somshu/factory/orthdontics/controller/Digitization.php:14:     * @ApiAuthor(author="黄平2018-05-02")
```
这是开发人员使用最多的命令之一。它用于查找某些文本位于哪些源码文件中。


> 忽略样式中的大小写 </br>
> 选项-i可以使匹配样式不考虑字符的大小写，例如：
```
[root@localhost ~]# echo 'hello,world' | grep -i 'HELLO'
hello,world
```

> 用grep匹配多个样式

```
[root@localhost ~]# echo 'this is a line of text' | grep -e 'this' -e 'line' -o
this
line
```

> 还有另一种方法也可以指定多个样式。我们可以提供一个样式文件用于读取样式。在样式文件中逐行写下需要匹配的样式，然后用选项-f执行grep：</br>
> $ grep -f pattern_file source_filename
```
[root@localhost ~]# echo 'hello, this is cool' | grep -f pat_file 
hello, this is cool
```

> 在grep搜索中包括或排除文件 </br>
> grep可以在搜索过程中包括或排除某些文件。我们可以使用通配符来指定所需要包括或排除的文件。
```
[root@localhost ~]# grep '黄平' /data/wwwroot/somshu -r --include *.{php,txt}
/data/wwwroot/somshu/extend/idvalidator/GB2260.php:                "522622" => "贵州省黔东南苗族侗族自治州黄平县",
/data/wwwroot/somshu/extend/core/model/FactoryOrder.php: * User: 黄平
/data/wwwroot/somshu/extend/core/model/QrcodeBarcode.php: * User: 黄平
/data/wwwroot/somshu/extend/core/datacell/FactoryOrder.php: * User: 黄平
/data/wwwroot/somshu/extend/core/datacell/QrcodeBarcode.php: * User: 黄平
/data/wwwroot/somshu/factory/orthdontics/controller/Orthdontics.php:     * @ApiAuthor(author="黄平2018-04-25")
/data/wwwroot/somshu/factory/orthdontics/controller/Orthdontics.php:     * @ApiAuthor(author="黄平2018-05-02")
/data/wwwroot/somshu/factory/orthdontics/controller/Digitization.php:     * @ApiAuthor(author="黄平2018-05-02")
/data/wwwroot/somshu/clinic/api/controller/Api.php:     * @ApiAuthor(author="黄平2018-04-18")
/data/wwwroot/somshu/clinic/api/controller/Api.php:     * @ApiAuthor(author="黄平2018-04-18")
/data/wwwroot/somshu/clinic/api/controller/Api.php:     * @ApiAuthor(author="黄平2018-04-18")
```
注意，some{string1,string2,string3}会扩展成somestring1 somestring2 somestring3。

> 在搜索中排除所有的README文件：$ grep "main()" . -r –-exclude "README" </br>
> 如果需要排除目录，可以使用--exclude-dir选项。</br>如果需要从文件中读取所需排除的文件列表，使用--ex-clude-from FILE。

```
#排除 sample2.txt文件
[artisan@localhost ~]$ grep 'linux' /home/artisan/ -r --exclude "sample2.txt"              
/home/artisan/.bash_history:grep linux -n sample1.txt 
/home/artisan/.bash_history:cat sample1.txt | grep linux -n
/home/artisan/.bash_history:grep linux -n sample*.txt
/home/artisan/.bash_history:grep -l linux sample1.txt sample2.txt 
/home/artisan/.bash_history:grep -L linux sample1.txt sample2.txt 
/home/artisan/sample1.txt:linux is fun

#排除 .bash_history 文件
[artisan@localhost ~]$ grep 'linux' /home/artisan/ -r --exclude .bash_history
/home/artisan/sample1.txt:linux is fun
/home/artisan/sample2.txt:planetlinux

#排除extend目录
[root@localhost ~]# grep '黄平' /data/wwwroot/somshu -r --exclude-dir 'extend'                      
/data/wwwroot/somshu/factory/orthdontics/controller/Orthdontics.php:     * @ApiAuthor(author="黄平2018-04-25")
/data/wwwroot/somshu/factory/orthdontics/controller/Orthdontics.php:     * @ApiAuthor(author="黄平2018-05-02")
/data/wwwroot/somshu/factory/orthdontics/controller/Digitization.php:     * @ApiAuthor(author="黄平2018-05-02")
```

