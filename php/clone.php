<?php

/** 
 * php�еĶ��󴫵������ô���
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
˵����
	���ڶ�obj������п�¡�����Ƶõ���һ��һģһ���Ķ����ǵõ���һ������ķ�����
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
//��һ����Ķ���ִ��clone����ʱ����ô������е�__clone�����ᱻ�Զ����á�
