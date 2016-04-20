#!/bin/bash
set -e
source /build/config
set -x

## Chrome dependencies
apt_install_permanent firefox

## Pulseaudio script
echo "PULSE_SERVER=host firefox" > /opt/firefox
chmod +x /opt/firefox
