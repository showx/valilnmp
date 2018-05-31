#!/usr/bin/env bash
#测试文件

a="apt-get"
tmp=`$($a -v)`
echo $tmp;
