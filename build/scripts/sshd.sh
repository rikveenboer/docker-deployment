#!/bin/bash
set -e
source /build/config
set -x

## Install the SSH server
apt_get_install_permanent openssh-server
mkdir /var/run/sshd

## Install root key
cd /opt
AUTHORIZED_KEYS=/root/.ssh/authorized_keys
DIR=`dirname "$AUTHORIZED_KEYS"`
mkdir -p "$DIR"
chmod 700 "$DIR"
chown root:root "$DIR"
pwd
ssh-keygen -t rsa -N "" -f id_rsa
cat /opt/id_rsa.pub >> "$AUTHORIZED_KEYS"

## X11 forwarding
apt_get_install_permanent xauth

## Setup environment
sed -i "1iexport HOME=/root" /root/.profile
sed -i "1isource /etc/container_environment.sh" /root/.profile
