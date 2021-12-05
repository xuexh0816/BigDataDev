
e6a0117ec169 :centos官网操作系统镜像

##容器启动
```
创建容器并启动
docker run -i -t -v /Users/xuexh/Documents/works/docker_cluster/hosts/master:/home --name master --privileged e6a0117ec169 /bin/bash
```
- -i: 以交互方式运行容器
- -t: 为容器指定一个伪终端 /bin/bash
- -v: 绑定一个卷 宿主机目录:容器目录
- --name: 容器命名
- e934aafc2206 IMAGE——ID
##容器操作命令
```
列出当前所有容器
docker ps -a 
删除容器
docker rm -f CONTAINER_ID
容器启停
docker start CONTAINER_ID/NAME
docker stop  CONTAINER_ID/NAME
docker restart CONTAINER_ID/NAME
进入已启动的容器
docker exec -it master /bin/bash
退出
exit
查看容器状态
docker stats -a
```

