<?php

class Account
{
	public $balance;
	public function __construct($balance)
	{
		$this->balance = $balance;
	}
}

class Person
{
	private $name;
	private $age;
	private $id;
	public $account;
	
	public function __construct($name, $age, Account $account)
	{
		$this->name = $name;
		$this->age = $age;
		$this->account = $account;
	}
	
	public function setId($id)
	{
		$this->id = $id;
	}
	
	public function __clone()
	{
		$this->id = 0;
		$this->account = clone $this->account;
	}
}

$person = new Person('wangtianshi', 28, new Account(200));
$person->setId(10);
$person2 = clone $person;
echo'<pre>';

//print_r($person);
/*
Person Object
(
    [name:Person:private] => wangtianshi
    [age:Person:private] => 28
    [id:Person:private] => 10
    [account:Person:private] => Account Object
        (
            [balance] => 200
        )

)
*/

//给person充值一些钱
$person->account->balance += 200;

print_r($person);
/*
Person Object
(
    [name:Person:private] => wangtianshi
    [age:Person:private] => 28
    [id:Person:private] => 10
    [account] => Account Object
        (
            [balance] => 400
        )

)
*/

//print_r($person2); //结果person2也得到了这笔钱
/*
Person Object
(
    [name:Person:private] => wangtianshi
    [age:Person:private] => 28
    [id:Person:private] => 0
    [account] => Account Object
        (
            [balance] => 400
        )

)
*/

//如果不希望对象属性在复制后被共享，那么可以在 __clone()方法中复制指向的对象
/*
public function __clone()
{
	$this->id = 0;
	$this->account = clone $this->account;
}
*/