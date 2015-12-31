#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env SICKBEARD_CONFIG /host/etc/sickbeard/config.ini    
export_env SICKBEARD_DATA /host/var/lib/sickbeard 

## SickBeard
apt_install_permanent python-cheetah
cd /opt
git clone https://github.com/midgetspy/Sick-Beard.git