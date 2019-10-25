#!/bin/bash
#docker容器
#Author:show
#docker开发环境

docker pull elasticsearch:5.5.0
docker pull kibana:5.5.0
docker pull docker.elastic.co/beats/filebeat:5.5.0
docker pull logstash:5.5.0


# 查看网络 docker network ls
#设置网络
docker network create --subnet=172.18.0.0/16 mynetwork
docker run -it -v /code:/webwww --name codedata centos:7.3.1611
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.2 -p 80:80 --name nginx nginx:me
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.3 --name php-fpm php:7.2-fpm
docker run -it -d --volumes-from codedata  --network mynetwork --ip 172.18.0.4 -p 5432:5432 --name postgres postgres:9.6.11
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.5 -p 6379:6379 --name redis redis:4-alpine
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.6 -p 8888:8888 --name ssdb ssdb:show
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.7 -v /code/mysql:/var/lib/mysql -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=root mysql:5.6
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.10 --name debian debian:9.6
docker run -it -d --volumes-from codedata --network mynetwork --ip 172.18.0.11 -p 5672:5672 -p 15672:15672  --name rabbitmq -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=admin rabbitmq:3.7.7-management

#elk
docker run -it -d -p 9200:9200 -p 9300:9300 \
--volumes-from codedata \
-v /code/elasticsearch/data:/usr/share/elasticsearch/data \
--network mynetwork --ip 172.18.0.12 \
--name elasticsearch elasticsearch:5.5.0

docker run -it -d -p 5601:5601 \
--volumes-from codedata \
-v /code/kibana:/etc/kibana \
--network mynetwork --ip 172.18.0.13 \
--name kibana kibana:5.5.0

docker run -it -d \
--volumes-from codedata \
-v /code/filebeat/filebeat.yml:/usr/share/filebeat/filebeat.yml \
--network mynetwork --ip 172.18.0.14 \
--name filebeat prima/filebeat:latest

docker run -it -d -p 5044:5044 \
--volumes-from codedata \
--network mynetwork --ip 172.18.0.15 \
-v /code/logstash/conf.d:/etc/logstash/conf.d \
-v /code/logstash/data/logs:/data/logs \
--name logstash logstash:5.5.0 \
-f /etc/logstash/conf.d/logstash.conf


#docker stop 容器
#docker start 容器
#docker stats 统计相关容器

#查看内置ip
#docker inspect 容器名 |grep IP

#查看容器
#docker ps -qa

#删除容器
#docker rm 容器名

#提交现有容器
#docker commit container [repository:tag]

#偶尔用到的命令
# apt-get install make
# apt-get install procps
# apt-get install vim
# apt-get install iputils-ping
# apt-get install lsof
# apt-get install  net-tools   安装ifconfig
# ​apt-get install  telnet


#注：尽量不用--link来链接容器，官方新版本可能去掉