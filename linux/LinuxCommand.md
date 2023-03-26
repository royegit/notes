# Linux 操作命令

[Linux 命令搜索,有详细的命令使用说明](https://jaywcjlove.gitee.io/linux-command/)

#### 常用到的命令

查看 Linux 当前的连接数
>$ ss -n|grep ESTAB | wc -l  
###### 例
```dockerfile
[root@ecs-7ca3 ~]# ss -n|grep ESTAB|wc -l
765
```
或
>$ netstat -n|grep ESTAB|wc -l

```dockerfile
bash-5.1# netstat -n|grep ESTAB|wc -l
28
```
两条命令一样的效果，ss 比 netstat 好用的socket统计信息,但是有的时候有的linux 系统不一定有 ss 这个命令

##### pgrep

根据用户给出的信息在当前运行进程中查找并列出符合条件的进程ID（PID）
列出 nginx 所有的进程号
>$ pgrep nginx

###### 例
```dockerfile
[root@ecs-7ca3 ~]# pgrep nginx
2011566
3593368
3593369
3593370
3593371
3593372
```