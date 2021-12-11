## 集群规划
| HostName | IP | Servers |
| :---:  |:---: |:---:|
| master|192.168.5.80| NameNode ResourceManager JobHistory SecondNameNode Grafana Prometheus MySql KafkaManger|
| work1|192.168.5.81|DataNode NodeManager ZookeeperNode KafkaNode |
| work2|192.168.5.82|DataNode NodeManager ZookeeperNode KafkaNode |
| work3|192.168.5.83|DataNode NodeManager ZookeeperNode KafkaNode |

| HostName | Port | Servers |
| :---:  |:---: |:---:|
| master|9090|Prometheus|
| work1|2181|Zookeeper|
| work2|2181|Zookeeper|
| work3|2181|Zookeeper|
| work1|9092|Kafka|
| work2|9092|Kafka|
| work3|9092|Kafka|
## 1. 基础镜像构建
### 1.1 容器创建
```shell
docker run -itd -v /Users/xuexh/Documents/works/docker_cluster/hosts/master:/home \
--name master \
--hostname master \
--privileged centos /usr/sbin/init

docker exec -it master /bin/bash
```
### 1.2 基础工具安装
```shell
yum -y update
yum install passwd openssl openssh-server net-tools vim sudo openssh-clients* -y
```
### 1.3 账户设置
#### 1.3.1 设置root密码
```shell
passwd root
```
#### 1.3.2 创建dev用户
```shell
useradd xuexh  
passwd xuexh
```
#### 1.3.3 授权 
```shell
chmod +w /etc/sudoers
vim /etc/sudoers
```
```shell
## Allow root to run any commands anywhere 
root    ALL=(ALL)       ALL
xuexh   ALL=(ALL)       NOPASSWD:ALL
```
```shell
chmod -w /etc/sudoers
```
### 1.4 sshd服务
```shell
systemctl start sshd
systemctl status sshd
```
### 查看监听端口
```shell
netstat -ntlp
```
### 1.5 控制台颜色
```shell
vim ~/.bashrc
```
```shell
# User specific aliases and functions
alias ll='ls $LS_OPTIONS -l --color'
```
```shell
source ~/.bashrc
```
### 1.6 安装JDk
### 退出
## 1.7 保存为新镜像
```shell
docker commit -m 'jdk maven' master devbase:jdkmvn
```
## 2.构建集群子网
```
docker network create --subnet=192.168.5.0/16 netxxh
```
## 3. 创建新的容器
### 3.1 拷贝磁盘文件
```shell
cp /Users/xuexh/Documents/works/docker_cluster/hosts/master \
/Users/xuexh/Documents/works/docker_cluster/hosts/work1

cp /Users/xuexh/Documents/works/docker_cluster/hosts/master \
/Users/xuexh/Documents/works/docker_cluster/hosts/work2

cp /Users/xuexh/Documents/works/docker_cluster/hosts/master \
/Users/xuexh/Documents/works/docker_cluster/hosts/work3
```
### 3.2 创建容器
```shell
docker run -itd -v /Users/xuexh/Documents/works/docker_cluster/hosts/master:/home \
-v /etc/localtime:/etc/localtime:ro \
-p 13000:3000 \
-p 19090:9090 \
-p 10022:22 \
--name master \
--hostname master \
--add-host master:192.168.5.80 \
--add-host work1:192.168.5.81 \
--add-host work2:192.168.5.82 \
--add-host work3:192.168.5.83 \
--net netxxh \
--ip 192.168.5.80 \
--dns 114.114.114.114 \
--privileged master:0.0.2 /usr/sbin/init

docker run -itd -v /Users/xuexh/Documents/works/docker_cluster/hosts/work1:/home \
-v /etc/localtime:/etc/localtime:ro \
-p 10122:22 \
-p 19092:9092 \
--name work1 \
--hostname work1 \
--add-host master:192.168.5.80 \
--add-host work1:192.168.5.81 \
--add-host work2:192.168.5.82 \
--add-host work3:192.168.5.83 \
--net netxxh \
--ip 192.168.5.81 \
--dns 114.114.114.114 \
--privileged work1:0.0.1 /usr/sbin/init

docker run -itd -v /Users/xuexh/Documents/works/docker_cluster/hosts/work2:/home \
-v /etc/localtime:/etc/localtime:ro \
-p 10222:22 \
-p 29092:9092 \
--name work2 \
--hostname work2 \
--add-host master:192.168.5.80 \
--add-host work1:192.168.5.81 \
--add-host work2:192.168.5.82 \
--add-host work3:192.168.5.83 \
--net netxxh \
--ip 192.168.5.82 \
--dns 114.114.114.114 \
--privileged work2:0.0.1 /usr/sbin/init

docker run -itd -v /Users/xuexh/Documents/works/docker_cluster/hosts/work3:/home \
-v /etc/localtime:/etc/localtime:ro \
-p 10322:22 \
-p 39092:9092 \
--name work3 \
--hostname work3 \
--add-host master:192.168.5.80 \
--add-host work1:192.168.5.81 \
--add-host work2:192.168.5.82 \
--add-host work3:192.168.5.83 \
--net netxxh \
--ip 192.168.5.83 \
--dns 114.114.114.114 \
--privileged work3:0.0.1 /usr/sbin/init
```
### 3.3 远程链接宿主机的10022端口
```shell
ssh xuexh@localhost:10022
ssh xuexh@localhost:10122
ssh xuexh@localhost:10222
ssh xuexh@localhost:10322
```
## 4. sshd 容器间免密登陆
su xuexh
cd ~
ssh-keygen 连续回车
ssh-copy-id -i .ssh/id_rsa.pub master
ssh-copy-id -i .ssh/id_rsa.pub work1 
... 
所有容器间全部配置

截止当前 容器间ping hostname 已通
ping baidu 已通

宿主机访问容器需 打镜像 再重启容器 指定端口映射