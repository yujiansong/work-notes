<?php
//in foreach if you want to iterate through a specific column in a nested arrays for example:

$arr = [
	[1, 5, 8, 0],
	['a', 'k', 'wanger', 'm'],
	['d', 2, 'laozheng', 'wanglaoer'],
];
//when we want to iterate on the third column we can use:
foreach ($arr as list(, , $a)) {
	$data[] = $a;
}
echo'<pre>';
print_r($data);