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

## pgrep

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
## free
显示内存的使用情况
###### 选项
* -s <间隔秒数> # 持续观察内存使用状况；
* -h 可以显示带单位（MB或者GB）易读格式：

free -h 可以显示带单位（MB或者GB）易读格式：
>$ free -h -s 3

```dockerfile
[root@ecs-7ca3 ~]# free -h -s 3
              total        used        free      shared  buff/cache   available
Mem:           15Gi       7.0Gi       373Mi       1.1Gi       8.1Gi       7.1Gi
Swap:            0B          0B          0B

              total        used        free      shared  buff/cache   available
Mem:           15Gi       7.0Gi       374Mi       1.1Gi       8.1Gi       7.1Gi
Swap:            0B          0B          0B

              total        used        free      shared  buff/cache   available
Mem:           15Gi       7.0Gi       379Mi       1.1Gi       8.1Gi       7.1Gi
Swap:            0B          0B          0B
```
#### CPU占用最多的前10个进程

>$ ps auxw|head -1;ps auxw|sort -rn -k3|head -10

```dockerfile
[root@ecs-7ca3 ~]# ps auxw|head -1;ps auxw|sort -rn -k3|head -10
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     2885877  261 14.8 2564316 2407204 ?     SNl  Feb09 169246:08 /tmp/.C3-unix/xmrig
www       589078  1.2  0.4 443264 65220 ?        S    Mar24  31:54 php-fpm: pool www
www       589052  1.2  0.3 443172 63644 ?        S    Mar24  31:59 php-fpm: pool www
www      3563719  1.2  0.5 444568 89804 ?        S    Mar17 157:56 php-fpm: pool www
www       231621  1.2  0.4 443552 71028 ?        S    Mar22  72:11 php-fpm: pool www
www       589082  1.1  0.3 443224 64464 ?        S    Mar24  31:11 php-fpm: pool www
www       589081  1.1  0.3 443100 64676 ?        S    Mar24  30:39 php-fpm: pool www
www       589080  1.1  0.3 443040 64476 ?        S    Mar24  31:09 php-fpm: pool www
www       589079  1.1  0.3 443060 63372 ?        S    Mar24  31:09 php-fpm: pool www
www       539323  1.1  0.4 443236 65552 ?        S    Mar24  35:04 php-fpm: pool www
```
#### 内存消耗最多的前10个进程
>$ ps auxw|head -1;ps auxw|sort -rn -k4|head -10

```dockerfile
[root@ecs-7ca3 ~]# ps auxw|head -1;ps auxw|sort -rn -k4|head -10
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     2885877  261 14.8 2564316 2407204 ?     SNl  Feb09 169247:31 /tmp/.C3-unix/xmrig
root       12803  0.0  1.0 292816 173556 ?       Ss   Jan16  10:57 /usr/lib/systemd/systemd-journald
www      2177983  0.7  0.7 446092 117340 ?       S    Mar08 196:35 php-fpm: pool www
www      2176514  0.7  0.7 445896 118064 ?       S    Mar08 195:22 php-fpm: pool www
www      2176513  0.7  0.7 445768 117324 ?       S    Mar08 194:25 php-fpm: pool www
www      2176512  0.7  0.7 445864 117572 ?       S    Mar08 191:33 php-fpm: pool www
www      2176511  0.7  0.7 447748 122984 ?       S    Mar08 192:54 php-fpm: pool www
www      2144819  0.7  0.7 450812 126600 ?       S    Mar08 203:29 php-fpm: pool www
www      2144818  0.7  0.7 445916 119964 ?       S    Mar08 196:36 php-fpm: pool www
www      2144817  0.7  0.7 445944 117616 ?       S    Mar08 194:25 php-fpm: pool www
```
#### 虚拟内存使用最多的前10个进程

>$ ps auxw|head -1;ps auxw|sort -rn -k5|head -10

```dockerfile
[root@ecs-7ca3 ~]# ps auxw|head -1;ps auxw|sort -rn -k5|head -10
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     2885877  261 14.8 2564316 2407204 ?     SNl  Feb09 169250:56 /tmp/.C3-unix/xmrig
root     2011423  0.0  0.1 1986524 25604 ?       SLl  Mar07   5:10 /usr/local/phpstudy/system/phpstudy -d
polkitd   371163  0.0  0.1 1766352 24056 ?       Ssl  Feb25   1:31 /usr/lib/polkit-1/polkitd --no-debug
root     1998673  0.0  0.3 1516780 59444 ?       Ssl  Mar07   2:45 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
root       13701  0.0  0.2 1509732 40772 ?       Ssl  Jan16  38:57 /usr/bin/containerd
root      893461  0.0  0.3 1440788 48888 pts/1   Sl+  09:21   0:00 docker exec -it 3b bash
root      899077  0.0  0.3 1440532 48720 pts/4   Sl+  10:04   0:00 docker exec -it c3 bash
root      893095  0.0  0.3 1440532 49284 pts/0   Sl+  09:19   0:00 docker exec -it 3b bash
root     3129792  0.0  0.3 1366800 54260 ?       Sl   Mar14   0:33 docker run --name hyperf-riskm -v /www/admin/hyperf-riskm:/home/hyperf-riskm -p 9505:9501 -it --privileged -u root --entrypoint /bin/sh hyperf:V1
root     1999057  0.0  0.0 1301136 12608 ?       Sl   Mar07   0:19 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 9503 -container-ip 172.17.0.4 -container-port 9501
```

##### 看看几个参数含义

* %MEM 进程的内存占用率
* MAJFL is the major page fault count,
* VSZ 进程所使用的虚存的大小
* RSS 进程使用的驻留集大小或者是实际内存的大小(RSS is the "resident set size" meaning physical memory used)
* TTY 与进程关联的终端（tty）