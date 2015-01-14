#!/bin/bash
set -e
source /build/config
set -x

## Remove temporary packages for minimal builds
if [ $MODE == "minimal" ]; then
    cat /build/temporary | xargs apt-get -y --purge autoremove
fi

## Clean apt files
apt-get clean
rm -rf /build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
