<?php

/*
class CopyMe
{
	
}

$first = new CopyMe();
$second = $first;
var_dump($first === $second); //bool(true)
$second = clone $first;
var_dump($first === $second); //bool(false)
*/


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
	
	public function __clone()
	{
		$this->id = 0;
	}
}

$person = new Person('wangtianshi', 26);
$person->setId(10);
$person2 = clone $person;
print_r($person2);
//Person Object ( [name:Person:private] => wangtianshi [age:Person:private] => 26 [id:Person:private] => 0 )









