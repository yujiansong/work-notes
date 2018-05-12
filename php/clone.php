<?php

/** 
 * php中的对象传递是引用传递
 */
class Cla
{
	public $pub = 10;
	public function __destruct() 
	{
		echo __METHOD__, '<br>';
	}
}

$cla = new Cla();
echo $cla->pub, '<br>'; //10
$clb = $cla;
$clb->pub = 20;
echo $cla->pub, '<br>'; //20
?>

<?php
/*
clone(obj);
说明：
	用于对obj对象进行克隆，复制得到另一个一模一样的对象。是得到另一个对象的方法。
*/
class Cla
{
	public $pub = 10;
	public function __clone() 
	{
		echo __METHOD__, '<br>';
	}
} 
$cla = new Cla;
echo $cla->pub , '<br>';
$clb = clone($cla);
$clb->pub = 20;
echo $clb->pub, '<br>'; //20
echo $cla->pub, '<br>'; //10
//当一个类的对象被执行clone操作时，那么这个类中的__clone方法会被自动调用。
