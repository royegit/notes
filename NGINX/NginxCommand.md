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