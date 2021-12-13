vim my.cnf
```shell
[mysqld]
bind-address=0.0.0.0
port=3306
user=mysql
basedir=/home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64
datadir=/home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64/datadir
socket=/tmp/mysql.sock
log-error=/home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64/logdir/mysql.err
pid-file=/home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64/mysql.pid
#character config
character_set_server=utf8mb4
symbolic-links=0
explicit_defaults_for_timestamp=true
```

./bin/mysqld --defaults-file=./my.cnf --basedir=/home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64/ \
--datadir=/home/xuexh/parcels/mysql/mysql-5.7.30-linux-glibc2.12-x86_64/datadir/ --user=mysql --initialize

