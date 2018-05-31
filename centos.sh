#!/bin/bash
#Author:show
#centos处理

#cetnos之后,yum安装没有mysql了,采用mariadb
#yum install mariadb-server mariadb
#安装完之后的操作

#mysql的my.conf可以提取出来处理一下

wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum install mysql-community-server

#mysql初始化权限命令：
#set password for 'root'@'localhost' =password('root');
#grant all privileges on *.* to root@'%'identified by 'root';
#create user 'show'@'%' identified by 'root';
#flush privileges


#复制配置文件到相应的文件夹内


#systemctl启动文件
#/lib/systemd/system/