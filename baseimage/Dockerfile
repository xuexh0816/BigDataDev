#centos8.4.2105-linux/amd64
FROM centos@sha256:a1801b843b1bfaf77c501e7a6d3f709401a1e0c83863037fa3aab063a7fdb9dc
MAINTAINER xuexh:1219858967@qq.com
USER root
RUN yum install passwd openssl openssh-server net-tools vim sudo openssh-clients* -y \
    && useradd xuexh \
    && useradd mysql \
    && sed -i '101 i xuexh   ALL=(ALL)       NOPASSWD:ALL' /etc/sudoers
COPY --chown=xuexh:xuexh ./home/ /home/

USER xuexh
#jdk
RUN tar -zxvf /home/xuexh/parcels/jdk/jdk-8u311-linux-x64.tar.gz -C /home/xuexh/parcels/jdk/ \
    && rm -rf /home/xuexh/parcels/jdk/jdk-8u311-linux-x64.tar.gz
#mysql
RUN tar -zxvf /home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64.tar.gz -C /home/xuexh/parcels/mysql/ \
    && rm -rf  /home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64.tar.gz \
    && ln -s /home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64 /home/xuexh/parcels/mysql/mysql \
    && mkdir $MYSQL_HOME/logdir \
    && sudo yum install -y ncurses-devel libaio-devel cmake glibc autoconf gcc-c++ numactl \
    && sudo mv /home/xuexh/parcels/mysql/my.cnf /home/xuexh/parcels/mysql/mysql/my.cnf \
    &&
    && sudo cp /home/xuexh/parcels/mysql/mysql/support-files/mysql.server /etc/init.d/mysqld
    && mysqld --defaults-file=/etc/my.cnf --user=mysql --basedir=$MYSQL_HOME --datadir=$MYSQL_HOME/datadir --initialize --console

flush privileges;
ALTER user 'root'@'localhost' IDENTIFIED BY '123456';