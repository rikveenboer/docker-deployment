#!/bin/bash
set -e
source /build/config
set -x

## Configuration
export_env BTSYNC_CONFIG /host/etc/btsync/btsync.conf
export_env BTSYNC_DATA /host/var/btsync

## BTsync
cd /opt
wget -O btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable
tar xzf btsync.tar.gz btsync

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm btsync.tar.gz
fi