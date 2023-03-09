#Docker 操作命令
***
####容器使用
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
####获取镜像
docker 从远程仓库下载 Centos7 镜像命令

>$ docker pull centos7

该命令等同于 docker pull centos7:latest; latest 是最新版本的意思或者指定一个centos7版本也可以

#### 根据 DockerFile 创建一个容器
根据当前目录下的 DockerFile 文件构建一个 hyperf 容器
>$ docker build -t hyperf .

####启动容器
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
