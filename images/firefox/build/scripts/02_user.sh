#!/bin/bash
set -e
source /build/config
set -x

## User
adduser --disabled-password --gecos "" user
