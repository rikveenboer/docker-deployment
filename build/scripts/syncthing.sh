#!/bin/bash
set -e
source /build/config
set -x

## Configuration
export_env SYNCTHING_CONFIG /host/etc/syncthing
export_env SYNCTHING_VERSION 0.12.20

## Dependencies
apt_install_temporary curl ca-certificates

## Gosu
# gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
# curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)"
# curl -o /usr/local/bin/gosu.asc -L "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc"
# gpg --verify /usr/local/bin/gosu.asc
# rm /usr/local/bin/gosu.asc
# chmod +x /usr/local/bin/gosu

# Syncthing
cd /opt
curl -L -o syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v$SYNCTHING_VERSION.tar.gz
tar -xzvf syncthing.tar.gz
rm -f syncthing.tar.gz
mv syncthing-linux-amd64-v* syncthing
rm -rf syncthing/etc
rm -rf syncthing/*.pdf
mkdir -p $SYNCTHING_CONFIG
mkdir -p $SYNCTHING_DATA