<?php

class PersonWriter
{
	public function writeName(Person $p)
	{
		print_r($p->getName()."\n");
	}
	
	public function writeAge(Person $p)
	{
		print_r($p->getAge()."\n");
	}
}

class Person
{
	private $writer;
	
	public function __construct(PersonWriter $writer)
	{
		$this->writer = $writer;
	}
	
	public function __call($methodname, $args)
	{
		if (method_exists($this->writer, $methodname)) {
			return $this->writer->$methodname($this);
		}
	}
	
	public function getName(){return 'Bob';}
	public function getAge(){return 44;}
}

$person = new Person(new PersonWriter());
$person->writeName(); //Bob