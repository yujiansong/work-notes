<?php

class ShopProduct
{
	private $title = 'default product';
	private $producerMainName = 'main name';
	private $producerFirstName = 'first name';
	protected $price = 0;
	private $discount = 0;

	public function __construct($title, $mainName, $firstName, $price)
	{
		$this->title = $title;
		$this->producerMainName = $mainName;
		$this->producerFirstName = $firstName;
		$this->price = $price;
	}

	public function getTitle()
	{
		return $this->title;
	}

	public function getProducerMainName()
	{
		return $this->producerMainName;
	}

	public function getProducerFirstName()
	{
		return $this->producerFirstName;
	}


	/** 设置折扣数量 */
	public function setDiscount($num)
	{
		$this->discount = $num;
	}

	public function getDiscount()
	{
		return $this->discount;
	}
	
	/**
	 * 调整过的价格
	 * @return [type] [description]
	 */
	public function getDiscountPrice()
	{
		return ($this->price - $this->discount);
	}

	public function getProducer()
	{
		return "{$this->producerMainName}"." {$this->producerFirstName}";
	}

	public function getSummaryLine()
	{
		$base = "{$this->title} ({$this->producerMainName}, ";
		$base .= "{$this->producerFirstName} )";
		return $base;
	}
}

class CdProduct extends ShopProduct
{
	private $playLength = 0; //cd播放时间

	public function __construct($title, $mainName, $firstName, $price, $playLength)
	{
		parent::__construct($title, $mainName, $firstName, $price);
		$this->playLength = $playLength;
	}

	public function getPlayLength()
	{
		return $this->playLength;
	}

	public function getSummaryLine()
	{
		//在基类中为子类CdProduct方法getSummaryLine完成核心功能，接着在子类中简单调用父类方法，然后增加更多数据到字符串，而不再重复实现相同的功能
		// $base = "{$this->title} ({$this->producerMainName}, ";
		// $base .= "{$this->producerFirstName} )";
		$base = parent::getSummaryLine();
		$base .= ": play time - {$this->playLength}";
		return $base;
	}
}

class BookProduct extends ShopProduct
{
	private $numPages = 100;

	public function __construct($title, $mainName, $firstName, $price, $numPages)
	{
		parent::__construct($title, $mainName, $firstName, $price);
		$this->numPages = $numPages;
	}

	public function getNumberOfPages()
	{
		return $this->numPages;
	}

	public function getPrice()
	{
		return $this->price;
	}

	public function getSummaryLine()
	{
		//在基类中为子类BookProduct方法getSummaryLine完成核心功能，接着在子类中简单调用父类方法，然后增加更多数据到字符串，而不再重复实现相同的功能
		//$base = "{$this->title} ({$this->producerMainName}, ";
		//$base .= "{$this->producerFirstName} )";
		$base = parent::getSummaryLine();
		$base .= ": page count - {$this->numPages}";
		return $base;
	}
}

$product2 = new CdProduct("大城小爱", "盖世", "英雄", 399, null, 40);
$product3 = new BookProduct("基督山伯爵", "爱德蒙", "唐泰斯", 128, 800, null);
// print_r("booklist: ".$product3->getProducer());
// echo'<br>';
// print_r("summaryline: ".$product3->getSummaryLine());
// echo '<br>';
// print_r("这本书原价是: ".$product3->price);
// print_r("这本书的原价是: ".$product3->getPrice());
// echo '<br>';
$product3->setDiscount(50);
//print_r("折后价格是: ".$product3->getDiscountPrice());

class ShopProductWriter
{
	private $products = [];

	public function addProduct(ShopProduct $shopProduct)
	{
		$this->products[] = $shopProduct;
	}

	public function write()
	{
		$str = "";
		foreach ($this->products as $shopProduct) {
			$str .= "{$shopProduct->getTitle()}";
			$str .= $shopProduct->getProducer();
			$str .= " ({$shopProduct->getDiscountPrice()})";
			$str .= "<br>";
		}
		return $str;
	}
}

$writer = new ShopProductWriter();
$writer->addProduct($product2);
$writer->addProduct($product3);
print_r($writer->write());
echo'ok';