#!/bin/bash
set -e
source /build/config
set -x

## Often used tools
apt_get_install_temporary curl python-pip git inetutils-ping telnet

## Often used python modules
pip install argparse
