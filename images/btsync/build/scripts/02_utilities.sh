#!/bin/bash
set -e
source /build/config
set -x

## Often used tools
$minimal_apt_get_install wget curl python-pip inetutils-ping telnet sox

## Often used python modules
pip install argparse
