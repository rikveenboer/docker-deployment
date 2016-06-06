#!/bin/bash
set -e

# Config
HOST_DIR=`dirname $CSYNC_CONFIG`
CONTAINER_DIR=/usr/local/etc
if [ ! -e $HOST_DIR/csync2.pem ]; then
    mkdir -p $HOST_DIR
    csync2 -k $HOST_DIR/csync2.pem
    cp -f $CONTAINER_DIR/csync2* $HOST_DIR/
fi
rm -r $CONTAINER_DIR
ln -sf $HOST_DIR/ $CONTAINER_DIR

# Database
CONTAINER_DIR=/usr/local/var/lib/csync2
rm -r $CONTAINER_DIR
ln -sf $CSYNC_DATABASE/ $CONTAINER_DIR