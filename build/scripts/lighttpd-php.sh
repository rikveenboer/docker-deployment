#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env PHP_CONFIG /host/etc/php.ini
export_env PHP_FCGI_CONFIG /etc/lighttpd/conf-enabled/15-fastcgi-php.conf
export_env PHP_FCGI_PORT 5555
export_env PHP_FCGI_CHILDREN 16
export_env PHP_FCGI_MAX_REQUESTS 2000

## Configuration
ln -s /etc/lighttpd/conf-available/10-fastcgi.conf /etc/lighttpd/conf-enabled/
cp /etc/lighttpd/conf-available/15-fastcgi-php.conf /etc/lighttpd/conf-enabled/
sed -i "s,\(\"PHP_FCGI_CHILDREN\"\s*=>\s*\"\).*$,\1$PHP_FCGI_CHILDREN\"\,," $PHP_FCGI_CONFIG
sed -i "s,\(\"PHP_FCGI_MAX_REQUESTS\"\s*=>\s*\"\).*$,\1$PHP_FCGI_MAX_REQUESTS\"\,," $PHP_FCGI_CONFIG
sed -i "s,\(\"socket\"\),\"host\" => \"127.0.0.1\"\,\n\t\t\"port\" => $PHP_FCGI_PORT\,\n\t\t#\1," $PHP_FCGI_CONFIG
