#!/bin/bash
set -e
HOST_DIR=`dirname $CSYNC_CONFIG`
CONTAINER_DIR=/usr/local/etc
if [ ! -e $HOST_DIR/csync2.pem ]; then
    csync2 -k $HOST_DIR/csync2.pem
    cp -f $CONTAINER_DIR/csync2* $HOST_DIR/
fi
rm -r $CONTAINER_DIR
ln -sf $HOST_DIR/ $CONTAINER_DIR
cp -f $HOST_DIR/csync2_$HOSTNAME.cfg $HOST_DIR/csync2.cfg