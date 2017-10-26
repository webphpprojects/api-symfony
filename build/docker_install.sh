#!/bin/bash

# We need to install dependencies only for Docker
[[ ! -e /.dockerenv ]] && exit 0

set -xe

# Install git (the php image doesn't have it) which is required by composer
apt-get update -yqq
apt-get install git -yqq

# Install phpunit, the tool that we will use for testing
curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar
chmod +x /usr/local/bin/phpunit

# Install mysql driver
# Here you can install any other extension that you need
docker-php-source extract

docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install zip iconv mysqli gd mbstring exif fileinfo pdo_mysql xsl opcache imap

pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini

curl -sS -o /tmp/icu.tar.gz -L http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.tgz && tar -zxf /tmp/icu.tar.gz -C /tmp && cd /tmp/icu/source && ./configure --prefix=/usr/local && make && make install

docker-php-ext-configure intl --with-icu-dir=/usr/local && \
    docker-php-ext-install intl

docker-php-source delete

curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer