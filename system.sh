#!/bin/bash
#Author:show
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

system="3";
command="";
system1=`lsb_release -a |grep Ubuntu`
system2=`lsb_release -a |grep Centos`
#echo $system1;
if [[ -n "$system1" ]]
then
    echo "Ubuntu";
    system="1";
    command="apt-get"
else
    if [[ -n "$system2" ]]
    then
        echo "Centos";
        system="2";
        command="yum"
     fi
fi

echo "$system";

if [[ "$system" -ge "3" ]]
then
    echo "centos"
    ./centos.sh
else
    echo "ubuntu"
    #./ubuntu.sh
fi