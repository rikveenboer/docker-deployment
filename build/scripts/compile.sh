#!/bin/bash
set -e
source /build/config
set -x

## Often used tools
apt_get_install_temporary gcc make automake libtool
