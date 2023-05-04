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

![LNMP](https://raw.githubusercontent.com/royegit/notes/master/NGINX/images/lnmp-ssl-1.jpg)

我们根据提示填写要设置SSL证书的域名、网站路径。因为我们是要给已有网站添加SSL证书，所以要确认好当前域名已经添加站点，以及当前网站的目录，这里我就不用购买的SSL证书，而是用免费 Let's Encrypt证书。最后，我们就等待自动安装执行。

![LNMP](https://raw.githubusercontent.com/royegit/notes/master/NGINX/images/lnmp-ssl-2.jpg)

看到这个表示已经安装完毕。

### 第三、检查SSL证书是否生效


![LNMP](https://raw.githubusercontent.com/royegit/notes/master/NGINX/images/lnmp-ssl-3.jpg)

我们去浏览器地址栏输入HTTPS格式网址打开看看，看到上面已经带有绿标的 Let's Encrypt证书生效。而且不用我们手动续约，每个7天会自动检测一次帮助我们续约证书。

### 第四、强制HTTPS地址访问

这里我们发现一个问题，默认并不是强制HTTP访问HTTPS的，我们肯定需要强制跳转过去。

1、修改位置

>$ /usr/local/nginx/conf/vhost

找到对应站点配置文件。

2、添加强制HTTPS脚本

>$ if ($ssl_protocol = "") { return 301 https://$host$request_uri; }

脚本添加到配置文件80模块区域中。

![LNMP](https://raw.githubusercontent.com/royegit/notes/master/NGINX/images/lnmp-ssl-4.jpg)

3、重启Nginx

>$ lnmp nginx reload

生效之后我们再去打开网站，就可以强制以HTTPS形式访问网站。

### 第五、LNMP添加SSL证书小结

1、LNMP一键包目前自带添加站点的时候可选安装SSL证书或者免费Let's Encrypt证书；

2、我们也可以在没有添加SSL证书已经运行的网站，不动网站数据前提下单独添加SSL证书，不会影响网站运行。

3、添加SSL证书之后，我们需要手动设置Nginx配置，强制HTTPS访问。





