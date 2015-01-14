#!/bin/bash
set -e
source /build/config
set -x

## MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password dummy'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password dummy'
apt_get_install_permanent mysql-server 

## Environment
export_env MYSQL_CONFIG /etc/mysql/my.cnf
export_env MYSQL_LOG /host/var/log/mysql/error.log
export_env MYSQL_DATA /host/var/lib/mysql

## Configuration
sed -i "s,^\(log_error\s*=\s*\).*$,\1$MYSQL_LOG," $MYSQL_CONFIG
sed -i "s,^\(datadir\s*=\s*\).*$,\1$MYSQL_DATA," $MYSQL_CONFIG
sed -i "s,^\(bind-address\s*=\s*\).*$,\10.0.0.0," $MYSQL_CONFIG
