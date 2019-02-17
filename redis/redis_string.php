<?php
/**
 * redis-string application practise
 * @var [type]
 */
$redis = new \Redis();
$redis->connect('127.0.0.1', 6379);

/**
 * 缓存数据
 * 
 * JSON_UNESCAPED_UNICODE http://www.laruence.com/2011/10/10/2239.html
 * PHP的json_encode来处理中文的时候, 中文都会被编码, 变成不可读的
 * Json新增了一个选项: JSON_UNESCAPED_UNICODE, 故名思议, 就是说, Json不要编码Unicode.
 */
// echo json_encode('王老二', JSON_UNESCAPED_UNICODE);


if ($redis->set('player', 'wanglaoer')) {
	echo 'success';
} else {
	echo 'false';
}
echo "<br>";
if ($redis->set('oldboy', json_encode(['name' => '王老二', 'age' => 29, 'from ' => '辽宁'], JSON_UNESCAPED_UNICODE))) {
	echo 'success';
} else {
	echo 'false';
}
echo "<br>";

//获取缓存数据
print_r($redis->get('player')); //wanglaoer
echo "<hr>";
print_r(json_decode($redis->get('oldboy'), true)); //Array ( [name] => 王老二 [age] => 29 [from ] => 辽宁 )
echo "<hr>";
var_dump($redis->get('notexists')); //bool(false)


