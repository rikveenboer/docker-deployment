#!/bin/bash
set -e
source /build/config
set -x

## Install runit
apt_get_install_permanent runit
