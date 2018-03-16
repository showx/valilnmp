FROM ubuntu:14.04

MAINTAINER showx<9448923@qq.com>

CMD echo "start linux"
RUN apt-get update
RUN apt-get install nginx

VOLUME /e/lnmp/data/nginx/conf /etc/nginx/conf
VOLUME /e/lnmp/data/www/ /data/www/
VOLUME /e/lnmp/data/log/nginx /var/log/nginx

RUN echo "/etc/init.d/nginx restart" >> /etc/bash.bashrc

EXPOSE 80