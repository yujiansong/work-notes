<?php

$redis = new \Redis();
$redis->connect('127.0.0.1', 6379);

/**
 * redis 队列
 */
for ($i = 1; $i <= 10; $i++) {
	$user_id = mt_rand(0, 9999);
	$redis->rpush('students_no', json_encode(['student_no' => $user_id]));
}
echo "数据进列成功";



/**
 * 查看队列
 */
print_r($redis->lrange('students_no', 0, -1));


/**
 * 出队列
 */
print_r($redis->lpop('students_no'));