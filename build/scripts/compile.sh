#!/bin/bash
set -e
source /build/config
set -x

## Often used tools
apt_install_temporary build-essential yasm cmake automake autopoint autoconf libtool pkg-config
