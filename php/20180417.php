<?php
//thinkphp 5.0.12版本 Helpers::getconfig 使用

//1.调用配置文件的配置参数
//助手函数方法 F:\project\toolink\extend\core\Helpers.php


//配置文件位置 F:\project\toolink\config\database.php
//当前文件位置 F:\project\toolink\admin\clinic\controller\Promote.php
//调用需要的数据库
$result = model('Dictionary','service')->getDictionary($param['code'], Helpers::getConfig('database', 'db_clinic.database'));
