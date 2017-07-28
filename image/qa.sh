#!/bin/bash

# Install PHP Mess Detector
curl -OL http://static.phpmd.org/php/latest/phpmd.phar
chmod +x phpmd.phar && mv phpmd.phar /usr/local/bin/phpmd

# Install PhpMetrics
curl -OL https://github.com/phpmetrics/PhpMetrics/releases/download/v2.1.0/phpmetrics.phar
chmod +x phpmetrics.phar && mv phpmetrics.phar /usr/local/bin/phpmetrics

# Install PHP Depend
curl -OL http://static.pdepend.org/php/latest/pdepend.phar
chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend

# Install PHP Copy/Paste Detector
curl -OL https://phar.phpunit.de/phpcpd.phar
chmod +x phpcpd.phar && mv phpcpd.phar /usr/local/bin/phpcpd

# Install PHP codeSniffer
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
chmod +x phpcs.phar && mv phpcs.phar /usr/local/bin/phpcs

curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
chmod +x phpcbf.phar && mv phpcbf.phar /usr/local/bin/phpcbf

# Install phpDox – The PHP Documentation Generator
curl -OL http://phpdox.de/releases/phpdox.phar
chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox

# Install PHPLOC
curl -OL https://phar.phpunit.de/phploc.phar
chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc
