#!/bin/bash

setenforce 0
iptables -F
iptables -X

service nginx stop
service nginx start

service mariadb stop
service mariadb start

killall -9 php-fpm
/usr/local/php5/sbin/php-fpm


killall -9 redis-server
/usr/local/bin/redis-server /usr/local/etc/redis.conf

cd im_server/im-server-*
./restart.sh all

