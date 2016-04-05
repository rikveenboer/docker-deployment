#!/bin/bash
set -e
source /build/config
set -x

## Often used tools
apt_install_permanent wget curl python-pip git
apt_install_temporary inetutils-ping telnet

## Often used python modules
pip install argparse
