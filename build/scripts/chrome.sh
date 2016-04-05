#!/bin/bash
set -e
source /build/config
set -x

## Chrome dependencies
apt_install_permanent gconf-service libasound2 libatk1.0-0 libcairo2 libcap2 libcups2 libcurl3 libfontconfig1 libgdk-pixbuf2.0-0 libgtk2.0-0 libnspr4 libnss3 libpango1.0-0 librtmp0 libxss1 libxtst6 xdg-utils

## Chrome
mkdir -p /usr/share/icons/hicolor
cd /opt
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
