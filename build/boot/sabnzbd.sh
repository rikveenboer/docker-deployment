#!/bin/bash
set -e
mkdir -p `dirname $SABNZBD_CONFIG`
if [[ ! -e $SABNZBD_CONFIG ]]; then
    cat << EOF > $SABNZBD_CONFIG
[misc]
log_dir = /host/var/log/sabnzbd
admin_dir = /host/var/lib/sabnzbd/admin
download_dir = /host/tmp/downloads
cache_dir = /host/var/lib/sabnzbd/cache
complete_dir = /host/srv/downloads
auto_browser = 0
[servers]
EOF
fi
