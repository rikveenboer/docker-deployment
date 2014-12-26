#!/bin/bash
set -e
source /build/config
set -x

## Install cron daemon
$minimal_apt_get_install cron
mkdir -p /etc/service/cron
mv /build/runit/cron /etc/service/cron/run

## Remove useless cron entries
# Checks for lost+found and scans for mtab
rm -f /etc/cron.daily/standard
