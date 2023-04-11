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




