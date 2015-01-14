#!/bin/bash
set -e
source /build/config
set -x

## Hosts file hack
export_env LD_LIBRARY_PATH /root/lib
mkdir -p $LD_LIBRARY_PATH
cp /lib/x86_64-linux-gnu/libnss_files.so.2 $LD_LIBRARY_PATH
sed -i 's,/etc/hosts,/tmp/hosts,' $LD_LIBRARY_PATH/libnss_files.so.2

## Other commands
# ENV LD_LIBRARY_PATH /root/lib
# RUN mkdir $LD_LIBRARY_PATH
# RUN cp /lib/x86_64-linux-gnu/libnss_files.so.2 $LD_LIBRARY_PATH
# RUN perl -pi -e 's:/etc/hosts:/tmp/hosts:g' $LD_LIBRARY_PATH/libnss_files.so.2

## Environment variable
echo -n $LD_LIBRARY_PATH > /etc/container_environment/LD_LIBRARY_PATH