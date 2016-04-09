#!/bin/bash
set -e
source /build/config
set -x

## Often used tools
apt_install_permanent wget curl python-pip git gawk zip gperf unzip inetutils-ping inetutils-telnet

## Often used python modules
pip install argparse
