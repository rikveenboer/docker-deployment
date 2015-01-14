#!/bin/bash
set -e
sed -i "s,\(\['host'\]\s*=\s*\).*$,\1'$MYSQL_PORT_3306_TCP_ADDR';," $PMA_CONFIG