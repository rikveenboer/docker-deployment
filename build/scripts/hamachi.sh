#!/bin/bash
set -e
source /build/config
set -x

## Hamachi dependency
apt_install_permanent lsb-core net-tools socat strace

## Hamachi
cd /opt
export HAMACHI_DATA=/host/var/lib/logmein-hamachi
export HAMACHI_VERSION=2.1.0.119
wget -O hamachi.deb https://secure.logmein.com/labs/logmein-hamachi_$HAMACHI_VERSION-1_amd64.deb
mkdir -p /etc/service/hamachi
cp /build/runit/hamachi /etc/service/hamachi/run

## Environment variables
echo -n $HAMACHI_DATA > /etc/container_environment/HAMACHI_DATA