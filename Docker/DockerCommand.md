# Docker 操作命令
#### 容器使用
可以通过命令 ```docker command --help``` 更深入的了解指定的Docker 命令使用方法。
例如我们要查看 ```docker stats``` 指令的具体使用方法:

>[runoob@runoob:~]# docker stats --help

```linux
[root@ecs-7ca3 ~]# docker stats --help

Usage:  docker stats [OPTIONS] [CONTAINER...]

Display a live stream of container(s) resource usage statistics

Options:
  -a, --all             Show all containers (default shows just running)
      --format string   Pretty-print images using a Go template
      --no-stream       Disable streaming stats and only pull the first result
      --no-trunc        Do not truncate output
```
#### 获取镜像

docker 从远程仓库下载 Centos7 镜像命令

>$ docker pull centos7

该命令等同于 docker pull centos7:latest; latest 是最新版本的意思或者指定一个centos7版本也可以

#### 根据 DockerFile 创建一个容器
根据当前目录下的 DockerFile 文件构建一个 hyperf 容器
>$ docker build -t hyperf .

#### 启动容器

>$ docker run -it centos7 /bin/bash

或者
>$ docker run -it centos7 bash

参数说明：
* -i : 交互式操作。
* -t : 终端。
* centos7 : centos7镜像
* /bin/bash:放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 ```/bin/bash``` 或者直接 ``bash``

要退出终端，直接输入 exit:

>bash-5.1# exit


#### 后台运行

在大部分的场景下，我们希望 docker 的服务器是后台运行的，我们可以通过 ``-d`` 指定容器的运行模式。

>$ docker run --name hyperf1 -p 9502:9501 -v F:\hyperf1:/hyperf1 -itd hyperf

>$ docker run --name hyperf1 -p 9502:9501 -v F:\hyperf1:/hyperf1 -v /www/admin/laravel/public/rule/:/www/admin/laravel/public/rule/ -itd hyperf  //映射多个目录
参数说明：
* -p : 映射端口，第一个 9502 为主机端口第二个9501为docker容器端口
* -v : 映射路径 F:\hyperf1 路径是你本地主机的路径 /hyperf1 是容器主机的路径
* -i : 交互式操作。
* -t : 终端。
* hyperf : hyperf 镜像
* /bin/bash:放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 ```/bin/bash``` 或者直接 ``bash``

注：加了 -d 参数默认不会进入容器。
#### 启动已停止运行的容器
查看所有的容器命令如下：

>$ docker ps -a

参数说明：
* -a : 所有启动/未启动的容器都显示出来，没有 ``-a`` 时只显示已启动的容器

```linux
[root@ecs-7ca3 ~]# docker ps -a
CONTAINER ID   IMAGE          COMMAND     CREATED        STATUS       PORTS                                       NAMES
e085d058b698   e0d7e8530099   "/bin/sh"   5 days ago     Up 2 hours   0.0.0.0:9502->9501/tcp, :::9502->9501/tcp   hyperf2
d22792037206   e0d7e8530099   "/bin/sh"   4 months ago   Up 2 hours   0.0.0.0:9503->9501/tcp, :::9503->9501/tcp   hyperf3
c3fe7de823c4   e0d7e8530099   "/bin/sh"   7 months ago   Up 2 hours   0.0.0.0:9501->9501/tcp, :::9501->9501/tcp   hyperf1
```

使用 docker start 启动一个已停止的容器：

>$ docker start hyperf1

或者也可以使用容器Id启动

>$ docker start c3fe7de823c4

或者还可以更简化方法，只输入容器Id的前一两个字符一样可以启动对应的容器

>$ docker start c3

#### 停止一个容器
停止容器的命令如下：
>$ docker stop <容器 ID>

例：
```
[root@ecs-5120 ~]# docker stop c3fe7de823c4 
```

#### 进入容器
在使用 -d 参数时，容器启动后会进入后台。此时想要进入容器，可以通过以下指令进入：

* docker attach
* docker exec：推荐大家使用 docker exec 命令，因为此命令会退出容器终端，但不会导致容器的停止。

###### attach 命令
>$ docker attach c3fe7de823c4

注意： 使用这个命令进入容器退出时，会导致容器的停止。

###### exec 命令
下面演示了使用 docker exec 命令。

>$ docker exec -it c3fe7de823c4 bash

注意： 使用这个命令进入容器退出时，容器不会停止，这就是为什么推荐大家使用 docker exec 的原因。
更多参数说明请使用 docker exec --help 命令查看。

#### 删除容器
删除容器使用 docker rm 命令：

>$ docker rm -f c3fe7de823c4

#### 宿主机连接Docker服务器地址
```injectablephp
DB_HOST=host.docker.internal #本地 - 映射本地IP
DB_USERNAME=sa
DB_PASSWORD=123456
```

#### 从容器内部拷贝一个文件到宿主机

>$ docker cp  c3fe7de823c4:/etc/nginx/nginx.conf

#### 复制一个文件到docker容器内部

>$ ADD nginx.conf  /etc/nginx/nginx.conf

### Dockerfile 自动构建脚本
> FROM：定制的镜像都是基于 FROM 的镜像，这里的 centos:6.9 就是定制需要的基础镜像。后续的操作都是基于 nginx。

> RUN：用于执行后面跟着的命令行命令。有以下俩种格式：

**格式：**
``` 
RUN <命令行命令>
<命令行命令> 等同于，在终端操作的 shell 命 
``` 
**注意：** Dockerfile 的指令每执行一次都会在 docker 上新建一层。所以过多无意义的层，会造成镜像膨胀过大。

**例如：**
```dockerfile
FROM centos:6.9
RUN yum -y install wget
RUN wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz"
RUN tar -xvf redis.tar.gz
```

以上执行会创建 3 层镜像。可简化为以下格式：
```dockerfile
FROM centos:6.9
RUN yum -y install wget \
    && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
    && tar -xvf redis.tar.gz
```
如上，以 && 符号连接命令，这样执行后，只会创建 1 层镜像。

#### docker 导出镜像

> docker save centos:6.9 > docker_centos6.9_ssh.tar.gz

#### docker 导入镜像
> docker load -i docker_centos6.9_ssh.tar.gz

#### 查看镜像构建历史
> docker image history centos:6.9 --no-trunc

#### docker 查看容器网络属性
> docker inspect centos:6.9

**Docker 网络类型**  
None: 不为容器配置任何网络功能，--net=none  
例：
```dockerfile
docker run -it --network none centos:6.9 /bin/bash
```
Container：与另一个运行中的容器共享Network Namespace，--net=container:containerID  
例：
```dockerfile
$ docker run -it --network container:c3fe7de823c4  centos:6.9 /bin/bash
```

Host：与主机共享NetWork Namespace , --net=host  
例：
```dockerfile
$ docker run -it --network host centos:6.9 /bin/bash
```
Bridge：Docker 设计的NAT网络模型

#### 跨主机容器直接的通讯之macvlan
Docker 跨主机容器之间的通信macvlan 默认一个物理网卡，只有一个物理地址，虚拟多个mac 地址  
首先准备两个主机节点的 Docker 环境，搭建如下拓扑  

| 主机 ```host1``` | 主机 ```host2```    |  
|----------------|-------------|
| 容器 ```c1```    | 容器 ```c2``` |

**例：**
创建 macvlan 网络
docker network create --driver macvlan ：意思是创建一个 macvlan 的网络类型
--subnet 10.0.0.0/24  : 意思是子网（  macvlan 网络所在的网络）
--gateway 10.0.0.254  ：指定网关
-o parent=eth0        ：指定用来分配 macvlan 网络的物理网卡

首先使用 docker network create 分别在两台主机上创建两个 macvlan 网络：
````dockerfile
$ docker network create --driver macvlan --subnet 10.0.0.0/24 --gateway 10.0.0.254 -o parent=eth0 maculan_1
````
**之后可以看到当前主机的网络环境，其中出现了 macvlan 网络：**
```
root@ubuntu:~# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
128956db798a        bridge              bridge              local
19fb1af129e6        host                host                local
2509b3717813        mac1                macvlan             local
d5b0798e725e        none                null                local
```
** 在 host1 运行容器 c1，并指定使用 macvlan 网络：**
```
root@ubuntu:~# docker run -itd --name c1 --ip=10.0.0.6 --network maculan_1 busybox
```
**这条命令中**  
```--ip``` 指定容器 c1 使用的 IP，这样做的目的是防止自动分配，造成 IP 冲突  
```--network```   指定 macvlan 网络  

**同样在 host2 中运行容器 c2：**  
```root@ubuntu:~# docker run -itd --name c2 --ip=10.0.0.7 --network maculan_1 busybox```

**注意：**
1、以上的实验都需要物理网卡 eth0 开启混杂模式，不然会 ping 不通，特别是在Ubuntu系统，Centos好像可以忽略。 
2、主机和这台主机的容器之间无法ping通，但是其他容器可以ping通其他主机。这是因为容器和主机共用一个网卡。这个问题待解决
```dockerfile
ip link set eth1 promisc on   -- 物理网卡设置为混杂模式
```

#### 开始构建镜像

在 Dockerfile 文件的存放目录下，执行构建动作。

以下示例，通过目录下的 Dockerfile 构建一个 centos:6.9（镜像名称:镜像标签/镜像版本））。
注：最后的 ```.```代表本次执行的上下文路径。

####  指令详解

| Dockerfile 指令 | 	说明                                           |
|---------------|-----------------------------------------------|
| FROM	         | 指定基础镜像，用于后续的指令构建。                             |
| MAINTAINER    | 	指定Dockerfile的作者/维护者。（已弃用，推荐使用LABEL指令）        |
| LABEL         | 	添加镜像的元数据，使用键值对的形式。                           |
| RUN	          | 在构建过程中在镜像中执行命令。                               |
| CMD	          | 指定容器创建时的默认命令。（可以被覆盖）                          |
| ENTRYPOINT	   | 设置容器创建时的主要命令。（不可被覆盖）                          |
| EXPOSE	       | 声明容器运行时监听的特定网络端口。                             |
| ENV	          | 在容器内部设置环境变量。                                  |
| ADD	          | 将文件、目录或远程URL复制到镜像中。                           |
| COPY	         | 将文件或目录复制到镜像中。                                 |
| VOLUME	       | 为容器创建挂载点或声明卷。                                 |
| WORKDIR       | 	设置后续指令的工作目录。                                 |
| USER	         | 指定后续指令的用户上下文。                                 |
| ARG           | 	定义在构建过程中传递给构建器的变量，可使用 "docker build" 命令设置。   |
| ONBUILD	      | 当该镜像被用作另一个构建过程的基础时，添加触发器。                     |
| STOPSIGNAL    | 	设置发送给容器以退出的系统调用信号。                           |
| HEALTHCHECK   | 	定义周期性检查容器健康状态的命令。                            |
|SHELL	| 覆盖Docker中默认的shell，用于RUN、CMD和ENTRYPOINT指令。     |

>$ docker build -t centos:6.9 .
```dockerfile
FROM centos:6.9 #定制的镜像都是基于FROM 的镜像，这里的 centos:6.9 就是定制需要的基础镜像。（基础镜像）

```


