#!/bin/bash
set -e
if [[ ! -e $PHP_CONFIG ]]; then
    cp /usr/local/lib/php.ini $PHP_CONFIG
fi