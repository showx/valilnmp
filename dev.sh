#!/bin/bash
#Author:show
#主流 redis,memcache,mongodb
#简单扩展可以使用pecl安装
#ftp,git,svn,samba等搭建
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

}
svn;
function git()
{

}
git;




