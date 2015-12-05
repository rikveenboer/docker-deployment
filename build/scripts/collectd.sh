#!/bin/bash
set -e
source /build/config
set -x

## collectd
apt_get_install_permanent libsensors4 collectd