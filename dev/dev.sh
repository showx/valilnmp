#!/bin/bash
#Author:show
#主流 redis,memcache,mongodb
#调试相关:xhprof,xdebug
#简单扩展可以使用pecl安装
#ftp,git,svn,samba,varnish等搭建
#ftp环境的搭建
#composer的安装
#图片 imagemagick
function ftp()
{
    yum -y install vsftpd
    chkconfig vsftpd on
    #创建密码，pam虚拟用户
    yum  -y install libdb-utils  libdb-devel.x86_64
    #vuser_passwd.txt ftproot NEPMFUKwerQzfQE2DtbVcRtR
    db_load -T -t hash -f /etc/vsftpd/vuser_passwd.txt /etc/vsftpd/vuser_passwd.db
    chmod  700   /etc/vsftpd/vuser_passwd.db
    #/etc/pam.d/vsftpd
    #配置PAM认证文件，/etc/pam.d/vsftpd加入： sed替换
    #auth required pam_userdb.so db=/etc/vsftpd/vuser_passwd
    #account required pam_userdb.so db=/etc/vsftpd/vuser_passwd
    systemctl restart vsftpd
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
    wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.16.3.tar.gz
    ./configure
    make prefix=/usr/local all
    # Install into /usr/local/bin
    sudo make prefix=/usr/local install
    #gitlab代码管理
    #不使用一键安装包来安装gitlab
}
git;

#与服务器联通的key
ssh-keygen -t rsa -C "9448923@qq.com"
cd /root/.ssh/

#确保有php的环境下安装扩展,版本是7.0以上
yum install vim



#redis  使用epel-release的方法
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

#安装valgrind
yum install valgrind

#openresty(nginx+lua)

#增加zabbix监控

rpm -i http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm

#服务端
yum install zabbix-server-mysql zabbix-web-mysql

#客户端
yum install zabbix-agent

#mysql zabbix user
#create database zabbix character set utf8 collate utf8_bin;
#grant all privileges on zabbix.* to zabbix@localhost identified by 'password';


zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix

#启动
#systemctl start zabbix-server
systemctl restart zabbix-server zabbix-agent
# systemctl enable zabbix-server zabbix-agent

#conf文件  /etc/zabbix/zabbix_server.conf
#          /etc/zabbix/zabbix_agentd.conf

#安装java环境 jdk
#rpm -ivh jdk-8u171-linux-x64.rpm

#进程监控
yum install supervisor
supervisorctl status
supervisorctl stop all
supervisorctl start all

#confd安装
wget https://github.com/kelseyhightower/confd/releases/download/v0.15.0/confd-0.15.0-linux-amd64
mv confd-0.15.0-linux-amd64 /usr/sbin/confd
chmod +x /usr/sbin/confd

#etcd的安装
yum install etcd -y

#默认要安装好composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
