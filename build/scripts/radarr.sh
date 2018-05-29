## Environment
export_env RADARR_DATA /host/var/lib/radarr

## Dependencies
apt_install_permanent libmono-cil-dev mediainfo

## Radarr
RADARR_TAG=$(curl -sX GET "https://api.github.com/repos/Radarr/Radarr/releases" | awk '/tag_name/{print $4;exit}' FS='[""]')
mkdir -p /opt/radarr
wget -O /tmp/radar.tar.gz \
    "https://github.com/Radarr/Radarr/releases/download/${RADARR_TAG}/Radarr.develop.${RADARR_TAG#v}.linux.tar.gz"
tar ixzf /tmp/radar.tar.gz -C /opt/radarr --strip-components=1
