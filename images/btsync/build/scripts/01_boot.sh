#!/bin/bash
set -e
source /build/config
set -x

## Boot entries
mkdir /opt/init.d/
mv /build/boot/*.sh /opt/init.d/
