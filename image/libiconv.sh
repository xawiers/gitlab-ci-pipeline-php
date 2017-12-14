#!/bin/bash

curl -SL http://ftp.gnu.org/pub/gnu/libiconv/libiconv-$LIBICONV_VERSION.tar.gz | tar -xz -C ~/ && \
        mv ~/libiconv-$LIBICONV_VERSION ~/libiconv && \
    	# remove origin iconv
    	rm /usr/bin/iconv && \
    	# install libiconv from source
    	~/libiconv/configure --prefix=/usr/local && \
    	make && make install
