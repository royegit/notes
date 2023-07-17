# php 常用函数组合总结

### php 计算两个日期之间相差天数

```injectablephp
    $ApplyDate1='2023-03-20 12:59:59';
    $ApplyDate2='2023-03-18 12:59:59';
    $date2 = date_create($ApplyDate1);
    $date1 = date_create($ApplyDate2);
    $interval = date_diff($date1,$date2);
    echo $interval->format("%r%a");
    // 输出：2
```

### 去除数组中重复的元素值
```injectablephp
array_unique() 
```
### 把字符串写入txt文本文件
```injectablephp
file_put_contents("test.txt", "This is something.");
```
### php获取数组最小值和最大值，包括获取key

```injectablephp
$array=array_column($spec,'fee'); // 获取数组中的 fee 字段的值
```

### 获取最大的值

```injectablephp
$a=array('1','3','55','99');
$pos = array_search(max($a), $a);
echo $a[$pos];
```
### 获取最小的

```injectablephp
$a=array('1','3','55','99');
$pos = array_search(min($a), $a);
echo $a[$pos];
```

### php 合并相同的值

```injectablephp
$arr = ['0006','0006','0005'];
print_r($arr);      //Array ( [0] => 0006 [1] => 0006 [2] => 0005 )
$arr = array_unique($arr);
print_r($arr);      //Array ( [0] => 0006 [2] => 0005 )
```
### 数组转为字符串

```injectablephp
$array=["php","Java","web"];
$result=implode(",",$array);
```
### 字符串转为数组

```injectablephp
$str="php,java,web";
$rsult=explode(',',$str);
```

### php 对二维数组的某个字段进行升序或降序排列

```injectablephp
$data1=array(array('id'=>'44','spec_id'=>'11','item'=>'600','order_index'=>'0'),array('id'=>'43','spec_id'=>'11','item'=>'200','order_index'=>'0'),array('id'=>'42','spec_id'=>'11','item'=>'100','order_index'=>'0'),array('id'=>'41','spec_id'=>'11','item'=>'50','order_index'=>'0'),array('id'=>'40','spec_id'=>'11','item'=>'30','order_index'=>'0'),array('id'=>'39','spec_id'=>'11','item'=>'20','order_index'=>'0'));
//根据字段item对数组$data进行降序排列
$last_names=array_column($data1,'item');
array_multisort($last_names,SORT_ASC,$data1);

var_dump($data1)
```

### php 截取字符串

```injectablephp
$email = 'user@5idev.com';	  		//定义字符串
$domain = strstr($email,'@',true);	//从@开始往后截取掉，如果没有true则到@之前的部分截取掉
echo $domain;
```
### php 请求取第三方连接内容 ddd

```injectablephp
$ggg=file_get_contents('http://i.tianqi.com/index.php?c=code&id=7');
echo $ggg;exit;
```

### centos如何启动php
#### centos7启动php：

重启：systemctl restart php-fpm.service

开启：systemctl start php-fpm.service

关闭：systemctl stop php-fpm.service

centos6启动php：

重启：service php-fpm restart

开启：service php-fpm start

关闭：service php-fpm stop
