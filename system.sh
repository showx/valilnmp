#!/bin/bash
#Author:show
#ubuntu和centos处理不一样
#yum,apt-get

#如果没www-data账号，先添加
groupadd www-data
useradd -g www-data www-data

system="3";
system1=`lsb_release -a |grep Ubuntu`
system2=`lsb_release -a |grep Centos`
#echo $system1;
if [[ -n "$system1" ]]
then
    echo "Ubuntu";
    system="1";
else
    if [[ -n "$system2" ]]
    then
        echo "Centos";
        system="2";
     fi
fi

echo "$system";