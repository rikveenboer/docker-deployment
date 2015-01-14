#!/bin/bash
set -e
source /build/config
set -x

## Create directories
mkdir /etc/container_environment
mkdir /opt/init.d

## Temporarily disable dpkg fsync to make building faster.
echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export_env INITRD no

## Enable Ubuntu Universe and Multiverse.
sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
apt-get update

## Fix some issues with APT packages
## See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

## Replace the 'ischroot' tool to make it always return true
## Prevent initscripts updates from breaking /dev/shm
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## https://bugs.launchpad.net/launchpad/+bug/974584
dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

## Fix known issue with user accounts
## https://github.com/docker/docker/issues/6345#issuecomment-49245365
ln -sf /bin/true /usr/bin/chfn

## Install HTTPS support for APT
apt_get_install_permanent apt-transport-https

## Upgrade all packages
apt-get dist-upgrade -y --no-install-recommends

## Fix locale
apt_get_install_permanent language-pack-en
locale-gen en_US