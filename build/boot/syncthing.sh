#!/bin/bash
set -e
if [ ! -f $SYNCTHING_CONFIG ]; then
  /opt/syncthing/syncthing --generate="$SYNCTHING_CONFIG"
  # don't take the whole volume with the default so that we can add additional folders
  sed -e "s~id=\"default\" path=\"/root/Sync\"~id=\"default\" path=\"$SYNCTHING_DATA/default\"~" -i $SYNCTHING_CONFIG/config.xml
  # ensure we can see the web ui outside of the docker container
	sed -e "s/<address>127.0.0.1:8384/<address>0.0.0.0:8080/" -i $SYNCTHING_CONFIG/config.xml
fi