#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env HEADPHONES_CONFIG /host/etc/headphones/config.ini
export_env HEADPHONES_CONFIG_DEFAULT /opt/headphones/config.ini
export_env HEADPHONES_DATA /host/var/lib/headphones

## Headphones
cd /opt
git clone https://github.com/rembo10/headphones.git
