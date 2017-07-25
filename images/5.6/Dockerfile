FROM php:5.6-fpm-alpine

# COPY INSTALL SCRIPTS
COPY ./images/*.sh /tmp/
RUN chmod +x /tmp/*.sh

COPY ./images/php.ini /etc/php/5.6/cli/conf.d/50-setting.ini

WORKDIR /tmp

RUN sh ./env.sh && \
    sh ./apk.sh && \
    sh ./composer.sh && \
    sh ./node.sh

WORKDIR /app
