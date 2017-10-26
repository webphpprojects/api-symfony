FROM webdevops/apache:latest

MAINTAINER Grzegorz RzeĹşnikiewicz maniakphp@gmail.com

WORKDIR /var/www/html/

RUN mkdir /var/log/apache
RUN chmod -R 755 /var/log/apache

ADD ./vhost.conf /opt/docker/etc/httpd/vhost.conf