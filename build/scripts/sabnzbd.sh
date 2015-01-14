#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env RAR_VERSION 4.1.1
export_env SABNZBD_CONFIG /host/etc/sabnzbd/sabnzbd.ini
export_env SABNZBD_DATA /host/var/lib/sabnzbd

## SABnzbd
echo "deb http://ppa.launchpad.net/jcfp/ppa/ubuntu $(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:11371 --recv-keys 0x98703123E0F52B2BE16D586EF13930B14BB9F05F
apt-get update
apt_get_install_permanent sabnzbdplus

## Utilities
apt_get_install_permanent unzip par2 python-openssl python-yenc

## Rar
cd /opt
wget http://www.rarlab.com/rar/rarlinux-x64-$RAR_VERSION.tar.gz
tar xzf rarlinux-x64-$RAR_VERSION.tar.gz
ln -s /opt/rar/rar /usr/bin