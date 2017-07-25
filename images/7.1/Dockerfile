FROM php:7.1-alpine

# COPY INSTALL SCRIPTS
COPY ./php/*.sh /tmp/
RUN chmod +x /tmp/*.sh

COPY ./images/php.ini /etc/php/7.1/cli/conf.d/50-setting.ini

WORKDIR /tmp

RUN sh ./env.sh && \
    sh ./apk.sh && \
    sh ./composer.sh && \
    sh ./node.sh

WORKDIR /app
