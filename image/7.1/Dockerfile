FROM php:7.1-alpine

# COPY INSTALL SCRIPTS
COPY ./image/*.sh /tmp/
RUN chmod +x /tmp/*.sh

COPY ./images/php.ini /usr/local/etc/php/

WORKDIR /tmp

RUN sh ./env.sh && \
    sh ./apk.sh && \
    sh ./composer.sh && \
    sh ./qa.sh && \
    sh ./node.sh

WORKDIR /root
