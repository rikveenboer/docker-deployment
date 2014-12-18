#!/bin/bash
set -e
source /build/config
set -x

## Install init process
mv /build/init /opt/
mkdir -p /etc/container_environment
touch /etc/container_environment.sh
touch /etc/container_environment.json
chmod 700 /etc/container_environment
chmod 600 /etc/container_environment.sh /etc/container_environment.json
