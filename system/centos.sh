#!/bin/bash
#Author:show
#centos处理

#cetnos之后,yum安装没有mysql了,采用mariadb
#yum install mariadb-server mariadb
#安装完之后的操作
#mysql的my.conf可以提取出来处理一下

#检查有没mysql才进行以下操作

wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum install mysql-community-server

#mysql -u root
#set password for 'root'@'localhost'=password('root');
#grant all privileges on *.* to root@'%'identified by 'root';

#mysql初始化权限命令：
#set password for 'root'@'localhost'=password('root');
#grant all privileges on *.* to root@'%'identified by 'root';
#create user 'show'@'%' identified by 'root';
#flush privileges

#复制配置文件到相应的文件夹内
#systemctl启动文件
#/lib/systemd/system/

#zabbix
#mysql> create database zabbix character set utf8 collate utf8_bin;
#mysql> grant all privileges on zabbix.* to zabbix@localhost identified by 'password';
#mysql> quit;

#mysql 通用创建
#set password for 'root'@'localhost' =password('NEPMFUKwerQzfQE2DtbVcRtR');
#grant all privileges on *.* to root@'%'identified by 'NEPMFUKwerQzfQE2DtbVcRtR';
#create user 'zabbix'@'localhost' identified by 'NEPMFUKwerQzfQE2DtbVcRtR';
#set password for 'zabbix'@'localhost'=password('NEPMFUKwerQzfQE2DtbVcRtR');
#grant all privileges on zabbix.* to zabbix@'localhost'identified by 'NEPMFUKwerQzfQE2DtbVcRtR';

#rabbitmq的安装
#wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
#rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
#yum install -y erlang
#rpm -q erlang   #查看erlang版本


#repos 源模式安装:
# In /etc/yum.repos.d/rabbitmq-erlang.repo
#[rabbitmq-erlang]
#name=rabbitmq-erlang
#baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
#gpgcheck=1
#gpgkey=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
#repo_gpgcheck=0
#enabled=1

# 清理原有rpm包缓存
#$ yum clean all
## 重新安装20.3版本的erlang
#$ yum install -y erlang
## 查看包状态
#$ rpm -q erlang
#erlang-20.3-1.el7.centos.x86_64  # 完成！
#wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.6/rabbitmq-server-3.7.6-1.el7.noarch.rpm
#rpm --import https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
#yum install -y rabbitmq-server-3.7.6-1.el7.noarch.rpm
#rpm -q rabbitmq-server

#迁移目录
#wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.12/rabbitmq-server-generic-unix-3.6.12.tar.xz
#xz -d rabbitmq-server-generic-unix-3.6.12.tar.xz
#tar -vxf  rabbitmq-server-generic-unix-3.6.12.tar -C /opt/
#cd /opt/
#mv rabbitmq-server-3.6.12/ rabbitmq


#erl #erl命令查看版本
wget http://erlang.org/download/otp_src_20.1.tar.gz
#解压
tar -zvxf otp_src_20.1.tar.gz
#配置安装路径编译代码
cd otp_src_20.1/
./configure
make && make install

#wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.4/rabbitmq-server-3.7.4-1.el7.noarch.rpm
#yum install rabbitmq-server-3.7.4-1.el7.noarch.rpm

#启动RabbitMQ服务
#service rabbitmq-server start
#状态查看
#rabbitmqctl status
#启用插件
#rabbitmq-plugins enable rabbitmq_management
#重启服务
#service rabbitmq-server restart
#添加帐号:name 密码:passwd
#rabbitmqctl add_user show show123show
#赋予其administrator角色
#rabbitmqctl set_user_tags show administrator
#设置权限
#rabbitmqctl set_permissions -p / show ".*" ".*" ".*"

#tar zxvf rabbitmq-c-0.8.0.tar.gz
#cd  rabbitmq-c-0.8.0
#./configure
#make && make install

#php 扩展安装
#pecl install amqp
#/usr/local/librabbitmq






