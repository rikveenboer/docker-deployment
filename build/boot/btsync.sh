#!/bin/bash
set -e
if [[ ! -e $BTSYNC_CONFIG ]]; then
    mkdir -p `dirname $BTSYNC_CONFIG`
    /opt/btsync --dump-sample-config > $BTSYNC_CONFIG
    sed -i "s,\(\"listen\"\s*:\).*,\1 \"0.0.0.0:8888\"\,," $BTSYNC_CONFIG
fi