# Docker


<!--more-->
## Docker介绍
Docker takes away repetitive, mundane configuration tasks and is used throughout the development lifecycle for fast, easy and portable application development - desktop and cloud. Docker’s comprehensive end to end platform includes UIs, CLIs, APIs and security that are engineered to work together across the entire application delivery lifecycle.

Docker 使用 Google 公司推出的 Go 语言 进行开发实现，基于 Linux 内核的 cgroup，namespace，以及
OverlayFS 类的 Union FS 等技术，对进程进行封装隔离，属于
操作系统层面的虚拟化技术。由于隔离的进程独立于宿主和其它的隔离的进程，因此也称其为容器.
> 命令都可以使用 --help查看帮助
>
> [Reference](https://docs.docker.com/reference/)

## Docker概念及命令

### 镜像
对于 Linux 而言，内核启动后，会挂载 root 文件系统为其提供用户空间支持。而 Docker 镜像（Image），就相当于是一个 root 文件系统。 Docker 镜像
是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。镜像 不包含 任何动态数据，其内容在构建之后也不会被改变。
分层存储

#### 镜像基本命令

###### docker pull
- 格式：docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]
- 说明：从Docker Registry拉取镜像

###### docker image ls
- 格式：docker image ls
- 说明：列出顶层镜像
- 注意：
    - docker image ls -a：列出包括中间层的所有镜像
    - docker system df：便捷查看镜像、容器、数据卷所占空间
    - docker image prune：删除虚悬镜像
    - docker image ls -q：只显示镜像ID
    - docker image ls -f ...：根据条件过滤镜像

###### docker image rm
- 格式：docker image rm [选项] <镜像1> [<镜像2> ...]
- 说明：删除本地镜像
- 例子：docker image rm $(docker image ls -q -f before=mongo:3.2)

###### ~~docker commit~~
- 格式：docker commit [选项] <容器ID或容器名> [<仓库名>[:<标签>]]
- 说明：就是在原有镜像的基础上，再叠加上容器的存储层，并构成新的镜像
- 注意：不要使用这种方式构建镜像，应该使用Dockerfile

###### docker diff
- 格式：docker diff container
- 说明：查看容器文件系统中被修改的文件和目录

###### ~~docker import~~
- 格式：docker import [选项] <文件>|<URL>|- [<仓库名>[:<标签>]]
- 说明：从rootfs压缩包导入镜像--导入一个容器快照到本地镜像库

###### ~~docker save & docker load~~
- 说明：将镜像保存为一个文件
- 注意：现在使用Docker Registry迁移镜像不使用这种方式了

### 容器
容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 命名空间。因此容器可以拥有自己的 root 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间。容器内的进程是运行在一个隔离的环境里，使用起来，就好像是在一个独立于宿主的系统下操作一样。这种特性使得容器封装的应用比直接在宿主运行更加安全。
每一个容器运行时，是以镜像为基础层，在其上创建一个当前容器的存储层，我们可以称这个为容器运行时读写而准备的存储层为 容器存储层。
容器存储层的生存周期和容器一样，容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。

#### 容器基本命令

###### docker run
- 说明：新建并启动容器
- 流程：
    >- 检查本地是否存在指定的镜像，不存在就从 registry 下载
    >- 利用镜像创建并启动一个容器
    >- 分配一个文件系统，并在只读的镜像层外面挂载一层可读写层
    >- 从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
    >- 从地址池配置一个 ip 地址给容器
    >- 执行用户指定的应用程序
    >- 执行完毕后容器被终止
- 注意：
    - -d 守护进程后台运行容器
    - -i 交互式
    - -t Allocate a pseudo-TTY

###### docker container start
- 说明：启动已经终止的容器

###### docker container stop
- 说明：终止容器

###### docker container restart
- 说明：重新启动正在运行的容器

###### docker container rm
- 说明：删除容器

###### docker container ls || docker ps
- 说明：查看正在运行的容器
- 注意：docker container ls -a 查看所有状态的容器

###### docker container logs
- 格式：docker container logs [container ID or NAMES]
- OR 格式：docker logs [container ID or NAMES]
- 说明：查看容器内日志

###### docker container prune
- 说明：清理所有处于终止状态的容器

###### docker export
- 说明：导出容器快照到本地
###### docker inspect
- 说明：查看容器信息

###### docker exec && ~~docker attach~~
- 说明：进入容器
- 注意：
    - docker arrach 不推荐使用，因为从stdin中exit，会导致容器停止
    - docker exec 的-i -t参数有用

### 仓库
Docker Registry 公开服务：https://hub.docker.com/
私有 Docker Registry：使用docker registry搭建本地私有仓库

#### 仓库有关的基本命令
###### docker login
- 说明：登录某个Docker Hub
###### docker logout
- 说明：登出已经登录的Docker Hub
###### docker search
- 说明：查询镜像
###### docker pull
- 说明：拉取镜像
###### docker push
- 说明：推送镜像
###### 自动构建
- 说明：支持自动构建镜像
###### 私有仓库
- 说明：支持使用docker-registry创建本地私有镜像仓库

### Dockerfile
Dockerfile 是一个文本文件，其内包含了一条条的 指令(Instruction)，每一条指令构建一层，因此每一条指令的内容，就是描述该层应当如何构建。

### 数据管理
保证即使容器删除，数据也不会丢失。

#### 数据卷
数据卷 是一个可供一个或多个容器使用的特殊目录，它绕过 UFS.
数据卷 是被设计用来持久化数据的，它的生命周期独立于容器，Docker 不会在容器被删除后自动删除 数据卷，并且也不存在垃圾回收这样的机制来处理没有任何容器引用的 数据卷。如果需要在删除容器的同时移除数据卷。可以在删除容器的时候使用 `docker rm -v` 这个命令。
数据卷 的使用，类似于 Linux 下对目录或文件进行 mount，镜像中的被指定为挂载点的目录中的文件会复制到数据卷中（仅数据卷为空时会复制）。

###### docker volume create
- 说明：创建一个数据卷
###### docker volume ls
- 说明：查看所有数据卷
###### docker volume inspect
- 说明：查看指定数据卷信息
###### docker volume rm
- 说明：删除数据卷
###### docker volume prune
- 说明：删除所有无主的数据卷
###### 启动一个挂在数据卷的容器
- 例子：
```
$ docker run -d -P \
    --name web \
    # -v my-vol:/usr/share/nginx/html \
    --mount source=my-vol,target=/usr/share/nginx/html \
    nginx:alpine
```

#### 挂载主机目录
创建容器的时候使用 --mount 标记可以指定挂载一个本地主机的目录到容器中去。
本地目录的路径必须是绝对路径，以前使用 -v 参数时如果本地目录不存在 Docker 会自动为你创建一个文件夹，现在使用 --mount 参数时如果本地目录不存在，Docker 会报错。
###### 挂载
- 例子：
```
$ docker run -d -P \
    --name web \
    # -v /src/webapp:/usr/share/nginx/html \
    --mount type=bind,source=/src/webapp,target=/usr/share/nginx/html \
    nginx:alpine
```

### 网络

#### 外部访问容器
容器中可以运行一些网络应用，要让外部也可以访问这些应用，可以通过`-P`或`-p`参数来指定端口映射。

当使用`-P`标记时，Docker 会随机映射一个端口到内部容器开放的网络端口。

`-p`则可以指定要映射的端口，并且，在一个指定端口上只可以绑定一个容器。支持的格式有 `ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort`。

###### docker port
- 格式：docker port CONTAINER [PRIVATE_PORT[/PROTO]]
- 说明：查看当前映射的端口的配置等
- 注意：
    - 容器有自己的内部网络和 ip 地址（使用 docker inspect 查看，Docker 还可以有一个可变的网络配置。）
    - `-p` 标记可以多次使用来绑定多个端口

###### 例子
- 映射所有接口的地址
    ```
    docker run -d -p 80:80 nginx:alpine
    ```
- 映射到指定地址的指定端口
    ```
    docker run -d -p 127.0.0.1:80:80 nginx:alpine
    ```
- 映射到指定地址的任意端口
    ```
    docker run -d -p 127.0.0.1::80 nginx:alpine
    ```
    > 可以使用`udp`标记指定`udp`端口
    ```
    docker run -d -p 127.0.0.1:80:80/udp nginx:alpine
    ```
- 绑定多个端口
    ```
    docker run -d \
        -p 80:80 \
        -p 443:443 \
        nginx:alpine
    ```

#### 容器互联
强烈建议大家将容器加入自定义的 Docker 网络来连接多个容器，而不是使用 --link 参数。

###### docker network
- 格式：docker network COMMAND
- 说明：docker网络的相关操作命令
- 例子：
    - docker network create -d bridge my-net
    - `-d` 参数指定 Docker 网络类型，有 `bridge overlay`。其中 overlay 网络类型用于 `Swarm mode`
    - docker run -it --rm --name busybox1 --network my-net busybox sh
    - docker run -it --rm --name busybox2 --network my-net busybox sh

#### 配置DNS
如何自定义配置容器的主机名和 DNS 呢？秘诀就是 Docker 利用虚拟文件来挂载容器的 3 个相关配置文件。 在容器中使用`mount`命令可以看到挂载信息

###### 配置全部容器的DNS
- 说明：在`/etc/docker/daemon.json`文件中新增以下内容设置
    ```
    {
      "dns" : [
        "114.114.114.114",
        "8.8.8.8"
      ]
    }
    ```

###### docker run
- 说明：手动指定容器配置参数
    - -h HOSTNAME 或者 --hostname=HOSTNAME 设定容器的主机名，它会被写到容器内的 /etc/hostname 和 /etc/hosts。但它在容器外部看不到，既不会在 docker container ls 中显示，也不会在其他的容器的 /etc/hosts 看到。
    - --dns=IP_ADDRESS 添加 DNS 服务器到容器的 /etc/resolv.conf 中，让容器用这个服务器来解析所有不在 /etc/hosts 中的主机名。
    - --dns-search=DOMAIN 设定容器的搜索域，当设定搜索域为 .example.com 时，在搜索一个名为 host 的主机时，DNS 不仅搜索 host，还会搜索 host.example.com。
- 注意：如果在容器启动时没有指定最后两个参数，Docker 会默认用主机上的 /etc/resolv.conf 来配置容器。

### docker-compose

#### Compose 相关链接
- [Compose 命令说明](https://yeasy.gitbook.io/docker_practice/compose/commands)
- [Compose 模板文件](https://yeasy.gitbook.io/docker_practice/compose/compose_file)
- [Compose 官方文档](https://docs.docker.com/compose/)
- [Compose file 官方文档](https://docs.docker.com/compose/compose-file/)

### Dockerfile

#### Dockerfile 相关链接
- [Dockerfile 指令详解](https://yeasy.gitbook.io/docker_practice/image/dockerfile)
- [Docker 官方镜像 Dockerfile](https://github.com/docker-library/docs)
- [Dockerfile 官方文档](https://docs.docker.com/engine/reference/builder/)
- [Dockerfile 最佳实践文档](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)


### Others

#### 更换国内源
`vim /etc/docker/daemon.json`
`
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://ustc-edu-cn.mirror.aliyuncs.com",
    "https://ghcr.io",
    "https://mirror.baidubce.com"
  ]
}
`

#### docker php 扩展安装
1. 通过pecl方式安装
2. 通过php容器中自带的特殊命令安装：
    > docker-php-source:在php容器中创建/usr/src/php目录，并在其中存放一些自带文件，php扩展源吗都在/usr/src/php/ext中
    >
    > 格式：docker-php-source extract | delete
    >
    > 说明：extract创建并初始化/usr/src/php目录，delete：删除/usr/src/php目录
    >
    > docker-php-ext-enable:启动php扩展，pecl安装php扩展默认不启动扩展，如果想要使用扩展必须在php.ini中配置。该命令则自动给我们启动php扩展不需要修改php.ini配置文件.
    >
    > `ls
    > 查看现有可以启动的扩展：/usr/local/lib/php/extensions/no-debug-non-zts-xxxxxx`
    > 查看redis扩展是否启动：php -m | grep redis
    > 启动redis扩展：docker-php-ext-enable redis
    >
    > docker-php-ext-install:安装并启动php扩展
    > 格式：docker-php-ext-install "源吗包目录名"
    > 说明："源码包"需要放在/usr/src/php/ext下
    > 卸载：直接删除/usr/local/etc/php/conf.d对应的配置文件即可
    > 
    > docker-php-ext-configure:自定义安装的php扩展。


