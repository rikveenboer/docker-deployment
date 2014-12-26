#!/bin/bash
set -e
source /build/config
set -x

## Install logrotate
$minimal_apt_get_install logrotate