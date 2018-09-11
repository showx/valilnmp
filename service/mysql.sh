#!/usr/bin/env bash
#mysql服务管理

password=`cat /webwww/mysql/mysql_root`
start(){
    a=` ss -antlp |grep 3306|awk -F "[ :]+" '{print $5}'`
    if [[ $a -eq 3306 ]]
    then
        echo "Mysql is running!"
    else
        echo "Mysql is starting!"
        mysqld_safe
    fi
}

stop(){
    a=` ss -antlp |grep 3306|awk -F "[ :]+" '{print $5}'`
    if [[ $a -eq 3306 ]]
    then
        echo "Stoping mysql!"
        mysqladmin -u root -p$password SHUTDOWN
                ##Mysql的关闭脚本
    else
        echo "Mysql is stoped!"
    fi
}

restart(){
    stop
    sleep 2
    start
}

case $1 in
start)
    start
;;
stop)
    stop
;;
restart)
    restart
;;
esac