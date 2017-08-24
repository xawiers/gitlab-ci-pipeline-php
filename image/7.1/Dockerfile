FROM php:7.1-alpine

# COPY INSTALL SCRIPTS
COPY ./image/*.sh /tmp/
RUN chmod +x /tmp/*.sh

COPY ./image/php.ini /usr/local/etc/php/

WORKDIR /tmp

RUN sh ./env.sh && \
    sh ./apk.sh && \
    sh ./composer.sh && \
    sh ./qa.sh

WORKDIR /root

RUN echo '/usr/local/bin/php -dzend_extension=xdebug.so -dxdebug.remote_enable=1 $*' >> /usr/local/bin/php-xdebug && chmod +x /usr/local/bin/php-xdebug
