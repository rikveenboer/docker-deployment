#!/bin/bash
set -e
source /build/config
set -x

## Enable configuration PHP in Lighttpd
ln -s /etc/lighttpd/conf-available/10-fastcgi.conf /etc/lighttpd/conf-enabled/10-fastcgi.conf 
ln -s /etc/lighttpd/conf-available/15-fastcgi-php.conf /etc/lighttpd/conf-enabled/15-fastcgi-php.conf
