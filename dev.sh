#!/bin/bash
#Author:show
#ftp,git,svn等搭建
#ftp环境的搭建
function ftp()
{
    yum -y install vsftpd
    chkconfig vsftpd on
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




