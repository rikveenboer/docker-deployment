#!/bin/bash
set -e
mkdir -p $TRANSMISSION_CONFIG
if [[ ! -e $TRANSMISSION_CONFIG ]]; then
    cat /etc/transmission-daemon/settings.json | 
        jq ".[\"download-dir\"] = \"$TRANSMISSION_COMPLETE\"" |
        jq ".[\"download-limit\"] = \"$DOCKER_HOME\"" |
        jq ".+ {
            \"rpc-whitelist-enabled\": false, 
            \"watch-dir\": \"$TRANSMISSION_TORRENTS\",
            \"watch-dir-enabled\": true,
            \"incomplete-dir\": \"$TRANSMISSION_DOWNLOAD\",
            \"incomplete-dir-enabled\": true,
            \"port-forwarding-enabled\": true
        }" > $TRANSMISSION_CONFIG/settings.json
fi