#!/bin/bash
set -e
source /build/config
set -x

## Transmission
apt_get_install_permanent transmission-daemon jq

## Environment
export_env TRANSMISSION_CONFIG /host/etc/transmission
export_env TRANSMISSION_TORRENTS /host/srv/torrents
export_env TRANSMISSION_DOWNLOAD /host/tmp/downloads
export_env TRANSMISSION_COMPLETE /host/srv/downloads
export_env TRANSMISSION_LOG /host/var/log/transmission/error.log