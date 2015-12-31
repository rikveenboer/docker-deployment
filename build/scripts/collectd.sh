#!/bin/bash
set -e
source /build/config
set -x

## collectd
apt_install_permanent libsensors4 collectd