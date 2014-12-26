#!/bin/bash
set -e
source /build/config
set -x

## Install the SSH server
$minimal_apt_get_install openssh-server
mkdir /var/run/sshd
mkdir -p /etc/service/sshd
cp /build/runit/sshd /etc/service/sshd/run

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
$minimal_apt_get_install xauth

## Setup environment
sed -i "1iexport HOME=/root" /root/.profile
sed -i "1isource /etc/container_environment.sh" /root/.profile
