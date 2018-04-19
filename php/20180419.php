<?php
/**
 * simple function to explode a string with keys specified in the string.
 */

/**
 * [explode_with_keys description]
 * @param  [type] $delim1      [description] delimiter1
 * @param  [type] $delimi2     [description] delimiter2
 * @param  [type] $inputstring [description] string
 * @return [type]              [description]
 */
function explode_with_keys($delim1, $delimi2, $inputstring)
{
	$firstarr = explode($delim1, $inputstring);
	$finallarr = [];
	foreach($firstarr as $set){
		$setarr = explode($delimi2, $set);
		$finallarr[$setarr[0]] = $setarr[1];
	}
	return $finallarr;
}
echo '<pre>';
print_r(explode_with_keys(";", ":", "a:b;c:d;e:f"));

/*
will output
 */
/*
Array
(
    [a] => b
    [c] => d
    [e] => f
)
*/