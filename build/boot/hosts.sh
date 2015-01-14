#!/bin/bash
set -e
# echo "127.0.0.1 localhost" >> /tmp/hosts
cp /etc/hosts /tmp
echo "$HOST_ADDR host" >> /tmp/hosts
