### 通过shell进行数学运算

> 在Bash shell环境中，可以利用**let**、(( ))和[]执行基本的算术操作。而在进行高级操作时，expr和bc这两个工具也会非常有用。

> 例

```
#!/bin/bash
no1=4;
no2=5;

#let 命令可以直接执行基本的算术操作
#当使用let时，变量名需要在添加$

#let result=no1+no2 #result = 9
#let no1++ #自加操作 no1 = 5
#let no2-- #自减操作 no2 = 4
#let no1+=5 #no1 = 9
#let no2-=5 #no2 = 0
#let no1*=2 #no1 = 8


#使用 []
#result=$[ no1 + no2 ] #result = 9
#在 [] 中也可以使用$前缀
#result=$[ $no1 * no2 ] #result=20

#使用 (())
#result=$(( no1 + 50 ))
#result=$(( $no2 + 50 ))

#使用expr
#result=`expr 3 + 4`
#result=`expr $no1 + $no2`
#result=`expr $no1 * $no2` #wrong

#echo "4 * 0.56" | bc
#echo "$no1 * 0.9" | bc
#result=`echo "$no2 * 1.5" | bc`

# scale 设定小数精度(数值范围)
#echo "scale=2;3/8" | bc # 0.37
#echo "3/8" | bc # 0
result=`echo "scale=3;3/11" | bc` # 0.272
echo $result
```

> 进制转换：用bc可以将一种进制系统转换为另一种。来看看如何将十进制转换成二进制，然后再将二进制转换回十进制：
```
#!/bin/bash
#数字转换

no=100
#echo "obase=2;$no" | bc #1100100 #转换为2进制
#result=`echo "obase=2;$no" | bc`

no2=1100100
#echo "obase=10;ibase=2;$no2" | bc #二进制转换为十进制

#计算平方以及平方根
#echo "sqrt(100)" | bc
echo "10^10" | bc
echo $result

```