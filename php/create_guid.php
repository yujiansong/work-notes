<?php
    //生成guid方法
    function guid() {    
        if (function_exists('com_create_guid')) {        
            return rtrim(ltrim(com_create_guid(), '{'), '}');    
        } else {     
            mt_srand((double)microtime()*10000);
            $charid = strtoupper(md5(uniqid(rand(), true))); 
            $hyphen = chr(45);        
            $uuid   = substr($charid, 0, 8).$hyphen               
                     .substr($charid, 8, 4).$hyphen            
                     .substr($charid,12, 4).$hyphen            
                     .substr($charid,16, 4).$hyphen            
                     .substr($charid,20,12);
            return $uuid;    
        }
    }

    $get_guid = guid();
    print_r($get_guid); //517AE1C6-4BE0-E0E7-12D7-4700751FABE4