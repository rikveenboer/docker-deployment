#!/bin/bash
set -e
source /build/config
set -x

# MiniDLNA dependencies
$minimal_apt_get_install gettext libavutil-dev libavcodec-dev libavformat-dev libjpeg-dev libsqlite3-dev libexif-dev libid3tag0-dev libogg-dev libvorbis-dev libFLAC-dev

export MINIDLNA_VERSION=1.1.1
export MINIDLNA_CONFIG=/host/etc/minidlna.conf
export MINIDLNA_LOG=/host/var/log/minidlna.log
export MINIDLNA_DATA=/host/var/lib/minidlna

# MiniDLNA
cd opt
wget http://downloads.sourceforge.net/project/minidlna/minidlna/$MINIDLNA_VERSION/minidlna-$MINIDLNA_VERSION.tar.gz
tar xzf minidlna-$MINIDLNA_VERSION.tar.gz
cd minidlna-$MINIDLNA_VERSION
./configure
make
make install

## Runit script
mkdir /etc/service/minidlna
mv /build/runit/minidlna /etc/service/minidlna/run

## Environment variables
echo -n $MINIDLNA_VERSION > /etc/container_environment/MINIDLNA_VERSION
echo -n $MINIDLNA_CONFIG > /etc/container_environment/MINIDLNA_CONFIG
echo -n $MINIDLNA_LOG > /etc/container_environment/MINIDLNA_LOG
echo -n $MINIDLNA_DATA > /etc/container_environment/MINIDLNA_DATA