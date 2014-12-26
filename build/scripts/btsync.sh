#!/bin/bash
set -e
source /build/config
set -x

## Redis
cd opt
wget -O btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable
tar xzf btsync.tar.gz
rm btsync.tar.gz

export BTSYNC_CONFIG=/host/etc/btsync.conf
export BTSYNC_DATA=/host/var/btsync

## Runit script
mkdir /etc/service/btsync
mv /build/runit/btsync /etc/service/btsync/run

## Environment variables
echo -n $BTSYNC_CONFIG > /etc/container_environment/BTSYNC_CONFIG
echo -n $BTSYNC_DATA > /etc/container_environment/BTSYNC_DATA
