#!/usr/bin/env bash
#nginx服务管理

NGINX=/usr/sbin/nginx
PID_FILE=/webwww/run/nginx.pid
PID=`cat $PID_FILE`
echo "当前nginx pid:".$PID
start()
{
	if [ -n $PID ]
	then
		echo "nginx in!"
	else
		$NGINX
		echo "nginx start!"
	fi
}
stop()
{
	if [ -n $PID ]
	then
#		killall -s QUIT nginx
		kill -INT $PID
		echo "nginx stop!"
	else
		echo "nginx no start!"
	fi
}
restart()
{
	if [ -n $PID ]
	then
		kill -HUP $PID
		sleep 2
	fi
	start
}

case $1 in
"start") start
	;;
"stop") stop
	;;
"restart") restart
	;;
*) echo "praram [start|stop|restart]"
	;;
esac
