## composer 
> 是 PHP 用来管理依赖（dependency）关系的工具。你可以在自己的项目中声明所依赖的外部工具库（libraries），Composer 会帮你安装这些依赖的库文件。

### 1.安装
> https://jingyan.baidu.com/album/ca2d939d164df6eb6c31ceb6.html?picindex=5

1. 第一步配置环境变量 ->高级系统设置
![image](951BB0016090472387BD45174002F298)

2. -> 环境变量</br>
![image](B51FF7CDE44845328F7B4487C2336A38)

3. -> 系统变量 配置==php.ini==所在的路径
![image](A50365ACB68849F9A886823A4E0FD5FB)

4. 前往composer官网现在一下composer.phar。
地址：https://getcomposer.org/download/ </br>
![image](C38BC9D7DA2F488B8862501181150992)

5. 第三步：把composer.phar放在php的根目录，然后建立一个composer.bat也放在php目录下。</br>
![image](F5C0B2EE63EB4848B5175ECDC5C0D872)

6.  
```
1. 先到代码编辑器中打开composer.bat
   看到如下代码：
@"C:/phpstudy/php/php-7.2.7-nts/php.exe"  "C:/phpstudy/php/php-7.2.7-nts/composer.phar"  %*

   左边的修改为自己的php.exe所在路径，注意要尽量新的php版本，强烈推荐 7.0 以后
   右边的修改为自己的composer.phar 文件所在路径，这个文件安装composer完成以后就不能移动了。
   [注意，目录中不好包含中文或全角符号]

2. 把 composer.bat 所在的路径放置到 系统的环境变量中
   注意，php.exe所在的路径也要设置到系统的环境变量中

3. 打开一个新的cmd窗口，输入composer即可 
```
![image](8DADDBED47494903BECADF8AEA6F02A9)

### 2. 用compose安装laravel
```
使用Laravel框架必须达到以下PHP版本和开启以下扩展：
PHP版本 >= 5.6.4 
PHP扩展：OpenSSL 
PHP扩展：PDO 
PHP扩展：Mbstring
PHP扩展：fileinfo
PHP扩展：CURL
```

λ composer create-project laravel/laravel .\mylaravel\ v5.6.21

mylaravel 安装的目录 </br>
v5.6.21   安装版本

> 安装成功后 在所在的安装目录里运行 php artisan serve
```
G:\mylaravel
λ php artisan serve
Laravel development server started: <http://127.0.0.1:8000>
[Sat Aug 25 15:05:37 2018] 127.0.0.1:57383 [200]: /favicon.ico
```

> 通过浏览器访问
![image](C2FFBEDE0B5041119D0305BF9EE7E707)

> 在phpstudy里配置站点
![image](1A522BF65CAE4CE1A68EF06BFB0111A0)

> 通过浏览器访问  www.mylaravel.com
![image](9A1AAE044C0F4CE29CC166EE9D5B46A4)