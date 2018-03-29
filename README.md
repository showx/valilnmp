# valilnmp简介
##关于命名
valilnmp拆分就是vali和lnmp
vali只是一种代号
lnmp=众所周知的 linux nginx mysql php

##说明
一键搭建lnmp开发环境
ubuntu与centos操作系统为主
轻量解决搭建环境的问题，让程序人员更舒心写代码。
一键切换php版本功能
#todo 虽然很不想增加apache,但某些项目怎么一直用它呢？

#使用方法
运行setup即可安装
./setup.sh

#整体架构
###文件目录
.
├── conf_file    服务相关配置文件
├── extends      
│   ├── php_ext  php扩展
│   ├── servergather   常用服务器监控
├── files  服务安装文件
└── other  vagrant和docker等第三方使用

###使用目录 
/webwww/   为核心开发目录
/webwww/log/  服务的日志文件夹

#调试开发
结合xhprof作用php基层调试