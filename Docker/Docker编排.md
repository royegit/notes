## Docker 编排

[Docker Compose 配置文件详解](https://www.jianshu.com/p/2217cfed29d7)
### 先安装 python2-pip、install docker-compose

> $ yum install python2-pip （需要epel源）

> $ pip install docker-compose (默认pypi源在国外)

安装 ```pip install docker-compose``` 时遇到问题如下：

```dockerfile
[root@localhost ~]# pip install docker-compose
Collecting docker-compose
  Using cached https://files.pythonhosted.org/packages/f3/3e/ca05e486d44e38eb495ca60b8ca526b192071717387346ed1031ecf78966/docker_compose-1.29.2-py2.py3-none-any.whl
Collecting cached-property<2,>=1.2.0; python_version < "3.8" (from docker-compose)
  Using cached https://files.pythonhosted.org/packages/48/19/f2090f7dad41e225c7f2326e4cfe6fff49e57dedb5b53636c9551f86b069/cached_property-1.5.2-py2.py3-none-any.whl
Requirement already satisfied (use --upgrade to upgrade): backports.ssl-match-hostname<4,>=3.5; python_version < "3.5" in /usr/lib/python2.7/site-packages (from docker-compose)
Collecting distro<2,>=1.5.0 (from docker-compose)
  Using cached https://files.pythonhosted.org/packages/4b/89/eaa3a3587ebf8bed93e45aa79be8c2af77d50790d15b53f6dfc85b57f398/distro-1.8.0.tar.gz
    Complete output from command python setup.py egg_info:
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
    IOError: [Errno 2] No such file or directory: '/tmp/pip-build-angoLH/distro/setup.py'

    ----------------------------------------
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-angoLH/distro/
You are using pip version 8.1.2, however version 23.2.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```
意思是需要先运行 ```pip install --upgrade pip ```   

**如下：**

```dockerfile
[root@localhost ~]# pip install --upgrade pip
Collecting pip
  Using cached https://files.pythonhosted.org/packages/ba/19/e63fb4e0d20e48bd2167bb7e857abc0e21679e24805ba921a224df8977c0/pip-23.2.1.tar.gz
    Complete output from command python setup.py egg_info:
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-build-wAxB6_/pip/setup.py", line 7
        def read(rel_path: str) -> str:
                         ^
    SyntaxError: invalid syntax

    ----------------------------------------
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-wAxB6_/pip/
You are using pip version 8.1.2, however version 23.2.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```
结果还是同样的错误需要运行 ``` pip install --upgrade pip```

**问题原因：**  
直接通过命令： pip install --upgrade pip 默认升级到最新pip版本21.3.1 (2021/12/01) 。
但 pip 21.0 之后的版本不支持python 2 ，所以导致升级失败。

**修复方法：**  
升级到最近一个pip 支持python2 的版本： 20.3.4

**修改命令如下**

>$ python -m pip install --upgrade pip==20.3.4

修改后可以正常运行 ```pip install --upgrade pip```，在运行一遍 ```pip install docker-compose```



#### Docker Compose配置常用字段

| 字段             | 	描述                                                                |
|----------------|--------------------------------------------------------------------|
| build          | 	指定 Dockerfile 文件名，要指定Dockerfile文件需要在build标签的子级标签中使用dockerfile标签指定 |
| dockerfile     | 	构建镜像上下文路径                                                         |
| context        | 	可以是 dockerfile 的路径，或者是指向 git 仓库的 url 地址                           |
| image          | 	指定镜像                                                              |
| command        | 	执行命令，覆盖容器启动后默认执行的命令                                               |
| container_name | 	指定容器名称，由于容器名称是唯一的，如果指定自定义名称，则无法scale指定容器数量                        |
| deploy         | 	指定部署和运行服务相关配置，只能在 Swarm 模式使用                                      |
| environment	   | 添加环境变量                                                             |
| networks       | 	加入网络，引用顶级networks下条目                                              |
| network_mode	  | 设置容器的网络模式，如 host，bridge，…                                          |
| ports	         | 暴露容器端口，与 -p 相同，但端口不能低于 60                                          |
 volumes	       | 挂载一个宿主机目录或命令卷到容器，命名卷要在顶级 volumes 定义卷名称                             |
| volumes_from	  | 从另一个服务或容器挂载卷，可选参数 :ro 和 :rw，仅版本 ‘2’ 支持                             |
| hostname	      | 容器主机名                                                              |
| sysctls        | 	在容器内设置内核参数                                                        |
| links	         | 连接到另外一个容器，- 服务名称[:服务别名]                                            |
| privileged     | 	用来给容器root权限，注意是不安全的，true                                          |
| restart	       | 设置重启策略，no，always，no-failure，unless-stopped                         |
|depends_on	|指定容器启动顺序|

>no: 默认策略，在容器退出时不重启容器。  
on-failure: 在容器非正常退出时（退出状态非0），才会重启容器。  
on-failure:3: 在容器非正常退出时重启容器，最多重启3次。  
always: 在容器退出时总是重启容器。  
unless-stopped: 在容器退出时总是重启容器，但是不考虑在 Docker 守护进程启动时就已经停止了的

#### Docker Compose 常用命令

| 字段     | 	描述             |
|--------|-----------------|
| build	 | 重新构建服务          |
| ps     | 	列出容器           |
| up	    | 创建和启动容器         |
| exec   | 	在容器里面执行命令      |
| scale	 | 指定一个服务容器启动数量    |
| top	   | 显示容器进程          |
| logs   | 	查看容器输出         |
| down   | 	删除容器、网络、数据卷和镜像 |
|stop/start/restart	|停止/启动/重启服务|




1、起几个容器就定义几个 ```services```
挂载一个目录或者一个已存在的数据卷容器，可以直接使用 [HOST:CONTAINER] 这样的格式，或者使用 [HOST:CONTAINER:ro] 这样的格式，后者对于容器来说，数据卷是只读的，这样可以有效保护宿主机的文件系统。  
Compose的数据卷指定路径可以是相对路径，使用 . 或者 .. 来指定相对目录。  
数据卷的格式可以是下面多种形式：
```dockerfile
volumes:
  // 只是指定一个路径，Docker 会自动在创建一个数据卷（这个路径是容器内部的）。
  - /var/lib/mysql

  // 使用绝对路径挂载数据卷
  - /opt/data:/var/lib/mysql

  // 以 Compose 配置文件为中心的相对路径作为数据卷挂载到容器。
  - ./cache:/tmp/cache

  // 使用用户的相对路径（~/ 表示的目录是 /home/<用户目录>/ 或者 /root/）。
  - ~/configs:/etc/configs/:ro

  // 已经存在的命名的数据卷。
```
如果你不使用宿主机的路径，你可以指定一个volume_driver。

```dockerfile
volume_driver: mydriver
```
#### volumes_from
从其它容器或者服务挂载数据卷，可选的参数是 :ro或者 :rw，前者表示容器只读，后者表示容器对数据卷是可读可写的。默认情况下是可读可写的。

````dockerfile
volumes_from:
  - service_name
  - service_name:ro
  - container:container_name
  - container:container_name:rw
````

#### depends_on
在使用 Compose 时，最大的好处就是少打启动命令，但是一般项目容器启动的顺序是有要求的，如果直接从上到下启动容器，必然会因为容器依赖问题而启动失败。
例如在没启动数据库容器的时候启动了应用容器，这时候应用容器会因为找不到数据库而退出，为了避免这种情况我们需要加入一个标签，就是 depends_on，这个标签解决了容器的依赖、启动先后的问题。
例如下面容器会先启动 redis 和 db 两个服务，最后才启动 web 服务
```dockerfile
version: '2'
services:
  web:
    build: .
    depends_on:
      - db
      - redis
  redis:
    image: redis
  db:
    image: postgres
```
#### 调度某个容器

>$ docker-compose scale wordpress=3 

选择编排文件中 wordpress容器 创建3个 wordpress 容器

#### docker-compose.yml 文件内容
>vi docker-compose.yml
```dockerfile
version:'3'

services:
    db:             # 第一个容器是数据库所以起名的名字是 db
        image: mysql:5.7  # 定义 services 使用的镜像是 mysql5.7版本的数据库
        volumes:  # 挂载一个宿主机目录或命令卷到容器，命名卷要在顶级 volumes 定义卷名称
            - db_data:/var/lib/mysql # 使用卷 db_data; db_data: 卷名 , 只是指定一个 /var/lib/mysql 路径，Docker 会自动在创建一个数据卷（这个路径是容器内部的）。
        restart:always # 容器开机自己启动
        environment:   # 环境变量
            MYSQL_ROOT_PASSWORD: somewordpress  # 定义环境变量 MYSQL_ROOT_PASSWORD
            MYSQL_DATABASE:wordpress  # 定义环境变量 MYSQL_DATABASE
            MYSQL_USER:wordpress
            MYSQL_PASSWORD:wordpress
            
    wordpress:   # 第二个容器是wordpress 所以起的名字是 wordpress
        depends_on: #选择依赖， 因为依赖数据库 所以这里选择依赖 db 容器 ，先启动db容器后在启动 wordpress容器
            -- db 
        image:wordpress:latest  # 选择最新版的 wordpress 镜像
        volumes:
            -- web_data:/var/www/html  # 使用卷 web_data
        ports: # 指定端口
            - "80" # 主机随机选择一个端口映射容器的 80 端口。如果想指定主机的某个端口映射容器的端口则 "80:80"
        restart:always
        environment:
            WORDPRESS_DB_HOST: db:3306
            WORDPRESS_DB_USER:wordpress
            WORDPRESS_DB_PASSWORD: wordpress
    volumes:
            db_data: # 创建顶级目录 db_data
            web_data: # 创建顶级目录 web_data
```



