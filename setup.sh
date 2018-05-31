#!/bin/bash
#Author:show
#自动搭建php开发环境shell
#ubuntu和centos处理不一样
#yum,apt-get

#如果没www-data账号，先添加, 但要有超管权限
echo '============是否进行搭建开发环境============';
read -p "input (y/n): " setup
if [ $setup != 'y' ]; then
	echo '已退出安装';
	exit
fi
if [ $UID != 0 ]; then
	echo '用户id为:'$UID'非root，可能有问题';
fi
#useradd -d /webwww -g www-data -s /bin/sh www-data
user=www-data
group=www-data
egrep "^$group" /etc/group >& /dev/null
if [ $? -ne 0 ]
then
    groupadd $group
    useradd -g $user $group
fi

echo '===========开始搭建=========='
echo '=========创建所需目录========='
if [ ! -d "/webwww/" ];then
    mkdir /webwww
fi
if [ ! -d "/webwww/log/nginx/" ];then
    mkdir -p /webwww/log/nginx/
    mkdir /webwww/run/
	mkdir /webwww/lock/
	mkdir -p /webwww/tmp/nginx/client_body/
	chmod -R 777 /webwww
fi
#默认为centos
system="2";
sys_command="";
#前提要有lsb_release
system1=`lsb_release -a |grep Ubuntu`
system2=`lsb_release -a |grep Cent`
#echo $system1;
if [[ -n "$system1" ]]
then
    echo "Ubuntu";
    system="1";
    sys_command="apt-get"
else
    if [[ -n "$system2" ]]
    then
        echo "Centos";
        system="2";
        sys_command="yum"
     fi
fi

echo "$system";


#处理每个系统不同的模块
if [[ "$system" -ge "3" ]]
then
    ./centos.sh
    echo 'c';
else
    ./ubuntu.sh
    echo 'u';
fi

#mysql -u root
#set password for 'root'@'localhost'=password('root');
#grant all privileges on *.* to root@'%'identified by 'root';


echo $sys_command;
#echo $($sys_command -v);

#======安装相关依赖库=================
echo "正在安装支持库"
echo $($sys_command install build-essential);
echo $($sys_command install libpcre3 libpcre3-dev zlib1g-dev);

echo $($sys_command install  -y gcc gcc-c++ openssl openssl-devel cyrus-sasl-md5)
echo $($sys_command install -y gcc gcc-c++ libxml2 libxml2-devel autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel  zlib zlib-devel glibc glibc-devel glib2 glib2-devel)
echo $($sys_command install -y bzip bzip2)
echo $($sys_command install -y wget)
echo $($sys_command install -y libcurl-devel.x86_64)

#libiconv等包最好自行编译安装
#http://www.gnu.org/software/libiconv/ https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz /usr/local/lib
#tar zxvf libiconv-1.15.tar.gz
#cd libiconv-1.15
#./configure
#make && make install
#libevent
#http://libevent.org/ https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
#http://www.gnu.org/software/libtool/

echo '===========安装nginx========'
#配置nginx
function nginx()
{



	#下载nginx
	wget http://nginx.org/download/nginx-1.10.3.tar.gz
	tar zxvf nginx-1.10.3.tar.gz
	mv nginx-1.10.3 nginx
	cd nginx
	./configure --prefix=/usr --sbin-path=/usr/sbin \
	--conf-path=/webwww/nginx/nginx.conf --pid-path=/webwww/run/nginx.pid --lock-path=/webwww/lock/nginx.lock \
	--error-log-path=/webwww/log/nginx/main_error.log  \
	--http-client-body-temp-path=/webwww/tmp/nginx/client_body/ --http-proxy-temp-path=/webwww/tmp/nginx/proxy/ --http-fastcgi-temp-path=/webwww/tmp/nginx/fcgi/ \
	--with-http_stub_status_module
	make
	make install
	cd ../

	#nginx
    #安装之后调试配置
    #nginx -t
    #nginx -V
}
#判断有没nginx先才安装
#nginx;

#自动下载配置文件并替换
echo '==========安装php7========='
#todo增加常用版本的安装
function php7()
{
    wget http://cn2.php.net/distributions/php-7.2.2.tar.bz2
	#wget http://cn2.php.net/distributions/php-7.1.1.tar.bz2
	#tar jxvf php-7.1.1.tar.bz2
	mv php-7.1.1 php7
	cd php7
	#配置php
	#  ac_default_prefix=/usr/local --prefix=/webwww/php/local 放php的路径
	#--with-mysql=mysqlnd 一般要干掉的了
	./configure --prefix=/webwww/php/72/ --with-config-file-path=/webwww/php/ --with-config-file-scan-dir=/webwww/php \
	--sysconfdir=/webwww/php --enable-fpm \
	--with-fpm-user=www-data --with-fpm-group=www-data \
	--enable-mbstring --enable-sockets --enable-pcntl --with-curl \
	--enable-pdo --enable-mysqlnd --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
	--enable-sysvshm --enable-shmop  \
	--with-jpeg-dir=/usr --with-freetype-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-iconv=/usr/local/lib \
	--with-gd --with-openssl --enable-opcache=no --enable-zip --enable-bcmath --enable-ftp
	make
	make install
	#从指定服务器下载指定php配置文件
}
#要兼容旧程序的办法
#https://git.php.net/repository/pecl/database/mysql.git
#php7;
