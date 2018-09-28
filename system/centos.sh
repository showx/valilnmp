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