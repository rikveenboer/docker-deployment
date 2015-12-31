#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env FTP_DATA /host/var/lib/ftp

## Pure-FTPd
apt update
apt_install_permanent pure-ftpd
