# Nginx 操作命令
#### Linux 查看定位当前正在运行的Nginx的配置文件

Linux在启动一个进程时，系统会在/proc下创建一个以PID命名的文件夹，在该文件夹下会有我们的进程的信息，其中包括一个名为exe的文件即记录了绝对路径，通过ll或ls –l命令即可查看。

* cwd符号链接的是进程运行目录；
* exe符号连接就是执行程序的绝对路径
* cmdline就是程序运行时输入的命令行命令；
* environ记录了进程运行时的环境变量；
* fd目录下是进程打开或使用的文件的符号连接。


#### 查看命令的绝对路径。

>$ cat /proc/xxxx/environ |grep PWD

因为备份、不同版本等问题，导致ECS Linux上存放有多个Nginx目录，可以通过如下方法定位当前正在运行的Nginx的配置文件：

#### 1. 查看nginx的PID，以常用的80端口为例：

>$ netstat -anop | grep 0.0.0.0:80

```angular2html
[root@ecs-7ca3 logs]# netstat -anop | grep 0.0.0.0:80
tcp        0      0 0.0.0.0:8090            0.0.0.0:*               LISTEN      2011423/phpstudy     off (0.00/0/0)
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      2011566/nginx: mast  off (0.00/0/0)
```

#### 2. 通过相应的进程ID(比如：2011566）查询当前运行的nginx路径

>$ ll  /proc/2011566/exe
```
[root@ecs-7ca3 logs]# ll  /proc/2011566/exe
lrwxrwxrwx 1 root root 0 Mar 10 12:57 /proc/2011566/exe -> /usr/local/nginx/nginx-1.15/nginx/sbin/nginx
```

#### 3. 获取到nginx的执行路径后，使用-t参数即可获取该进程对应的配置文件路径，如：

>$  /usr/local/nginx/nginx-1.15/nginx/sbin/nginx -t


```gherkin
[root@ecs-7ca3 logs]# /usr/local/nginx/nginx-1.15/nginx/sbin/nginx -t
nginx: the configuration file /usr/local/nginx/nginx-1.15/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/nginx-1.15/nginx/conf/nginx.conf test is successful
```
#### 4.平滑重启命令：
kill -HUP 住进称号或进程号文件路径
或者使用

>$ /usr/local/nginx/nginx-1.15/nginx/sbin/nginx -s reload

注意，修改了配置文件后最好先检查一下修改过的配置文件是否正 确，以免重启后Nginx出现错误影响服务器稳定运行。
判断Nginx配置是否正确命令如下：

```gherkin
[root@ecs-7ca3 logs]# /usr/local/nginx/nginx-1.15/nginx/sbin/nginx -t
nginx: the configuration file /usr/local/nginx/nginx-1.15/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/nginx-1.15/nginx/conf/nginx.conf test is successful
```
或者

```gherkin
[root@ecs-7ca3 logs]# /usr/local/phpstudy/soft/nginx/nginx-1.15/nginx/sbin/nginx -t -c /usr/local/phpstudy/soft/nginx/nginx-1.15/nginx/conf/nginx.conf
nginx: the configuration file /usr/local/phpstudy/soft/nginx/nginx-1.15/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/phpstudy/soft/nginx/nginx-1.15/nginx/conf/nginx.conf test is successful
```

#### Centos nginx 重启
重启Nginx

>$ service nginx restart

>$ /etc/init.d/nginx stop

>$ /etc/init.d/nginx start

#### Ubuntu Nginx
重启Nginx
>$ sudo service nginx start

>$ sudo service nginx stop

## LNMP - 已有站点添加SSL证书/免费Let's Encrypt证书方法

最近几年网站安装SSL证书（HTTPS形式的网址）应该算是一个趋势，根据传言如果是英文网站或者是基于Google搜索引擎获取流量的，如果有使用SSL证书还会给网站加分。不过目前中文网站（百度等搜索引擎）并没有过分的强制，但是可能也是趋势。不过个人看法是强制使用SSL证书也并不正确，因为有些普通内容型网站，并不是用户交互的其实也没有必要用SSL证书。

在之前的LNMP一键脚本中，是没有自带SSL证书安装功能的，从V1.4开始带有这个功能，对于站长用户来说方便很多，我们可以在添加站点的时候直接安装第三方购买的SSL证书，也可以使用免费Let's Encrypt证书。同时，我们也可以将开始并没有使用SSL证书的网站在不动网站结构和内容的前提下只添加SSL证书。

在这篇文章中，老部落网站就来演示正在运行中的没有使用SSL证书的网站，如果不动数据的前提下安装SSL证书的。

### 第一、LNMP添加SSL证书命令

>$ lnmp ssl add

我们可以用这个命令给已有的网站添加SSL证书。

### 第二、SSL证书设置选项参数

```injectablephp
Please enter domain(example: www.lnmp.org): v.laobuluo.com
Your domain: v.laobuluo.com
Enter more domain name(example: lnmp.org *.lnmp.org):
Please enter the directory for domain v.laobuluo.com: /home/wwwroot/v.laobuluo.com
Allow Rewrite rule? (y/n) y
Please enter the rewrite of programme,
wordpress,discuz,typecho,sablog,typecho rewrite was exist.
(Default rewrite: other): wordpress
You choose rewrite: wordpress
Allow access log? (y/n) y
Enter access log filename(Default:v.laobuluo.com.log):
You access log filename: v.laobuluo.com.log
1: Use your own SSL Certificate and Key
2: Use Let's Encrypt to create SSL Certificate and Key
Enter 1 or 2: 2
Please enter your email address: i@laobuluo.com
```

![LNMP](https://raw.githubusercontent.com/royegit/notes/master/PHP/php_promotion/coupon/images/Quicker_20230330_141243.png)
