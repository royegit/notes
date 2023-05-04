# php 遇到过的报错级解决方案

#### 报错信息 
Warning: require(): open_basedir restriction in effect
```injectablephp
Warning: require(): open_basedir restriction in effect. File(/www/wwwroot/zhuyuyun/thinkphp/start.php) is not within the allowed path(s): (/www/wwwroot/zhuyuyun/public/:/tmp/:/proc/) in /www/wwwroot/zhuyuyun/public/index.php on line 20
Warning: require(/www/wwwroot/zhuyuyun/thinkphp/start.php): failed to open stream: Operation not permitted in /www/wwwroot/zhuyuyun/public/index.php on line 20
Fatal error: require(): Failed opening required '/www/wwwroot/zhuyuyun/public/../thinkphp/start.php' (include_path='.:/www/server/php/56/lib/php') in /www/wwwroot/zhuyuyun/public/index.php on line 20
```

出现这个问题的原因是由于lnmp配置的时候fastcgi.conf配置PHP_ADMIN_VALUE为”open_basedir=$document_root/:/tmp/:/proc/”，而且在配置虚拟主机的时候fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; 就会指定到你配置的路径中，如下：



#### 解决方案

在Nginx 配置文件中找到 `fastcgi.conf` 文件 ，然后在文件中找到 `fastcgi_param PHP_ADMIN_VALUE "open_basedir=$document_root/:/tmp/:/proc/";` 修改成你网站的根目录；把 `$document_root` 改成 `/www/wwwroot/zhuyuyun` 即可，同时注释掉`php.ini`中的`open_basedir;`
