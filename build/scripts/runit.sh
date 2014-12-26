#!/bin/bash
set -e
source /build/config
set -x

## Install runit
$minimal_apt_get_install runit
