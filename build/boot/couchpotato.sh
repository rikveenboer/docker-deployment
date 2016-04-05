#!/bin/bash
set -e
mkdir -p `dirname $COUCHPOTATO_CONFIG`
if [[ ! -e $COUCHPOTATO_CONFIG ]]; then
    cat << EOF > $COUCHPOTATO_CONFIG
[core]
show_wizard = 0

[updater]
enabled = 0

[binsearch]
enabled = 1

[nzbclub]
enabled = 1

[kickasstorrents]
enabled = 1

[thepiratebay]
domain = 
enabled = 1
extra_score = 0
seed_time = 40
seed_ratio = 1

[yify]
enabled = 1

[blackhole]
directory = /host/srv/torrents
manual = 0
enabled = 1
use_for = torrent
create_subdir = 0

[sabnzbd]
category = movies
delete_failed = 1
enabled = 1
manual = 0
host = sabnzbd:8083
remove_complete = 1

[transmission]
username = user
manual = 0
enabled = 1
host = transmission:9091
stalled_as_failed = 1
delete_failed = 1
rpc_url = transmission
delete_files = 1
remove_complete = 1

[manage]
cleanup = 1
enabled = 1
library = /host/srv/movies
startup_scan = 1
library_refresh_interval = 0

[renamer]
from = /host/srv/downloads
to = /host/srv/movies
EOF
fi
