FROM php:5.6-fpm-alpine

# COPY INSTALL SCRIPTS
COPY ./php/*.sh /tmp/
RUN chmod +x /tmp/*.sh

WORKDIR /tmp

RUN sh ./env.sh && \
    sh ./apk.sh && \
    sh ./composer.sh && \
    sh ./node.sh

WORKDIR /root
