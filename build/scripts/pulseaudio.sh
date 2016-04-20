#!/bin/bash
set -e
source /build/config
set -x

## Pulseaudio
apt_install_permanent pulseaudio

## Setup environment
sed -i "1iexport PULSE_SERVER=host" /root/.profile