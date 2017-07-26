FROM php:5.6-fpm-alpine

# COPY INSTALL SCRIPTS
COPY ./image/*.sh /tmp/
RUN chmod +x /tmp/*.sh

COPY ./image/php.ini /usr/local/etc/php/

WORKDIR /tmp

RUN sh ./env.sh && \
    sh ./apk.sh && \
    sh ./composer.sh && \
    sh ./qa.sh && \
    sh ./node.sh

WORKDIR /root
