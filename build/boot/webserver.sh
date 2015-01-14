#!/bin/bash
set -e
mkdir -p $LIGHTTPD_DOMAINS
if [[ ! -e $LIGHTTPD_DOMAINS ]]; then
    touch $LIGHTTPD_DOMAINS/empty.conf
fi