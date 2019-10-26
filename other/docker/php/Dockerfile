FROM php:7.1.4
MAINTAINER showx<9448923@qq.com>
# CMD echo "start php"

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

WORKDIR /data/www/

CMD ["php-fpm"]

EXPOSE 9000
