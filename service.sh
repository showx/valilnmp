#!/usr/bin/env bash
#lnmp启动和结束

systemctl nginx restart
systemctl mysql restart
systemctl php-fpm restart