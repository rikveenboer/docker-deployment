#!/bin/bash
set -e
source /build/config
set -x

## Install cron daemon
apt_get_install_permanent cron

## Remove useless cron entries
# Checks for lost+found and scans for mtab
rm -f /etc/cron.daily/standard
