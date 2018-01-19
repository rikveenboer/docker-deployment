## Create directories and files
mkdir /etc/container_environment
mkdir /opt/init.d
touch /etc/container_environment.sh
touch /etc/container_environment.json
chmod 700 /etc/container_environment
chmod 600 /etc/container_environment.sh /etc/container_environment.json

# Temporarily disable dpkg fsync to make building faster.
echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Prevent initramfs updates from trying to run grub and lilo.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export_env INITRD no

# Enable sources and backports in APT
echo "deb-src http://deb.debian.org/debian/ $DEBIAN main" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ $DEBIAN-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ $DEBIAN-backports main contrib non-free" >> /etc/apt/sources.list

## Fix some issues with APT packages
# See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

# Replace the 'ischroot' tool to make it always return true
# Prevent initscripts updates from breaking /dev/shm
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# https://bugs.launchpad.net/launchpad/+bug/974584
dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

# Fix known issue with user accounts
# https://github.com/docker/docker/issues/6345#issuecomment-49245365
ln -sf /bin/true /usr/bin/chfn

## Install HTTPS support for APT
apt update
apt_install_permanent apt-transport-https

## Upgrade all packages
apt dist-upgrade -y --no-install-recommends

## Set timezone
echo $TIMEZONE > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

## Store debian
export_env DEBIAN $DEBIAN
