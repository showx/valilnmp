#!/bin/bash
#Author:show
#主流 redis,memcache,mongodb
#调试相关:xhprof,xdebug
#简单扩展可以使用pecl安装
#ftp,git,svn,samba,varnish等搭建
#ftp环境的搭建
function ftp()
{
    yum -y install vsftpd
    chkconfig vsftpd on
    #创建密码，pam虚拟用户
    db_load -T -t hash -f /etc/vsftpd/vuser_passwd.txt /etc/vsftpd/vuser_passwd.db
}
ftp;
function svn()
{
    yum -y install  subversion
    #使用的项目目录
    mkdir -p /application/svndata
    #指定svn的配置文件信息路径
    mkdir -p /application/svnpasswd
    #启动svn服务
    svnserve -d -r /application/svndata/

#==================================================
     #搭建之后创建项目
     svnadmin help create
     #创建test版本库
     svnadmin create /application/svndata/test

     #svn的hook功能不启用
     #hook自动上线代码的功能作用不大

     pkill svnserve
     #启动svn
     svnserve -d -r /application/svndata/
}
svn;
function git()
{
    sudo yum install git
    #gitlab代码管理
}
git;

ssh-keygen -t rsa -C "9448923@qq.com"
cd /root/.ssh/

#确保有php的环境下安装扩展,版本是7.0以上

#redis
yum install epel-release
yum install redis
redis-server /etc/redis.conf
#redis-cli测试


#memcache memcached
yum -y install memcached
vim /etc/sysconfig/memcached
systemctl enabled memcached
systemctl start memcached

#mongodb 远程下载源文件
sudo yum install -y mongodb-org

#安装docker
yum -y install docker






