#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env COUCHPOTATO_CONFIG /host/etc/couchpotato/config.ini    
export_env COUCHPOTATO_DATA /host/var/lib/couchpotato

## CouchPotato
cd /opt
git clone https://github.com/RuudBurger/CouchPotatoServer.git