#!/bin/bash
set -e
source /build/config
set -x

## UPnP Proxy dependency
apt_install_permanent uuid-dev

## UPnP Proxy
cd opt
git clone git://git.savannah.nongnu.org/upnpproxy.git
cd upnpproxy
autoreconf || automake --add-missing
./configure
make
make install

## Runit script
mkdir /etc/service/upnpproxy
mv /build/runit/upnpproxy /etc/service/upnpproxy/run

## Environment variables
export UPNPPROXY_CONFIG=/host/etc/upnpproxy.conf
echo -n $UPNPPROXY_CONFIG > /etc/container_environment/UPNPPROXY_CONFIG
