#!/bin/bash
#centos的处理

#======安装相关依赖库=================
yum install gcc gcc-c++ openssl openssl-devel cyrus-sasl-md5
yum install gcc gcc-c++ libxml2 libxml2-devel autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel  zlib zlib-devel glibc glibc-devel glib2 glib2-devel
yum install bzip bzip2

nginx
#安装之后调试配置
nginx -t

wget http://cn2.php.net/distributions/php-7.2.2.tar.bz2

#cetnos之后,yum安装没有mysql了,采用mariadb
yum install mariadb-server mariadb
#安装完之后的操作


#mysql -u root
#set password for 'root'@'localhost'=password('showisme');
#grant all privileges on *.* to root@'%'identified by 'showisme';

