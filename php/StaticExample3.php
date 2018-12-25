<?php
/**
* static 延迟静态绑定
**/
abstract class DomainObject
{
	private $group;
	public function __construct()
	{
		$this->group = static::getGroup();
	}
	
	public static function create()
	{
		return new static();
	}
	
	static public function getGroup()
	{
		return 'default';
	}
}

class User extends DomainObject
{
	
}

class Document extends DomainObject
{
	static public function getGroup()
	{
		return 'document';
	}
}

class SpreadSheet extends Document
{
	
}

//Document::create();
print_r(User::create()); //User Object ( [group:DomainObject:private] => default ) 
echo'<br>';
print_r(SpreadSheet::create()); //SpreadSheet Object ( [group:DomainObject:private] => document )