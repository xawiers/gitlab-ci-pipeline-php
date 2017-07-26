#!/bin/bash

echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories

apk update && apk upgrade

set -xe \
	&& apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		icu-dev \
		zlib-dev \
		git \
		icu-libs \
 		zlib \
 		wget \
		ca-certificates \
		curl \
		nodejs@${NODE_VERSION} \
		yarn@${YARN_VERSION} \
		apache-ant \
	&& docker-php-ext-install \
		intl \
		zip \
		pdo_mysql \
	&& curl -L https://npmjs.org/install.sh | sh
