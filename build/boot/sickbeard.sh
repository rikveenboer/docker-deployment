#!/bin/bash
set -e
mkdir -p `dirname $SICKBEARD_CONFIG`
if [[ ! -e $SICKBEARD_CONFIG ]]; then
    cat << EOF > $SICKBEARD_CONFIG
[General]
config_version = 6
log_dir = /host/var/log/sickbeard
use_nzbs = 1
use_torrents = 1
nzb_method = sabnzbd
flatten_folders_default = 1
root_dirs = 0|/host/srv/shows
tv_download_dir = /host/srv/downloads
process_automatically = 1
rename_episodes = 1
extra_scripts = /opt/subtitles
[Blackhole]
nzb_dir = ""
torrent_dir = /host/srv/torrents
[SABnzbd]
sab_username = ""
sab_password = ""
sab_apikey = ""
sab_category = tv
sab_host = http://sabnzbd:8080/
EOF
fi
