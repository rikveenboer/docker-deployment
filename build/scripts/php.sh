#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env PHP_VERSION 5.6.20
export_env PHP_CONFIG /usr/local/lib/php.ini
export_env PHP_TIMEZONE Europe/London

## Dependencies
apt_install_permanent libxml2-dev libcurl4-openssl-dev libbz2-dev libjpeg-dev libpng12-dev libmcrypt-dev libssl-dev pkg-config

## PHP
cd /opt
wget http://uk1.php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror -O  php-$PHP_VERSION.tar.gz
tar xzf php-$PHP_VERSION.tar.gz
cd php-$PHP_VERSION
./configure --enable-calendar --enable-bcmath --with-bz2 --enable-ctype --without-gdbm --with-iconv --enable-exif --enable-ftp --with-gettext --enable-mbstring --enable-sockets --with-zlib --enable-soap --enable-zip --with-mhash --with-curl --with-gd --with-mysql --with-jpeg-dir --with-openssl --with-mysqli --with-mcrypt
make $JOBS
make install

## Configuration
cp /opt/php-$PHP_VERSION/php.ini-production $PHP_CONFIG
sed -i "s,^;\(date\.timezone\s*=\s*\)$,\1 $PHP_TIMEZONE," $PHP_CONFIG
ln -s /usr/local/bin/php-cgi /usr/bin/php-cgi

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -r php-$PHP_VERSION
    rm php-$PHP_VERSION.tar.gz
fi