## Environment
export_env SABNZBD_CONFIG /host/etc/sabnzbd/sabnzbd.ini
export_env SABNZBD_DATA /host/var/lib/sabnzbd

## SABnzbd
echo 'deb http://ppa.launchpad.net/jcfp/ppa/ubuntu precise main' > /etc/apt/sources.list.d/sabnzbdplus.list
apt-key adv --keyserver hkp://pool.sks-keyservers.net:11371 --recv-keys 0x98703123E0F52B2BE16D586EF13930B14BB9F05F
apt update
apt_install_permanent sabnzbdplus

## Utilities
apt_install_permanent unzip par2 python-openssl python-yenc

## 7zip
apt_install_permanent p7zip-full
