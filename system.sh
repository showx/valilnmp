#!/bin/bash
#Author:show
#ubuntu和centos处理不一样
#yum,apt-get

#如果没www-data账号，先添加
groupadd www-data
useradd -g www-data www-data