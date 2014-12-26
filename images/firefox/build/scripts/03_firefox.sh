#!/bin/bash
set -e
source /build/config
set -x

## Firefox
$minimal_apt_get_install firefox

## Pulseaudio script
echo "PULSE_SERVER=host firefox" > /opt/firefox
chmod +x /opt/firefox
