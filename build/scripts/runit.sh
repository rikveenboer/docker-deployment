#!/bin/bash
set -e
source /build/config
set -x

## Install runit
apt_install_permanent runit
