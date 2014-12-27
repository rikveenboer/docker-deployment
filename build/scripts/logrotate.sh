#!/bin/bash
set -e
source /build/config
set -x

## Install logrotate
apt_get_install_permanent logrotate