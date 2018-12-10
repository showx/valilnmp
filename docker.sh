#!/bin/bash
#docker容器
#Author:show
#docker开发环境

#todo 相关pull后面更新上

docker network create --subnet=172.18.0.0/16 mynetwork
docker run -it -v /code:/webwww --name codedata centos:7.3.1611
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.2 -p 80:80 --name nginx nginx:me
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.3 --name php-fpm php:7.2-fpm
docker run -it -d --volumes-from codedata  --network mynetwork --ip 172.18.0.4 -p 5432:5432 --name postgres postgres:9.6.11
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.5 -p 6379:6379 --name redis redis:4-alpine
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.6 -p 8888:8888 --name ssdb ssdb:show
#docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.10 --name debian debian:9.6
docker run -it -d --volumes-from codedata -v /code/mysql:/var/lib/mysql -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=root mysql:5.6


#docker stop 容器
#docker start 容器

