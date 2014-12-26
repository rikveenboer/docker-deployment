#!/bin/bash
set -e
source /build/config
set -x

## Often used tools
$minimal_apt_get_install gcc make automake libtool
