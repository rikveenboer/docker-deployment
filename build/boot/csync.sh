#!/bin/bash
set -e
HOST_ETC_CSYNC=/host/etc/csync
if [ ! -e $CSYNC_CONFIG ]; then
    cp /usr/local/etc/csync2* $HOST_ETC_CSYNC/
    csync2 -k $HOST_ETC_CSYNC/csync2.pem
fi
rm -r /usr/local/etc
ln -sf $HOST_ETC_CSYNC/ /usr/local/etc