<?php
/**
?? skill
*/
//null合并运算符前使用trim过滤掉两边的空格
$name = '  wanglaoer  ';
$username = trim($name) ?? 'anonymous';
print_r(strlen($name)); //13
var_dump($username); //string(9) "wanglaoer" 
?>

<?php
//null合并运算符前不使用trim则原值输出
$name = '   wanglaoer   ';
$username = $name ?? 'anonymous';
print_r(strlen($name)); //15
var_dump($username);  //string(15) " wanglaoer " 
?>

<?php
//null合并运算符前使用trim过滤掉两边的空格
$name = '   ';
$username = trim($name) ?? 'anonymous';
var_dump($username); //string(0) ""
?>

<?php
//null合并运算符前不使用trim则原值输出
$name = '   ';
$username = $name ?? 'anonymous';
var_dump($username); //string(3) " "
?>

<?php
$username = $name ?? 'anonymous';
print_r($username); //string(9) "anonymous" 
?>

<?php
$name = null;
$username = $name ?? 'anonymous';
var_dump($name); //NULL
?>

<?php
name = false;
$username = $name ?? 'anonymous';
var_dump($name); //bool(false) 
?>

<?php
$name = true;
$username = $name ?? 'anonymous';
var_dump($name); //bool(true)  
?>

<?php
$name = 0;
$username = $name ?? 'anonymous';
var_dump($name); //int(0)
?>


