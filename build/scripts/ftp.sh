#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env FTP_DATA /host/var/lib/ftp

## Pure-FTPd
apt-get update
apt_get_install_permanent pure-ftpd
