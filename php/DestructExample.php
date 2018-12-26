<?php
/**
* 析构方法
**/
class Person
{
	private $name;
	private $age;
	private $id;
	
	public function __construct($name, $age)
	{
		$this->name = $name;
		$this->age = $age;
	}
	
	public function setId($id)
	{
		$this->id = $id;
	}
	
	public function __destruct()
	{
		if (!empty($this->id)) {
			//保存person数据
			print_r("saving person\n");
		}
	}
}

$person = new Person('wangtianshi', 44);
$person->setId(17);
unset($person);