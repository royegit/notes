<?php

class App{

public function run(){
			echo 1111;
	}
	
public function run2(){
			echo 22222;
	}
	
public function run3(){
			echo 3333;
	}
	
}

$url=$_SERVER['PHP_SELF'];   //截取url地址  ；http://localhost/thinkphptest/index.php/run3
$url2=explode('/',$url);     //截取把url转数组

//数组 案例
//  D:\phpStudy\PHPTutorial\WWW\thinkphptest\index.php:22:
//  array (size=4)
//    0 => string '' (length=0)
//    1 => string 'thinkphptest' (length=12)
//    2 => string 'index.php' (length=9)
//    3 => string 'run3' (length=4)
  

$app=new App();

//  执行当前操作  
//  $app     实例化类
//  $url2[3] 是方法名
$method =   new \ReflectionMethod($app,$url2[3]);  

//  $url2[3] 是方法名
$method->invoke($app);  //执行一个方法

?>