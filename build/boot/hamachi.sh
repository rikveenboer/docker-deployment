#!/bin/bash
set -e
cd /opt
dpkg -i hamachi.deb
kill -9 `pgrep hamachid`