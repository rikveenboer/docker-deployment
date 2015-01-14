#!/bin/bash
set -e
source /build/config
set -x

## Lighthttpd
apt_get_install_permanent  lighttpd

## Environment
export_env LIGHTTPD_CONFIG /etc/lighttpd/lighttpd.conf
export_env LIGHTTPD_DOMAINS /host/etc/lighttpd
export_env LIGHTTPD_LOG /host/var/log/lighttpd/error.log
export_env LIGHTTPD_DATA /host/var/www/global

## Configuration
sed -i "s,^\(server.errorlog\s*=\s*\).*$,\1\"$LIGHTTPD_LOG\"," $LIGHTTPD_CONFIG
sed -i "s,^\(server.document-root\s*=\s*\).*$,\1\"$LIGHTTPD_DATA\"," $LIGHTTPD_CONFIG
echo "include_shell \"cat $LIGHTTPD_DOMAINS/*.conf\"" >> $LIGHTTPD_CONFIG
