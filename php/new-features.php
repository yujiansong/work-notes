<?php
/**
?? skill
*/
//null�ϲ������ǰʹ��trim���˵����ߵĿո�
$name = '  wanglaoer  ';
$username = trim($name) ?? 'anonymous';
print_r(strlen($name)); //13
var_dump($username); //string(9) "wanglaoer" 
?>

<?php
//null�ϲ������ǰ��ʹ��trim��ԭֵ���
$name = '   wanglaoer   ';
$username = $name ?? 'anonymous';
print_r(strlen($name)); //15
var_dump($username);  //string(15) " wanglaoer " 
?>

<?php
//null�ϲ������ǰʹ��trim���˵����ߵĿո�
$name = '   ';
$username = trim($name) ?? 'anonymous';
var_dump($username); //string(0) ""
?>

<?php
//null�ϲ������ǰ��ʹ��trim��ԭֵ���
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


