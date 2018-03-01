#!/bin/bash
#Author:show
#自动搭建php开发环境shell
echo '是否进行安装(y/n)';
read -p "(y/n): " setup
if [ $setup != 'y' ]; then
	echo '已退出安装';
	exit
fi
if [ $UID != 0 ]; then
	echo '用户id为:'$UID'非root，可能有问题';
fi
echo '===========开始搭建=========='
echo '=========创建所需目录========='
#系统版本
#SYSCON = "head -n 1 /etc/issue";
#echo $SYSCON
#echo $?
function dirmake()
{
	mkdir /webwww
	mkdir -p /webwww/log/nginx/
	mkdir /webwww/run/
	mkdir /webwww/lock/
	mkdir -p /webwww/tmp/nginx/client_body/
	chmod -R 777 /webwww
}
#检测系统好处，mac下也能兼用 别名？
#dirmake;
apt-get install build-essential
useradd -d /webwww -g www-data -s /bin/sh www-data
#安装mysql
echo '===========安装mysql========'
apt-get install mysql-server mysql-client
#nginx配置所需库
apt-get install libpcre3 libpcre3-dev zlib1g-dev
echo '===========安装nginx========'
#配置nginx
function nginx()
{
	#下载nginx
	wget http://nginx.org/download/nginx-1.10.3.tar.gz
	tar zxvf nginx-1.10.3.tar.gz
	mv nginx-1.10.3 nginx
	cd nginx
	./configure --prefix=/usr --sbin-path=/usr/sbin --conf-path=/webwww/nginx/nginx.conf --pid-path=/webwww/run/nginx.pid --lock-path=/webwww/lock/nginx.lock --error-log-path=/webwww/log/nginx/main_error.log  --http-client-body-temp-path=/webwww/tmp/nginx/client_body/ --http-proxy-temp-path=/webwww/tmp/nginx/proxy/ --http-fastcgi-temp-path=/webwww/tmp/nginx/fcgi/ --with-http_stub_status_module
	make
	make install
	cd ../
}
nginx;
#ls
#自动下载配置文件并替换
echo '==========安装php7========='
function php7()
{
	wget http://cn2.php.net/distributions/php-7.1.1.tar.bz2
	#tar jxvf php-7.1.1.tar.bz2
	mv php-7.1.1 php7
	cd php7
	#配置php
	./configure --with-config-file-scan-dir=/webwww/php --prefix=/etc/php --sysconfdir=/webwww/php --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --enable-mbstring --enable-sockets --enable-pcntl --enable-pdo --enable-mysqlnd --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --enable-sysvshm --enable-shmop  --with-jpeg-dir=/usr --with-freetype-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-iconv=/usr/lib --with-gd --with-openssl --enable-opcache=no --enable-zip --enable-bcmath --enable-pcntl --enable-ftp --with-curl
	make
	make install
	#从指定服务器下载指定php配置文件
}
php7;






