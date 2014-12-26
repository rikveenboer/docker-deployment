#!/bin/bash
set -e
source /build/config
set -x

## Install a syslog daemon
$minimal_apt_get_install syslog-ng-core
mkdir -p /var/lib/syslog-ng
sed -i "s/^\(#SYSLOGNG_OPTS=\).*$/\1\"--no-caps --default-modules=affile,afprog,afsocket,afuser,basicfuncs,csvparser,dbparser,syslogformat\"/" /etc/default/syslog-ng
