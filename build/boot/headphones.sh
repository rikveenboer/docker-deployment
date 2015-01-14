#!/bin/bash
set -e
mkdir -p `dirname $HEADPHONES_CONFIG`
mkdir -p `dirname $HEADPHONES_DATA`
if [[ ! -e $HEADPHONES_CONFIG ]]; then
    cat << EOF > $HEADPHONES_CONFIG
[General]
cache_dir = /host/var/lib/headphones
music_dir = /host/srv/headphones
destination_dir = /host/srv/headphones
preferred_bitrate = 192
auto_add_artists = 1
correct_metadata = 1
move_files = 1
rename_files = 1
folder_format = $Artist/$Album
file_format = $Artist - $Title
file_underscores = 0
cleanup_files = 1
add_album_art = 1
album_art_format = $Artist - $Album
nzb_downloader = 1
torrent_downloader = 1
download_dir = /host/srv/downloads
autowant_upcoming = 1
torrentblackhole_dir = ""
isohunt = 1
kat = 1
mininova = 1
piratebay = 1
download_torrent_dir = /host/srv/downloads
music_encoder = 1
encoder = ffmpeg
bitrate = 192
samplingfrequency = 44100
[SABnzbd]
sab_host = http://sabnzbd:8080/
[Transmission]
transmission_host = transmission:9091
EOF
fi