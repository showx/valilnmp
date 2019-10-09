#!/bin/bash
#Author:show

#php扩展相关

#安装 yar扩展
#注：出现curl故障，切换更新源，更新curl-dev库
pecl install yar

#php redis
pecl install redis

#php yconf
pecl install yconf

#安装php swoole扩展
#注：http2和hiredis要安装有
curl -o ./tmp/swoole.tar.gz https://github.com/swoole/swoole-src/archive/master.tar.gz -L && \
tar zxvf ./tmp/swoole.tar.gz && \
mv swoole-src* swoole-src && \
cd swoole-src && \
phpize && \
./configure \
--enable-coroutine \
--enable-openssl  \
--enable-http2  \
--enable-async-redis \
--enable-sockets \
--enable-mysqlnd && \
make clean && make && sudo make install