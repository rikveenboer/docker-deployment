#!/bin/bash
set -e
source /build/config
set -x

## Mpd
$minimal_apt_get_install mpd
mkdir -p /etc/service/mpd
cp /build/runit/mpd /etc/service/mpd/run
