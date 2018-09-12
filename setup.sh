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
    mkdir /show
    mkdir /show/node_module
fi
if [ ! -d "/webwww/log/nginx/" ];then
    mkdir -p /webwww/log/nginx/
    mkdir /webwww/run/
	mkdir /webwww/lock/
	mkdir -p /webwww/tmp/nginx/client_body/
	mkdir -p /webwww/php/conf
	chmod -R 777 /webwww
fi
#默认为centos
system="2";
sys_command="";

#增加判断 后面改为which apt-get
apt-get install -y lsb-release
yum install -y redhat-lsb redhat-lsb.x86_64

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
    system/centos.sh
    echo 'c';
else
    system/ubuntu.sh
    echo 'u';
fi



echo $sys_command;
#echo $($sys_command -v);

#======安装相关依赖库=================
echo "正在安装支持库"
echo $($sys_command install build-essential);
echo $($sys_command install libpcre3 libpcre3-dev zlib1g-dev);

echo $($sys_command install -y cmake gcc gcc-c++ cyrus-sasl-md5)
echo $($sys_command install -y libxml2 libxml2-devel \
autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel \
 zlib zlib-devel glibc glibc-devel glib2 glib2-devel )
echo $($sys_command install -y bzip bzip2 ncurses ncurses-devel monit.x86_64 git unzip rsync nc)
echo $($sys_command install -y wget curl curl-devel openssl openssl-devel libevent libevent-devel)
echo $($sys_command install -y lrzsz ntpdate libmcrypt libmcrypt-devel mcrypt mhash)
echo $($sys_command install -y libcurl-devel.x86_64  postgresql-devel)


#libevent
#http://libevent.org/ https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
#http://www.gnu.org/software/libtool/

echo '===========安装nginx========'
#配置nginx
function nginx()
{

    #增加nginx module文件夹
    #lua开发模块，解压，放在/show/nginx_module
    if [ ! -d /show/nginx_module/lua-nginx-module-0.10.13 ];then
        wget https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz
        tar zxvf v0.10.13.tar.gz -C /show/nginx_module/
    fi
    if [ ! -d /show/nginx_module/ngx_devel_kit-0.3.0 ];then
        wget https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz
        tar zxvf v0.3.0.tar.gz -C /show/nginx_module/
    fi

	#下载nginx
	#wget http://nginx.org/download/nginx-1.10.3.tar.gz
	wget http://nginx.org/download/nginx-1.13.12.tar.gz
	tar zxvf nginx-1.13.12.tar.gz
	mv nginx-1.13.12 nginx
	cd nginx
	./configure --prefix=/usr --sbin-path=/usr/sbin \
	--user=www-data --group=www-data \
	--conf-path=/webwww/nginx/nginx.conf \
	--pid-path=/webwww/run/nginx.pid --lock-path=/webwww/lock/nginx.lock \
	--error-log-path=/webwww/log/nginx/main_error.log  \
	--http-log-path=/webwww/log/nginx/main_access.log  \
	--http-client-body-temp-path=/webwww/tmp/nginx/client_body/ --http-proxy-temp-path=/webwww/tmp/nginx/proxy/ --http-fastcgi-temp-path=/webwww/tmp/nginx/fcgi/ \
	--with-pcre-jit \
	--with-ld-opt="-Wl,-rpath,/usr/local/lib" \
	--with-http_stub_status_module \
    --with-http_realip_module \
    --with-http_ssl_module \
    --add-module=/show/nginx_module/lua-nginx-module-0.10.13 \
    --add-module=/show/nginx_module/ngx_devel_kit-0.3.0

    #	--with-pcre=$pcre_dir \

	make
	make install
	cd ../

	#nginx
    #安装之后调试配置
    #nginx -t
    #nginx -V
}
#判断有没nginx先才安装
echo '是否安装nginx';
read -p "input (y/n): " nginx_y
if [ $nginx_y == 'y' ]; then
	nginx
	echo '成功安装完nginx';
fi

#自动下载配置文件并替换
echo '==========安装php7========='
#todo增加常用版本的安装
php_version='7.2.6';
function php7()
{

    #libiconv等包最好自行编译安装
    #http://www.gnu.org/software/libiconv/      /usr/local/lib
    wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
    tar zxvf libiconv-1.15.tar.gz
    cd libiconv-1.15
    ./configure
    cd ../
    make && make install

    #从指定服务器下载指定php配置文件
    #wget http://cn2.php.net/distributions/php-7.2.2.tar.bz2
	#tar jxvf php-7.2.2.tar.bz2
	wget http://cn2.php.net/distributions/php-$php_version.tar.gz
    tar zxvf php-$php_version.tar.gz
	mv php-$php_version php7
	cd php7
	#要兼容旧程序的办法
    #https://git.php.net/repository/pecl/database/mysql.git
	#配置php
	# --ac_default_prefix=/usr/local --prefix=/webwww/php/local 放php的路径
	# --sysconfdir=/webwww/php sysconfdir不用
	./configure --prefix=/webwww/php/726/ \
	--with-config-file-path=/webwww/php/conf/ \
	--with-config-file-scan-dir=/webwww/php/conf.d/ \
	--enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data \
	--enable-mbstring --enable-sockets --enable-pcntl --with-curl \
	--enable-pdo --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pgsql --with-pdo-pgsql \
	--enable-sysvshm --enable-shmop --with-gettext  \
	--with-jpeg-dir=/usr --with-freetype-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-iconv=/usr/local/lib \
	--with-gd --with-openssl --enable-opcache=no --enable-zip --enable-bcmath --enable-ftp
	make
	make install
    cd ../
}
echo '是否安装php7';
read -p "input (y/n): " php7_y
if [ $php7_y == 'y' ]; then
	php7
	echo '成功安装完php7';
fi

if [[ $nginx_y ]] && [[ $php7_y ]];
then
    echo '生成配置文件';
    cp -rf ./conf_file/nginxconf/ /webwww/nginx/
    cp -rf ./conf_file/phpconf/php.ini  /webwww/php/$php_version/conf/php.ini
    cp -rf ./conf_file/phpconf/php-cli.ini  /webwww/$php_version/php/conf/php-cli.ini
    cp -rf ./conf_file/phpconf/php-fpm.ini  /webwww/$php_version/php/etc/php-fpm.ini
fi