## Environment
export_env SONARR_DATA /host/var/lib/sonarr

## Dependencies
apt_install_permanent libmono-cil-dev sqlite3 mediainfo

## Key
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC

## Sonarr
echo "deb http://apt.sonarr.tv/ develop main" | tee -a /etc/apt/sources.list
apt update
apt_install_permanent nzbdrone
chmod +x /opt/NzbDrone/NzbDrone.exe
