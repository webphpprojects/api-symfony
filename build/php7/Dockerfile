FROM php:7.1-fpm

EXPOSE 9000

MAINTAINER Grzegorz RzeĹşnikiewicz maniakphp@gmail.com

ARG USERID=1000

RUN usermod -u $USERID www-data && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod 755 -R /var/www/html

RUN apt-get -qq update --fix-missing && \
    apt-get -q install -y \
        zlib1g-dev \
        libicu-dev \
        g++ \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        libxslt1-dev \
        libc-client-dev \
        libkrb5-dev \
        cloc \
        git-core \
        default-jdk \
        ant \
        && rm -rf /var/lib/apt/lists/*

RUN docker-php-source extract

RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install zip iconv intl mysqli gd mbstring exif fileinfo pdo_mysql xsl opcache imap

RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini

RUN curl -sS -o /tmp/icu.tar.gz -L http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.tgz && tar -zxf /tmp/icu.tar.gz -C /tmp && cd /tmp/icu/source && ./configure --prefix=/usr/local && make && make install

RUN docker-php-ext-configure intl --with-icu-dir=/usr/local && \
    docker-php-ext-install intl

RUN docker-php-source delete

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY php.ini /usr/local/etc/php/