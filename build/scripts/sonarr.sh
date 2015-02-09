#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env SONARR_DATA /host/var/lib/sonarr

## Sonarr
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
echo "deb http://apt.sonarr.tv/ develop main" | tee -a /etc/apt/sources.list
apt-get update
apt_get_install_permanent nzbdrone mediainfo
chmod +x /opt/NzbDrone/NzbDrone.exe