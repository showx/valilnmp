#!/usr/bin/env bash
#php服务管理

prefix=/usr/local
exec_prefix=${prefix}

php_fpm_BIN=${exec_prefix}/sbin/php-fpm
php_fpm_PID_PATH=/webwww/php/var/run/php-fpm.pid
if [ -f $php_fpm_PID_PATH ];then
    php_fpm_PID=`cat $php_fpm_PID_PATH`
    echo "php-fpm pid:$php_fpm_PID";
fi
function start()
{
    $php_fpm_BIN
    if [ $? -ne 0 ];then
        echo "php-fpm fail!"
    else
        echo "php-fpm start!"
    fi
}

function stop()
{
    if [ -n "$php_fpm_PID" ];then
        kill -INT $php_fpm_PID
        echo "php-fpm stop!"
    fi
}

function reload()
{
    if [ -n "$php_fpm_PID" ];then
        kill -USR2 $php_fpm_PID
        echo "php-fpm reload"
    fi
}

case "$1" in
    "start")
        start
        ;;
    "stop")
        stop
        ;;
    "restart")
        stop
        sleep 2
        start
        ;;
    "reload")
        reload
        ;;
    *)
        echo "$0 start|stop|restart|reload"
        ;;
esac