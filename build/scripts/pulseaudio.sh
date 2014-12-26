#!/bin/bash
set -e
source /build/config
set -x

## Pulseaudio
$minimal_apt_get_install pulseaudio

## Setup environment
sed -i "1iexport PULSE_SERVER=host" /root/.profile