#!/bin/bash
set -e
if [[ ! -e $BTSYNC_CONFIG ]]; then
    mkdir -p `dirname $BTSYNC_CONFIG`
    /opt/btsync --dump-sample-config > $BTSYNC_CONFIG
    sed -i "s,// \(\"storage_path\"\).*,  \1 : \"$BTSYNC_DATA\"\,," $BTSYNC_CONFIG
fi