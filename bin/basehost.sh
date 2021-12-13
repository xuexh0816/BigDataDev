#!/bin/bash
docker run -itd \
--platform linux/amd64 \
-p 13000:3000 \
-p 19090:9090 \
-p 10022:22 \
--name base \
--hostname base \
--net netxxh \
--ip 192.168.5.70 \
--dns 114.114.114.114 \
--privileged base:0.0.1 /usr/sbin/init