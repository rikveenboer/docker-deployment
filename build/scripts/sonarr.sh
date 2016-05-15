## Environment
export_env SONARR_DATA /host/var/lib/sonarr

## Dependency
apt_install_permanent libmono-cil-dev

## Sonarr
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
echo "deb http://apt.sonarr.tv/ develop main" | tee -a /etc/apt/sources.list
apt update
apt_install_permanent nzbdrone mediainfo
chmod +x /opt/NzbDrone/NzbDrone.exe